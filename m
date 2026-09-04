Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3986551118D;
	Fri,  4 Sep 2026 17:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788541834; cv=none; b=h7xReteO9VQNm/4wxVkyV959V+xRvSToGvufdG7yqFVPgPxd6/SPfIvKcyZRmG2GEi/Mx6EtYSKHPiM7G4U+cgztljvApMf3AWGBoAp44GYPZGs/3NYRFOM4t7CHF//FTYj3wjJ1xpBAxK9P2lKoderSZOAS4ERpeZPUbSA9dCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788541834; c=relaxed/simple;
	bh=gA6fqD4jeawG/r3uXp7hAR7LuJriNp0pXhV+O2ZhR2E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O8Wk9o6Ec8ptlOs5q9jse3rWJDkNMip+lFQB+scxRrix81uz2v0xwiKBsvWytPmdWGbI8AZN4tOhmcHHEM+gl//d3twLeyzWD4z4saOvxTHH1e5q5wJyat62ChVoxi+UwaBj3J1wnzTY/KoS8KhRnYOUMxu97jnU18p1H20Yd/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=M7wvoiU2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="M7wvoiU2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D9C01F00A3D;
	Fri,  4 Sep 2026 17:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788541831;
	bh=DLyBHdBCiwFaJqCNC3f7TEdHuUZXCH0w7XfvGLQL/Ok=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=M7wvoiU2Ad4m317yVhPA29adVTn/XoSCL5MdaOA1H+DQ2ictbMGs7zoklNWPyPYUf
	 cdTZZMTtbgcCoJhCFBcoDT7n1TwVO+Wkpom5xyFdEJ613Js4Jf4uF4A+C0kMkgDsKZ
	 0N2tvqv2E9rjNI0yaBVw7flJVOTplT+qMWmrxe5o=
Date: Fri, 4 Sep 2026 19:07:50 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Cole Munz <Munzzyy1@proton.me>
Cc: Thinh Nguyen <Thinh.Nguyen@synopsys.com>, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] usb: dwc3: gadget: don't error on dequeue of a
 completed request
Message-ID: <2026090413-hurdle-puzzling-aadd@gregkh>
References: <20260904161344.2191362-1-Munzzyy1@proton.me>
 <2026090406-unrevised-stays-4832@gregkh>
 <7bef11b63feb88f89b37bbc86323ed3dba794f43.1788541086.git.Munzzyy1@proton.me>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7bef11b63feb88f89b37bbc86323ed3dba794f43.1788541086.git.Munzzyy1@proton.me>

On Fri, Sep 04, 2026 at 04:58:57PM +0000, Cole Munz wrote:
> Dequeuing a request that has already been given back logs an error and
> returns -EINVAL:
> 
>   dwc3 23000000.usb: request 00000000ad92f1c4 was not queued to ep0out
> 
> f_fs hits this on every teardown. functionfs_unbind() dequeues ep0req
> unconditionally before freeing it, which
> commit ce405d561b02 ("usb: gadget: f_fs: Ensure ep0req is dequeued
> before free_request") made deliberate to close a use-after-free. By then
> the control transfer has long completed, so dwc3_gadget_ep_dequeue()
> finds the request on none of cancelled_list, pending_list or
> started_list and falls through to the error path.
> 
> Nothing is actually wrong. The request is not queued, which is what the
> caller asked for, and both callers ignore the return value and free the
> request straight after. The only effect is an error line in every gadget
> teardown, which buries real USB errors.
> 
> dwc3 already tracks enough to tell the two cases apart.
> dwc3_gadget_ep_alloc_request() sets DWC3_REQUEST_STATUS_UNKNOWN, both
> __dwc3_gadget_ep_queue() and __dwc3_gadget_ep0_queue() set
> DWC3_REQUEST_STATUS_QUEUED, and dwc3_gadget_giveback() sets
> DWC3_REQUEST_STATUS_COMPLETED. A request that reaches the end of dequeue
> with status COMPLETED was queued to this endpoint and has finished.
> Anything else was never queued here, or the driver lost track of it.
> Keep the error for those, and return success for a completed request.
> 
> A completed request still has to be dequeued on the endpoint it belongs
> to. req->dep is set once at allocation and never changes, and
> __dwc3_gadget_ep_queue() rejects the same mismatch with a WARN, so a
> wrong-endpoint dequeue stays on the error path here as well.
> 
> This is narrower than the cdnsp fix for the same caller,
> commit 34f08eb0ba6e ("usb: cdnsp: Fixes issue with dequeuing not queued
> requests"), which returns 0 whenever usb_request::status is not
> -EINPROGRESS. That also swallows a request that was never queued, since
> status is zero out of allocation. Going by dwc3's own request status
> keeps that case an error, which is what was asked for when a separate
> ep0 dequeue was proposed in 2022.
> 
> Fixes: 72246da40f37 ("usb: Introduce DesignWare USB3 DRD Driver")
> Cc: stable@vger.kernel.org
> Link: https://lore.kernel.org/linux-usb/20221117054917.30104-1-quic_ugoswami@quicinc.com/
> Assisted-by: LLM sparse
> Signed-off-by: Cole Munz <Munzzyy1@proton.me>
> ---
> All three were missing, sorry about that.
> 
> v2: add Fixes:, Cc: stable and Assisted-by tags. No code change.
> 
>  drivers/usb/dwc3/gadget.c | 19 ++++++++++++++++---
>  1 file changed, 16 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
> index fa944856f956..f68eb9254afa 100644
> --- a/drivers/usb/dwc3/gadget.c
> +++ b/drivers/usb/dwc3/gadget.c
> @@ -2181,9 +2181,22 @@ static int dwc3_gadget_ep_dequeue(struct usb_ep *ep,
>  		}
>  	}
>  
> -	dev_err(dwc->dev, "request %p was not queued to %s\n",
> -		request, ep->name);
> -	ret = -EINVAL;
> +	/*
> +	 * The request is on none of this endpoint's lists. That is the
> +	 * expected state once it has been given back: a function may dequeue
> +	 * a request before freeing it, and f_fs does so unconditionally for
> +	 * ep0req in functionfs_unbind(). Nothing is queued, which is what the
> +	 * caller asked for, so report success. Any other status means the
> +	 * request was never queued here or the driver lost track of it, and
> +	 * stays an error. So does a completed request handed to the wrong
> +	 * endpoint: req->dep is fixed at allocation, and the queue side
> +	 * rejects the same mismatch.
> +	 */

LLMs love to add long comments like this that make almost no sense.
Please rewrite this in a human voice, being very concise, if you still
feel a comment is needed.

thanks,

greg k-h
