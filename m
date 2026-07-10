Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D0CA3F0A92
	for <stable@vger.kernel.org>; Fri, 10 Jul 2026 08:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783672079; cv=none; b=H/viR625UgLHMnOQ+BIncYO+nnjgulqkHaZgMarkAyNiufFITG+3alnH18gvZDoAhqc4JBJK3Xg1pruVM+NCTSyu224nJZNtq2Rl7ceYiGJLLBNtpYnyBr73utba3cpvH/pQVek9gFOieEkeyygZ9DEbaTYHmL+yR4FKGupHZtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783672079; c=relaxed/simple;
	bh=w0XukhUGcMXl1pfRJDXW4iErHU1Kq89lOp4vXId0pfo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DmH5tyRobaQu92RaGfnPqaiYnfpEzPDCq27gMbfBbi1xjX72LkbRh0h6NoBoVvYRc83gCJ1fujSMs4Zw7u776TitrtD/BtIAZ/P0DLBU44ZOnVvvyBUk3at4KpTuFItImCJy9BJ3kRYmfwzcEaXh1m+o7injLtk6R5sxi3U2WYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LTK3w/pf; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=UFbUO1Z0; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LTK3w/pf";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UFbUO1Z0"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66A7dZEB182971
	for <stable@vger.kernel.org>; Fri, 10 Jul 2026 08:27:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	fwL26Vdu8eHV+0HZPUj6SDG3AZi2maZop/sTus1frl4=; b=LTK3w/pf3y2Iwjay
	ScD6QLWv15XwLvfa+FLdeLfN4OlKhxIRNGhpmo1qec5K4gDHlsNxK9tmeazt5uED
	JiQJGEG8ZD0SnkJ91uuLUs1m+dWSKRV/KgnrEHpmC8hlhxa6I3VvaCVhzqy5tgS8
	TTu+cTF8uJlQgkZsoZfRZeSRHromjAdPhGS7vrr0/Oe6g0fkTAF3dlrwQYbnCVFY
	k9IY1n9ADtRlUYK+sAw6WZG5LIOcWKyUbjbSLGEJ19Dyt1cYhJgDAwpRBR0HOq32
	Cl/P/LkEtnZ+0ihDpFs71ZmTR4tnqCgVLsWo+eggL86azB2OKYcynoOQ4IT+X4tP
	NwgJDw==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fajte259w-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 10 Jul 2026 08:27:56 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-51c1a97644aso5999401cf.2
        for <stable@vger.kernel.org>; Fri, 10 Jul 2026 01:27:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783672075; x=1784276875; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fwL26Vdu8eHV+0HZPUj6SDG3AZi2maZop/sTus1frl4=;
        b=UFbUO1Z0SbktgJraAzaZQ9Dwep8vLk9+QLIXmOI33SflZZEjiP7zvgMHlF6BuxmEwu
         ajG/4EVB11rnG0MbkrFywwLsr2KjnbCmAdmApgvA/VnAELkkAv1MLFtKDhxo/CaIcwWQ
         Q6pPzV40nBTt8rng4ORb21ZVK+Uftozl1+NCVF5qphLzosISAATqIjBYDj+WEsbakzqN
         ylg9WEakZP6ykfBqJ9wzjf5wkyx+i2n00viy+K1tiaS9Yk81S6sSDhbT+Bw1PmPwPJuI
         A7tLhQH6824UGeY3ZVGrqAC3erN6sWpTYSIEBbP9EdfT61m00AlWNK3hCMMeraBzH7B4
         qg0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783672075; x=1784276875;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fwL26Vdu8eHV+0HZPUj6SDG3AZi2maZop/sTus1frl4=;
        b=dZmOGirif710j2ffqWLQDncj08ejEID6ZHPapmhkCmMejMYVdQ5q71JvfQ8XvU2egT
         GuVgFdSCli2/UJgKAdj3LKEjy6Q8d0OiLx1KsHk5Ez5D5GcvPSabLahI1e3vGFEpYNK8
         bootUI/D2keAR0OvyYNaiFYKIrDKe31fNuHOh8rt08KTn5sRchA77zFxnx+mn+jEERof
         +nYJDrZo0GwmuP7tO5ehIQz7CWw+LrCosuEqR7dWmP5L5pOGmg8uKpyXK/Try4KIcmpX
         z/Or18qllNPXFYsFN6W4Np4z+NOBIWpyTwGz5KhCrt7Qj1sr6VTr7+ulGIhJH8UjNViI
         tNMQ==
X-Forwarded-Encrypted: i=1; AHgh+RpSXO9F4EJU44Q3fHeyr3dHPaczvtdOTj1ixbhWDgtkI8+qrfYOT6W/qbTvXTgpDdTPB1YjTe8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4jvOHbyChJev/CLE/2goV1LW4ZiLZJaLnpEHlMNHM7e41c8Ol
	vKE0Iy/iT/+OH01Vk6Irui4iWhD61TDE8fpraDbyGhA/xVz4Cf7je572dPuzkjwxrpzWbIo/kV8
	fiKrHnSHskD9yjGmorRK8EzEJeGwRVobZyyrIfUr7F3LwBX/a5titNu/3560=
X-Gm-Gg: AfdE7cmD+3yD5fW6AK9QNksZ5C+a6GhBPhqbznYfMsLTLQiDjzL3IVepHl+aFm0W1i6
	TwIRCIzp7eFP1b/AYRdzZW9wtntXzpTzqU+2WTeHs0qHy4xSdImYiJ60QuyaeRe4ABzwmEfKdyu
	KUOTd4cGBtakerVRZzos8r50gYgMrnPh/Oitxb7PMxvsUkG5DsHKaXqU4Tz1gDARR9mJ+mwUGie
	XeK1yF7kcrl4N2OtCWJ0YTPILp84YoWfAMsbd//59jFpgwmm3TClfas1H68p1oT8xAYOUhYedRj
	9+YCFtESHyR8KE4ojmTGsXwz6Cg/G4L7OJSGdgqHhDcggiC3dqTZw1o9EF28ENAKD7BHLqTtLOB
	SOoUj2HMBXOzH47Y9djysOeauTpNGMAuOdSgKrjtw9xoaRg==
X-Received: by 2002:ac8:590d:0:b0:51c:2190:3b56 with SMTP id d75a77b69052e-51c8b433337mr114544611cf.21.1783672075651;
        Fri, 10 Jul 2026 01:27:55 -0700 (PDT)
X-Received: by 2002:ac8:590d:0:b0:51c:2190:3b56 with SMTP id d75a77b69052e-51c8b433337mr114544311cf.21.1783672075114;
        Fri, 10 Jul 2026 01:27:55 -0700 (PDT)
Received: from [192.168.0.172] ([49.205.253.142])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c15c38c164asm429906566b.3.2026.07.10.01.27.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jul 2026 01:27:53 -0700 (PDT)
Message-ID: <ea0b16a3-0c44-433f-9404-747feff3b19c@oss.qualcomm.com>
Date: Fri, 10 Jul 2026 13:57:43 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] media: iris: avoid bit depth validation for
 capture formats
To: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Neil Armstrong <neil.armstrong@linaro.org>
Cc: Bryan O'Donoghue <bryan.odonoghue@linaro.org>, linux-media@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
References: <20260710-qc10c_fix_and_disable_time_delta_based_rc-v2-0-701d6dfd1ac1@oss.qualcomm.com>
 <20260710-qc10c_fix_and_disable_time_delta_based_rc-v2-1-701d6dfd1ac1@oss.qualcomm.com>
Content-Language: en-US
From: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
In-Reply-To: <20260710-qc10c_fix_and_disable_time_delta_based_rc-v2-1-701d6dfd1ac1@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 4ejjuZzXfgqK_zeDHCkGO-Swr23MbMLx
X-Proofpoint-ORIG-GUID: 4ejjuZzXfgqK_zeDHCkGO-Swr23MbMLx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDA4MSBTYWx0ZWRfX0jWojxJV3wJk
 bzkN7UPpe8wMS9YbSSZxvR5r068AIZJT28NOvEjvmMYNn72sJCeB3V8TI6/GTqOOly9nU7Y9mbS
 8fe7COPGwWnFQkLeWAcLwoYIy/pDilGjaz9M5V+79Z17MN7BNIFl6fd/FoVzjSNhfVb4TXepdW4
 0xSsX/JEmDj6zCipnl94X+DYxzCp3JpNex3+gFJoddR2sAnKQNfqe295fbYgoxQn5vrI0ghImG7
 CasfIpCIFD5y5AafXFoTmroZ25qNGljTPMNGziO2f4Qm/Klg2J4m9oVpIemZK2jGHyPeWuDiG5m
 d6fM+iI7Nol4GKD42qQS6AKB8WzCb55PC866FRktjEhmkksFyFwpdkxm0W6FQMn3W0VnNPYrTAI
 gPoulBTDRFV+2YpWjc25waOB8GVY4GeR+aiKcrPPCrt6UILHJTVODJsbbCyvXhtPpySz60//ZGS
 r0d7M2m8OuCsvWMAoRA==
X-Authority-Analysis: v=2.4 cv=N7MZ0W9B c=1 sm=1 tr=0 ts=6a50ad0c cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=MoCqpHF70WjPNMFBpltNPQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=ukklFZUiyCJfO1Kbj-UA:9 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDA4MSBTYWx0ZWRfX2fbCzZ49DGZ5
 IaQHxmx4uK41T7gnesLkhBTvF8PnusWeR36NAeUZ1H8YQ5sGZtYCwosgSiMn5COowxiigthDULC
 pds++1MT3YCQfUKIlt/JSJeGZ5eZm4Q=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_02,2026-07-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 impostorscore=0 suspectscore=0 adultscore=0
 malwarescore=0 phishscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607100081


On 7/10/2026 8:24 AM, Vishnu Reddy wrote:
> When validating a capture format, check_format() compares the requested
> pixel format against inst->fw_caps[BIT_DEPTH]. However, the bit depth
> capability is not available at this stage and it contains the default
> value of BIT_DEPTH_8. The actual bit depth is updated later after the
> firmware reports stream capabilities through read_input_subcr_params().
> Because of this, a valid client request of QC10C format request is
> rejected during the initial format negotiation. The driver then falls
> back to the default capture format (NV12) and stores it as capture format.
> Later, when the firmware reports that the stream is 10-bit, the driver
> sees NV12 as the selected capture format and switches to the default
> 10-bit format (P010). As a result, the original QC10C format requested
> by userspace is lost and QC10C decoding cannot work correctly.
> The bit depth information is not reliable during the initial format
> setup, so it should not be used to validate capture formats. Remove
> the bit-depth checks from check_format() and only verify that the
> requested pixel format is supported. This allows the format requested
> by userspace is handled correctly.
> 
> Fixes: 20c3ef4c7cae ("media: qcom: iris: vdec: update find_format to handle 8bit and 10bit formats")
> Cc:stable@vger.kernel.org
> Signed-off-by: Vishnu Reddy<busanna.reddy@oss.qualcomm.com>
> ---
>   drivers/media/platform/qcom/iris/iris_vdec.c | 10 ----------
>   1 file changed, 10 deletions(-)

Reviewed-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
