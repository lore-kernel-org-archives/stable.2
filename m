Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5AA13F3286;
	Thu,  6 Aug 2026 09:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786009016; cv=none; b=jx43wNo4zKr5fvAwGWid/c7vIuNrmjRVQtpD5etGikFYc20iD8rzpMi7L5KSXfqUkHXFKjRWWAghEZFafCK8jTdgwAQfbBxYwgtBp2vEKDiHQdP7u2JKc/ozzPI5PIxTbBIuOQSK6Ma3Y4QMGWc9XnekTTjXPHGcr5fA/lr5fgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786009016; c=relaxed/simple;
	bh=/9Q5cG8ldbWnfIdg/Wv2LI2RYtQy4M3JgGt631OvMTI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mEk5GXgqtkp/WCIGxD64pVlacgXN6Sqjzt1BsYhCMbGqHBoc/V9a+b9p4ap51YyqnQd2GFejcWO18tQSEQm4x+JsvnuhM/SaDrkbxhguQTnyzEij6MGn4dlibHAErx+J1kwCFOTV/CItjVQchOWm7PvfuDyYzv9G4pz+vWIYw8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n5VLFUn1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n5VLFUn1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 419E91F00A3A;
	Thu,  6 Aug 2026 09:36:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786009013;
	bh=rdPdqJV4mQ10FVUkWhMaqcDT56k5KTr7Ol9Micjxtf0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=n5VLFUn1qPcd7F41K0Bk8ZxLGk7G/Meyn99kZEhB2bsx6COgjrbp2Gu2wnHNsSPGs
	 PwiTSmHY9KLvPb9P1l+5Oaa2wkCtJhuUPcSAWfqrHCxCQ9pLiqadhHWxISiI7oex5z
	 AigrxvSIkw1A+DOM5Aerr1m60B2cF98+kG/ic3HTyr4QZU0cwmWvkCTIdgEi3RRi7V
	 0HXhBzcrcqetsgyFAkIFW22ewfeRAvLbuwgRHTHmoUNa6/FBjA4i94rqJ5xw6Pr54j
	 BSF1OgrWnlfPdeUv1zDnxfLObiSlG/v3hayVNwLSoTMUQ+mQhHdws0Xt2p5pnkNkaj
	 Pa/nxdPpPb34g==
Message-ID: <9921567d-4b3a-43b6-bf5e-eb0e92102e34@kernel.org>
Date: Thu, 6 Aug 2026 11:36:45 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/12] dt-bindings: media: qcom,venus: Add context bank
 subnodes to common schema
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
 Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
 Abhinav Kumar <abhinav.kumar@linux.dev>, Bryan O'Donoghue <bod@kernel.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Stanimir Varbanov <stanimir.varbanov@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
 Stephan Gerhold <stephan.gerhold@linaro.org>, linux-media@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Konrad Dybcio
 <konrad.dybcio@oss.qualcomm.com>, stable@vger.kernel.org,
 Daniel J Blueman <daniel@quora.org>
References: <20260731-vpu_iommu_iova_handling-v2-0-da52b5228dbd@oss.qualcomm.com>
 <20260731-vpu_iommu_iova_handling-v2-1-da52b5228dbd@oss.qualcomm.com>
 <20260805-dark-voracious-jacamar-6aae4c@quoll>
 <7a546bc6-a2b4-457d-ac27-05fc1cfe17f5@kernel.org>
 <m4rccl6zsdzmkzntc3njv3uczcppva3passjr5ukmru5q6rylx@wlwha7ydttfp>
 <163c24ba-6b78-44bb-afe9-3dcbb4d47475@kernel.org>
 <zqpgl3esozn4dgnm7remmwmquxasyc4qpyh3fgcdfblmn2xe3g@vhp5umdahvmi>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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
In-Reply-To: <zqpgl3esozn4dgnm7remmwmquxasyc4qpyh3fgcdfblmn2xe3g@vhp5umdahvmi>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 06/08/2026 11:22, Dmitry Baryshkov wrote:
> On Thu, Aug 06, 2026 at 11:11:09AM +0200, Krzysztof Kozlowski wrote:
>> On 06/08/2026 10:46, Dmitry Baryshkov wrote:
>>>
>>>> dma-ranges tell how this bus - so venus/iris - performs DMA translation
>>>> in respective to parent. Address/size-cells are obviously also needed if
>>>> this is a bus with addressing.
>>>>
>>>> But there are no children with addressing, thus what sort of bus would
>>>> it be?
>>>>
>>>> It looks to me that having here both:
>>>> 1. dma-ranges + address/size-cells
>>>> 2. children without bus addressing
>>>> is some sort of abuse of the DT syntax. It is allowed, but does not
>>>> really represent hardware.
>>>>
>>>> IOW, dma-ranges alone feels okay, although unusual, and it states proper
>>>> DMA translation for this bus. If you add address/size-cells, it means
>>>> this bus HAS addressing and thus YOU MUST use addressing.
>>>>
>>>> If my understanding is correct, then solution would be to add addressing
>>>> to the children (so unit address and "reg" property) or drop
>>>> address/size-cells as Rob pointed out. [1]
>>>
>>> Doesn't dma-ranges require address/size cells? In the end, how can you
>>
>> I think it does not require, at least how I understood the DT spec,
>> unless you provide actual addresses to the property.
>>
>> IOW, this requires address/size-cells:
>> 	dma-ranges = <0 0 0 0 0x10 0>;
>>
>>> specify the DMA address if the device doesn't have addressing at all (or
>>> MMIO-style addressing)?
>>
>> Yeah, that's why having here children without bus addressing is
>> confusing. I would interpret it that, children are not on MMIO bus, thus
>> the venus/iris is some sort of proprietary bus with no mapping between
>> parent MMIO and children nodes.
>>
>> If there is no mapping, then we do not have 'ranges' property. But I
>> could imagine that such no-mapping bus still provides access to system RAM?
>>
>> Actually this feels like a huge stretch, so I tend to think that the
>> only reasonable option is to have children with MMIO, which would make
>> it explicit: Venus/iris is a bus which provides translation of both MMIO
>> and DMA addresses to the parent.
> 
> But there are no separate addresses for those subnodes. Would you prefer

There might be some or maybe these should be the addresses of DMA?

> them to duplicate the addresses of the parent node? Or would the
> 'ranges' be enough?

I made mistake earlier - 'dma-ranges' without values is not described in
DT spec explicitly, but should be treated as 'ranges' without values,
thus direct mapping from parent to the child.

So it also requires address/size-cells, just like 'dma-ranges =
<mapping>'. And dtc checks/reports that.

I think therefore now that the binding is unusual (because no bus
addresses of children) but actually correct.

> 
> Or, thinking about it, if Venus / Iris have 32-bit addressing, then
> dma-range should probably define the limited DMA range.

That's another point which I also raised to Vikash already - mapping
should be restricted to 32-bit if this is how the child devices operate.

Best regards,
Krzysztof
