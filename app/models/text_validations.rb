module TextValidations

	def self.included(receiver)
		receiver.validates :body, :exclusion => { :in => 'kitten' }		
	end
	
end