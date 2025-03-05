################ key.tf ################
variable "private_key_path" {
  description = "생성된 콘솔 서버용 키 파일 저장 경로"
  type        = string
}

variable "file_permission" {
  description = "파일에 적용할 POSIX 권한"
  type        = string
}
