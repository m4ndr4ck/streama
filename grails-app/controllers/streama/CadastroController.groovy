package streama


import grails.rest.*
import grails.converters.*
import grails.transaction.Transactional
import org.springframework.security.access.annotation.Secured

import static org.springframework.http.HttpStatus.CREATED
import static org.springframework.http.HttpStatus.NOT_ACCEPTABLE
import static org.springframework.http.HttpStatus.NOT_FOUND

@Secured('permitAll')
@Transactional
class CadastroController {
	static responseFormats = ['json', 'xml']
  static allowedMethods = [save: "POST", delete: "DELETE"]

    @Transactional
    def createUser() {

      def data = request.JSON

      User userInstance = data.id ? User.get(data.id) : new User()

      if (userInstance == null) {
        render status: NOT_FOUND
        return
      }

      userInstance.properties = data

      userInstance.validate()
      if (userInstance.hasErrors()) {
        render status: NOT_ACCEPTABLE
        return
      }

      userInstance.save flush: true

      UserRole.removeAll(userInstance)
      data.authorities?.each { roleJson ->
        Role role = Role.get(roleJson.id)
        UserRole.create(userInstance, role)
      }

      respond userInstance, [status: CREATED]
    }
}
