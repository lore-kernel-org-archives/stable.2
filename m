Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC225393DC0
	for <stable@vger.kernel.org>; Tue, 23 Jun 2026 20:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782246287; cv=none; b=QU82Dveqgm5x1U5Td9n/2SsByorv7KToCZOFvjsb5wXkOKyYGTrAOa7kPjgVPK5FcCByX6GQApDZYheZy+gDDymLBUE4lG1tpzk3nk+Qs2h7e/cTbAYbdnGHoo0q44HJBBCvmcek5kR4aw3EpvrJnQbBledKF1+ISxL8grx2cWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782246287; c=relaxed/simple;
	bh=fZL8XosPNIDbemG2cyPZ9OfoCZKG/KqD+Zut4TrzU5c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e9B0nI3PXAaErifZOG3nLVBkr2NFwVxxcvT94j/RJhrKqyEV0/VNOjT0F34Fd1c4GKLszYtH1MApRn1E026Y2dPOZgbjRZOpgffGhZcNF7gUKz95drmNKjJrbHz7p3McIr8KnxclxTvarY0Wx5273WSNLFmir4erK+c/ynlxNSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=Tdo7Mi8r; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="Tdo7Mi8r"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-519f6a10d9bso1170341cf.3
        for <stable@vger.kernel.org>; Tue, 23 Jun 2026 13:24:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1782246284; x=1782851084; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Dg0VmZRnPidvv5d8YAEvIvPCwG3p5pIpsB4/HR9xgq8=;
        b=Tdo7Mi8reTpsYR867cW+35uAao1l3WSZt6yfZbPGjwTYeh0VOn4VDBIQQTLUdfh2/p
         O7DVPoyM1+CBOtnHiBsWTRT5uuf8erQ1c+crtAC0d7ScWG1u2dxjk038O6jJEjtclYiv
         d11+6m6nGl9WQW9WYmaMqR0GzEOJPr98xJNAp5JCQOn9CGuyogI7rq6dsjpJnSON42UP
         jbqC+44/dTF4SJBRGbhYPztKeSVhIBYOllxBw1FMYoo9ta5AvW2jsglYnLn0fPwBgUMe
         CFBV8Zg3d1RnDUZFz2akgGqgb6PylOwc8AMoAXGRfT3Do5m9cXrZH9LRF4XJs70qjlmT
         cLtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782246284; x=1782851084;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dg0VmZRnPidvv5d8YAEvIvPCwG3p5pIpsB4/HR9xgq8=;
        b=ZONVLeAzElifcn7bwkBYSKDrNhPnq71cJCthpe4/nxCqL2zrIok19/jLFZb0JUp70Y
         NSaUNnsLsc5UDv2Ae9KNQ7FBQ+zGNAVA1s/1MfwVt88hrsdJzQGZyqvVmlu85vql4Ppa
         Q477Vx/gX7tB9ngnaFwUIcY8y2HtuSX8y/0p/3jVAGHYOlWS97u2BZ/uXvjMPl4lGr0H
         nynHzlsHdSdsW/Fa6wLMA6fJz8UGNqksf8TGeY6ggsgL8r0D7PwT0vccp+/tybgR6aDS
         Rnal/NsYfF+IqrbM1E8tGT/SIhnWwfwdmVIRxZRvdP4guAnlN5kLrTzziBRruj7ujkR1
         m9kw==
X-Forwarded-Encrypted: i=1; AFNElJ/su2XecWpLKWUZYgcQuDD1cJ9JFe56Xc7iyqiT1XY1qOMrS0488R1jOTnhZZ2ohJlaDBTQs0w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1K5TC8MBHS5qgdsBlnzDQEoXzYeAk2DCFLTv2diXef5Ai7PT0
	lJXfmLR374S1P1YdrX40rKxilyaJ9G3et0EtDSCAdN+jZ9JL7XB/fEUfAtpYe4IyFw==
X-Gm-Gg: AfdE7cmYCtaADMCThPKOdm2woqNRdD7sJFSYusD0qu0kJncYKDKmBMDz4YI0t4Fv6VW
	lLhD9Kh5DqD2F4qEcq/yEWV2J3U7rZA8A8CgQtJmxcsreI2Z7Ndy6Gh9STIm3E8DoLhwWkx6kxF
	uAyGTsxwdISTFIAcCuPZkvI8HBQCx2SZ3wqUC8WRGKyTCTEHktIlQq69KAZ9ir4yLCMgwmKIuKc
	/Fd6WAFwJkWy5TMkDJARclhqQF1tqlBJHjneWS1M+aN4Wbgfka+uIOpmHpxvC/Pz0HpDG8QK46N
	HZ3D3bHfUKfeBbCaqlc2fAI2+K+a4jNx7WkJsr4MWkrXLV2t/Cn1BiyCXRAT++z6MazASGuxsMQ
	5XtDA3hkkQL6PL517HcAqLuE5JDhQrFfdR+D+O3RywJpFx06KYbctWK1jmdTkv1ktrkNyq6BcgD
	LN2i8AheTjzmROOB/vGzU8hHzaGrKspxUmtCayGCNtz0Q=
X-Received: by 2002:ac8:59cd:0:b0:517:6d82:9aec with SMTP id d75a77b69052e-51a61bc9a7emr9843381cf.0.1782246283350;
        Tue, 23 Jun 2026 13:24:43 -0700 (PDT)
Received: from rowland.harvard.edu ([2601:19b:d01:d210:d62f:1911:f952:16ba])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51a515d055esm32297941cf.12.2026.06.23.13.24.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 13:24:41 -0700 (PDT)
Date: Tue, 23 Jun 2026 16:24:38 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: Nikhil Solanke <nikhilsolanke5@gmail.com>
Cc: linux-usb@vger.kernel.org, gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org, michal.pecio@gmail.com,
	stable@vger.kernel.org, corbet@lwn.net, skhan@linuxfoundation.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH v2] usbcore: Add quirk for 255-bytes initial config read
Message-ID: <567e8866-4308-4e5f-819c-fe778dbf74f8@rowland.harvard.edu>
References: <20260623161035.5792-1-nikhilsolanke5@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260623161035.5792-1-nikhilsolanke5@gmail.com>

This is looking better.  A few more things to mention below, but 
otherwise okay.

On Tue, Jun 23, 2026 at 09:40:35PM +0530, Nikhil Solanke wrote:
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

Normally people don't leave a blank line before their Signed-off-by: 
(unless it's the first tag to appear).  But I don't think it makes any 
difference, especially if the checkpatch.pl script doesn't object.

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
>  			Example: quirks=0781:5580:bk,0a5c:5834:gij

As Randy said, use tabs instead of spaces.  And this new entry should be 
aligned with all the preceding entries, and it should end with a ';' 
like they do.

I would leave out the two sentences of explanation, but that's more of a 
personal choice.  We'll see if Greg KH objects.

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

It's a little unusual to have a multiline comment in the middle of a 
bunch of variable definitions.  The alternative is to do the assignment 
later on and move the comment there.

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

Moving this delay up here changes the behavior when the quirk flag isn't 
set.  While it agrees with the intention of the USB_QUIRK_DELAY_INIT 
flag, such a change should be mentioned in the patch description.

> +
> +		/*
> +		 * Grab just the first descriptor so we know how long the whole
> +		 * configuration is. In case of quirky firmware, try to grab the
> +		 * whole thing in one go by asking for a 255-bytes sized buffer
> +		 * mirroring Windows behavior.
> +		 */

This needs to be rewritten, as it is self-contradictory.  When the quirk 
flag is set we issue a 255-byte request to mimic the Windows behavior, 
and only when the flag isn't set do we grab just the first descriptor.

>  		result = usb_get_descriptor(dev, USB_DT_CONFIG, cfgno,
> -		    desc, USB_DT_CONFIG_SIZE);
> +						desc, usb_config_req_size);

Don't make extraneous changes to the existing indentation (or whitespace 
in general), here and below.

>  		if (result < 0) {
>  			dev_err(ddev, "unable to read config index %d "
> -			    "descriptor/%s: %d\n", cfgno, "start", result);
> +				"descriptor/%s: %d\n", cfgno, "start", result);

At the time this code was originally written, the policy for kernel code 
was to break lines before 80 columns.  Since then the policy has changed 
to avoid splitting long literal strings into pieces, even when that 
means exceeding 80 columns.  So your new string here should all go on 
one line.

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

This is another example of a change that has nothing to do with the 
purpose of the patch.

> +
> +		/*
> +		 * If the device returns the full length configuration
> +		 * descriptor, skip the second read. Otherwise, send a second

Strictly speaking, the configuration descriptor is only 9 bytes long.  
What you mean here is the entire configuration descriptor set.

> +		 * request asking for the full length.
> +		 */
> +		if (result >= le16_to_cpu(desc->wTotalLength)) {

Shouldn't this be: result >= length?  No point in repeating the 
le16_to_cpu calculation.

> +			bigbuffer = (unsigned char *) desc;
> +			desc = NULL;
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

More examples of unnecessary whitespace changes.

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

Like above, this string should all be on one line.

Alan Stern

> +					le16_to_cpu(udev->descriptor.idVendor),
> +					le16_to_cpu(udev->descriptor.idProduct), err);
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
