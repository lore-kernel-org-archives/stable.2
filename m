Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9095E38E8A6;
	Thu,  6 Aug 2026 05:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785994086; cv=none; b=jGtprNkEj8NJkLJ4ahF0F54tvXqmtFoegW/7X2XNTmr5w8X60lujgrln2rsM0g9vsrV2Dpr3taeX69i0xZ8zWUtJGa9bF85SVG9yBii3zQgLDQIcDWf0Bzi6eUooFHk4YTl3ZufgdwqIb1WGoNpqninQNfxGgFhuQGDVS8AdVPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785994086; c=relaxed/simple;
	bh=OU5A0sN8OuZjUv3oDw1TgFBNrodpSWhgq2aT0BXm1rE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ojgcdwxUFlP0wiaXg2Z/isdw3YXItZ+p8Oe2GdJM3cOVZk51pDhqj/n8SDIOvMqaF6tEEvmImM20hHUY/d58lVBdRQwE+DsRaO08NQEJgOZjELE25TGWvk4kRj28YjkjelxQCSG3sdJUPVjPjZrmzYyihFUxExRx1UslTveCm7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UoM2RbY3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UoM2RbY3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CE761F00A3A;
	Thu,  6 Aug 2026 05:28:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785994084;
	bh=7QsdJcYMMjPeyIPN7IrpdG6mTl4fy8+Im/jD6iCt+A4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=UoM2RbY39sexrlwaXFxn0Aj+HKByaBTOHpnWnf2xWkB/ew2WxKDM2FrMxQSyjfsFu
	 iAaHhuPHTTIIovstodNllKbVcEvITTFVXPLl3an9t4MFbjFBp6AOdoXRAg2/u9VHC5
	 kGv2jVwTC6hDGGIdgkcq51be9STpwMKiBZBLgQc4=
Date: Thu, 6 Aug 2026 07:27:46 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Jeffin Philip <jeffinphilip14@gmail.com>
Cc: linux-usb@vger.kernel.org, valentina.manea.m@gmail.com,
	shuah@kernel.org, i@zenithal.me, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	syzbot+af76b01c9a0f0ab60fb0@syzkaller.appspotmail.com
Subject: Re: [PATCH] usbip: usbip_host: Fix null pointer dereference in
 rebind_store
Message-ID: <2026080602-estrogen-dry-f499@gregkh>
References: <20260806051726.24343-1-jeffinphilip14@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260806051726.24343-1-jeffinphilip14@gmail.com>

On Thu, Aug 06, 2026 at 10:47:26AM +0530, Jeffin Philip wrote:
> rebind_store calls do_rebind which dereferences udev without
> checking if it is NULL. If busid is registered using match_busid
> but the device is not present in the first place, it triggers a
> null pointer dereference when we attempt to rebind the device.
> Fix this by checking explicitly for udev first and returning
> -ENODEV if udev is NULL.
> 
> Reported-by: syzbot+af76b01c9a0f0ab60fb0@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=af76b01c9a0f0ab60fb0
> Fixes: 4bfb141bc013 ("usbip: usbip_host: fix to hold parent lock for device_attach() calls")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jeffin Philip <jeffinphilip14@gmail.com>
> ---
>  drivers/usb/usbip/stub_main.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/usb/usbip/stub_main.c b/drivers/usb/usbip/stub_main.c
> index 79110a69d697..dfaedecedb81 100644
> --- a/drivers/usb/usbip/stub_main.c
> +++ b/drivers/usb/usbip/stub_main.c
> @@ -256,6 +256,11 @@ static ssize_t rebind_store(struct device_driver *dev, const char *buf,
>  	if (!bid)
>  		return -ENODEV;
>  
> +	if (!bid->udev) {
> +		put_busid_priv(bid);
> +		return -ENODEV;
> +	}

What prevents bid->udev from becoming NULL right after you checked this?

How was this tested?

thanks,

greg k-h
