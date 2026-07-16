Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC01A3F4DF0
	for <stable@vger.kernel.org>; Thu, 16 Jul 2026 09:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784194970; cv=none; b=S2S5kFBXredJIg2FlqK6eDRzgvxR8Qy3gB9PD4be7JQBDMFXtznDoXNtZRek//JdlNOCYOlAXF5M5BscEg54bTwJI6KBBcLTTzAqd0eTnkM2aXjoV0YdGTdgmF0Je2Qv+6i9T503MLLcVjky0KJsTapRMvF/orYvd5oRweMCwUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784194970; c=relaxed/simple;
	bh=5HkbT5VTjQEbCphRnfj+qtVR3I6tfp3ysrSh9PXdd8g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E5F1mXI9PgO8T8uZOijdm2qsOP3QIrZYEGpofJuLwKbY1wXknrelOHo8m13MM31HAjBVi83t4RLMPj5arCvou2Mgi3/WY1HaRy9nkWeuVxrqt1iool+Vsjo9BtULWbJ9H1/xswMH5svYNCXKTXM86z6WWjTCATAQDSyWnm/Nqfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HaDXCFgl; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=A0zmti2J; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HaDXCFgl";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="A0zmti2J"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66G7XQFI2176012
	for <stable@vger.kernel.org>; Thu, 16 Jul 2026 09:42:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	HzsM35EiZJ/yzPPIs0XjKw5tRsijyewrzXg6CrcCnPo=; b=HaDXCFglMZs0ti8S
	pzu3gBUeeawMCDZsYTLiTxpDkYKE9KNf+CRRt9U1jbC8Fb/hQYixA8KGO7puSrsS
	7ljMkbD2umyqmI97nEHvFoMZZ4wdLNRNQ0DtSqg/lZWVq8TYBp0FweIWkAmeCSNC
	tjLLDpCvEKHKaCfNFRSlStd/xTDo0kfdu9B+TGGSCq1/tNXthCMFKlIziL22xBHs
	quYjWGBaIyx9hqWsE6lJq+2lAv8P86Y81cojjd1XLeG2U0XqOUBDtgZ6PuXOeRpD
	b766iclZDEZkSd6cjegBOWvS/Pv+AIbD7X41mO+NV+elMXqkA6iyNGXDTWXDqvar
	C9OlzA==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4feu108fsg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 16 Jul 2026 09:42:47 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-92e5110c89eso151673885a.3
        for <stable@vger.kernel.org>; Thu, 16 Jul 2026 02:42:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784194967; x=1784799767; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HzsM35EiZJ/yzPPIs0XjKw5tRsijyewrzXg6CrcCnPo=;
        b=A0zmti2JyXzjpZJrRI0Mdi8wgEY8sSiYr194tLhs/4AnzMfcqsYB5DtVWlgac6gHd2
         G+SrxXlvj7rNXLBVtd7D2SRjm9S4onV68K9cDIYn7L44sRC91lBTTtco/I/ATZeuxlco
         oXzc/qjJzWUGHiPT/ULq9/KszfdeXJ/eoAG5/YbUguHNEAzkV+vWUnpm08ZjV87wv28X
         DRHqF29ddP4Al5qcZktXwXv0WcMAkzizftNHDcB1jRk1dYao6ohxBOGcuJWKuGuMX5jR
         e2pXeRkTAMmkWUipPYO7qhl6bbBbiKjZX+lh5lwLIE8fzJXRI3xCz3TX1g4KJIsmEriJ
         yQTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784194967; x=1784799767;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HzsM35EiZJ/yzPPIs0XjKw5tRsijyewrzXg6CrcCnPo=;
        b=MPiT58UKtCnwXfsYxM/gfA6q3fJY2tS0ou7hMr+b8lT3XQz4y3OpnrqFqA8cXFLetp
         v+tVuQrx+yXL197qLFr2Mfxt5vMcrIRLSZZQK/etx3ZwMMPV7N4CR7AvFoc9SswmSfr/
         6K9gGv7eAHIJTFtuLvbSHpw79HOL494I6Yjx1ntlwSQfeyKLv4BqRHZfTIa3gIKSSNRL
         LndJEe/gh+Tnvix5LFbA7CycqGS4zhxtYBOdbDAcrBwAKetZmVqDEFw5FdvTgmmanhqZ
         l26W9MFZjUFAqWCms37On89rQ+5bFeuyPqe5+XDJlH6MBvpF/xANlJWSBNbYB5IC2pgA
         9pyw==
X-Forwarded-Encrypted: i=1; AHgh+Rr870dw15XD5J02/isyhEJ5cSN7YpHxi5SehYXaOSWf20KB4dtvTp8OQHSLylNTz5kZJHp4HPM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwT2XtL8/1379/mZecOEKAOpPYqFzCA/ZCYUNIjmz7rmmA0DJ0i
	T86TfVp3ICF3m6mt6+zK8hqelaXPzcg4ezcaJVrDP3ZEsFizPtozfNpFevbmXX8craWmxdQN6bK
	aWPjvTJuJ9rp/CogTRzfp3fTQc33qyP+aDz2+ni5KP8PBU8k3VevGbgVRi8U=
X-Gm-Gg: AfdE7cndB4gSn4brdxL1lpNaSiFe1h59AqwxTeOsITAnWZx5fTTPPHFjvbLR5JUwG5O
	NaI96teRGoh88UO6GX8/m/TAOsPFmOMv8YPFNZE/2gAo81MRy/hnaL7m+/k5wGGLswR7SDZAJ7X
	pOz6RizCkySFbMqTRNVf7Ry2Mt7i4cPtjfp3MMGc+HTXYRUAR7QHE71e9eLn+H2ATyUxHJY6X7w
	fLaKGFepV9nHVL+PjrMXXbR58SG99ephe0ZF/RWjriXK3PL5JMd2wepxW2ZqJ5KkO/BKWjxX56M
	iHMOzY5fc5+rAEodrEUzPI0BDCPh9erZBs1ARscRa87V3MwA0pGH2F72cYEmTzoidB5p2LyycOn
	c32F8epTKd9qHmAu+TyAJGcGv
X-Received: by 2002:a05:620a:318f:b0:92e:705f:1626 with SMTP id af79cd13be357-92ef2c65077mr1810288085a.6.1784194967226;
        Thu, 16 Jul 2026 02:42:47 -0700 (PDT)
X-Received: by 2002:a05:620a:318f:b0:92e:705f:1626 with SMTP id af79cd13be357-92ef2c65077mr1810281085a.6.1784194964806;
        Thu, 16 Jul 2026 02:42:44 -0700 (PDT)
Received: from [192.168.120.193] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c16871264basm176210666b.7.2026.07.16.02.42.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jul 2026 02:42:44 -0700 (PDT)
Message-ID: <6caf8ca0-8be5-4935-9766-10d21c71ac37@oss.qualcomm.com>
Date: Thu, 16 Jul 2026 11:42:41 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] iommu/msm: Fix dangling list entry on probe failure
To: Weimin Xiong <xiongwm2026@163.com>
Cc: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>, robin.clark@oss.qualcomm.com,
        joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
        linux-arm-msm@vger.kernel.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260716013229.91014-1-xiongwm2026@163.com>
 <20260716085313.207069-1-xiongwm2026@163.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260716085313.207069-1-xiongwm2026@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: hcO9ImqkvO1ez6wLL3R1DlxEfd1fl-ge
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDA5OSBTYWx0ZWRfX8cJn5/4j2j7H
 R5XX0oGyzAXpYDXH61Ct+Qeht+rw3GNG/ZIgRtJriwA4vdOvUJTnqTz01RvIjDz//8JTl6ZBCV8
 y9RPtxqHAvduIJbtXXAXG2sVd/4fMM6xaFlbcwTUkKijJl6yERt/cglG1xfXGzbhlnzmDhuyyeP
 chHfLSbjRGSrnAliXcF/g4hYx5SAk1Dcx7x/kupH+3HnG6xl2Lt5NRkYo/HWZbVsvYQBbTUOjvA
 SHGh9+BraBVX+TWwt0DLtcfshEzM52I2PYRtKBUof2R7ojjHuPruI2kc8EYVst78tOfU7XFYmOd
 cixfGzTsA2hKZgIbf3E7sQ031faMn3yIa1RwRoMovPGYM8pvY9EIhl2ys721I3wx3NyIMkkHHap
 E7xp42d3+NLK8TZihkpyZzqk510sMchH8+GhrAlskXWsY55gmwniC8Ir89PqH2AKnR0Tl9LxiDG
 ffnDoLJbqvjVJ4yHIAA==
X-Proofpoint-GUID: hcO9ImqkvO1ez6wLL3R1DlxEfd1fl-ge
X-Authority-Analysis: v=2.4 cv=BPODalQG c=1 sm=1 tr=0 ts=6a58a797 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=n3OY92c7DukLRWByAxYA:9 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDA5OSBTYWx0ZWRfX85FBhq9Ww4Vu
 E13RYohO4dg7PL0crxnG07/beHGL7qj8Y0eYsvHQ2WkyVlrV1+XhvwJvPmQd9FlWYb2AATIz2Ke
 EfbCGnuZjyXOMYG7zeqFjfau7edAOVQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_03,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0
 priorityscore=1501 phishscore=0 bulkscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607160099

On 7/16/26 10:53 AM, Weimin Xiong wrote:
> Move the list_add() call to the end of msm_iommu_probe() instead of
> adding cleanup paths, which avoids the dangling list entry problem
> entirely (suggested by Mukesh Ojha).
> 
> This approach simplifies the code by ensuring the iommu device is
> never added to the global list until after all potential failure
> points have passed.
> 
> Changes in v3:
> - Move list_add() to the end instead of adding cleanup labels
>   (suggested by Mukesh Ojha)

I think this approach introduces a race condition, because e.g.
iommu_ops->of_xlate() depends on the item being present in this list

Konrad
