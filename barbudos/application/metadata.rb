name    "barbudos_application"
version "0.0.1"

%w{ application_nodejs nginx mongodb }.each do |cb|
  depends cb
end
