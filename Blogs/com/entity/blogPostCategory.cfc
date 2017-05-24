/**
 * blogPostCategory
 *
 * @author Amit Pandey
 * @date 5/23/17
 **/
component persistent="true" {
	property name="blogPost" fieldtype="id,many-to-one" cfc="com/entity/blogPost" column="blogPostid" ;
	property name="blogCategory" fieldtype="id,many-to-one" cfc="com/entity/blogCategory" column="blogCategoryid" ;
}