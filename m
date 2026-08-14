Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0DFD41D200
	for <stable@vger.kernel.org>; Fri, 14 Aug 2026 10:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786703115; cv=none; b=PlaBzMpfDWcA7wu4SXIVsbHmehrMvXFJ/o+UNYjQZqTrVPZV2tRBbozNfHszqk5g7pt+WQw74Ixoc5Y9kiWkykjN+TSfXNqAqoRLY3FJY1ILLEr5iExdNjUa1CHpauJsKaedfO0nh1P6uqo7nYsZ7qk/6GqeGlmwiz4tXFUrOzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786703115; c=relaxed/simple;
	bh=kVtqC5vjqVMxDhomAfCYddXbUgXY2gPiwPy5iyBGIfQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DxGAq1jxXGUN0T9iUQbGAnrDD5DSi5jRnWKy02L1Kxu2vDtoJw0h4AKLFsw2pRN7dZMEm1tGVb1zp0bZhDQvm4YCOLzwr0EDZQN7PkG4Bg78dTDRJhjc/7W0UEv56fwL7w1aWkf4ybSyG2hgse34JiZyLyIkncFjA5f4QNhMkHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FZkfNNOD; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=jmrl12PN; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FZkfNNOD";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jmrl12PN"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67E7giC91412152
	for <stable@vger.kernel.org>; Fri, 14 Aug 2026 10:25:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	kVtqC5vjqVMxDhomAfCYddXbUgXY2gPiwPy5iyBGIfQ=; b=FZkfNNODPdU/uhdf
	PXbCOQB4Y6xM2Iq7seSPco/DlOqzmDMf9vG1gc26c7kf2YZFOw3zKlPt7R3pkn6C
	C3qZFlnKLo+oUQ9Pyl5BocMf6FdDB7KhlSjqx4GgUX9l5MFXbUO2qWUZs5juWUSP
	fuwdN5hWpzDe3bnEUMK3VLoMmRnnA+RP9xRx4F/Rjmq6Vx/bjwTHqazTTNtfKBdo
	u6I4XH5lTlzQKktSTeKmJQLQ+eFDVZcamHFHvyijqT1p/zA+2OC+I2VEvBMzsyA6
	yJFM3SWP1hIKkAHrALpmswu95V33Ax5DMqxcXVB1rNtHiK5HWo86WQaORPhm17jz
	x72R/A==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g1pea2e4d-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 14 Aug 2026 10:25:02 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-cb5cc1e139bso604472a12.3
        for <stable@vger.kernel.org>; Fri, 14 Aug 2026 03:25:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786703102; x=1787307902; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=kVtqC5vjqVMxDhomAfCYddXbUgXY2gPiwPy5iyBGIfQ=;
        b=jmrl12PNoXmfNfktykMPozAaBavghhfEJ+xcmdAItaJlH2zaTaNlbQ9sti7RWlou8Y
         Ho82Mtx1+DJ/roaCm4sTfZl8gxGmqIfXmy2KsmmbijiFbBjroU223k1NIba9dKJpRGiv
         IzPr0YZJ74Tkx+TfVKrOEXj6Hxqsh5wj8/JB4Pgoyo7qTo/ubj5CsRqNpFeQ2InSVS7v
         EK52G6e/gp7d05VgrgYL6v+c/Xgkse03RBbi1vEHrukJmjJ+Fg7uqb0FFejxruiU0sD0
         +3YXVeeHm/XaQCLdOTYoOluf4N81nLq0Mwp2Mp5wtNVyTO5dwcAHS1tfnmwbXog9q7ba
         9IBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786703102; x=1787307902;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kVtqC5vjqVMxDhomAfCYddXbUgXY2gPiwPy5iyBGIfQ=;
        b=rUFUKHeXgdAdp4kEMlzs0XA/7TE5xyJ3wGrJpVnBCVPIK3ADlLjd+F5TMwNsAjTyNm
         lKzubdL/g/XSQB7EQz7CR+IZY8X4Iu9V3WEWIJRrFzYgSueK28Vbt/pVmX/8h3poY4AV
         DTqkiKg+raoT3iolrT1UbfpSuxalZY4qb7w+r78V0NYQlMDykboEdQJsZp72D+VHjECb
         Rg3ssEMIqXUdxJFBBP3132lsIERen1ofuItNv7oscAlsn9XF/g3Zz3dlOlg5qBVchnXS
         qskAimqhIBDd/vIjrT/Z34pQjV2VM2JSz6fXDcwCiZJizr0Lg7fC+vgopAiTdc5kJgat
         IB1Q==
X-Forwarded-Encrypted: i=1; AHgh+RrKsW/7gZ6qbxFEPRCPEMj474gP/ScsyQ+MEV/VYAtrX+xYn0Fj2r3OHLXgWIMCijnIsZHfcak=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSj0Pz7qeoA+smOaGHs2e/12V6SAFCKl/EVu2opOFG5XcKYNzI
	IrxY4wPVvxsuNnBD0VH+SrHqbtS9RDR6Hi6pgehU4+gFzIaFrSBx6FZaQp9rr4AmiuATmFGr+s5
	VnDrw7EVfZM82SMyWA6Vw6pvzkGIiRjp0gTIJOYkGtE3dPcnX13u6u1/8xWo=
X-Gm-Gg: AR+sD10TLMklXSgZF+GUy7XRGi9AyxCnnauBy4SzH/fQQCtpQoTA0uvOK0JKAtDCl+s
	aHBgxVx2V5zvA61lRKvm6Q2/cRj85tKrJffW8CNzpmStyT772QwV+g8qIHFifxajdbI8WYu0Fps
	e+jyT5B9WRnhgkzxR2VQOHID7pu0+P7n4ZHT8dB+GnBmFOLzNJvSHoTbsBlVdBLmg2SrmzcO3Et
	CSc+mir+TMWINVHhg7DInvFTfxZ2kG43JrOuzHbZM2V+LHoy0yiKThR++1pYHHl+T5bhOEcgeOe
	tqfttPkRsK08dU23a5gs6D0hzL4q56pFzg/MgU2U2lrIy6ahJYj56ZLe7mhN/5T9aBfaXhVci49
	dYRnACSTxvgL6E95ZyqSjyYLSC2n3jlLm
X-Received: by 2002:a05:6a20:6f04:b0:3bf:6e72:68f9 with SMTP id adf61e73a8af0-3cc720e1af9mr5407856637.38.1786703101998;
        Fri, 14 Aug 2026 03:25:01 -0700 (PDT)
X-Received: by 2002:a05:6a20:6f04:b0:3bf:6e72:68f9 with SMTP id adf61e73a8af0-3cc720e1af9mr5407807637.38.1786703101528;
        Fri, 14 Aug 2026 03:25:01 -0700 (PDT)
Received: from [10.206.101.140] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-320d61e1568sm3161720eec.11.2026.08.14.03.24.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Aug 2026 03:25:01 -0700 (PDT)
Message-ID: <c03354d1-843c-af24-0e7b-a4c0cfb8e001@oss.qualcomm.com>
Date: Fri, 14 Aug 2026 15:54:52 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 2/4] arm64: dts: qcom: sc7280: Add dma-coherent property
 into venus node
Content-Language: en-US
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Bryan O'Donoghue <bod@kernel.org>,
        Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Mansur Alisha Shaik <mansur@codeaurora.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Hans Verkuil <hverkuil@kernel.org>,
        Stefan Schmidt <stefan.schmidt@linaro.org>,
        Hans Verkuil <hverkuil+cisco@kernel.org>, linux-media@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260801-iris-fixes-dma-pseq-fint-v1-0-aba0cb22f6ab@oss.qualcomm.com>
 <20260801-iris-fixes-dma-pseq-fint-v1-2-aba0cb22f6ab@oss.qualcomm.com>
 <20260813-frisky-augmented-crow-fd5d3d@quoll>
 <4b34e718-0878-25cc-a5bd-0d8858df5133@oss.qualcomm.com>
 <30195e14-0dcb-476d-af0d-f85ee57e2aa5@kernel.org>
 <e287e538-135a-4eb7-1b21-55b475c844e0@oss.qualcomm.com>
 <26a880b2-5f37-43be-ae8b-2c0c27c777a1@kernel.org>
From: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
In-Reply-To: <26a880b2-5f37-43be-ae8b-2c0c27c777a1@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=TbGmcxQh c=1 sm=1 tr=0 ts=6a7eecff cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=mqT1Idva8bgf30cmp0IA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-GUID: xp6Ok1egjKUeiMG-DFBgKsURUWEmrtKu
X-Proofpoint-ORIG-GUID: xp6Ok1egjKUeiMG-DFBgKsURUWEmrtKu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE0MDA3OCBTYWx0ZWRfX/rFtf9HatjcZ
 zE7ISyySdZzbI/5bz9uTxtOU8fqz299Wj4xi5qEaMoNQxT7dblynOAabnkub7xO0hg8CB3n3pCs
 TfurtqyeOMVQQMIvpmP0/GHcKMQWMn/dmVSACstY7WWJf6rMxlVmPsJKDH5PKpV7tfGTxDxF//c
 KRaNwvff+LWBYhUy8vejERfZCCftcIIqbE8Z31zJ9XH1PDakJUiHYepo1UVY2olKeoogTBX9gsS
 /enlFVwec75QBKjAR3KKDytGXIr33lU/VaDEhQHObdXxYd7Lf4//2olFU1jvyEQJVSUvUUv1VeF
 syiG7vG5BM8UXhaQh1GWDizmqh0k9gY7AkCWc4CWaKQdYznzQhCncRMXcosm7oo8qgwFgowvumy
 jtFT7jDrXfbCoGW3mSKt54uA/H1FTPBwoQQgXA+XRPKfmuB1lxoz9w3sLBeVkt7rwLlcLKLJ2ht
 4XSVEjdGkLbbSm1AIgQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE0MDA3OCBTYWx0ZWRfX/1C5edQL+vc4
 1TyzxCyD5Q6iB0m1x/CbHcC/fn+k0Eid5D4/Xejr69UqwqAtNJ05av9vM5PgNqOgCWBWVOm8tiy
 EryBqppAVVmJKZgLKuoYttABs4kwLpo=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-14_03,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 malwarescore=0 priorityscore=1501 bulkscore=0
 adultscore=0 suspectscore=0 impostorscore=0 lowpriorityscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608140078


On 8/14/2026 3:26 PM, Krzysztof Kozlowski wrote:
> On 14/08/2026 11:49, Vishnu Reddy wrote:
>> On 8/14/2026 12:01 PM, Krzysztof Kozlowski wrote:
>>> On 14/08/2026 07:29, Vishnu Reddy wrote:
>>>> On 8/13/2026 2:49 PM, Krzysztof Kozlowski wrote:
>>>>> On Sat, Aug 01, 2026 at 01:07:28PM +0530, Vishnu Reddy wrote:
>>>>>> While testing with some higher resolution clips, the venus hardware
>>>>>> triggers a fault due to wrong input data being received. Corruption
>>>>>> was also observed in the captured output when the client dumped it
>>>>>> to a file.
>>>>>>
>>>>>> On debugging, this was traced to the venus node not declaring
>>>>>> dma-coherent. As a result, DMA buffers shared between the CPU and the
>>>>>> venus video hardware/controller are not guaranteed to be I/O coherent:
>>>>>> CPU writes to an input buffer can remain in CPU caches without being
>>>>>> visible to the video hardware when it reads the same buffer, so the
>>>>>> hardware receives input data that does not match what the CPU wrote.
>>>>>> Likewise, on the capture path, data written by the video hardware to
>>>>>> the output buffer may not be visible to the CPU, so the client reads
>>>>>> stale or partial data, resulting in corruption.
>>>>>>
>>>>>> Add the dma-coherent property to the venus node so that DMA buffers
>>>>>> shared between the CPU and the video hardware and controller remain
>>>>>> coherent.
>>>>>>
>>>>>> Fixes: 37613aee2179 ("arm64: dts: qcom: sc7280: Add venus DT node")
>>>>> Really does not look like a fix. How skipping a cache sync can fix
>>>>> anything exactly?
>>>> dma-coherent tells the kernel that this device DMA path is hardware-coherent,
>>>> so the SMMU maps its buffers as cacheable. That attribute is what causes the
>>>> coherent interconnect to snoop CPU cache lines on every VPU transaction, so
>>>> hardware keeps CPU caches and VPU-visible memory in sync — which is why the
>>>> dma-coherent property lets us skip the unnecessary cache clean/invalidate.
>>> You just repeated what I wrote. What for?
>>>
>>>> If a device doesn't support I/O coherence, its buffers would instead be mapped
>>>> non-cacheable, no snooping would occur, and the driver would need explicit
>>>> dma_sync_*() calls at each transition. Venus on SC7280 does support I/O
>>>> coherence, so dma-coherent describes that existing hardware capability to
>>>> the DMA subsystem.
>>> How does this anyhow explain your commit msg? Are you saying driver is
>>> buggy that it misses sync calls?
>> No, driver is not buggy here. dma-coherent flag is missed in the dt node.
> Again, no... or explain why. Missing dma-coherent is not a fix, but
> rather optimisation, but you claimed it is a fix. Explain why.

Is the dma-coherent flag only for skipping cache sync?
I might be repeating here — it enables the hardware level snoop between CPU
caches and DMA memory. Without dma-coherent, the CPU cache and the memory
which VPU accesses aren't in sync at the hardware level, which is what
caused the corruption. So dma-coherent is the proper fix here, and that's
why I've mentioned it as a fix. Do you have any opinion on how you'd prefer
to handle this? Please share.

> Best regards,
> Krzysztof
>
