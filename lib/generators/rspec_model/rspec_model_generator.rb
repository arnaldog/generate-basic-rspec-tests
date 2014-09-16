class RspecModelGenerator < Rails::Generators::Base
	source_root File.expand_path('../templates', __FILE__)
	argument :model_name, :type => :string

	def generate_rspec_model
		
	end
end
