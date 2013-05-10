unless defined?(Motion::Project::Config)
  raise "This file must be required within a RubyMotion project Rakefile."
end

unless File.exist? '/Applications/Spark Inspector.app'
	raise "Please install SparkInspector (http://www.sparkinspector.com"
end

Motion::Project::App.setup do |app|
	app.development do
  	app.vendor_project('/Applications/Spark Inspector.app/Contents/Resources/Frameworks/SparkInspector.framework', :static, :products => ['SparkInspector'], :force_load => true, :headers_dir => 'Headers')
		app.libs += ['/usr/lib/libz.dylib']
		app.frameworks += ['QuartzCore']
	end
end