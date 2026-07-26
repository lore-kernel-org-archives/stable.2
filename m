Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFFA970818;
	Sun, 26 Jul 2026 13:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785072523; cv=none; b=NY1xK5ni0YwKmWN54VPCCCliYmiJdYlSccOgpKpb/C5HWvq+bZg/oLK8aaMVxIQcWu9vfxec/y1JuISo8vgJ2XTOx7Py3otiLQ4B/ypffoQ5Nl6slyOPAhtWNCSiZh3Tqya4zwtjWATV+LYH7RYGCSLrqJ9eDz72TgfdT/wg0aI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785072523; c=relaxed/simple;
	bh=SpaC9R3k8iJo1n/+TvqsGNyd7OuxV9YpbviiehL+MzU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bmSApFej2Ep9js2Eq/v2LUY+N7lsw578DZGmX/iLj2rKyf1Jsq+OTLp7FQ9oirH2AvZuNkDedJ/kHA/b1iQ0qJZzopvUF1p7CPOtN8Mdd2iFxs0b2vUO0C5xCeSwFE2vuaGubEADdJFCAThs4+EnZfhBhKJpeE5hRWuTV6s6nc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=p70Xyhoy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="p70Xyhoy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEA831F000E9;
	Sun, 26 Jul 2026 13:28:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785072521;
	bh=M91H2DtWJUkNml4ra1XbrxKJeqOJ2sPSlMcE6mDChpI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=p70Xyhoyh3FJFINw20z6WYvb9rJFcEJP3a2ySZPGDxHoHtvYoo7VJKD2YzngRE+2E
	 FqWPV8WHzQzzBqYMAUG2j2rX425HzJ6pL2uBczIMXUm8fCiSprQfTEYRrmfNa/W7x4
	 VEysiLD2FDu3eQ2B3vQk4FlKq4f3d5Spul+tbQxY=
Date: Sun, 26 Jul 2026 15:28:29 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Ishaan Dandekar <ishaan.dandekar@gmail.com>
Cc: linux-input@vger.kernel.org, linux-usb@vger.kernel.org,
	nikhilsolanke5@gmail.com, Alan Stern <stern@rowland.harvard.edu>,
	Michal Pecio <michal.pecio@gmail.com>, stable@vger.kernel.org
Subject: Re: [PATCH 1/3] usbcore: Add quirk for 255-bytes initial config read
Message-ID: <2026072612-ungreased-repulsive-d992@gregkh>
References: <20260726132039.28330-1-ishaan.dandekar@gmail.com>
 <20260726132039.28330-2-ishaan.dandekar@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260726132039.28330-2-ishaan.dandekar@gmail.com>

On Sun, Jul 26, 2026 at 06:50:38PM +0530, Ishaan Dandekar wrote:
> From: Nikhil Solanke <nikhilsolanke5@gmail.com>
> 
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
>  .../admin-guide/kernel-parameters.txt         | 10 +++++
>  drivers/usb/core/config.c                     | 39 +++++++++++++++----
>  drivers/usb/core/quirks.c                     |  4 ++
>  include/linux/usb/quirks.h                    |  3 ++
>  4 files changed, 49 insertions(+), 7 deletions(-)

Cool, but you can't send on someone else's patch without also signing
off on it :)

thanks,

greg k-h
