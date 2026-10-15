Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3471E522EFB;
	Thu, 15 Oct 2026 13:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792069274; cv=none; b=uJfWpSsGRgzHRSaa4Huf60ALRLnBYB52ABFoBWVwQ89yGZW55SD2hOGGEh02FuJdQaGySL/PAGw/lJcGrL2IjQRA14i+4vRNHmj3+XowApPJVM1WtiunKxxG7EMEFfhc76eLstbDQRyrjpt0LvQNoN33sSkb8pQImhCG6a7GLZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792069274; c=relaxed/simple;
	bh=KNSXJi+NNEtUDlRfnbNAIaRITk+Ou1thMrl7TK66NH0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hL8orCGZWos0xVuQG9iACpeKi8rZykIuVyH44GkmzGCFEqBZVDW59+CfLCJVygLtxxyY+PE2pvZcwKIy90QvF8uixT8wvZ5HQNzEUbojq2kvIwnXT5XjOqm6vJByA8f1peebjt7X5iVVFAR+djgdm4WFcP0ULoeXidwxi24dr6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AOVSy6gN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AOVSy6gN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B63B71F000C4;
	Thu, 15 Oct 2026 13:01:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792069272;
	bh=eqIgsGYukq6PGetqnMXH2t9oTCKq1pYgymkhGCe9J7k=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=AOVSy6gNTvD89UTGpdp2X+qSgZFiPSiP5w8Cb9tznZHPoBJmQvy+SJWl/ti+GiFX1
	 dxYKD16CA0pz5rjxCLJlD3+1PwNWm5R8Vwh7f8mlQ4EGI+/DR8mGPisswQpobwCdiB
	 97S5pEBfTrgj1TqZlYG4Xd6TO5qRoWNrXH1fV3kr0AMuQqoqmYVG+Lds8xpjZigCmE
	 tvJ3nro//2ImXfoN+QaLHXB7XbmJE2mcsyeqZwUQ8Z/dsIkEZFrQt0m18lrN7NTz10
	 iJaaVRU8/fnLVKeJZMGPVQPYgLzxfgJPfRiVJs9DusncbdqcTc2X0c04Xv/XLX4i6d
	 tTNPYhpJoZKig==
Message-ID: <33c0c48e-91aa-461f-80bd-ac1d0860a125@kernel.org>
Date: Thu, 15 Oct 2026 08:01:11 -0500
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] usb: pci-quirks: always assert xHCI OS ownership
Content-Language: en-US
To: Michal Pecio <michal.pecio@gmail.com>
Cc: Rishabh Jain <rishabh.jain1198@gmail.com>,
 Mathias Nyman <mathias.nyman@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260902052631.75c6068b.michal.pecio@gmail.com>
 <178832755831.50581.1058201741431375556@gmail.com>
 <7d64e267-8ca6-4130-bd4a-d80fb4224f72@kernel.org>
 <20261015111733.5ead367c.michal.pecio@gmail.com>
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <20261015111733.5ead367c.michal.pecio@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/15/26 04:17, Michal Pecio wrote:
> On Mon, 12 Oct 2026 15:14:14 -0500, Mario Limonciello wrote:
>> On 9/2/26 00:39, Rishabh Jain wrote:
>>> The xHCI ownership protocol requires the OS driver to assert the HC OS
>>> Owned semaphore before using the host controller, then wait for HC BIOS
>>> Owned to clear if firmware owns it.
>>>
>>> quirk_usb_handoff_xhci() currently asserts OS Owned only when BIOS Owned
>>> is already set. If firmware leaves BIOS Owned clear, Linux uses the xHC
>>> while both ownership semaphores remain clear.
>>>
>>> The timeout fallback also clears BIOS Owned using the original register
>>> value, which can clear OS Owned at the same time.
>>>
>>> On an AMD PROM21 xHCI controller (1022:43fc), this caused every S3
>>> resume to terminate Controller Restore State with USBSTS 0x401. Linux
>>> then reset the host controller, both root hubs and the USB Bluetooth
>>> adapter.
>>>
>>> The controller entered resume ready and halted with USBSTS 0x1.
>>> Endpoint state, 100 ms save/restore delays, scratchpads, the DCBAA,
>>> device contexts and command, event and transfer rings were verified not
>>> to cause the restore error.
>>>
>>> Across four S3 cycles, asserting only HC OS Owned changed USBLEGSUP from
>>> 0x00000801 to 0x01000801 and eliminated the restore failure. Testing
>>> included the unmodified 7.1.8-ogc1.1.fc44.x86_64 distribution kernel
>>> using a test module that set the HC OS Owned semaphore. The same test
>>> was repeated after review with the same result. Clearing USBLEGCTLSTS
>>> was independently verified to be unnecessary.
>>>
>>> Always assert OS Owned for controllers using the standard xHCI handoff,
>>> and leave the existing TI/Renesas forced handoff unchanged. Keep OS
>>> Owned asserted after the standard handoff, including when forcing BIOS
>>> Owned clear after a timeout, to prevent firmware from reclaiming the
>>> controller during subsequent suspends.
>>>
>>> Fixes: 66d4eadd8d06 ("USB: xhci: BIOS handoff and HW initialization.")
>>> Cc: stable@vger.kernel.org
>>> Assisted-by: LLM
>>> Signed-off-by: Rishabh Jain <rishabh.jain1198@gmail.com>
>>> ---
>>
>> Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>
> 
> Yes, this fixes a legit issue and would be worth getting in mainline.
> Two users confirmed the patch works for them, though no one could be
> bothered to post proper Tested-by here :(
> 
> https://lore.kernel.org/linux-usb/P1FsfbW--F-9@tuta.io/
> https://lore.kernel.org/linux-usb/CY8PR14MB59803EC0F6C7FD39A6D3C42FA0BF2@CY8PR14MB5980.namprd14.prod.outlook.com/

They're public assertions, let's just put T-b tags for them so b4 can 
pick them up from this thread.

Tested-by: McKenna Fan <blue_sun@tuta.io>
Tested-by: Quinn Schive <quinnschive@hotmail.com>
> 
>>
>>> I kept val unchanged for the error log, restored the original handshake
>>> formatting, and explicitly preserve OS Owned when forcing BIOS Owned
>>> clear after a timeout. Documented timeout issue in commit message.
>>>
>>> I repeated the same S3 test on the unmodified
>>> 7.1.8-ogc1.1.fc44.x86_64 distribution kernel using the test module, with
>>> the same successful result.
>>>
>>> Changes in v5:
>>> - Preserve the original ownership value for error logging.
>>> - Restore the original handshake formatting.
>>> - Explicitly retain OS Owned in the timeout fallback.
>>>
>>>    drivers/usb/host/pci-quirks.c | 13 ++++++++-----
>>>    1 file changed, 8 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/drivers/usb/host/pci-quirks.c b/drivers/usb/host/pci-quirks.c
>>> index 0404489c2f6a..2b12a35e6f10 100644
>>> --- a/drivers/usb/host/pci-quirks.c
>>> +++ b/drivers/usb/host/pci-quirks.c
>>> @@ -1193,10 +1193,11 @@ static void quirk_usb_handoff_xhci(struct pci_dev *pdev)
>>>    			 && pdev->device == 0x0014)) {
>>>    		val = (val | XHCI_HC_OS_OWNED) & ~XHCI_HC_BIOS_OWNED;
>>>    		writel(val, base + ext_cap_offset);
>>> -	}
>>> -
>>> -	/* If the BIOS owns the HC, signal that the OS wants it, and wait */
>>> -	if (val & XHCI_HC_BIOS_OWNED) {
>>> +	} else {
>>> +		/*
>>> +		 * Perform the standard handoff and leave OS ownership set to
>>> +		 * keep the BIOS at bay during subsequent suspends.
>>> +		 */
>>>    		writel(val | XHCI_HC_OS_OWNED, base + ext_cap_offset);
>>>    
>>>    		/* Wait for 1 second with 10 microsecond polling interval */
>>> @@ -1208,7 +1209,9 @@ static void quirk_usb_handoff_xhci(struct pci_dev *pdev)
>>>    			dev_warn(&pdev->dev,
>>>    				 "xHCI BIOS handoff failed (BIOS bug ?) %08x\n",
>>>    				 val);
>>> -			writel(val & ~XHCI_HC_BIOS_OWNED, base + ext_cap_offset);
>>> +			writel((val | XHCI_HC_OS_OWNED) &
>>> +			       ~XHCI_HC_BIOS_OWNED,
>>> +			       base + ext_cap_offset);
>>>    		}
>>>    	}
>>>      
>>

