Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7C61EADC
	for <stable@vger.kernel.org>; Fri, 19 Jun 2026 19:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781898400; cv=none; b=bZ0rpXVpk0SIziukSLpV1RmTzhBQcZRwiU0ahGsfenfStleZe1Cf5HJMxRP9yVRhuvyf43A9lgjkVdBzzD23EpbfeF84w8Kva3Wx0SEKG5rnXLPUo/LmBKA+Jg0xfaUSWDVov4N0rlx/hcB3YsOfBWRGv+aEai58TyW1UKSCMRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781898400; c=relaxed/simple;
	bh=Ak8KaVYAdNCM7uKimDwuwsEeEDofSny7sAcpzlfK4UY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pBHnb070ZrkhhmXZGfYsxPRux1ni0BoN7pz6HgMClNYloXMv2cCJ9a4Ju6H2kxBfApykR/JBcHplNANLLYEQeUu2Tn8uM5yQjimeVUkQMgJH/ZZ5TXcS7+sT7RCEBpqa6e0duoLNMMB903BmdVvqVjeEhVsW1dD9aTDPl9ZMuo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=rDZESBX0; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="rDZESBX0"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-519eedc30a3so10054701cf.1
        for <stable@vger.kernel.org>; Fri, 19 Jun 2026 12:46:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1781898393; x=1782503193; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=X6gTumD1afmt47+eQHNq2xIZFcuee6vcKia2u6xIXfs=;
        b=rDZESBX0DrLOIqna8imPexW95HanL4g9euTnNj9pPe/NsLVfMuug9tY5C31VmOqxzR
         97nqPohGBaYm5H//KvrMzw18siSrJYv2Frhk9okhFo44YrftBYzZQM5CxZXBUAYsOoel
         Rci9paFPHwkeZ5E/1VgvzYzntkKOieWseY77eghR0Ws6Dpz/qN6pGSYAnNLJ2JeT9qep
         mTVcWZiddBucwYMIQ0mg6XrybXcGlTStOcq1XeGp/2NSGYya6w30FIQqxWl6udEKLJ33
         PXcoXDxdhKCdTg6NKo5t8E1mHjzRMGmTax2791utvP+tVA/UNdDT9Vsev+OLU8FbpjAj
         G/rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781898393; x=1782503193;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X6gTumD1afmt47+eQHNq2xIZFcuee6vcKia2u6xIXfs=;
        b=k16JzeXOqKrlEmn3iPzXyZk02NDj7xveFFe6f3/bhS/KkHQoABTjj/Dr8huNT0nx1+
         gwaWduohCjMdfPrFImIyvHZ5NIRaREpy2HH6Yta4UAcVErRsP4DkwWdpKM/07NFWqYSd
         0wAQJxcQZigAaFZ5uCZCUY2iPtGESNG+0qp+BIfFMJP9jUahtoHFwYSlFey2pSX3jMVD
         3+nyaBLM1Y52YIn3OGPZ5xDXhSK8GrqrZa9t2C35hgnXB1YhdC2pUIgxfioc6tN8p4i/
         3a1w6ZBzCgqqo/Ls+YwuMIEhEUk3K9Dcz/pk1hF9FEcbOKTSYWK9K/o5wdfplU3+BozF
         t7Kg==
X-Forwarded-Encrypted: i=1; AFNElJ+AnY+o0AJE+sozHJicWmmRttoWuM1RqnRs9s5zFDeC0L2HUREEYKqJhuSTBlMje9hk8BrlW0s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsaxX7aQ1zg0Jrdzvy5GjG2jbGsjb0xAJF/pNTuiQZF8kv7gfQ
	AmydU5jB0W1sl0YcuIYgr+r/zgGdsWckNX6evi3d7fb9K3NiA6NHy0Vqm8ZZnCrccA==
X-Gm-Gg: AfdE7ckcOOj4OV0XR8ksHdtgX7G1Dwjwq1xdIYpoc2HK7bLpBFYUzCbXhfNLRQgDP8L
	6fNaZ08vfs8JE7qJUqMp9HcYbACs0H9+qUUJ1rdSAQnaqx4hvwvY40/N76AZOEwf97dc/xhy28c
	XVMnIy9NZHfNiHjgKDzfK7NIn2Agp8KZ0kDVrsDLlwg5opq5wz9Se8wAyj8TQ3La5N/ERkQJHj2
	5Q+ahj9OX53E3iWXLuhzEud0Yk2LVeVgmWKqDIxYQOp1N2NFX6dO8l9rYziJnZQrzMj6p0jdBRb
	4TVb8nGyVPJqQtrcaCqns4h6V5/O3aCH7pXGzqoeU/slmGw851lTZojxgElWPDC5GtiXQP9/4h6
	ja2/CdqYALBdXOwviKKsw+3jT+zsKURuc+uCNOp39TQA8GqqKCqI8hr3MxRpe5RGpEsxN3MjZhb
	+MDCw6nda3LnvMemNCKbE6ReRy9NZrkk3T
X-Received: by 2002:a05:622a:651:b0:517:9e57:c681 with SMTP id d75a77b69052e-519e4de8800mr73003911cf.53.1781898392539;
        Fri, 19 Jun 2026 12:46:32 -0700 (PDT)
Received: from rowland.harvard.edu ([2601:19b:d01:d210:d62f:1911:f952:16ba])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8df81cdf302sm10419126d6.30.2026.06.19.12.46.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2026 12:46:31 -0700 (PDT)
Date: Fri, 19 Jun 2026 15:46:29 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: Nikhil Solanke <nikhilsolanke5@gmail.com>
Cc: linux-usb@vger.kernel.org, gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org, michal.pecio@gmail.com,
	stable@vger.kernel.org
Subject: Re: [PATCH] usbcore: Add quirk for 255-bytes initial config read
Message-ID: <8175e40d-357a-4513-b827-752f679e9904@rowland.harvard.edu>
References: <20260619095936.24080-1-nikhilsolanke5@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260619095936.24080-1-nikhilsolanke5@gmail.com>

On Fri, Jun 19, 2026 at 03:29:36PM +0530, Nikhil Solanke wrote:
> Certain third-party USB game controllers exposing (or spoofing) an Xbox
> 360-compatible interface (VID:PID 045e:028e) fail to enumerate under Linux.
> The device disconnects from the bus without responding to the initial
> GET_DESCRIPTOR(CONFIGURATION) request, and the kernel logs 'unable to read
> config index 0 descriptor/start: -71'.
> 
> The device then falls back to a secondary Android HID mode (with a
> different VID:PID), losing XInput functionality including rumble support.
> The failure reproduces across multiple machines, host controller types, and
> kernel versions including current mainline and LTS. The device enumerates
> correctly and remains in XInput mode under Windows. Notably, the device
> enumerates correctly in Android mode when the same aklsjdasd 9-byte request
> is issued for that mode's configuration descriptor, confirming the firmware
> bug is specific to the XInput mode.
> 
> usbmon traces from Linux and Wireshark/USBPcap traces from Windows are
> identical up to the point of failure, with no visible protocol-level
> difference explaining the divergence. The root cause was identified when
> Michal Pecio discovered via a QEMU bus-level capture that Windows does not
> use wLength=9 for the initial config descriptor request; it uses
> wLength=255. This is not visible in Windows Wireshark/USBPcap traces
> because Windows routes enumeration-phase traffic to sniffers only after
> initialization completes. Alan Stern subsequently confirmed this with a bus
> analyzer on a different USB 2.0 device, and Michal verified the behavior
> goes back to Windows 95 OSR2.1.
> 
> So, add a new quirk flag USB_QUIRK_CONFIG_SIZE which causes
> usb_get_configuration() to issue a 255 byte sized configuration request
> instead of USB_DT_CONFIG_SIZE (9) for the initial
> GET_DESCRIPTOR(CONFIGURATION) request, mimicking long-standing Windows
> behavior.
> 
> Suggested-by: Nikhil Solanke <nikhilsolanke5@gmail.com>

You don't need Suggested-by here.  It's redundant; we always assume that 
people are responsible for authorship of the patches they write and 
submit, unless they say otherwise.

> Suggested-by: Alan Stern <stern@rowland.harvard.edu>
> Suggested-by: Michal Pecio <michal.pecio@gmail.com>
> Closes: https://lore.kernel.org/linux-usb/CAFgddh+JWdT4LLwMc5qjM8q_pBu-fRo2qADR5ovAKoGHWMQrRw@mail.gmail.com/
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: <stable@vger.kernel.org>
> 
> Signed-off-by: Nikhil Solanke <nikhilsolanke5@gmail.com>
> ---
>  drivers/usb/core/config.c  | 56 +++++++++++++++++++++++++++-----------
>  drivers/usb/core/quirks.c  |  3 ++
>  include/linux/usb/quirks.h |  4 +++
>  3 files changed, 47 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/usb/core/config.c b/drivers/usb/core/config.c
> index 45e20c6d76c0..623425cef085 100644
> --- a/drivers/usb/core/config.c
> +++ b/drivers/usb/core/config.c
> @@ -912,6 +912,8 @@ int usb_get_configuration(struct usb_device *dev)
>  	unsigned char *bigbuffer;
>  	struct usb_config_descriptor *desc;
>  	int result;
> +	size_t usb_dt_config_size = (dev->quirks & USB_QUIRK_CONFIG_SIZE)
> +		? USB_DT_CONFIG_SIZE_QUIRK : USB_DT_CONFIG_SIZE;

I wouldn't call the variable usb_dt_config_size.  It isn't always the 
size of a USB configuration descriptor; it isn't even always the size 
you expect for the response.  Rather, it is the size you intend to ask 
for.

>  
>  	if (ncfg > USB_MAXCONFIG) {
>  		dev_notice(ddev, "too many configurations: %d, "
> @@ -938,7 +940,8 @@ int usb_get_configuration(struct usb_device *dev)
>  	if (!dev->rawdescriptors)
>  		return -ENOMEM;
>  
> -	desc = kmalloc(USB_DT_CONFIG_SIZE, GFP_KERNEL);
> +	desc = kmalloc(usb_dt_config_size, GFP_KERNEL);
> +
>  	if (!desc)
>  		return -ENOMEM;
>  
> @@ -946,7 +949,7 @@ int usb_get_configuration(struct usb_device *dev)
>  		/* We grab just the first descriptor so we know how long
>  		 * the whole configuration is */

This comment is now out of date.  It should be rewritten to explain why 
the quirk does and why.

>  		result = usb_get_descriptor(dev, USB_DT_CONFIG, cfgno,
> -		    desc, USB_DT_CONFIG_SIZE);
> +		    desc, usb_dt_config_size);
>  		if (result < 0) {
>  			dev_err(ddev, "unable to read config index %d "
>  			    "descriptor/%s: %d\n", cfgno, "start", result);
> @@ -957,26 +960,39 @@ int usb_get_configuration(struct usb_device *dev)
>  			break;
>  		} else if (result < 4) {
>  			dev_err(ddev, "config index %d descriptor too short "
> -			    "(expected %i, got %i)\n", cfgno,
> -			    USB_DT_CONFIG_SIZE, result);
> +			    "(expected %zu, got %i)\n", cfgno,

Likewise, "expected" here is wrong.  It should be "asked for" or 
something like that.

> +			    usb_dt_config_size, result);
>  			result = -EINVAL;
>  			goto err;
>  		}
> -		length = max_t(int, le16_to_cpu(desc->wTotalLength),
> -		    USB_DT_CONFIG_SIZE);
> +		/* If the device does returns the full length configuration
> +		 * descriptor, skip the second read. Fallback to default
> +		 * behavior otherwise.
> +		 */

New multiline comments (or ones that are rewritten) should use the same 
format as the rest of the USB stack:

	/*
	 * Blah, blah, blah
	 * Blah, blah, blah
	 */

> +		if (dev->quirks & USB_QUIRK_CONFIG_SIZE
> +				&& result == le16_to_cpu(desc->wTotalLength)
> +				&& result < USB_DT_CONFIG_SIZE_QUIRK) {

Whether the quirk flag is set doesn't matter.  All you care about is 
whether the information received earlier contains the entire descriptor 
set.  The first and third tests here should be removed.

There is some question about what to do if wTotalLength < result.  My 
advice is to use the smaller value in this case, but not smaller than 
USB_DT_CONFIG_SIZE.

>  
> -		/* Now that we know the length, get the whole thing */
> -		bigbuffer = kmalloc(length, GFP_KERNEL);
> -		if (!bigbuffer) {
> -			result = -ENOMEM;
> -			goto err;
> -		}
> +			bigbuffer = (unsigned char *) desc;
> +			desc = NULL;
> +			length = result;

Don't keep the entire 255-byte buffer.  Use krealloc() to shrink the 
buffer down to the right size.

> +		} else {
> +			length = max_t(int, le16_to_cpu(desc->wTotalLength),
> +			    usb_dt_config_size);
> +
> +			/* Now that we know the length, get the whole thing */
> +			bigbuffer = kmalloc(length, GFP_KERNEL);
> +			if (!bigbuffer) {
> +				result = -ENOMEM;
> +				goto err;
> +			}
>  
> -		if (dev->quirks & USB_QUIRK_DELAY_INIT)
> -			msleep(200);
> +			if (dev->quirks & USB_QUIRK_DELAY_INIT)
> +				msleep(200);
>  
> -		result = usb_get_descriptor(dev, USB_DT_CONFIG, cfgno,
> -		    bigbuffer, length);
> +			result = usb_get_descriptor(dev, USB_DT_CONFIG, cfgno,
> +			    bigbuffer, length);
> +		}
>  		if (result < 0) {
>  			dev_err(ddev, "unable to read config index %d "
>  			    "descriptor/%s\n", cfgno, "all");
> @@ -1000,6 +1016,14 @@ int usb_get_configuration(struct usb_device *dev)
>  	}
>  
>  err:
> +	/* Log failed device's VID:PID pair to make it easy to debug and fix
> +	 * enumeration and initialization issues
> +	 */
> +	if (result < 0) {
> +		dev_err(ddev, "Failed to initialize device %04x:%04x due to above errors.",

The "due to above errors" part isn't needed, since the errors will be 
obvious in the kernel log.  In fact, it probably would be better not to 
put this information here at all but instead modify the error message in 
usb_enumerate_device() (the caller).

> +		    le16_to_cpu(dev->descriptor.idVendor), le16_to_cpu(dev->descriptor.idProduct));
> +	}
> +
>  	kfree(desc);
>  	dev->descriptor.bNumConfigurations = cfgno;
>  
> diff --git a/drivers/usb/core/quirks.c b/drivers/usb/core/quirks.c
> index 87810eff974e..92219684a604 100644
> --- a/drivers/usb/core/quirks.c
> +++ b/drivers/usb/core/quirks.c
> @@ -142,6 +142,9 @@ static int quirks_param_set(const char *value, const struct kernel_param *kp)
>  				break;
>  			case 'q':
>  				flags |= USB_QUIRK_FORCE_ONE_CONFIG;
> +				break;
> +			case 'r':
> +				flags |= USB_QUIRK_CONFIG_SIZE;

For good style, there should be a "break" statement here.

Also, you need to document the new flag under the usbcore.quirks entry 
in Documentation/admin-guide/kernel-parameters.txt.

>  			/* Ignore unrecognized flag characters */
>  			}
>  		}
> diff --git a/include/linux/usb/quirks.h b/include/linux/usb/quirks.h
> index b3cc7beab4a3..f864571da870 100644
> --- a/include/linux/usb/quirks.h
> +++ b/include/linux/usb/quirks.h
> @@ -81,4 +81,8 @@
>  /* Device claims zero configurations, forcing to 1 */
>  #define USB_QUIRK_FORCE_ONE_CONFIG		BIT(18)
>  
> +/* Use a 255 byte sized config descriptor request */
> +#define USB_QUIRK_CONFIG_SIZE			BIT(19)
> +#define USB_DT_CONFIG_SIZE_QUIRK		255

Again, I don't like this name.  It's not a quirk in the size of the 
configuration descriptor type, which is what "USB_DT_CONFIG_SIZE" stands 
for; it's a quirk in the way the kernel asks for config descriptors.  
(Or in what size request the device will accept, if you prefer.)

And the 255 value doesn't belong in this header file anyway.  It should 
be defined in config.c since that's the only place it gets used.

Alan Stern

> +
>  #endif /* __LINUX_USB_QUIRKS_H */
> -- 
> 2.54.0
> 
