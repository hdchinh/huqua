Gem::Specification.new do |s|
  s.name        = 'huqua'
  s.version     = '2.0.1'
  s.date        = '2019-08-31'
  s.summary     = "A simple tool for checking postgresql database in development without access to rails console"
  s.description = "A simple tool for checking postgresql database in development without access to rails console"
  s.authors     = ["Duy Chinh"]
  s.email       = 'hduychinh@gmail.com'
  s.files       = [
    "lib/huqua.rb",
    "lib/string.rb",
    "lib/read_schema.rb",
    "lib/display_overview.rb",
    "lib/display_structure.rb",
    "lib/display_detail.rb"
  ]
  s.executables << 'huqua'
  s.homepage    =
    'https://github.com/hdchinh/huqua'
  s.license       = 'MIT'
end
