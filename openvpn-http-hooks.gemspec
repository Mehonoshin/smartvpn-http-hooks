Gem::Specification.new do |s|
  s.name        = 'openvpn-http-hooks'
  s.version     = '1.0.6'
  s.date        = '2014-04-27'
  s.summary     = "HTTP hooks for OpenVPN server"
  s.description = "Trigger on openvpn events and notify HTTP API"
  s.authors     = ["Victor Ivanov"]
  s.email       = 'admin@smartvpn.biz'
  s.files       = `git ls-files`.split($/)
  s.homepage    = 'https://smartvpn.biz'
  s.executables = ['openvpn-activate', 'openvpn-authenticate', 'openvpn-connect', 'openvpn-disconnect']
  s.license       = 'MIT'
  s.require_path = 'lib'
  s.add_development_dependency 'rspec', ['>= 0']
  s.add_development_dependency 'mocha'
  s.add_development_dependency 'webmock'

end
