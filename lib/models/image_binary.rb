class ImageBinary < Sequel::Model
  one_to_one :image_attribute
  one_to_many :image_croppings
  
  def before_create
    self.created_at ||= Time.now
    self.updated_at = Time.now
    super
  end
  
  def before_save
    self.updated_at = Time.now
    super
  end
  
  def before_destroy
    ImageCropping[self.image_croppings_dataset.collect(&:id)].destroy if self.image_croppings.size > 0
    ImageAttribute[self.image_attribute.id].destroy unless self.image_attribute.nil?
    super
  end
end