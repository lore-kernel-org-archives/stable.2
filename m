Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41FD238DC51;
	Thu, 30 Jul 2026 10:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785405611; cv=none; b=Gu+g1VAbRS1DDXpeooZxIrVkD0K5S32lSMkT5lFzX+wg1njd3IUf9VwF1I0CmU5Pe0k9sz1sjIUXxKGwnVumhOmyFJevd8PNLvKqXIbCc1SjnPu39UWERTlueioCuw/6+RdlQgsty9enjh/ZYfzAiEgEFueWDG3VkO/Wv+qXa1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785405611; c=relaxed/simple;
	bh=YAK4FBEjUwihRwITFMn8VwvrjUGpkYRacJbhN6DWGUE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mUZnVW374EtKOHWCMgACVXUOlDz2IAIpliWOI1saEMeS+mZGGMSyXTSwiFzlIb51oSyVd8o/FcdZzm4YANTVbOKJL0qHJkL/2YAb8rAzx7pSNuEbvSFuJE8vgg0MkfGIJRJynhHec544BV35j2e5qTIcJoOVXplLT6QwZW/kli0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yH1Ykp9+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yH1Ykp9+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CB2D1F000E9;
	Thu, 30 Jul 2026 10:00:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785405609;
	bh=l/xo6Y9k3LaBxxdPOqqjWN0IjEhjhqW7CVXzXDrrmHk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=yH1Ykp9+b0iNiu3RY+mDjyWgom9yfalc8QCeWrtPVdmUuXkv5SF6BSnlKSZwoaHKT
	 i6F4SkonwVH3A4ucn3i/aaVUHkaFivIaFe3bJYYYBcZA5G96Q9sQlh48lBF3Jv1Xsd
	 QyVeLMcJRomJgSJjgtk61GHNzoIy9CMVRvDukMtQ=
Date: Thu, 30 Jul 2026 11:59:55 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Jeffin Philip <jeffinphilip14@gmail.com>
Cc: xu.yang_2@nxp.com, Frank.Li@nxp.com, panjunzhong@linux.spacemit.com,
	kees@kernel.org, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+8dcac923582c28505fd7@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: Re: [PATCH v4] usb: gadget: uvc: Fix Null Pointer Dereference in
Message-ID: <2026073025-gigantic-defuse-84d7@gregkh>
References: <20260730093948.7800-1-jeffinphilip14@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260730093948.7800-1-jeffinphilip14@gmail.com>

On Thu, Jul 30, 2026 at 03:09:48PM +0530, Jeffin Philip wrote:
> In uvcg_video_init(), if kthread_run_worker() fails,
> the error logged uses uvcg_err(), however, the pointer it uses:
> video->uvc is not assigned at this point, triggering a null
> pointer dereference. Fix this by directly using uvc->func which
> is assigned already.
> 
> Reported-by: syzbot+8dcac923582c28505fd7@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=8dcac923582c28505fd7
> Fixes: 7ea95b110811 (usb: gadget: uvc: rename functions to avoid conflicts with host uvc)
> Cc: stable@vger.kernel.org
> Signed-off-by: Jeffin Philip <jeffinphilip14@gmail.com>
> ---
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

Please slow down. Only do 1 patch per day, at the most.

This one is still wrong (hint, no changelog of what changed between
versions.)

There is no rush here, relax :)

thanks,

greg k-h
