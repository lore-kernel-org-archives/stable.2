Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68ECF388E76;
	Fri,  3 Jul 2026 07:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783062201; cv=none; b=WKA+qWAOx1nftpZ5TBN/n5phnqGoG1Gp74rSGJ1SJT55z0b48QIk/Vw4VkxTFFa97s1OQXCOB+jgEdsreMB0EDHmRWIuBPWwv4AYcqbgDD9OI8GcCV0L7ZVMNj31ZV1MlBLstQbbbS9/IIdXpSCnwAuuNRgKLXHn7Xh4VNchxiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783062201; c=relaxed/simple;
	bh=JkFPjoxFTMur+37gMHh4PR+51kpVZe+/gkS9HFC0MBs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YBw7jh5A4xQMFtW8oChYTCT9HVpS6+0mLYzgkZIVmmezsh0n6ovVed/zh772VrTtOYPSbUxy86jCrp+joyexHjtY1qcOQkVnf/iSIyvMf/vf0/WgPT3Qy63+4gYE+qYuad9kWJdCk2oBGeDqPSVWy8dcQ8GChjJpEnuJ3M+11Yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RThat20e; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RThat20e"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9B701F000E9;
	Fri,  3 Jul 2026 07:03:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783062200;
	bh=MwBqIbO+uyjhlDw6NVMbMyFvEcq7NmoGtHQejj+SLFE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=RThat20ehjTOHl5OwssmV69gEmG2XtNagHpxRhIW8AXKQf+43a/DDdjyRAjwavYaK
	 sSiZ3DoLLFpWSxZgn8uuWfduaLLCcp92C8ZCacx1Tb0xIuOpaXzkriE1Rw3ylL7sqm
	 oSeccmmcQcjR5FOWhItZRdGpi4O0vqKu/KMl2QBVwoBI4Iu69M2i9HjV57S2/8jkZe
	 UTiqaAiDHA+d0LD8ro1C2olBk94i2sC7AJjwKmc6Kv6SssgN7rmOSNm6V5lSFsB393
	 jpwKD3r2xJaSuScEMETJ8jzGqQOh4e8f/aOC8vHuJl7EGV8XROmTAOFd+x2xMuDLqI
	 awTcwR3SHtLWA==
Date: Fri, 3 Jul 2026 00:03:18 -0700
From: Peter Chen <peter.chen@kernel.org>
To: Melbin K Mathew <mlbnkm1@gmail.com>
Cc: gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, security@kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] usb: gadget: printer: fix infinite loop in printer_read()
Message-ID: <akdetq0h1ECpbZXp@hu-petche-lv.qualcomm.com>
References: <20260701205320.227791-1-mlbnkm1@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260701205320.227791-1-mlbnkm1@gmail.com>

On 26-07-01 22:53:20, Melbin K Mathew wrote:
> printer_read() uses the same variable for the requested copy size and
> the number of bytes actually copied to user space. copy_to_user()
> returns the number of bytes not copied, so when it fails to copy
> anything, the computed copied length becomes zero.
> 
> In that case len, buf, current_rx_bytes and current_rx_buf are left
> unchanged. If RX data is available and the user buffer remains
> unwritable, the read loop can repeat indefinitely.
> 
> Track the copied length separately and return -EFAULT, or the number of
> bytes already copied, if an iteration makes no progress.
> 
> Fixes: b185f01a9ab7 ("usb: gadget: printer: factor out f_printer")
> Cc: stable@vger.kernel.org
> Signed-off-by: Melbin K Mathew <mlbnkm1@gmail.com>
> ---
> A small userspace model/reproducer is available to maintainers on request.
> 
>  drivers/usb/gadget/function/f_printer.c | 25 +++++++++++++++++++------
>  1 file changed, 19 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/usb/gadget/function/f_printer.c b/drivers/usb/gadget/function/f_printer.c
> index e4f7828ae7..e346e4c26e 100644
> --- a/drivers/usb/gadget/function/f_printer.c
> +++ b/drivers/usb/gadget/function/f_printer.c
> @@ -432,7 +432,7 @@ printer_read(struct file *fd, char __user *buf, size_t len, loff_t *ptr)
>  {
>  	struct printer_dev		*dev = fd->private_data;
>  	unsigned long			flags;
> -	size_t				size;
> +	size_t				size, not_copied, copied;
>  	size_t				bytes_copied;
>  	struct usb_request		*req;
>  	/* This is a pointer to the current USB rx request. */
> @@ -525,14 +525,16 @@ printer_read(struct file *fd, char __user *buf, size_t len, loff_t *ptr)
>  		else
>  			size = len;
>  
> -		size -= copy_to_user(buf, current_rx_buf, size);
> -		bytes_copied += size;
> -		len -= size;
> -		buf += size;
> +		not_copied = copy_to_user(buf, current_rx_buf, size);
> +		copied = size - not_copied;
> +
> +		bytes_copied += copied;
> +		len -= copied;
> +		buf += copied;
>  
>  		spin_lock_irqsave(&dev->lock, flags);
>  
> -		/* We've disconnected or reset so return. */
> +		/* We have disconnected or reset so return. */

Since it is a bug-fix, and goes to stable tree, drop this un-related change.
Otherwise:
Reviewed-by: Peter Chen <peter.chen@kernel.org>

Peter

>  		if (dev->reset_printer) {
>  			list_add(&current_rx_req->list, &dev->rx_reqs);
>  			spin_unlock_irqrestore(&dev->lock, flags);
> @@ -543,6 +545,17 @@ printer_read(struct file *fd, char __user *buf, size_t len, loff_t *ptr)
>  		if (dev->interface < 0)
>  			goto out_disabled;
>  
> +		if (!copied) {
> +			dev->current_rx_req = current_rx_req;
> +			dev->current_rx_bytes = current_rx_bytes;
> +			dev->current_rx_buf = current_rx_buf;
> +			spin_unlock_irqrestore(&dev->lock, flags);
> +			mutex_unlock(&dev->lock_printer_io);
> +			return bytes_copied ? bytes_copied : -EFAULT;
> +		}
> +
> +		size = copied;
> +
>  		/* If we not returning all the data left in this RX request
>  		 * buffer then adjust the amount of data left in the buffer.
>  		 * Othewise if we are done with this RX request buffer then
> -- 
> 2.39.5
> 
> 

-- 

Thanks,
Peter Chen
