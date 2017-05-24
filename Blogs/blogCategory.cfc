/**
 * blogCategory
 *
 * @author Amit Pandey
 * @date 5/22/17
 **/
component persistent="true" {

  property name="id" fieldtype="id" generator="increment" ;
  property name="name" ormtype="text";
  property name="posts" fieldtype="one-to-many" cfc="blogPostCategory" fkcolumn="blogCategoryid";
}