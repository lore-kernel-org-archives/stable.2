Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0419E471CFD
	for <stable@vger.kernel.org>; Thu,  6 Aug 2026 11:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786017426; cv=none; b=WNiwoeJ6nhSVIfzuZNFh6mAZgDTBvEpTfYt49JYzRS6cjl5Z8cl71CztruxmGWyWDm3kic250pA/VdqMd1Hled+OaIiqHkJbriPCNWRLEAUdmuuzBzXGbziaKAxVuPE2mcxIvPZf5RpCcImulaEyBqRZgFsStivmpBoJXg/5o9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786017426; c=relaxed/simple;
	bh=xNFLD4E91K9S2ZUtnWsmxgEzMpCxGHiVf/rcwec9iMk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FpFrNs7IPBYbUgUkXAdmp4eTau+NXUHSN0f+IWV/1zHL7lrmMj52KxG9hKH1y42A7I7IkyiFIvFbfquwvq0ugfdNiU99gjT0XYnrqsahc90VOH3MnydYf96YclVubbtyIinQUfazStucx5VBEhn2sL1R4H1rjscpGQebvqM4cd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GlpPpJgv; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=FfJ4z9Bp; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GlpPpJgv";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FfJ4z9Bp"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6769ngJo1876508
	for <stable@vger.kernel.org>; Thu, 6 Aug 2026 11:57:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	VkStwf3S7kCqSDAEDhjUDeg3C2rvnMkGzJXuP0MDY+I=; b=GlpPpJgvZ4rXTz3f
	Vbsow/BTSTRqHZoBrpNGzGx138KjJFsEmgyX9Sc2fuGNub047NhdGuwleFhS4M87
	+rgPv98MEYMz4fC1yLiveSrHxyyOw2xPq95xVuhtIznpX729wUuwdUqEEiphCr7M
	eEoVcb12j205pC1C/FqFKPE8FelWHeK7YCcz8lvOnlc0naKn+VjN/ajhz84I9u0S
	ymJB+jSNGRaAePHEzS9s3NldXyooEL02lVY9a9BrQgr9ZslmLb8kGX1pr7O3Ne+8
	qHN+xYD4XgdseoK4SIDEks6IzABN9z4VZSZLBY1gQyQw/oZqeDbg2h2BsuuWVOd/
	Dk2bmg==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fvjuchy5u-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 06 Aug 2026 11:57:02 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cbbb9c9bfc3so1319575a12.1
        for <stable@vger.kernel.org>; Thu, 06 Aug 2026 04:57:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786017421; x=1786622221; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VkStwf3S7kCqSDAEDhjUDeg3C2rvnMkGzJXuP0MDY+I=;
        b=FfJ4z9BpbPicDbzACOITEcRIy8nXerTvWRJ+q7qhdJKoOJ7CCiuRnS2L7gBhcociEm
         z6XaWnnl6t7K6FLFm4OHxYokwTWEZUJ8/PoZipEY2FoqtlRO+yhTT9IUJkZLwT02leKr
         3ztibQ6YPqhd4CdKwj+14YgQe9BJrEz1uORcJgi/L2gkTMm9Lrywz/xj0KvKMlkjQ0WI
         LD8lfiP8MmxpnKEt/Qr9nTG/W9lXijoGp1MlT6PAmwyWSyqLyavyZefFQXS6V8Ft0XLq
         JE03hMfNdFnL0PywYLf0KsqNUb14adM6TsZJTZ9ZmePOrCfrlMXJtUk3lN4xAbE5Vm5+
         X3bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786017421; x=1786622221;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VkStwf3S7kCqSDAEDhjUDeg3C2rvnMkGzJXuP0MDY+I=;
        b=TKa0VVUQw+jpZnQSbfV1uz8/kSbFd3+z7+fmG8ACCjhjc4o3lE9lhBH0dIGn7IaFBv
         gmwGvj8JQmDIg6WFpjG8dNdZrqX5IFEOlWi9onD3pRPUA9tkSrkdIMmj3PmITwDbZtB+
         dR1XmJia0TVf4ti2m56IRoP8EpVCqS0s3L9k0/yFRitlg1VfndBReEPyGTfv1WTDr0H5
         LsKx+QHGYKBB43eWSXDKTPlhuv1o/VXTzDYUwPm2MH1K48X6+3CMNbcYVcXbsD6yrE2l
         EB2qFcyBmDq/E3daejreEIOIgt9yeEVD64SD0UcqbZIgt/BUckn5yjLEDWyY/9fAflyH
         WH+g==
X-Forwarded-Encrypted: i=1; AHgh+Ro/L3vjT9/RL91Nm8WKX9+BXOfWgexvCy9mEfrUx6cC0w/sazD1kElKqGtF8iLjeR9mN9S08GA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJAWyTiPkicFzjaH4A4F/wms8nzVWbUqQrAyMWbASo41WXCE35
	9W0/WyVRq4P1Ed/sDzVI61GDL7w3vVsirOEKrmHBJmLRwhA0u1LSjWhwQIwmkdk4Z4AxQTS3rly
	vTnYQyyJmswTBh/J1jpc5W4CiVs6QqKX+ZFa35gQPUxFlGKEIjJ63Skbjxmc=
X-Gm-Gg: AR+sD112tDjasgb9KXO6OWyCY4azOOHKhwEPJYK1PN43Q16xDPE3d46Dd6tfZN4sKvd
	R6DN1UGNaTiunsvD5YqLys7i3hPdtXssekxJnIp8p5oSlQLdGrVl5A+4Oe9wzedntnCX/1cfYMT
	tkArDkxwFUVGaw4BcbNx8Wgw9tCLgYKhZphJ2x46pDVf9At3fL7mWmfVi/vLEqAmMG7+RS9MBE2
	OBud/n8cQk67s9mKphE2KVZaAq8+NdA4RWHqFHS55BPHp1npk5SGdJsTWVbCEsaJ7vw9T82qUVo
	+UC7JneajPTyeKcmrwInYj9WdDGu1iMMDhLlDlA5ZDfl731+2xLs+xONauAS3lidNASVIaOe/pk
	dBou66R4hjlvsNow3yGfhuySYfIDXMtlAFZk=
X-Received: by 2002:a05:6a20:9e0e:b0:3bf:6ac8:8d29 with SMTP id adf61e73a8af0-3cb85e736dfmr18447900637.21.1786017421184;
        Thu, 06 Aug 2026 04:57:01 -0700 (PDT)
X-Received: by 2002:a05:6a20:9e0e:b0:3bf:6ac8:8d29 with SMTP id adf61e73a8af0-3cb85e736dfmr18447828637.21.1786017420682;
        Thu, 06 Aug 2026 04:57:00 -0700 (PDT)
Received: from [192.168.0.173] ([183.83.142.146])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-315ae6c1f9fsm4873066eec.17.2026.08.06.04.56.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Aug 2026 04:57:00 -0700 (PDT)
Message-ID: <d0dfd058-f0a0-41e3-a7ad-89eccd0571cb@oss.qualcomm.com>
Date: Thu, 6 Aug 2026 17:26:51 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/12] dt-bindings: media: qcom,venus: Add context bank
 subnodes to common schema
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Cc: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Stephan Gerhold <stephan.gerhold@linaro.org>,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Konrad Dybcio
 <konrad.dybcio@oss.qualcomm.com>,
        stable@vger.kernel.org, Daniel J Blueman <daniel@quora.org>
References: <20260731-vpu_iommu_iova_handling-v2-0-da52b5228dbd@oss.qualcomm.com>
 <20260731-vpu_iommu_iova_handling-v2-1-da52b5228dbd@oss.qualcomm.com>
 <20260805-dark-voracious-jacamar-6aae4c@quoll>
 <7a546bc6-a2b4-457d-ac27-05fc1cfe17f5@kernel.org>
 <m4rccl6zsdzmkzntc3njv3uczcppva3passjr5ukmru5q6rylx@wlwha7ydttfp>
 <163c24ba-6b78-44bb-afe9-3dcbb4d47475@kernel.org>
 <zqpgl3esozn4dgnm7remmwmquxasyc4qpyh3fgcdfblmn2xe3g@vhp5umdahvmi>
 <9921567d-4b3a-43b6-bf5e-eb0e92102e34@kernel.org>
 <npojagmk7x24wpbqcmzg4mijscqz63aluh6lj5uaciztzl53wl@ld342uighqaa>
Content-Language: en-US
From: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
In-Reply-To: <npojagmk7x24wpbqcmzg4mijscqz63aluh6lj5uaciztzl53wl@ld342uighqaa>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA2MDA5NCBTYWx0ZWRfXyomkZIviE2j2
 +iHHTnouADTTgwkJ+2f6lsrEdMGOREickvhDfkNKg38Vyt07mknsDarlbeocd78GDpeS9dqluCk
 gKqqTz2+CdsvUa3uOXMK+hVymMHshTU=
X-Proofpoint-GUID: OpqWQ4gg44V4E2mbfO_xE5JXtyymjf1A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA2MDA5NCBTYWx0ZWRfXwRyysteTQIPN
 rdeLT1XhT31GQyOAxKn5UB2mQW50NSm4/ozV0JOOUnTnKoNF/5WsIDPaTvK4dzBNXLD1MbzMv4t
 ef31BMociSXPgKxsUy2khUqArYlqKBVfVaN5WYquArFIZhEH5i5ue6iIL/1Vw+sSPK1ZOfTSSFS
 qjWW5Akh1sihKsTw25V72xw4ZM7LEFaIZPMz19KaykZ2w951rrezEcBxIxX0RksL8pn1Ct+i1GS
 A3PVcqBzBlu14EK93gKuqrWOD0cQEbG5Z078i49AvhEbfS4OmWI/+5OkS9V9pfCec+HdkGtG8T3
 UGGPrLm+NBIcpbsYu+c1KVLJjTsz10BAvc7n9nNMOhOneC1/7wlcxddlF+52xOkBmZ/vx3PiZSI
 HOlPKsb5XuulILYwNaC05omSTmw1XJcrihuUEPQ94B4iykHF/zRXVZLcfkQlNMIkU5PXA6yGxQ9
 CJd1EsZG0s/trSfHT7A==
X-Authority-Analysis: v=2.4 cv=Mo1iLWae c=1 sm=1 tr=0 ts=6a74768e cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=eVbXwf39F0J6/s7D6zfB/A==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=2aMSz8YdNj8EIwJtzwMA:9 a=QEXdDO2ut3YA:10 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-ORIG-GUID: OpqWQ4gg44V4E2mbfO_xE5JXtyymjf1A
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_06,2026-08-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 priorityscore=1501 adultscore=0
 malwarescore=0 bulkscore=0 clxscore=1015 suspectscore=0 spamscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608060094


On 8/6/2026 4:05 PM, Dmitry Baryshkov wrote:
> On Thu, Aug 06, 2026 at 11:36:45AM +0200, Krzysztof Kozlowski wrote:
>> On 06/08/2026 11:22, Dmitry Baryshkov wrote:
>>> On Thu, Aug 06, 2026 at 11:11:09AM +0200, Krzysztof Kozlowski wrote:
>>>> On 06/08/2026 10:46, Dmitry Baryshkov wrote:
>>>>>
>>>>>> dma-ranges tell how this bus - so venus/iris - performs DMA translation
>>>>>> in respective to parent. Address/size-cells are obviously also needed if
>>>>>> this is a bus with addressing.
>>>>>>
>>>>>> But there are no children with addressing, thus what sort of bus would
>>>>>> it be?
>>>>>>
>>>>>> It looks to me that having here both:
>>>>>> 1. dma-ranges + address/size-cells
>>>>>> 2. children without bus addressing
>>>>>> is some sort of abuse of the DT syntax. It is allowed, but does not
>>>>>> really represent hardware.
>>>>>>
>>>>>> IOW, dma-ranges alone feels okay, although unusual, and it states proper
>>>>>> DMA translation for this bus. If you add address/size-cells, it means
>>>>>> this bus HAS addressing and thus YOU MUST use addressing.
>>>>>>
>>>>>> If my understanding is correct, then solution would be to add addressing
>>>>>> to the children (so unit address and "reg" property) or drop
>>>>>> address/size-cells as Rob pointed out. [1]
>>>>>
>>>>> Doesn't dma-ranges require address/size cells? In the end, how can you
>>>>
>>>> I think it does not require, at least how I understood the DT spec,
>>>> unless you provide actual addresses to the property.
>>>>
>>>> IOW, this requires address/size-cells:
>>>> 	dma-ranges = <0 0 0 0 0x10 0>;
>>>>
>>>>> specify the DMA address if the device doesn't have addressing at all (or
>>>>> MMIO-style addressing)?
>>>>
>>>> Yeah, that's why having here children without bus addressing is
>>>> confusing. I would interpret it that, children are not on MMIO bus, thus
>>>> the venus/iris is some sort of proprietary bus with no mapping between
>>>> parent MMIO and children nodes.
>>>>
>>>> If there is no mapping, then we do not have 'ranges' property. But I
>>>> could imagine that such no-mapping bus still provides access to system RAM?
>>>>
>>>> Actually this feels like a huge stretch, so I tend to think that the
>>>> only reasonable option is to have children with MMIO, which would make
>>>> it explicit: Venus/iris is a bus which provides translation of both MMIO
>>>> and DMA addresses to the parent.
>>>
>>> But there are no separate addresses for those subnodes. Would you prefer
>>
>> There might be some or maybe these should be the addresses of DMA?
>>
>>> them to duplicate the addresses of the parent node? Or would the
>>> 'ranges' be enough?
>>
>> I made mistake earlier - 'dma-ranges' without values is not described in
>> DT spec explicitly, but should be treated as 'ranges' without values,
>> thus direct mapping from parent to the child.
> 
> Documentation/devicetree/bindings/iommu/iommu.txt:
> 
>    An empty "dma-ranges" property means that there is a 1:1 mapping from
>    IOMMU to memory.
> 
>>
>> So it also requires address/size-cells, just like 'dma-ranges =
>> <mapping>'. And dtc checks/reports that.
>>
>> I think therefore now that the binding is unusual (because no bus
>> addresses of children) but actually correct.
>>
>>>
>>> Or, thinking about it, if Venus / Iris have 32-bit addressing, then
>>> dma-range should probably define the limited DMA range.
>>
>> That's another point which I also raised to Vikash already - mapping
>> should be restricted to 32-bit if this is how the child devices operate.
> 
> Souds so. Then we need a non-empty dma-ranges.
> 
> 

based on this discussion, below works for schema check and dtc

schema:
   '#address-cells':
     const: 1

   '#size-cells':
     const: 1

   dma-ranges:
     maxItems: 1


Now in the schema examples, soc is added to match the reg/dma-ranges of 
parent (iris)

   examples
      soc {
           #address-cells = <2>;
           #size-cells = <2>;

           video-codec@aa00000 {
             compatible = "qcom,sm8550-iris";
             reg = <0x0 0x0aa00000 0x0 0xf0000>;

DTS

iris {
....
   #address-cells = <1>;
   #size-cells = <1>;
   dma-ranges = <0x0 0x0 0x0 0xe0000000>;

   iris_non_pixel: non-pixel {
	iommus = <&apps_smmu 0x1940 0x0>;
	memory-region = <&iris_resv>;
   };

   pixel {
	iommus = <&apps_smmu 0x1947 0x0>;
   };

Please review if anything is missed out.

Regards,
Vikash
