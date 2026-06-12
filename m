Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC6FB30F7F2;
	Fri, 12 Jun 2026 19:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781292434; cv=none; b=VleDkHqh7IszHijuIAB0vxVRVQzWgYVkG0clJleMyQZH93CmY/uP1EePL+MF0C1d8RN8+1qs9sr0p1ako0zqLYRr+BrjOipbJ5FHIu5qJMhl6ELqcTU7SMEcApu3IbcEFyDdHWl6CnNk49W8LqcjXUGNyb0YBZWQylKspk2R2WM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781292434; c=relaxed/simple;
	bh=sDlNg3jNR3VkC9Yc5jiT7PReuDVVqc2WuKd4K66BGpc=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ajwa92VL1vIHtLzroZpVz9iG0BAXT5m620qVtDNVWY/S2vgfLITi4Lq2NT6g61nxlTJEQfXjfM+wi+/daY1BxgIpRYRQQ6tdeG14ap+9DNv2gqm2OsX2dKjLY4ejN9cLMpxjTwn9KWuserrSCFdeStA2M6X2WYzfLjq3jnF8KGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=sGFB1Ysv; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="sGFB1Ysv"
Received: from [192.168.201.246] (unknown [4.194.122.170])
	by linux.microsoft.com (Postfix) with ESMTPSA id C324A20B716A;
	Fri, 12 Jun 2026 12:26:47 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C324A20B716A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1781292413;
	bh=VFoPonWpWXwuXHtqnk4IpXqhlk14J/U7sojhe9tiN34=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=sGFB1Ysvao5HmkpJS06nA+8PKkJkHs2MZRIuSerNWxtGDQLczDVSK2FjA5HIkuaE1
	 n1AoECTdDT6ntcT5pS0JVCMWDsR8apFE3hyOsTIKJpl4qjq0AQ0VC3JtCy79EHXcZf
	 IOJd43P7Pv7qRpNRd31razBjW1gGqKmy7tbjyw04=
Message-ID: <9239f428-9b94-48a6-aec1-f459198da6b3@linux.microsoft.com>
Date: Fri, 12 Jun 2026 12:27:03 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: linux-hyperv@vger.kernel.org, easwar.hariharan@linux.microsoft.com,
 "K. Y. Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH] PCI: hv: add hard timeout to wait_for_response()
To: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
References: <20260612174010.2598695-1-hamzamahfooz@linux.microsoft.com>
From: Easwar Hariharan <easwar.hariharan@linux.microsoft.com>
Content-Language: en-US
In-Reply-To: <20260612174010.2598695-1-hamzamahfooz@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/12/2026 10:40, Hamza Mahfooz wrote:
> It is possible that we never receive a rescind event, in which case we
> will wait indefinitely for a device that will never show up. So, assume
> a device is gone if have been polling for more than 5 seconds.
> 

Echo Long's request for more context on where this was seen.

> Cc: stable@vger.kernel.org
> Fixes: c3635da2a336 ("PCI: hv: Do not wait forever on a device that has disappeared")
> Signed-off-by: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
> ---
>  drivers/pci/controller/pci-hyperv.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
> index cfc8fa403dad..bd63efc4a210 100644
> --- a/drivers/pci/controller/pci-hyperv.c
> +++ b/drivers/pci/controller/pci-hyperv.c
> @@ -52,6 +52,7 @@
>  #include <linux/acpi.h>
>  #include <linux/sizes.h>
>  #include <linux/of_irq.h>
> +#include <linux/jiffies.h>
>  #include <asm/mshyperv.h>
>  
>  /*
> @@ -1038,6 +1039,8 @@ static void put_pcichild(struct hv_pci_dev *hpdev)
>  		kfree(hpdev);
>  }
>  
> +#define TIMEOUT_MS 5000
> +

This can be in seconds, see below.

>  /*
>   * There is no good way to get notified from vmbus_onoffer_rescind(),
>   * so let's use polling here, since this is not a hot path.
> @@ -1045,8 +1048,13 @@ static void put_pcichild(struct hv_pci_dev *hpdev)
>  static int wait_for_response(struct hv_device *hdev,
>  			     struct completion *comp)
>  {
> +	unsigned long timeout = get_jiffies_64() + msecs_to_jiffies(TIMEOUT_MS);

You can use secs_to_jiffies() here instead.

> +	unsigned long now;
> +
>  	while (true) {
> -		if (hdev->channel->rescind) {
> +		now = get_jiffies_64();
> +		if (hdev->channel->rescind ||
> +		    time_after(now, timeout)) {
>  			dev_warn_once(&hdev->device, "The device is gone.\n");
>  			return -ENODEV;
>  		}

