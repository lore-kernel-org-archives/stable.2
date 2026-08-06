Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6DA74334C1
	for <stable@vger.kernel.org>; Thu,  6 Aug 2026 09:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786009963; cv=none; b=B/Mk54VvklvD1guyhdEd6VARRrgh4jNwS2FtQdfzAshFd3D6jTmRHuI7jyUrThIJXbcRDvw0RXQMGPcUesvOQVsThqEh2M6KXSvBaFTVE/lwatYZmpwkjrM8kqohkmLD0+gN62lnCvuoJq8y3/YX5XDPxsfy5pT9doQAtC7f6Bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786009963; c=relaxed/simple;
	bh=gRUha24JKDyYXQuYod1ckbZURT/+JZRsMXtQhQkCg9A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J9TO1pz97o/DhJUfkNAAgMWGv3jBnVl1iF7/FCJwyADWo41+nyEyMBuH1FbMqIadVSbJutxvI7dwtRD1u1ze2s7rOs8jL6F8qIrm5ZqWu0Lub392ijWurd3D7WF5R3wdGwOjx/btmFUHvIqXLQuRfvwodZswENd8gE/0y44oDWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=E6jMlumV; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=JYD88+ek; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="E6jMlumV";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="JYD88+ek"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6769ngdO1534128
	for <stable@vger.kernel.org>; Thu, 6 Aug 2026 09:52:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	LIidbOLK7YUH8s7JFWhLKurGYVJCaqUu4CJdXBld3+8=; b=E6jMlumVYbMKyvpr
	Bt+kkZWLKXs74BeVc1MMiS+OGhLn/hGQ2+DE5t64a78ohB+YXaJKd34UszQXqVb6
	pWvFJCiCQwCpyFzr9nQjLXs+bI7NwZFJzLnBOriPaBrspqNnUeBlsjt4LHvvzAtt
	cKUkpx4BwOfe9VyVOdZjWU319Zt6ZZ4QddJ1NXo2TT9t6pehELXDj7pBAjAhtGUf
	H1CYBKabn0z73M7SDJvGq361TkfH1DfMqeZv6GSlgCWsaaetkRExFyj7PI6W/xTB
	qqF7edmtv5NCe2r6ZWX8KxtZR2EZohOL8G/hHZRUIK7kCapszHxRqWAu4wEGeaxx
	K7N7lg==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fvn8prsyn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 06 Aug 2026 09:52:37 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-38dde0df80bso2847204a91.3
        for <stable@vger.kernel.org>; Thu, 06 Aug 2026 02:52:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786009956; x=1786614756; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LIidbOLK7YUH8s7JFWhLKurGYVJCaqUu4CJdXBld3+8=;
        b=JYD88+ekvcKX6ZzRiZFyS6P1KYI+EgxzHKSnW9vEnwUcmWAwWqR5zcf/NvBJJFOyP7
         Qj61NzboFI8A5+zWjrbe+smEblGmbyq9Di2kLH+MDSbJ871JfsVwihOSHh1ZEMKX6HtM
         jeSsQK39atYUQ/VxihLPvYYsgFRG7nW1AbtMy0QGQqjrTM9VhXMnY+BRd3AO9ZLkFDYe
         liXYtLNOxivOp2v5ngaKAoloBaDlR0WfUNXTZUr6rCLFRCR7TI0CviJDisFAIRhDW7EO
         +LAEyOXMOnOlwilCkPJxohl0brFt8PHNL4W8QdAsO4yJ2VqD4r12OhsVQ6PVDfQXS0Qc
         FjFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786009956; x=1786614756;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LIidbOLK7YUH8s7JFWhLKurGYVJCaqUu4CJdXBld3+8=;
        b=q9OkJW2c9xBq7cVKEwZiqrctwA1V2f+EPcCamOK+nD5yFOY38/HBV2HKcK+uUOf5ZW
         0aVAghNzyTxjUTBTtRDuEjFdBXQkM6mQynHR9tu+QVzJ4TMMt225bkmP9bOePRbbPJYv
         E+ji7gHhRWDFlXsAFndWRnDM9y+caJVXOxZrZPojU5d2h7athf0b5NnblbqX1kwW5WWE
         DRRnh2StGPxfXrfVAPEn/RPQYxYgggASHkRnfHo3NTTaAWi2oTZ9dJyCNfw7FNzBwlNd
         Y4JQov9Ppy24Jw0kMfUN4JIgg24fgPQSVrmqiUYitXKPOhG1KGiVnLoMVz1lJYK9InHv
         W77g==
X-Forwarded-Encrypted: i=1; AHgh+RqMWQvImnOk+dClSY41dGQj1v4FLgicc2TXkWjw/w0SldDO5owfyOG7g4SYz0l3GLQJnT/HTR4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNTEt+VwdTynJgrQfkQyZnKBjznmXz64Hqu+g4uUTa0+QKhBz/
	KJjFtAnP30orgMhgRuuIWbZlpXiRz1IK6rAhBQpWtr/OUgXiM8YUqhiiK834GA7zpRRIzDcKB/w
	dUWBHTMLtgM9mQ9dqez8x8NS32xMvgwcZpB7pFWrT2OnGnjbmJJnX+DnUYuw=
X-Gm-Gg: AR+sD11hOzl7xcBtFRmac2//mhA0GLuIamPam3IioF4L82h5Td3WDdaRDJWYhtiNcr9
	BCUWwg/d/kOJGb1VtK2J3XvFdXJ32fE1Pi9keKtHHSknw+T40RMHBVeP/nEtg6IJUUE7LKZHHw2
	n/R78s2g7FxRLm9P+DpBjHe2otb/aErmoJLgcrI1CZVrrF2Rc3B8DIkDgk+3kwAAdmY+Kg42gAc
	OVZmWWim78GjxqryRQ+92U5OAuzbuat5KfMZWpgyRSCaCZ8maUQinDCjEqABZvue9nCLZbaCLC6
	UK+Y3mUruJYiFSYvUpJ4MwmN4U1grEGoVbal9gupNR8Ke8F/UCNNERU8K7pWO+NqoRELRMFMg6X
	bgO+LD5jP3+m/dHw3P/GuWXATlvoU+Xeb9lg=
X-Received: by 2002:a17:90b:264b:b0:380:71eb:4014 with SMTP id 98e67ed59e1d1-3903c5b2c25mr14455544a91.15.1786009956076;
        Thu, 06 Aug 2026 02:52:36 -0700 (PDT)
X-Received: by 2002:a17:90b:264b:b0:380:71eb:4014 with SMTP id 98e67ed59e1d1-3903c5b2c25mr14455492a91.15.1786009955604;
        Thu, 06 Aug 2026 02:52:35 -0700 (PDT)
Received: from [192.168.0.173] ([183.83.142.146])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13fca6482e7sm23033859c88.6.2026.08.06.02.52.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Aug 2026 02:52:35 -0700 (PDT)
Message-ID: <d6207874-630f-445d-8d1d-3a30ba8f41dd@oss.qualcomm.com>
Date: Thu, 6 Aug 2026 15:22:26 +0530
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
 <xusr4efn5dmsvcs2hl5vg3t7ctqbbchnbdx3mx6km5s7s3se23@mzzqs54lp46l>
Content-Language: en-US
From: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
In-Reply-To: <xusr4efn5dmsvcs2hl5vg3t7ctqbbchnbdx3mx6km5s7s3se23@mzzqs54lp46l>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA2MDA3NiBTYWx0ZWRfXy3xvvpiiACFv
 fv1gaiN4ySqXnEbUeGbSpZ+fQd9nFKcXi9FdlL5SdT//KGgTvoHa58U03330JgEtYnTl/FpsCI4
 tZ6nRE2EzAaPwtFiVxn91VIHSHRnxNQ=
X-Authority-Analysis: v=2.4 cv=RPeD2Yi+ c=1 sm=1 tr=0 ts=6a745965 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=eVbXwf39F0J6/s7D6zfB/A==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=e5mUnYsNAAAA:8 a=LxpaqNrMlFw5iMcKExUA:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-GUID: sA4aQnBGhszpuqIRG58aClIlUkaiBoaU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA2MDA3NiBTYWx0ZWRfX44QMppwsSGbx
 BOc3VdWMLAMEHfa6MkMlyz6MQ4rR1Re+Ekceq+bQ9SeKHMbnV4XLe5a+S7Bu4CK0SA4Tup52HSq
 dnw/1UmQtbEPfrLKtXWv6CTPXaKHlk9E7p9E37oIvIyNHOHAytE2TXYVJvTGltyM3dM/b3I9cWV
 I/mNtTCIIQNvmVJ56SjeHCWmBc6k4otGQjpuXGbaTMk8XjQWOG8jhJV8UDC/AxbxGxig6MvHsfe
 /qlcQQdr/zOnrD/iaCslH2nvILA9mwuSTPe65ZOAZrDC3oWHJX9L6eha6+U5jNQDG9NkYrkFMvm
 rJiMnhtZQnG1s93H4QMbpLlusxXjhHiTfyJsgFYqRWMF83uhYlEcFWFW1ATVWKZyLfgVF+CJHxt
 iS9JznM7fvlMdu/Iz/iT9zRRFYmBPZMP775THKnP8lDYLsgrgUBEd7RJO5xnMFRSxHA3B5hOh0K
 oZMl7ChQjDJZcFE9xoQ==
X-Proofpoint-ORIG-GUID: sA4aQnBGhszpuqIRG58aClIlUkaiBoaU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_06,2026-08-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 spamscore=0 priorityscore=1501 impostorscore=0
 adultscore=0 phishscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608060076



On 8/6/2026 2:19 PM, Dmitry Baryshkov wrote:
> On Fri, Jul 31, 2026 at 11:52:16PM +0530, Vikash Garodia wrote:
>> The VPU issues DMA through several SMMU streams, and the hardware does
>> not give every stream the same addressable range. The non-pixel stream
>> is restricted to use 0-600MB of IOVA space, while the pixel stream can
>> address the full range:
>>      +-----------------------------------------------------------+
>>      | non-pixel stream addressable range (600 MB - 3.5 GB)      |
>>      | 0x25800000 - 0xe0000000                                   |
>>      +-----------------------------------------------------------+
>>      | pixel stream addressable range (0 - 3.5 GB)               |
>>      | 0x00000000 - 0xe0000000                                   |
>>      +-----------------------------------------------------------+
>> A single "iommus" property on the video-codec node puts every stream in
>> one IOMMU domain sharing one IOVA allocator, so nothing keeps a
>> non-pixel buffer inside the low 600 MB. Once an allocation lands below
>> that boundary the hardware faults, which shows up as unhandled SMMU page
>> faults and spontaneous reboots:
>> https://gitlab.freedesktop.org/drm/msm/-/work_items/100
>>
>>   
>> +  dma-ranges: true
>> +
>> +  '#address-cells':
>> +    const: 2
>> +
>> +  '#size-cells':
>> +    const: 2
> 
> This would conflict with the 32-bit addressed Venus nodes (and it will
> also break examples). So both should be just 'true'

With "true", i see following comment from sashiko (when ran locally)

Without a const constraint, a device tree could specify #address-cells = 
<1> or a non-empty dma-ranges, and it would silently pass schema 
validation. The DT bindings guidelines also recommend that cell-count 
properties have a const constraint matching the hardware.

> 
>>   
>> +oneOf:
>> +  - required:
>> +      - iommus
>> +  - required:
>> +      - non-pixel
>> +      - pixel
> 
> - #address-cells
> - #size-cells
> - dma-ranges
> 
>> +
>>   additionalProperties: true
>>
>> -- 
>> 2.34.1
>>
> 

