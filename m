Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A43683033F5;
	Thu, 25 Jun 2026 13:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782395965; cv=none; b=PDPY3VOiZqUYFgpNokmZ9M/V3IBZD7v74gtgorGgktQ/GvWTPMCm/qKezr+nd9ksWJCmxQfi2rTBOcComgfNrEGRWAyzORaiq8ASoPWR8xhrWOFyonGY4P2zTpEssjbURgXgu37YA7ukb/yKaFV/dhUBfawPOzojgz0a+tAjQQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782395965; c=relaxed/simple;
	bh=9KfnScTaU7V2VWW54Rm8nUqqtKVRHVbaZxtXq2v6HaY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HZ6GwETmNVvSAPkr0StkNnjejMU03N+rlCmGiAAuJeOvnr5g2/LAE6FJhAPaCy+yP2q38iFViGNGy1HNsCW5She4jmuyx1Y3AM1WmlPet30VHCRnXFAxr9r6mYg2bX33dpkw3IIir6FDtmgp1pTsaG2kkAM7hm6w6Az2R4ihvbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=N/oaw8XV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="N/oaw8XV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B46251F000E9;
	Thu, 25 Jun 2026 13:59:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1782395964;
	bh=VwuvOQTh9YnYvj1OE7I2iBGUZJIM6VMa+G3v72JjBJ4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=N/oaw8XVH2QstEhegFemDQQysi4GtRDqCso3vucekfWOxcwqpw5BKq3dvTI/ZzJU5
	 B+gWGrzWoTkX50JZtahktAEXqS5WXqrjEXmqmRsaBmUN7nz+8chNwnlgZcguzxPFQS
	 wWKKCJ9eAO8gpvUdrnU0zfruTV4u3aAgU1cDn0JI=
Date: Thu, 25 Jun 2026 14:58:12 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Adrian Korwel <adriank20047@gmail.com>
Cc: linux-usb@vger.kernel.org, stable@vger.kernel.org, dave@stgolabs.net
Subject: Re: [PATCH] usb: gadget: f_midi: cancel work before midi is freed
Message-ID: <2026062501-espresso-sadness-801e@gregkh>
References: <2026052509-shelter-caucus-92e5@gregkh>
 <20260525150139.3038-1-adriank20047@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260525150139.3038-1-adriank20047@gmail.com>

On Mon, May 25, 2026 at 10:01:39AM -0500, Adrian Korwel wrote:
> f_midi_disable() disables the USB endpoints but does not cancel the
> pending work item before returning. Since f_midi uses the system
> high-priority workqueue (system_highpri_wq) rather than a dedicated
> workqueue, there is no implicit draining when the function is unbound.
> 
> The work item f_midi_in_work can therefore be scheduled via
> queue_work() from f_midi_complete() or f_midi_in_trigger() and execute
> after f_midi_free() has run, resulting in a use-after-free when
> f_midi_transmit() accesses midi->in_ep, midi->transmit_lock,
> midi->in_req_fifo and midi->in_ports_array.
> 
> This was introduced in commit 8653d71ce376 ("usb/gadget: f_midi:
> Replace tasklet with work") which converted from tasklet_hi_schedule()
> to queue_work() but omitted the cancel_work_sync() call needed to
> ensure the work is not in flight when the structure is freed. Tasklets
> did not require explicit cancellation in this path; workqueues do.
> 
> Fix by calling cancel_work_sync() in f_midi_disable() after disabling
> the endpoints, ensuring no work item referencing midi can run after
> teardown begins.
> 
> Fixes: 8653d71ce376 ("usb/gadget: f_midi: Replace tasklet with work")
> Cc: stable@vger.kernel.org
> Signed-off-by: Adrian Korwel <adriank20047@gmail.com>
> ---
>  drivers/usb/gadget/function/f_midi.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/usb/gadget/function/f_midi.c b/drivers/usb/gadget/function/f_midi.c
> index 4d9e4bd700d8..864527bf900c 100644
> --- a/drivers/usb/gadget/function/f_midi.c
> +++ b/drivers/usb/gadget/function/f_midi.c
> @@ -430,6 +430,8 @@ static void f_midi_disable(struct usb_function *f)
>  	usb_ep_disable(midi->in_ep);
>  	usb_ep_disable(midi->out_ep);
>  
> +	cancel_work_sync(&midi->work);
> +
>  	/* release IN requests */
>  	while (kfifo_get(&midi->in_req_fifo, &req))
>  		free_ep_req(midi->in_ep, req);
> -- 
> 2.43.0
> 
> 

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:


- This looks like a new version of a previously submitted patch, but you
  did not list below the --- line any changes from the previous version.
  Please read the section entitled "The canonical patch format" in the
  kernel file, Documentation/process/submitting-patches.rst for what
  needs to be done here to properly describe this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
