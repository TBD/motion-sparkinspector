module Motion ; module Project
	class App
		class << self
			attr_accessor :sparkinspector_path

			def sparkinspector_path
				@sparkinspector_path ||= '/Applications'
			end
		end
	end

	class Config
		attr_accessor :sparkinspector_path

		def sparkinspector_path
			@sparkinspector_path ||= Motion::Project::App.sparkinspector_path
		end
	end
end ; end
