Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6713738886F;
	Tue, 23 Jun 2026 18:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782239759; cv=none; b=rlARFhyNAq2K5Cc24Hl1P1DJURRZPdADrORDadU/05jSLrL827Z5EL/v5B1QDDeJjztNYeQpKCvtKEPMqRKHzIApSwlQ98y6m4iy9QCmMEXoIlujvIWzjxy6gK13WcrorceXSRmhgwOIkAU4VqSGzAxxZ9rniWsCeCwxaUOHIeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782239759; c=relaxed/simple;
	bh=3denSDWU4lslLMMrBoV7SduczTmb4bDlfrVrLSfyQOU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IAUrQxqRdxaGocTZAr0YaoFoe3LdA9kO4Yqs42eZqippIizRiiQC5kiMOkDjW50Ghouo45CurkYtQjJtlwSGFITUtrQEe+hj6CunkUGr6V3sDjdWM/+sRtDDVq1dOJ/7PN2zUSrhADSVy3mrYCRfkWTNB65GLYXpsOcs7aFqq0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=DHb6vyiY; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DHb6vyiY"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=8eu3Tvugp4G3bN3k1ldUXH5hZPq1X4tfuU0wkqE8zfk=; b=DHb6vyiYJyimYURUi7NGZDHuIH
	lSoYKVDsTVEJomfIBZxlXmuIE4Ltgb045Nymk7a6n7YdrzpbIOak00qMU48J75e9hQpbOHt0FQd4V
	+G/SzJQNxz2DSroO9RLAMs6yVVu51eVhbAuL3VS7TDvzZSJu1oTnMdx3YcS4Qq9qFpZV+hiz003ld
	mPxD3oMYra0zZ2UpgiZh73Ys87AEI4in1l3FpPaGt8r2dWuhQwS2pl1yeeweYyu8y67Soo6mBTQiy
	Um5gtYQhMOQlX3cAcNFzkt59nGsDryC7EwC/WurS3icu2fOqweOnVhe5SASWKB70/4n5/UBMVRlzg
	WHlon57g==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wc5yW-00000006lNN-2Zbn;
	Tue, 23 Jun 2026 18:35:56 +0000
Message-ID: <75822857-473d-4067-a378-aae2cdab4176@infradead.org>
Date: Tue, 23 Jun 2026 11:35:54 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] usbcore: Add quirk for 255-bytes initial config read
To: Nikhil Solanke <nikhilsolanke5@gmail.com>, linux-usb@vger.kernel.org
Cc: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
 stern@rowland.harvard.edu, michal.pecio@gmail.com, stable@vger.kernel.org,
 corbet@lwn.net, skhan@linuxfoundation.org, linux-doc@vger.kernel.org
References: <20260623161035.5792-1-nikhilsolanke5@gmail.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20260623161035.5792-1-nikhilsolanke5@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/23/26 9:10 AM, Nikhil Solanke wrote:
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

		                             descriptor

> +                    for 255-bytes request instead to mirror
> +                    Windows' behavior. This quirk is originally
> +                    meant to fix some quirky gamepads that refuse
> +                    to connect in their XInput mode. But it can also
> +                    potentially fix issues with other USB devices
> +                    that work on Windows but not on Linux)

add ending '.'

For all lines added here, use tabs instead of spaces for indentation.


>  			Example: quirks=0781:5580:bk,0a5c:5834:gij
>  
>  	usbhid.mousepoll=


-- 
~Randy

