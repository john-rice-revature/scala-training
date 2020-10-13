package csvreadwrite
import org.bson.types.ObjectId

case class Contact(_id: ObjectId, name: String, phone: Int, group: String){}

object Contact {
    def apply(name: String, phone: Int, group: String) : Contact = Contact(new ObjectId(), name, phone, group)
}
