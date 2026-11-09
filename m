Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794243069;
	b=r2NnnDP9UNzn/M9S7vuYz0/anqkVxRFXIh5CQfYsu4boXKZHfu0XNqo1AaXzDkPUO00T
	 6xjjPWwDi/Yt2wbJ2wFjQs3dlJdTDrB27cWHdFD6U9vAtrw2Afa48TuRB/3JZtnv/uYiS
	 GUMPtnaV3iUkFJK6XAoes25LTWcV8dDyhx0NZ9u267agC7LenKELRDAqPnlMDVA1gYDVQ
	 OaVRKNVSS1tkuGt+sV+uBOPwb3cZhv5kWZSOE4JdbEnykdw43cErC1wYqp69R2ZWMlLez
	 n8bMhPfVQKxvU11S5QLHwBFa+TfSNtEXAJR3d00ssgoUmM7BtXr2HUxHcNXXfkwRE8g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794243069;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=pRmx0w+ZK8QYZ3Le9mlwOie4ZXY6jj6xLVnd9zUts7M=;
	b=M9J/7SnNpv15pVftqc0bWG2VUIzBoJMwQJCLNmhlM/S9xpDHzHOwFiSFwtu7xk/RnRNB
	 67Ej1ij58cMWkjVOTodPrf06fn79feBztlwARWCOcIUYiBXZyJ8X4WXcLyCNDX8EAnbv9
	 x9eBUihpVOnnd66Gyc9xnmYY7Dc1aDFRo/yEkxjsXuu6DVC45ijs9zD3RLn3GSMtIxvRu
	 lHNTJuC0z30Ch+NPOXeObUnM6PDsiuTBjM70FglbNkA1zzuYzVIKm7rF/JHFVPf01Snm5
	 ZME7UPHXeEVdNH6vc9tDOlTPknxusBRUiJFb3arRF/oaEO+2iT9s5+1mbw8IOb5aWEQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=rowland.harvard.edu;
	spf=fail smtp.mailfrom=g.harvard.edu;
	dkim=pass header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.a=rsa-sha256 header.s=google header.b=eVUtPdlI;
	arc=none smtp.remote-ip=209.85.219.46
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42D6460A2630
	for <stable@vger.kernel.org>; Mon,  9 Nov 2026 16:51:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 42D6460A2630
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.a=rsa-sha256 header.s=google header.b=eVUtPdlI
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-91ec396c93dso12933066d6.1
        for <stable@vger.kernel.org>; Mon, 09 Nov 2026 08:51:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1794243068; x=1794847868; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=pRmx0w+ZK8QYZ3Le9mlwOie4ZXY6jj6xLVnd9zUts7M=;
        b=eVUtPdlIxx2K2Thn4bqSyzcFLOC9yflVfdzDBaB4D+MZJCGwgOy31UmzpcqO46/0m+
         NqWjbSsE1jkuTeEv23cQkZpnXMJAhTVCr5b1jIlfQ6X2NXmuFQvqIA4hPTtsZaHKBZJG
         6gjTfeUHOhB45RMJCn8msDinbGOCyzFB9RzGNN9IMDXOiShevnhn6LLswqZqui2OdzcL
         bEDax1ClcWmvMhK3nGHlz50MOXdBGC7DHdg3Q7evUMrq2fJWPAhFYJvqFC0ZwE/mPUsY
         XqJfT7QBn8XjXpnh4GqL9BuuEedeOkge01onJ6F/wC2JYQyl0aWoW4Y/OkIDSzQNqsdT
         FAXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794243068; x=1794847868;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pRmx0w+ZK8QYZ3Le9mlwOie4ZXY6jj6xLVnd9zUts7M=;
        b=1ItimeCueHvAnvZgGcgboz+ZEUNbOdJiAIp779Jp4PSRr48z7W1cwTQIk8bMdCTp6J
         LUNTqPFdge6k6jkLyKpO3I9TukHxvUSUQSdh3yumYbt7yiXpXZayaPkDZsKerbv0Caqj
         MOCQuZFUEDi7J0e4wNWUJfiWYhzXlNEhRifuXQnvdUj/6EkdZbNbEJfpfryUaQMD6+L0
         7mij7BIN1yUlM6fEo4CNRE0zfVnU+EEdAjzrhNmgpr9XaJ0uN4Bvc/ERbwg5U2WyDr19
         oq2kV1H6XPNWFz/3b8HVToooIcIS7pZGx0HTr/zAV9Bnb8POFXqYy2Md5b2qyi3dlppS
         KY2w==
X-Forwarded-Encrypted: i=1; AL+hErG8dMpCSj7GjOnz3aBOEeVi6oR9luF0Pu8SHt8Zy8nuK0VBRdHirVnCQRmQ90u6FI+ijSdWsSo=@vger.kernel.org
X-Gm-Message-State: APuU4Z9gRUQbANRrrfyj3OyjDVIZ6z9uxaamNVzDc9qFPBbShV0t0as4
	Mq5dJmgEZyd6cu+CRejNu99DwBlHwqp6x2l7h3a/GjxbTIllNGLdQODNxSIFQHnsng==
X-Gm-Gg: AYBFou1mEHqKpTjRoiUsPtXoFIk7dvuLPhDE6MmuflXBNhOYhSMzSEMAp352T6zzsV8
	H+djm9pP8+OyPAToXB60JoKZvCEIWDwL+UO2G9eCWGvbkn4Ti8DDWYUzxmhHxm0JVAIqhMK2l7z
	gPpqBWTMdsbVLYWt9bF0bEHVf3/VZc+P4X54D18CIrc+I94LcAcXH9Vb5ggzPdLu450xcC61r6r
	Q/3dMu60pXfS+4p5Gco6SgFOOx7E+Lg1NFlLjAPZi54SyAh+tyy//h5EEkhdf5bqYjXKJQov2xK
	fMMMDv7/RY6U2iMrFPLsTeOem2DrTbsEporJCWYRyrb0sUVWtnYSqE9FLF3PCY2HaBY/XINiyjv
	BSJQCNshBXDtySisxgBD5jEG4uSaeRCn7zqsO7rQ3YTw85a0YCcNJi8XpK+bCyDEPa15l/SwUVA
	9o+nCl7kkg7WckxURFQp83pDlH2WHFH5mWwK9RS03Mb7FQiqjIG8AG1hn1JuraXiJBhkRBOx4w5
	lPdhhaNNfnGOLbaaWPL5QX2d5Zs2yLYRkD9xaiWS4gdX74Mpk/7qOYAgvBCfcsKZ111wvRuR1Qw
	7naqVYfXVOGDzS4cx/DAnzB9dydH
X-Received: by 2002:a05:620a:2b8e:b0:945:f5c0:a63f with SMTP id af79cd13be357-9479f228752mr4974385a.5.1794243067581;
        Mon, 09 Nov 2026 08:51:07 -0800 (PST)
Received: from rowland.harvard.edu ([2601:19b:d01:d210::66b0])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9479e7ce960sm12830485a.31.2026.11.09.08.51.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 08:51:06 -0800 (PST)
Date: Mon, 9 Nov 2026 11:51:03 -0500
From: Alan Stern <stern@rowland.harvard.edu>
To: kayano050408@gmail.com
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Neill Kapron <nkapron@google.com>, linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	syzbot+c73e1942197af9f54ca3@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: Re: [PATCH v6 1/3] usb: gadget: gadgetfs: fix ep0 request lifetime
 on disconnect
Message-ID: <72c56e59-9e78-4536-a0e8-8007aaa46fda@rowland.harvard.edu>
References: <20261109-b4-gadgetfs-ep0-v6-0-b410e3dced89@gmail.com>
 <20261109-b4-gadgetfs-ep0-v6-1-b410e3dced89@gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261109-b4-gadgetfs-ep0-v6-1-b410e3dced89@gmail.com>

On Mon, Nov 09, 2026 at 02:50:51PM +0800, Jing Lin via B4 Relay wrote:
> From: Jing Lin <kayano050408@gmail.com>
> 
> gadgetfs_unbind() frees the preallocated ep0 request after disconnecting
> the gadget, assuming that no I/O remains active.
> 
> With dummy_hcd, disconnecting does not necessarily drain ep0, so a delayed
> userspace response can leave dev->req queued when it is freed.  This
> triggers the warning in dummy_free_request() and a use-after-free when
> dummy_udc_stop() subsequently drains the endpoint queue.
> 
> gadgetfs_setup() and the userspace copy helpers also race on dev->req and
> req->buf:
> 
> 1. ep0_read() versus gadgetfs_setup().  A delegated control OUT request
>    is queued by gadgetfs_setup() and completed by ep0_complete(), which
>    leaves the payload in dev->req->buf and sets setup_out_ready.
>    ep0_read() copies that payload with copy_to_user() after dropping
>    dev->lock, so the copy can fault and sleep.  If a new control transfer
>    arrives during that window, gadgetfs_setup() reuses dev->req for it;
>    for example, GET_DESCRIPTOR(config) points req->buf at dev->config.
>    When ep0_read() resumes, clean_req() frees whatever req->buf points to
>    at that moment, which is now dev->config.  The following
>    GET_DESCRIPTOR(config) dereferences the freed descriptor.
> 
> 2. ep0_write() versus gadgetfs_setup().  For a delegated control IN
>    request, ep0_write() prepares dev->req and copies the response from
>    userspace with copy_from_user() after dropping dev->lock.  A control
>    request that arrives during that copy can point req->buf at dev->dev
>    or dev->config, so the userspace copy overwrites a descriptor buffer,
>    or it can reset req->buf to dev->rbuf, so the request is queued with
>    the wrong buffer.  Completion then calls clean_req() on the wrong
>    object.
> 
> Copy completed control OUT payloads into a separate setup_buf in
> ep0_complete(), copy control IN payloads from userspace into a stack
> buffer before preparing dev->req in ep0_write(), and reset req->buf when
> control transfers finish.  Track whether dev->req is queued, reject reuse
> while it is queued, and dequeue it without dev->lock before freeing it in
> gadgetfs_unbind().
> 
> Only the buffer allocated by setup_req() belongs to the request, while
> descriptor responses point req->buf into dev->buf.  Track the allocation
> explicitly so clean_req() cannot free a descriptor buffer when a request
> is destroyed while an in-kernel GET_DESCRIPTOR response is active, and
> wait for the asynchronous usb_ep_dequeue() completion before freeing the
> request.
> 
> Count setup callbacks and recheck the count in ep0_write() after
> copy_from_user(), so a control request that arrives while dev->lock is
> dropped invalidates the stale response instead of having it queued for
> the new transfer.
> 
> Wake an ep0_read() that waits for a delegated OUT data stage when a new
> setup aborts it, and include setup_abort in the wait condition so the
> abort is not missed.
> 
> Consume setup_abort through one helper that returns to
> STATE_DEV_CONNECTED only when the state is still STATE_DEV_SETUP.  This
> keeps the following event read out of the control data path without
> overwriting STATE_DEV_UNBOUND when gadgetfs_unbind() ran concurrently.

This seems like a lot of material for a single patch.  You could break 
it into two separate patches, one to handle the ep0 abort races and one 
to wait for outstanding requests to complete before freeing dev->req.  
Maybe subdivide it even more, if you think that would help.

> The setup() callback runs in interrupt context and may not sleep, so a
> mutex cannot be used to serialize it against ep0_read() and ep0_write().
> The shared request state is protected by dev->lock and the payloads are
> handed off through private buffers instead.

This sort of material (saying what you decided _not_ to do) doesn't 
belong in the patch description.  If anywhere, it should go in the 0/N 
summary message.

> @@ -1073,13 +1123,20 @@ ep0_read (struct file *fd, char __user *buf, size_t len, loff_t *ptr)
>  			struct usb_request	*req = dev->req;
>  
>  			if ((retval = setup_req (ep, req, 0)) == 0) {
> +				dev->state = STATE_DEV_CONNECTED;
>  				++dev->udc_usage;
> +				dev->ep0_req_queued = true;
>  				spin_unlock_irq (&dev->lock);
>  				retval = usb_ep_queue (ep, req, GFP_KERNEL);
>  				spin_lock_irq (&dev->lock);
>  				--dev->udc_usage;
> +				if (retval < 0) {
> +					dev->ep0_req_queued = false;
> +					clean_req(ep, req);
> +				}

Here, and every other place where dev->ep0_req_queued is changed to 
false, you need to call wake_up(&dev->wait).

>  			spin_unlock_irq (&dev->lock);
>  			retval = wait_event_interruptible (dev->wait,
> -					dev->setup_out_ready != 0);
> +					dev->setup_out_ready ||
> +					dev->setup_abort);
>  
>  			/* FIXME state could change from under us */
> @@ -1781,15 +1883,29 @@ gadgetfs_unbind (struct usb_gadget *gadget)
>  		usleep_range(1000, 2000);
>  		spin_lock_irq(&dev->lock);
>  	}
> +	queued = dev->ep0_req_queued;
>  	spin_unlock_irq (&dev->lock);
>  
> +	if (dev->req) {
> +		if (queued) {
> +			usb_ep_dequeue(gadget->ep0, dev->req);
> +			/*
> +			 * usb_ep_dequeue() may return before the completion
> +			 * routine runs.  Do not free the request until the
> +			 * controller has given it back.
> +			 */
> +			wait_event(dev->wait, !dev->ep0_req_queued);

Otherwise, how will this wait_event() call be triggered, if it is 
waiting for a failed submission?

Also, it would be worthwhile to create a separate subroutine just for 
submitting dev->req.  The same code is duplicated several times in the 
driver.

> +		}
> +		dev->req->buf = dev->rbuf;
> +		clean_req(gadget->ep0, dev->req);
> +		usb_ep_free_request(gadget->ep0, dev->req);
> +		dev->req = NULL;
> +	}
> +
>  	destroy_ep_files (dev);

Logically, this destroy_ep_files() call belongs before the dev->req 
stuff, because ep0 is created before and destroyed after all the other 
endpoints.

Alan Stern
