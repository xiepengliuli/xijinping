package cn.com.infcn.model.tmodel;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;

import javax.persistence.FetchType;

import javax.persistence.Table;
import java.util.Date;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import javax.persistence.OneToMany;
import java.util.HashSet;
import java.util.Set;


/**
 * 文章表
 * Tessay generated by 项目开发部
 */
@Entity
@Table(name = "eg_essay")
public class Tessay implements java.io.Serializable {

  private static final long serialVersionUID = 1L;

  /***/
  private String id;
  /**标题*/
  private String title;
  /**作者*/
  private String author;
  /**关键字*/
  private String keyWord;
  /**发布日期*/
  private Date publishtime;
  /**年*/
  private Integer year;
  /**全文*/
  private String fullText;
  /**文章链接*/
  private String titleLink;
  /**地点*/
  private String addr;
  /**资源类型*/
  private String resourceCategory;
  /**资源分类*/
  private String resourceType;
  /**主题分类一级*/
  private String titleTypeFirst;
  /**主题分类二级*/
  private String titleTypeSecond;
  /**岗位*/
  private String position;
  /**事件*/
  private String event;
  /**陪同人*/
  private String interviewer;
  /**参与人*/
  private String related;
  /**场景*/
  private String scene;
  /***/
  private Set<TessayParagraph> tessayParagraphs =new HashSet<TessayParagraph>(0);

  public Tessay() {
  }

  public Tessay(String id) {
    this.id = id;
  }

  public Tessay(String id, String title, String author, String keyWord, Date publishtime, Integer year, String fullText, String titleLink, String addr, String resourceCategory, String resourceType, String titleTypeFirst, String titleTypeSecond, String position, String event, String interviewer, String related, String scene, Set<TessayParagraph> tessayParagraphs) {
    super();
    this.id = id;
    this.title = title;
    this.author = author;
    this.keyWord = keyWord;
    this.publishtime = publishtime;
    this.year = year;
    this.fullText = fullText;
    this.titleLink = titleLink;
    this.addr = addr;
    this.resourceCategory = resourceCategory;
    this.resourceType = resourceType;
    this.titleTypeFirst = titleTypeFirst;
    this.titleTypeSecond = titleTypeSecond;
    this.position = position;
    this.event = event;
    this.interviewer = interviewer;
    this.related = related;
    this.scene = scene;
    this.tessayParagraphs = tessayParagraphs;
  }

  @Id
  @Column(name = "ID", unique = true, nullable = false, length = 32)
  public String getId() {
    return this.id;
  }

  public void setId(String id) {
    this.id = id;
  }

  @Column(name = "TITLE", nullable = true)
  public String getTitle() {
    return this.title;
  }

  public void setTitle(String title) {
    this.title = title;
  }

  @Column(name = "AUTHOR", nullable = true)
  public String getAuthor() {
    return this.author;
  }

  public void setAuthor(String author) {
    this.author = author;
  }

  @Column(name = "KEY_WORD", nullable = true)
  public String getKeyWord() {
    return this.keyWord;
  }

  public void setKeyWord(String keyWord) {
    this.keyWord = keyWord;
  }

  @Temporal(TemporalType.TIMESTAMP)
  @Column(name = "PUBLISHTIME", nullable = true)
  public Date getPublishtime() {
    return this.publishtime;
  }

  public void setPublishtime(Date publishtime) {
    this.publishtime = publishtime;
  }

  @Column(name = "YEAR", nullable = true, length = 11)
  public Integer getYear() {
    return this.year;
  }

  public void setYear(Integer year) {
    this.year = year;
  }

  @Column(name = "FULL_TEXT", nullable = true)
  public String getFullText() {
    return this.fullText;
  }

  public void setFullText(String fullText) {
    this.fullText = fullText;
  }

  @Column(name = "TITLE_LINK", nullable = true)
  public String getTitleLink() {
    return this.titleLink;
  }

  public void setTitleLink(String titleLink) {
    this.titleLink = titleLink;
  }

  @Column(name = "ADDR", nullable = true)
  public String getAddr() {
    return this.addr;
  }

  public void setAddr(String addr) {
    this.addr = addr;
  }

  @Column(name = "RESOURCE_CATEGORY", nullable = true)
  public String getResourceCategory() {
    return this.resourceCategory;
  }

  public void setResourceCategory(String resourceCategory) {
    this.resourceCategory = resourceCategory;
  }

  @Column(name = "RESOURCE_TYPE", nullable = true)
  public String getResourceType() {
    return this.resourceType;
  }

  public void setResourceType(String resourceType) {
    this.resourceType = resourceType;
  }

  @Column(name = "TITLE_TYPE_FIRST", nullable = true)
  public String getTitleTypeFirst() {
    return this.titleTypeFirst;
  }

  public void setTitleTypeFirst(String titleTypeFirst) {
    this.titleTypeFirst = titleTypeFirst;
  }

  @Column(name = "TITLE_TYPE_SECOND", nullable = true)
  public String getTitleTypeSecond() {
    return this.titleTypeSecond;
  }

  public void setTitleTypeSecond(String titleTypeSecond) {
    this.titleTypeSecond = titleTypeSecond;
  }

  @Column(name = "POSITION", nullable = true)
  public String getPosition() {
    return this.position;
  }

  public void setPosition(String position) {
    this.position = position;
  }

  @Column(name = "EVENT", nullable = true, length = 100)
  public String getEvent() {
    return this.event;
  }

  public void setEvent(String event) {
    this.event = event;
  }

  @Column(name = "INTERVIEWER", nullable = true, length = 100)
  public String getInterviewer() {
    return this.interviewer;
  }

  public void setInterviewer(String interviewer) {
    this.interviewer = interviewer;
  }

  @Column(name = "RELATED", nullable = true, length = 100)
  public String getRelated() {
    return this.related;
  }

  public void setRelated(String related) {
    this.related = related;
  }

  @Column(name = "SCENE", nullable = true, length = 200)
  public String getScene() {
    return this.scene;
  }

  public void setScene(String scene) {
    this.scene = scene;
  }

  @OneToMany(fetch = FetchType.LAZY, mappedBy = "tessay")
  public  Set<TessayParagraph> getTessayParagraphs() {
    return this.tessayParagraphs;
  }

  public void setTessayParagraphs(Set<TessayParagraph> tessayParagraphs) { 
    this.tessayParagraphs = tessayParagraphs; 
  }
}
