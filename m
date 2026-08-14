Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FADD45FFC7;
	Fri, 14 Aug 2026 12:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786709155; cv=none; b=AqAheX4jOuAF/cTdRfqOoqdttaEFpbaJjBTYHlmi5maq06FANmq83NxTrBqQXc41bj5rtDvZEA7sursrN5MTQXB8LAcrgWOKR0bN8XWcQtNSr47w6dvkgwE3Otfifqnww88YjPOquWslWQ3IbwWKgWnp5SxZDS4ltkxAQ/4T6xA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786709155; c=relaxed/simple;
	bh=RRAdnE3AgfrpxH5Gc5Sx8/07H+aHGviS7OiNn75ei88=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M27nP9fMv4IV5SWSX/0vX/cVu5nxSscMcHRIMRqMXW4kqJZDhT3+gnTWodwC467jl0b3Zrx4Iu636eTdBqNBGbdn4703GuBIDayLS49eHi3srw2bJTH2atmviducwIxI4fVmsN8i+aqtQ12jYS3JaamN0yFTZADs6ktDy+3A3bE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Y5xTWKQv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Y5xTWKQv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2DAA1F000E9;
	Fri, 14 Aug 2026 12:05:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1786709154;
	bh=oc6QpJbe8pAPodwdQ5Ao7+1jRsE5XVSpcTx3GCcOuDM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Y5xTWKQvXonNx0CKPQ6zsGycg+pEGSsAhHM9DDvG2J+VqX+QOn3sfBt0OQhMNRuwg
	 getzwfLDC8Bnhya4cmUgXzyqNXObpJVrIHNO5+SXF8UHlZKcSU0F1b9zVSs08zi9ry
	 /tYP8In5umUxHagqATufe8hu/6EWB8kFmtB+K3nk=
Date: Fri, 14 Aug 2026 21:04:20 +0900
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Hyeontae Lee <wonju345@naver.com>
Cc: Krzysztof Opasiak <k.opasiak@samsung.com>, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] usb: gadget: f_hid: only clear write_pending from the
 owning request
Message-ID: <2026081413-exorcist-elliptic-5d1b@gregkh>
References: <20260814084616.259367-1-wonju345@naver.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260814084616.259367-1-wonju345@naver.com>

On Fri, Aug 14, 2026 at 05:46:16PM +0900, Hyeontae Lee wrote:
> f_hidg_write() sets write_pending, caches hidg->req into a stack local,
> and drops write_spinlock across copy_from_user(). hidg_disable() frees
> hidg->req whenever write_pending is clear, so that flag is the only thing
> keeping the writer's cached pointer alive.
> 
> f_hidg_req_complete() clears it for whichever request completes, not for
> the one the writer owns. A write() that has queued a request leaves it
> queued indefinitely if the host never issues an IN token. When the host
> then disables the configuration, usb_ep_disable() gives that old request
> back, its completion clears write_pending, and hidg_disable() goes on to
> free hidg->req - which a different write() is holding at that moment.
> 
> The writer resumes, finds hidg->req NULL, and frees its cached pointer a
> second time:
> 
>   BUG: KASAN: slab-use-after-free in f_hidg_write+0x7b7/0x920
>   Read of size 8 at addr ffff888104fc9018 by task s4-3/163
> 
>   Allocated by task 0:
>    alloc_ep_req+0x20/0x1b0
>    hidg_set_alt+0x1ed/0xbd0
>    composite_setup+0x1072/0x8690
>    configfs_composite_setup+0xcd/0x110
>    dummy_timer+0x1a68/0x31d0
> 
>   Freed by task 0:
>    kfree+0x121/0x380
>    hidg_disable+0x559/0x7a0
>    reset_config+0x9d/0x200
>    composite_setup+0x32d4/0x8690
>    configfs_composite_setup+0xcd/0x110
>    dummy_timer+0x1a68/0x31d0
> 
>   The buggy address belongs to the object at ffff888104fc9000
>    which belongs to the cache kmalloc-128 of size 128
> 
>   BUG: KASAN: double-free in f_hidg_write+0x267/0x920
> 
> Record which request owns the flag and let only that request's completion
> clear it. An older queued request being given back then leaves
> write_pending set, hidg_disable() declines to free, and the writer frees
> its own request on the existing path.
> 
> Fixes: 25cd9721c2b1 ("usb: gadget: f_hid: fix: Don't access hidg->req without spinlock held")
> Cc: stable@vger.kernel.org
> Signed-off-by: Hyeontae Lee <wonju345@naver.com>
> ---
> Notes for reviewers:
> 
> The clearer was identified by instrumenting the three sites that clear the
> flag: of 4944 frees at hidg_disable(), all 4944 followed a clear from
> f_hidg_req_complete(), and 4440 freed a request a writer was holding.
> 
> 749494b6bdbb introduced the stack local but left the uses on hidg->req, so
> check and use still agreed; 25cd9721c2b1 moved the uses to the local and
> left the guard on the field, which is why that one is tagged.
> 
> Every dereference of the freed pointer is inside f_hidg_write(), so this is
> not remotely triggerable on its own - a local process must be writing to
> /dev/hidgN at the time.
> 
> hidg_disable() now declines to free a request a writer owns; f_hid's request
> lifetime under repeated SET_INTERFACE has pre-existing gaps this does not
> address.
> 
> Tested on v7.2-rc7-12 (f5bbbfec59b4) under dummy_hcd, report_length=8: over
> 45 s of identical workload, double frees of the same address went from 52 to
> 0 and KASAN reports from 208 to 0.

Did you forget to add an Assisted-by: tag?


> ---
>  drivers/usb/gadget/function/f_hid.c | 17 ++++++++++++++++-
>  1 file changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/gadget/function/f_hid.c b/drivers/usb/gadget/function/f_hid.c
> index 3c6b43d06a6d1..d65169c9645b1 100644
> --- a/drivers/usb/gadget/function/f_hid.c
> +++ b/drivers/usb/gadget/function/f_hid.c
> @@ -89,6 +89,7 @@ struct f_hidg {
>  	/* send report */
>  	spinlock_t			write_spinlock;
>  	bool				write_pending;
> +	struct usb_request		*write_req;
>  	wait_queue_head_t		write_queue;
>  	struct usb_request		*req;
>  
> @@ -443,7 +444,16 @@ static void f_hidg_req_complete(struct usb_ep *ep, struct usb_request *req)
>  	}
>  
>  	spin_lock_irqsave(&hidg->write_spinlock, flags);
> -	hidg->write_pending = 0;
> +	/*
> +	 * Only the completion of the request this writer owns may clear the
> +	 * flag. usb_ep_disable() gives back whatever is still queued from an
> +	 * earlier write(), and letting that clear write_pending lets
> +	 * hidg_disable() go on to free a request a writer is still holding.

LLMs love to add comments when it's not needed, be judicious please.

thanks,

greg k-h
