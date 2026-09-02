Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF368233954
	for <stable@vger.kernel.org>; Wed,  2 Sep 2026 03:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788319599; cv=none; b=OFnvITcXlvsjYP6bCSogyE4oDhvMq65OtThhowr7Q3H9CJf+m555DyF6qbNV3Seayx0Mo5cQj5LGA8sDc+8tQYOjzH+zbOvf3n1N70uOM5mYn8Wnw9ubIGldhyKC4Jjt1Gxk38Tp9lSowu5P7jPF9DtDhNvsvBHiHc7HPwBnWXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788319599; c=relaxed/simple;
	bh=96wvEPiwPZfR78LElYmLqc+vqsPLRsuVXQK+WuAbyd4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ts4hn+0RRYlW4zH6r9+Q/TDr4v6w+ZURP6W/hMpVIzIcTeBS7yYZgC5jT1AQWFmG8KK50nd/LA/ejm7fjt52fr0daU+R2B/nzEoX9X0fXWfv0fhyHR6VNtpqDFquFITeuYCSHowtPYPXc5r9oGvSpjmPOwnnfcUzTUCniAc+B8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zcs3JbQr; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zcs3JbQr"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-4843efcbdb2so313618f8f.2
        for <stable@vger.kernel.org>; Tue, 01 Sep 2026 20:26:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788319596; x=1788924396; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=CWAV+LvRXqnUBhlcQBpGfOksFpIYqg+MNUT0HrN6l6o=;
        b=Zcs3JbQrig9Xlfw2jzMfNoBFox3oNzg7sc2oQjzk8pEJYhEZIBSJYlPEyGxLqxMCul
         o9n+aO5tyh9N6PMudI14ZJ/Ij6PZFbiHi3ZgI/t2bv4qAAAIJAV/IEa+cUfGmXv215hx
         3nZHCSXVc1E4w6K50I76RH0OuBSbymioEB56Bs6liCDlv/OzhMM481qw2xGX2JpoAGQt
         zJxa2r5NZYMpqAmD4r9qv5Z1aSSb1JlPyz36FyCtbU0+OjRoaVHojQL7yxYgWfw/9Qy7
         YAKWyG3V4AQdmB6Ss1Ecz1lhEk8MksKufAZ+ShfZJa7qX0uefaig5NfAsGJ9BHhEkSMN
         SHow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788319596; x=1788924396;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CWAV+LvRXqnUBhlcQBpGfOksFpIYqg+MNUT0HrN6l6o=;
        b=U8IEpS548NlmAcNxTRsvO+TPeDY+PlcMsrRWDyhI8YE2i5Qug5s1koEvLIb3+kR+P/
         nraX3pUseQ0kNagsAMV9kkTyJsJYzujGUDRm8SOChRRfqCpOL/QcEPThV8LAMlz5PI88
         2ebdsuxw5xWWAuls2pZ7jd+sjfnVbpdGYSldOuFazhMApIyuCxgtrs1rdR4q7oGLjafp
         zbVO9wzk9d9yEOBcCoLY+X8SzUPEjx2YjIo5+STUnrYceODTlfssZnOJHnZcF/vjs+Qc
         idGMcM/f5Aylk/vYlIGShRYPbLWiJsVlzlAeJ8KS9IO7iscD3Be894xUm5LETLoOi2Om
         UpSg==
X-Forwarded-Encrypted: i=1; AKwUvBxL6I8Hyj5HH1hp/0GmOxdVFb69r1+J/kNuYsPOjIapRBbpEPm5tB6E28fGljSl20cti68zJco=@vger.kernel.org
X-Gm-Message-State: AFuF++kcIjNgcEkYwfjUUVXIPhUDHlDEBkFRTiDkF24Z3Lz60sD7h3mM
	LScBT6vE0OKkdwK2jnSCD5tbJT9M41zkRfaJEnvokYq/8DnR+vMgk9Xe
X-Gm-Gg: AYBFou3/zluZRynkPTTctrSIMY8TvMKYiC4mPnGtjwzlEDcr5UpBwHfxof8+Lb0dLEF
	1hP3dxMGDZB6yiWAq9k8R+FTs6dLo+Yu3jfXivhQZ+absZL1vHtKHpkcn8s56YTLp/OhbPf+Jof
	3HKJszPaMePDX/xVQ/gYeiBGkcDAJgkSMraqeyOp7nisdcCGnrjfprbTsrkP8AnqHCNpEUdr6/h
	J4+Ni0Z9xjSYZmpNoNEghrGm/cPCRdVG+Ymo7aSSbCtK2JrKuRv7lR4HvxLjVGBECGlcb1abIbf
	gdFWypwyCf8wTD8MRyQm3ke07YVS3IIA9+6a6PY3oJ76XkIH5IdIvawBP1GVDx2P88HPvCrWhIK
	uKjSfCN63BkaEDYucAddAaxNekGmpkuqf1A2ZUbjBGWzNCDrx4DpASdp3nPdXpxXFD81NLl3PGp
	t/NxB0lJJ8xd1ubTcwrV9s7dizObAFhQPli3yZQTYBKTWEfFtB7eO8bVJpO/UG8aeIf3c=
X-Received: by 2002:a05:6000:4a0a:b0:484:39b4:5bc9 with SMTP id ffacd0b85a97d-484914cba9amr2358765f8f.26.1788319595898;
        Tue, 01 Sep 2026 20:26:35 -0700 (PDT)
Received: from foxbook (bfk5.neoplus.adsl.tpnet.pl. [83.28.48.5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48448e7f8f9sm3312839f8f.9.2026.09.01.20.26.34
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 01 Sep 2026 20:26:34 -0700 (PDT)
Date: Wed, 2 Sep 2026 05:26:31 +0200
From: Michal Pecio <michal.pecio@gmail.com>
To: Rishabh Jain <rishabh.jain1198@gmail.com>
Cc: Mathias Nyman <mathias.nyman@intel.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Mario Limonciello <superm1@kernel.org>,
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH v4] usb: pci-quirks: always assert xHCI OS ownership
Message-ID: <20260902052631.75c6068b.michal.pecio@gmail.com>
In-Reply-To: <178831224746.44206.8934470315568179153@gmail.com>
References: <20260831211126.23745-1-rishabh.jain1198@gmail.com>
	<178831224746.44206.8934470315568179153@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 01 Sep 2026 18:24:07 -0700, Rishabh Jain wrote:
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
> Across four S3 cycles, asserting only HC OS Owned changed USBLEGSUP from
> 0x00000801 to 0x01000801 and eliminated the restore failure. Testing
> included the unmodified 7.1.8-ogc1.1.fc44.x86_64 distribution kernel
> using a test module that set the HC OS Owned semaphore. Clearing
> USBLEGCTLSTS was independently verified to be unnecessary.
> 
> Always assert OS Owned for controllers using the standard xHCI handoff,
> and leave the existing TI/Renesas forced handoff unchanged. Keep OS
> Owned asserted after the standard handoff to prevent firmware from
> reclaiming the controller during subsequent suspends.
> 
> Fixes: 66d4eadd8d06 ("USB: xhci: BIOS handoff and HW initialization.")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Rishabh Jain <rishabh.jain1198@gmail.com>
> ---
> Thanks for the review.
> 
> By "stock-kernel test", I meant that the register change was tested on
> the unmodified 7.1.8-ogc1.1.fc44.x86_64 distribution kernel using a test
> module that set the HC OS Owned semaphore.
> 
> Sorry, I missed the AI assistant guidelines. Fixed now.
> 
> The TI/Renesas forced-handoff path is restored unchanged. This revision
> only changes the standard handoff path. I left the byte-access change
> out of this patch.
> 
> Changes in v4:
> - Preserve the existing TI/Renesas forced-handoff path.
> - Limit the ownership change to the standard handoff path.
> 
>  drivers/usb/host/pci-quirks.c | 17 ++++++++++-------
>  1 file changed, 10 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/usb/host/pci-quirks.c b/drivers/usb/host/pci-quirks.c
> index 0404489c2f6a..fa9b5db4d115 100644
> --- a/drivers/usb/host/pci-quirks.c
> +++ b/drivers/usb/host/pci-quirks.c
> @@ -1193,22 +1193,25 @@ static void quirk_usb_handoff_xhci(struct pci_dev *pdev)
>  			 && pdev->device == 0x0014)) {
>  		val = (val | XHCI_HC_OS_OWNED) & ~XHCI_HC_BIOS_OWNED;
>  		writel(val, base + ext_cap_offset);
> -	}
> -
> -	/* If the BIOS owns the HC, signal that the OS wants it, and wait */
> -	if (val & XHCI_HC_BIOS_OWNED) {
> -		writel(val | XHCI_HC_OS_OWNED, base + ext_cap_offset);
> +	} else {
> +		/*
> +		 * Perform the standard handoff and leave OS ownership set to
> +		 * keep the BIOS at bay during subsequent suspends.
> +		 */
> +		val |= XHCI_HC_OS_OWNED;
> +		writel(val, base + ext_cap_offset);

The change from val|OS_OWNED to val|=OS_OWNED doesn't seem necessary.

>  
>  		/* Wait for 1 second with 10 microsecond polling interval */
>  		timeout = handshake(base + ext_cap_offset, XHCI_HC_BIOS_OWNED,
> -				0, 1000000, 10);
> +				    0, 1000000, 10);

And this whitespace tweak isn't either.

>  
>  		/* Assume a buggy BIOS and take HC ownership anyway */
>  		if (timeout) {
>  			dev_warn(&pdev->dev,
>  				 "xHCI BIOS handoff failed (BIOS bug ?) %08x\n",
>  				 val);

Note that val is being logged here in case of error. It's probably
better to preserve the original value for this purpose. We *know* that
the code above tried to add OS_OWNED, but we don't know whether it was
set before or not. Not sure if we will ever want to know, but still...

> -			writel(val & ~XHCI_HC_BIOS_OWNED, base + ext_cap_offset);
> +			writel(val & ~XHCI_HC_BIOS_OWNED,
> +			       base + ext_cap_offset);

OK, I see, this could unintentionally clear OS Owned together with BIOS
Owned. This can be prevented by explicitly oring OS Owned here. And it
would make sense to document this problem in the commit message if you
are trying to solve it in this patch.

Other than that, I think this looks good. Just in caes, pease test the
final version once more to ensure we haven't broken something.

>  		}
>  	}
>  
> -- 
> 2.50.1 (Apple Git-155)
> 
