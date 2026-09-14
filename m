Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8E7F3DB626;
	Mon, 14 Sep 2026 11:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789383690; cv=none; b=Jht1h6F9+kZtMYAGqB+aUx3/DadRLg5nLL7RtJ6kwIEtYBSc/y+rsGq9VqLz7EyFV46BnXhcFYnV8NpRGkXs8Nycl94ud8Ckqh1SL0TmrVJIdT/3MZFgG3O4xWcIK3eUMZvt9W6+W0mx2wyk3CdeD98LxzL98MudjBOJ+ZS8+vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789383690; c=relaxed/simple;
	bh=iN/uqvYh5oGbyMuPH/icSsXbIxVktkW44wWAepl+wkw=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=SPDzFZLVg8ghhhIEgA2tuWE9nmtrqnI1ZZRl8XCL9mm+av/EDXHwKuwwxwryiSxiKKUOEXL/9dFkbh3VlJ2LBxHC+NM5HHbhJXBmNdF4TT8GMcl3wrMFun5rYQcYoRP1j2nrdpQlCugJIvub7M/FcI3Qi/vcB9EasKPHDs02ONY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=tM2Wck3U; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="tM2Wck3U"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1789383678; h=Message-ID:Date:MIME-Version:Subject:From:To:Content-Type;
	bh=9I6qpgeDCcaTHuE1jJmktcuPaVKe2XvWLkaoxeUkkuI=;
	b=tM2Wck3U0lcuuDfMfP/YvaE4UlTDWz6E+9UOACMUcPkJE4AF1R3kzCUpBuqGCwk3pPzinnu0lHDu9IF/ObmYtupmxVnOtXn3n+rhb9TNwj0PxXhReQH8kbeA025UURX6lUFURPCp+05GzsPPYrQ36b7idinarjfTFKCQe9973NE=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R781e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037026112;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0XAvB94Z_1789383676;
Received: from 30.178.84.243(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0XAvB94Z_1789383676 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 14 Sep 2026 19:01:17 +0800
Message-ID: <44256f8c-5087-4550-a522-34a828c40c1c@linux.alibaba.com>
Date: Mon, 14 Sep 2026 19:01:16 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI/DPC: Honor "pcie_ports=native" when enabling DPC
From: Guixin Liu <kanie@linux.alibaba.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 Jonathan Cameron <jic23@kernel.org>, Lukas Wunner <lukas@wunner.de>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Kees Cook <kees@kernel.org>, Darshit Shah <darnshah@amazon.de>,
 Brian Norris <briannorris@chromium.org>,
 Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
 linux-pci@vger.kernel.org, stable@vger.kernel.org
References: <20260903230537.GA2273943@bhelgaas>
 <58ea18fe-6e7d-49ab-b6cf-992db4aae732@linux.alibaba.com>
In-Reply-To: <58ea18fe-6e7d-49ab-b6cf-992db4aae732@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2026/9/4 10:34, Guixin Liu 写道:
>
>
> 在 2026/9/4 07:05, Bjorn Helgaas 写道:
>> On Tue, Sep 01, 2026 at 02:45:54PM +0800, Guixin Liu wrote:
>>> Commit 97ca178c899d ("PCI/DPC: Allow DPC on all Downstream Ports when
>>> OS controls AER") replaced the AER service bit with host->native_aer
>>> when deciding whether to create a DPC service device. Unlike the AER
>>> service bit, host->native_aer does not reflect the "pcie_ports=native"
>>> command-line override.
>>>
>>> Consequently, if firmware retains AER control, "pcie_ports=native" no
>>> longer enables DPC on Root Ports that advertise both AER and DPC, even
>>> though the option is documented to force native DPC handling.
>>>
>>> Check pcie_ports_native explicitly so both command-line overrides
>>> continue to work.
>>>
>>> Fixes: 97ca178c899d ("PCI/DPC: Allow DPC on all Downstream Ports 
>>> when OS controls AER")
>>> Cc: stable@vger.kernel.org
>>> Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
>>> ---
>>>   drivers/pci/pcie/portdrv.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/pci/pcie/portdrv.c b/drivers/pci/pcie/portdrv.c
>>> index a9cbfc1d2bc7..a05ee7980fb2 100644
>>> --- a/drivers/pci/pcie/portdrv.c
>>> +++ b/drivers/pci/pcie/portdrv.c
>>> @@ -264,7 +264,7 @@ static int get_port_device_capability(struct 
>>> pci_dev *dev)
>>>        */
>>>       if (pci_find_ext_capability(dev, PCI_EXT_CAP_ID_DPC) &&
>>>           pci_aer_available() &&
>>> -        (pcie_ports_dpc_native || host->native_aer))
>>> +        (pcie_ports_native || pcie_ports_dpc_native || 
>>> host->native_aer))
>> Oh my goodness.  I think I completely dropped ball on this YEARS ago.
>>
>> It's crazy that we have "pcie_ports_native" checking littered all
>> over.  I think we should instead treat host->native_* as the single
>> source of truth, and pay attention to pcie_ports_native when setting
>> host->native_*.
>>
>> Sathy did some great work to do exactly that in 2020, and I never got
>> it merged.  I wish I had some great excuse, but I looked at my 2020
>> calendar and couldn't find one.  I think I just blew it.
>>
>> So I think we should resurrect that series and update it as needed and
>> solve the problem that way.  I dug out the links just for
>> completeness, but we should probably just start with the most recent
>> ones (v11 or v12):
>>
>>    # v2 
>> https://lore.kernel.org/r/cover.1590355211.git.sathyanarayanan.kuppuswamy@linux.intel.com/
>>    # v3 
>> https://lore.kernel.org/r/cover.1590355824.git.sathyanarayanan.kuppuswamy@linux.intel.com/
>>    # v4 
>> https://lore.kernel.org/r/cover.1590534843.git.sathyanarayanan.kuppuswamy@linux.intel.com/
>>    # v5 
>> https://lore.kernel.org/r/cover.1591545462.git.sathyanarayanan.kuppuswamy@linux.intel.com/
>>    # v6 
>> https://lore.kernel.org/r/cover.1593195899.git.sathyanarayanan.kuppuswamy@linux.intel.com/
>>    # v7 
>> https://lore.kernel.org/r/cover.1595006564.git.sathyanarayanan.kuppuswamy@linux.intel.com/
>>    # v8 
>> https://lore.kernel.org/r/cover.1595649348.git.sathyanarayanan.kuppuswamy@linux.intel.com/
>>    # v9 
>> https://lore.kernel.org/r/cover.1600457297.git.sathyanarayanan.kuppuswamy@linux.intel.com/
>>    # v9 
>> https://lore.kernel.org/r/20200928011131.MI-pJpJNRQw6c35j_O6019flLWHe08C4WvKPmKEbnik@z/
>>    # v10 
>> https://lore.kernel.org/r/cover.1603738449.git.sathyanarayanan.kuppuswamy@linux.intel.com/
>>    # v11 
>> https://lore.kernel.org/r/cover.1603766889.git.sathyanarayanan.kuppuswamy@linux.intel.com/
>>    # v12 
>> https://lore.kernel.org/r/20201126011816.711106-1-helgaas@kernel.org/
Hi Bjorn, still not see you resurrect this series.

Best Regards,
Guixin Liu
> Yeah, this series is better than mine, wait for your to recover them.
>
> In addition, we should add "Fixes: 97ca178c899d ("PCI/DPC: Allow DPC 
> on all Downstream Ports when OS controls AER")" also.
>
> Best Regards,
> Guixin Liu
>>> services |= PCIE_PORT_SERVICE_DPC;
>>>         /* Enable bandwidth control if more than one speed is 
>>> supported. */
>>> -- 
>>> 2.43.7
>>>

