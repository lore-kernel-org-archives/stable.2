Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03FAC3321A7;
	Wed, 12 Aug 2026 16:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786550975; cv=none; b=tIeDlSCLYke2pBlD7lkXK7naEMWxKeuESrtrtzBkHpOvWIRkNFH9hoffE8BAkoJzV8UsoMo81+fmukmkAJ0yWnFGr/PfV2NZlQN9Tz7466xDOBGrB1G0CtS7PG9ZQsqZkZ384/UZSg7eSYa4bWjk9TSrGkBGintdDSTilE1yaCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786550975; c=relaxed/simple;
	bh=gE61fvifrYqpGR3X2GYMe+i9ZrniAMwVNwX7pDzGIhw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H6VfVND3BovNMrv6nhf8/g6Bzaxy71ofQeZPJRnTE+PpSVL235Ut52g+tMkWu4ST8Hx5udp4vTJvhFp/pNOUc4Rpi30vBTXV08NcEausPBJY3zVsoe0BBT0LBARGFYpK5FrapqlwfiyGwCOzAoTLQjkEe31HtELSOY6EUBz6ic4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P1jeFAOq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P1jeFAOq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C109B1F000E9;
	Wed, 12 Aug 2026 16:09:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786550973;
	bh=SUFBrQ1nQLkrBvvgBqMI8JlTiz31F3hZgB1piZ45IDY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=P1jeFAOqKyRs12l5w++ExNW2uzyP3pMsxLuK5ozTyW92m6vOwMByjqAaONNogjibZ
	 qFv71P2EXTWRjj75c4h+rfc2eRjkL1rA8rEdvIvaIQduXoU2zgsoQisETRxGxrThFo
	 HhMaPDq34DYnte1w6W7rhJUq0IVykDEnmK2zTqVd3zWGlF67382Q2t6+IXyFDXH2bI
	 IpaTyVXWTJfnsVxGGcHYTS6ZkWaU/pE0WKlHVMlzeFWYzT50LVhn8D3P4CF2Ik3CcP
	 deNhb0IyTfQGGrYd+v0H97wuP6U5mTlG+x3X9gg4ELqR5i7L0XcnMH6X84GK0ySo3p
	 7J/t9H4M+RNIg==
Message-ID: <815c0301-200f-4bc9-bb80-e4920eb4fe27@kernel.org>
Date: Wed, 12 Aug 2026 18:09:14 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/22] arm64: dts: qcom: hamoa: Reserve low IOVA range for
 Iris
To: Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
 Rob Herring <robh@kernel.org>, Bryan O'Donoghue <bod@kernel.org>
Cc: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
 Sakari Ailus <sakari.ailus@linux.intel.com>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Stephan Gerhold <stephan.gerhold@linaro.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Stanimir Varbanov <stanimir.varbanov@linaro.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Johan Hovold <johan+linaro@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Loic Poulain <loic.poulain@oss.qualcomm.com>,
 Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>,
 Mansur Alisha Shaik <mansur@codeaurora.org>,
 Andy Gross <andy.gross@linaro.org>, Rob Clark
 <robin.clark@oss.qualcomm.com>, Stephen Boyd <sboyd@codeaurora.org>,
 Yassine Oudjana <y.oudjana@protonmail.com>,
 Pierre-Hugues Husson <phhusson@freebox.fr>,
 Marc Gonzalez <mgonzalez@freebox.fr>, cros-qcom-dts-watchers@chromium.org,
 Matthias Kaehlcke <mka@chromium.org>,
 Douglas Anderson <dianders@chromium.org>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Aniket Masule <amasule@codeaurora.org>,
 Malathi Gottam <quic_mgottam@quicinc.com>,
 Rajendra Nayak <quic_rjendra@quicinc.com>, Jonathan Marek
 <jonathan@marek.ca>, Dikshita Agarwal <dikshita@qti.qualcomm.com>,
 Renjiang Han <quic_renjiang@quicinc.com>, linux-media@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
 Daniel J Blueman <daniel@quora.org>, stable@vger.kernel.org
References: <20260807-iris_iova_600mb_fix-v1-0-3996f67e33f9@oss.qualcomm.com>
 <20260807-iris_iova_600mb_fix-v1-4-3996f67e33f9@oss.qualcomm.com>
 <ruow4uus64krlpy2gvm3g2d6rq5kgmgxnlhstmecil3gw7lhkd@2golvucd473l>
 <20260807162405.GA896590-robh@kernel.org>
 <c3hVumMy_QnRbUmbFTSWGjkfG7lPjGFEcZfPsZeGQ57nWKkhlBL3wgmcDcAgT9cNb8Ju3qZ_sSKgHk8vmow0xQ==@protonmail.internalid>
 <6ee7f32e-eb6c-e264-6f0d-541555f8fd62@oss.qualcomm.com>
 <56b3dfcf-b1ad-4192-8199-06c80cc5d124@kernel.org>
 <CAL_JsqLGOz7Fh=AsM+g84=Uko10YXU4QN1buApD3CJMkOmsebA@mail.gmail.com>
 <1a7c222a-617b-4dfd-a551-2c00115747a9@oss.qualcomm.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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
In-Reply-To: <1a7c222a-617b-4dfd-a551-2c00115747a9@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 12/08/2026 17:44, Vikash Garodia wrote:
> 
> On 8/10/2026 7:17 PM, Rob Herring wrote:
>> On Sat, Aug 8, 2026 at 4:55 AM Bryan O'Donoghue <bod@kernel.org> wrote:
>>>
>>> On 08/08/2026 05:37, Vishnu Reddy wrote:
>>>>
>>>> On 8/7/2026 9:54 PM, Rob Herring wrote:
>>>>> On Fri, Aug 07, 2026 at 12:03:50PM +0300, Dmitry Baryshkov wrote:
>>>>>> On Fri, Aug 07, 2026 at 01:54:48PM +0530, Vikash Garodia wrote:
>>>>>>> From: Daniel J Blueman <daniel@quora.org>
>>>>>>>
>>>>>>> On X1-family hamoa platforms, the Iris VPU reserves IOVA addresses
>>>>>>> below 0x25800000 (600MB), primarily for secure non-pixel buffers. DMA
>>>>>>> into that range, from any other stream id would triggers unhandled SMMU
>>>>>>> page faults that cause spontaneous device reboots. This is readily
>>>>>>> reproduced with one or more browser tabs driving multiple concurrent
>>>>>>> video decode streams.
>>>>>>>
>>>>>>> Add a reserved-memory IOVA reservation node covering [0, 0x25800000]
>>>>>>> and reference it from the Iris node so the IOMMU layer keeps DMA
>>>>>>> allocations above that boundary.
>>>>>>>
>>>>>>> Link: https://github.com/qualcomm-linux/kernel-topics/issues/1157#issuecomment-4458933574
>>>>>>> Fixes: 9065340ac04d ("arm64: dts: qcom: x1e80100: Add IRIS video codec")
>>>>>>> Cc: stable@vger.kernel.org
>>>>>>> Signed-off-by: Daniel J Blueman <daniel@quora.org>
>>>>>>> Signed-off-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
>>>>>>> ---
>>>>>>>    arch/arm64/boot/dts/qcom/hamoa.dtsi | 13 ++++++++++++-
>>>>>>>    1 file changed, 12 insertions(+), 1 deletion(-)
>>>>>>>
>>>>>>> diff --git a/arch/arm64/boot/dts/qcom/hamoa.dtsi b/arch/arm64/boot/dts/qcom/hamoa.dtsi
>>>>>>> index 8a96ea1bdb9c4c409b2af997680d8c13fed0643e..87f424765d513c97b06303bceb75ca9f176d2ace 100644
>>>>>>> --- a/arch/arm64/boot/dts/qcom/hamoa.dtsi
>>>>>>> +++ b/arch/arm64/boot/dts/qcom/hamoa.dtsi
>>>>>>> @@ -666,6 +666,17 @@ smem_mem: smem@ffe00000 {
>>>>>>>                     hwlocks = <&tcsr_mutex 3>;
>>>>>>>                     no-map;
>>>>>>>             };
>>>>>>> +
>>>>>>> +          /*
>>>>>>> +           * The Iris VPU reserves IOVA below 0x25800000 (600MB),
>>>>>>> +           * primarily for non-pixel buffers using different Stream IDs.
>>>>>>> +           * DMA into that range triggers unhandled SMMU faults and
>>>>>>> +           * spontaneous reboots, so reserve it to keep IOMMU
>>>>>>> +           * allocations above this boundary.
>>>>>>> +           */
>>>>>>> +          iris_iova: iris-iova {
>>>>>>> +                  iommu-addresses = <&iris 0x0 0x0 0x0 0x25800000>;
>>>>>>> +          };
>>>>>>>     };
>>>>>>>
>>>>>>>     qup_opp_table_100mhz: opp-table-qup100mhz {
>>>>>>> @@ -5439,7 +5450,7 @@ &config_noc SLAVE_VENUS_CFG QCOM_ICC_TAG_ACTIVE_ONLY>,
>>>>>>>                     interconnect-names = "cpu-cfg",
>>>>>>>                                          "video-mem";
>>>>>>>
>>>>>>> -                  memory-region = <&video_mem>;
>>>>>>> +                  memory-region = <&video_mem>, <&iris_iova>;
>>>>>> I don't like the idea of this series, because it _again_ doesn't tell us
>>>>>> the truth about the hardware. This typicall ends up with bigger problems
>>>>>> later on, when it starts to affect other bits and pieces.
>>>>>>
>>>>>> I don't want to NAK it, but I'd strongly ask to reconsider it.
>>>>> I think this is an abuse of /reserved-memory. reserved-memory is
>>>>> reserved *physical* memory. Reserved IOVA is a property on top of that.
>>>>> I'm surprised this passes validation. If it does, I may go fix that.
>>>>
>>>> As per the reserved-memory.yaml schema document, the iommu-addresses
>>>> property for IOVA reservation into /reserved-memory is allowed — it's
>>>> documented for IOVA carveout reservations:
>>>> https://github.com/devicetree-org/dt-schema/blob/main/dtschema/schemas/reserved-memory/reserved-memory.yaml#L56
>>> I think that is an entirely reasonable reading of the text
>>>
>>> Quote:
>>>
>>> "If no "reg" property is specified, the "iommu-addresses" property
>>>    defines carveout regions in the IOVA space for the given device. This
>>>    can be useful if a certain memory region should not be mapped through
>>>    the IOMMU."
>>>
>>> Which is exactly what this series does. Excludes a specific IOVA range
>>> from being allocated for this device.
>>
>> But if "iommu-addresses" is the only property of the reserved memory,
>> why put this property in reserved-memory rather than directly in the
>> device's node? I'm only questioning where is the right place to
>> describe a reserved IOVA.
>>
> 
> a single property node vs multi-property node should not be the reason 
> to decide the place i believe, rather having them all under 
> reserve-memory keeps all reservation at one place instead of scattering 
> it all over.
> 

It is not about the amount of properties, but the intention of
reserved-nodes. Their intention is for reserved memory, which you do not
have here really.

Best regards,
Krzysztof
