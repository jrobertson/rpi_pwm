Gem::Specification.new do |s|
  s.name = 'rpi_pwm'
  s.version = '0.3.2'
  s.summary = 'A wrapper of the rpi_gpio gem with similar function to the rpi gem, but features PWM.'
  s.authors = ['James Robertson']
  s.files = Dir['lib/rpi_pwm.rb']
  s.add_runtime_dependency('pinx', '~> 0.1', '>=0.1.3') 
  s.add_runtime_dependency('rpi_gpio', '~> 0.3', '>=0.3.3') 
  s.signing_key = '../privatekeys/rpi_pwm.pem'
  s.cert_chain  = ['gem-public_cert.pem']
  s.license = 'MIT'
  s.email = 'james@jamesrobertson.eu'
  s.homepage = 'https://github.com/jrobertson/rpi_pwm'
end
