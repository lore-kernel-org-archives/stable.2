Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D49E427A05
	for <stable@vger.kernel.org>; Mon, 20 Jul 2026 16:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784563472; cv=none; b=X/ihZIoNP1eL7EckvSJSPVJSVl/Hlee/7FpD+0gqD/KPzltw/hCdnJmUYCROdxWOP0vNYxdVusMHZ1mMdh/8JwMiXRo2vZjHCqctTDXvePU3wp3pxUdGrYiM5LCor40Tgc3Q/VZzVD7yHens0IyKmktgNbdSb9fUpqAowbUgETA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784563472; c=relaxed/simple;
	bh=+qTmfzHzKgZXFKCtnjQEa7gvZQKtdktlmWhJSmYTJ8c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mtvv1ueXnBuE4XbQk7vNQuuLtAUS9EfrygflggyvjclEZpP9BkLQw2K/aVQbaWy00AyAzepauW3J4iibPjXc2MDJUgo3rGcINmu4YI9J/U+JORoH80w5wlrUCqAD5dJXFsmkxkIkmGfbBlPN0i3qT/rFBBcT6bwN3I/RKJz4+CI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=vDHhJJ8U; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="vDHhJJ8U"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-51c0cea8883so48260491cf.1
        for <stable@vger.kernel.org>; Mon, 20 Jul 2026 09:04:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1784563469; x=1785168269; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=pRDup4IApSPObs0d76X/agqpGSU9Wb191kX+rVPp5VA=;
        b=vDHhJJ8U/eGnHCju/2g8I6RWbjIqOBzooig18e4keQUxvGtul9STJq3Ar9ZuE9SJ/M
         JoeqLDKWoACt82iXwDnjfsJKRJBj3yfrWYcZXmZVEaFy17bZPHvxB7sR6DOQXsTxDsvv
         NQHxjla6/b+ESClGr8XNEOSDIGclYIeNGepycCSgVu0gSU7aPtDI8V02HPEgI3C4fKLA
         nEIn296czenH6hClFflKwiXOf1LXt5ETguz5GGl9bvcKBFFlKaIYZU/p3SyaCQt8JTg8
         9Px8UTpP0GOhxwUyvoJau/erz2p9LYcrEuK2nLdsvnYhKD3Neenk9bdCtVDa9OcTVPXU
         Ux1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784563469; x=1785168269;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pRDup4IApSPObs0d76X/agqpGSU9Wb191kX+rVPp5VA=;
        b=Rdc+EHtFDCjM0Y3LH9VGFA/Vlp/a0IiKRYPNE0FbKPHSrgqbPwEDzGazb5owhrl7s1
         icgQEBoB9tD56YMeIOQSi6ZFlnOyh3ZxHCIvJKVfc1qlQ2xv/wgKl+Uti4F2cV9mg/Wm
         d/WzusxFS1iaCkkc3q3gMpJzoR6lt08Btq/0f85bR+i1I0IkfICNAIAvYeK+c/cA9qjX
         iF0Y6dG2lYGDo4vezyIMNOK3QQ9CAQoKlAkP2IKDnQGH8zl/Oski9PXCUDkTjJJI3SnV
         qqaGE+L3B1zZEqSQ8O9o5RfEEKx5Ml2j7H8GUNHrD3HczBNOuGq6i6HCKxbqT5Tb0ryG
         ZTOg==
X-Forwarded-Encrypted: i=1; AHgh+Rp+o4lPNUn/JkFtLd98LmufSV1Ui+GPNDpK4TrvjGfSFOmiR66JaxgDrcglwpgJkj9Lsc1K8SY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFPgPmZKeguAaz4x9ZNV3E6BfEFX1zfeyBXGgvFrnwJQqI3hEJ
	9mN768oJ2Zg7om+UuPM5XSiA4nS6uomUBp7eQfs95BKNV62WzwY2g0aKq7sJi/CkwA==
X-Gm-Gg: AfdE7cm2jqXqWMv+zl3IyYBur/N14xKO3bFl6g2RVmYcwEgbh63y6K7/XCcpQ1FwZMH
	IM2FnVjBlnhscxtghXDvU3LCy6kRLrLAWrXPHV3E1pwJDX4RvhBu/QoPfknz6YrnIdfo9alyep/
	A8AKLxNaZmIpmLkSE0wDJW5cxFLeFDk2XvF7Pc5n8Zi6Ajn+7lObgCeDYy8xv66/QsKXNrKd4vQ
	TEACWkiWK89wxax1/MfX3A6j63gwysMuxToA9FWJDR3ofDns/rf+/AYJepYFyrdAdris1U7EMO7
	82Ae+IUN8vQBR7W3d2ES8FCs+vGm2rgJ4A0rZp8YW7T95hmGUzahwMCcTFiIcUPCGkQ5JZ3e/Ey
	TPHt3FOGdff7AzhwsxqXtMDfozGuPffwu9I3ukreieGaJBG9ILb1ahTaBQ55ia52DnYqkMuukNJ
	6v7E0Ul/Fc97WPnEPKxIaRRlKKpiK3tUrsraMMGbkBdWvbmg==
X-Received: by 2002:ac8:7f8b:0:b0:517:5f04:f23f with SMTP id d75a77b69052e-521298a8a73mr142534011cf.4.1784563469002;
        Mon, 20 Jul 2026 09:04:29 -0700 (PDT)
Received: from rowland.harvard.edu ([2607:fb60:1011:2006:2008:aeb7:73d7:d8ff])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-521502b92acsm81123961cf.30.2026.07.20.09.04.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 09:04:28 -0700 (PDT)
Date: Mon, 20 Jul 2026 12:04:25 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: Charles Daoust <charles.daoust@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] usb: core: add USB_QUIRK_CONFIG_DESC_READ_255 for Razer
 BlackShark V3 Pro
Message-ID: <2a80e88e-936d-4927-a915-352fe92e47df@rowland.harvard.edu>
References: <20260720150207.1963786-1-charles.daoust@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260720150207.1963786-1-charles.daoust@gmail.com>

On Mon, Jul 20, 2026 at 11:01:26AM -0400, Charles Daoust wrote:
> From: Charles D'Aoust <charles.daoust@gmail.com>
> 
> The Razer BlackShark V3 Pro wireless headset dongle (1532:0577)
> fingerprints its host during the first enumeration after power-on: if
> the first GET_DESCRIPTOR(CONFIGURATION) request asks for 255 bytes, as
> Windows does, the dongle enables its vendor HID command channel; if it
> sees the 9-byte header-only read that Linux issues, it disables that
> channel for the rest of the power session.  Audio still works in that
> state, but battery reporting and all vendor commands are silently
> ignored, and nothing short of removing power recovers the device:
> resets, re-enumerations and byte-exact replays of complete Windows
> control sessions were all verified not to help.
> 
> Both read lengths are spec-compliant (the device truncates the reply
> to wLength); the firmware was evidently only validated against the
> larger request.  The kernel already accommodates this class of
> firmware assumption during enumeration: hub_port_init() reads the
> device descriptor with a 64-byte request because that is what Windows
> does and what many devices expect.
> 
> Add USB_QUIRK_CONFIG_DESC_READ_255, which makes usb_get_configuration()
> request 255 bytes for the initial configuration descriptor read rather
> than USB_DT_CONFIG_SIZE, apply it to 1532:0577, and expose it as
> runtime quirk letter 'r'.  Devices without the quirk are unaffected.
> 
> The trigger was isolated by single-variable bisection on otherwise
> unmodified kernels: with only the widened initial read, the dongle's
> vendor channel comes up enabled on a cold plug with no interface
> drivers bound (bare enumeration only); without it, it never does.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Charles D'Aoust <charles.daoust@gmail.com>
> ---

Is this not the same as

https://lore.kernel.org/linux-usb/20260717195336.98500-2-nikhilsolanke5@gmail.com/

?

Alan Stern

>  Documentation/admin-guide/kernel-parameters.txt |  3 +++
>  drivers/usb/core/config.c                       | 13 ++++++++++---
>  drivers/usb/core/quirks.c                       |  6 ++++++
>  include/linux/usb/quirks.h                      |  3 +++
>  4 files changed, 22 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index b5493a7f8..1bd138ba6 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -8169,6 +8169,9 @@ Kernel parameters
>  				q = USB_QUIRK_FORCE_ONE_CONFIG (Device
>  					claims zero configurations,
>  					forcing to 1);
> +				r = USB_QUIRK_CONFIG_DESC_READ_255 (initial
> +					configuration descriptor read must
> +					request 255 bytes, as Windows does);
>  			Example: quirks=0781:5580:bk,0a5c:5834:gij
>  
>  	usbhid.mousepoll=
> diff --git a/drivers/usb/core/config.c b/drivers/usb/core/config.c
> index cd3231d21..c7e21cc76 100644
> --- a/drivers/usb/core/config.c
> +++ b/drivers/usb/core/config.c
> @@ -908,7 +908,7 @@ int usb_get_configuration(struct usb_device *dev)
>  {
>  	struct device *ddev = &dev->dev;
>  	int ncfg = dev->descriptor.bNumConfigurations;
> -	unsigned int cfgno, length;
> +	unsigned int cfgno, length, first_read_len;
>  	unsigned char *bigbuffer;
>  	struct usb_config_descriptor *desc;
>  	int result;
> @@ -938,7 +938,14 @@ int usb_get_configuration(struct usb_device *dev)
>  	if (!dev->rawdescriptors)
>  		return -ENOMEM;
>  
> -	desc = kmalloc(USB_DT_CONFIG_SIZE, GFP_KERNEL);
> +	/*
> +	 * Some devices (see USB_QUIRK_CONFIG_DESC_READ_255) malfunction unless
> +	 * the initial configuration descriptor read requests 255 bytes, as
> +	 * Windows does.  Only the header is consumed here either way.
> +	 */
> +	first_read_len = (dev->quirks & USB_QUIRK_CONFIG_DESC_READ_255) ?
> +			 255 : USB_DT_CONFIG_SIZE;
> +	desc = kmalloc(first_read_len, GFP_KERNEL);
>  	if (!desc)
>  		return -ENOMEM;
>  
> @@ -946,7 +953,7 @@ int usb_get_configuration(struct usb_device *dev)
>  		/* We grab just the first descriptor so we know how long
>  		 * the whole configuration is */
>  		result = usb_get_descriptor(dev, USB_DT_CONFIG, cfgno,
> -		    desc, USB_DT_CONFIG_SIZE);
> +		    desc, first_read_len);
>  		if (result < 0) {
>  			dev_err(ddev, "unable to read config index %d "
>  			    "descriptor/%s: %d\n", cfgno, "start", result);
> diff --git a/drivers/usb/core/quirks.c b/drivers/usb/core/quirks.c
> index 87ee2d938..c8f71b825 100644
> --- a/drivers/usb/core/quirks.c
> +++ b/drivers/usb/core/quirks.c
> @@ -142,6 +142,9 @@ static int quirks_param_set(const char *value, const struct kernel_param *kp)
>  				break;
>  			case 'q':
>  				flags |= USB_QUIRK_FORCE_ONE_CONFIG;
> +				break;
> +			case 'r':
> +				flags |= USB_QUIRK_CONFIG_DESC_READ_255;
>  			/* Ignore unrecognized flag characters */
>  			}
>  		}
> @@ -496,6 +499,9 @@ static const struct usb_device_id usb_quirk_list[] = {
>  	/* Razer - Razer Blade Keyboard */
>  	{ USB_DEVICE(0x1532, 0x0116), .driver_info =
>  			USB_QUIRK_LINEAR_UFRAME_INTR_BINTERVAL },
> +	/* Razer - Razer BlackShark V3 Pro wireless headset dongle */
> +	{ USB_DEVICE(0x1532, 0x0577), .driver_info =
> +			USB_QUIRK_CONFIG_DESC_READ_255 },
>  	/* Razer - Razer Kiyo Pro Webcam */
>  	{ USB_DEVICE(0x1532, 0x0e05), .driver_info = USB_QUIRK_NO_LPM },
>  
> diff --git a/include/linux/usb/quirks.h b/include/linux/usb/quirks.h
> index b3cc7beab..02de5ed48 100644
> --- a/include/linux/usb/quirks.h
> +++ b/include/linux/usb/quirks.h
> @@ -81,4 +81,7 @@
>  /* Device claims zero configurations, forcing to 1 */
>  #define USB_QUIRK_FORCE_ONE_CONFIG		BIT(18)
>  
> +/* initial configuration descriptor read must request 255 bytes (Windows) */
> +#define USB_QUIRK_CONFIG_DESC_READ_255		BIT(19)
> +
>  #endif /* __LINUX_USB_QUIRKS_H */
> -- 
> 2.55.0
> 
> 
