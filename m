Received: from mail-yw1-f227.google.com (mail-yw1-f227.google.com [209.85.128.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB9CE36F915
	for <stable@vger.kernel.org>; Thu, 27 Aug 2026 17:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787852259; cv=none; b=OSBlu/EXisiyKVJGbiBJOsc1jMtC01BbMuOyJvyrpDmE/Jz5eEYzeDz86g4PyuhksZ0lrhmfgCgC4HHKe/fLIxyU57XzabICm5Ou28ZThqfxhh3+ie8AOMchXN+ymz8k2SBpsdvKDyUCF98fJBTuKtvbf8IEckeAyA7B1voBo5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787852259; c=relaxed/simple;
	bh=z9IzAgxB+3FIGTAj2Ofk8xHm/BSZx33gK3RGaZbZCGw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fjF1DwzS7uR/A7lVEtzTYInZ/Gd9eVRy51YOhM8AVgya1ZwmS06L/fR03Fe3iHI0EOjZ1Yc2xpRLXaBz3XaFNTN1S4n7w3Wpu61pBiWngkRMaD6rletC7iXVOaw9YLl+JlFaXqc+fNkE5y3VTeeltm8xvAaSUmcbgfhOG6pD2kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=A5xRypZb; arc=none smtp.client-ip=209.85.128.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="A5xRypZb"
Received: by mail-yw1-f227.google.com with SMTP id 00721157ae682-85aeb506b78so1672977b3.3
        for <stable@vger.kernel.org>; Thu, 27 Aug 2026 10:37:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787852257; x=1788457057;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=jl7DYaCAgT6voJx+/pTYVo9JkDp1mfF80CDgV5Jiw5A=;
        b=fml2CK6a3IG3GN/Xhez87LfqNyvWs3tawbcoquZnuXitt7E2azqlXjUPPcA5ANiXo6
         g9wXrFpFkgG0TljLxJBbXuDV08K5OzYHn8XBIBP49BxpFvoHr+adnjTnk+akdL/cvB13
         YsGWZ3LNuYBI7mfnaMfas+ofNzLJuwF1Sw9/igUcBDyeY/XqRQ3xI4uTdY39TOFHzXC0
         wnkrxFy/+oiRY+Bg1r9w4zv4lCaeTjGH/mvyltjc1FE6tu3oUqlYbKA0unyIhf8uxn2P
         J6sNKai1XHUWakohTwjOwd772r2QU9QAukZhwBNxmGsliUdLroirIOhII38WVPDD9UAP
         5flA==
X-Forwarded-Encrypted: i=1; AHgh+RqS+iNmRLA+MhHFY3cPVbW9w6wH1507WrlIwnUqvOzQNRmFz613MprbMkhV+T6/zHJ5VW5m30w=@vger.kernel.org
X-Gm-Message-State: AFuF++l7DdQkja04mKxeq+buOiCkBHjyGPiZglyzFE3h6vzJymTsiJvR
	s5ZFFEGjDFhtNhNxQ7DGnXZCJK+v8JYU7d7xc5SUuRZuavfSFDTJC1VSPH1jiWu2l09tovm2TNk
	6FGHcV3WKy4HVLS7mlrXd+Go1NqXGydC/9DBFo43YEk1N9Drw20gLOFMKUgExvXJm+jkgdE9z5r
	p7pHCZ5eRpWtI3djqRFFgM6Q4VUvw1V9gGLTTO+f0edX95KqEGXx1Z3qM8Tr9A2lZHuAih6ZJ1A
	U1feiP6JaPmhWiV
X-Gm-Gg: AR+sD11sesZeoCwAUtBD0MB1LXNCy305WQ6Z9h55o2/izKJ5toioHbWxSo8rAXZEMWn
	w0C7hSog8Nqmm9bKVZeBmENs7XmhznAP3UrRtq7UkePlgY+20HHKZcPJMKLjC3CrMjhsCUGl1I6
	L13W2dxak8B0qT3a1mPDqOS7/PMnbZTicyy80VgwKEOccuZFsNVtdGuIxTd1fsrUWY5cnUNYedf
	blglboW/xWEzszLc0dtioTJhCOq3BhJ6CMqt5wdwSiCPXAA6wIDOAG8fqnAEgo9gUUC3zoR15Q/
	mdYqLGNSAVt6UZUrMhBmWE01RzQKL6d1mJFPl4HNIjyVTZCnsm3OqnW28bWUDENzhHn6zwbgvhL
	xBUT5+K3dJKbwvqMpQZtpNW/tCNODNrCHsN6zd9pXWU7e8GA7aqAy7lUT5Q7ujxq3p2Mwl5gkEJ
	O0pzEevXwhRYyr3bT+mE+FUsTxSE84zcGuY9DVeykq
X-Received: by 2002:a05:690c:6606:b0:81e:deab:43af with SMTP id 00721157ae682-85d65ee7b11mr5304947b3.4.1787852256580;
        Thu, 27 Aug 2026 10:37:36 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-16.dlp.protect.broadcom.com. [144.49.247.16])
        by smtp-relay.gmail.com with ESMTPS id 00721157ae682-85b60978adfsm125637b3.13.2026.08.27.10.37.36
        for <stable@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Aug 2026 10:37:36 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-93494cce712so13723285a.3
        for <stable@vger.kernel.org>; Thu, 27 Aug 2026 10:37:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1787852256; x=1788457056; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jl7DYaCAgT6voJx+/pTYVo9JkDp1mfF80CDgV5Jiw5A=;
        b=A5xRypZbPtB+Iv0/8qnP2BIrMppRPBw3/mO1fjGa6MP8BLD6dG/pD6n2toD0hAAhEw
         MQDy2/yq3EcG4sqIllkWB9u56wYxG95Gv4CuZ9DVjGxAMZHTU6bmaKkvF4rnMKbmOvI0
         5munwhBee+ZdjvuI3l4wTulsn3mPariikUIZ0=
X-Forwarded-Encrypted: i=1; AHgh+RqorMqpghoD8eQPoaFML5ZBrHBUT5JHUy3FaXR1jlpvorale8gyzWcHZkpVuIufcqS5f7X4vco=@vger.kernel.org
X-Received: by 2002:a05:620a:620a:b0:915:9e84:85d1 with SMTP id af79cd13be357-939138d1cc9mr36639085a.23.1787852255699;
        Thu, 27 Aug 2026 10:37:35 -0700 (PDT)
X-Received: by 2002:a05:620a:620a:b0:915:9e84:85d1 with SMTP id af79cd13be357-939138d1cc9mr36628285a.23.1787852254803;
        Thu, 27 Aug 2026 10:37:34 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93913734be9sm12011585a.15.2026.08.27.10.37.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Aug 2026 10:37:33 -0700 (PDT)
Message-ID: <682b68a0-03b7-4ec9-9d17-698fe134b57a@broadcom.com>
Date: Thu, 27 Aug 2026 10:37:31 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] memory: brcmstb_dpfe: Fix out-of-bounds access due to
 DCPU offset
To: Krzysztof Kozlowski <krzk@kernel.org>,
 Danesh Petigara <danesh.petigara@broadcom.com>, mmayer@broadcom.com
Cc: bcm-kernel-feedback-list@broadcom.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Justin Chen <justin.chen@broadcom.com>, stable@vger.kernel.org
References: <20260826201500.3000125-1-danesh.petigara@broadcom.com>
 <20260826201500.3000125-2-danesh.petigara@broadcom.com>
 <067b7e2e-f2b2-4462-96f1-3a1e35bd25e8@kernel.org>
Content-Language: en-US, fr-FR
From: Florian Fainelli <florian.fainelli@broadcom.com>
Autocrypt: addr=florian.fainelli@broadcom.com; keydata=
 xsBNBFPAG8ABCAC3EO02urEwipgbUNJ1r6oI2Vr/+uE389lSEShN2PmL3MVnzhViSAtrYxeT
 M0Txqn1tOWoIc4QUl6Ggqf5KP6FoRkCrgMMTnUAINsINYXK+3OLe7HjP10h2jDRX4Ajs4Ghs
 JrZOBru6rH0YrgAhr6O5gG7NE1jhly+EsOa2MpwOiXO4DE/YKZGuVe6Bh87WqmILs9KvnNrQ
 PcycQnYKTVpqE95d4M824M5cuRB6D1GrYovCsjA9uxo22kPdOoQRAu5gBBn3AdtALFyQj9DQ
 KQuc39/i/Kt6XLZ/RsBc6qLs+p+JnEuPJngTSfWvzGjpx0nkwCMi4yBb+xk7Hki4kEslABEB
 AAHNMEZsb3JpYW4gRmFpbmVsbGkgPGZsb3JpYW4uZmFpbmVsbGlAYnJvYWRjb20uY29tPsLB
 IQQQAQgAywUCZWl41AUJI+Jo+hcKAAG/SMv+fS3xUQWa0NryPuoRGjsA3SAUAAAAAAAWAAFr
 ZXktdXNhZ2UtbWFza0BwZ3AuY29tjDAUgAAAAAAgAAdwcmVmZXJyZWQtZW1haWwtZW5jb2Rp
 bmdAcGdwLmNvbXBncG1pbWUICwkIBwMCAQoFF4AAAAAZGGxkYXA6Ly9rZXlzLmJyb2FkY29t
 Lm5ldAUbAwAAAAMWAgEFHgEAAAAEFQgJChYhBNXZKpfnkVze1+R8aIExtcQpvGagAAoJEIEx
 tcQpvGagWPEH/2l0DNr9QkTwJUxOoP9wgHfmVhqc0ZlDsBFv91I3BbhGKI5UATbipKNqG13Z
 TsBrJHcrnCqnTRS+8n9/myOF0ng2A4YT0EJnayzHugXm+hrkO5O9UEPJ8a+0553VqyoFhHqA
 zjxj8fUu1px5cbb4R9G4UAySqyeLLeqnYLCKb4+GklGSBGsLMYvLmIDNYlkhMdnnzsSUAS61
 WJYW6jjnzMwuKJ0ZHv7xZvSHyhIsFRiYiEs44kiYjbUUMcXor/uLEuTIazGrE3MahuGdjpT2
 IOjoMiTsbMc0yfhHp6G/2E769oDXMVxCCbMVpA+LUtVIQEA+8Zr6mX0Yk4nDS7OiBlvOwE0E
 U8AbwQEIAKxr71oqe+0+MYCc7WafWEcpQHFUwvYLcdBoOnmJPxDwDRpvU5LhqSPvk/yJdh9k
 4xUDQu3rm1qIW2I9Puk5n/Jz/lZsqGw8T13DKyu8eMcvaA/irm9lX9El27DPHy/0qsxmxVmU
 pu9y9S+BmaMb2CM9IuyxMWEl9ruWFS2jAWh/R8CrdnL6+zLk60R7XGzmSJqF09vYNlJ6Bdbs
 MWDXkYWWP5Ub1ZJGNJQ4qT7g8IN0qXxzLQsmz6tbgLMEHYBGx80bBF8AkdThd6SLhreCN7Uh
 IR/5NXGqotAZao2xlDpJLuOMQtoH9WVNuuxQQZHVd8if+yp6yRJ5DAmIUt5CCPcAEQEAAcLB
 gQQYAQIBKwUCU8AbwgUbDAAAAMBdIAQZAQgABgUCU8AbwQAKCRCTYAaomC8PVQ0VCACWk3n+
 obFABEp5Rg6Qvspi9kWXcwCcfZV41OIYWhXMoc57ssjCand5noZi8bKg0bxw4qsg+9cNgZ3P
 N/DFWcNKcAT3Z2/4fTnJqdJS//YcEhlr8uGs+ZWFcqAPbteFCM4dGDRruo69IrHfyyQGx16s
 CcFlrN8vD066RKevFepb/ml7eYEdN5SRALyEdQMKeCSf3mectdoECEqdF/MWpfWIYQ1hEfdm
 C2Kztm+h3Nkt9ZQLqc3wsPJZmbD9T0c9Rphfypgw/SfTf2/CHoYVkKqwUIzI59itl5Lze+R5
 wDByhWHx2Ud2R7SudmT9XK1e0x7W7a5z11Q6vrzuED5nQvkhAAoJEIExtcQpvGagugcIAJd5
 EYe6KM6Y6RvI6TvHp+QgbU5dxvjqSiSvam0Ms3QrLidCtantcGT2Wz/2PlbZqkoJxMQc40rb
 fXa4xQSvJYj0GWpadrDJUvUu3LEsunDCxdWrmbmwGRKqZraV2oG7YEddmDqOe0Xm/NxeSobc
 MIlnaE6V0U8f5zNHB7Y46yJjjYT/Ds1TJo3pvwevDWPvv6rdBeV07D9s43frUS6xYd1uFxHC
 7dZYWJjZmyUf5evr1W1gCgwLXG0PEi9n3qmz1lelQ8lSocmvxBKtMbX/OKhAfuP/iIwnTsww
 95A2SaPiQZA51NywV8OFgsN0ITl2PlZ4Tp9hHERDe6nQCsNI/Us=
In-Reply-To: <067b7e2e-f2b2-4462-96f1-3a1e35bd25e8@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On 8/26/26 23:48, Krzysztof Kozlowski wrote:
> On 26/08/2026 22:14, Danesh Petigara wrote:
>> From: Justin Chen <justin.chen@broadcom.com>
>>
>> On API v1/v2 boards, the DCPU coprocessor can steer kernel readl_relaxed()
>> and writel_relaxed() to any address within 256 MB of the ioremapped DPFE
>> dmem or regs base. The DCPU firmware provides a 28-bit offset which the
>> driver adds to the ioremap base without any bounds checking in
>> get_msg_ptr().
>>
>> This allows a compromised DCPU firmware to trick the host kernel into
>> reading or writing arbitrary memory-mapped I/O registers in vmalloc
>> space. When combined with a root-writable sysfs file like dpfe_refresh,
>> it provides an arbitrary MMIO write primitive. Similarly, world-readable
>> sysfs files can be used to leak other devices' register contents.
> 
> If someone can compromise firmware to provide different addresses, then
> what stops this person to change DTB with completely different MMIO
> ranges for this device?

On our platforms the DTB is part of the boot loader which is 
signed+encrypted and customers do not build any UART driver or 
user-interface so changing the DTB is somewhat difficult. Same goes with 
the Linux kernel, it's also signed+encrypted. This is defense in depth 
at this point.

> 
> Isn't better just to drop root-writeable sysfs interfaces, since they
> are the insecure parts?

Yes that would probably be an acceptable move forward. Markus do you 
remember what was the use case for the dpfe_refresh file to be R/W?

> 
>>
>> Fix this by recording the resource_size() of the dmem and regs ioremaps
>> at probe time, and rejecting any offset that, along with the largest
>> field accessed (DRAM_VENDOR_ERROR + sizeof(u32)), exceeds the recorded
>> mapping size.
>>
>> Fixes: fee5f1ef6cf7 ("memory: brcmstb: dpfe: support new way of passing data from the DCPU")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Justin Chen <justin.chen@broadcom.com>
>> Assisted-by: Gemini:gemini-3.1-pro-preview cursor
>> Signed-off-by: Danesh Petigara <danesh.petigara@broadcom.com>
>> ---
>>   drivers/memory/brcmstb_dpfe.c | 22 ++++++++++++++++++++--
>>   1 file changed, 20 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/memory/brcmstb_dpfe.c b/drivers/memory/brcmstb_dpfe.c
>> index 08d9e05b1b33..66343205f585 100644
>> --- a/drivers/memory/brcmstb_dpfe.c
>> +++ b/drivers/memory/brcmstb_dpfe.c
>> @@ -182,6 +182,8 @@ struct brcmstb_dpfe_priv {
>>   	void __iomem *regs;
>>   	void __iomem *dmem;
>>   	void __iomem *imem;
>> +	resource_size_t regs_size;
>> +	resource_size_t dmem_size;
>>   	struct device *dev;
>>   	const struct dpfe_api *dpfe_api;
>>   	struct mutex lock;
>> @@ -401,9 +403,14 @@ static void __iomem *get_msg_ptr(struct brcmstb_dpfe_priv *priv, u32 response,
>>   	 */
>>   	switch (msg_type) {
>>   	case 1:
>> +		if (DCPU_MSG_RAM_START + offset + DRAM_VENDOR_ERROR +
>> +		    sizeof(u32) > priv->regs_size)
>> +			goto bad_offset;
>>   		ptr = priv->regs + DCPU_MSG_RAM_START + offset;
>>   		break;
>>   	case 0:
>> +		if (offset + DRAM_VENDOR_ERROR + sizeof(u32) > priv->dmem_size)
>> +			goto bad_offset;
>>   		ptr = priv->dmem + offset;
>>   		break;
>>   	default:
>> @@ -415,6 +422,12 @@ static void __iomem *get_msg_ptr(struct brcmstb_dpfe_priv *priv, u32 response,
>>   	}
>>   
>>   	return ptr;
>> +
>> +bad_offset:
>> +	dev_err(priv->dev, "DCPU returned out-of-range offset %#x\n", offset);
>> +	if (buf && size)
>> +		*size = sprintf(buf, "ERROR: DCPU offset out of range\n");
>> +	return NULL;
>>   }
>>   
>>   static void __finalize_command(struct brcmstb_dpfe_priv *priv)
>> @@ -858,6 +871,7 @@ static int brcmstb_dpfe_probe(struct platform_device *pdev)
>>   {
>>   	struct device *dev = &pdev->dev;
>>   	struct brcmstb_dpfe_priv *priv;
>> +	struct resource *res;
>>   	int ret;
>>   
>>   	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
>> @@ -869,17 +883,21 @@ static int brcmstb_dpfe_probe(struct platform_device *pdev)
>>   	mutex_init(&priv->lock);
>>   	platform_set_drvdata(pdev, priv);
>>   
>> -	priv->regs = devm_platform_ioremap_resource_byname(pdev, "dpfe-cpu");
>> +	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "dpfe-cpu");
> 
> You cannot use devm_platform_get_and_ioremap_resource()? Are the 'reg'
> entries flexible/random?

IIRC the names and indexes are stable so we could do a positional index 
resource lookup, but maybe what we want is to introduce a 
devm_platform_get_and_ioremap_resource_by_name()?
-- 
Florian
