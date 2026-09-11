Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 524F5377545;
	Fri, 11 Sep 2026 01:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789090869; cv=none; b=RFUAQ8PnBGg94gBklJ8i/FVBwkjs6/ojnM7kOrgYOJcfRIwg1DtxQjM+C/d9zJxPXgkV1034S5qEPJQ7yGxx5t/ri8N0XV9UyQssBm+yc8pzchn5R2oC/zFFnizjShQqVeGNZ2sxFEZkMHloIpe2bxC7Df20NkI/n/mxzEU0k3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789090869; c=relaxed/simple;
	bh=9eeSa7wy/fFrLjtPFF9CWGC+26JZptOZSSCeH+aVUCU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Di4cY+tHnsPhgUGXWlCrm7FqlIH0TfZP2xoPxf+uSzaea8LLX3AGDKvrtt0EADQ/uHMvaMD6xcpEHM68zY+1uM6DNEMEaTUZmzTDbPIfH1hi5/j1gfyGhUSZ/HIfVra/e0XjP0gS5zLxEdMF1TTYdab1l4Ab9jnPk31N1TFk7Kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: d8e8cae2ad8111f19a56ed5b684f684d-20260911
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:ea22bced-16c7-4e13-86e0-dc58687ac881,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:7db8b62,CLOUDID:ca077e12bcc8d860d6ef4ff0d3b1b1ce,BulkI
	D:nil,BulkQuantity:0,SF:80|81|82|83|102|865|898,TC:nil,Content:0|15|50|99,
	EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OS
	A:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: d8e8cae2ad8111f19a56ed5b684f684d-20260911
Received: from [10.42.17.251] [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <oushixiong@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_128_GCM_SHA256 128/128)
	with ESMTP id 1239253127; Fri, 11 Sep 2026 09:41:02 +0800
Message-ID: <4a527e66-8aa9-4422-a3b5-7ac1d9919220@kylinos.cn>
Date: Fri, 11 Sep 2026 09:41:01 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fbdev: sh_mobile_lcdcfb: Restore the per-overlay sysfs
 attributes
To: Helge Deller <deller@gmx.de>, Karl Mehltretter <kmehltretter@gmail.com>
Cc: Chintan Patel <chintanlike@gmail.com>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, linux-fbdev@vger.kernel.org,
 dri-devel@lists.freedesktop.org, stable@vger.kernel.org,
 Arnd Bergmann <arnd@arndb.de>
References: <20260907021844.25497-1-kmehltretter@gmail.com>
 <72351d8f-289e-44d1-b241-e68d7d23145a@gmx.de>
Content-Language: en-US
From: Shixiong Ou <oushixiong@kylinos.cn>
In-Reply-To: <72351d8f-289e-44d1-b241-e68d7d23145a@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 2026/9/11 05:15, Helge Deller wrote:
> On 9/7/26 04:18, Karl Mehltretter wrote:
>> The ovl_* files documented in
>> Documentation/ABI/testing/sysfs-devices-platform-sh_mobile_lcdc_fb no
>> longer exist.
>>
>> Commit a979182a2453 ("fbdev: lcdcfb: Register sysfs groups through 
>> driver
>> core") moved the attributes from each overlay's framebuffer device to
>> the platform driver's dev_groups and renamed them overlay_*. There is
>> now only one set of attributes for the whole LCDC. The callbacks still
>> expect dev_get_drvdata() to return a struct fb_info, but the platform
>> device holds struct sh_mobile_lcdc_priv, so they access the wrong
>> structure.
>>
>> Restore the documented names and register the group on each overlay's
>> framebuffer device with device_add_groups(). Remove it with
>> device_remove_groups() before unregistering the framebuffer. Skip
>> creation when info->dev is NULL, as the old device_create_file() 
>> calls did.
>>
>> Drop the CONFIG_FB_DEVICE guard, since the driver already depends on it.
>>
>> Fixes: a979182a2453 ("fbdev: lcdcfb: Register sysfs groups through 
>> driver core")
>> Cc: stable@vger.kernel.org
>> Assisted-by: LLM
>> Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
>> ---
>> Found while reviewing the sysfs ABI documentation.
>>
>> Compile-tested only (allmodconfig, W=1), I have no SH-Mobile hardware.
>
>
> This all seems correct, but since it reverts a few of the last patches
> I'd prefer that some other person could also review it....
>
Looks good to me, and I agree .dev_groups is wrong here.

Shixiong.

>
>>   drivers/video/fbdev/sh_mobile_lcdcfb.c | 37 +++++++++++++++++---------
>>   1 file changed, 24 insertions(+), 13 deletions(-)
>>
>> diff --git a/drivers/video/fbdev/sh_mobile_lcdcfb.c 
>> b/drivers/video/fbdev/sh_mobile_lcdcfb.c
>> index e8324b01700f..18fc4e465283 100644
>> --- a/drivers/video/fbdev/sh_mobile_lcdcfb.c
>> +++ b/drivers/video/fbdev/sh_mobile_lcdcfb.c
>> @@ -1337,22 +1337,24 @@ overlay_rop3_store(struct device *dev, struct 
>> device_attribute *attr,
>>       return count;
>>   }
>>   -static DEVICE_ATTR_RW(overlay_alpha);
>> -static DEVICE_ATTR_RW(overlay_mode);
>> -static DEVICE_ATTR_RW(overlay_position);
>> -static DEVICE_ATTR_RW(overlay_rop3);
>> -
>> -static struct attribute *overlay_sysfs_attrs[] __maybe_unused = {
>> -    &dev_attr_overlay_alpha.attr,
>> -    &dev_attr_overlay_mode.attr,
>> -    &dev_attr_overlay_position.attr,
>> -    &dev_attr_overlay_rop3.attr,
>> +static struct device_attribute dev_attr_ovl_alpha =
>> +    __ATTR(ovl_alpha, 0644, overlay_alpha_show, overlay_alpha_store);
>> +static struct device_attribute dev_attr_ovl_mode =
>> +    __ATTR(ovl_mode, 0644, overlay_mode_show, overlay_mode_store);
>> +static struct device_attribute dev_attr_ovl_position =
>> +    __ATTR(ovl_position, 0644, overlay_position_show, 
>> overlay_position_store);
>> +static struct device_attribute dev_attr_ovl_rop3 =
>> +    __ATTR(ovl_rop3, 0644, overlay_rop3_show, overlay_rop3_store);
>> +
>> +static struct attribute *overlay_sysfs_attrs[] = {
>> +    &dev_attr_ovl_alpha.attr,
>> +    &dev_attr_ovl_mode.attr,
>> +    &dev_attr_ovl_position.attr,
>> +    &dev_attr_ovl_rop3.attr,
>>       NULL,
>>   };
>>   -#ifdef CONFIG_FB_DEVICE
>>   ATTRIBUTE_GROUPS(overlay_sysfs);
>> -#endif
>>     static const struct fb_fix_screeninfo sh_mobile_lcdc_overlay_fix  
>> = {
>>       .id =        "SH Mobile LCDC",
>> @@ -1513,6 +1515,7 @@ sh_mobile_lcdc_overlay_fb_unregister(struct 
>> sh_mobile_lcdc_overlay *ovl)
>>       if (info == NULL || info->dev == NULL)
>>           return;
>>   +    device_remove_groups(info->dev, overlay_sysfs_groups);
>>       unregister_framebuffer(ovl->info);
>>   }
>>   @@ -1530,6 +1533,15 @@ sh_mobile_lcdc_overlay_fb_register(struct 
>> sh_mobile_lcdc_overlay *ovl)
>>       if (ret < 0)
>>           return ret;
>>   +    /* The framebuffer device is optional, see fb_device_create(). */
>> +    if (info->dev) {
>
> I think this needs to be:
>     if (dev_of_fbinfo(info)) {
> to avoid compile error when CONFIG_FB_DEVICE=n.
>
>
>> +        ret = device_add_groups(info->dev, overlay_sysfs_groups);
>
> same here. dev_of_fbinfo(info).
>
>> +        if (ret < 0) {
>> +            unregister_framebuffer(info);
>> +            return ret;
>> +        }
>> +    }
>> +
>>       dev_info(lcdc->dev, "registered %s/overlay %u as %dx%d %dbpp.\n",
>>            dev_name(lcdc->dev), ovl->index, info->var.xres,
>>            info->var.yres, info->var.bits_per_pixel);
>> @@ -2637,7 +2649,6 @@ static int sh_mobile_lcdc_probe(struct 
>> platform_device *pdev)
>>   static struct platform_driver sh_mobile_lcdc_driver = {
>>       .driver        = {
>>           .name        = "sh_mobile_lcdc_fb",
>> -        .dev_groups    = overlay_sysfs_groups,
>>           .pm        = &sh_mobile_lcdc_dev_pm_ops,
>>       },
>>       .probe        = sh_mobile_lcdc_probe,
>>
>> base-commit: 986c24e0fe44f844b44d365b71ce831947f50298
