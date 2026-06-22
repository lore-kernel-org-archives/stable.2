Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B67C12BEC2A;
	Mon, 22 Jun 2026 11:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782128198; cv=none; b=uJX3dDTzY2U4q5EqSfgGhQZMxTR5CYhhvWBddW//v008t5VYPsNYr2jE/P7lGBzOiV5uCLGDfQMKrnPpNIJ43JP7NYA32NNgIQveHXvJIlUdthteNphFuNQOTWZv1TRTrto0VM7k+N4r3KPtuvNP86tHI1ResIWoTB6l5k9YSAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782128198; c=relaxed/simple;
	bh=NMegGtCpazuqTxx3oAKyKyvlgzrPygdUq4zbpguWgqQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mjlA73S1qSvAfTIz4xnK8YzesXf9n5O6kBQA7gOB1az9bkuSNaoNf2DXE0TchjwKBUErIJ3oCBJF5wqYJtBKiR8CvPz+Lo9TioDYhlQOwX/D+UaVZUrdG/g+rISYgmzGwfObnz4FGhea2RjhypPuqSNWUeF7ZTWvEVS8uA4SF/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HrUpJK+X; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HrUpJK+X"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782128197; x=1813664197;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=NMegGtCpazuqTxx3oAKyKyvlgzrPygdUq4zbpguWgqQ=;
  b=HrUpJK+X1cNBElg9bDyiW7dvGQi66EFQ2fPPBb/y8Lm9i2mkNE/MoY9x
   aTFZuw8kUOOlsJLGpFcHB4jcV8FwEjbWSoIY4stRlg/xsH/oWEEYkmYqc
   axv42BOPP1ZQsj/jZbYKNYaaxba3qTDkae5GMHTNgp9XA1EylI+fGZUhh
   cXbWY1hd6Bud8yRG9wpbEFN0ReUY5GDhsm+nb74UZv4S96eV3vIxuSREp
   15jA8q7xrmlS/YeJZFjpG5m10aff4Vh/VG18UYbgXLsfvcMN33m0LJ/Mc
   Xg3rdOtsiRJsIYCFRk4ZA9Ovm1kY15k/JJYdcO96ghN/LrQink1VSWWtz
   g==;
X-CSE-ConnectionGUID: jJZOwNYYT1GAoUMfaoM2tA==
X-CSE-MsgGUID: C5BGC01sRtCnmKszgSfFeg==
X-IronPort-AV: E=McAfee;i="6800,10657,11824"; a="94243755"
X-IronPort-AV: E=Sophos;i="6.24,218,1774335600"; 
   d="scan'208";a="94243755"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2026 04:36:36 -0700
X-CSE-ConnectionGUID: dien85zHTPibEvZGxJApeg==
X-CSE-MsgGUID: oXAWpn18TTCJohiofCyVPw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,218,1774335600"; 
   d="scan'208";a="253106030"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO [10.245.245.57]) ([10.245.245.57])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2026 04:36:34 -0700
Message-ID: <9d87814e-baf0-4dad-aeb9-b34d28a4fc86@linux.intel.com>
Date: Mon, 22 Jun 2026 14:36:31 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] xhci: pci: Disable soft retry for Renesas uPD720201
To: Michal Pecio <michal.pecio@gmail.com>
Cc: raoxu <raoxu@uniontech.com>, mathias.nyman@intel.com,
 gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <D9BA02889D046D23+20260617100957.2888108-1-raoxu@uniontech.com>
 <62003881-4975-4bb2-a842-cb153ebd8cd4@linux.intel.com>
 <20260619124234.0a9e4670.michal.pecio@gmail.com>
Content-Language: en-US
From: Mathias Nyman <mathias.nyman@linux.intel.com>
In-Reply-To: <20260619124234.0a9e4670.michal.pecio@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/19/26 13:42, Michal Pecio wrote:
>> On 6/17/26 13:09, raoxu wrote:
>>> From: Xu Rao <raoxu@uniontech.com>
>>>
>>> The Renesas uPD720201 xHCI controller can fail to complete
>>> a Stop Endpoint command after a transaction error on an interrupt
>>> endpoint when soft retry is used.
>>>
>>> This was reproduced with this setup:
>>>
>>>     xHCI: Renesas uPD720201, PCI ID 1912:0014 rev 03
>>>     dev:  USB Ethernet device with an integrated Genesys Logic
>>>           USB3.1 hub, USB ID 05e3:0626, and a Realtek RTL8153
>>>           Ethernet function, USB ID 0bda:8153
> 
> Same thing with uPD720202 (1912:0015) here.
> 
> Is the hub even necessary? In my case I have one too, but I cannot
> separate it from the RTL8153 for testing.
> 
>>> Reproducer:
>>>
>>>     1. Plug the integrated USB hub and Ethernet device into the
>>>        1912:0014 xHCI controller.
>>>     2. Let r8152 bind to the 0bda:8153 RTL8153 Ethernet function
>>>        behind the integrated hub.
>>>     3. Bring the Ethernet device up.
>>>     4. Hot-unplug the device.
> 
> In my case, necessary step 3.5: connect a cable and wait for the
> "r8152: carrier on" message. Otherwise it disconnects cleanly.
> 
>>> The host reports a transaction error on the RTL8153 interrupt
>>> endpoint, queues a soft reset, and later times out the Stop
>>> Endpoint command while disconnecting the device:
>>>
>>>     Transfer error for slot 8 ep 6 on endpoint
>>>     Soft-reset ep 6, slot 8
>>>     Ignoring reset ep completion code of 1
>>>     xHCI host not responding to stop endpoint command
>>>     xHCI host controller not responding, assume dead
>>>     HC died; cleaning up
> 
> There is other stuff too, like concurrent teardown of a separate bulk
> endpoint, not yet sure what exactly breaks these chips.
> 
> Would you mind to apply the attached debug patch, reproduce and post
> dmesg from your system for comparison?
> 
>>> The Renesas 1912:0014 controller cannot safely use the xHCI soft
>>> retry path. Set XHCI_NO_SOFT_RETRY for this controller so
>>> transaction errors use the pre-soft-retry recovery path. With
>>> this quirk the same hot-unplug test no longer times out the Stop
>>> Endpoint command and the RTL8153 remains usable and stable.
> 
> A bit heavy handed, but we might find no better way.
> 
> On Thu, 18 Jun 2026 17:03:26 +0300, Mathias Nyman wrote:
>> I'd appreciate your opinion on a related issue.
>> I'm thinking about trying to recover from these stop endpoint command
>> timeouts.
> 
> I can share a bit of mine. I tried aborting Stop EP on Etron and found
> the EP in some bogus state afterwards (e.g. Running but Stop EP fails
> with Context State Error, or Stopped but not responing to doorbells,
> something like that, I don't remember).
> 
> Per xHCI 4.6.9 there isn't really a case when this command should time
> out, so it's always some internal bug/deadlock in the xHC and IMO good
> chance that abort will leave at least this one EP or slot broken.
> 
> Another case is ASMedia, which doesn't seem to implement abort at all -
> at least in my tests with Address Device and a dummy device that always
> NAKs, abort simply waits for the command to finish (these chips have
> internal 3 second timeout on Address Device). I would expect the same
> for Stop EP, except that it likely lacks internal timeout. And the
> driver will busy-wait for several seconds with IRQs disabled.
> 
>> While debugging this, did xHC controller otherwise seem somewhat
>> functional? Did you for example see port status change events, or
>> transfer events between queuing the stop endpoint command and the
>> timeout?
> 
> Mouse continues to work until we kill the HC. And I can even abort the
> command, but then some URB is never given back, so teardown of the USB
> device gets stuck and IDK what would happen later.
> 
> Such recovery would be a bit of work, potential chip specific bugs and
> frankly we can' be sure if the EP won't try to begin executing URBs.

Thanks, sounds like simple recovery by just canceling the command and moving
on might not be the best approach.

If root port is disconnected or link in error state (link:Inactive) then
we could avoid all soft retries and ring restarts for child devices.

This could avoid queuing the problematic stop endpoint command as well.

Thanks
Mathias


