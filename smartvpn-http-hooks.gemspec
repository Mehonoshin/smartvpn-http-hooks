Gem::Specification.new do |s|
  s.name        = 'smartvpn-http-hooks'
  s.version     = '1.0.7'
  s.date        = '2019-01-08'
  s.summary     = "HTTP hooks for OpenVPN server"
  s.description = "Trigger on openvpn events and notify HTTP API"
  s.authors     = ["Stanislav Mekhonoshin"]
  s.email       = 'ejabberd@gmail.com'
  s.files       = `git ls-files`.split($/)
  s.homepage    = 'https://github.com/Mehonoshin/smartvpn-http-hooks'
  s.executables = ['smartvpn-activate', 'smartvpn-authenticate', 'smartvpn-connect', 'smartvpn-disconnect']
  s.license       = 'MIT'
  s.require_path = 'lib'
  s.add_development_dependency 'rspec', ['>= 0']
  s.add_development_dependency 'mocha'
  s.add_development_dependency 'webmock'
end
