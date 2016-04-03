Gem::Specification.new do |s|
  s.name = 'rpi_pwm'
  s.version = '0.2.0'
  s.summary = 'A wrapper of the rpi_gpio gem with similar function to the rpi gem, but features PWM.'
  s.authors = ['James Robertson']
  s.files = Dir['lib/rpi_pwm.rb']
  s.add_runtime_dependency('rpi_gpio', '~> 0.2', '>=0.2.0') 
  s.signing_key = '../privatekeys/rpi_pwm.pem'
  s.cert_chain  = ['gem-public_cert.pem']
  s.license = 'MIT'
  s.email = 'james@r0bertson.co.uk'
  s.homepage = 'https://github.com/jrobertson/rpi_pwm'
end
