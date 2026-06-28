Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C89DF35F5FB
	for <stable@vger.kernel.org>; Sun, 28 Jun 2026 21:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782681401; cv=none; b=PU5/TxAaEO9CpLngvk/2eRx3g37yy0MyH6p1b1GQcrquyfdCS+5udR+cKkSq2Wy/hwtb2gBv3VAFmg4DuuM4a/ahCAt4IS/lClQyemSU+QBU3r9niFXWyVA2g8rwN6dTClBw5zjbHnI8vg2XR0K+ufs3I7QVoZOHhAtyXPxdrpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782681401; c=relaxed/simple;
	bh=Ak4ME6EV2umXWDdTsgBMo7kpaXBWMZyqJ/E0DQRGCSo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Dfl5tMAUPbzq4k22CJ1QYZ0SauwgqR8uKIn2wr4gISnnuJDhT8CmAj8sUz+fPuhllSmxnrhrXdnz0iU/LOLMAmRykZlcxxJicjtXwHzKrq9nERClJanSad9IS6jU3EkQ0EkV6od7kzflsTvZ6l4cYK3XRpuh6UgeQhfO33dwW/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VJTB5hLt; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VJTB5hLt"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-473ba028d46so260797f8f.1
        for <stable@vger.kernel.org>; Sun, 28 Jun 2026 14:16:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782681398; x=1783286198; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JR17Ijov4migXeSaakJw+TAwMRCearPMtrzs674Xjvw=;
        b=VJTB5hLtIE75WLeGWo2QOO267CwlDFAv8yZdjzc8OYQAeWigY7MqAfl3h/PHuCxwTY
         bhAB/wy990yK3w3RhkWczSML6POE7TwKaRuaYbYN+rAUa+5xEMwWdsEmSogXXYtaHqN1
         lPvnw2YzPkuSitjsSaj3gy381Lj9EIPTi4zYnjEyAPnalZ/7QAx24yxgJyNBhKq8C8Pg
         IjkyeZTWpjJobZEbOccnDtZfr/awguhNUcXpe6fp9akXobTn5ysaz9pqdIRhnTx7My3w
         Lfi7Jjg9OPqKaXHWdGf/XXw5BYmVf4n9vLcz0eD7JwYVgGCce3LvWFAbOhbaiPFP/toC
         1Xaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782681398; x=1783286198;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JR17Ijov4migXeSaakJw+TAwMRCearPMtrzs674Xjvw=;
        b=lcQ91dTyeKC9dM+mT9UA8f1FCWeeZkKWfa/eQ5Ba1ujuRPpVoalNJWqvLaZ29wgmap
         LXi4ZTWa2F/rH2ULdNUDJ1FO8/mlvrIU9YvZkJwNpuTm1PeeNxju0l3TJLR00vWUYGra
         J7YKHnOULvRywrQ3pQF9NhrMwZW7S3/HCQqYDyLwmh2WdVApgiK5M4siOD1Ae06u27Xs
         2E/Q8eaHOGTEWrXtLpWMoi+RbvHsdN5du5k+qMIRHVk2KlsAi5sh1axJ7Pg4lB+4+0lB
         d2Q6PUbQTFTbGVC7XRsqYkUda9SJqwhaf+2Cd4czT4+cVTLv7xviUpLrpiUGF863HOMF
         9Lrg==
X-Forwarded-Encrypted: i=1; AHgh+RpTXpoIXkIkKLy4wQTweKT3VFhhrDY7dgJzbeQBtoeJxphfwb6ylAyMNvBsAu26x+cnN6Cydu4=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywk9QoPyaRPdifpu7N5L8nvSRlyCpv4tYbukozKvz3gVbxDsNaC
	nIsQXPqP4agXkF/NRKSkayQFom+wgYiHL37lmDqcIl4dV0/FTgtmwogY
X-Gm-Gg: AfdE7ckghtwaB4AKEi+wT+LlJnaV2R0bE60sK2j/vxnEMM/DPxicAqyGxbhobGnfHn1
	5gDdPAX1sYngJNWSXeS697KjG7I/QbQAEBD48VjrXRZmzlvShnpUcxpMg+2mYM2Iftkyw3U4d4X
	cqn8hQ2M8NG7CHwFuKNjFd+r4M31aQSLWrPzRY9pD+zFD90KAh8UiocTdeCyvOrhr1+8s5VWRwM
	suef1cwbF5UKaoffuYCAXogAL8fZPXHTnfQmHSQS+4IE+MQnoeBOBRc1izYkOnSCsltyz2ynuWh
	spEr6r6tfsSxbl8zYALTJoPch+Bivkv7+SgLsYMunvy/ii5w1UZpoxPvdbOCwxD9Qs+rStYq7M1
	OLbT4PYdEwQCAAP5dxAdF6WUYPw3e5lvnmTPwkX3m1xyL2kgPGJNjve7JnBlrby6QEqJ/qY891D
	XADaMnN4AXsQbzRuif/qeVCBXH
X-Received: by 2002:a05:6000:2905:b0:470:6dc:848a with SMTP id ffacd0b85a97d-47006dc868amr10104283f8f.2.1782681398041;
        Sun, 28 Jun 2026 14:16:38 -0700 (PDT)
Received: from foxbook (bgu190.neoplus.adsl.tpnet.pl. [83.28.84.190])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-46fe25429d5sm23299558f8f.7.2026.06.28.14.16.36
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sun, 28 Jun 2026 14:16:37 -0700 (PDT)
Date: Sun, 28 Jun 2026 23:16:34 +0200
From: Michal Pecio <michal.pecio@gmail.com>
To: Nikhil Solanke <nikhilsolanke5@gmail.com>
Cc: linux-usb@vger.kernel.org, gregkh@linuxfoundation.org,
 linux-kernel@vger.kernel.org, stern@rowland.harvard.edu,
 stable@vger.kernel.org, corbet@lwn.net, skhan@linuxfoundation.org,
 linux-doc@vger.kernel.org
Subject: Re: [PATCH v2] usbcore: Add quirk for 255-bytes initial config read
Message-ID: <20260628231634.6752f74d.michal.pecio@gmail.com>
In-Reply-To: <20260623161035.5792-1-nikhilsolanke5@gmail.com>
References: <20260623161035.5792-1-nikhilsolanke5@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 23 Jun 2026 21:40:35 +0530, Nikhil Solanke wrote:
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
> enumerates correctly in Android mode when the same 9-byte request
> is issued for that mode's configuration descriptor, confirming the firmware
> bug is specific to the XInput mode.
> 
> usbmon traces from Linux and Wireshark/USBPcap traces from Windows are
> identical up to the point of failure, with no visible protocol-level
> difference explaining the divergence. The root cause was identified when
> Michal Pecio discovered via a QEMU bus-level capture that Windows does not
> use wLength=9 for the initial config descriptor request; it uses
> wLength=255. Alan Stern subsequently confirmed this with a bus
> analyzer on a different USB 2.0 device, and Michal verified the behavior
> goes back to Windows 95 OSR2.1.
> 
> So, add a new quirk flag USB_QUIRK_CONFIG_SIZE which causes
> usb_get_configuration() to issue a 255 byte sized configuration request
> instead of USB_DT_CONFIG_SIZE (9) for the initial
> GET_DESCRIPTOR(CONFIGURATION) request, mimicking long-standing Windows
> behavior.
> 
> Suggested-by: Alan Stern <stern@rowland.harvard.edu>
> Suggested-by: Michal Pecio <michal.pecio@gmail.com>
> Closes: https://lore.kernel.org/linux-usb/CAFgddh+JWdT4LLwMc5qjM8q_pBu-fRo2qADR5ovAKoGHWMQrRw@mail.gmail.com/
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: stable@vger.kernel.org
> 
> Signed-off-by: Nikhil Solanke <nikhilsolanke5@gmail.com>
> ---
> Changes in v2:
> - Add Documentation
> - Naming changes
> - Refactored to have a better flow with existing code.
> 
>  .../admin-guide/kernel-parameters.txt         |  9 +++
>  drivers/usb/core/config.c                     | 61 ++++++++++++++-----
>  drivers/usb/core/hub.c                        |  6 +-
>  drivers/usb/core/quirks.c                     |  4 ++
>  include/linux/usb/quirks.h                    |  3 +
>  5 files changed, 67 insertions(+), 16 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 97007f4f69d4..af4bf0ef2c7b 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -8158,6 +8158,15 @@ Kernel parameters
>  				q = USB_QUIRK_FORCE_ONE_CONFIG (Device
>  					claims zero configurations,
>  					forcing to 1);
> +                r = USB_QUIRK_WINDOWS_CONFIG_REQ_SIZE (Device
> +                    fails during initialization when asked for
> +                    9-bytes configuration desciptor request. Ask
> +                    for 255-bytes request instead to mirror
> +                    Windows' behavior. This quirk is originally
> +                    meant to fix some quirky gamepads that refuse
> +                    to connect in their XInput mode. But it can also
> +                    potentially fix issues with other USB devices
> +                    that work on Windows but not on Linux)

I too think it's too long. This file explains what the parametrs do,
not their history.

And here it's USB_QUIRK_WINDOWS_CONFIG_REQ_SIZE, but in the commit
message it was USB_QUIRK_CONFIG_SIZE.

Honestly, I would suggest a third option: something with "255" instead
of "Windows", because not everybody knows how windows queries
descriptors, but everybody knows what 255 is.

>  			Example: quirks=0781:5580:bk,0a5c:5834:gij
>  
>  	usbhid.mousepoll=
> diff --git a/drivers/usb/core/config.c b/drivers/usb/core/config.c
> index 45e20c6d76c0..4fc3145404d6 100644
> --- a/drivers/usb/core/config.c
> +++ b/drivers/usb/core/config.c
> @@ -19,6 +19,9 @@
>  
>  #define USB_MAXCONFIG			8	/* Arbitrary limit */
>  
> +/* config req size if USB_QUIRK_WINDOWS_CONFIG_REQ_SIZE is set */
> +#define USB_CONFIG_WINDOWS_REQ_SIZE	255
> +
>  static int find_next_descriptor(unsigned char *buffer, int size,
>      int dt1, int dt2, int *num_skipped)
>  {
> @@ -912,6 +915,13 @@ int usb_get_configuration(struct usb_device *dev)
>  	unsigned char *bigbuffer;
>  	struct usb_config_descriptor *desc;
>  	int result;
> +	/*
> +	 * Devices with quirky firmware will stall or reset when asked only for
> +	 * the configuration header. This variable decides which size to use in
> +	 * that case, if the quirk for that device was set.
> +	 */
> +	size_t usb_config_req_size = (dev->quirks & USB_QUIRK_WINDOWS_CONFIG_REQ_SIZE)
> +		? USB_CONFIG_WINDOWS_REQ_SIZE : USB_DT_CONFIG_SIZE;

That's a lot of capital letters, USBCONFIG_WINDOWS_REQ_SIZE never
appears outside this function and personally I would just spell it out
as 255 here with appropriate comment.

The whole function is all about "usb" and "config" so maybe these words
don't need to appear here. OTOH, "first" would add useful information.

>  
>  	if (ncfg > USB_MAXCONFIG) {
>  		dev_notice(ddev, "too many configurations: %d, "
> @@ -938,18 +948,27 @@ int usb_get_configuration(struct usb_device *dev)
>  	if (!dev->rawdescriptors)
>  		return -ENOMEM;
>  
> -	desc = kmalloc(USB_DT_CONFIG_SIZE, GFP_KERNEL);
> +	desc = kmalloc(usb_config_req_size, GFP_KERNEL);
> +
>  	if (!desc)
>  		return -ENOMEM;
>  
>  	for (cfgno = 0; cfgno < ncfg; cfgno++) {
> -		/* We grab just the first descriptor so we know how long
> -		 * the whole configuration is */
> +
> +		if (dev->quirks & USB_QUIRK_DELAY_INIT)
> +			msleep(200);
> +
> +		/*
> +		 * Grab just the first descriptor so we know how long the whole
> +		 * configuration is. In case of quirky firmware, try to grab the
> +		 * whole thing in one go by asking for a 255-bytes sized buffer
> +		 * mirroring Windows behavior.
> +		 */
>  		result = usb_get_descriptor(dev, USB_DT_CONFIG, cfgno,
> -		    desc, USB_DT_CONFIG_SIZE);
> +						desc, usb_config_req_size);
>  		if (result < 0) {
>  			dev_err(ddev, "unable to read config index %d "
> -			    "descriptor/%s: %d\n", cfgno, "start", result);
> +				"descriptor/%s: %d\n", cfgno, "start", result);
>  			if (result != -EPIPE)
>  				goto err;
>  			dev_notice(ddev, "chopping to %d config(s)\n", cfgno);
> @@ -957,13 +976,25 @@ int usb_get_configuration(struct usb_device *dev)
>  			break;
>  		} else if (result < 4) {
>  			dev_err(ddev, "config index %d descriptor too short "
> -			    "(expected %i, got %i)\n", cfgno,
> -			    USB_DT_CONFIG_SIZE, result);
> +				"(asked for %zu, got %i, expected at least %i)\n",
> +				cfgno, usb_config_req_size, result, 4);
>  			result = -EINVAL;
>  			goto err;
>  		}
> +
>  		length = max_t(int, le16_to_cpu(desc->wTotalLength),
> -		    USB_DT_CONFIG_SIZE);
> +				USB_DT_CONFIG_SIZE);
> +
> +		/*
> +		 * If the device returns the full length configuration
> +		 * descriptor, skip the second read. Otherwise, send a second
> +		 * request asking for the full length.
> +		 */
> +		if (result >= le16_to_cpu(desc->wTotalLength)) {

Technically, this is a behavior change for devices without the quirk,
if their wTotalLength is 9. Not sure if this is worth worrynig about,
it would mean that the configuration has no interfaces or endpoints.

> +			bigbuffer = (unsigned char *) desc;
> +			desc = NULL;

What happens in the next iteration of the loop?

> +			goto store_and_parse;
> +		}
>  
>  		/* Now that we know the length, get the whole thing */
>  		bigbuffer = kmalloc(length, GFP_KERNEL);
> @@ -972,23 +1003,25 @@ int usb_get_configuration(struct usb_device *dev)
>  			goto err;
>  		}
>  
> -		if (dev->quirks & USB_QUIRK_DELAY_INIT)
> -			msleep(200);
> -
>  		result = usb_get_descriptor(dev, USB_DT_CONFIG, cfgno,
> -		    bigbuffer, length);
> +						bigbuffer, length);
> +
>  		if (result < 0) {
>  			dev_err(ddev, "unable to read config index %d "
> -			    "descriptor/%s\n", cfgno, "all");
> +				"descriptor/%s\n", cfgno, "all");
>  			kfree(bigbuffer);
>  			goto err;
>  		}
> +
>  		if (result < length) {
>  			dev_notice(ddev, "config index %d descriptor too short "
> -			    "(expected %i, got %i)\n", cfgno, length, result);
> +				"(asked for %i, got %i)\n",
> +				cfgno, length, result);
>  			length = result;
>  		}
>  
> +store_and_parse:
> +		krealloc(bigbuffer, length, GFP_KERNEL);
>  		dev->rawdescriptors[cfgno] = bigbuffer;
>  
>  		result = usb_parse_configuration(dev, cfgno,
> diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
> index 24960ba9caa9..9acd278666fc 100644
> --- a/drivers/usb/core/hub.c
> +++ b/drivers/usb/core/hub.c
> @@ -2527,8 +2527,10 @@ static int usb_enumerate_device(struct usb_device *udev)
>  		err = usb_get_configuration(udev);
>  		if (err < 0) {
>  			if (err != -ENODEV)
> -				dev_err(&udev->dev, "can't read configurations, error %d\n",
> -						err);
> +				dev_err(&udev->dev, "can't read configurations, "
> +					"for device %04x:%04x, error %d\n",
> +					le16_to_cpu(udev->descriptor.idVendor),
> +					le16_to_cpu(udev->descriptor.idProduct), err);

I wonder if it wouldn't make sense to split announce_device() so that
the first line is printed as soon as usb_new_device() starts, before
enumeration is attempted and possibly fails.

That would be a separate patch, of course.

>  			return err;
>  		}
>  	}
> diff --git a/drivers/usb/core/quirks.c b/drivers/usb/core/quirks.c
> index 87810eff974e..df670b0b66fe 100644
> --- a/drivers/usb/core/quirks.c
> +++ b/drivers/usb/core/quirks.c
> @@ -142,6 +142,10 @@ static int quirks_param_set(const char *value, const struct kernel_param *kp)
>  				break;
>  			case 'q':
>  				flags |= USB_QUIRK_FORCE_ONE_CONFIG;
> +				break;
> +			case 'r':
> +				flags |= USB_QUIRK_WINDOWS_CONFIG_REQ_SIZE;
> +				break;
>  			/* Ignore unrecognized flag characters */
>  			}
>  		}
> diff --git a/include/linux/usb/quirks.h b/include/linux/usb/quirks.h
> index b3cc7beab4a3..a4043b33c2c2 100644
> --- a/include/linux/usb/quirks.h
> +++ b/include/linux/usb/quirks.h
> @@ -81,4 +81,7 @@
>  /* Device claims zero configurations, forcing to 1 */
>  #define USB_QUIRK_FORCE_ONE_CONFIG		BIT(18)
>  
> +/* Use a 255 bytes config descriptor request mirroring windows behavior */
> +#define USB_QUIRK_WINDOWS_CONFIG_REQ_SIZE	BIT(19)
> +
>  #endif /* __LINUX_USB_QUIRKS_H */
> -- 
> 2.54.0
> 
