Received: from ixit.cz (ixit.cz [84.42.129.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C23674B66F6;
	Thu,  3 Sep 2026 14:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.42.129.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788446460; cv=none; b=WUsBI3IunWBdbttfYEmR7CFethnsdA2TpAk0ht8hdKw05QdFyYXdkCWBJvjybecWgbWEw+jQoURZUHbQzXm8DqOTrBVBwsMyhF+o40/c+j765lL8OwJAp87VUJka7ejHG9Mfg0XOOEftY5Jn0LB2WG8vKRVOc0Jx2ekO26RuH4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788446460; c=relaxed/simple;
	bh=4naB7UIPaDXCcNDksCUuirSZuL4IKfdjox4HXLjJDI0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j5xzorvGWHJ4tFDspsuZIK7RwggVa0Mn/Wadi6FuNjmXbxq3BmxyHr1GPGYeT2ESVEUAfU+Yq4dRN+pwsnwY4Ib3u8SNOKpnmvLbL269newqoVoYId6OHnoVW0qn5AI5qo67Y/ul9abOCAqrYqxt++Nh6+w7WmZViJRhnjxy3rY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ixit.cz; spf=pass smtp.mailfrom=ixit.cz; dkim=pass (1024-bit key) header.d=ixit.cz header.i=@ixit.cz header.b=HBTWuTmz; arc=none smtp.client-ip=84.42.129.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ixit.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ixit.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ixit.cz header.i=@ixit.cz header.b="HBTWuTmz"
Received: from [10.0.0.152] (unknown [10.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ixit.cz (Postfix) with ESMTPSA id 2382253401F6;
	Thu, 03 Sep 2026 16:40:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ixit.cz; s=dkim;
	t=1788446445;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ozigZcNd1R53uOOyPgHz9kIrV8jED5fHr5sryjLmFzc=;
	b=HBTWuTmzT13Y7VOAjc6IG2hB4+5maIPoHG0xJd58BuLMRoQqejE3KaRbXiDEEQ7I6orgvw
	rpSlBrm9GR9M4Agx3kZZ+xw4k3ebSxaH57vk+n8Jr2ezAh07Jdv0u5XqCgcI1pOBI8zIQ/
	AYze+VFui2F6UKX8qSwrJk9JS9uRK+8=
Message-ID: <ff2ee3c5-c0fc-4aa6-b64a-c77e4a2242e2@ixit.cz>
Date: Thu, 3 Sep 2026 16:40:44 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mfd: wcd934x: set DMA mask on parent to silence "DMA mask
 not set"
To: Lee Jones <lee@kernel.org>
Cc: Thomas Tai <thomas.tai@oracle.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, mfd@lists.linux.dev,
 linux-kernel@vger.kernel.org, phone-devel@vger.kernel.org,
 stable@vger.kernel.org
References: <20260823-wcd-dma-v1-1-95e44a315ccf@ixit.cz>
 <20260903124939.GT2133376@google.com>
Content-Language: en-US, cs-CZ
From: David Heidelberg <david@ixit.cz>
Autocrypt: addr=david@ixit.cz; keydata=
 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
In-Reply-To: <20260903124939.GT2133376@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 03/09/2026 14:49, Lee Jones wrote:
> On Sun, 23 Aug 2026, David Heidelberg via B4 Relay wrote:
> 
>> From: David Heidelberg <david@ixit.cz>
>>
>> The wcd934x MFD parent (a slim_device) never initializes its
>> dma_mask/coherent_dma_mask. When the DT-aware children pass through
>> of_dma_configure() this triggers the "DMA mask not set" warning for
>> each child.
>>
>> Cc: stable@vger.kernel.org
>> Fixes: f959dcd6ddfd ("dma-direct: Fix potential NULL pointer dereference")
>> Assisted-by: tencent:hy3
>> Signed-off-by: David Heidelberg <david@ixit.cz>
>> ---
>>   drivers/mfd/wcd934x.c | 6 ++++++
>>   1 file changed, 6 insertions(+)
>>
>> diff --git a/drivers/mfd/wcd934x.c b/drivers/mfd/wcd934x.c
>> index 3c3080e8c8cf7..70ee13791d52b 100644
>> --- a/drivers/mfd/wcd934x.c
>> +++ b/drivers/mfd/wcd934x.c
>> @@ -1,12 +1,13 @@
>>   // SPDX-License-Identifier: GPL-2.0
>>   // Copyright (c) 2019, Linaro Limited
>>   
>>   #include <linux/clk.h>
>> +#include <linux/dma-mapping.h>
>>   #include <linux/gpio/consumer.h>
>>   #include <linux/interrupt.h>
>>   #include <linux/kernel.h>
>>   #include <linux/mfd/core.h>
>>   #include <linux/mfd/wcd934x/registers.h>
>>   #include <linux/mfd/wcd934x/wcd934x.h>
>>   #include <linux/module.h>
>>   #include <linux/of.h>
>> @@ -212,16 +213,21 @@ static int wcd934x_slim_status(struct slim_device *sdev,
>>   static int wcd934x_slim_probe(struct slim_device *sdev)
>>   {
>>   	struct device *dev = &sdev->dev;
>>   	struct device_node *np = dev->of_node;
>>   	struct wcd934x_ddata *ddata;
>>   	struct gpio_desc *reset_gpio;
>>   	int ret;
>>   
>> +	if (!dev->dma_mask) {
>> +		dev->dma_mask = &dev->coherent_dma_mask;
>> +		dev->coherent_dma_mask = DMA_BIT_MASK(32);
>> +	}
>> +
> 
> Any reason not to use dma_coerce_mask_and_coherent()?

Didn't knew about it. Sending v2.

David
