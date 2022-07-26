VideoCodingModuleImpl 持有一个receiver 一个sender。也就是vcm

VideoSender  VideoReceiver 各持有一个VCMCodecDataBase _codecDataBase;



EncoderWrapper::Create 会创建两个sw encoder。两个hardware encoder。然后用一个encode wrapper包裹。

将EncoderWrapper 传给VCMGenericEncoder 做参数生成一个通用encoder。

外部使用通用encoder



VCMCodecDataBase::SetSendCodec 创建 VCMGenericEncoder。





updateCodec -》_setCodec(type)

setCodec( int index, unsigned short width, unsigned short height ) 调用RegisterSendCodec 失败返回-1 

init || setCodec( int index, unsigned short width, unsigned short height )  ->

RegisterSendCodec ( fail create will return VCM_NOT_IMPLEMENTED)  -> SetSendCodec && reset_required=true  ->CreateEncoder  


因为硬件不支持，但是config有没有来。此时去创建265。 但是失败了。但是没有回退到264. 此时会有错误。

   VCMGenericEncoder 创建失败了。





Super Resoultion

超分

https://confluence.agoralab.co/pages/viewpage.action?pageId=624770608

https://confluence.agoralab.co/pages/viewpage.action?pageId=660701563 



有的，功能部分的话，可以把jira/MS-10773和3.0.0比对一下，另外机型适配部分是在DeviceProfile里设置的，这部分可以看 jira/MS-11701

