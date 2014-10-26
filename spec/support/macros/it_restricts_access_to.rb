module Support
  module Macros
    # Checks whether resource is accessible only by certain user
    #
    # Usage:
    #   RSpec.describe PostsController do
    #     before { @user = create :user }
    #
    #     it_restricts_access_to 'create post' do
    #       post :create, :user_id => @user, :post => {...}
    #     end
    #   end
    def it_restricts_access_to(action_name, &block)
      it "restricts access to #{action_name} if user is not logged in" do
        bypass_rescue
        expect { instance_eval(&block) }.to raise_error ApplicationController::PermissionDenied
      end

      it "restricts access to #{action_name} if other user is logged in" do
        other_user = create :user
        sign_in other_user

        bypass_rescue
        expect { instance_eval(&block) }.to raise_error ApplicationController::PermissionDenied
      end
    end
  end
end