unless defined?(Motion::Project::Config)
	raise "This file must be required within a RubyMotion project Rakefile."
end

def create_launcher(files)
	# --- based on motion-testflight
	launcher_code = <<EOF
# created by motion-sparkinspector
	if Object.const_defined?('SparkInspector')
		SparkInspector.enableObservation
	end
EOF

	launcher_file = './app/sparkinspector_launcher.rb'
	if !File.exist?(launcher_file) or File.read(launcher_file) != launcher_code
		File.open(launcher_file, 'w') { |io| io.write(launcher_code) }
	end
	files = files.flatten
	files << launcher_file unless files.find { |x| File.expand_path(x) == File.expand_path(launcher_file) }

end

Motion::Project::App.setup do |app|
	app.development do
		if File.exist? '/Applications/Spark Inspector.appx'
			app.vendor_project('/Applications/Spark Inspector.app/Contents/Resources/Frameworks/SparkInspector.framework', :static, :products => ['SparkInspector'], :force_load => true, :headers_dir => 'Headers')
			app.libs += ['/usr/lib/libz.dylib']
			app.frameworks += ['QuartzCore']

			create_launcher(app.files)
		else
			puts "[warning] missing SparkInspector (http://www.sparkinspector.com)"
		end
	end
end