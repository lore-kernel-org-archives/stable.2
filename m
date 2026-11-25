Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795597757;
	b=IW5AHo2tx0stfxaAVZn6Tqa/kGHFcPveCfB+OCXyR0Zw0n5b3qTPYJG94YDCcDGiXVR1
	 4hpAcGaa0onw9Ja7TDo4H2Vq0sJGJYJ/QbNH7Njk3wPUtw9YBkksbcl0WgJgKxbPnMM/e
	 5rNMB7MyDPV++noMGS0GtgfmS8VT1N/z3SkvexeqWvPa5tawSd3Jnox3G5vQJ7B8rHN3u
	 9GEAaHPp6vNoEb4LM0S92BKc6UfZurVd3k9dwpNTcSZVT7suyNWGo7KbRSyQZPtLBEN3/
	 RnX2TabKK+3c/27jlqzs44bXTzHY62sptz2d+fwI+BPj5P+JjCl/qYlqCOErGTiAeCQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795597757;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=VTGamPuekzux5hFeH9dv3N/BCyf5kNpAzusBnN/5ynE=;
	b=nwh654LdLGVuLv7tEBMjlIyPdRTAvjt8oTFS9BXzbIeuwnXyLkfVjcY+j/YPfNyixaL1
	 FiTYKjKM+iwDebCoMApJsr0Wi135YwF+5u/grt/EdJ4ug4w6uw2ZbisE51M9IfydkWOVz
	 KS43GQE3AYTXmX3uXmj7QEDKVaWruutrs81ClSB9sDcs02vm+wCSJISDDZfmNPxIqqRzT
	 yP8QqUVHaFry5vPDjcchP6l8QCXUtuXAIqn7cV3lOkY9YRzxBoMS0AMH0Y8kbTy/SNKav
	 WI9oNzwi617uJTBkSuqLRNrrBcwNEERTIhtSdVldjyx2if3ePnaLQ+l29UPAX6t/HKw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ptgPhzTf;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ESFkDNQ9;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFE8E606A321
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 09:09:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BFE8E606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ptgPhzTf;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ESFkDNQ9
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AP68cs93113706
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 09:09:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	VTGamPuekzux5hFeH9dv3N/BCyf5kNpAzusBnN/5ynE=; b=ptgPhzTfBdA1WjiH
	Pk945kJFPGKY8t6fLHQqZOj09ia1wvJSzsW5kcyGjotfcl6fiqXUFlNPxGLtONLF
	fFvyTm0X0idOFkYXlj4CIYoSBd17G7Rwis0dk+mhvefrZSd6kqaE35/0hDYkjH68
	9RF57mbM1DNTexFowjXSOkGnXX66vZb1HJ2PvCk9Pu/DJeWXXgWr37mAP6riv58O
	+eF4n6bOcHRu3qzzilOX8xtpRHLpqGfPPwRgdDm+qDZopN99V0AbUcidzuFaRJjE
	WPnUScolK+TP7oXLVLgICnvhCnUMpu6Sn7Oc3c0h3tZTniOvtqX1EOhgzJMmeHCS
	StKXuQ==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j5gnsas7q-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 09:09:15 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-375bac6bd21so5884036eec.0
        for <stable@vger.kernel.org>; Wed, 25 Nov 2026 01:09:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795597755; x=1796202555; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VTGamPuekzux5hFeH9dv3N/BCyf5kNpAzusBnN/5ynE=;
        b=ESFkDNQ9cjD1XCVsbdlfRhUrO9Q6bAjhcAlQqjzNC33mUNe9/b/ov/MoV1AUQzMR9V
         eYhBDv/MQ1qUEnZBpuR5XEX+9LVpjMCeowsLyKt/iin0Q1tjFB9eS33SpebazQC7z4AO
         PYqBV8Y8BBT4Uj5dmPuBDCtJT/8uVz7UqI8JMb5KSCrIWRbC581Dm2lLa5cj7JYWVYRb
         ruunTpIZqzB4cVNu7w2aUmQ8lUEKrNmxqTiemgSfRKDZZKw7E5ZEjQKwFVkdmagin6De
         klng5DChSOWsEkcpqRcowiKM5cpi0p1kW54Ys3pOJJ32EQ1aHppck36N3yWiDqtFnjgS
         yLAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795597755; x=1796202555;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VTGamPuekzux5hFeH9dv3N/BCyf5kNpAzusBnN/5ynE=;
        b=o7PAo4SZ/DocasMLp11ET16IUhB/hs6hxj02H2BHuBzGrdrPm/QCyLwnOIXgA1ZR9U
         994CNj5zj0pINc32xMd9oETEdRaFWabqfT5S1WbyJ3eN96hwuydQlmfGQL7v+DswB7KL
         9a7M2hlasm/niW2KJTAy9dFXH+VBQfaNaovmy3lMbTmZMO4NOG/hk0Jw5DY1w0tMKHSC
         dGUsTV9WZNe3KW3bTxDnUKZ16/KC7slubkBNrbeL/6EfKww9m2YHbAros9eGhs/Rti81
         D4ZvjZV1ZftxFxlQaGOSVgUYTMTUdayBOh9INhftL/7Nxdt42ejgoyr+QPTv4WJYPLsp
         FXaQ==
X-Forwarded-Encrypted: i=1; AL+hErH60yh+qiLPspNz5SL5XmZfUd7A1OOlvInphwpj73lANKmkqcw2RH5lp0D7pYTCeD0QzO4mUQU=@vger.kernel.org
X-Gm-Message-State: APuU4Z8B0huJFXZRFsxJOy12bfPQU1rosLRp9p0Cn3up2UedD/oBDXk/
	ubZhHBdVSbXQPns2pVUxTIpKrROu+3TKSwwyKG9UnYX63cpbP/WrQjfw+XUTRy5/AQ13S2pfY52
	r7OsacB2+sLlDLW1DyrzA3eE3543KdNDlOlSFM48yOKTobWTODfRMkuOi3UQ=
X-Gm-Gg: AZFdTZfJrcqrwj7pWDkkcIC2SkMaklfhAC5cieksXNh1cuCn6c6P34eivqEtMtcQvuq
	PfdyC37Zmx8IRCQ04G3wsxo7mtH3IYfNAiVVWjYq85tCdCWcGenOQFHfO9EnoOmEGKnvzLwhBdG
	ucYM86kIrvdsv1It4QiTwbEMqUb0ybOzSOrwoSMNvFgsEA5d6nVjEXM1vzLk40CWABTMLhee1wf
	AcFH7lIAHSyRi63h1HCyfVX4RjuXbW9WX4fyJVW1Kbt6+xdfCiyJPmPQr/MjpaziFSYYlW+n1J4
	8W7ZDWYUZHEsskh3SGkN5uwEODF0kP/q7eeM8faXOQNb6yV/SKnxIn5cAxfOtYPih63OiYmLpLr
	MclGnOjgAjMu5JffoYZp9xoq61DSZ32r9O59/6+SdfKdJ4QgdcXRyLicvABj97o+GhBiQ5b4+js
	lBCkTD8g==
X-Received: by 2002:a05:701b:2810:b0:159:f192:5290 with SMTP id a92af1059eb24-1b5524b591cmr16136818c88.13.1795597755006;
        Wed, 25 Nov 2026 01:09:15 -0800 (PST)
X-Received: by 2002:a05:701b:2810:b0:159:f192:5290 with SMTP id a92af1059eb24-1b5524b591cmr16136787c88.13.1795597754388;
        Wed, 25 Nov 2026 01:09:14 -0800 (PST)
Received: from [10.204.100.88] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b5567e2bd1sm39505827c88.3.2026.11.25.01.09.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Nov 2026 01:09:13 -0800 (PST)
Message-ID: <8d988822-aa70-402c-bf87-83a4403136f3@oss.qualcomm.com>
Date: Wed, 25 Nov 2026 14:39:07 +0530
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
Subject: Re: [PATCH] media: iris: fix deadlock in iris_pm_suspend() with
 threaded IRQ handler
To: Wangao Wang <wangao.wang@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Hungyu Lin <dennylin0707@gmail.com>
Cc: Bryan O'Donoghue <bryan.odonoghue@linaro.org>, linux-media@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, stable@vger.kernel.org
References: <20261124-disable_irq_fix-v1-1-d27f44f7eacf@oss.qualcomm.com>
Content-Language: en-US
From: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
In-Reply-To: <20261124-disable_irq_fix-v1-1-d27f44f7eacf@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: wj30-_YsNXKNP8mQr4m3o9IIBJRVIyms
X-Authority-Analysis: v=2.4 cv=G+SJgNk5 c=1 sm=1 tr=0 ts=6b06a5bb cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=Wii44K86_fOECA-UWJUA:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI1MDAzNiBTYWx0ZWRfXyd383b9DOkrg
 dXzV+JQMlI8CVAxLnT94VjMAczpz2BHy+goe0eqfH7f3S2GHy5DAFRKWAoJhO3F3RBybH6QOd/x
 HlFX/azej8A2HQdSXG/AsbSshAlLKVM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI1MDAzNiBTYWx0ZWRfX/Z+XwnkJY8S7
 FYHB9W0R69rfYe6AsunGPwuBQ16c530eOrGWlMoQk2ENbePnq4Jl3401Wj/sT4hELYLemyzU0bH
 6RqNYs0p2aBa1yXoae0Jqvr/o1RUPt5HwWGqwT8Gm4I4z1MdnUtYzVYwdwIEyImlCmffbGB8rZA
 TUKI3j6/7jD3+nx///bxErHdPWnkvwke8kKs/oX8lpL93z5sYDA6rNJ1iuVcdB2P/HLaF6NhlII
 SDzBI8lmjPOV9CZUNvO4Blh5B+jxfpNM6I7BSuErg09BWq8mP+wg9uxkgohnJHEC7hE5hXavLL8
 Lv1jnr0HYPVdho1Pwl0E0SbvysowmVXGO1Mi3IyF4H/wDfXTUvkHC+zACZR8SKpkx4JWHxUqqZ3
 Tw/5f1MPfSBDSiHUDiX1QCh8AZq8Cy39yk3pyMx0jALVPFCd35mghH+hT+ZIgqbBtLkQJfSQHQD
 6gc2czGnMxnhpoGQrhA==
X-Proofpoint-ORIG-GUID: wj30-_YsNXKNP8mQr4m3o9IIBJRVIyms
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-25_02,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 bulkscore=0 phishscore=0 malwarescore=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611250036



On 11/24/2026 1:30 PM, Wangao Wang wrote:
> Commit b9c2215bdedc ("media: qcom: iris: use disable_irq() during
> power-off") replaced disable_irq_nosync() with disable_irq() in
> iris_vpu_power_off() to ensure the threaded IRQ handler completes
> before the VPU is powered down.
> 
> However, this introduced a deadlock. iris_pm_suspend() holds core->lock
> across the entire suspend sequence, and iris_hfi_isr_handler() must
> acquire the same lock before it can complete. Since disable_irq() blocks
> until the threaded handler finishes, the two contexts wait on each other
> indefinitely:
> 
>    kworker (pm_runtime_work)         iris_hfi_isr_handler (kthread)
>    -------------------------         ------------------------------
>    mutex_lock(&core->lock)
>      iris_hfi_pm_suspend()
>        iris_vpu_power_off()
>          disable_irq()                 mutex_lock(&core->lock)
>            __synchronize_irq()         [blocked: core->lock held
>              schedule()                 by kworker]
>              [blocked: waiting
>                for handler to finish]
> 
> This manifests as a hung task with kworker stuck in D state:
> 
>    INFO: task kworker/u33:8:178 blocked for more than 122 seconds.
>    Call trace:
>      __synchronize_irq+0xb8/0xf8
>      disable_irq+0x60/0x88
>      iris_vpu_power_off+0x6c/0xb0 [qcom_iris]
>      iris_hfi_pm_suspend+0x44/0xa0 [qcom_iris]
>      iris_pm_suspend+0x6c/0xa0 [qcom_iris]
>      pm_generic_runtime_suspend+0x38/0x80
>      rpm_suspend+0xec/0x6b8
>      pm_runtime_work+0x118/0x128

This is fixed with, pls apply the same for your issue.

https://lore.kernel.org/all/3d04aa51-7301-4d8b-93d4-1a7d28e6c614@oss.qualcomm.com/
