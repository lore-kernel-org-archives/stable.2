Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1197D390986;
	Fri,  4 Sep 2026 02:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788489253; cv=none; b=U8Vt93UrRbbGbLi+ptc6Xw+fwJbfujX8JsAH9qDNwpcDPxZXIDEnaW8hI+u2FGLzKzye9Q7modWDDMvHE16RgE4M3HCbMz3ATdPLOX4v2djMk7991Yb/xFBLISY5a+r/oF+p6PMZsyDqC0Q/VlKdsgM8PlNQzr/ElawCfloNQlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788489253; c=relaxed/simple;
	bh=N5dB2KOvLQFzxEPbdbcuMcKsmlXDKJ2N7sokJ1V6ipY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GKMWLhgO3XZTyGi8s3nXM6fHSVk44QgzBtjiNk0rl67GMh19VQiHAj+Ip6xTmT9YgJ+7wYPbzJcPFhclqthVynSlnyxl3/He/F8V+Lfgtq4kAWaTLWftkAxHK5HcQqZxeD+Gt8pMMaTjs0FeI05DIzk14dmHyCjDuVc8xu3pbqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Kht6VjV9; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Kht6VjV9"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1788489247; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=/9Vs1DV7JKUB5qKEXzitfFkdT9fBL6pjXJr2CKdD5Gk=;
	b=Kht6VjV9I23+Zm2HhFq5XlxuSWbJjaRzVmwwm5B0nKzOvMajze9lrjyZlp8IFNrTrh0d33EGZjvDlnXgSB6mvusZQOdLdDdZRwmY2b4xqUJwNNv/GdFKzu7VLNvOQXKA3sggU7au8pm9ejn/HX7sSJz2DUIwC8KJXksiUq16zLA=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032089153;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0XAHFP96_1788489245;
Received: from 30.178.68.229(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0XAHFP96_1788489245 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 04 Sep 2026 10:34:06 +0800
Message-ID: <58ea18fe-6e7d-49ab-b6cf-992db4aae732@linux.alibaba.com>
Date: Fri, 4 Sep 2026 10:34:05 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI/DPC: Honor "pcie_ports=native" when enabling DPC
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
From: Guixin Liu <kanie@linux.alibaba.com>
In-Reply-To: <20260903230537.GA2273943@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2026/9/4 07:05, Bjorn Helgaas 写道:
> On Tue, Sep 01, 2026 at 02:45:54PM +0800, Guixin Liu wrote:
>> Commit 97ca178c899d ("PCI/DPC: Allow DPC on all Downstream Ports when
>> OS controls AER") replaced the AER service bit with host->native_aer
>> when deciding whether to create a DPC service device.  Unlike the AER
>> service bit, host->native_aer does not reflect the "pcie_ports=native"
>> command-line override.
>>
>> Consequently, if firmware retains AER control, "pcie_ports=native" no
>> longer enables DPC on Root Ports that advertise both AER and DPC, even
>> though the option is documented to force native DPC handling.
>>
>> Check pcie_ports_native explicitly so both command-line overrides
>> continue to work.
>>
>> Fixes: 97ca178c899d ("PCI/DPC: Allow DPC on all Downstream Ports when OS controls AER")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
>> ---
>>   drivers/pci/pcie/portdrv.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/pci/pcie/portdrv.c b/drivers/pci/pcie/portdrv.c
>> index a9cbfc1d2bc7..a05ee7980fb2 100644
>> --- a/drivers/pci/pcie/portdrv.c
>> +++ b/drivers/pci/pcie/portdrv.c
>> @@ -264,7 +264,7 @@ static int get_port_device_capability(struct pci_dev *dev)
>>   	 */
>>   	if (pci_find_ext_capability(dev, PCI_EXT_CAP_ID_DPC) &&
>>   	    pci_aer_available() &&
>> -	    (pcie_ports_dpc_native || host->native_aer))
>> +	    (pcie_ports_native || pcie_ports_dpc_native || host->native_aer))
> Oh my goodness.  I think I completely dropped ball on this YEARS ago.
>
> It's crazy that we have "pcie_ports_native" checking littered all
> over.  I think we should instead treat host->native_* as the single
> source of truth, and pay attention to pcie_ports_native when setting
> host->native_*.
>
> Sathy did some great work to do exactly that in 2020, and I never got
> it merged.  I wish I had some great excuse, but I looked at my 2020
> calendar and couldn't find one.  I think I just blew it.
>
> So I think we should resurrect that series and update it as needed and
> solve the problem that way.  I dug out the links just for
> completeness, but we should probably just start with the most recent
> ones (v11 or v12):
>
>    # v2 https://lore.kernel.org/r/cover.1590355211.git.sathyanarayanan.kuppuswamy@linux.intel.com/
>    # v3 https://lore.kernel.org/r/cover.1590355824.git.sathyanarayanan.kuppuswamy@linux.intel.com/
>    # v4 https://lore.kernel.org/r/cover.1590534843.git.sathyanarayanan.kuppuswamy@linux.intel.com/
>    # v5 https://lore.kernel.org/r/cover.1591545462.git.sathyanarayanan.kuppuswamy@linux.intel.com/
>    # v6 https://lore.kernel.org/r/cover.1593195899.git.sathyanarayanan.kuppuswamy@linux.intel.com/
>    # v7 https://lore.kernel.org/r/cover.1595006564.git.sathyanarayanan.kuppuswamy@linux.intel.com/
>    # v8 https://lore.kernel.org/r/cover.1595649348.git.sathyanarayanan.kuppuswamy@linux.intel.com/
>    # v9 https://lore.kernel.org/r/cover.1600457297.git.sathyanarayanan.kuppuswamy@linux.intel.com/
>    # v9 https://lore.kernel.org/r/20200928011131.MI-pJpJNRQw6c35j_O6019flLWHe08C4WvKPmKEbnik@z/
>    # v10 https://lore.kernel.org/r/cover.1603738449.git.sathyanarayanan.kuppuswamy@linux.intel.com/
>    # v11 https://lore.kernel.org/r/cover.1603766889.git.sathyanarayanan.kuppuswamy@linux.intel.com/
>    # v12 https://lore.kernel.org/r/20201126011816.711106-1-helgaas@kernel.org/
Yeah, this series is better than mine, wait for your to recover them.

In addition, we should add "Fixes: 97ca178c899d ("PCI/DPC: Allow DPC on 
all Downstream Ports when OS controls AER")" also.

Best Regards,
Guixin Liu
>>   		services |= PCIE_PORT_SERVICE_DPC;
>>   
>>   	/* Enable bandwidth control if more than one speed is supported. */
>> -- 
>> 2.43.7
>>

