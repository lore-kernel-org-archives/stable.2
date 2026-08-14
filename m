Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 314C639F18F
	for <stable@vger.kernel.org>; Fri, 14 Aug 2026 09:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786701007; cv=none; b=nUprVhVDAOECQMadj8iJdysJVjIAtChAxw1uFOcyuOFctSgxTdTsNWNI6Mmmf3991JZ0sMqHaTTpi1eu92n2gLt1Yj+c28zttVevyrliSSW/nqS5NDBM94RO+WbAC4LyhvOdDO9cN2tn2bK/Bq7fQ5Fyx+v3LARhZyNIRzOpBeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786701007; c=relaxed/simple;
	bh=bbuQsLL8tNbhWQV7ZzutwSkYT7CQTJBHS2BgGEjkN+c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pmyvlyXwMVISRZ8HpVyL51dGoqz/sNiM6xFWM5BE0CGNQIJQMMwABHZmmrncIzJpbRJ0Yqwl5jMl3fcOsSFMaDtudRha7voW5rUmQyHE/h522BXIToJhTzeJYQLMNKgwoPhv8oUwz20qrmKn4iD4uwa2aBgPnbp+Gr0Tp306KQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XOBIQGjm; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=F6FTqVic; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XOBIQGjm";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="F6FTqVic"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67E9BxYa1224446
	for <stable@vger.kernel.org>; Fri, 14 Aug 2026 09:50:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	bbuQsLL8tNbhWQV7ZzutwSkYT7CQTJBHS2BgGEjkN+c=; b=XOBIQGjm4V9isW3l
	VDkpseqsgGD2+cB+YnNpYmbW4TQ4ODlfHtk2vfDuHPycgr4Aezv76Y1fKN38bIZF
	UywzS4RnJ3A5RTScghTyCICdQIB3zGEmDTpmAWrACd+L/PSDL+SBQd55RE+B/5oO
	OVZVwU78ddrE3UL57ZfftmCFRMjbxkCDGST2CDz8g+N5WH6CdnQhNNTPZb2rZPY+
	7OafYnNF4Q92gavDv8Kl3dZVTZyFpslWSC7Xbvgd5WFo7qHluhk8n7Ln9qv0HgAP
	yrIkTYqsFC3ThGZeKsjMPJ/5AxIrtlWEcsVHNHNmqXv5t2hWaqNiSPjxlTor/ZTA
	EHaY/g==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g206384nw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 14 Aug 2026 09:50:00 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-cbb20f82a0eso589126a12.0
        for <stable@vger.kernel.org>; Fri, 14 Aug 2026 02:50:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786701000; x=1787305800; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=bbuQsLL8tNbhWQV7ZzutwSkYT7CQTJBHS2BgGEjkN+c=;
        b=F6FTqVicCAheKUYaH4Iwd7IU8nlJ4eRS9TL53o/y/BqDtmJmEvFUyhLl1S5NnOvfcG
         NEnf464IBWciP1Gigs/bb79NwVlSViAoYMiJM0GxRPpWKY2N/oaazb9VttgXfftwa6rF
         f+EGV9vAKAemWvwIi1SE4tbfa300qu4T8as1ojfHMr+JHLkHVUehncUDkRfG7rG5wgEp
         vap1whjgLcqFiStecZiL15JilMiMJf6Gl/PqbLkCa8/nsPpOnn3tmUSvwLcDosqajEFf
         ou1HIPfhZSVbStGzRFkUbBbvaQbzdKRn5i7zZegThbA/rVMRtBbiqMVzgUjstHb9yVkW
         xp6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786701000; x=1787305800;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bbuQsLL8tNbhWQV7ZzutwSkYT7CQTJBHS2BgGEjkN+c=;
        b=kKcAtA85rVwczWk1MvKkLAgQqcyDTwTW4WzJrh5bkllUAvcyJag+NYSKmEMKiXpj3E
         q/K7uP563HQmsnwaRQSDfcGYBOm9d98ZYOu20oxWA/m2B+cbn7v1wI+wx9bbdh9yJKwE
         SctNcKom1/H0wabzW9bDhvM7YcK7JagKQfcGjXS0kcTk+CRHsi7dFztrBvQ0gFAnyWAZ
         XicZL9RDWLzSJe2rcuidComGFywUyFWg4rfNyFbQv+B0aninYZw3mRGrOA4+JRtE7qa7
         /JmJpr88ghhZz2snmTknLmNQgrNkRK4ktAy3+M9S0GBw+pqvNDownH0k8kCDejys0XEm
         P6iA==
X-Forwarded-Encrypted: i=1; AHgh+Rrgmmfx0BIoRYEhsU5fe1XrcWzmvMNiV3Hs3VtqRuAyP7aH76Nl91fPBd/8cDbKztDSxPLB+J8=@vger.kernel.org
X-Gm-Message-State: AOJu0YypN1oyjdU+aVORMFoBjWVvN4Q71hChwwIq6o+ghrjZENYW0VLj
	KzpZi8oxNbgvLma3p6O1Vkl+wntdcmVTkYoD5J2hZiAMTqLMtCWF6KSMPaea3s7Mztn+RmSPeM9
	PFAy0Ww376MurkGhCt1rGxJq+ceJbIID1jOEOHu6ANLM8oNjjvaD/2b39s6Y=
X-Gm-Gg: AR+sD12ZabqAgM/fqqvSgXOAVY6Nhwg1feMoS6l7wuH7IXplaA6wRyMiuCWD5Pi+HrS
	fy/k4vdcST0gbxtN08a7YuMLsRJmH9KVZbXqFdKQiMwtAOHJkJAPNCcK8wz0ah0zFhFyWx95L6L
	Kh8gruYI0yr5zNsEIZGyrdi6qAR99Vg05+TAD04AZEn6s+EO8+olr5jfMqTQtA/3e5t2bQkcRAq
	fof5VTc0J7NEnqdxx5EaTWFfWAsaU5pNQmULaNHk5DqTRFB5MdSmAC8AEkR6ethuIA8Vkx9hNK+
	0ZnwJylsU7MmE30pZTNjXB/+SIbyN8RxNiHySKOlyw11pwGj5ePp6gXXspo6uOspOJxl/4okZXZ
	kQ+CvCjQJ7odO8/vipHrrgDrj0IVbdlYF
X-Received: by 2002:a05:6a20:9f93:b0:3bd:3800:7538 with SMTP id adf61e73a8af0-3cc71de3f87mr4852487637.33.1786701000054;
        Fri, 14 Aug 2026 02:50:00 -0700 (PDT)
X-Received: by 2002:a05:6a20:9f93:b0:3bd:3800:7538 with SMTP id adf61e73a8af0-3cc71de3f87mr4852449637.33.1786700999644;
        Fri, 14 Aug 2026 02:49:59 -0700 (PDT)
Received: from [10.206.101.140] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-320d5bd9fd3sm2621667eec.4.2026.08.14.02.49.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Aug 2026 02:49:59 -0700 (PDT)
Message-ID: <e287e538-135a-4eb7-1b21-55b475c844e0@oss.qualcomm.com>
Date: Fri, 14 Aug 2026 15:19:51 +0530
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
From: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
In-Reply-To: <30195e14-0dcb-476d-af0d-f85ee57e2aa5@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE0MDA3NCBTYWx0ZWRfX27x70HrXz8XS
 vJQA+4wVPd3xGhR6xrDE/z2/mfJyZX23Y3UzSZtIwshntPSbRurRmio+gubE2/VeXQAGGkL+C8A
 QVQv0/6RxP5YS7rSTVv9vkcxFb8xZ/g=
X-Authority-Analysis: v=2.4 cv=Z/Hc2nRA c=1 sm=1 tr=0 ts=6a7ee4c9 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=V9F15ByMrN-4acUeBR0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-ORIG-GUID: 7rNZYMM0DWujn4srnkOQPe1LEF264CMa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE0MDA3NCBTYWx0ZWRfXxgCQ5UpInxI4
 atRR8SoiRSIRCIb7OgvLjtXjXvaa8IfTAsLf2ECg26uqJFFxqgZLAE647rhWlq1mFnCEGI7cj2q
 Sg3miM4iEexCLZXbH741nm+/Bb5NQMtfbF4Mgn1iF3jDA1s86n/PVFw0CM3kBpGL/W8MoD8aePv
 SYggxujFqSTOajWfLkTp5DtYPjSaYpZ1hkWqryiUCds8gU1okN77TXaqRC8K6q9v7nc0W+i2fYT
 u7gbwmXmZ12bKpCoZtrwlbQMlJCwk4LAiuJ7BK6edV8QiLOwUrNTIPieqX5mD6j2HtgHVRk3/jR
 yIgGSGp5EPo2du4QI3GdxVj/VIOlaxF+NDQbFOzxhhQuGpFi43YNUjKLhSEU9Rox/d2/urqdo8s
 BJPD9v/D2Hlo2xdkcWaIjbus6gacP0cS55zKAu/37ArS4sBLXE4znAN3ANszL8/kEHwTwMB+WIH
 libzCWb0MDmRmTzHgYg==
X-Proofpoint-GUID: 7rNZYMM0DWujn4srnkOQPe1LEF264CMa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-14_03,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 priorityscore=1501 adultscore=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 clxscore=1015 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608140074


On 8/14/2026 12:01 PM, Krzysztof Kozlowski wrote:
> On 14/08/2026 07:29, Vishnu Reddy wrote:
>> On 8/13/2026 2:49 PM, Krzysztof Kozlowski wrote:
>>> On Sat, Aug 01, 2026 at 01:07:28PM +0530, Vishnu Reddy wrote:
>>>> While testing with some higher resolution clips, the venus hardware
>>>> triggers a fault due to wrong input data being received. Corruption
>>>> was also observed in the captured output when the client dumped it
>>>> to a file.
>>>>
>>>> On debugging, this was traced to the venus node not declaring
>>>> dma-coherent. As a result, DMA buffers shared between the CPU and the
>>>> venus video hardware/controller are not guaranteed to be I/O coherent:
>>>> CPU writes to an input buffer can remain in CPU caches without being
>>>> visible to the video hardware when it reads the same buffer, so the
>>>> hardware receives input data that does not match what the CPU wrote.
>>>> Likewise, on the capture path, data written by the video hardware to
>>>> the output buffer may not be visible to the CPU, so the client reads
>>>> stale or partial data, resulting in corruption.
>>>>
>>>> Add the dma-coherent property to the venus node so that DMA buffers
>>>> shared between the CPU and the video hardware and controller remain
>>>> coherent.
>>>>
>>>> Fixes: 37613aee2179 ("arm64: dts: qcom: sc7280: Add venus DT node")
>>> Really does not look like a fix. How skipping a cache sync can fix
>>> anything exactly?
>> dma-coherent tells the kernel that this device DMA path is hardware-coherent,
>> so the SMMU maps its buffers as cacheable. That attribute is what causes the
>> coherent interconnect to snoop CPU cache lines on every VPU transaction, so
>> hardware keeps CPU caches and VPU-visible memory in sync — which is why the
>> dma-coherent property lets us skip the unnecessary cache clean/invalidate.
> You just repeated what I wrote. What for?
>
>> If a device doesn't support I/O coherence, its buffers would instead be mapped
>> non-cacheable, no snooping would occur, and the driver would need explicit
>> dma_sync_*() calls at each transition. Venus on SC7280 does support I/O
>> coherence, so dma-coherent describes that existing hardware capability to
>> the DMA subsystem.
> How does this anyhow explain your commit msg? Are you saying driver is
> buggy that it misses sync calls?

No, driver is not buggy here. dma-coherent flag is missed in the dt node.

> Best regards,
> Krzysztof
>
