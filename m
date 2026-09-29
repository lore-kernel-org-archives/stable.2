Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C1173BC68E;
	Tue, 29 Sep 2026 15:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790694815; cv=none; b=kwke0WaUqt3pGhHdWqvjzxcMehhTwkk6g4DX5uuTqB43W+FvLNIVLQGLPdnn63Fm4G3AbUfMwBLySBPU2zsS5n1Nl984+DNAJO1zCdgL0lxPBoFoitk3Tr6ympi15QwFERw5OaxmCAwPzHyQX0X/IHFvHDSLKTXLNkr0TItClSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790694815; c=relaxed/simple;
	bh=WTVdWqAWN6jaCu3/M0m4sLjNLMvpGfXrLMrB8aZs+No=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JwOuOqAsIPMIctN515aKTet6lXOyYOLZtVmdKlioN00Cvhhffvz+s4pDDs8JQOGHK7tUCRZMHwic0vYBtxpHmZkddDTTmNNrKIlyxwvqA0Kj+zcdA6fPIN+7Ryfcs4Iwds6ov39AwcUr7/IRYKR7XYfDwtLGahsHom8hhRurX9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UrUTZ3IR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UrUTZ3IR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F1BD1F000FF;
	Tue, 29 Sep 2026 15:13:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790694800;
	bh=j71LnEqVH+pnurWlxEZb2howKkEzojL7sj8VLJRzEKw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=UrUTZ3IRCYQpCUfW4VYJgYculZvSJWbANrAo+hb3x+LMZz6lI+8tbIGsI/kCGhOJK
	 wlU1UZom27rpnZQFzUlzxSqPo+AwnzLOA50BOK8nNyF9vE/XZnuXfT+OWc8aY0jWcn
	 pY7bzqREPKujWRSIEuYgwBQE7mf9PI5Rn0RSzJMZqCFHqZmixbsmHSh/haw6POfDRU
	 BSzD0YPZM1DFTLzazepzlm4pSLZbpS8dx+HuGiwGCfxoihDrUY9Q3DjqfcyIIv4VNs
	 KPLKrLIXqI2XhM9JOhGpk9eSM3cEOt5u+wA5fCk1DBaz/QND2LTl4BvUNtf10h10+E
	 QRYlSSUVPJO9A==
Message-ID: <6534f8fc-6222-4524-881b-d0be69d461ce@kernel.org>
Date: Tue, 29 Sep 2026 17:13:17 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] media: uvcvideo: Fix NULL deref on events for
 uninitialized controls
To: Wei Jie LAW <98lawweijie@gmail.com>, laurent.pinchart@ideasonboard.com,
 mchehab@kernel.org
Cc: guennadi.liakhovetski@linux.intel.com, linux-media@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, ribalda@chromium.org
References: <20260907121844.2592492-1-98lawweijie@gmail.com>
From: Hans de Goede <hansg@kernel.org>
Content-Language: en-US, nl
In-Reply-To: <20260907121844.2592492-1-98lawweijie@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 7-Sep-26 14:18, Wei Jie LAW wrote:
> From: Wei Jie Law <98lawweijie@gmail.com>
> 
> A null-ptr-deref exists in v6.12.105 and upstream. KASAN crash log:
> 
>   KASAN: null-ptr-deref in range [0x0000000000000080-0x0000000000000087]
>   Workqueue: events uvc_ctrl_status_event_work
>   RIP: 0010:uvc_ctrl_status_event+0x105/0x280
>    uvc_ctrl_status_event_work+0x82/0x240
>    process_one_work+0x66f/0x10b0
> 
> XU controls are initialized lazily, on the first UVCIOC_CTRL_MAP or
> UVCIOC_CTRL_QUERY.  Until then ctrl->info is all zeroes, so
> info.mappings is not a valid list head, list_empty() returns false, and
> uvc_ctrl_status_event() walks it from a NULL next pointer.
> 
> Fixes: e5225c820c05 ("media: uvcvideo: Send a control event when a Control Change interrupt arrives")
> Cc: stable@vger.kernel.org
> Signed-off-by: Wei Jie Law <98lawweijie@gmail.com>
> Assisted-by: Claude:claude-opus-5
> Reviewed-by: Ricardo Ribalda <ribalda@chromium.org>

Thank you for your patch.

I have merged this into:

https://gitlab.freedesktop.org/linux-media/users/uvc/-/commits/for-next/

Regards,

Hans



> 
> ---
> Changes in v2:
> - dropped comments in code based on review received
> - add Reviewed-by from Ricardo Ribalda
> - drop the former [2/2] patch as it is a duplicate (out-of-bounds read in
>   uvc_ctrl_status_event()): already handled by
>   https://lore.kernel.org/linux-media/20260813-uvc-status-11-v1-1-2cf43e9590b0@chromium.org/
> 
> v1: https://lore.kernel.org/all/20260907062819.2519878-2-98lawweijie@gmail.com/
> ---
>  drivers/media/usb/uvc/uvc_ctrl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
> index 3ca108b83f1d..ea28c4e819bd 100644
> --- a/drivers/media/usb/uvc/uvc_ctrl.c
> +++ b/drivers/media/usb/uvc/uvc_ctrl.c
> @@ -2209,7 +2209,7 @@ bool uvc_ctrl_status_event_async(struct urb *urb, struct uvc_video_chain *chain,
>  	struct uvc_device *dev = chain->dev;
>  	struct uvc_ctrl_work *w = &dev->async_ctrl;
>  
> -	if (list_empty(&ctrl->info.mappings))
> +	if (!ctrl->initialized || list_empty(&ctrl->info.mappings))
>  		return false;
>  
>  	w->data = data;

