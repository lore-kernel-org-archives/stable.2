Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1C3742903A
	for <stable@vger.kernel.org>; Thu, 16 Jul 2026 13:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784209842; cv=none; b=MenrMQu4SOGPulUNm8FOrOVJCHOgz/hZBfdFHlceuvzs+qroQsG8FZlubZpfAS1WEfxICdKh58myc/ahusEq5/nOpL0ST9og+WXXuCalEM/0zqXsi0QC4K1cQj0cOCOXpq4RKzdULXx/0tVuBYm+ZxU2z6qjuoUQKn3w9Ore8rA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784209842; c=relaxed/simple;
	bh=guywnq+OONoCzjFKy5Yswja0LpCYw+U9IPLJdPZxFFs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p9sAO4m1LHh/811zD04BrEN56Wizh4awbNs7ejUagWv0Z6x60GZJjqXBXonKO3hp51dTNLgOlAdvOktepeyAlFb3DcqZSDHInNp5B6FQVWsTaAO+QM5zbcyNIv/teQKH3RXj9wc2GogU5znNdbf6SMcgK4/Syzw2NyoUBUHPiPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=kqRPoLbb; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="kqRPoLbb"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-51c2a449c57so61484001cf.1
        for <stable@vger.kernel.org>; Thu, 16 Jul 2026 06:50:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1784209839; x=1784814639; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=wyyFAYfsx6IDOKPwbXOmbk6JqIVXyebJTmhE4alRfu0=;
        b=kqRPoLbbHQRysHvCrKSnq8qf8cDjUFKrNH2t/k/ujC86FAAJegspc8sdkmY9V0sSTE
         OiUobfi6j9pA/8O9gljDashtcNIJ/QWGCQhViDHT/tZQMNNvCkkB0d8kLr45DEFg7gfX
         uYjR7ZwkTpfjRjJiA+n6A1ON6EzIe457INdLYExTXtvMg2uqmuq+XEIpVC0uHR8Sprbq
         lZ9VlXEwYNBA8xH5C7qZlfZVw0G48KtKUFpelOiFoK5PK1/QcI/ihuCqdGMRLfwB/TYA
         hVjenm5LjmC/x976XO3S+IelKuLDVWRxka0SfJJ0cCuCKcWyY9kDhzqfio9mhJTkfNlO
         ufXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784209839; x=1784814639;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wyyFAYfsx6IDOKPwbXOmbk6JqIVXyebJTmhE4alRfu0=;
        b=hTO4xlhwCHJ4S3w84gx75fjcGbLhjhjM34g1cvqT7xcjhDxG4t1CGOPuKdsn8o9tCX
         /odzSeXJrI1ycop0HaMssk35mKOW+TVv9byjzNA/zA25uqYN0GJ7AUHxMsUOG6hWEZnf
         HLPNs3Ilaj1rZxGp2wNCYUUXo1a4iSYZT66CN1AYWBnHSgPQ038rRlLH+6NToo8k+sXI
         sleUFI2/RqKOKqED+8XKB51xvLV686nJd4cQc+VDcPPtvWBOWg86VpH6udE5YiAihuaU
         Joz1sxOGCSsSjUewW2l6ljQDRFjrVKn9dHMuf4OfxcipxcM6aus6sU5/suTO8oTwfoJm
         TBOg==
X-Forwarded-Encrypted: i=1; AHgh+RquugOhqNZh3zNi9HfkBjXRlKKTdNnjA3vbDUYXzJ0641yahrnLNlhuaKbCIFGdBJPTRaEvQGw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyq5HdnDQLUONABhpVOkNmG6LAKu3QVCxBZH0awKrG6ZH1Y3pXA
	R8kDoJGKPlQXd7kWDg95Q6+FXRfQSMBzBopGRZrRI55Tau4c8X/ipX1v4DJ7cGWWUg==
X-Gm-Gg: AfdE7cmU672xBMJrb1v5Ub4aayeMcXKl4iHDxOEU5KtON3m8eeo8YlBRWpg70XPvK/z
	SOdhBftX0jjOlM9dGxSvECvV5FJJ2NxR/3k+iHiR0vGxXhQh+YSvQP7LDrSJOufxMj1GRI6Wgm4
	r8/8EJsW4QT7QwZc3RCXnWHClLESoVE6fG1bzWcy5xKswmR2XBA0ooG9araQ7W2FKkmbZiXBPnE
	sJMeCk8Q2caGhgGq6Rk7nwv8VCzbz9WUvw6zyZF191grvgv7XgE9gMmz+Yy1uhUTFP3DlUCCjQQ
	rPGRsdXrCrjMFsoIXkmCn6U4CBKqqv3+o23mek2Bcnxx7EEccU4EOcIZYsO4AD77jZGDfnvzNDt
	4YJtYXl6tnWOFkMseZWje13rfbW9Mm27EBRlHMHgi1rP4mtrvteqz0A86zfh2o+6d48xOyJKXJe
	xspGGh2oUXS47pcYk1SaKj
X-Received: by 2002:a05:622a:4c6:b0:519:8b76:2ce0 with SMTP id d75a77b69052e-51e3c21a3eemr130895871cf.37.1784209838410;
        Thu, 16 Jul 2026 06:50:38 -0700 (PDT)
Received: from rowland.harvard.edu ([140.247.181.15])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ffd82e9d5csm218295796d6.41.2026.07.16.06.50.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 06:50:37 -0700 (PDT)
Date: Thu, 16 Jul 2026 09:50:36 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: Jinchao Wang <wangjinchao600@gmail.com>
Cc: gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, eeodqql09@gmail.com,
	surban@surban.net, bigeasy@linutronix.de, kees@kernel.org,
	syzbot+faf3a6cf579fc65591ca@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] usb: gadget: dummy_hcd: prevent fifo_req reuse during
 giveback
Message-ID: <52979e09-5422-4ab4-bffa-995b245d8267@rowland.harvard.edu>
References: <20260714064829.172098-1-wangjinchao600@gmail.com>
 <5db8bba5b3499a86cd2e776f9918126b68b2508b.1784198306.git.wangjinchao600@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5db8bba5b3499a86cd2e776f9918126b68b2508b.1784198306.git.wangjinchao600@gmail.com>

On Thu, Jul 16, 2026 at 06:42:17AM -0400, Jinchao Wang wrote:
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
> Add a fifo_req_busy bit covering the shared request's whole lifetime:
> set it in dummy_queue() when the FIFO fast-path takes fifo_req (making
> it the fast-path guard, replacing the list_empty(&fifo_req.queue)
> test), and clear it after the completion callback has returned, via a
> dummy_giveback() helper used at all four gadget-request giveback
> sites.  The shared slot can no longer be reused until its completion
> callback has finished.
> 
> Reported-by: syzbot+faf3a6cf579fc65591ca@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=faf3a6cf579fc65591ca
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
> ---
> Changes in v2 (per Alan Stern's review of v1 [1]):
> 
> - Move dummy_giveback() above the "/* called with spinlock held */"
>   comment so the comment is again immediately before nuke().
> - Set fifo_req_busy in dummy_queue() when the FIFO fast-path takes the
>   shared request (covering its whole in-use lifetime) instead of in
>   dummy_giveback(), and drop the now-redundant
>   list_empty(&fifo_req.queue) test from the fast-path guard.
> 
> [1] https://lore.kernel.org/all/20260714064829.172098-1-wangjinchao600@gmail.com/

Reviewed-by: Alan Stern <stern@rowland.harvard.edu>

>  drivers/usb/gadget/udc/dummy_hcd.c | 40 ++++++++++++++++++++----------
>  1 file changed, 27 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/usb/gadget/udc/dummy_hcd.c b/drivers/usb/gadget/udc/dummy_hcd.c
> index f47903461ed5..c0e40fa6dde5 100644
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
> @@ -329,6 +330,26 @@ static inline struct dummy *gadget_dev_to_dummy(struct device *dev)
>  
>  /* DEVICE/GADGET SIDE UTILITY ROUTINES */
>  
> +/*
> + * Give back a gadget request with dum->lock dropped around the callback.
> + * If @req is the shared fifo_req, clear fifo_req_busy afterward: the flag
> + * was set in dummy_queue() when the shared request was taken and must stay
> + * set until its completion callback has returned; list_del_init() alone
> + * makes the request look idle while the callback is still running.
> + * Caller holds dum->lock and has already done list_del_init() + status.
> + */
> +static void dummy_giveback(struct dummy *dum, struct usb_ep *_ep,
> +			   struct dummy_request *req)
> +{
> +	bool fifo = req == &dum->fifo_req;
> +
> +	spin_unlock(&dum->lock);
> +	usb_gadget_giveback_request(_ep, &req->req);
> +	spin_lock(&dum->lock);
> +	if (fifo)
> +		dum->fifo_req_busy = 0;
> +}
> +
>  /* called with spinlock held */
>  static void nuke(struct dummy *dum, struct dummy_ep *ep)
>  {
> @@ -339,9 +360,7 @@ static void nuke(struct dummy *dum, struct dummy_ep *ep)
>  		list_del_init(&req->queue);
>  		req->req.status = -ESHUTDOWN;
>  
> -		spin_unlock(&dum->lock);
> -		usb_gadget_giveback_request(&ep->ep, &req->req);
> -		spin_lock(&dum->lock);
> +		dummy_giveback(dum, &ep->ep, req);
>  	}
>  }
>  
> @@ -728,10 +747,11 @@ static int dummy_queue(struct usb_ep *_ep, struct usb_request *_req,
>  
>  	/* implement an emulated single-request FIFO */
>  	if (ep->desc && (ep->desc->bEndpointAddress & USB_DIR_IN) &&
> -			list_empty(&dum->fifo_req.queue) &&
> +			!dum->fifo_req_busy &&
>  			list_empty(&ep->queue) &&
>  			_req->length <= FIFO_SIZE) {
>  		req = &dum->fifo_req;
> +		dum->fifo_req_busy = 1;
>  		req->req = *_req;
>  		req->req.buf = dum->fifo_buf;
>  		memcpy(dum->fifo_buf, _req->buf, _req->length);
> @@ -785,9 +805,7 @@ static int dummy_dequeue(struct usb_ep *_ep, struct usb_request *_req)
>  		dev_dbg(udc_dev(dum),
>  				"dequeued req %p from %s, len %d buf %p\n",
>  				req, _ep->name, _req->length, _req->buf);
> -		spin_unlock(&dum->lock);
> -		usb_gadget_giveback_request(_ep, _req);
> -		spin_lock(&dum->lock);
> +		dummy_giveback(dum, _ep, req);
>  	}
>  	spin_unlock_irqrestore(&dum->lock, flags);
>  	return retval;
> @@ -1523,9 +1541,7 @@ static int transfer(struct dummy_hcd *dum_hcd, struct urb *urb,
>  		if (req->req.status != -EINPROGRESS) {
>  			list_del_init(&req->queue);
>  
> -			spin_unlock(&dum->lock);
> -			usb_gadget_giveback_request(&ep->ep, &req->req);
> -			spin_lock(&dum->lock);
> +			dummy_giveback(dum, &ep->ep, req);
>  
>  			/* requests might have been unlinked... */
>  			rescan = 1;
> @@ -1910,9 +1926,7 @@ static enum hrtimer_restart dummy_timer(struct hrtimer *t)
>  				dev_dbg(udc_dev(dum), "stale req = %p\n",
>  						req);
>  
> -				spin_unlock(&dum->lock);
> -				usb_gadget_giveback_request(&ep->ep, &req->req);
> -				spin_lock(&dum->lock);
> +				dummy_giveback(dum, &ep->ep, req);
>  				ep->already_seen = 0;
>  				goto restart;
>  			}
> -- 
> 2.53.0
> 
