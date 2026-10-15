Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51E3949C4C7
	for <stable@vger.kernel.org>; Thu, 15 Oct 2026 09:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792055860; cv=none; b=SdVnkuNPTI6Mo2LxNJKlBvwyF2EJQFrJx9+6W3AV/FotpMMZOUHgUtMaH6VEvVpVU1oK1CQksc5CwbvUjzm4oiG1eYm4/4BSK5a672TQtuPsZiXf+IzE2hT85NvZ+iEzX2jwfWckFRnPYvUif56pw/n2QKex+bUWLnuSfqgAv+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792055860; c=relaxed/simple;
	bh=IyAZ5pkLnMxh94MB73YiJMR++H7wpdk5msxW3CzpIr8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O2cKTaTmnQkJXiVRW/v1NPVGBwqVw3Kd/s08UUTppGRoAAdaPgVzbSpPYIH3YfZBGJcAhi9wTyFCT0LM/3x7qWnvjLK6TuhzdGP000MjvXmW4I0H2aGI84i0g6RYl4T0/jSeSKJNSSRRhlbeydO43sR+/2lOErIOldFefEl3U7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=flDoxF/L; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="flDoxF/L"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4a16aaf2067so22936555e9.0
        for <stable@vger.kernel.org>; Thu, 15 Oct 2026 02:17:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792055857; x=1792660657; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ylxkGWPRhbu3wMGo/t9b6unbwGCeSJctOEWu1P2KuE8=;
        b=flDoxF/LpcIqI0znL5gDzl8mSaP/F2cVRDzFPmsH+Z0PoO75VrN87kYckUGBhHuF6j
         ULyWq3oXGZ4GBIa2HztDtxbSiY2aI3NIUqySMdCH4uF5kdEbtex/7qLcq98iDBm1QIoj
         wbl0D/BiAhGbE6XbBuX7g7EgjRRTKX4bmZiTbc8mJfMrBqZZZfufaFXqsZJa72tNd/6B
         rqqDFwd2BB+6x9tztoOHIMifZsW5/cqoccGXrVBtF7EH8lymZoh9VRnMTvRyRNsna3Kj
         woG4PtvWWALQ+xgmIgiSfDUBJU4d64Uf3AfUnGAVJ7pKxbiAbeZFeA9/Q+916wCdWkDz
         E7lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792055857; x=1792660657;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ylxkGWPRhbu3wMGo/t9b6unbwGCeSJctOEWu1P2KuE8=;
        b=2nd7gaotyS9sTgSqcDNONExPSjoIEBB+pdDQjFOKELc+H1iGbwsZKOsq/1jxzwiU0d
         j5RpnbhuxJi5zxUN5A1c2Kws3uPx8pU+lJk+wCJ8kpzOZegYa/kvmjaqRPc7d57GycqW
         TiAi0jFudaM5kNUKhWIcauoaNYsM6nKKBMv0tgSRXWbgqPYRoe4Eqp6NG9U/lVOxSJLd
         gKIDVkUFGYAKo0q97Q/2z9t2ZJv8Z4efIITmbH8K1ojqn0dPScZ17MjcGGATHipLyslf
         qMcevnXOXdEaifOjHk9MWxB49QuA5D3JUliJA4TwmTcHlVN/YDhz6gnQLDnp/23j8Eo4
         clvQ==
X-Forwarded-Encrypted: i=1; AKwUvBwGUstAxgansI8BwoLlsT5gERyGRdcflbPDl+/+Vi28gEXiMpzbE1jbORGmmxDNS42qpf6ucAs=@vger.kernel.org
X-Gm-Message-State: AFq9FYJnk4R1v+QWO7atBdxhbiJkdoZypE1gQsfaZChzfds524psudlg
	1JZxu3ZtGGQkMBYteLUUXlzqrgTUNF2d8s+0LH12/CjX28hRs2/Y7Oly
X-Gm-Gg: AYBFou2Oh3WCguXRoqQcvgol7X7NCEdsuxX65ZyUOyG7cL55dFZ6YW60VpdGMgaaDbd
	YcTn8otUK8nI98DKQQ/kpHBabReM8jovaHvE94DZWGKNTqJgYEUWYBK2jowdC4vmO0O47NJ+5mi
	ZpXxFqvuljnGZB9qyu7/IhzffIEZuXioLcRlnN6VFal+muA0wD8jQBlG3eXcHpVBE81+N3qR/Ef
	2hkQj/N1twoZJtb7WWZiK1CJfki25M0WjptrqEsJJD72Cp3TUcAvpqmuwmCksVq4p9h+TWefmrX
	+D0kiCK6KpTI4O9ZCVoJFogPynSyKybrgNns5aYn59poIl9nG7e03dW5euppvP9MHCcflntw2Gy
	sGQgOqg7ECtrV+NYQvYs8Gmv1rnZ3eh1jSXphhSCG0+C3jb0NdEJAkRITFK+nnSehWXo8ryMG5f
	IXpzFHf8izac0QGBb7tgURfAJwWQ1xpZMrcYyjJKCQ7khNuCF6WRgC2LBZzWrGHr/DR1cFIRiUA
	KCTeR7gn+c=
X-Received: by 2002:a05:600c:3111:b0:4a0:159b:d2a2 with SMTP id 5b1f17b1804b1-4a18e4e14e8mr351253395e9.29.1792055857375;
        Thu, 15 Oct 2026 02:17:37 -0700 (PDT)
Received: from foxbook (bez186.neoplus.adsl.tpnet.pl. [83.28.37.186])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48de72d2b13sm12304181f8f.55.2026.10.15.02.17.36
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 15 Oct 2026 02:17:37 -0700 (PDT)
Date: Thu, 15 Oct 2026 11:17:33 +0200
From: Michal Pecio <michal.pecio@gmail.com>
To: Mario Limonciello <superm1@kernel.org>
Cc: Rishabh Jain <rishabh.jain1198@gmail.com>, Mathias Nyman
 <mathias.nyman@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH v5] usb: pci-quirks: always assert xHCI OS ownership
Message-ID: <20261015111733.5ead367c.michal.pecio@gmail.com>
In-Reply-To: <7d64e267-8ca6-4130-bd4a-d80fb4224f72@kernel.org>
References: <20260902052631.75c6068b.michal.pecio@gmail.com>
	<178832755831.50581.1058201741431375556@gmail.com>
	<7d64e267-8ca6-4130-bd4a-d80fb4224f72@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 12 Oct 2026 15:14:14 -0500, Mario Limonciello wrote:
> On 9/2/26 00:39, Rishabh Jain wrote:
> > The xHCI ownership protocol requires the OS driver to assert the HC OS
> > Owned semaphore before using the host controller, then wait for HC BIOS
> > Owned to clear if firmware owns it.
> > 
> > quirk_usb_handoff_xhci() currently asserts OS Owned only when BIOS Owned
> > is already set. If firmware leaves BIOS Owned clear, Linux uses the xHC
> > while both ownership semaphores remain clear.
> > 
> > The timeout fallback also clears BIOS Owned using the original register
> > value, which can clear OS Owned at the same time.
> > 
> > On an AMD PROM21 xHCI controller (1022:43fc), this caused every S3
> > resume to terminate Controller Restore State with USBSTS 0x401. Linux
> > then reset the host controller, both root hubs and the USB Bluetooth
> > adapter.
> > 
> > The controller entered resume ready and halted with USBSTS 0x1.
> > Endpoint state, 100 ms save/restore delays, scratchpads, the DCBAA,
> > device contexts and command, event and transfer rings were verified not
> > to cause the restore error.
> > 
> > Across four S3 cycles, asserting only HC OS Owned changed USBLEGSUP from
> > 0x00000801 to 0x01000801 and eliminated the restore failure. Testing
> > included the unmodified 7.1.8-ogc1.1.fc44.x86_64 distribution kernel
> > using a test module that set the HC OS Owned semaphore. The same test
> > was repeated after review with the same result. Clearing USBLEGCTLSTS
> > was independently verified to be unnecessary.
> > 
> > Always assert OS Owned for controllers using the standard xHCI handoff,
> > and leave the existing TI/Renesas forced handoff unchanged. Keep OS
> > Owned asserted after the standard handoff, including when forcing BIOS
> > Owned clear after a timeout, to prevent firmware from reclaiming the
> > controller during subsequent suspends.
> > 
> > Fixes: 66d4eadd8d06 ("USB: xhci: BIOS handoff and HW initialization.")
> > Cc: stable@vger.kernel.org
> > Assisted-by: LLM
> > Signed-off-by: Rishabh Jain <rishabh.jain1198@gmail.com>
> > ---  
> 
> Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>

Yes, this fixes a legit issue and would be worth getting in mainline.
Two users confirmed the patch works for them, though no one could be
bothered to post proper Tested-by here :(

https://lore.kernel.org/linux-usb/P1FsfbW--F-9@tuta.io/
https://lore.kernel.org/linux-usb/CY8PR14MB59803EC0F6C7FD39A6D3C42FA0BF2@CY8PR14MB5980.namprd14.prod.outlook.com/

> 
> > I kept val unchanged for the error log, restored the original handshake
> > formatting, and explicitly preserve OS Owned when forcing BIOS Owned
> > clear after a timeout. Documented timeout issue in commit message.
> > 
> > I repeated the same S3 test on the unmodified
> > 7.1.8-ogc1.1.fc44.x86_64 distribution kernel using the test module, with
> > the same successful result.
> > 
> > Changes in v5:
> > - Preserve the original ownership value for error logging.
> > - Restore the original handshake formatting.
> > - Explicitly retain OS Owned in the timeout fallback.
> > 
> >   drivers/usb/host/pci-quirks.c | 13 ++++++++-----
> >   1 file changed, 8 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/usb/host/pci-quirks.c b/drivers/usb/host/pci-quirks.c
> > index 0404489c2f6a..2b12a35e6f10 100644
> > --- a/drivers/usb/host/pci-quirks.c
> > +++ b/drivers/usb/host/pci-quirks.c
> > @@ -1193,10 +1193,11 @@ static void quirk_usb_handoff_xhci(struct pci_dev *pdev)
> >   			 && pdev->device == 0x0014)) {
> >   		val = (val | XHCI_HC_OS_OWNED) & ~XHCI_HC_BIOS_OWNED;
> >   		writel(val, base + ext_cap_offset);
> > -	}
> > -
> > -	/* If the BIOS owns the HC, signal that the OS wants it, and wait */
> > -	if (val & XHCI_HC_BIOS_OWNED) {
> > +	} else {
> > +		/*
> > +		 * Perform the standard handoff and leave OS ownership set to
> > +		 * keep the BIOS at bay during subsequent suspends.
> > +		 */
> >   		writel(val | XHCI_HC_OS_OWNED, base + ext_cap_offset);
> >   
> >   		/* Wait for 1 second with 10 microsecond polling interval */
> > @@ -1208,7 +1209,9 @@ static void quirk_usb_handoff_xhci(struct pci_dev *pdev)
> >   			dev_warn(&pdev->dev,
> >   				 "xHCI BIOS handoff failed (BIOS bug ?) %08x\n",
> >   				 val);
> > -			writel(val & ~XHCI_HC_BIOS_OWNED, base + ext_cap_offset);
> > +			writel((val | XHCI_HC_OS_OWNED) &
> > +			       ~XHCI_HC_BIOS_OWNED,
> > +			       base + ext_cap_offset);
> >   		}
> >   	}
> >     
> 
