/**
 * blogPost
 *
 * @author Amit Pandey
 * @date 5/22/17
 **/
component  persistent="true" table="blogPost" {

property name="id" column="blogPostId" fieldtype="id" generator="increment";
property name="title" column="title" ormtype="text";
property name="summary" column="summary" ormtype="text";
property name="body" ormtype="text";
property name="dateposted" ormtype="timestamp";
property name="createdDateTime" ormtype="timestamp";
property name="modifiedDateTime" ormtype="timestamp";
property name="deleted" ormtype="boolean";
property name="comments" singularname="comment" fieldtype="one-to-many" cfc="blogComment" fkcolumn="blogPostId" cascade="all";
}