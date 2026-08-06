Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B38E841A92C
	for <stable@vger.kernel.org>; Thu,  6 Aug 2026 10:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786010920; cv=none; b=p0jQ2yS7L4irtiMQjwf9Fkr9ycQ1VzrJE7H6YPtVwDqsS4Dfm3ut+B/s71jPiAMqJYNnp4KyybrYpUpRPfVXlVWVkmdLBtnzdLngVaeVir13yL6NBgWD72wxFQFHmI0ZESA+H8YGdNAgN2mI5DhErPDQlVt2Bkx5KTfocF6yBYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786010920; c=relaxed/simple;
	bh=xCxUMghW2Xyi8faCH5QpwDEU1W4G+MMm2rfwWySl39Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aEJ33jAJhSpz0smh+qT5Ka16lFunyq4F0HimAWQo3wr/2+uhvwrKX8avHGNmsi0NcwJp1evcJozi/RrM/tVz2Jio+mzSFaFTFMiuOQioEauFMbM+BravvvsJ4bMHtcWHwip/voW5wMhpwcPEOy0n8MYRx6O+oOfCCooXvVZlx74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Uw0BfDb3; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=iq2jFpH/; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Uw0BfDb3";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="iq2jFpH/"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6769nteu1626143
	for <stable@vger.kernel.org>; Thu, 6 Aug 2026 10:08:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	iyOUQx3uVZC2rm7J8gJxSev+lJA8+WSrUOAuZsrWWxg=; b=Uw0BfDb3WPVliKgP
	JCWmPWixkfJdB0Ste3TtPH0VXlkVC41xuBL49//2EweTIOuqqEahmsE0FH+XIzjm
	+LTB7/wQxHv286yx/L6TwXq1Xg7PP7xqlMPt4kKSCHDdLmqhjgeKqElzLogUiTdG
	lztSsFVqQBSMQ5bng9x54SgDeg44CIcPPF7sgBnmBdiWg0dbhh7ZLXJakC7JJyUb
	FYPJ6C2EmyJ5dGPc7Z1x4xi6hT+k0JwVK6KbmXPNgHHy+38Z/njaot4+kLm30IF0
	Ru4HK4kBhpAeKQmc7ZbzvLMh7b5JfSjDyzK+gBOLDJ/q67WkG/sNK3rIeHAH75nM
	NgnDJw==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fvntngp9p-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 06 Aug 2026 10:08:30 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-38e667368f0so3340574a91.2
        for <stable@vger.kernel.org>; Thu, 06 Aug 2026 03:08:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786010909; x=1786615709; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iyOUQx3uVZC2rm7J8gJxSev+lJA8+WSrUOAuZsrWWxg=;
        b=iq2jFpH/HW6WmIn8igySZCc6RaSS6Ofivxv9kxoqzI+Ad+SArYeOHCOBgaTRdJbPFw
         Q1rqNc4R+UzR/5lirWBn1f5syHq38YhdCXl2aibAZw68QVXxI7U+a1/Iy4jcGFLexSk1
         rN3ts2Q1yoAqbicq6S5Gujz34UCkD47g+08N5lKSKxrOBPOmKd8nTw+W57STStDuUlCJ
         R/omUjhgnom3euZ/9NJF78dd9gQghds2v1R90kciKoCBi4+Z+OShUFcznCuKLh0NEuCo
         HXGDG8e13uXM9k7eFCU3gBnHolofFEKQsFQRt4QxzR0kQBktqQdji3IGpLl8g4slwO6n
         LxUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786010909; x=1786615709;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iyOUQx3uVZC2rm7J8gJxSev+lJA8+WSrUOAuZsrWWxg=;
        b=UyYqIHou0WG72224sNIhkT+2sd5jbFDqXLZR6tqeYSCXBQ8AtrgXokjSRWOOwBp1mG
         ne6qIPWxQF+DTZtp5y3Ub+A+FdrHmXWQYWkrvo9WrpAJ0dT7DCNM/cRKlhSgUWOA1q1N
         FplN6bNeChhNn/0VZGFFc+UUyYvE8RyNfg/wPnxnf91C+oa7HQh/JX2mmRFz2G66RLVa
         QYQ6Ei72+dUSO07OkdFjRFqy0xulPMB+Vh0BE24M+C2M/2rUojcRDg4FGG2spBU5gZfp
         VAtubvkZJw2ldzzxd9ENs0RQvmrMKZ9wVQrwgHmDOu6BIvrbCyJiv2D6JUqXc3Q76DF3
         HMXQ==
X-Forwarded-Encrypted: i=1; AHgh+RpEPsWbmi0c9yRzbofyjZFKmRDIKtw8IO5tgID3qon9hyeO3cv8TEtgv6TtTpFZAOpgArgEjJ8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxaV4ERKnucr4A1P6NDIECqDoq4KCaCfwOxvdSuM+38LC4IIheV
	y8DPI7J4d2kLskNLSjn3U04ENM6zheKoAdRLzsahdCCvqLVgg9SAJCNbmOiCAVR3C6+AK66acXa
	M6GvaZJ31eJOYiF87g3vybjisVtn52hxbXcAwxvzTW4TIhBTkO4KSwd3fhtM=
X-Gm-Gg: AR+sD13i7FCGZOBk1M8DZOyzgI3Vyu64Zfjdii66IBuYpfOHdzPCipumNrR3r/rvVgk
	mLPhqGTlJSF2CdJz39yQ9M0/7ZpYlfSvpbA1x6KdWWrCDj96Fna9fiSVrL135bhhR8jQMfg+aYH
	+OZ6HMnMHF/HN9pGQsSSJTQ7DJ1tBLJvjQslFqQDmk2DfOHfLwyF2zQfQfdZMSjFhJMcXi9K9ew
	iaFHPuNRv5vXvY7O2GXPMn4o/IiI9p73cz4S/Sf2ykXTaGMUuLhhuDfoiRL8mp/som+XpAEF3W8
	dbJS4qS17k8uTTsqZwtiWNVwcwGCIDffUSU9UG+BauWhF0KYh6MqYswkvUMDp1c7O9aVQZ5QX3/
	3shEzsW4QamHnMXxkP/uGnjRSoxANaxbtxmQ=
X-Received: by 2002:a17:90b:5203:b0:37d:f206:a2ac with SMTP id 98e67ed59e1d1-3903c598ce5mr14953587a91.7.1786010909504;
        Thu, 06 Aug 2026 03:08:29 -0700 (PDT)
X-Received: by 2002:a17:90b:5203:b0:37d:f206:a2ac with SMTP id 98e67ed59e1d1-3903c598ce5mr14953531a91.7.1786010909098;
        Thu, 06 Aug 2026 03:08:29 -0700 (PDT)
Received: from [192.168.0.173] ([183.83.142.146])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-315863b761asm38533481eec.1.2026.08.06.03.08.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Aug 2026 03:08:28 -0700 (PDT)
Message-ID: <36b53e0d-82e2-4fbb-a2b6-3fd7b9c98663@oss.qualcomm.com>
Date: Thu, 6 Aug 2026 15:38:20 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/12] media: iris: Add helper to create a context bank
 device
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
        stable@vger.kernel.org, Vishnu Reddy <busanna.reddy@oss.qualcomm.com>,
        Daniel J Blueman <daniel@quora.org>
References: <20260731-vpu_iommu_iova_handling-v2-0-da52b5228dbd@oss.qualcomm.com>
 <20260731-vpu_iommu_iova_handling-v2-4-da52b5228dbd@oss.qualcomm.com>
 <o6s5kezlsbe6z53jbsezeixp2wfrmwmvwda67t6chf57jnbm3x@ta5hktzs7mdf>
Content-Language: en-US
From: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
In-Reply-To: <o6s5kezlsbe6z53jbsezeixp2wfrmwmvwda67t6chf57jnbm3x@ta5hktzs7mdf>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA2MDA3OSBTYWx0ZWRfX32vqnsnx1HnM
 /xeitmhboUc1XvmwcGmF6ZPqBjeVeA2HBihkFoDd6C2c2RgG65olhCj1YPbNg9WWb+1//ESZuao
 3VpUUmYcWmDd7qdOP1LIaKWE6/8Zol0mmYc5QiZ/tnTxy/gPSktIXtaZNn9S9m/EZHn0gQPFjpw
 GV7d5VMUhUSUgyXyGoWvLsJtMoWYj2Q5oNwGiFSMORKbv/PToKABib9LwRyLcSuQKJh5tEZ7oUM
 Oqvsja/pAeVhzH7sI+V1aiIcFL14uzTllmpwZtZ9ZgvdB9BCyY6WXhUhdxqti9wDcgvi+Tm/p4b
 3TPqjmqzKiug/gTG1KDiTnyAwjwQqkU1RPtrWCYfQwLUYDxWDPfOCSChMz1EZshBmJS1l6i801X
 0a7qjc2qNUgBn9Vl7pXoA9An6dNTujlRoggLxBVgu8jA1E0CUweEg8swHj8Sq1hUFUvQXiiGcHs
 DY7H9nGfgy70sQDK7MA==
X-Proofpoint-ORIG-GUID: ynOHiOKmQPg-82a4jHk9hZzibxEb4q3I
X-Proofpoint-GUID: ynOHiOKmQPg-82a4jHk9hZzibxEb4q3I
X-Authority-Analysis: v=2.4 cv=LpKiDHdc c=1 sm=1 tr=0 ts=6a745d1e cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=eVbXwf39F0J6/s7D6zfB/A==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=t9ty7G3lAAAA:8 a=4qxhn-3g-SBwpGBp1HsA:9
 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22 a=CsAS6f0m0zARWR-uHzm3:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA2MDA3OSBTYWx0ZWRfX8dQPMhBWVx5h
 uWi2sw8/wsAOeayy1MDjGATiJPPStBtfvU86Q+GrwYFr67EZf3SaE9bShOzD7s/9BSIC3/LbHaV
 9POuTEZyPLgxfLYaXyO4SarZ9oiK26I=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_06,2026-08-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 adultscore=0 bulkscore=0 spamscore=0
 phishscore=0 priorityscore=1501 malwarescore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608060079



On 8/6/2026 2:27 PM, Dmitry Baryshkov wrote:
> On Fri, Jul 31, 2026 at 11:52:19PM +0530, Vikash Garodia wrote:
>> The VPU issues DMA through several SMMU streams, and the hardware does
>> not give every stream the same addressable range. The non-pixel stream
>> is restricted to use 0-600MB of IOVA space, while the pixel stream can
>> address the full range. A stream can only be confined to its range if it
>> has an IOMMU domain of its own, and the IOMMU core attaches a domain per
>> struct device, so each stream needs its own device.
>> Add iris_create_cb_dev(), which looks up a named child of the iris node
>> and registers it as a platform device parented to the iris core. The
>> child's fwnode is handed to platform_device_register_full() so the OF
>> core applies that subnode's "iommus" property and the new device gets
>> its own IOMMU domain. The DMA mask comes from platform data, and the
>> segment size and boundary are capped at 32 bits to match the addressing
>> the VPU performs.
>> Return NULL when the named child is absent, so callers can treat a
>> device tree without context bank subnodes as a supported configuration
>> rather than an error.
>> Backports are intended since the first DTS of 8550 binding schema.
> 
> What does this mean in the commit message?
> 
>>
>> Fixes: 41661853ae8e ("arm64: dts: qcom: sm8550: add iris DT node")
> 
> How can driver fix the DT?
> 

The idea is to backport the driver fixes till the kernels when the first 
DTS landed. Ideally the fixes tags the commit which introduced the bug, 
while in this case, was thinking to keep it for DTS.

>> Cc: stable@vger.kernel.org
>> Co-developed-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
>> Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
>> Tested-by: Daniel J Blueman <daniel@quora.org>
>> Signed-off-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
>> ---
>>   drivers/media/platform/qcom/iris/iris_resources.c | 28 +++++++++++++++++++++++
>>   drivers/media/platform/qcom/iris/iris_resources.h |  1 +
>>   2 files changed, 29 insertions(+)
>>
> 

