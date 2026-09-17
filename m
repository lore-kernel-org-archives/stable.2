Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B61D550DB8;
	Thu, 17 Sep 2026 15:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789658272; cv=none; b=XbGrl/6WG3j/DIMOqxXVvXSNRGfwuHUDniGTmVl86gW34aa6AXW0+rEdawC8BYcy5DHhaHkqZEyGyDo2igh0rsXzluZ/W3fs7uwOXJQPwZz29ZPJk8xdQ+x+TQW0hBhz2Brp5yH+rqEnvqgWNqHnE3kDw+015tS/pTiAPE8r6O8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789658272; c=relaxed/simple;
	bh=WCjWZ4ko8FeIN8sqh99s+ccnuIOlIyUFY3KoAf3vhJI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DyMDjRw5+aDh8hZnKDT7OXnM2SuokGLjcAG4tGIXSmHRrnXZ6NblZK1icyUJ/+uLLHEOKEBQHTajbdK1rgLDWBxvk3ocNFsv4mFDuNTtfkpiWVLE5Uc9moTbwR/xVWe3Kt8ZUhZEEGMisF5CiomDmLy83pv8SOpzi8ryyYF4kb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wjSpXKYJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wjSpXKYJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B99A1F008AB;
	Thu, 17 Sep 2026 15:17:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1789658241;
	bh=06xNhlMbIFLF21+BuJrYXqeFqRP7MJS9PBsX0UaCkhQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=wjSpXKYJHPFycTzd1iXnjgHzdvBxBhlFzL2mfY2SS5StsMkvkflCULZj9hBz9mnoS
	 YK9wAs0H+AZPtBikMp4GcXgoLGh1OBadn3Yf4BJKhfmexFcZMZ81KEfF6COFdLEwcV
	 EBLxm+bEMe11XktZ9D2lkLo8HDjGeISOIrlT7adU=
Date: Thu, 17 Sep 2026 16:15:26 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: zjamg <ndaugoing@gmail.com>
Cc: Michal Nazarewicz <mina86@mina86.com>,
	Robert Baldyga <r.baldyga@samsung.com>, Felipe Balbi <balbi@ti.com>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 1/1] usb: gadget: f_fs: Fix NULL pointer dereference in
 FUNCTIONFS_ENDPOINT_DESC
Message-ID: <2026091710-trapper-sudden-0d05@gregkh>
References: <20260917135337.65444-1-ndaugoing@gmail.com>
 <20260917135337.65444-2-ndaugoing@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260917135337.65444-2-ndaugoing@gmail.com>

On Thu, Sep 17, 2026 at 09:53:37PM +0800, zjamg wrote:
> When user space sets up FunctionFS with only full-speed descriptors
> (e.g., flags = FUNCTIONFS_HAS_FS_DESC) and the gadget operates at a
> higher speed (such as USB_SPEED_HIGH or USB_SPEED_SUPER),
> config_ep_by_speed() detects that the function lacks descriptors for
> the current speed, logs a warning, and falls back to full-speed
> descriptors. The endpoint is then successfully enabled via
> usb_ep_enable(), and epfile->ep becomes valid.
> 
> However, when user space subsequently issues the FUNCTIONFS_ENDPOINT_DESC
> ioctl to query the endpoint descriptor, ffs_epfile_ioctl() selects the
> descriptor index solely based on gadget->speed:
> 
> 	switch (epfile->ffs->gadget->speed) {
> 	case USB_SPEED_SUPER:
> 	case USB_SPEED_SUPER_PLUS:
> 		desc_idx = 2;
> 		break;
> 	case USB_SPEED_HIGH:
> 		desc_idx = 1;
> 		break;
> 	default:
> 		desc_idx = 0;
> 	}
> 	desc = epfile->ep->descs[desc_idx];
> 	memcpy(&desc1, desc, desc->bLength);
> 
> Because user space only supplied full-speed descriptors,
> epfile->ep->descs[1] is NULL. Dereferencing desc->bLength triggers an
> immediate kernel NULL pointer dereference panic.
> 
> Fix this by falling back through lower speed descriptors if the current
> speed descriptor was not supplied, matching the fallback logic in
> config_ep_by_speed() and historical f_fs behavior. If still missing,
> fall back to epfile->ep->ep->desc (the active descriptor), and return
> -EINVAL safely if no valid descriptor is found. In addition, mark desc
> as const to match struct usb_ep::desc and avoid discarding qualifiers.
> 
> Fixes: c559a3534109 ("usb: gadget: f_fs: add ioctl returning ep descriptor")
> Cc: stable@vger.kernel.org
> Signed-off-by: zjamg <ndaugoing@gmail.com>
> ---
>  drivers/usb/gadget/function/f_fs.c | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
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

- It looks like you did not use your "real" name for the patch on either
  the Signed-off-by: line, or the From: line (both of which have to
  match).  Please read the kernel file,
  Documentation/process/submitting-patches.rst for how to do this
  correctly.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
