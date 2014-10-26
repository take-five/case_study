authorization do
  # Anonymous users privileges
  role :guest do
    has_permission_on :users,
                      :collections,
                      :monuments,
                      :pictures,
                      :to => :read

    has_permission_on :categories, :to => :manage
  end

  # Authenticated users privileges
  role :user do
    includes :guest

    has_permission_on :users do
      to :manage
      # user refers to current_user
      if_attribute :id => is { user.id }
    end

    has_permission_on :collections do
      to :manage
      if_attribute :user_id => is { user.id }
      # Instead of
      # if_permitted_to :manage, :user
      # to avoid redundant SQL query
    end

    has_permission_on :monuments do
      to :manage
      if_permitted_to :manage, :collection
    end

    has_permission_on :picture do
      to :manage
      if_permitted_to :manage, :monument
    end
  end
end

privileges do
  # default privilege hierarchies to facilitate RESTful Rails apps
  privilege :manage, :includes => [:create, :read, :update, :delete]
  privilege :read, :includes => [:index, :show]
  privilege :create, :includes => :new
  privilege :update, :includes => :edit
  privilege :delete, :includes => :destroy
end
