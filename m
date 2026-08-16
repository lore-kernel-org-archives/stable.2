Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6F7E3D813C;
	Sun, 16 Aug 2026 21:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786914060; cv=none; b=YY9KG/2xtQy0hCdrbV3mC63X6pFDRiDGtg9KNX8hus4Lx4uDgzhZcmq19dzSqCX/di4+1ur6zq6jh7RQXOLorvlKJsEjRhS7LExHCb2BU44YxFofP9/jooxdFIfW61XFxgj+VIhDXwb/KIUz9zvnxM5sT71RKlSHKTZ1M4g01K0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786914060; c=relaxed/simple;
	bh=l4VGrHWiUOv9KkEux2TUWn0/ZIt16/xTqgOXClVdgp8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=APpX1sYkg2LQK/o37kvpfJcmCeZJb7vKjdbJjU8+x9sZgu0mk6UeOcgCWdPOaK6s0ngQCx7AzmXDNTsVHUH/YXRSQcgzUTP0aMm89yCCXOw5ae1ybQg9Nk7CEBmE1ozCnfkDWf4H306JGen8uoXKCthqO/JKSnTBy0JyBkLoNBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QY0AocKN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QY0AocKN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 776151F000E9;
	Sun, 16 Aug 2026 21:00:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786914049;
	bh=xw/AMo6b3nfC+SC+C77ABKsLtRtS9MF/hAS0al3oxXU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=QY0AocKNfX1y46z1HpPqEtbf+f9/BqOA/bzkdxYjPRMXGaQP72dRDTZEQBXlLOYX5
	 Ai7XFhDKBlQAchxwAoLdlLkvFgfcIiHYbRsAUgKTpaR5sy3JLYRy208USFY/qGk/lC
	 IMliiCrn5pSkB9AxNmKnRVEGB93tznWgkXJjqxbTIZHCQZAxUnHZd8hl3gf8wB0+bf
	 7aLuSVSoFRQmauqHpNq0fn4kl0541Rio5WI6Ud+lIi7R7dtyHNLg5Z6rRYD68sMh7k
	 Tu5Gfifhzs6lk9RKVNRSKkppoB9T7LE1MOQiIrrZLHTSJ4FrxZHmqPhE17u6nB9m1m
	 WspHYk5Q5Pyiw==
Message-ID: <2d13e2ae-f5da-4951-bbe4-be7bb0b296cf@kernel.org>
Date: Sun, 16 Aug 2026 16:00:47 -0500
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb: pci-quirks: always assert xHCI OS ownership
Content-Language: en-US
To: Michal Pecio <michal.pecio@gmail.com>
Cc: Rishabh Jain <rishabh.jain1198@gmail.com>,
 Mathias Nyman <mathias.nyman@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260815014534.77850-1-rishabh.jain1198@gmail.com>
 <69fdc442-a4f2-42e0-80f6-6b35cbc207bf@kernel.org>
 <20260816220306.64c615f2.michal.pecio@gmail.com>
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <20260816220306.64c615f2.michal.pecio@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/16/26 15:03, Michal Pecio wrote:
> On Sun, 16 Aug 2026 11:33:56 -0500, Mario Limonciello wrote:
>> On 8/14/26 20:45, Rishabh Jain wrote:
>>> The xHCI ownership protocol requires the OS driver to assert the HC
>>> OS Owned semaphore before using the host controller, then wait for
>>> HC BIOS Owned to clear if firmware owns it.
>>>
>>> quirk_usb_handoff_xhci() currently asserts OS Owned only when BIOS
>>> Owned is already set. If firmware leaves BIOS Owned clear, Linux
>>> uses the xHC while both ownership semaphores remain clear.
>>>
>>> On an AMD PROM21 xHCI controller (1022:43fc), this caused every S3
>>> resume to terminate Controller Restore State with USBSTS 0x401.
>>> Linux then reset the host controller, both root hubs and the USB
>>> Bluetooth adapter.
> 
> Not sure if this has anything to do with PROM21, or if some BIOS
> is just trying to use the xHC at resume because it's permitted to.
> Then it makes too many changes for Restore State to still work.
> 
> Potentially, such bugs may have happened and been left unsolved or
> "solved" with RESET_ON_RESUME quirks and other hacks.

What do you think about making this a series with each of those quirks 
dropped one-by-one?  The head patch (a variation of this one) could go 
to stable and the rest of the commits dropping those can go to linux-next.

All the authors and associated people with thoes quirks can be CC'ed to 
give us a shot at cleaning up all of them.  If any continue to fail then 
it's a simple revert for each one that failed.

> 
>>> The controller entered resume ready and halted with USBSTS 0x1.
>>> Endpoint state, 100 ms save/restore delays, scratchpads, the DCBAA,
>>> device contexts and command, event and transfer rings were verified not
>>> to cause the restore error.
>>>
>>> Asserting only HC OS Owned changed USBLEGSUP from 0x00000801 to
>>> 0x01000801 and eliminated the restore failure across four S3 cycles,
>>> including a stock-kernel test. Clearing USBLEGCTLSTS was independently
>>> verified to be unnecessary.
>>>
>>> Always assert OS Owned when the xHCI Legacy Support capability is
>>> present. Use the independently accessible ownership byte so firmware
>>> can update BIOS Owned without racing a 32-bit read-modify-write. Keep
>>> the existing BIOS handoff wait and legacy SMI cleanup unchanged.
>>>
>>> Fixes: 66d4eadd8d06 ("USB: xhci: BIOS handoff and HW initialization.")
>>> Tested-by: Rishabh Jain <rishabh.jain1198@gmail.com>
>>> Cc: stable@vger.kernel.org
>>> Signed-off-by: Rishabh Jain <rishabh.jain1198@gmail.com>
>>> ---
>>> Additional context:
>>>
>>> * Kernel Bugzilla #216470 documents the same USBSTS 0x401/reinitialize
>>>     behavior and its impact on attached USB devices:
>>>     https://bugzilla.kernel.org/show_bug.cgi?id=216470
>>>
>>> * Commit a7d57abcc8a5 ("xhci: workaround CSS timeout on AMD SNPS 3.0
>>>     xHC") is related workaround history: it tolerates a distinct AMD CSS
>>>     timeout and resets the controller on resume:
>>>     https://github.com/torvalds/linux/commit/a7d57abcc8a5bdeb53bbf8e87558e8e0a2c2a29d
>>>
>>> The external reports do not record their ownership semaphore values but
>>> are included as corroborating failure signatures that this might fix.
>>>
>>> drivers/usb/host/pci-quirks.c | 12 +++++++++---
>>>    1 file changed, 9 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/usb/host/pci-quirks.c b/drivers/usb/host/pci-quirks.c
>>> index 0404489c2f6a..d76a4791b8f5 100644
>>> --- a/drivers/usb/host/pci-quirks.c
>>> +++ b/drivers/usb/host/pci-quirks.c
>>> @@ -1185,6 +1185,14 @@ static void quirk_usb_handoff_xhci(struct pci_dev *pdev)
>>>    		dev_warn(&pdev->dev, "xHCI controller failing to respond");
>>>    		goto iounmap;
>>>    	}
>>> +
>>> +	/*
>>> +	 * The OS ownership semaphore must be asserted while the OS owns the
>>> +	 * xHC, even if firmware did not assert the BIOS ownership semaphore.
>>> +	 * Update only the OS ownership byte to avoid racing with firmware.
>>> +	 */
>>> +	writeb(readb(base + ext_cap_offset + 3) | BIT(0),
>>> +	       base + ext_cap_offset + 3);
>>
>> I'm assuming you are actually meaning XHCI_EXT_CAPS_PM for the 3 here.
>> Why are you doing all this math?
>>
>> We already have the defines XHCI_HC_OS_OWNED, can't you just use that?
>>
>> And for that matter it sounds like you are really proposing to just
>> remove this check but adding more complexity in the process.
>>
>> 	if (val & XHCI_HC_BIOS_OWNED)
> 
> All explained by the comment above and xHCI 4.22.1.
> 
> Though curiously, while HW is required to enable doing the sensible
> thing, the spec doesn't clearly state that SW must actually do it...
> 
> And BTW, I checked if any of my HCs refuses to honor DWORD writes to
> this register to protect SW from itself, but none does.
> 
>> I guess the way I would do this is at least leave a debug breadcrumb
> 
> Is anyone ever going to look at that pci_debug()?
> 
> If it works, who cares if it was claimed by the BIOS or not.
> If it doesn't, you know that it was. And the full register is dumped.
> 

I guess I see your point.  This debug message I mentioned can probably 
be dropped in a v3.

>> since you're reading the register something like this:
>>
>> val = readl(base + ext_cap_offset);
>> if (val & XHCI_HC_BIOS_OWNED)
>> 	pci_debug(pdev, "BIOS owns XHCI HC\n"0;
>> writel(val | XHCI_HC_OS_OWNED, base + ext_cap_offset);
>> timeout = handshake(...)
>> if (timeout && (val & XHCI_HC_BIOS_OWNED)) {
>> 	dev_warn(...)
>> 	writel(val & ~XHCI_HC_BIOS_OWNED, base + ext_cap_offset);
>> }
>>
>> Then you have a single read, no extra writes.
>>
>>>    	val = readl(base + ext_cap_offset);
>>>    
>>>    	/* Auto handoff never worked for these devices. Force it and continue */
>>> @@ -1195,10 +1203,8 @@ static void quirk_usb_handoff_xhci(struct pci_dev *pdev)
>>>    		writel(val, base + ext_cap_offset);
>>>    	}
>>>    
>>> -	/* If the BIOS owns the HC, signal that the OS wants it, and wait */
>>> +	/* If the BIOS owns the HC, wait for it to hand over control */
>>>    	if (val & XHCI_HC_BIOS_OWNED) {
>>> -		writel(val | XHCI_HC_OS_OWNED, base + ext_cap_offset);
>>> -
>>>    		/* Wait for 1 second with 10 microsecond polling interval */
>>>    		timeout = handshake(base + ext_cap_offset, XHCI_HC_BIOS_OWNED,
>>>    				0, 1000000, 10);
>>

