package cn.com.infcn.model.tmodel;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;

import javax.persistence.FetchType;

import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;



/**
 * 段落表（从文章表中提取）
 * TessayParagraph generated by 项目开发部
 */
@Entity
@Table(name = "eg_essay_paragraph")
public class TessayParagraph implements java.io.Serializable {

  private static final long serialVersionUID = 1L;

  /***/
  private String id;
  /**段落内容*/
  private String paragraphContent;
  /**段落标记*/
  private Integer paragraphFlag;
  /**对应文章id*/
  private Tessay tessay;

  public TessayParagraph() {
  }

  public TessayParagraph(String id) {
    this.id = id;
  }

  public TessayParagraph(String id, String paragraphContent, Integer paragraphFlag, Tessay tessay) {
    super();
    this.id = id;
    this.paragraphContent = paragraphContent;
    this.paragraphFlag = paragraphFlag;
    this.tessay = tessay;
  }

  @Id
  @Column(name = "ID", unique = true, nullable = false, length = 32)
  public String getId() {
    return this.id;
  }

  public void setId(String id) {
    this.id = id;
  }

  @Column(name = "PARAGRAPH_CONTENT", nullable = true)
  public String getParagraphContent() {
    return this.paragraphContent;
  }

  public void setParagraphContent(String paragraphContent) {
    this.paragraphContent = paragraphContent;
  }

  @Column(name = "PARAGRAPH_FLAG", nullable = true, length = 11)
  public Integer getParagraphFlag() {
    return this.paragraphFlag;
  }

  public void setParagraphFlag(Integer paragraphFlag) {
    this.paragraphFlag = paragraphFlag;
  }

  @ManyToOne(fetch = FetchType.LAZY)
  @JoinColumn(name = "TITLE_ID")
  public Tessay getTessay() {
    return this.tessay;
  }

  public void setTessay(Tessay tessay) {
    this.tessay = tessay;
  }
}