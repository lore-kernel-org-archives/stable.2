Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 300E03DDDDE;
	Mon, 31 Aug 2026 10:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788170983; cv=none; b=uDRBomkOg4dd8TXWW1DjY1WplV66eMbRNLlydNsa4FoVipggk/BJ2qRQRMWmr2lerO7IvL5nMiOzyia1l2Fha5JOiUbmSRjANglzGuISSmUevuoJXn98XSEjiE9E3axoLBOp5JdKCESYO+QHTQXmJYPGZAB5PoJ+ObjFctlh7qY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788170983; c=relaxed/simple;
	bh=x+8lU402WCpYO7mhIG+KCEDw/P223Qpg3y2Ef+3Lxvc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SR9k3onRa5GSo0Z4kW4YilY0xsAP9ATUokfwv5Rzw41Z4Gl34g35huRDbY7GXxDXS/3xJbGmUsuVq4+wcpyrPQ9jtCzVGMlkrxSxwpzWoKqEol59CoE9VEbG3hCrLUDThOrTX7WY8W/KbD0wnAt1teSx+pexnKLuOUrGRZMPz3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ST8rPUhj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ST8rPUhj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1220D1F000E9;
	Mon, 31 Aug 2026 10:09:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788170981;
	bh=AZV9NH3a7XWgTTIIp4Spi0yx8YwNlaofiwjwTGL5HTw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ST8rPUhjPYc7++xH1o6amwnTNVU0r4dBUYU14fe5hv/LGFEUhen7aT6yNoejdOvt+
	 nWhfStHr8Kd4aqaNlGJ+Devp6I/A2tlKqZiuH99ZgdJSrbLfnR/wYDYFwpEHw8mFWq
	 RyncQ9tMUiNgWIrwAhN+QI8UCALSiHwnwLW7/bzw=
Date: Mon, 31 Aug 2026 12:09:38 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Rishabh Jain <rishabh.jain1198@gmail.com>
Cc: Mathias Nyman <mathias.nyman@intel.com>,
	Mario Limonciello <superm1@kernel.org>, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] usb: pci-quirks: always assert xHCI OS ownership
Message-ID: <2026083129-justice-egomaniac-01cd@gregkh>
References: <69fdc442-a4f2-42e0-80f6-6b35cbc207bf@kernel.org>
 <20260816181519.88865-1-rishabh.jain1198@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260816181519.88865-1-rishabh.jain1198@gmail.com>

On Sun, Aug 16, 2026 at 11:15:19AM -0700, Rishabh Jain wrote:
> The xHCI ownership protocol requires the OS driver to assert the HC OS
> Owned semaphore before using the host controller, then wait for HC BIOS
> Owned to clear if firmware owns it.
> 
> quirk_usb_handoff_xhci() currently asserts OS Owned only when BIOS Owned
> is already set. If firmware leaves BIOS Owned clear, Linux uses the xHC
> while both ownership semaphores remain clear.
> 
> On an AMD PROM21 xHCI controller (1022:43fc), this caused every S3
> resume to terminate Controller Restore State with USBSTS 0x401. Linux
> then reset the host controller, both root hubs and the USB Bluetooth
> adapter.
> 
> The controller entered resume ready and halted with USBSTS 0x1.
> Endpoint state, 100 ms save/restore delays, scratchpads, the DCBAA,
> device contexts and command, event and transfer rings were verified not
> to cause the restore error.
> 
> Asserting only HC OS Owned changed USBLEGSUP from 0x00000801 to
> 0x01000801 and eliminated the restore failure across four S3 cycles,
> including a stock-kernel test. Clearing USBLEGCTLSTS was independently
> verified to be unnecessary.
> 
> Always assert OS Owned when the xHCI Legacy Support capability is
> present. Use the existing ownership masks with a single initial register
> read/write, and leave a debug breadcrumb when firmware owns the
> controller. Keep the existing BIOS handoff recovery and legacy SMI
> cleanup unchanged.
> 
> Fixes: 66d4eadd8d06 ("USB: xhci: BIOS handoff and HW initialization.")
> Tested-by: Rishabh Jain <rishabh.jain1198@gmail.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Rishabh Jain <rishabh.jain1198@gmail.com>

Tested-by: is implied if you sign off on a patch, no need to include it.



> ---
> Ah, agreed, I didn't see XHCI_HC_OS_OWNED is defined! The +3 in v1 was
> for selecting byte 3 of USBLEGSUP.
> 
> I've simplified v2 to use the existing ownership masks, one initial
> read/write (makes sense to batch the writes), and the debug breadcrumb
> you suggested.
> 
> Changes in v2:
> - Use XHCI_HC_OS_OWNED instead of byte-offset access.
> - Fold the TI/Renesas forced handoff into the ownership-register write.
> - Add a debug breadcrumb when BIOS ownership is initially set.
> - Make the BIOS handoff wait unconditional and gate recovery on the initial
>   BIOS ownership state.
> 
> Additional context:
> 
> * Kernel Bugzilla #216470 documents the same USBSTS 0x401/reinitialize
>   behavior and its impact on attached USB devices:
>   https://bugzilla.kernel.org/show_bug.cgi?id=216470
> 
> * Commit a7d57abcc8a5 ("xhci: workaround CSS timeout on AMD SNPS 3.0
>   xHC") is related workaround history: it tolerates a distinct AMD CSS
>   timeout and resets the controller on resume:
>   https://github.com/torvalds/linux/commit/a7d57abcc8a5bdeb53bbf8e87558e8e0a2c2a29d
> 
> The external reports do not record their ownership semaphore values but
> are included as corroborating failure signatures that this might fix.
> 
>  drivers/usb/host/pci-quirks.c | 30 +++++++++++++++---------------
>  1 file changed, 15 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/usb/host/pci-quirks.c b/drivers/usb/host/pci-quirks.c
> index 0404489c2f6a..29e635a036a6 100644
> --- a/drivers/usb/host/pci-quirks.c
> +++ b/drivers/usb/host/pci-quirks.c
> @@ -1185,31 +1185,31 @@ static void quirk_usb_handoff_xhci(struct pci_dev *pdev)
>  		dev_warn(&pdev->dev, "xHCI controller failing to respond");
>  		goto iounmap;
>  	}
> +
>  	val = readl(base + ext_cap_offset);
> +	if (val & XHCI_HC_BIOS_OWNED)
> +		pci_dbg(pdev, "BIOS owns xHCI HC\n");

Who needs this new message?

thanks,

greg k-h
