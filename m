Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D3EA4071E3
	for <stable@vger.kernel.org>; Mon,  7 Sep 2026 06:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788763922; cv=none; b=F0/f5VL3AWFccnngTS3qGkGRmpBE6Tp2h/axBLUfAq+Zh+HeYWzP5xiSdXShjrbn1pi8yxRgAovvUX3cUGJwrbXxShoINpCgb3+xTbVnHZQ4t03oK/jc3LSTMRhuKsd6OdJAc20PUS7W9rxWHB+W3Ku/IhKWTd69fZgxlJfhqXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788763922; c=relaxed/simple;
	bh=zPTLqj7M2sowhCEMCOIjV4OUVmZP7xmVC8flf/vDf/A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e/FCMw7cnZ8WVSzHbVtSvG0Zn1MQfMvNNyhNiYCAZeh1JxXz9jjcuFlUTtdM6QJ4FGFnSzgl4XYDy6cW4BpKR4xsbwfYKShftiPe23eEcyi1Gj7O/tZS62FK1xEsiswJfUiCOoRMgHJcRYmh16pan8ngl/W4u6L873KfEPUcTSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=T5tkGDT7; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="T5tkGDT7"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-3964dfb5b9aso4038794a91.1
        for <stable@vger.kernel.org>; Sun, 06 Sep 2026 23:52:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1788763920; x=1789368720; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=X0VAf/+VGb/j1E+84EtyzEfQ6Scvu4LmVjCogzBoYhM=;
        b=T5tkGDT7xKH6mN4QmlxpP0Al+y/5IQ8/AISgL5xWuTSGID9YF51xjKT7Eux/BdGJ3d
         oaYljYzi6YsOwNbL/oaKu4Sal6mVJXOmikLERIvJdb4jNjkHdYCh5TC010YrJ3erL1N9
         5u+xxE0rPNB3D8Q6VX+WgTG3KpYCOWHxq5V+Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788763920; x=1789368720;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=X0VAf/+VGb/j1E+84EtyzEfQ6Scvu4LmVjCogzBoYhM=;
        b=JhTm7tjCMZ/ir7sjnkPSln28QCSYyOlWnX4Oj8Cqa9Kk5tJGA7YGHX23clB6WCMZFZ
         V2Iz5yg57abgjx7H1qt5DboTPjWz3pkDRs6dJ1wbgJ97adutRAiQZMqMJEeJtTOVfyz2
         Q2bfANrhp38RA96GUzNQU/1aPBsZfHtBl4g+HY4WDDN/1LTT1a42EjsDtsffbJpTZ1uI
         5BRbOEAYhV+5gHUIey0uik4iLSkofS6X/88srbMySBoeLfyGIeI0ceFo18c9wm3lAoBU
         ntvyelHqZlib+M6Kktd+HtVQsxjg+0b+NHect9XtYSI3uNJJ7ICije4bz+udt6alwMXs
         xkhg==
X-Forwarded-Encrypted: i=1; AKwUvBzhPKg1LF09JfN+SuK+5e+fFvYNmdCxScmnBQRk45DxRRpT/QfFmeSyQTOGd26zjhmTOvi7Vw8=@vger.kernel.org
X-Gm-Message-State: AFuF++mS5WB5bffcagO92EMhM4zDTzzTNtTjUYhYdbhQjmBhIXsxzXH6
	Y6MwKgiQdTvu/Q/2K9h5Ha0kX+TmzpLboflImP+9dPWJcj6tIUrmBEKyPWs4Y4HymPc2TbqfY/9
	cdRm01g==
X-Gm-Gg: AYBFou00k9SI8HdCsCef4WHi+2wAOO1MXdvlSa/0ckCTPu2e6v6iWnKOxJVBCVXkZZH
	wN0YA3FJVIRO2ygK7yJkL3UgrddZoZJAXe3Fpwa0vqyneXKUquxire06dY4W4b+76wy5ABKyhgl
	5Co5dk4EtpP1os3uYnMfsSjVDx+hzZMcHOTXi4rMWMHsMZqtFeCD0FxBzdiznxUQ1CW87COPQs4
	WIIE3oeQ54VQZwdcNMErIB6HspEhbCLHRyBDnJx8REkg/3tzSHV+ulMN2FbxPJUU7XbApXRwAv6
	dsK5rZ+kgpoBlmUdKfMxHqJS/HLzVO3wwQImcADHyZ1Y1/6kHnZYe9JVjeWBOovhhlfNO7/6RCs
	7TtwzeOSxhddVVwfpljECBYbSFOID4GHpKQ0M+nMteqo3b65uixKNOV3Z9fsyBtG5nD3prPx+K1
	/adI8qWQwua22/WHMJK1QKqrJ+Iz8xBUuhQXaW0KcOHPRQz6P3/ZdHTb9E1lu4xjiF+EXXox986
	GrbhgFrGokno144zEKhuO7ovfHKbA==
X-Received: by 2002:a17:90a:1c81:b0:39b:2c00:c3f5 with SMTP id 98e67ed59e1d1-39b2c00ed40mr19434369a91.18.1788763919709;
        Sun, 06 Sep 2026 23:51:59 -0700 (PDT)
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com. [209.85.215.179])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39b08bcc081sm25005786a91.6.2026.09.06.23.51.59
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Sep 2026 23:51:59 -0700 (PDT)
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-ca7c1176317so2615019a12.1
        for <stable@vger.kernel.org>; Sun, 06 Sep 2026 23:51:59 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBzyvo1WR4JS8rFDtAVUvQ3ySoOp3V3zoHFEnnDxiI0d5u78cbyzwMJ8JRDMMh4v1ioP3QwNTy4=@vger.kernel.org
X-Received: by 2002:a05:6a21:3417:b0:3bf:7081:9356 with SMTP id
 adf61e73a8af0-3da3a08ecdbmr34321628637.17.1788763918085; Sun, 06 Sep 2026
 23:51:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260907062819.2519878-1-98lawweijie@gmail.com> <20260907062819.2519878-3-98lawweijie@gmail.com>
In-Reply-To: <20260907062819.2519878-3-98lawweijie@gmail.com>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 7 Sep 2026 08:51:45 +0200
X-Gmail-Original-Message-ID: <CANiDSCvMZzb3ObT3401_iYeE3g+n6kYxTpZVJoDrx4N2_=jrHg@mail.gmail.com>
X-Gm-Features: AcwNN1UsSDcKPkMILOpVw0AYVR4mteKdpMFX9Kcq10_nDYUkxjE4yE_OMWZcYCI
Message-ID: <CANiDSCvMZzb3ObT3401_iYeE3g+n6kYxTpZVJoDrx4N2_=jrHg@mail.gmail.com>
Subject: Re: [PATCH 2/2] media: uvcvideo: Fix out-of-bounds read in uvc_ctrl_status_event()
To: Wei Jie Law <98lawweijie@gmail.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Hans de Goede <hansg@kernel.org>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>, linux-media@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Wei


I belive this is already handled here:

https://lore.kernel.org/linux-media/20260813-uvc-status-11-v1-1-2cf43e9590b0@chromium.org/

On Mon, 7 Sept 2026 at 08:34, Wei Jie Law <98lawweijie@gmail.com> wrote:
>
> An out-of-bounds read exists in v6.12.105 and upstream. KASAN crash log:
>
>   BUG: KASAN: slab-use-after-free in uvc_get_le_value+0x314/0x350
>   Read of size 1 at addr ffff88802df955e4 by task kworker/0:2/128
>   Workqueue: events uvc_ctrl_status_event_work
>    uvc_ctrl_status_event+0x128/0x280
>    uvc_ctrl_status_event_work+0x82/0x240
>   The buggy address belongs to the object at ffff88802df955e0
>    which belongs to the cache kmalloc-16 of size 16
>
> uvc_ctrl_add_mapping() validates mapping->offset against the control
> data buffer, sized from the device's GET_LEN answer.
> uvc_ctrl_status_event() applies the same offset to the 11 byte bValue
> field of a control change event, so uvc_get_le_value() reads past the
> 16 byte struct uvc_status and the value is reported to userspace as a
> V4L2_EVENT_CTRL change.  offset is a u8 bit offset, so the read reaches
> 24 bytes into the neighbouring objects; KASAN calls it a use-after-free
> because the neighbour it read had just been freed.
>
> Fixes: e5225c820c05 ("media: uvcvideo: Send a control event when a Control Change interrupt arrives")
> Cc: stable@vger.kernel.org
> Signed-off-by: Wei Jie Law <98lawweijie@gmail.com>
> Assisted-by: Claude:claude-opus-5
> ---
>  drivers/media/usb/uvc/uvc_ctrl.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
> index 21802f9b1b61..d082bcb8d98d 100644
> --- a/drivers/media/usb/uvc/uvc_ctrl.c
> +++ b/drivers/media/usb/uvc/uvc_ctrl.c
> @@ -2156,11 +2156,16 @@ void uvc_ctrl_status_event(struct uvc_video_chain *chain,
>                 uvc_ctrl_clear_handle(ctrl);
>
>         list_for_each_entry(mapping, &ctrl->info.mappings, list) {
> -               s32 value;
> +               s32 value = 0;
>
> -               if (uvc_ctrl_mapping_is_compound(mapping))
> -                       value = 0;
> -               else
> +               /*
> +                * The offset is validated against the control size, not
> +                * against the event payload, so a mapping can reach past
> +                * bValue[].
> +                */
> +               if (!uvc_ctrl_mapping_is_compound(mapping) &&
> +                   mapping->offset + mapping->size <=
> +                       8 * sizeof_field(struct uvc_status_control, bValue))
>                         value = uvc_mapping_get_s32(mapping, UVC_GET_CUR, data);
>
>                 /*
> --
> 2.43.0
>
>


-- 
Ricardo Ribalda
