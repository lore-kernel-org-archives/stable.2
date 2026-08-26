Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3825B282F17;
	Wed, 26 Aug 2026 02:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787711077; cv=none; b=a8AIt05OomEih1vvAQP4/1J9o22iKSh5KCRGHnTSaduErCCSpYrs+jmDkYYJqXgww6kUgTwxOycjyQ7lyT3tIQjFi4+g8DY5FIdrN8ciCXXAgz1tgvg0Tgf88XYu5lDvxJBko/ZCRCi9LVp69Sv+3Kh6cVNc6S+qzO5HOvDe1bM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787711077; c=relaxed/simple;
	bh=14b0stW5jhQNnGgUU9Q3PBXBuFCEKtHBlLnHB0hlj4s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=udeyrSzRoTerH7Tlm6+0fQtNAw8M7+VFfRsggKtHikFqSFZ3qPoRenJMLtjeFDxndKd4668SlI13yLfHvf71HGf51yHiv6AZEaIfLadFzExcYt8tHNRWsto4wj0JF2HP74X3fc3PjdlfBjR9f+ehcEgY+cx2kLB9P1COUwJJHL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 400493a8a0f511f19a56ed5b684f684d-20260826
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:4e685729-2c37-48f1-a137-09bd151f7d3c,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:7db8b62,CLOUDID:007a68245441e193de880e54a407ae3f,BulkI
	D:nil,BulkQuantity:0,SF:80|81|82|83|102|865|898,TC:nil,Content:0|15|52,EDM
	:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0
	,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 400493a8a0f511f19a56ed5b684f684d-20260826
X-User: lilinmao@kylinos.cn
Received: from [10.0.2.15] [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <lilinmao@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_128_GCM_SHA256 128/128)
	with ESMTP id 1637893290; Wed, 26 Aug 2026 10:24:22 +0800
Message-ID: <d8d17463-cde2-47a0-9e18-ffa5d8cab52b@kylinos.cn>
Date: Wed, 26 Aug 2026 10:24:18 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: adc: ade9000: fix NULL pointer dereference in clkout
 registration
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
 Antoniu Miclaus <antoniu.miclaus@analog.com>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, David Lechner <dlechner@baylibre.com>,
 Andy Shevchenko <andy@kernel.org>, linux@analog.com,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20260824125210.1644319-1-lilinmao@kylinos.cn>
 <aoxecT3hNa-M3UMn@ashevche-desk.local>
From: Linmao Li <lilinmao@kylinos.cn>
In-Reply-To: <aoxecT3hNa-M3UMn@ashevche-desk.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


在 2026/8/24 23:08, Andy Shevchenko 写道:
> On Mon, Aug 24, 2026 at 08:52:10PM +0800, Linmao Li wrote:
>> ade9000_setup_clkout() passes NULL as the register address when
>> registering a divider clock. During clock registration, the common
>> clock framework calls clk_divider_recalc_rate(), which dereferences
>> the address through readl(). As a result, probing an ADE9000 configured
>> as a clock provider with an external input clock crashes.
>>
>> CLKOUT passes CLKIN through without changing its rate. Register it as
>> a 1:1 fixed-factor clock, which does not require register access.
> Do you have HW to test? What will be the result for the internal clock case?
No, unfortunately I do not have access to the hardware, so this is
based on code inspection only.

For the crystal oscillator case, the device tree does not provide a
clocks property. devm_clk_get_optional_enabled() therefore returns
NULL, and ade9000_setup_clkout() returns here:

         if (!device_property_present(dev, "#clock-cells") || !st->clkin)
                 return 0;

No clock provider is registered in that case. This behavior is
unchanged by the patch. The modified registration path is reached only
when an external input clock is present and the device is configured as
a clock provider.

Thanks,
Linmao
>
