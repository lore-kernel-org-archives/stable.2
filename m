Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68B384756DF
	for <stable@vger.kernel.org>; Fri, 16 Oct 2026 13:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792156960; cv=none; b=Wq3ByXNzVa4Mr/vm/OUOe7RcaJT2pW7b83aTidWogzcOvpjkG+YPWNJVQ36N1hE8qlbCDVD3/fhw/MTZx4Hjb8Gv4hNASoDUZrN3yx7KnpedPpC7CKQxl48uqMbwvBdSaWAQuKwo060hYZ0KhK9P/EmDlWBHoBslASVJ8KBSZ3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792156960; c=relaxed/simple;
	bh=u3NCbjlF65MzYbR+oR2Tct4Ob6r1UTi0DYYNdD9tCKg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YONtYCszhGPKucmHbX6awqwcFVI38f0GGujDq+rp40BoGjoMRfJh1SdpWjqiF050K5QDkuF006Muhqm8D3LA+QaS5t2HqeDZDVmIk5m4SSyhUL6l7UHW/5DnQcvjZkWglzidelWVwhkD6MGjG/1bARKUMZfeBuhFbDznt6MxiHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=m8xAVPq2; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=d+rK/+6p; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="m8xAVPq2";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="d+rK/+6p"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69GAvaEb1504198
	for <stable@vger.kernel.org>; Fri, 16 Oct 2026 13:22:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	WFnblkCZk590L97ihVInQZtbtIXSB+YbRNIrJk5YPFQ=; b=m8xAVPq28s85+rGt
	66bkL94GxtJPu2AO1TQCIUNqtScwBLYGQHBI1z1cekyAjnhrLvGUVYUOBwQ1vmbr
	wVaB3zwHUN0OvxpSaYUY/MLzYVkFK1qnHjrvKvTpTmA8HRS1THBKHxWdvhLZyC3P
	z02XANusJN5Rg/Q5UpgC4yPDl2mzXU7qwLfyn1YGN2BgLjP4KRINTH1BFWsoRuUj
	4OYipnacOdXJRW7XWMla6xyMoJHRX+CZz5e2nAt/0fXHxxfwe15ai195rj4c3Wv3
	TCcdjYP/QJbMsSpwEHwmThg7HcqO0BHBPqHVJm8XxSguQoWZAuEhYrJZWDj7qMYw
	9vWoxA==
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com [209.85.221.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hbjmf8g1c-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 16 Oct 2026 13:22:38 +0000 (GMT)
Received: by mail-vk1-f198.google.com with SMTP id 71dfb90a1353d-5e9b3b44aaeso93981e0c.1
        for <stable@vger.kernel.org>; Fri, 16 Oct 2026 06:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792156957; x=1792761757; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WFnblkCZk590L97ihVInQZtbtIXSB+YbRNIrJk5YPFQ=;
        b=d+rK/+6pOgspWZ+Vs6P0aR0tuLn4ouXWBm6mhl0ke08wyXq4el2hThB8wscW3xgYun
         0vp/qcxvdBV4NevO9FM4zLkMEJtZX/FWYCm/T0BrveYlkbvPiaeIZoZtea/vdFAUQe1b
         a+tHnn9lg0vcv7f54XVFJRSMfx2vsu29oUkrie9nUR+I1f1sHRoRxYqGiIG8xqwNxfoe
         D8P9STeroOg/bJI+L00hl5YZEGxTZRRG/06MAhIjv55VFvB15ut3McTE0VOHueeTXkYj
         ORW+Jl2oo977wj1tYkUbnUs2kTzcvhUPOGEk+IHeAozQHBcob5unhs19CS9l9RBctu1I
         wKhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792156957; x=1792761757;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WFnblkCZk590L97ihVInQZtbtIXSB+YbRNIrJk5YPFQ=;
        b=Z/liM5aIOeUatp73EOEQlxQNxFlaTLKp9U27wY5e9mCun/2WyWkfRBriVXvGb9/WIH
         RbjHfARRUXRbwn67pMjzK6dLv/erjG7ksJ1pNbAwyfdkVpkReAlMR5KGDAShdc3TStIL
         zmk+CcUaOvFmu8Y2D94TtwccDEc0u0RGDTOPv6F9kNoNjSkjyH4KEmcS1h0zU1lIudry
         Z1UX16yeVvV9UZ1l48RNKyiFnEGR6rPIvZAIqweyWH4WUbEZCTbnPMVwkKfURaY1x0n2
         GE0d6RXezRrUl1pSmmS2VKFH4fHi4m0cDe3X4Jxj36a3tvZpSXVW+q9SAeTJ/WaZR205
         Pdpg==
X-Forwarded-Encrypted: i=1; AKwUvBzSX+UdOpMaoHgHoCBTF8ThDcFNZUi89DXBrSx7S/dL6nC/aVyxJfl5hDXaiWoASraiJ6tmDwg=@vger.kernel.org
X-Gm-Message-State: AFq9FYLo6j/z2dPRx6F/ovvFm0oriV9xyyyCarkzFC+6Nc7tM5BIGaqE
	gssZALMfwdd8+ZMHEbYgy4V1hmyjDSFnpDgqgwrZ7wNrnXdzNNQDbPiZ28GWz73qVncwSjDKDCm
	fleR34mExPJuRyjjOV40caKXK3La1e67hcNPtTPGyVGBUtTEEl2oj6Y7GDHs=
X-Gm-Gg: AYBFou0Qg00ziLL7vlHK4t7GpktPL7nR3Yvl91iuMZdR1IRbZKkM4A1SRMuGp2itG8H
	fyH79FMAhP0qElDzcPhutXPKxz196y3iHyJD4cbl9i5mCIegnCJUElP47Pito4Yl4x6VXTTRkAR
	Lgh4iVjwtzZ4zypjAgqnIWTNJQN4cDK/bwzQmY0+YYcIv8fCvojA3zZIUWGadC/IIpt1iPue4oi
	3XsIFp/cy6Y8ZD8zJRddW1gVDRRocQNHB9B3wuSih4BCp4D0ExRzB1K9AOj23ag6x/zm2HKClg4
	m+avxstJj6AHMnnKqEoIGR/hORD4bUHv1KEAWs4YhN7/ePUNmKLdg6R46tFtEEY951kWa0PjcM/
	M+b4jsIa3c1xTx0Oa9867Pw==
X-Received: by 2002:ac5:c001:0:20b0:5e9:4e2b:4c9f with SMTP id 71dfb90a1353d-5e94e2b4d71mr3414855e0c.4.1792156957621;
        Fri, 16 Oct 2026 06:22:37 -0700 (PDT)
X-Received: by 2002:ac5:c001:0:20b0:5e9:4e2b:4c9f with SMTP id 71dfb90a1353d-5e94e2b4d71mr3414831e0c.4.1792156957176;
        Fri, 16 Oct 2026 06:22:37 -0700 (PDT)
Received: from [192.168.226.26] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c4091eb256csm71413666b.78.2026.10.16.06.22.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Oct 2026 06:22:36 -0700 (PDT)
Message-ID: <95d6c0a0-b0ef-4e4b-a8b1-772ac27e9d07@oss.qualcomm.com>
Date: Fri, 16 Oct 2026 15:22:33 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: qrtr: ns: retry service announcements on -EAGAIN
To: Joonhoe Kim <26rote@gmail.com>
Cc: mani@kernel.org, davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
        pabeni@redhat.com, horms@kernel.org, christopher.lew@oss.qualcomm.com,
        deepak.singh@oss.qualcomm.com, pranav.phansalkar@oss.qualcomm.com,
        andersson@kernel.org, linux-arm-msm@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        regressions@lists.linux.dev, stable@vger.kernel.org
References: <20261016124600.31-1-26rote@gmail.com>
 <bbdaabf7-ffdb-433d-91fb-f6ca03b0747c@oss.qualcomm.com>
 <20261016132034.711-1-26rote@gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261016132034.711-1-26rote@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: P1SNH2b8P6x1wUGjhUrXqjAR1Xjock69
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE2MDA1MyBTYWx0ZWRfX7JoSv0N2vo//
 CQWnBzgWzxScRKsTdV/wLXPeEoqsA3Dhh/BHK5YpRt6h+844ByBdWlzFZ4KDCKRO14H34hBYLQG
 43nuXpiVHZ0+axoOxZUujYwMRT+GCY4=
X-Authority-Analysis: v=2.4 cv=SrAFe/O0 c=1 sm=1 tr=0 ts=6ad2251e cx=c_pps
 a=1Os3MKEOqt8YzSjcPV0cFA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=BNqwQ8rykVb9Ldng7p0A:9 a=QEXdDO2ut3YA:10 a=hhpmQAJR8DioWGSBphRh:22
X-Proofpoint-ORIG-GUID: P1SNH2b8P6x1wUGjhUrXqjAR1Xjock69
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE2MDA1MyBTYWx0ZWRfXysAKR9z2+xx3
 xsCLh33BuPOExmeQ0VSc+iklvv3Jtm5VEhC7ncM+Bgn49280IS01EtnjVdJV92DymJi6XX7sukY
 CqpTmeclKj3AJdYL043kb2atYU4lqBwV4AZVIg5cGRhfiOdOMGhT4WVJrJW5N7IKuX8+77iD/iP
 tMcqzCuQXE19FTMffg9K6SY6zc+3Cvo8RG0F3H117tBGyatRtkBM0kIT418ayuZR0j4QAnRAzsR
 NvdXYnwVZAPznOixPVgZ0uX5Bpcoks/8/JWmwibwOND38YUPuOtwH8xwBqVPAQ6m1X9taZHSpDU
 /3IwRCLtcoq96Qoq0T0nWAf8/dab+CZadlE/gXFgdQvPUBaw/Ln5ipMKvatt6ObnX4yWDDGOxZl
 4PRMRB2Acijpi4hFKtjnhceuLQKEaBBPhrIOWM3glBVql2blGBQYPTQFb86iLg0j5GUWjHabhHG
 w7n7+t3/jd57d/rGs6A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-16_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 bulkscore=0 spamscore=0 phishscore=0
 clxscore=1015 malwarescore=0 priorityscore=1501 adultscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610160053

On 10/16/26 3:20 PM, Joonhoe Kim wrote:
> On 10/16/26 3:14 PM, Konrad Dybcio wrote:
>> Please remember about Assisted-by tags if they apply in your case
> 
> It does apply: I used an LLM for the analysis and for writing the
> patch. I left the tag off after "docs: remove Assisted-by references"
> was queued in docs-next, but I can add it back in v2 or note it below
> the "---", whichever you prefer.

OK so we went through with removing that, didn't notice. No worries then!

Konrad
