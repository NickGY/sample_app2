module SessionsHelper
	 # Осуществляет вход данного пользователя.
  def log_in(user)
    session[:user_id] = user.id
  end
  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end
   # Возвращает true, если пользователь вошел, иначе false.
  def logged_in?
    !current_user.nil?
  end
  # Forgets a persistent session.
def forget(user)
user.forget
cookies.delete(:user_id)
cookies.delete(:remember_token)
end
  def log_out
    forget(current_user)
    session.delete(:user_id)
    @current_user = nil
  end
  # Возвращает true, если заданный пользователь является текущим.
  def current_user?(user)
    user == current_user
  end
  # Перенаправляет к сохраненному расположению (или по умолчанию).
  def redirect_back_or(default)
    redirect_to(session[:forwarding_url] || default)
    session.delete(:forwarding_url)
  end

  # Сохраняет запрошенный URL.
  def store_location
    session[:forwarding_url] = request.url if request.get?
  end
end
