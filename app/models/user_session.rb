class UserSession < Authlogic::Session::Base
self.single_access_allowed_request_types = :all 




end