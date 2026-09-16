Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B34BA39E180;
	Wed, 16 Sep 2026 16:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789575571; cv=none; b=lSpeS8FS1dBpo1YhbbcdjfKzd490YbxNrLdarc0Niyf9MptdFXDziecKSr/pQ38StgYXQNaSQZnyWLZM5Aif5EiHm3jLLckf5c3z2z+AZjW1P4kmBuOoMQqkdc4uL0e05DPkEcneDIdGUeCIJWByQH36Z41ZAwjlhI1D3Ku/BRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789575571; c=relaxed/simple;
	bh=SHxc9qJsOLXK/tljvtNmHhBOpMOEE2bT0FUViBGPFg4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JxhLdpyKbx8oDqu7QI7LmpndlFnmcyOOItkS69hDAQvxPoM/kmAogKrKxfifCAQltoMa3Bm8Nyf7+uK4oRF9n+uyZjVGTtzW4911CLXL/0t4vqLQNP0xeiogavuR/fHI3pcqhw7QW3Cla8ioySvY2Zq6O3WsnZHcx/+48OSVTaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=X9pgAJ8e; arc=none smtp.client-ip=192.198.163.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X9pgAJ8e"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789575568; x=1821111568;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=SHxc9qJsOLXK/tljvtNmHhBOpMOEE2bT0FUViBGPFg4=;
  b=X9pgAJ8el9U80GM4fHmnPyyeavdRyLpYMCXLWMaMIoxXBHLRWd7X/r5T
   3b9e3nTlqgELkjES8Ak/pSqCyNC7juUY8vJdH1zpZ8Ys18Hglefrx474/
   5gPvAzYVH7o+wmCZwfUY2akhqjTBy2nuGCB4fbvYw11O0WNGuVq4/5yqY
   6df2hEaMPAAEIDHaBqaGEjO3Wnanu7LQEGhefUkh/P0+M+jq5IzKeHOIs
   7S4uhIcuTQnk4co3ssqQFc829X0guqoRI44Ye251q6AEZzi1sIiaYl26Y
   th0QUggS+ndVCG/Q5+kd47F34mza2Zi+uYW92Ok+0aucRoUJmiZWFJStk
   w==;
X-CSE-ConnectionGUID: fIWfddTcTTWl0VHcXOL2Bw==
X-CSE-MsgGUID: fbMJD9xKToWIwxm33Md12A==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="462951"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="462951"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa116.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2026 09:19:28 -0700
X-CSE-ConnectionGUID: z7QIQ+ouSpuJT1hwi4KfyQ==
X-CSE-MsgGUID: 1scNkbsjTMe/xuN1zcrTLA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="277126507"
Received: from soc-pf446t5c.clients.intel.com (HELO [10.24.80.90]) ([10.24.80.90])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2026 09:19:27 -0700
Message-ID: <2a8de957-74fc-4b70-be9e-c404fc49220d@linux.intel.com>
Date: Wed, 16 Sep 2026 09:19:27 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI/DPC: Honor "pcie_ports=native" when enabling DPC
To: Guixin Liu <kanie@linux.alibaba.com>, Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 Jonathan Cameron <jic23@kernel.org>, Lukas Wunner <lukas@wunner.de>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Kees Cook <kees@kernel.org>, Darshit Shah <darnshah@amazon.de>,
 Brian Norris <briannorris@chromium.org>, linux-pci@vger.kernel.org,
 stable@vger.kernel.org
References: <20260903230537.GA2273943@bhelgaas>
 <58ea18fe-6e7d-49ab-b6cf-992db4aae732@linux.alibaba.com>
 <44256f8c-5087-4550-a522-34a828c40c1c@linux.alibaba.com>
Content-Language: en-US
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <44256f8c-5087-4550-a522-34a828c40c1c@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Liu,

On 9/14/2026 4:01 AM, Guixin Liu wrote:
> 
> 
> 在 2026/9/4 10:34, Guixin Liu 写道:
>>
>>
>> 在 2026/9/4 07:05, Bjorn Helgaas 写道:
>>> On Tue, Sep 01, 2026 at 02:45:54PM +0800, Guixin Liu wrote:
>>>> Commit 97ca178c899d ("PCI/DPC: Allow DPC on all Downstream Ports when
>>>> OS controls AER") replaced the AER service bit with host->native_aer
>>>> when deciding whether to create a DPC service device. Unlike the AER
>>>> service bit, host->native_aer does not reflect the "pcie_ports=native"
>>>> command-line override.
>>>>
>>>> Consequently, if firmware retains AER control, "pcie_ports=native" no
>>>> longer enables DPC on Root Ports that advertise both AER and DPC, even
>>>> though the option is documented to force native DPC handling.
>>>>
>>>> Check pcie_ports_native explicitly so both command-line overrides
>>>> continue to work.
>>>>
>>>> Fixes: 97ca178c899d ("PCI/DPC: Allow DPC on all Downstream Ports when OS controls AER")
>>>> Cc: stable@vger.kernel.org
>>>> Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
>>>> ---
>>>>   drivers/pci/pcie/portdrv.c | 2 +-
>>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/pci/pcie/portdrv.c b/drivers/pci/pcie/portdrv.c
>>>> index a9cbfc1d2bc7..a05ee7980fb2 100644
>>>> --- a/drivers/pci/pcie/portdrv.c
>>>> +++ b/drivers/pci/pcie/portdrv.c
>>>> @@ -264,7 +264,7 @@ static int get_port_device_capability(struct pci_dev *dev)
>>>>        */
>>>>       if (pci_find_ext_capability(dev, PCI_EXT_CAP_ID_DPC) &&
>>>>           pci_aer_available() &&
>>>> -        (pcie_ports_dpc_native || host->native_aer))
>>>> +        (pcie_ports_native || pcie_ports_dpc_native || host->native_aer))
>>> Oh my goodness.  I think I completely dropped ball on this YEARS ago.
>>>
>>> It's crazy that we have "pcie_ports_native" checking littered all
>>> over.  I think we should instead treat host->native_* as the single
>>> source of truth, and pay attention to pcie_ports_native when setting
>>> host->native_*.
>>>
>>> Sathy did some great work to do exactly that in 2020, and I never got
>>> it merged.  I wish I had some great excuse, but I looked at my 2020
>>> calendar and couldn't find one.  I think I just blew it.
>>>
>>> So I think we should resurrect that series and update it as needed and
>>> solve the problem that way.  I dug out the links just for
>>> completeness, but we should probably just start with the most recent
>>> ones (v11 or v12):
>>>
>>>    # v2 https://lore.kernel.org/r/cover.1590355211.git.sathyanarayanan.kuppuswamy@linux.intel.com/
>>>    # v3 https://lore.kernel.org/r/cover.1590355824.git.sathyanarayanan.kuppuswamy@linux.intel.com/
>>>    # v4 https://lore.kernel.org/r/cover.1590534843.git.sathyanarayanan.kuppuswamy@linux.intel.com/
>>>    # v5 https://lore.kernel.org/r/cover.1591545462.git.sathyanarayanan.kuppuswamy@linux.intel.com/
>>>    # v6 https://lore.kernel.org/r/cover.1593195899.git.sathyanarayanan.kuppuswamy@linux.intel.com/
>>>    # v7 https://lore.kernel.org/r/cover.1595006564.git.sathyanarayanan.kuppuswamy@linux.intel.com/
>>>    # v8 https://lore.kernel.org/r/cover.1595649348.git.sathyanarayanan.kuppuswamy@linux.intel.com/
>>>    # v9 https://lore.kernel.org/r/cover.1600457297.git.sathyanarayanan.kuppuswamy@linux.intel.com/
>>>    # v9 https://lore.kernel.org/r/20200928011131.MI-pJpJNRQw6c35j_O6019flLWHe08C4WvKPmKEbnik@z/
>>>    # v10 https://lore.kernel.org/r/cover.1603738449.git.sathyanarayanan.kuppuswamy@linux.intel.com/
>>>    # v11 https://lore.kernel.org/r/cover.1603766889.git.sathyanarayanan.kuppuswamy@linux.intel.com/
>>>    # v12 https://lore.kernel.org/r/20201126011816.711106-1-helgaas@kernel.org/
> Hi Bjorn, still not see you resurrect this series.

I am working on this. I will post the rebased version soon.

> 
> Best Regards,
> Guixin Liu
>> Yeah, this series is better than mine, wait for your to recover them.
>>
>> In addition, we should add "Fixes: 97ca178c899d ("PCI/DPC: Allow DPC on all Downstream Ports when OS controls AER")" also.
>>
>> Best Regards,
>> Guixin Liu
>>>> services |= PCIE_PORT_SERVICE_DPC;
>>>>         /* Enable bandwidth control if more than one speed is supported. */
>>>> -- 
>>>> 2.43.7
>>>>
> 

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer

