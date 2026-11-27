Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795788002;
	b=VI5ZmmO+JUtzRhwgZVBHtmxCGCsf63mqXguVInJDuP7H3AtFq47xP2a/lM+l6PVjPquG
	 Dez6FD680glXb9jKVxjXVw/cK1JPciIxvoEqAJsVdueZuOplUtEhdp0x3fS4/04Gkj/ll
	 yIELyRwFIp5Wi6PuksIN7GgVq4BitIYo2tVOQ66JNy92GiWVa28Nb5I+wT0EAEVL+fkvU
	 BCwf4c30Z9FvGfOnomZmisty+3JqOhyZWWnDzhBj2vN9Xo25UPFTf3f2SC9FAmZ0aJyD9
	 J8sv6fmKRUucFMqvXI+obW57KtfF0tVJ+qSTUzqSqgAwFtFCcpBpSzuOW3DFxtWsSlg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795788002;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=TVJ7FGwJvzojmK8u57f7Bta3j/u3dqWpXMiIY6IlGEU=;
	b=NnQOL4HB7DuyAQf9/RLqjdvr2pP0ry4+mceBrcrt/b9J6X/o+1IsghgYWnTLD0WCmNaU
	 OlOPLa3jjI1nBu+hssLZ5vGVW7fc5MSPHyxEC1nlG1kR5C28zSAAhMyTIEKOVUNrpowqY
	 JrHUvj7ZDy86a/9LuH7n+smpFXkP4Bx0MXuIvKsrijfGaT1xl5DLWl+qQEsc26rf7+K59
	 aNmp/4tfBm19G6WHOD0FuTZK8z0NWaWKeQZae2i/LmcNcVSiDW090Z7yf+eFZaqIwLfz8
	 zJUCZ+bj2BConA0ty6cjBMHtNUbWg3sKnMvoC74RGxTs3wSDpcp4W3IIDtJq26frP0Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=m17uSs+h;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Ed7OU8m7;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 261BA606A321
	for <stable@vger.kernel.org>; Fri, 27 Nov 2026 14:00:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 261BA606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=m17uSs+h;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Ed7OU8m7
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ARDtrQV1959129
	for <stable@vger.kernel.org>; Fri, 27 Nov 2026 14:00:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	TVJ7FGwJvzojmK8u57f7Bta3j/u3dqWpXMiIY6IlGEU=; b=m17uSs+hA0uwBeDk
	n3jh1uZfvCrEpejAAyvlQ63wlxqQ5XKm8xdCHnd3XFmt45enERsJ99BwC/IlJMw2
	pylSEyf1DibOMz5GKQQC+Dkim/U06eg8hyFKM0gswpsYhSQX8yGmXlXrEOjclq2F
	YJ+InFFuUXy00Dv2ky05IsODF1m9ANOuFp/GJ0Y+nbuCzcvB73BWHrmxTj6V2wm2
	eWcxnecgKD/gP2bHYg5VRVBq4zeKgY7uuGGIXLSBuvdPSxWoFDtZzHkjymxnYnHr
	N8hkQxtCGGO76ws/8H30acpnjbHfLNzaFMMK6LT5eim115BRu/gCIkXwDvWBXKXs
	zYTDZg==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j6u55u8t1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 27 Nov 2026 13:59:59 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-386b8624cf7so7166414eec.1
        for <stable@vger.kernel.org>; Fri, 27 Nov 2026 05:59:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795787999; x=1796392799; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TVJ7FGwJvzojmK8u57f7Bta3j/u3dqWpXMiIY6IlGEU=;
        b=Ed7OU8m7Ok1Ap60daYNVpX+Pvgb8EiMGxgN9mEvEBT6vdEsrNIDCNZlqKp3XIA90O9
         n0qAh1HDWwXp0RKIxA5h5VimOg1VKmqJh0uu29uOWvpER/NJaeRcTdQX/oit/ouQ7U+D
         tdBTYRVc61Ut1puD5INnbhWfOs/oL/uLbndPOCrogbNKmLfMz4LtAxm1HJ/l8TcGsKng
         /HvSfc4Wz0B5aBOG+fMko+qH/xZ42+C5Rr2ki/qlmE7Vv3uOVhmpIFuZlpe2SRNRX8PZ
         xd5g8vjenagAQuqYL0hhI8cG6dWOCzsWQH00k4VNnYdcERtMGs4sKMnlo+K+XD2nBvz5
         Rm2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795787999; x=1796392799;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TVJ7FGwJvzojmK8u57f7Bta3j/u3dqWpXMiIY6IlGEU=;
        b=V8cftafjEcZgn7x6eKA89PAlrBlk2mG5RnOjJahFmCriT5TvNGzqL/iNfrQXBzVZAV
         ze7SR+10OkhR+Gr/tFltBabzMd4MY4rt9qj6rZgNfm3EcOnLgPPuzxsZYy3ncRJgb4k3
         BkWh75Ajq+LUekwKv4BImvudUL1BQa1/gmJACQ6xrIIwThB5ZYmTPrAayz8Sam2D+wyG
         mP/WKLbEdB6lFbdAA9SA9Yi0mSRchRu1wO7XQiHfZN+IAK8OiWISEGo5mnwUKuiFwyVz
         o/4ifXxUGMVvWt7ClNCXIXbf+/yWLdjKfnkIo72SZiAvA6HUWxnVvZLWtfnxJWdBEIFF
         ZDFg==
X-Forwarded-Encrypted: i=1; AL+hErG6MHlFNnUpugllL4HlOG2MPIhaGzadcITv4ncMGcU2/MUUwXMN4pbuoNskXWhWxsekqSe7Ek8=@vger.kernel.org
X-Gm-Message-State: APuU4Z8JcdawFGU1YdPBUiihfAv5rcPRZDPP/GtFcAjhm2Lc4D9evvDh
	qX+jL9u9Zl27SeNBkR+d33potyiuRakPNCQJqm6GGYsieXWGYv3u+EtfY93vSZkw390Ml2pcW6p
	0ut65DZI/+4ADNjAW/cK14eks+lx+Gj/wJLvfQhBHjDiYKZ5VOfBpfaVsNJc=
X-Gm-Gg: AZFdTZfx+GT0PdDlRw4ImZ+vrrfFhy01lwXLSSUpIzJ/Wc4iOeUvHH/NpWgAAd1aQtH
	Db50puTP5VkBXDYOlyFNa50zRTyEdxtAKPEEtKaNxN7bFk5gHu9fyARrfYhuRW1sKS9s2y4M47m
	EaQPA9q7RNZpCDb/DpHk0I+NeiVsHNMSjz4oMxkbYYuskN9Hyvv7AhSc02PRGzlyasCdtjSLezP
	qWcteKLv81Ns47y0uyMXRAy68t537PjhuwsARnjK55QJjSvogK1TlVVZ0bXa4P7ZZcFLpRovQiN
	IMNn6YHnT5zBX0RMBEUGs5CvKjpoAg/9mlkw3dQx7+GhrwB14rFIdyXvvRI+pQZdcst50DjQvxC
	4fIZZ6TRjopODEOKspmqcaso2qyvQeqVMErJR3+QS2XXX5I+Xkm2qaW5sJZluORCmaHcHU6balW
	7ZTQAD
X-Received: by 2002:a05:7301:fe91:b0:386:e392:5031 with SMTP id 5a478bee46e88-386e3925531mr4757474eec.14.1795787998845;
        Fri, 27 Nov 2026 05:59:58 -0800 (PST)
X-Received: by 2002:a05:7301:fe91:b0:386:e392:5031 with SMTP id 5a478bee46e88-386e3925531mr4757444eec.14.1795787998322;
        Fri, 27 Nov 2026 05:59:58 -0800 (PST)
Received: from [10.206.111.23] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385666e7fc3sm64939202eec.8.2026.11.27.05.59.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Nov 2026 05:59:58 -0800 (PST)
Message-ID: <72ae56fc-41ea-4088-8daf-3d9535de97f9@oss.qualcomm.com>
Date: Fri, 27 Nov 2026 19:29:49 +0530
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
Subject: Re: [PATCH v3 3/3] media: qcom: iris: Skip register access in IRQ
 handler after power-off
To: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Hungyu Lin <dennylin0707@gmail.com>,
        Stefan Schmidt <stefan.schmidt@linaro.org>,
        Hans Verkuil <hverkuil@kernel.org>
Cc: Bryan O'Donoghue <bryan.odonoghue@linaro.org>, linux-media@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
References: <20261120-fix-disable-irq-safely-v3-0-82f9561394cb@oss.qualcomm.com>
 <20261120-fix-disable-irq-safely-v3-3-82f9561394cb@oss.qualcomm.com>
Content-Language: en-US
From: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
In-Reply-To: <20261120-fix-disable-irq-safely-v3-3-82f9561394cb@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI3MDA1NSBTYWx0ZWRfX8QBkq3g9mSvV
 v9qypTgBUnNYl5yySoDr/oIGzApwL0dEcrJuOUepREmtHtNsYgNVBks+VfyaTURLoBxTLXYJeQQ
 QRoncLNI1VbR3Y2t8BHWu2RHxcGWNx8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI3MDA1NSBTYWx0ZWRfXwLsHNeL49lVk
 4JSBqdR7mLuQQ59zRzJKMX4ERfi5Q0gV3reXZnim6o8J2lQORHq8r/JhGhBSprcCFpWXNm9cgAF
 zEDfWGB+B7qonpi7avEDX+eoZpCpyI79h9oOvLJDkrgv739Lqx4GcclHLRaVA4d8iNpSAt12L+R
 kbZKIaCaRXE3/e2xBizUTC7pol9GNJFDWs8ok7NyT5XKK7efPaFtL8fRFnpHZSpJ4zRkzDcl44M
 fhW4qP0cMvgYeamSkUPdrtOi+t9bAELbRuUiuZu1lQ1KDORB4ud+CK7lLYFwy6+2gc11JAw5JGK
 GClduj1RwgV/mnbwJij7fW/+nm1IwuwI5KF6Gz8PXJVae8y2EIP9TULSb7yX5H2L+zh9WPc70Qu
 n8EzotY/jRHCrAnSM89aj56xgLO8uvt4yV65epVwq/VdOPgTAjOKxzA+7/ElkZjpoNmOb8nnA6m
 c5+74mW/BDbvZiPVrYA==
X-Proofpoint-ORIG-GUID: KjI2NWWNTwpz5l_dOZdzgMOiQcDj7KV-
X-Authority-Analysis: v=2.4 cv=Z795j3RA c=1 sm=1 tr=0 ts=6b098ce0 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=EUGQh4eoQUa4RnJZeMsA:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-GUID: KjI2NWWNTwpz5l_dOZdzgMOiQcDj7KV-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-27_02,2026-11-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 malwarescore=0 clxscore=1015 priorityscore=1501
 adultscore=0 spamscore=0 bulkscore=0 lowpriorityscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611270055


On 11/20/2026 1:12 PM, Vishnu Reddy wrote:
> The threaded IRQ handler reads and clears the interrupt registers
> under core->lock. Power-off disables the IRQ without waiting for a
> queued handler. If the handler is woken and queued around the same
> time power-off is entered, it runs after the VPU is powered down and
> accesses the registers of powered-off hardware.
> 
> disable_irq() cannot be used to wait for the handler. The caller of
> power-off holds core->lock and blocks in disable_irq() waiting for the
> handler, while the handler blocks waiting for core->lock.
> 
> Track the power state in core->powered, which power-on and power-off
> change under core->lock. The handler checks it after taking the lock
> and returns without touching the hardware when the VPU is off.
> 
> Fixes: bb8a95aa038e ("media: iris: implement power management")
> Cc:stable@vger.kernel.org
> Signed-off-by: Vishnu Reddy<busanna.reddy@oss.qualcomm.com>
> ---
>   drivers/media/platform/qcom/iris/iris_core.h       | 2 ++
>   drivers/media/platform/qcom/iris/iris_hfi_common.c | 6 ++++++
>   drivers/media/platform/qcom/iris/iris_vpu_common.c | 2 ++
>   3 files changed, 10 insertions(+)

Reviewed-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
