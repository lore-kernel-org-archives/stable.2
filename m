Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7C663F1052;
	Thu, 27 Aug 2026 21:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787866293; cv=none; b=ajZC5PNkZNFtB9YLW5GZbCgSmC20/Qzf5l7wfL9nI+cTPOxMCU/XwD03H0nk8diAWrXfKqbNj99s/Poy96pDl7ebz4W6hDGwFIyMswmBnKF8DHcMaJtUNbpaZ+ntdzGt54LN/ZMbhXe85GbutDFNaDjYAa/ZLklswSpGVzLzJ4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787866293; c=relaxed/simple;
	bh=soFAUHtvdICcBVLleRu5AZdyHAhV3DnN6SyMS8PK9QI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qektqjT1nOoilaGOiDQFfKq62H8+03nQ/x5BB07NfjpH10zKu25PnjbrZ+az+N9KdzghKfhspdpffRXDE2Y5XzvW6Lb8rt63Sk4OmPPL+lVkSRhF30pR+/WsWNnG3baR1wqNY7qG0C7v8dFxIPhejggxpS4HJ/Htt0Z/BzgMP0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TLn7syWK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TLn7syWK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 718181F000E9;
	Thu, 27 Aug 2026 21:31:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787866291;
	bh=9unVKK1/5iVSwUwtUvNBODIAkXlxY/1QEcZHNF7mjeg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=TLn7syWKfMb8Yas5bKfX/vd2E0ck7RCGWtxrjsqJNwPCxgP7HimTFF4CfhAEG+VOE
	 /8OfD5usJxt1CaNNniDxSUEjnrzZEER5RRcjIwRR23Qk1ZJsB2BE7joJlpjjlnuXCA
	 37HxnBWjaFfP+qT9oMeLjnkdWXNeFKcOFBV9iVgy9moxnHysQ/CUpUZV0vK+kduD5c
	 NmYTo23XieBfiUGiB4dQLGZ8Xw5D0D03VOevZuk8aOVVdKQZqpMvatAf1uaJHJPnq8
	 EhGODtx8xLhIXOZlAw7d8HhI+LyKqyspxbu9YcD06h9eMUGJiYfEQhr4ZwOf9WPINa
	 0rjhcbhcKFnAg==
Message-ID: <e21a7302-44db-4e20-805b-5c1de1f59c56@kernel.org>
Date: Thu, 27 Aug 2026 23:31:25 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] memory: brcmstb_dpfe: Fix out-of-bounds access due to
 DCPU offset
To: Florian Fainelli <florian.fainelli@broadcom.com>,
 Danesh Petigara <danesh.petigara@broadcom.com>, mmayer@broadcom.com
Cc: bcm-kernel-feedback-list@broadcom.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Justin Chen <justin.chen@broadcom.com>, stable@vger.kernel.org
References: <20260826201500.3000125-1-danesh.petigara@broadcom.com>
 <20260826201500.3000125-2-danesh.petigara@broadcom.com>
 <067b7e2e-f2b2-4462-96f1-3a1e35bd25e8@kernel.org>
 <682b68a0-03b7-4ec9-9d17-698fe134b57a@broadcom.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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
In-Reply-To: <682b68a0-03b7-4ec9-9d17-698fe134b57a@broadcom.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 27/08/2026 19:37, Florian Fainelli wrote:
> On 8/26/26 23:48, Krzysztof Kozlowski wrote:
>> On 26/08/2026 22:14, Danesh Petigara wrote:
>>> From: Justin Chen <justin.chen@broadcom.com>
>>>
>>> On API v1/v2 boards, the DCPU coprocessor can steer kernel readl_relaxed()
>>> and writel_relaxed() to any address within 256 MB of the ioremapped DPFE
>>> dmem or regs base. The DCPU firmware provides a 28-bit offset which the
>>> driver adds to the ioremap base without any bounds checking in
>>> get_msg_ptr().
>>>
>>> This allows a compromised DCPU firmware to trick the host kernel into
>>> reading or writing arbitrary memory-mapped I/O registers in vmalloc
>>> space. When combined with a root-writable sysfs file like dpfe_refresh,
>>> it provides an arbitrary MMIO write primitive. Similarly, world-readable
>>> sysfs files can be used to leak other devices' register contents.
>>
>> If someone can compromise firmware to provide different addresses, then
>> what stops this person to change DTB with completely different MMIO
>> ranges for this device?
> 
> On our platforms the DTB is part of the boot loader which is 
> signed+encrypted and customers do not build any UART driver or 
> user-interface so changing the DTB is somewhat difficult. Same goes with 
> the Linux kernel, it's also signed+encrypted. This is defense in depth 
> at this point.

Ack

> 
>>
>> Isn't better just to drop root-writeable sysfs interfaces, since they
>> are the insecure parts?
> 
> Yes that would probably be an acceptable move forward. Markus do you 
> remember what was the use case for the dpfe_refresh file to be R/W?

That's in this case separate solution, worth anyway investigating.

> 
>>
>>>
>>> Fix this by recording the resource_size() of the dmem and regs ioremaps
>>> at probe time, and rejecting any offset that, along with the largest
>>> field accessed (DRAM_VENDOR_ERROR + sizeof(u32)), exceeds the recorded
>>> mapping size.
>>>
>>> Fixes: fee5f1ef6cf7 ("memory: brcmstb: dpfe: support new way of passing data from the DCPU")
>>> Cc: stable@vger.kernel.org
>>> Signed-off-by: Justin Chen <justin.chen@broadcom.com>
>>> Assisted-by: Gemini:gemini-3.1-pro-preview cursor
>>> Signed-off-by: Danesh Petigara <danesh.petigara@broadcom.com>
>>> ---
>>>   drivers/memory/brcmstb_dpfe.c | 22 ++++++++++++++++++++--
>>>   1 file changed, 20 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/memory/brcmstb_dpfe.c b/drivers/memory/brcmstb_dpfe.c
>>> index 08d9e05b1b33..66343205f585 100644
>>> --- a/drivers/memory/brcmstb_dpfe.c
>>> +++ b/drivers/memory/brcmstb_dpfe.c
>>> @@ -182,6 +182,8 @@ struct brcmstb_dpfe_priv {
>>>   	void __iomem *regs;
>>>   	void __iomem *dmem;
>>>   	void __iomem *imem;
>>> +	resource_size_t regs_size;
>>> +	resource_size_t dmem_size;
>>>   	struct device *dev;
>>>   	const struct dpfe_api *dpfe_api;
>>>   	struct mutex lock;
>>> @@ -401,9 +403,14 @@ static void __iomem *get_msg_ptr(struct brcmstb_dpfe_priv *priv, u32 response,
>>>   	 */
>>>   	switch (msg_type) {
>>>   	case 1:
>>> +		if (DCPU_MSG_RAM_START + offset + DRAM_VENDOR_ERROR +
>>> +		    sizeof(u32) > priv->regs_size)
>>> +			goto bad_offset;
>>>   		ptr = priv->regs + DCPU_MSG_RAM_START + offset;
>>>   		break;
>>>   	case 0:
>>> +		if (offset + DRAM_VENDOR_ERROR + sizeof(u32) > priv->dmem_size)
>>> +			goto bad_offset;
>>>   		ptr = priv->dmem + offset;
>>>   		break;
>>>   	default:
>>> @@ -415,6 +422,12 @@ static void __iomem *get_msg_ptr(struct brcmstb_dpfe_priv *priv, u32 response,
>>>   	}
>>>   
>>>   	return ptr;
>>> +
>>> +bad_offset:
>>> +	dev_err(priv->dev, "DCPU returned out-of-range offset %#x\n", offset);
>>> +	if (buf && size)
>>> +		*size = sprintf(buf, "ERROR: DCPU offset out of range\n");
>>> +	return NULL;
>>>   }
>>>   
>>>   static void __finalize_command(struct brcmstb_dpfe_priv *priv)
>>> @@ -858,6 +871,7 @@ static int brcmstb_dpfe_probe(struct platform_device *pdev)
>>>   {
>>>   	struct device *dev = &pdev->dev;
>>>   	struct brcmstb_dpfe_priv *priv;
>>> +	struct resource *res;
>>>   	int ret;
>>>   
>>>   	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
>>> @@ -869,17 +883,21 @@ static int brcmstb_dpfe_probe(struct platform_device *pdev)
>>>   	mutex_init(&priv->lock);
>>>   	platform_set_drvdata(pdev, priv);
>>>   
>>> -	priv->regs = devm_platform_ioremap_resource_byname(pdev, "dpfe-cpu");
>>> +	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "dpfe-cpu");
>>
>> You cannot use devm_platform_get_and_ioremap_resource()? Are the 'reg'
>> entries flexible/random?
> 
> IIRC the names and indexes are stable so we could do a positional index 
> resource lookup, but maybe what we want is to introduce a 
> devm_platform_get_and_ioremap_resource_by_name()?

If the bindings enforces strict order, that could be a way, but I do not
want to push towards new
devm_platform_get_and_ioremap_resource_by_name() because that could lead
to long patchset with bikeshedding about how many wrappers we need...

Approach is fine then. New wrapper can be brought on top.

Best regards,
Krzysztof
