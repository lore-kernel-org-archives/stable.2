Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 314DF37C10C;
	Thu, 10 Sep 2026 13:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789047634; cv=none; b=Frxp1Ic+dc2n0ZfcWqCOk7lLThFEh0Ru/ZiJ/mxKRBEeqsYQzb2ugxjRJmFHROED02w0sHQg1HlC9G14iyhT18dzg0oWEXYqhmYodwK/oyfuwXE3uymKUKjE5V2CBl0+eOz77AdaaTYNwvjdc/xHokGYh25z7Es7Q6VIWgbVB9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789047634; c=relaxed/simple;
	bh=ebLIaGFPwn6jlZr+scsUSMLgbdDN6IZAobs0/FT/3Rg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hc8CpdvjkWr98xhM8qKRW/fXNQEiXYsfPz2GrPYSV/EAg5jrY77AT332gh8guUq44p3FIxWy9PHnlvAKCFnPPvuE3wGP1tkC76P2jDG+IiYyoSkoN3h35KeA/pe0FK3UAUyughSCkChh46kPPjC+zP00xHQ/EBBph6euFQ4mc94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qaD+85Wm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qaD+85Wm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FB6F1F000FF;
	Thu, 10 Sep 2026 13:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1789047631;
	bh=xO6IrZJlrsRk11VGROOdZQbQRlbEHwSOdyIM9DozyvE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=qaD+85Wm9UdcVhU4FJz0n/oUK4e0HMXOaFLSSo2wki/nHdDy9wPq8VaLW6MXrusoU
	 TXceK9wB3DIRRnk9I4ySAqnI5y6HnJtY/EAD3nyhtBqzvVMnc4kRk/n+fri2SN0IzT
	 XeS3v5p8xaVYGFd8V0GEZjH1F5C+UWOGjFSsT24g=
Date: Thu, 10 Sep 2026 15:40:23 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: syedlabeeq <syedlabeeq@gmail.com>
Cc: linux-usb@vger.kernel.org, usb-storage@lists.one-eyed-alien.net,
	stern@rowland.harvard.edu, stable@vger.kernel.org
Subject: Re: [PATCH RESEND] usb: storage: sierra_ms: reject short SWoC info
 transfers
Message-ID: <2026091052-refueling-bulk-afc5@gregkh>
References: <20260910123129.16793-1-syedlabeeq@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260910123129.16793-1-syedlabeeq@gmail.com>

On Thu, Sep 10, 2026 at 05:31:28PM +0500, syedlabeeq wrote:
> From: Syed Labeeq Sajid Bukhari <syedlabeeq@gmail.com>
> 
> sierra_get_swoc_info() requests sizeof(struct swoc_info) (60) bytes
> from the device via usb_control_msg(), but its callers only treat a
> negative return value as failure. A device that answers the
> vendor-specific GetSwocInfo request with a short IN transfer is
> therefore accepted, leaving the tail of the freshly allocated
> (kmalloc(), non-zeroing) swoc_info buffer uninitialized.
> 
> truinst_show() subsequently prints swocInfo->rev, swocInfo->LinuxSKU
> and swocInfo->LinuxVer from that buffer into the world-readable
> (0444) "truinst" sysfs attribute. An emulated/malicious USB device
> (VID 0x1199, PID 0x0fff) can exploit this to disclose up to 5 bytes
> of stale kernel heap memory (kmalloc-64) to unprivileged userspace,
> once per sysfs read, indefinitely. On kernels built without
> init_on_alloc this leaks recently freed heap contents.
> 
> Only accept the transfer when the full structure was received.
> sierra_ms_init() already retries failed queries, so well-behaved
> devices are unaffected.
> 
> Fixes: 32fe5e393455 ("USB Storage Sierra: TRU-Install feature update")
> Cc: stable@vger.kernel.org
> Signed-off-by: Syed Labeeq Sajid Bukhari <syedlabeeq@gmail.com>
> ---
> Resend: the first posting was whitespace-mangled by a webmail client;
> no code changes.
>  drivers/usb/storage/sierra_ms.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/usb/storage/sierra_ms.c b/drivers/usb/storage/sierra_ms.c
> index 177fa6cd143ab2837640c26f8336781ddd3cf9cb..8755fda42eed2afd3235283e990a35aac14cb829 100644
> --- a/drivers/usb/storage/sierra_ms.c
> +++ b/drivers/usb/storage/sierra_ms.c
> @@ -76,6 +76,12 @@
>  			(void *) swocInfo,		/* void *data        */
>  			sizeof(struct swoc_info),	/* __u16 size 	     */
>  			USB_CTRL_SET_TIMEOUT);		/* int timeout 	     */
> +	/*
> +	 * A short IN transfer leaves the tail of swocInfo uninitialized;
> +	 * only a full transfer is valid.
> +	 */
> +	if (result != sizeof(struct swoc_info))
> +		return -EIO;

Don't you need a blank line before this comment?

And did you forget an Assisted-by: tag?

thanks,

greg k-h
