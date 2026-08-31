Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D800137189C;
	Mon, 31 Aug 2026 21:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788211660; cv=none; b=Ww6UHTuEV3TiSAVFtW8MK/f5BeSD+nycpu3K+0rcDyEJXK9Ums/uQjphh+MBhE7S9G8CnlM1yEnYqk9UyZCKpOAAfhHY8FwUf0qRZEvWo8U4JmVcQrLuhBM6JdRZnRk1LV57YG2RDqGAxQpzHeWELLNTe9/TeBWiJ6f6VvxHsvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788211660; c=relaxed/simple;
	bh=j/IL/Qt6kfJAF/KzPAMqe4zvR2J2gHo7Y7/J+EH+5qs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jzthRG+DUyDYSJLllPitRFBNYmE4fWECTm1PC7iWZWt3uOwQjLXmGUX+BthCIDWu8NMxX93ASqOoRpBMETNlODgvbLQUifnaSJTnizPBvqdIJonggmLLaR4Ld1b47sJwaJX1NpE9ZkJQbzsc87+vSW/Yn847snrUDeB6F3slIPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ij2dTxwz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ij2dTxwz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 170751F000E9;
	Mon, 31 Aug 2026 21:27:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788211658;
	bh=I7WDKw282IDUYm8QytKCMKjv27yy6DDhv7SSE6iTZCg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=Ij2dTxwzloLkAArxcTVpzOoY+P9bW/EToJ4GL3NNYN+PflBXqlENTi5suxq1q4Wrz
	 5LJRTJ/e1kxPZmqAvF1VKaqoteUG9FV4Et7+3URyzpZQdGLF1ikHnL6flUbWT7ZO5y
	 SA4lXI8shw/k5Vj8P3tqmoEo4O/T0h7PcrN0B0MxGQHsCxYvSC9QWxbJZHvqAQGLvm
	 90a2Y/t6nS963L1Ip3banSFZkjywr52kCxEtG8BQQKREOqGJ6EG519BIhZVv04sz9n
	 XDKBYDLVf3+btDtVhhCWJIpEEECPk/DNAth65obREUBIt2sRa0QRwIzWoWIRx31G9q
	 FRIEoTkLPFswg==
Message-ID: <9cbebb07-28a5-4491-b23d-bf4cb453ef11@kernel.org>
Date: Mon, 31 Aug 2026 16:27:37 -0500
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] usb: pci-quirks: always assert xHCI OS ownership
Content-Language: en-US
To: Rishabh Jain <rishabh.jain1198@gmail.com>,
 Mathias Nyman <mathias.nyman@intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Michal Pecio <michal.pecio@gmail.com>, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <2026083129-justice-egomaniac-01cd@gregkh>
 <20260831211126.23745-1-rishabh.jain1198@gmail.com>
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <20260831211126.23745-1-rishabh.jain1198@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/31/26 16:11, Rishabh Jain wrote:
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
> read/write. Keep the existing BIOS handoff recovery and legacy SMI
> cleanup unchanged.
> 
> Fixes: 66d4eadd8d06 ("USB: xhci: BIOS handoff and HW initialization.")
> Cc: stable@vger.kernel.org
> Signed-off-by: Rishabh Jain <rishabh.jain1198@gmail.com>
Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>> ---
> Changes in v3:
> - Drop the unnecessary BIOS ownership debug message.
> - Drop the redundant self Tested-by tag.
> 
> Changes in v2:
> - Use XHCI_HC_OS_OWNED instead of byte-offset access.
> - Fold the TI/Renesas forced handoff into the ownership-register write.
> - Make the BIOS handoff wait unconditional and gate recovery on the initial
>    BIOS ownership state.
> 
> Additional context:
> 
> * Kernel Bugzilla #216470 documents the same USBSTS 0x401/reinitialize
>    behavior and its impact on attached USB devices:
>    https://bugzilla.kernel.org/show_bug.cgi?id=216470
> 
> * Commit a7d57abcc8a5 ("xhci: workaround CSS timeout on AMD SNPS 3.0
>    xHC") is related workaround history: it tolerates a distinct AMD CSS
>    timeout and resets the controller on resume:
>    https://github.com/torvalds/linux/commit/a7d57abcc8a5bdeb53bbf8e87558e8e0a2c2a29d
> 
> The external reports do not record their ownership semaphore values but
> are included as corroborating failure signatures that this might fix.
> 
>   drivers/usb/host/pci-quirks.c | 27 ++++++++++++---------------
>   1 file changed, 12 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/usb/host/pci-quirks.c b/drivers/usb/host/pci-quirks.c
> index 0404489c2f6a9..52d41ac5daa85 100644
> --- a/drivers/usb/host/pci-quirks.c
> +++ b/drivers/usb/host/pci-quirks.c
> @@ -1191,25 +1191,22 @@ static void quirk_usb_handoff_xhci(struct pci_dev *pdev)
>   	if ((pdev->vendor == PCI_VENDOR_ID_TI && pdev->device == 0x8241) ||
>   			(pdev->vendor == PCI_VENDOR_ID_RENESAS
>   			 && pdev->device == 0x0014)) {
> -		val = (val | XHCI_HC_OS_OWNED) & ~XHCI_HC_BIOS_OWNED;
> -		writel(val, base + ext_cap_offset);
> +		val &= ~XHCI_HC_BIOS_OWNED;
>   	}
>   
> -	/* If the BIOS owns the HC, signal that the OS wants it, and wait */
> -	if (val & XHCI_HC_BIOS_OWNED) {
> -		writel(val | XHCI_HC_OS_OWNED, base + ext_cap_offset);
> +	val |= XHCI_HC_OS_OWNED;
> +	writel(val, base + ext_cap_offset);
>   
> -		/* Wait for 1 second with 10 microsecond polling interval */
> -		timeout = handshake(base + ext_cap_offset, XHCI_HC_BIOS_OWNED,
> -				0, 1000000, 10);
> +	/* Wait for 1 second with 10 microsecond polling interval */
> +	timeout = handshake(base + ext_cap_offset, XHCI_HC_BIOS_OWNED,
> +			    0, 1000000, 10);
>   
> -		/* Assume a buggy BIOS and take HC ownership anyway */
> -		if (timeout) {
> -			dev_warn(&pdev->dev,
> -				 "xHCI BIOS handoff failed (BIOS bug ?) %08x\n",
> -				 val);
> -			writel(val & ~XHCI_HC_BIOS_OWNED, base + ext_cap_offset);
> -		}
> +	/* Assume a buggy BIOS and take HC ownership anyway */
> +	if (timeout && (val & XHCI_HC_BIOS_OWNED)) {
> +		dev_warn(&pdev->dev,
> +			 "xHCI BIOS handoff failed (BIOS bug ?) %08x\n",
> +			 val);
> +		writel(val & ~XHCI_HC_BIOS_OWNED, base + ext_cap_offset);
>   	}
>   
>   	val = readl(base + ext_cap_offset + XHCI_LEGACY_CONTROL_OFFSET);

