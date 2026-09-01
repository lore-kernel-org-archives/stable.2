Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09AFE47A0DE
	for <stable@vger.kernel.org>; Tue,  1 Sep 2026 10:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788257636; cv=none; b=sfg4QiszfPmJvnWuqZJezJTed4YcDS5XEjyP02dw428N3DMsudNwgtjvxGSbnBKHvTJVmWOU3WinM5qcDqY5qXj+iKOLeGuOf2HLkOPhZQ08iqnZo/dyhJ1h5j0CrO/Dcys9BuMkx4CPtzAhEmO+xi2golllybrRgUeGEU8cXlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788257636; c=relaxed/simple;
	bh=vRaD2X2xcCDuIb7uPDzMrYCycckWIwEhrOsQLCzY4gw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mqxvAqnjYbOhjCgtGMBfXf8HPJ+lsTla4MHzA0kmtW5G4nlQncMKILK32nix9NN50+b4OuUGuiSLPCCm3L+6kunRFslpROkJPrDkRZolTL/C3m9nomRX4w6Y1jS0ho1bX2kTgJQnqfMHP3/SsT7LvLbJLdXShT2BhfVW4vwBKgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=APqieEQp; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="APqieEQp"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-48441fa5c37so574264f8f.3
        for <stable@vger.kernel.org>; Tue, 01 Sep 2026 03:13:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788257631; x=1788862431; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=pGMhkf3RCMEctq3umyHGO3MvdxWxMBbojsHlqXM+5wA=;
        b=APqieEQp6y/pDSLkyyFvsLRHl6q9sC4Tr9EFLRo3oTWYbayTZQAe7J7PUnSc3jxj7m
         WWz2ux3RjctnjGgMotx4ePkqveVvOQb0jpnNrMxFQCylUT26Ai16WBvqMnIGohTLKQVH
         kds4HhjdxvxIcXqVHfk4F0OrJxJP1S3n3GZDAFVvYuiBSggLUqsz1pdCeBcizHS7HZjz
         w2a6heWN96qF2anyQUx5mCIMBqDZXManH365MvdNLWw5zEEplk5gtkLX2vSFX5Nih0r1
         U7CU2m2qxCeDMCKiONjqCC8AC0H4EPc8iNbhhsu3a1OOt5e1ZEtMal1VSA5BroyLkHfC
         8kMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788257631; x=1788862431;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pGMhkf3RCMEctq3umyHGO3MvdxWxMBbojsHlqXM+5wA=;
        b=LJl5K+AzeHANDIlAFn9I6cWqltI58iMaTQJzxf+Chy+wpu86VTYwOIad1C316yWZOW
         BF64CSsm6RTsC8bO5Ffp8cuo4deozgRvqOznydHOl/P41K7y90Hs3YzKimSIkSeEMBEQ
         O/Z3AXqKjq4oLsOohExrgVLA9+P5GW5s58qXjvbL23NWIieRvdig2gbjkAuMuFL8Hdge
         Wghao0+7lyMg3bRQXTJBDzF2MJxd5ANyvI9qcsXVflmuo/wWe5D73S6hE5kDKHwqaHEJ
         mJmG7Eufxua7UItmcrdZgO0ipNTmtlDkvzZ7jPZ/jh0srRugssSM5yp/KZXj3Xw3lD2p
         loSw==
X-Forwarded-Encrypted: i=1; AHgh+RrlpmGnLoEke0GfCfdxEyX/TFpvOMpdBd43NEoPOqjiyUlFAFfQoB7Uo5bEJTSaj5vQT/oUoQg=@vger.kernel.org
X-Gm-Message-State: AFuF++npeMq9jcOLk4tv41ayehSNlTUlXkmCwqdLGIKcB+tWrthfyM7u
	tF6AuN3kZg3aeM9pxXIf+j/mvWWcMLBS5mklED/4ZNWu8ZKH+yc+dOjj
X-Gm-Gg: AR+sD12kMHz6LnKSMIDrEKxwuZz23/f8DnNb478367NIkRjQY4IREcBnAW/7f1Rc7vc
	fmrCjRkXsH3J6uTA9SJWcQJw5p2VU4GEd8r9w7p5cINRePM/vAhK5U/lCpMnfpOacEuedzd9K/7
	B4L7s8L8oGX+vWVlckR2djQOsHEzy3U4DugPmuuHAmPM2mytKaDJvIl9j6DMiTCw4CbGxK0pqMw
	UYU0aJb+cWaLvyfd8X8RFwCJLDz0bdh5aTIRm+N2XnyQS6CxpcQ+2cI+P/kzT8fdh7AqRvjG0je
	ssXgL8FYxus7s+GLrvJPDZMoZI6TY+1WuhTlDiUIaTFnv0n/Wzdxm2dv/ZUwdeHPDhK7RdNNEPY
	wBENCoSz22Yg3s7C7to2nv8HzsnCUCeOQ4tPb23W1XoiNJiTYKWaRQDdQZiRiEM5Rxv6HZkfv9y
	O7tJ8sMw4Pk1unmF+nfPqzMWiaTxMDVyA/5SdLVUY3UpvV2zzqlUMynQHPrcP1XqJdhvnq6p7Q7
	vXGuQ==
X-Received: by 2002:a05:600c:c494:b0:499:8aff:59b6 with SMTP id 5b1f17b1804b1-49b91c486c3mr408787555e9.14.1788257630883;
        Tue, 01 Sep 2026 03:13:50 -0700 (PDT)
Received: from foxbook (bfk5.neoplus.adsl.tpnet.pl. [83.28.48.5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cdcdd5f5esm54249965e9.0.2026.09.01.03.13.49
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 01 Sep 2026 03:13:50 -0700 (PDT)
Date: Tue, 1 Sep 2026 12:13:43 +0200
From: Michal Pecio <michal.pecio@gmail.com>
To: Rishabh Jain <rishabh.jain1198@gmail.com>
Cc: Mathias Nyman <mathias.nyman@intel.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Mario Limonciello <superm1@kernel.org>,
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH v3] usb: pci-quirks: always assert xHCI OS ownership
Message-ID: <20260901121343.22786f2d.michal.pecio@gmail.com>
In-Reply-To: <20260831211126.23745-1-rishabh.jain1198@gmail.com>
References: <2026083129-justice-egomaniac-01cd@gregkh>
	<20260831211126.23745-1-rishabh.jain1198@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 31 Aug 2026 14:11:26 -0700, Rishabh Jain wrote:
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

Not sure what you mean by a "stock-kernel test"?

> 
> Always assert OS Owned when the xHCI Legacy Support capability is
> present. Use the existing ownership masks with a single initial register
> read/write. Keep the existing BIOS handoff recovery and legacy SMI
> cleanup unchanged.
> 
> Fixes: 66d4eadd8d06 ("USB: xhci: BIOS handoff and HW initialization.")
> Cc: stable@vger.kernel.org
> Signed-off-by: Rishabh Jain <rishabh.jain1198@gmail.com>

Does this submission comply with the attribution rulese here?
https://docs.kernel.org/process/coding-assistants.html

> ---
> Changes in v3:
> - Drop the unnecessary BIOS ownership debug message.
> - Drop the redundant self Tested-by tag.
> 
> Changes in v2:
> - Use XHCI_HC_OS_OWNED instead of byte-offset access.
> - Fold the TI/Renesas forced handoff into the ownership-register write.
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
>  drivers/usb/host/pci-quirks.c | 27 ++++++++++++---------------
>  1 file changed, 12 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/usb/host/pci-quirks.c b/drivers/usb/host/pci-quirks.c
> index 0404489c2f6a9..52d41ac5daa85 100644
> --- a/drivers/usb/host/pci-quirks.c
> +++ b/drivers/usb/host/pci-quirks.c
> @@ -1191,25 +1191,22 @@ static void quirk_usb_handoff_xhci(struct pci_dev *pdev)
>  	if ((pdev->vendor == PCI_VENDOR_ID_TI && pdev->device == 0x8241) ||
>  			(pdev->vendor == PCI_VENDOR_ID_RENESAS
>  			 && pdev->device == 0x0014)) {
> -		val = (val | XHCI_HC_OS_OWNED) & ~XHCI_HC_BIOS_OWNED;
> -		writel(val, base + ext_cap_offset);
> +		val &= ~XHCI_HC_BIOS_OWNED;
>  	}

I'm not sure why touching this code has been suggested to you. You
don't have this hardware, you can't test this change, and it isn't
required for achieving your goal.

[Actually, I doubt this whole code and the (not visible here) comment
above it, because nobody had issues with uPD720200 and uPD720202, so
it's unlikely that uPD720201 is broken. Probably this was a workaround
for someone's buggy BIOS. But I'm digressing.]

A stable bugfix is a particular case where one commit should do one
thing and do it well. So it should preserve the original behavior for
"broken" chips and only affect those chips where we do actually try
to perform the handoff handshake in accordance with xHCI spec.

So this is the actual change you wanted to do:

> -	/* If the BIOS owns the HC, signal that the OS wants it, and wait */
> -	if (val & XHCI_HC_BIOS_OWNED) {

and to preserve existing "broken chip" behavior, you could add

+ } else {
+ 	/* Perform standard handshake and leave OS_OWNED set
+        * to keep the BIOS at bay during subsequent suspends

And it seems that this is enough.

However, as v1 rightly pointed out, this code is dubious because
it performs read-modify-write on the whole DWORD, of which the
BIOS_OWNED bit may be concurrently modified by the BIOS (though it
isn't clear if that would ever happen under any circumstances).

So the change from writel() to writeb() in v1 actually made sense,
maybe as a separate patch because it's a separate change. xHCI spec
is clear that HW must support writeb() accesses to this register,
exactly for this reason, so regression risk seems low.

Regards,
Michal
