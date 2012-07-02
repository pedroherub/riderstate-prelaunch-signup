class RegistrationsController < Devise::RegistrationsController

  # ovverride #create to respond to AJAX with a partial
  def create
    build_resource
    @users = User.find(:all, :include => :roles)  
    #debugger
    if resource.save
      if resource.active_for_authentication?
        sign_in(resource_name, resource)
        (render(:partial => 'newuser', :locals => {:user => resource.id}, :layout => false) && return)  if request.xhr?
        respond_with resource, :location => after_sign_up_path_for(resource)
      else
        expire_session_data_after_sign_in!
        (render(:partial => 'newuser', :locals => {:user => resource.id}, :layout => false) && return)  if request.xhr?
        respond_with resource, :location => after_inactive_sign_up_path_for(resource)
      end
    else
      clean_up_passwords resource
      render :action => :new, :layout => !request.xhr?
    end
  end

  def update
    @users = User.find
  end

  def register
    build_resource

    if resource.save
      if resource.active_for_authentication?
        set_flash_message :notice, :signed_up if is_navigational_format?
        sign_in(resource_name, resource)
        respond_with resource, :location => after_sign_up_path_for(resource)
      else
        set_flash_message :notice, :"signed_up_but_#{resource.inactive_message}" if is_navigational_format?
        expire_session_data_after_sign_in!
        respond_with resource, :location => after_inactive_sign_up_path_for(resource)
      end
    else
      clean_up_passwords resource
      respond_with resource
    end
  end

  protected

  def after_inactive_sign_up_path_for(resource)
    '/thankyou.html'
  end
  
  def after_sign_up_path_for(resource)
    '/thankyou.html'
  end
  
end
