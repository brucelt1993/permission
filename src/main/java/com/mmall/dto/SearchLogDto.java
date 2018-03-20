package com.mmall.dto;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

import java.util.Date;
@Getter
@Setter
@ToString
public class SearchLogDto {
    private Integer type;//LogType
    private String beforeSeq;
    private String afterSeq;
    private String operator;
    private Date fromTime;
    private Date toTime;
}
