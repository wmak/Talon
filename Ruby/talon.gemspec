Gem::Specification.new do |s|
  s.name         = 'talon'
  s.version      = '0.0.1'
  s.date         = '2014-09-24'
  s.licenses     = ['MIT']

  s.summary      = 'Concisely store latitude and longitude'
  s.description  = 'Talon encodes long co-ordinate pairs into a small UTF-8 ' \
                   'string.'

  s.authors      = ['Prajjwal Bhandari']
  s.email        = 'talon@pbhandari.ca'
  s.homepage     = 'http://wmak.io/talon'

  s.add_development_dependency 'rspec', '~> 0'

  s.files        = ['lib/talon.rb']
  s.require_path = 'lib'
end
