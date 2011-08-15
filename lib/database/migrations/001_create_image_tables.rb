# UP => sequel -E -M 1 -m lib/database/migrations jdbc:postgresql://localhost/images_development?user=default
# DOWN => sequel -E -M 0 -m lib/database/migrations jdbc:postgresql://localhost/images_development?user=default

Sequel.migration do
  
  up do
    create_table(:image_binaries) do
      primary_key :id
      File :file, :null => false
      Time :created_at, :null => false
      Time :updated_at, :null => false
      String :mime_type, :null => false, :size => 255
      Bignum :file_size, :null => false  
    end
    
    create_table(:image_attributes) do
      primary_key :id
      String :caption, :size => 255
      String :description, :size => 1000
      foreign_key :image_binary_id, :image_binaries, :null => false
      unique :image_binary_id
    end
    
    create_table(:image_croppings) do
      primary_key :id
      Float :x_coordinate, :null => false
      Float :y_coordinate, :null => false
      String :aspect_ratio, :null => false, :size => 5
      foreign_key :image_binary_id, :image_binaries, :null => false
      unique [:image_binary_id, :aspect_ratio]
    end
  end
  
  down do
    drop_table(:image_croppings)
    drop_table(:image_attributes)
    drop_table(:image_binaries)
  end
  
end

