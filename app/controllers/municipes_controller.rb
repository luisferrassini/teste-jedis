class MunicipesController < ApplicationController
  before_action :set_municipe, only: %i[show edit update]

  # GET /municipes or /municipes.json
  def index
    @municipes = if params[:status].present?
                   Municipe.all
                 else
                   Municipe.where(status: true)
                 end
    if params[:search].present?
      @municipes = @municipes.where('LOWER(nome_completo) LIKE ?',
                                    "%#{I18n.transliterate(params[:search].downcase)}%")
    end
    if params[:cidade].present?
      @municipes = @municipes.joins(:endereco).where('LOWER(enderecos.cidade) LIKE ?',
                                                     "%#{I18n.transliterate(params[:cidade].downcase)}%")
    end
    if params[:uf].present?
      @municipes = @municipes.joins(:endereco).where('LOWER(enderecos.uf) LIKE ?',
                                                     "%#{I18n.transliterate(params[:uf].downcase)}%")
    end
    @credential_warnings = []
    return unless ENV['RAILS_ENV'] != 'production'

    if ENV['SENDPULSE_API_USER'] == 'username' && ENV['SENDPULSE_API_KEY'] == 'password'
      @credential_warnings << 'Sendpulse credentials not set'
    end
    if ENV['SMTP_ADDRESS'] == 'smtp.example.com' && ENV['SMTP_PORT'] == '587' && ENV['SMTP_HOST'] == 'example.com' && ENV['SMTP_USERNAME'] == 'username' && ENV['SMTP_PASSWORD'] == 'password'
      @credential_warnings << 'Mailtrap credentials not set'
    end
  end

  # GET /municipes/1 or /municipes/1.json
  def show; end

  # GET /municipes/new
  def new
    @municipe = Municipe.new
    @municipe.build_endereco
  end

  # GET /municipes/1/edit
  def edit; end

  # POST /municipes or /municipes.json
  def create
    @municipe = Municipe.new(municipe_params)
    respond_to do |format|
      if @municipe.save
        @municipe.enviar_email_e_sms_cadastro
        format.html { redirect_to municipe_url(@municipe), notice: 'Municipe was successfully created.' }
        format.json { render :show, status: :created, location: @municipe }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @municipe.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /municipes/1 or /municipes/1.json
  def update
    respond_to do |format|
      if @municipe.update(municipe_params)
        @municipe.enviar_email_e_sms_atualizacao_status
        format.html { redirect_to municipe_url(@municipe), notice: 'Municipe was successfully updated.' }
        format.json { render :show, status: :ok, location: @municipe }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @municipe.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /municipes/1 or /municipes/1.json
  # def destroy
  #   @municipe.destroy!

  #   respond_to do |format|
  #     format.html { redirect_to municipes_url, notice: 'Municipe was successfully destroyed.' }
  #     format.json { head :no_content }
  #   end
  # end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_municipe
    @municipe = Municipe.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def municipe_params
    params.require(:municipe).permit(:nome_completo, :cpf, :cns, :email, :data_nascimento, :telefone, :foto, :status, :endereco,
                                     endereco_attributes: %i[id cep logradouro complemento bairro cidade uf codigo_ibge])
  end
end
