Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CDBD332EA0
	for <stable@vger.kernel.org>; Tue, 14 Jul 2026 21:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784063627; cv=none; b=DJueUg6gkTLYpAbhn7/6O15yqPZvDR184Sr+qWSEHwnoQyVUHTJ/Y/RxCeSvKrRpbxQSNuzL01svKFH5+/zKe0uXzBoq5uHqG+DRbchP7pBhzoMoweDyVC9vY5b6GTX4PqVeDW5EHv2XHv/Qtn2xMZY5643uO0ZwmtGhlEWZZBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784063627; c=relaxed/simple;
	bh=hOnGvAZYq4m8S8T4INlhjWRF8/URmX7flajKWcliev0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mssx88DUbgEfP0NXZE/1VTD6LZdE6Zcc69A7uarBUG55dReHBt5OuOLO/Vhyi6iDJNZJEfPT7dByqzElvqA1XOMoE5oKLWBGRe0YBqDWDPFdMC/dLtkU0dF5q2w/LNHhGCH5N5V70Zu8HlRXYuvOYprB8LlYs0jVLjcKtsL4s3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=LQn9CvyL; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="LQn9CvyL"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-92e50979c71so463907485a.3
        for <stable@vger.kernel.org>; Tue, 14 Jul 2026 14:13:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1784063624; x=1784668424; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=be1RLwiNhcmJdomm6jkaCt0/KvcyWRVekWgUTPQeycU=;
        b=LQn9CvyLE+az5tTdelnpXxe9qleLtzR3SBh3CEpFDKbUVVWP6fIQUaTHbPlgUcmi4A
         Gpr7qrBmErWpUVhqTY+wlC3FpRE3aa1pKPZbdhHlZTY2Q0GChuf3KiKslMH9OCiVXGZK
         3iPdExizt3CmU4LvgfHP3HER+Uw0FMyuCDtyQNdWzd7TzbqvEYRdUgabh/ww97kNIoRD
         l/tCOuun8NzTNV+Muc5MhSMx2H2cuDSfBLbuE8U1Hqx2Egwf+KIyS1Y+n1WAVIhCCTC3
         sbp1r9RnIKVJrz6s9K+LqDQEQh9QHjrBOYdXE7PGcbCrK7TJTuyjhJPRa5FMGHJLgGYs
         fbKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784063624; x=1784668424;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=be1RLwiNhcmJdomm6jkaCt0/KvcyWRVekWgUTPQeycU=;
        b=K+vDRLAgVDlKWC+TqvXlsqVk9K7fJqWwiln0JIInhu0axQzQVYSSuwYQHsofO9rrwC
         4pS1KOCVhqCfPSAqpy1w0imSMBdrp1POEyjBqVUzAfHrJYEbJ5vHzDzIuakOfQOTT0Pz
         ngIUAKccGu5SL0SIAObMNtcftalA6NJzQGpl7eTXFnnI6VV6FkxUv/Yd4hG1mouNbaSD
         b+5gw452cA9ag9qZyQRxMKlDP463j0nDH5o2X/Zq6ALa1EDuw8aQDYb70XoAQSnS49Qp
         s56y4hpeqJeG9sjXZEY/LRrwsD9Wtvsdqx6/KF6CDGhLSRjsNQTxxRoSlJEO/b1zq99D
         3mEA==
X-Forwarded-Encrypted: i=1; AHgh+Ro5E9i8tpVv+kU85losFfQUqRaXSjqUnKwzPnqBRapljA2zOg+XBhTlDamosHyYGllKCjRoRnA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZ1MivQ5vxxXAQGlrTD07uHigWGyPZYV+1Ir9mmT/przgETwS+
	FVTvWYVuXLq9PHBBNzz7h7/TV5AoC9FVTors11KOB+xtSPFKeO77pEsjuyG8h2Qq8AyIYzufIKE
	Lz7doPw==
X-Gm-Gg: AfdE7cnyRKuaaXKXNge5VEMksAhWVov4o7LtXvX67wTBxCzr9deS6BO/IMRU+dPlKhc
	SO5yAmVfQQr/chQWJQb21QOZTXV/M2Rn1ipUacPpGyrwdrsSx1VK4w2Arts6jYTEg7qFJjptJbU
	OFnl+ZwlUeOhWkaNaZWgL1t/LBdj3hlqxR4KKmu8wnXaZO+6V/GVIVRi8NrzjzcEvlNBg7eNBak
	CQN2ys0+nwAmxgH+NIwUbxT82nQg0jXTmywaMlQTWBZKzxJ38Us/bAuA92Qm8hN9lkHkhy9L6FF
	Bj6HQ7us4dDHLMaengqA2ZvhRddKEarmqdZ/wfhrGRh0keLscn2v4embS1tN5mIyRihnw+QpuW2
	962J59V0i+jlONK+K/ZvWWWahgHyz4c9U9WM6d++m5q8/K8IMvCSRykdWHgD7rSVVCGA448jsQ/
	Suc+P4ICKX/bQxkQ==
X-Received: by 2002:a05:620a:31a5:b0:92e:c117:9ea8 with SMTP id af79cd13be357-930962f3b64mr11987085a.86.1784063624366;
        Tue, 14 Jul 2026 14:13:44 -0700 (PDT)
Received: from rowland.harvard.edu ([2601:19b:d01:d210::883a])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92ee5cfacb3sm1550951985a.26.2026.07.14.14.13.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 14:13:43 -0700 (PDT)
Date: Tue, 14 Jul 2026 17:13:40 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: Jinchao Wang <wangjinchao600@gmail.com>
Cc: gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
	bigeasy@linutronix.de, eeodqql09@gmail.com, kees@kernel.org,
	surban@surban.net, linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com, stable@vger.kernel.org
Subject: Re: [PATCH] usb: gadget: dummy_hcd: prevent fifo_req reuse during
 giveback
Message-ID: <c7de3923-1f68-46f9-986e-33899dce112c@rowland.harvard.edu>
References: <20260714064829.172098-1-wangjinchao600@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260714064829.172098-1-wangjinchao600@gmail.com>

On Tue, Jul 14, 2026 at 02:48:29PM +0800, Jinchao Wang wrote:
> dummy_hcd embeds a single shared usb_request (dum->fifo_req) that the
> "emulated single-request FIFO" fast-path in dummy_queue() reuses for
> small IN transfers: it copies the caller's request into it
> (req->req = *_req) and queues it, treating list_empty(&fifo_req.queue)
> as "the slot is free".
> 
> The completion side (dummy_timer/transfer/nuke/dummy_dequeue) follows
> the standard pattern: list_del_init(&req->queue) unlinks the request,
> then the lock is dropped and usb_gadget_giveback_request() invokes
> req->complete().  But list_del_init() makes fifo_req.queue look empty
> *before* the completion callback returns, so a concurrent dummy_queue()
> on another CPU sees the slot as free, reuses fifo_req and runs
> req->req = *_req -- overwriting req->complete while dummy_timer is
> mid-calling it.  The indirect call then jumps to a clobbered pointer,
> causing a general protection fault / page fault in dummy_timer
> (syzkaller extid faf3a6cf579fc65591ca).  The clobbering write is an
> in-bounds memcpy on a live shared object, so KASAN cannot flag it.
> 
> Add a fifo_req_busy bit, set across the lockless giveback window via a
> dummy_giveback() helper used at all four gadget-request giveback sites,
> and require !fifo_req_busy in the FIFO fast-path guard so the shared
> slot cannot be reused until its completion callback has returned.
> 
> Reported-by: syzbot+faf3a6cf579fc65591ca@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=faf3a6cf579fc65591ca
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>

Wow!  I'm impressed.  How did you figure this out?

> ---
>  drivers/usb/gadget/udc/dummy_hcd.c | 40 +++++++++++++++++++++---------
>  1 file changed, 28 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/usb/gadget/udc/dummy_hcd.c b/drivers/usb/gadget/udc/dummy_hcd.c
> index f47903461ed5..fce3c3ba7a63 100644
> --- a/drivers/usb/gadget/udc/dummy_hcd.c
> +++ b/drivers/usb/gadget/udc/dummy_hcd.c
> @@ -278,6 +278,7 @@ struct dummy {
>  	unsigned			ints_enabled:1;
>  	unsigned			udc_suspended:1;
>  	unsigned			pullup:1;
> +	unsigned			fifo_req_busy:1;
>  
>  	/*
>  	 * HOST side support
> @@ -330,6 +331,28 @@ static inline struct dummy *gadget_dev_to_dummy(struct device *dev)
>  /* DEVICE/GADGET SIDE UTILITY ROUTINES */
>  
>  /* called with spinlock held */

That comment line is supposed to come immediately before nuke().  Your 
new code got inserted below the comment instead of above it.

> +/*
> + * Give back a gadget request with dum->lock dropped around the callback.
> + * If @req is the shared fifo_req, mark it busy across the callback so
> + * dummy_queue()'s FIFO fast-path (keyed on list_empty(&fifo_req.queue))
> + * cannot reuse it mid-giveback: list_del_init() already made the queue look
> + * empty, but the request is in flight until the completion callback returns.
> + * Caller holds dum->lock and has already done list_del_init() + status.
> + */
> +static void dummy_giveback(struct dummy *dum, struct usb_ep *_ep,
> +			   struct dummy_request *req)
> +{
> +	bool fifo = req == &dum->fifo_req;
> +
> +	if (fifo)
> +		dum->fifo_req_busy = 1;

Don't set the new flag here...

> +	spin_unlock(&dum->lock);
> +	usb_gadget_giveback_request(_ep, &req->req);
> +	spin_lock(&dum->lock);
> +	if (fifo)
> +		dum->fifo_req_busy = 0;
> +}
> +
>  static void nuke(struct dummy *dum, struct dummy_ep *ep)
>  {
>  	while (!list_empty(&ep->queue)) {

> @@ -729,6 +750,7 @@ static int dummy_queue(struct usb_ep *_ep, struct usb_request *_req,
>  	/* implement an emulated single-request FIFO */
>  	if (ep->desc && (ep->desc->bEndpointAddress & USB_DIR_IN) &&
>  			list_empty(&dum->fifo_req.queue) &&
> +			!dum->fifo_req_busy &&
>  			list_empty(&ep->queue) &&
>  			_req->length <= FIFO_SIZE) {
>  		req = &dum->fifo_req;

Set it here instead, so the flag is set during the entire time that 
dum->fifo_req is in use.  As a bonus, you can then remove the 
list_empty(&dum->fifo_req.queue) test above.

Otherwise this seems fine.

Alan Stern
