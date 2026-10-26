Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793016112;
	b=n/6NJO5Z2ypqvnrw2JfyXAXFRwS2RPIfXZ14Q9R7LH6BU5uYqnn4kczfQmTjKng74BrF
	 F51EXFW39AKJh13OvamJx01N+XLPdO47O++Mu38HAkDIc/DjJq0Um+ARgNGK8lSc6TVYA
	 EAnVA1aRYQzC/Y3CXh9Fw9/vXkTao7ficChr+SpB3DLrbajJtAyYr3DtveJkW2kCqhsjb
	 MImbXG5fQxDqny1gLyCbHcDBbVZ3zXgTupHOiG3HMHbN+4/Sq7FVALfa8H72RSbwFzQLs
	 iGmDaz0zgPOy2RO3RmHHX4HOfk2JkWbiNRQ7iFp0kEoLgQHmIJPJMk7HhsGwmYqun/Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793016112;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=VzJXKHWJowrI6hOoUXLp6aJOFbu2bd1z6Aka5OEKUo4=;
	b=5RXDQddfB+JX5ocKfFfCcTlS5SSx+hhObqP9ajtaNVrZ0q33XTxuSTv9RDNzYM5dxxB9
	 rci/4OFQtavZDrmpEzs6TvP4vtD940K/6AMz0ClDgbrekBibPFc3vmFxLgtDsh7o/uXPu
	 aKtkfdxaAQ5/EZ7J5b2bTeJj2vCCs8DM6NpcLtew4fAipJMimsvAz/3WL3zYuRUlSW0L8
	 UCgKLdtcDzG03Fpw0L9RRIAwQJXMGdcdlESOFW4pOdjuO4QbH389lyjGZIdTwRYfzLMLM
	 jUPGqDPVlujaXwxX/DFXVp9jpZFy8F10O8Qj4bCcsLOArRTqoqsqomo3ugfn+QCKMkg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=IDSvKgtL;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b="O/dbzDzC";
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C364E60A263C
	for <stable@vger.kernel.org>; Mon, 26 Oct 2026 12:01:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C364E60A263C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=IDSvKgtL;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=O/dbzDzC
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69QAspgj2168629
	for <stable@vger.kernel.org>; Mon, 26 Oct 2026 12:01:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	VzJXKHWJowrI6hOoUXLp6aJOFbu2bd1z6Aka5OEKUo4=; b=IDSvKgtLSU4Bw1d1
	G8fUyADyvE5gRtxX05159uGej0m6GRxBzbF/sehcA4Q8ObR2HYxpIcJkv/+AJuyn
	LxfV2ZLcXGqpPxEhV93FhgC6SQu8aEOjJg/MtxSc76iGf9/wT4BJPLGUfZfoTtmR
	1xZ5rgMa3MG3vNjWBpZBuvzuCnfUYKMiAkuKaZifA99SSeH8BqdnxNQCmWehsbYV
	6cllylrwNOPt+BXTZDBudlOPfxKk6fIwyMMv2eYk++qM06YqST4R36UEpJ0ZcSKI
	V4kgDlFLmU/ayCf9qP0F0OVYfvEgA1JcbuP+re4466dis4XsTk2d1EGXmql38Nrt
	2f7LMQ==
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com [209.85.210.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hj3u60njb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 26 Oct 2026 12:01:50 +0000 (GMT)
Received: by mail-ot1-f69.google.com with SMTP id 46e09a7af769-80c63d27682so854754a34.2
        for <stable@vger.kernel.org>; Mon, 26 Oct 2026 05:01:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793016110; x=1793620910; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VzJXKHWJowrI6hOoUXLp6aJOFbu2bd1z6Aka5OEKUo4=;
        b=O/dbzDzC5VOVvB52HwMOfku4YxPhZqnAcB/hw79AWgrNCgIxQCBn4GMsm37tBwZOot
         moXI+UJ+QJb0yTxA+dEJuXWXfj/u7YwMKnI3IuCuqvLWzA64oiy3n5mH2BFaKGJgN+zi
         9kow3oqoz03AkfVOi5PQZO3APNqyjShz0pGU0iahLP1XAU2bcSK6a2de1tMxdpSpPXJm
         swIzITILQDAedBmqLMChPPNI/GLFa0CQJCN2jRsYcPPy7P6wdHw3kEDjPdwQY19yc6bg
         oCndGe6Sz3lhS1DiuIHiNH4fS7ewoCJXuy06vXH+ZCSoGN9aVGd7213z8mcmxZrEwqWU
         4Euw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793016110; x=1793620910;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VzJXKHWJowrI6hOoUXLp6aJOFbu2bd1z6Aka5OEKUo4=;
        b=U70M1wRKD0js9rXH2FETlyRJKtBKiP8KTpUTUtWzbX7QDJAXCWV8svH4lhvh22+CoA
         k2rzQM3tIIzhsJCe7N5OHFlB+bu66kbYQh8xQfAs7pVaxQyKSk79A87ICThA52ZkMpna
         pPF2sXkUqm+KbR7sBehAULM7n/nrQmJs/KqBBcJZxbWSB74FO7KUGSP+o6gIlmmyAxlL
         7uCHqAe+MVELoRe88wrijtZU1cinoFichKiXl8sL0P320jph2vf1QRnMQSIjHsFbc9O9
         4SRJ6jlMsEcZgIvCGH6+1T4FZ6qfOJ/SihkEkQggj0f1knmQGO/H89+7pgC/ba3RjK3f
         Vkpw==
X-Forwarded-Encrypted: i=1; AKwUvByp5WirIUPm01Z7Kt/zsoOhjPWOuTy8Aysig35AUbRh2i7Y9KJBqirqiamXW9JG8dgD8X9PFzk=@vger.kernel.org
X-Gm-Message-State: AFq9FYJBKQ1kZCY6yaole+BlCAQebuYUTZHLR6I2lzyqM5/RMUO2zzmT
	2+smG/Y2nUNlJtok7rMW9L5Cce8kitB/wsf4vjdRtq5SskgX2GJPdFpti2rawZUSnEbiiVlnsv7
	25BnEiZy4zX15rdeA5yICQcLJg9oJSGjX+2Pr9Gf6qlM2mIWmJuLOJ5dgFDo=
X-Gm-Gg: AYBFou346L1/Gl/PS0artKOt6aE6UQMLRPdUUADm8UfHiGfAf178ciW3dPqO5zG+D+F
	vJ+9Xhd065v40R0y9cIVcl/pz4Km+lFrKBHbmYWlqed012b9jCtntslGkfFUscJbfNhKhwOUjBM
	SuniHCgcMMDIAvUsvkvjpnIIFCfdSdPndMfCSwBJly+s9Hlq4SAFVs0rAabejFho9p+2f55vWjl
	MG+dmXm/SoSd6i/kLMjABCa4AgSNlWYr4Ab6Z6JpDVxBYZAQ+Fx7AV9C4XChF+D1Ul2ZWwSZ/Y/
	+ZkrOFQanAOhZpcVtdyf0Z2903Utsv7zXdE3ePP8gjm3+le+TVQ5KNzFMtDkDt3fr2dEhPm6yYa
	sQjjpkee9WA5I4fo8VKfX9Q==
X-Received: by 2002:a05:6820:c0cf:10b0:6de:87d1:a1e6 with SMTP id 006d021491bc7-70ba0d3ee53mr4140753eaf.2.1793016110005;
        Mon, 26 Oct 2026 05:01:50 -0700 (PDT)
X-Received: by 2002:a05:6820:c0cf:10b0:6de:87d1:a1e6 with SMTP id 006d021491bc7-70ba0d3ee53mr4140696eaf.2.1793016109423;
        Mon, 26 Oct 2026 05:01:49 -0700 (PDT)
Received: from [192.168.226.26] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c46c59c063csm265518866b.34.2026.10.26.05.01.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Oct 2026 05:01:48 -0700 (PDT)
Message-ID: <0facde6d-85e6-4394-9de8-8290c4d69582@oss.qualcomm.com>
Date: Mon, 26 Oct 2026 13:01:43 +0100
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/6] arm64: dts: qcom: monaco: Remove FastRPC compute
 CB9 entry
To: Abhinav Parihar <abhinav.parihar@oss.qualcomm.com>,
        srinivas.kandagatla@linaro.org, linux-arm-msm@vger.kernel.org
Cc: gregkh@linuxfoundation.org, quic_bkumar@quicinc.com,
        ekansh.gupta@oss.qualcomm.com, linux-kernel@vger.kernel.org,
        quic_chennak@quicinc.com, dri-devel@lists.freedesktop.org,
        arnd@arndb.de, stable@vger.kernel.org
References: <20261023090308.2898683-1-abhinav.parihar@oss.qualcomm.com>
 <20261023090308.2898683-3-abhinav.parihar@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261023090308.2898683-3-abhinav.parihar@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: eszRBcmEdXtEIRXsBxJw0ZjQQwAPKXj7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDA0NyBTYWx0ZWRfXysw370QjxP1/
 /tr7ZBT+VwtCQiNaNhhuaOp1imgG2nKtI+ZxlTnTIU7jGqIc25AsX2THPYoVfq9ehgoa8ve/iPC
 n2lD5tlw3GwnNhHg4OIYA5NRDoPp5bEWojUYlzeefKv3hZZscbYFuxwWq2N/VUzAkGd46yas6qY
 IRiIp0EnFW3XJHP/h4nIRU7QaNCr026AFFrCfAjxk9hKOc7TsrqVGBtsFRQXy7Ti8j74Ai1UD84
 hQ/DzoxN/mAH34JlBpT4gxUvKFzGaiX+RdkrxOsge71nwOqogPaJF3dPKzD1HP3paFW2PSlnxY+
 GGPD8Fx+0B7itCdtRG0gxyFfFKk7JRqL9CeJCjp8lnGTkGRT1NUB7SpU6+wigUJfp+enZB3Mef6
 YOI+zqwwA2I6JsBiN8B5Y+HiGKrlKGrlFc0kKF/y+CPu2Qc1XVuh2aE1p1LVdOLN4xB5/+FK2ID
 5vFLuRcs0Z8DftOCEAg==
X-Proofpoint-ORIG-GUID: eszRBcmEdXtEIRXsBxJw0ZjQQwAPKXj7
X-Authority-Analysis: v=2.4 cv=K823jCWI c=1 sm=1 tr=0 ts=6adf412e cx=c_pps
 a=z9lCQkyTxNhZyzAvolXo/A==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=rdexUmAEWTTLP2vLS_oA:9 a=QEXdDO2ut3YA:10
 a=EyFUmsFV_t8cxB2kMr4A:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDA0NyBTYWx0ZWRfX4wruCM7xIpcy
 lrAKSToAWU956WvH0ehW2KuAEbKzRq1Y+qMe8kbBdW++ulbXrwDvZuxAYGczMxQQF3lzXQgKmVw
 b7nBnysME5h91P37Ku3COaYKcKZcILs=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-26_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 spamscore=0 clxscore=1015 impostorscore=0
 lowpriorityscore=0 malwarescore=0 suspectscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610260047

On 10/23/26 11:03 AM, Abhinav Parihar wrote:
> Remove the compute-cb@9 nodes from Monaco device tree to
> prevent clients from selecting a secure context bank for normal FastRPC
> workloads.
> 
> Secure use case support is not currently implemented upstream.
> 
> Fixes: af0d19ea5a31 ("arm64: dts: monaco: extend fastrpc compute cb")
> Cc: stable@vger.kernel.org
> Signed-off-by: Abhinav Parihar <abhinav.parihar@oss.qualcomm.com>
> ---

The documentation doesn't concur this for this platform

Konrad
