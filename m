Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795601939;
	b=oUHGQ32tyeHxBRSbmcxGuRjJk3k83yZdx7yOXxhnpr3ZpiA8she16i7WJw2UIdbzyTDt
	 q3tmgcY5bAfFjAzfn6y4waOFzvVy06fkPARc4dgkXb3egxDhwxridjJSE7HJfabpGBIWR
	 v/TM+PGhKBxqYHtbEXV1CPTH1skzu2Y/TfQKfKbnm0+zGzorE3Qe5UBT2lkqJ13JjLfcv
	 W8DkGDale0MIt6ac3lB7Xk4aCtR9IGt2pEivDi2SiN7qVSNvuK/WWJe9PsW/6jcxUOmpr
	 ZAR4ymLCPaXrwssoXzzqFHHTb8xen6dSRJ6f2efIPM+O44gDyKv75gBcqFmku5TJqSw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795601939;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=qgfBpFM+z2YBeezRZEwdMFkwU1ZfAT0p5BExL/+QJaE=;
	b=qkTDOK6VZjRVjKRmdINNCbtYGyxAUW4FOXG/0tf+lrMRITmwEVH7n8F2KH+Vev475UGo
	 Oaje6qaRYvxUto7xCqizbW2Fikd+5W4e+FA1U1reZWkhJ1HwU/wKBH4uaublDCMgjUrd9
	 uR8ZbxZMrbjt4gBDOl4mX0lcjFmKAWob1QzQRXY+jRVctik0asRFcsS0yVYcIj08zCLES
	 U5Js4l8o6lOORU/FVlO95stnZrjUyutzQH9k/4XbXbVke7qLMXgNni2zhOLTkl6LEE0k/
	 KjxhBCrIGd1L3mkBv4ECz5PnEcCgGqW3LoWS5uXBx9YspLbrxaf/5r8aVaPFZOKlMQA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=UlzkiCmy;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=YWsGyCBf;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFF6F606A326
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 10:18:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CFF6F606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=UlzkiCmy;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=YWsGyCBf
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AP9mAOw115100
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 10:18:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	qgfBpFM+z2YBeezRZEwdMFkwU1ZfAT0p5BExL/+QJaE=; b=UlzkiCmyHTJB/y37
	5duvhkt2WYUVV2iEzzGE59afXH0OzbrZNvqIJo5FDb+GbFGiDqMJ1JmiTNA2kIaI
	QKcSqSrEd03iugMw2D7CrdsIMFq6/bk306S6KExjZ/VpVZ9gBzqo7fYtPLnOCEd9
	/ZowfVrwVU2EjJi62/g5Az+vb9MwKAmSvG3gzHPAK9SmbUtIVd98/CzGz5bikF8Q
	XfKzG13XWsBRZyA0DFfhh9IAnp9K/abcVmNO37NycEmZ5nvuWwasb6E3BpWUCS0C
	Iz3BC7my1zQ72peifXykvUoZdkiy1ShCVt0FmXPRCeIP6JwhKvqD4TPQXQ/yTM+p
	K2OYRA==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j5cxkcakg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 10:18:57 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-550b1b21674so12523031cf.1
        for <stable@vger.kernel.org>; Wed, 25 Nov 2026 02:18:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795601936; x=1796206736; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qgfBpFM+z2YBeezRZEwdMFkwU1ZfAT0p5BExL/+QJaE=;
        b=YWsGyCBfUQFi2YvI4tdS8b+hf7hYCTuc55Lpb6Xrx/AS9s2Eo/Np0nACBoJfYU3JGV
         RcsjtTOWIYAuv8d8JSzOrECzguumws8mkynAMlj3NGlGL4ioo3pullhRiFwUGL7yUg1C
         /tdU//QB31lrrndiXElc2pwjYpgjH5YaJSmpZZ7avAL85otAklPwKfNHwHM1KxAFO+TA
         F2MJ2QVVdM8G46EF41FwmErK3UUNiAR/OA4Ts2DMjERqyuapPPA9abkTPddeQVt9120T
         ImeXArbAHwLXDpKlSmcLhyx6yaJ9XQIUnT/NVT+K2J3gVUVcrX03NHOQNX602Iyn/CtU
         5JtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795601936; x=1796206736;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qgfBpFM+z2YBeezRZEwdMFkwU1ZfAT0p5BExL/+QJaE=;
        b=lblKOfhtn//F4RT8aHn7UZcoaLFF1yKAEzkt/ER7gIcixTeFqOQo7Vu8qDA8bahOpo
         EvMCp3pn/ecbrYuUFyYbYb3viOgf5cAw5n9heGJ5/v++XVxd+xfRUFS9a/uxTtRff+bh
         lO/EXNaSbkwY1/ss6UuynFElz98m/LtePmWOr7agy/QbPbPUDW2i+q8mr+/NwXSSeOU2
         wadiNenQuoxnESVGaTSUImEtWOpN24PVdbpMtq/N+qrKsJmKo7xyQ/zgjrtkJoUpkROI
         9b7PtIPssQk9pxWbmRRg5gkMisqbMy+Ds36TZ7SRVf5094vCC8f8Y63HHLJb/ni4y80I
         9kNg==
X-Forwarded-Encrypted: i=1; AL+hErHU1uah0bAycawnVdLwtIA605XGhVoSn2Pr0tkh4b3b1zBcFXJeVgSp6j7IsI/2JRA5ZikC5X0=@vger.kernel.org
X-Gm-Message-State: APuU4Z+CxK+QUM/8Gwmi6+364wdMUjkHo336FkYeztgnpBQjR0WalUj6
	3IuuReX8TJ4N64+wOX/zr7fCy73zU/jgLKa12ZosM9BcUnr3JWBIe647d8g9rpP+20bkmxRQ0u3
	51KbeyT2LaRN5GXZ3/Lzzmz9BW6FMkM4tra1UeQIlxQdOaZYavexIdqpT3y0=
X-Gm-Gg: AZFdTZcLgSW5y3q+wyAzZsTM6CaKYYsH03fbxMhQ8CuMUqNXOx9FOnSP9wvsPvs0dVI
	MOWjMGjnFqF5qmF29pa6eXK1RbmqYJtsNWB72q6BwV1BRa2PgMfYVSfMfO6uIrOm11KpeKqAnOt
	fGVAEcd5hYgOIIpr1MiiZvgOjKj10iRwbzGawFwYQC7c9QnrRS4XyFzYlyui/kSPjf8WNRXWMe5
	qfqZptOcFflhhbzbEkZUJXSw+ocqvFyb0m0/XuPli9aroRx/99o6TsNzn/mdLUjrn+/ktZoX74Y
	KTvAcicd7+7rBVGV4UFpHcpjMesIboRO6MYIA72t3CiBYLUEGFjCHSp1f/efjoQPBXtQmHD2G+1
	M2iIAwx6X/+Vk2pXPn8scpEAnTnE/Wjfc9OdokA/npelOrYlD3EB6fKm7NSdTYTPuIMjjpXI=
X-Received: by 2002:a05:622a:ea0b:10b0:55d:3798:5ff3 with SMTP id d75a77b69052e-55d76ad4456mr300294311cf.5.1795601936069;
        Wed, 25 Nov 2026 02:18:56 -0800 (PST)
X-Received: by 2002:a05:622a:ea0b:10b0:55d:3798:5ff3 with SMTP id d75a77b69052e-55d76ad4456mr300293971cf.5.1795601935658;
        Wed, 25 Nov 2026 02:18:55 -0800 (PST)
Received: from [192.168.226.72] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c513ae68284sm629439566b.18.2026.11.25.02.18.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Nov 2026 02:18:54 -0800 (PST)
Message-ID: <0a0544f0-9999-4c35-b370-0ab291e3cb62@oss.qualcomm.com>
Date: Wed, 25 Nov 2026 11:18:51 +0100
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
Subject: Re: [PATCH v3 1/4] media: iris: Fix runtime PM reference imbalance on
 failed resume
To: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>,
        Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@kernel.org>,
        Stefan Schmidt <stefan.schmidt@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Hungyu Lin <dennylin0707@gmail.com>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>, stable@vger.kernel.org
References: <20261119-iris-handle-unbind-v3-0-52d467a13907@oss.qualcomm.com>
 <20261119-iris-handle-unbind-v3-1-52d467a13907@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261119-iris-handle-unbind-v3-1-52d467a13907@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI1MDA0MCBTYWx0ZWRfX/M4FEDAas6eh
 ibbD/9m5RUQceX4CwIOdt2+NMcbHdQqViACQdmRephW/+i1CCoh3SzyAMeTGY5532iwTt6+JRr0
 fHaax+CZx+mJ7u9TLSfxx1lMYa+k350TjkfRcYa9/9YX5LxBMzehvseUymlvsJxMbNu7cv+Umzp
 3dm8o54hlLayd/ke9xSau0f0Ris88xnXjHvcQsksMOyBUInwX2M7kxLHtzXnEOFI19QborbqJ3w
 zfS5J4tA08TuY4arOxsU64PYvaTN4rMCZ9fu0dkwAV0RF/SE+JQ6EHigsS505Lf9udhLEUEyIlk
 tkenYT7kxqNeojQFImcMElUm6/s37kMvYAV8U8VTqBpq2XHW3oGorBUmEMji2FMipios5GjnFiC
 I3pbR71SRegqNqm0QFfkejWY2Kbt9t8OAfHi8F7NKDTZecs3B1H8GCOtJiuDL8gv6S5Zur6wR71
 RC4MTMIL6Y58qXzl/NA==
X-Proofpoint-GUID: UruRZG2UkefWOZkEQbKJY1-hbIp4Y3yD
X-Proofpoint-ORIG-GUID: UruRZG2UkefWOZkEQbKJY1-hbIp4Y3yD
X-Authority-Analysis: v=2.4 cv=TLbQ2Fla c=1 sm=1 tr=0 ts=6b06b611 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=pyCJf-qXJP2HTA3QtQoA:9 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI1MDA0MCBTYWx0ZWRfX9BQr8UMY3AOO
 nTn/2u2cjX+QhBthjyaaXDD0M4IyYC4d5cuClcf4JQhN3oaDgUWPx0J48GAl7w9+bWK28LCnZmN
 QVDMddys4rSJ/eLVbLascJZlrK9LkBs=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-25_03,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 spamscore=0 clxscore=1015 suspectscore=0
 malwarescore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611250040

On 11/19/26 12:45 PM, Vishnu Reddy wrote:
> pm_runtime_resume_and_get() drops its usage count when the resume
> fails. iris_hfi_queue_cmd_write() dropped it a second time on that
> path, resulting in a runtime PM usage count underflow warning:
> 
>   qcom-iris aa00000.video-codec: Runtime PM usage count underflow!
> 
> Fixes: bb8a95aa038e ("media: iris: implement power management")
> Cc: stable@vger.kernel.org
> Reviewed-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
> Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

if you want to go hypermodern, you can use
PM_RUNTIME_ACQUIRE_IF_ENABLED_AUTOSUSPEND (or another combo of
these, defined in pm_runtime.h)

Konrad
