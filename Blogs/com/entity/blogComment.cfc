/**
 * blogComment
 *
 * @author Amit Pandey
 * @date 5/22/17
 **/
component persistent="true" {

   property name="id" column="blogCommentid" fieldtype="id" generator="increment";
   property name="author" ormtype="string";
   property name="comment" ormtype="text";
   property name="createdDateTime" ormtype="timestamp";
   property name="deleted" ormtype="boolean";

   property name="blog"  fieldType="many-to-one" cfc="blogPost";

}