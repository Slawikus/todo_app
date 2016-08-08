class TaskSerializer < ActiveModel::Serializer

  belongs_to :user

  attributes :id, :title, :done

end
