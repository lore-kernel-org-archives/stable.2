Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF652374E42
	for <stable@vger.kernel.org>; Sun, 26 Jul 2026 16:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785083155; cv=none; b=Nmf5kixj9s6Rc8rcsDiCy79pR+4guMbotpn2/yF7t5zK2YAY72jvCFRqbI6yxJf7Dml60UeauoPxHp6KlTMTE+byTl1nTRrcNS+ctQyTFwnUqV75faaFSNFsjKmPok0Sw6WS/m4+zGizIQrjilnbKvATVqnU19tRTrdH0APNDXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785083155; c=relaxed/simple;
	bh=XbhZWawk9uP5w+/hRkyU+8LB6exUbgZNi8v8VnEQEzc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o/QrjQxLV0PpZpQKfeB+ZVRW98zCTFG4XF4E+qIG8ulvIJuTG67wki/s5QZY2Cw3NAsZx1NDMVUzxHi23F89nr6g/vrb7YpUfRKSU95JucjlcTz8YhyV6BiQvYR9lBAk+/PdkCp5OOg0BYYT1lEG9LqrVBFCE+Y0nIZS029UK5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tv6wFtMH; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tv6wFtMH"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-495757ccbc1so18045775e9.2
        for <stable@vger.kernel.org>; Sun, 26 Jul 2026 09:25:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785083150; x=1785687950; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zFLKSj9QjxByZ3M4VcrGfBPwVddmmLi8VlJ0E9sOg4I=;
        b=Tv6wFtMHsgi8RdI7RvXTvkvNoRut+nhX93vPraQKLt6lXF/OydWq1DonZUWQx1n4/x
         5E9pVORAUfO74ZrEjkD2Y4JMzifGner2Keo12oS57vcFTWS+pMVACSWsHdxuAeh4mB1W
         DbLqKg1Ppq8KAvbPvYhSEuHzpkwZa8m/QFspjsFFPNHtHGbXhcmPbiZgOn7gqUp/SG6p
         GZyEv672LN+rmjVpViVQKqWBkqadG1dLaW7VwKrRtj5X3PuDY9f/O8S06etrosJQh7Nz
         Vrn855+/DR6dSg3evyITd+hzygE/KO+Dgj5tNriSAsMySta/GVgslK2HGQSKKmOigZjq
         FGvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785083150; x=1785687950;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zFLKSj9QjxByZ3M4VcrGfBPwVddmmLi8VlJ0E9sOg4I=;
        b=sdzTgSEClLIxnoKGoXdB55+8c9DEGOhLO8tSAIQOWdJKVT4QMhLspFraV40HzlOLci
         mRQ5AC8tHnd0qVCCt24joGSaxmdp47QhGJtL/bRFmEeuhpaW4LvqcPoJwHS+yYC30K2b
         MSu2yI1Rrg7gijYP+M4ZuMypiKQyliMHQY9owbGN855s3Zee04cTLIVI5IkUThL5MHgG
         lIPkUPLbMWCSfoN3jomjhwcGjiGQhytCfrNIvj09QpYzGYibXkdPhs8UJLI98h4HEP1e
         WyAfrSDgxi5VtuQ9rtfvDXoUit4Ogi3xvVHi+FnVy6t4U6OoZEE+flTy2WWEGM5hcDbX
         O7Bg==
X-Forwarded-Encrypted: i=1; AHgh+RorAQMwL5Y7GMGi5/uIbZy+z49yWSFq4yAEapwjHeguc+txtWqZNDUQz6wJCkZ4Utdl8vSyeuU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPoZ6dYI/qhHp/KuZQGOERMipBV1IW/Qr3Fg3v3BP/ThhzMCLh
	kS90878miTINyw1JLP3sqSMMFb2mQc1Ulr8Jx8K4ImuQ/thjd50JKVyh
X-Gm-Gg: AR+sD12rwCe79I1ueo+YQRc8hWPnUwf5PDWSpGU1i12TzwjVUDJoV6sjoncJRBa/2zK
	Ac+7z0dEfKJ6HL2JgmRrGB1CXR4FduqwND5Q/QSCF/GqjMbz6XPjCGUahS355h50r4qQZdbxl86
	lFCxBaL8Xm95yyBSv9YEFcw4j7fEScvIF07Pe7904lTV3XjZy7TBRQ/3piR5T7af0ahLUmRdx3B
	6uXG8Mr8op52pIdFd9XikTAyoHNrm0ML3ZVjOYomn8kI6zmWSMXM9CEXMrpGmFFgLyT0PReK9V+
	MtSEOlWR0qw8tMjnXKjQavEaPgMNfG65A53ZHInb6QcIwO8Mcw6mwFec+gVZ+00hMRDCYIYFK/z
	Y/hLTnDaLAK/yzT+VPOYrkGuH2VlNp7VxHgKNZNXz3YQ9xU3HjZ9OB/9clYcgAmX2CoCQklJz5i
	XsQDvz4CNXXUM=
X-Received: by 2002:a05:600c:6992:b0:495:4811:d71c with SMTP id 5b1f17b1804b1-496b56c6d6dmr72217385e9.13.1785083150064;
        Sun, 26 Jul 2026 09:25:50 -0700 (PDT)
Received: from foxbook (bey56.neoplus.adsl.tpnet.pl. [83.28.36.56])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-496b4f302f8sm148698145e9.12.2026.07.26.09.25.48
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sun, 26 Jul 2026 09:25:49 -0700 (PDT)
Date: Sun, 26 Jul 2026 18:29:46 +0200
From: Michal Pecio <michal.pecio@gmail.com>
To: Nikhil Solanke <nikhilsolanke5@gmail.com>
Cc: linux-usb@vger.kernel.org, gregkh@linuxfoundation.org,
 linux-kernel@vger.kernel.org, stern@rowland.harvard.edu, corbet@lwn.net,
 skhan@linuxfoundation.org, linux-doc@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH 1/2] usbcore: Add quirk for 255-bytes initial config
 read
Message-ID: <20260726182946.79a4ef98.michal.pecio@gmail.com>
In-Reply-To: <20260717195336.98500-2-nikhilsolanke5@gmail.com>
References: <20260717195336.98500-1-nikhilsolanke5@gmail.com>
	<20260717195336.98500-2-nikhilsolanke5@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 18 Jul 2026 01:23:35 +0530, Nikhil Solanke wrote:
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
> So, add a new quirk flag USB_QUIRK_WINDOWS_CONFIG_REQ_SIZE which causes
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
> Signed-off-by: Nikhil Solanke <nikhilsolanke5@gmail.com>
> ---

The code looks generally correct now. Some small issues noted below.

>  .../admin-guide/kernel-parameters.txt         | 10 +++++
>  drivers/usb/core/config.c                     | 39 +++++++++++++++----
>  drivers/usb/core/quirks.c                     |  4 ++
>  include/linux/usb/quirks.h                    |  3 ++
>  4 files changed, 49 insertions(+), 7 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index b5493a7f8f22..14121458a0c0 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -8169,6 +8169,16 @@ Kernel parameters
>  				q = USB_QUIRK_FORCE_ONE_CONFIG (Device
>  					claims zero configurations,
>  					forcing to 1);
> +				r = USB_QUIRK_WINDOWS_CONFIG_REQ_SIZE (Device
> +					fails during initialization when asked for
> +					9-bytes configuration descriptor request.
> +					Ask for 255-bytes request instead to mirror
> +					Windows' behavior. This quirk is originally
> +					meant to fix some quirky gamepads that refuse
> +					to connect in their XInput mode. But it can
> +					also potentially fix issues with other USB
> +					devices that work on Windows but not on
> +					Linux);

I still think this text is needlessly long. Could be:

				r = USB_QUIRK_WINDOWS_CONFIG_REQ_SIZE (Device
					doesn't respond to 9-byte configuration
					descriptor requests, ask for 255 bytes like
					Windows does. Required by some gamepads);

>  			Example: quirks=0781:5580:bk,0a5c:5834:gij
>  
>  	usbhid.mousepoll=
> diff --git a/drivers/usb/core/config.c b/drivers/usb/core/config.c
> index 45e20c6d76c0..442c15f92ccd 100644
> --- a/drivers/usb/core/config.c
> +++ b/drivers/usb/core/config.c
> @@ -912,6 +912,17 @@ int usb_get_configuration(struct usb_device *dev)
>  	unsigned char *bigbuffer;
>  	struct usb_config_descriptor *desc;
>  	int result;
> +	size_t usb_config_req_size;
> +
> +	/*
> +	 * Devices with quirky firmware will stall or reset when the initial

Has anyone actually seen a device that stalls?

> +	 * config descriptor request uses wLength=9. If the quirk is set, use
> +	 * 255 instead, mirroring the behavior of Windows.
> +	 */

If the USB_DT_CONFIG_SIZE constant is moved here then it could make
sense to also move the related comment and merge with this one. Say,

	/*
	 * We start with grabbing the first descriptor so we know how
	 * long the whole configuration is. Some devices don't respond,
	 * request 255 bytes instead, mirroring the behavior of Windows.
	 */

> +	if (dev->quirks & USB_QUIRK_WINDOWS_CONFIG_REQ_SIZE)
> +		usb_config_req_size = 255;
> +	else
> +		usb_config_req_size = USB_DT_CONFIG_SIZE;
>  
>  	if (ncfg > USB_MAXCONFIG) {
>  		dev_notice(ddev, "too many configurations: %d, "
> @@ -938,15 +949,19 @@ int usb_get_configuration(struct usb_device *dev)
>  	if (!dev->rawdescriptors)
>  		return -ENOMEM;
>  
> -	desc = kmalloc(USB_DT_CONFIG_SIZE, GFP_KERNEL);
> +	desc = kmalloc(usb_config_req_size, GFP_KERNEL);
>  	if (!desc)
>  		return -ENOMEM;
>  
>  	for (cfgno = 0; cfgno < ncfg; cfgno++) {
> -		/* We grab just the first descriptor so we know how long
> -		 * the whole configuration is */
> +		/*
> +		 * Normally we request only the configuration descriptor header
> +		 * so we can determine the total configuration length. For
> +		 * devices with USB_QUIRK_WINDOWS_CONFIG_REQ_SIZE set, try to
> +		 * grab the full descriptor set instead.
> +		 */

... and then this comment wouldn't really be necessary, or it could
be shorter like
		/* First request for an initial prefix */

Also, the full descriptor set may be up to 65535 bytes long and in
some classes like UVC it commonly exceeds 255 bytes

>  		result = usb_get_descriptor(dev, USB_DT_CONFIG, cfgno,
> -		    desc, USB_DT_CONFIG_SIZE);
> +		    desc, usb_config_req_size);
>  		if (result < 0) {
>  			dev_err(ddev, "unable to read config index %d "
>  			    "descriptor/%s: %d\n", cfgno, "start", result);
> @@ -956,9 +971,8 @@ int usb_get_configuration(struct usb_device *dev)
>  			dev->descriptor.bNumConfigurations = cfgno;
>  			break;
>  		} else if (result < 4) {
> -			dev_err(ddev, "config index %d descriptor too short "
> -			    "(expected %i, got %i)\n", cfgno,
> -			    USB_DT_CONFIG_SIZE, result);
> +			dev_err(ddev, "config index %d descriptor too short (asked for %zu, got %i, need at least %i)\n",
> +			    cfgno, usb_config_req_size, result, 4);

There is no need to use %i if you always pass a constant 4.

There is probably no need to print "need at least 4" at all. Users
don't care that we request 9 or 255 bytes but tolarate just 4.

No compliant device will ever respond with less than 9, so it's not
clear if accepting 4 is even necessary for some very bad devices, or
was merely done out of paranoia. It's an irrelevant detail.

>  			result = -EINVAL;
>  			goto err;
>  		}
> @@ -972,6 +986,16 @@ int usb_get_configuration(struct usb_device *dev)
>  			goto err;
>  		}
>  
> +		/*
> +		 * If the device returns the full configuration descriptor set,
> +		 * skip the second read. Otherwise, send a second request
> +		 * asking for the full set.
> +		 */

There is already a comment about "getting the whole thing" a few lines
above, so half of this is redundant.

> +		if (result >= length) {
> +			memcpy(bigbuffer, desc, length);
> +			goto store_and_parse;
> +		}
> +

Even if no device currently uses both quirks, I think this belongs
after the msleep() below, to minimize interaction between the quirks.

>  		if (dev->quirks & USB_QUIRK_DELAY_INIT)
>  			msleep(200);
>  
> @@ -989,6 +1013,7 @@ int usb_get_configuration(struct usb_device *dev)
>  			length = result;
>  		}
>  
> +store_and_parse:
>  		dev->rawdescriptors[cfgno] = bigbuffer;
>  
>  		result = usb_parse_configuration(dev, cfgno,
> diff --git a/drivers/usb/core/quirks.c b/drivers/usb/core/quirks.c
> index 87ee2d938bc0..f5a60ccf21d3 100644
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
> 2.55.0
> 
