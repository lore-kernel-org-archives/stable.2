Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FF5F381EBA
	for <stable@vger.kernel.org>; Thu,  6 Aug 2026 07:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786003088; cv=none; b=bKp5KreqB3uoE67I3gUzGiiz567fwCJauBAi/Dvzeds3B2ib3gzNRLR1UfB5BNX5gngvQdPbP1fMCwpcpeR6aNA+vUYztCLZqqbOILWcaPV5WoceatDjZTvJ4Bi6mQ1ROlqcDtrcvGeIvns9zfnzu6JQ2aNaZBvYGDa6Gi8B2ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786003088; c=relaxed/simple;
	bh=tI+N0a0wfxMdNBRKZGb2ZGPqHO4OtAB40aOT08pkdww=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ozIKoNtew8/RPkz8mmId0wOiwPNWB+PkDsYJlipPSGEoKaDscZs9sAG0BQE6DMeXXEMYfFqqz6UwN3SQm7kDAw5RMbf9qv5vdZXPoRxSkVPxgk3h+FklQlIMrhSBY1sxThqVHs05Ol9T504cndmxZdOBLf8EX1S3dYIy3kTEa30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ipS8Rkui; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=YbiaunKH; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ipS8Rkui";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="YbiaunKH"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6767MJrq1286936
	for <stable@vger.kernel.org>; Thu, 6 Aug 2026 07:58:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	2ldzWFN9pHQYJUN2j5inoFoN/0RcHqULrphDDtK0FC0=; b=ipS8RkuioOY9xwWH
	4sFrahfgboYEzxphcn8IxtOyCNNIWKj0qjabRUqPp4kn7UJT3wva/aaPUhKk/yVN
	zOVBMz8WY1sUnO7WGG7NUbbc5eQ2JqBguLg5xztTc6iyvLFSmy4QFXEf+yBXXe76
	6is3FjIs4VRZHhAvpsfEjEnzgV6dDPwRFaVDID3L1JhR00/vShaHyGjrTsruZCvi
	V6kXiiMRkqPeDa4A6nAVAJmN9Q+8tusm07afZjpCBgXsoMEBMUm+hEKtg04bmewV
	g0CCo5SOkr8+C32/DeK53Ai8k9lIWj0hV+GRyrxHdvUG5cXNpLkzB4AfDGEDnmga
	rzEdQg==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fvntng4e4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 06 Aug 2026 07:58:06 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-cb74d5db64eso2103929a12.2
        for <stable@vger.kernel.org>; Thu, 06 Aug 2026 00:58:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786003086; x=1786607886; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2ldzWFN9pHQYJUN2j5inoFoN/0RcHqULrphDDtK0FC0=;
        b=YbiaunKHBk6D5cTu9ZcJjZOI5djRxM10Lg6w7iQsNfcPjpFVzJ6PMfwc7+vCpdmF3i
         nKUmwcZChG1EwZXXHEzzfc1lk21NNs7buc3SWGW4YbdNtoWvCTXu018ZkCZ7XXLErdFM
         YrZAHhZzE7Fznk1YTUYP6P55AJLap3JLW/KriqjE0BdTapCuxuZ/o4P00u+NvHq+z8QH
         Wl6DNm76tmWD4oRnNtcMS3PQo2bLj/5EJ2+8H04wwFMpnXhDrxp+zxkjnIYITvxEybCT
         jw45yzw3Vu8hst9WSYpsGsZmIRYPl92J+hvuqUu7+Op7GsrUWAAkttEAnY5qxO/xUzxI
         8zhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786003086; x=1786607886;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2ldzWFN9pHQYJUN2j5inoFoN/0RcHqULrphDDtK0FC0=;
        b=X1OjXRqCQMbQW3GVulRjVp/tKKI7/li1yo1vYG0k4epG+2c4h2/q7sDDhN96DDkJ7c
         CfCh+ELB65irCY8yYXwIpnmXQaPVENKZrmdOf2y4qDjoY7wxU9mNlJ7f8Md2xw8d6Eda
         kzuQ3bAq3xHLBKKs9K1Et/vVNeGZ5i1LL+br9cIVbtuvlvNjktD9WZfemUqPkzXYkEIF
         81ajn81hDEQQc0mviWJTnhjQNbxyXcM1EJtd69cMxgygdBvfusPRrSf3dX9AgcOed2st
         wh/FPZnv4atyJXePxqZbqWCrymbl5H7ZMMx394Id2Un29Um9QPsDKGdIjYbV5uaexSVc
         a3nQ==
X-Forwarded-Encrypted: i=1; AHgh+RpwU1zVk1jU1P1ZpQJgqy2RHlJmHOoowuKOt32b7NgOibcSKOh51Sr2ywtjegl2VqwkDyErX4I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5XYJu6aHyWGKRtMZ666Pz65AxCcAWE7OF1d0w1KqVDlG1P4XT
	EsKjGHHxRBO2eNQrq+v8yBteFJjhnh4SvWoWi1B5Bj3mfs3RQWxl5FXFT0YisS7Md6gIwGKbWJC
	TBxN4qLOzbYQCXYa+1u7hTqkPOfsrXfHKzjwDxxe+WkGgvVm/n0dJdI74WlQ=
X-Gm-Gg: AR+sD13KSkdkwM3ZqdKM9ZNv50n4n/AEtgrNqAWLkLMOyehxW6D2XOoPU4Yn7Un7+rH
	bOjmY5vPg9hCv7yTK0vmVjC04/4xki2Clh60fmjy+HoV2j/0ua2JIewQ0t3qxFeehs8plFWgdEu
	kMJVX2e6LxleBuy6VZF7K3PhaugqDxci8nRKA0VaOVEUgu6gAnQQXUA478DZEXRmz8R8dSLIWDm
	DZq2YPL1zws/OIrWLJKXDPrZmXH+lqHH5c9Ga8wwBmF95OGKJkCa+xG89un4gIxjznc0IsWuzNx
	NMLbfLWG38d+PbVN4x0htseedP3CjTEL66yac4U+s7X8/JUqtYbl3mjnre8pUBY5RvuYueG1p06
	/SLJCB/siVUYguKZkMjsFZienrUw3qXZpNA==
X-Received: by 2002:a05:6a21:687:b0:3cb:7b9d:9869 with SMTP id adf61e73a8af0-3cb85f4a600mr16700021637.35.1786003085830;
        Thu, 06 Aug 2026 00:58:05 -0700 (PDT)
X-Received: by 2002:a05:6a21:687:b0:3cb:7b9d:9869 with SMTP id adf61e73a8af0-3cb85f4a600mr16699976637.35.1786003085420;
        Thu, 06 Aug 2026 00:58:05 -0700 (PDT)
Received: from [192.168.0.173] ([183.83.140.67])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13fca660e66sm21728887c88.8.2026.08.06.00.57.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Aug 2026 00:58:05 -0700 (PDT)
Message-ID: <8130900b-c9f2-4f5a-80f1-1e8567ee1b72@oss.qualcomm.com>
Date: Thu, 6 Aug 2026 13:27:56 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/12] dt-bindings: media: qcom,venus: Add context bank
 subnodes to common schema
To: Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Bryan O'Donoghue <bod@kernel.org>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Stephan Gerhold <stephan.gerhold@linaro.org>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, stable@vger.kernel.org,
        Daniel J Blueman <daniel@quora.org>
References: <20260731-vpu_iommu_iova_handling-v2-0-da52b5228dbd@oss.qualcomm.com>
 <futJwsC0VjGSkjrB5PP9T0jBOVgWADaDAYyRRp-OZifaKPNtjcnnA59QJaQTdqYTeayZk9jY6e1jOfun71Yp5Q==@protonmail.internalid>
 <20260731-vpu_iommu_iova_handling-v2-1-da52b5228dbd@oss.qualcomm.com>
 <689580d1-8169-41cf-a954-927e10135700@kernel.org>
 <d0983bf7-a708-46ff-9f86-f94fb6a92ba7@oss.qualcomm.com>
 <d6ffacaf-7f83-42be-a3cf-40ce00810ca9@linaro.org>
Content-Language: en-US
From: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
In-Reply-To: <d6ffacaf-7f83-42be-a3cf-40ce00810ca9@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA2MDA2MCBTYWx0ZWRfX3UMJdYHO3lZe
 c42SSSyZuwFoOx1A5F+n/t/6MSPlzbkKuaTCB88665x5mzBVxUv2Kw+yS0PLI3X7KLWo/msYnD4
 joC9RkOPrnyUK8lxu3Tfj/mgFcNjKGQ8Qnlp0qCAo94/6EJK3bfm7nMf2nf+aJcOiM/TsuQRiHZ
 DSVBsGPM915BokrYPC6MEN30zzQBAKiZnHH/hz4/xYNCX1JNeaB7OQBoiZtrbOsQOYLMSmpIHiL
 Jt2zPtDnBWbyHFcWJO1Vlfetg/pDm0rL54uk/7H+9jDUGJaKwwV8ReCUY4lp1PTIQ2QpNODLuqg
 iqIEiAScQFJII657+23hxuGNp3CO1LKla2P/hvOW1rLgFAV7gg2wGiNElCgDqcopWhTyyLXH5Sr
 rhzpa1rwhE4fNXKUCDmuVRC1zGl15gc4BdlbO5wgk0hdunOrniRILL7YYoe/4fsrYbnYSkrV9Ab
 mFj9xX0JZhDj7EV/xkg==
X-Proofpoint-ORIG-GUID: 1jph9PFUSRjajeJq0N8clgCHN_CZmN2J
X-Proofpoint-GUID: 1jph9PFUSRjajeJq0N8clgCHN_CZmN2J
X-Authority-Analysis: v=2.4 cv=LpKiDHdc c=1 sm=1 tr=0 ts=6a743e8e cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=kGzeRs6aa4G/VYrSuZk26Q==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=VwQbUJbxAAAA:8 a=t9ty7G3lAAAA:8 a=EUspDBNiAAAA:8 a=KDX8qB4gCLF3aDKb5rsA:9
 a=QEXdDO2ut3YA:10 a=_Vgx9l1VpLgwpw_dHYaR:22 a=CsAS6f0m0zARWR-uHzm3:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA2MDA2MCBTYWx0ZWRfX8CnFRDiQMCTR
 3jH8SUExDtx9qHOe/pE+/yJ2Ml5gfSSekSy1OQ4O7KjvpNoqfx/fGYFhUyhjtmiPiQAzSw43BfN
 Dui5TRh0iZbql6MLtljM47mPmXAX34c=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_06,2026-08-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 adultscore=0 bulkscore=0 spamscore=0
 phishscore=0 priorityscore=1501 malwarescore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608060060


On 8/6/2026 1:24 PM, Bryan O'Donoghue wrote:
> On 06/08/2026 06:21, Vikash Garodia wrote:
>>
>> On 8/1/2026 3:36 PM, Bryan O'Donoghue wrote:
>>> On 31/07/2026 19:22, Vikash Garodia wrote:
>>>> Fixes: 41661853ae8e ("arm64: dts: qcom: sm8550: add iris DT node")
>>>> Cc:stable@vger.kernel.org
>>>> Tested-by: Daniel J Blueman<daniel@quora.org>
>>>> Signed-off-by: Vikash Garodia<vikash.garodia@oss.qualcomm.com>
>>>
>>> What about venus ?
>>
>> Plan is to get the reviews for IRIS3 family SOCs, once we have a go 
>> ahead from binding/DT maintainers, i can either bring in few series 
>> for remaining venus and iris SOC family OR do all of them in one 
>> single series. My preference would be to add in multiple series.
> 
> I still don't see why we can't just set
> 
> minItems: 1 for the memory nodes - implement a fix for stable and then 
> iterate around this new way at leisure.

you can follow the guidance from binding maintainer [1] and continue to 
discuss in the same thread if you have any question.

[1] 
https://lore.kernel.org/linux-media/2b0ea2a2-c3ef-4147-801b-af41733fba7b@kernel.org/

> 
> There is a festering - system resetting bug.
> 
> ---
> bod

