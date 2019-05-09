package streama

import grails.plugin.springsecurity.SpringSecurityUtils
import grails.rest.*
import grails.converters.*
import grails.transaction.Transactional
import org.springframework.security.access.annotation.Secured

import static org.springframework.http.HttpStatus.CREATED
import static org.springframework.http.HttpStatus.NOT_ACCEPTABLE
import static org.springframework.http.HttpStatus.NOT_FOUND
import static org.springframework.http.HttpStatus.UNAUTHORIZED
import org.apache.commons.validator.EmailValidator

@Secured('permitAll')
@Transactional
class CadastroController {
	static responseFormats = ['json', 'xml']
  static allowedMethods = [save: "POST"]
  /** Dependency injection for the springSecurityService. */
  def springSecurityService
    @Transactional
    def createUser() {
      if (request.method == 'GET') {
        response.sendError(405)
        return
      }
      def data = request.JSON

      User userInstance = data.id ? User.get(data.id) : new User()

      if (userInstance == null) {
        render status: NOT_FOUND
        return
      }
      EmailValidator emailValidator = EmailValidator.getInstance()
      String email = data.getAt("username")
      if (!emailValidator.isValid(email)) {
        response.sendError(406)
        return
      }

      if(!data.getAt("password").equals(data.getAt("password_confirm"))){
        response.sendError(407)
        return
      }

      userInstance.username = email
      userInstance.password = data.getAt("password")
      //userInstance.properties = data
      userInstance.enabled = true

      userInstance.validate()
      if (userInstance.hasErrors()) {
        render status: NOT_ACCEPTABLE
        return
      }

      //userInstance.save flush: true

      data.favoriteGenres?.collect{
        Genre.findOrCreateByApiId(it.apiId)
      }

      bindData(userInstance, data, [exclude: ['username', 'password', 'lastUpdated', 'dateCreated']])

      userInstance.save failOnError: true, flush: true
      List<String> test = new ArrayList<>()
      test.add("Ok")
      //respond test, [status: CREATED]
      springSecurityService.reauthenticate(userInstance.username,userInstance.password)
      def conf = getConf()
      render view: '/login/auth', model: [postUrl: "/z#!/dash",
                                   rememberMeParameter: conf.rememberMe.parameter,
                                   usernameParameter: userInstance.username,
                                   passwordParameter: userInstance.password,
                                   gspLayout: conf.gsp.layoutAuth]


    }

  protected ConfigObject getConf() {
    SpringSecurityUtils.securityConfig
  }
}
