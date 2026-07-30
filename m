Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10B2C411A07;
	Thu, 30 Jul 2026 12:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785415487; cv=none; b=KbSkhObgvqD/9H6ogEF0VhSQA14Aeno0UfNdxNE9pRzM+09Nn0nmgJywvHhCYt1eysjXfyIKnLdiqaBA7RZnTtkZGPjhoQCwxCyBDyK8pWLl2F/Doma/G0Am8+EXQaDpi2JtfzdqfPRuBION/7N80SVL1MncJfTeUxzSs+52OSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785415487; c=relaxed/simple;
	bh=mgWHyBoqbc80sdo8aPInLqhg4O66058+ZT20KG6janE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HXAWfBkw27An4eEXf/RSLvo7lsIYYtw/ih0UXr/62xz8QQa6qT48NsarCicJ/7hEb4pRih69nYJWDpvAb3ILD54v9bzSacmN3SCV+owOX6f9ltvcNY4+L73jx0xkOVxcYoHQqhX5yp0Ex7S9OT9Yo5XsLwUnH5r+4beFh2JqBBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wqIlZ6xO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wqIlZ6xO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D0F11F000E9;
	Thu, 30 Jul 2026 12:44:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785415485;
	bh=ZhmV2pyVil3Q/CQlbRgMq1T9zbsxcrxe1CVCqSsxz2s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=wqIlZ6xOs5gyJ3kllIfRiW7HL7Dob27ZCBCXXzJYDJfyfvYxAWoAwW1o7MA8BuuM9
	 oomZNTf3eXwg3tWxauA7dGwedc94klhOz5QSW9XUfUQaXINXbhoeJvIjAzMnVyLFFS
	 yL4AwgORTtcq/bHm/ONy/iPb7hXz5QuTUyW3pSiA=
Date: Thu, 30 Jul 2026 14:44:31 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Jeffin Philip <jeffinphilip14@gmail.com>
Cc: Frank.Li@nxp.com, kees@kernel.org, linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org, panjunzhong@linux.spacemit.com,
	xu.yang_2@nxp.com,
	syzbot+8dcac923582c28505fd7@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: Re: [PATCH v5] usb: gadget: uvc: Fix Null Pointer Dereference in
 uvcg_video_init()
Message-ID: <2026073005-shadiness-untracked-9efc@gregkh>
References: <20260730123941.8180-1-jeffinphilip14@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260730123941.8180-1-jeffinphilip14@gmail.com>

On Thu, Jul 30, 2026 at 06:09:41PM +0530, Jeffin Philip wrote:
> In uvcg_video_init(), if kthread_run_worker() fails,
> the error logged uses uvcg_err(), however, the pointer it uses:
> video->uvc is not assigned at this point, triggering a null
> pointer dereference. Fix this by directly using uvc->func which
> is assigned already.
> 
> Reported-by: syzbot+8dcac923582c28505fd7@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=8dcac923582c28505fd7
> Fixes: 7ea95b110811 ("usb: gadget: uvc: rename functions to avoid conflicts with host uvc")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jeffin Philip <jeffinphilip14@gmail.com>
> ---
> Changelog:
>  -Small fixes addressed in v4 discussion
>   https://lore.kernel.org/all/20260730093948.7800-1-jeffinphilip14@gmail.com/T/#u
> 
>  drivers/usb/gadget/function/uvc_video.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/gadget/function/uvc_video.c b/drivers/usb/gadget/function/uvc_video.c
> index 2f9700b3f1b6..9ba09118bb74 100644
> --- a/drivers/usb/gadget/function/uvc_video.c
> +++ b/drivers/usb/gadget/function/uvc_video.c
> @@ -821,7 +821,7 @@ int uvcg_video_init(struct uvc_video *video, struct uvc_device *uvc)
>  	/* Allocate a kthread for asynchronous hw submit handler. */
>  	video->kworker = kthread_run_worker(0, "UVCG");
>  	if (IS_ERR(video->kworker)) {
> -		uvcg_err(&video->uvc->func, "failed to create UVCG kworker\n");
> +		uvcg_err(&uvc->func, "failed to create UVCG kworker\n");
>  		return PTR_ERR(video->kworker);
>  	}
> 
> --
> 2.55.0
> 

Dropped due to lack of following directions...
