Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 083CB3C1F4F;
	Wed,  1 Jul 2026 10:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782901546; cv=none; b=UAIzyZKYh7Tb3u0qpo2mCxQU1Wj/D6C4A2h/Tl2B48kBWHU28LR+804DjWTkgTdscm9d3tgI6OWaERUJIMvyGQ7hr6c/gpAkxE6gOWbnC0Xd73eB3RNREv3EhCKxMLt3aoxJFKVDFpmkvN8EjGBZvyJ04dCIHMY8z2JsJ1qFX/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782901546; c=relaxed/simple;
	bh=Zwc9OT/HbVqiv11orN2n3ee5JLDvtSqQAS3sCwyTy9Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H1d0VzUncKzOdYci5HIsR1qiXH03FLihnyGz9cmL47voEzZpJ8K9OrGJbb+8KEzg6Kd+dzPT5uDIUu3Hq0h/kdcK71pWsMHRXwivP+IOmPg0P2PrQoTFUFR5sfpAqjg+B49SIPmCTehzFJO34R7W+2je2Thc4O2QSeckTyAg9vM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xQYCJa2D; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xQYCJa2D"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E19651F000E9;
	Wed,  1 Jul 2026 10:25:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1782901543;
	bh=C7zV9GY5gNgVzaxV40iTUoOhY2WdnX6qR6DXnDytM3M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=xQYCJa2DhvX/A6yxHv39gzCJRtVZnl0a04+q597TLj/SC1dpHcW7ryGrUdMXaiGo2
	 YXZj6qkgHJtzTDYJPZYRRyF/nYGz3G//EmtWYW6f9YVJIXR9lju6Klg4JlqjAUFait
	 L7vm+/Qmhvey2YRW/sqxTJfT+QFHy28nPYOn7LtA=
Date: Wed, 1 Jul 2026 12:25:40 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Sascha Grunert <sgrunert@redhat.com>
Cc: linux-usb@vger.kernel.org, valentina.manea.m@gmail.com,
	shuah@kernel.org, i@zenithal.me, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 2/2] usbip: block SET_INTERFACE for isoc alt settings
Message-ID: <2026070107-estrogen-semantic-31a4@gregkh>
References: <20260701101826.894848-1-sgrunert@redhat.com>
 <20260701101826.894848-3-sgrunert@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260701101826.894848-3-sgrunert@redhat.com>

On Wed, Jul 01, 2026 at 12:18:26PM +0200, Sascha Grunert wrote:
> USB/IP cannot forward isochronous transfers. When the client activates
> an alt setting with isoc endpoints, the transfers fail with -EPROTO and
> the resulting usb_clear_halt cascade disconnects the device.
> 
> Intercept SET_INTERFACE in tweak_set_interface_cmd() and fake success
> when the target alt setting contains isoc endpoints, keeping the device
> at alt 0.
> 
> Tested with a Turtle Beach Velocity One Flight yoke (10f5:7001)
> forwarded to a VM via USB/IP, which previously disconnect-looped every
> few seconds and now stays connected.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Sascha Grunert <sgrunert@redhat.com>

What commit id does this fix?

> ---
>  drivers/usb/usbip/stub_rx.c | 36 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 36 insertions(+)
> 
> diff --git a/drivers/usb/usbip/stub_rx.c b/drivers/usb/usbip/stub_rx.c
> index d0e3d3f..f323b48 100644
> --- a/drivers/usb/usbip/stub_rx.c
> +++ b/drivers/usb/usbip/stub_rx.c
> @@ -100,6 +100,28 @@ static int tweak_clear_halt_cmd(struct urb *urb)
>  	return ret;
>  }
>  
> +static bool altsetting_has_isoc(struct usb_device *udev, __u16 interface,
> +				__u16 alternate)
> +{
> +	struct usb_interface *intf;
> +	struct usb_host_interface *alt;
> +	int i;
> +
> +	intf = usb_ifnum_to_if(udev, interface);
> +	if (!intf)
> +		return false;
> +
> +	alt = usb_altnum_to_altsetting(intf, alternate);
> +	if (!alt)
> +		return false;
> +
> +	for (i = 0; i < alt->desc.bNumEndpoints; i++) {
> +		if (usb_endpoint_xfer_isoc(&alt->endpoint[i].desc))
> +			return true;
> +	}
> +	return false;
> +}
> +
>  static int tweak_set_interface_cmd(struct urb *urb)
>  {
>  	struct usb_ctrlrequest *req;
> @@ -111,6 +133,20 @@ static int tweak_set_interface_cmd(struct urb *urb)
>  	alternate = le16_to_cpu(req->wValue);
>  	interface = le16_to_cpu(req->wIndex);
>  
> +	/*
> +	 * USB/IP cannot forward isochronous transfers.  If the requested
> +	 * alt setting activates isochronous endpoints, pretend the switch
> +	 * succeeded without touching the device.  This prevents the
> +	 * cascade of failed isoc URBs that leads to a device disconnect.
> +	 */
> +	if (alternate != 0 && altsetting_has_isoc(urb->dev, interface,
> +						  alternate)) {
> +		dev_info(&urb->dev->dev,
> +			 "usb_set_interface blocked: inf %u alt %u (isoc)\n",
> +			 interface, alternate);

Why is this not an error?  And if a user sees this, what can they do
about it?

> +		return 0;

Why isn't this an error?

thanks,

greg k-h
