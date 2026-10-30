Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793350153;
	b=YMmjqwyB7BjeUG0gMIF1ey227UIJP4VynhvMrpZxW1qkNSthjPwhHwhHah0HPFExnxb6
	 l+N2j2LI7x2XZzV284hIH+3yHMTcwnFaF2xzqDJKaOQvhG2zGBKlauYuFFE8z8dOVRI93
	 FUvRIr/GGkuI68EB7+aLp969B01wyA54O/ROVcvhGniL/slpl5ho2rJh+ZBSolmnQGZXM
	 qvl9Jy9T6zhvpsX+TmWW1aMKSRd1fTl/Yz+GnB8tuOPc+rJg/O6vHUq1mxeJlTZzxowN3
	 8ZsUtz+5S9w6wla/5BHoQV9IYSAorWYFuvm0H8376lxMCdy9lw0qBuwIOQ6tg/6Nyaw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793350153;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=cbUUbzN0+cCtT/keBcmiPRae6tkWqWYqorJda4XW1pw=;
	b=Uv0keInrkW/6DNgccL1RQCeLr3It24m0jhHay8V3zBEvBhSSsvzLWp4/vir/nClFqrdr
	 QxmeU4d2aEEcgut5K/NIlzSaNDVjGzJNV/xPnh7SxR56X8eArBnoIIp+/yePPhu3Ombb2
	 UHTs74wHiL0IOkwWeuJIUc6mJxomTerRQa+XT6n57bQ9DFSONmOD355V6cZaArwmyV7oR
	 jYH2LxtM2B1Y8/3FkxIch5yKR/zABjMjAUo/H7SK2ZUMhCiXUntkzyjI4OR0GWtFGkSj8
	 Duz33NTaBJk9VQqknACB2mo2rGGxFZJ556jVJRwT4ChGx6cXzhQVLdzk8pf77OO9/hQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=TLz5zqHz;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=YKQnPGIg;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D441606A326
	for <stable@vger.kernel.org>; Fri, 30 Oct 2026 08:49:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2D441606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=TLz5zqHz;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=YKQnPGIg
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69U8FhBe3312061
	for <stable@vger.kernel.org>; Fri, 30 Oct 2026 08:49:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	cbUUbzN0+cCtT/keBcmiPRae6tkWqWYqorJda4XW1pw=; b=TLz5zqHzA7ZWNCgv
	0X4ObSt4y9gdflINLP7FvEwwrQvzw+UEEUZmiCqIVLAe2ByuN5lQ3Kq6WmGNRGN6
	QAmaAH4b9etrBGWfFjrc8CW/A1JrjTT0NNUDI+VrOjy9gq5hXIC7kc1fbhpY3E1j
	/Z6AjHMZGHjGcSiuvnuumia0cy8GN5Yiq7NI3tIHzVvFV/lnHvjYe/+z2UvurD6Q
	sexfC9K3jsZuiReCw8LjLGPLPYCerG+I2Z4rKdOlPvB23N7Vvh6XRUo6xGYB67ll
	peb7hOeoJbQxaf0K3rKJU+8WmRR8Oshibt9ZG2zxri9P2aW3BPad98hLUt0U9yNm
	rI1jIA==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hme6qt2ev-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 30 Oct 2026 08:49:10 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-91c6ea5aa1fso1446586d6.1
        for <stable@vger.kernel.org>; Fri, 30 Oct 2026 01:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793350150; x=1793954950; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cbUUbzN0+cCtT/keBcmiPRae6tkWqWYqorJda4XW1pw=;
        b=YKQnPGIg3B9XF16OOeO/8TU7SmK+jfEeZAx3vHh1zyH8cEuKScFgZNQ+U6+2O/FN4i
         /L360K9ARlHfZ8foBc1SFWqjDUAvAT5VtEN5DzbZGOpPB99JfmbHDpdCT+17DVQovSv/
         oNWI6rU3NRvqc0JJOt61ONiHEToxliG5mjZRfcqhyEY11AVAIgjNnHZyUg88jOZ4Qb5s
         /HjMBKbA57yGE8rCiTqOc0W9Sa14KF9DqzGCbQSkmY7dcp7wIWZPXGqneFrTBjbijnvj
         iPL7wqta2iPoRo9SfPAoAi5VSJUCheem1ekA24BmKgJ9WW8q+aRyKvemzKjU5yQYH5+c
         SugA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793350150; x=1793954950;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cbUUbzN0+cCtT/keBcmiPRae6tkWqWYqorJda4XW1pw=;
        b=n0/FSce9+7X6OM+aOn+8lUDvmGB44uCqqeG9vgQ02imP0hVBHbEE77hlHCl5NivJUx
         MDZZOFXQSkRDUL2/mmPCSI9wAQVHM3ugDvo6clzljMk/5P5MrlUEUohJudPmp1qdvm+W
         g/AnvhP2h+1om52mAQ5wKA1PN+2cJ8Qmoy9gs9/ujUaE896lsDH63Gi/f8iCPbSLAQS9
         I15JzIvqppS2kFg3Ltr3cEebbPU3YdX4zd5RqSDEBcz7cxpxOsH2uh7Euf09EZQFeDAI
         7oZifCW4EEcSjseJrUnw9u2atibudBkKDuVUWC8wU7++0Do/tFq3hSvR0aThVOV8cB+b
         5vUA==
X-Forwarded-Encrypted: i=1; AKwUvBzgmySRZD9sG/DJ6WxIbFYLQoaiGAwEjqmWUp+l2T8cqzzmO3QRMGfX9bwUxy6Ue7Z/zNLflSw=@vger.kernel.org
X-Gm-Message-State: AFq9FYIoLkR8SBzQ99eHb2FgfLCV7sXnzGt551/wejfiLkIhWdDEg9yq
	sbxOsS9UFrnrQ3FgRJNXjR/9yKIQFuhYriqXnZ1GBMN7TB7o/fjX6b4BZ8SMh9O7xa5+b596Mr4
	PqEYK4AsMkppWqYcNEGquFWqRkEskU4NeJ+YIMOH/YtMquOC9VmEFwtedz+0=
X-Gm-Gg: AYBFou0dM4im7rDQdZ1L0wun3fCbXre7RxHOvzEr8N2Gu+wLouw2tgDKQJ4I8mCBKR2
	RQzQR+ICypU9vV4539DuOlK2GzB//aPt+8gYSpRE4SSTSLQ6tkjU/ZWq5zjg774m2+mtErYFHe2
	fs2HXwVk/57EGn3f90/h/v/aW/r3Yel/4lyQI+iL/z6N9cqJ0f3MxjxaILLTTyh9n7OEBRhHMKz
	nP/TbeFasJrS0EB2yuxsBeuoCYgxvxhmtMAnBuxjs51m2FNalgIFWbI2FRZ76MXJCPtcj5pNanP
	0iuxMwvdumIQjEfrqiFtcFImym3kp7hv43jrQWoIGqWX0JvH+x4xmKlodAjnUa/os638MD6xrF7
	GC3z64J60nhkNCq1Y+CDHiVKXptxdOK6mYlT49hzyMoYCiT7SNxAVtAPNL+xzokP8rnyXpQ8=
X-Received: by 2002:a05:622a:e18f:10b0:534:7732:a141 with SMTP id d75a77b69052e-542b443eb72mr25306041cf.2.1793350150281;
        Fri, 30 Oct 2026 01:49:10 -0700 (PDT)
X-Received: by 2002:a05:622a:e18f:10b0:534:7732:a141 with SMTP id d75a77b69052e-542b443eb72mr25305731cf.2.1793350149640;
        Fri, 30 Oct 2026 01:49:09 -0700 (PDT)
Received: from [192.168.226.64] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b4d7a4eac5sm382210a12.5.2026.10.30.01.49.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Oct 2026 01:49:08 -0700 (PDT)
Message-ID: <36a18bbe-7a2c-422e-82ad-b9d1d87900bf@oss.qualcomm.com>
Date: Fri, 30 Oct 2026 09:49:05 +0100
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
Subject: Re: [PATCH] arm64: dts: qcom: msm8996-oneplus-common: Drop LVS2
 voltage constraints
To: webholt@gmail.com, Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20261029-op3t-lvs2-fix-v1-1-42ca9d992c20@gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261029-op3t-lvs2-fix-v1-1-42ca9d992c20@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 2XptHErJRGM4rYeHayY2uzaQ1Dq7RyX6
X-Proofpoint-ORIG-GUID: 2XptHErJRGM4rYeHayY2uzaQ1Dq7RyX6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDAzNCBTYWx0ZWRfX+MW4UPGUZorG
 jpQuI4eAJamABYzjeXGm5bPHHRPMtjEKaArTUmajB6WcBs57iyNDj1yjN732X6aX2ZYZocq8hTo
 Ku/1hex9nc5mbrvTC3Knk7GjEsEAtrhZUw+RizNQpFTrE3m1akWGWQ2jeMscVoGIKsC9azuGWok
 FZb50DYTeNBmu7t++c6PIceb7gzA6BFoh8GoXFKrw0m1pNd4CrGVOCjfJRRmX9HxmC8/F07VHQh
 KRR7mYwXVTkESz970AMh8wDlGWzsxg18RQKPE9wRMVEUGyBde+CWAsToCraHg0O2fnqVUHWzVoK
 jd9nHGHARGBFx8lea720alcLGCdxQVnk1tA+zzXIgv2KxeYlvuQoXpnINCSSllMkU3kHNA892SL
 5EoOqeqCS+20Vq+nsIDwhgGDNqlEJYcy0HjvjsQOVQs4evtGPGxv7WELJJu/0t8Iv6VcAQjwFMK
 3srDpFrJrCrPwuP9ENg==
X-Authority-Analysis: v=2.4 cv=dPgzC+Zb c=1 sm=1 tr=0 ts=6ae45a07 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=nlTkBPkjGgE2AyCPopkA:9
 a=QEXdDO2ut3YA:10 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDAzNCBTYWx0ZWRfXw4tx5APN37mu
 XT57xy10jn52KOTShroC97ECF6fXZjIF8YqahKW53q3ZkNtZOVxOKRd5wCf17q3Yojxa+eEfWe1
 ec81xYn+Vpe+8buqy5atZlBxpPYR+k4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 spamscore=0 malwarescore=0 clxscore=1015
 priorityscore=1501 lowpriorityscore=0 phishscore=0 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610300034

On 10/29/26 7:12 PM, Vladlen Grachev via B4 Relay wrote:
> From: Vladlen Grachev <webholt@gmail.com>
> 
> Since commit 27880745470a ("arm64: dts: qcom: msm8996-oneplus: Add SLPI
> VDD_PX"), OnePlus 3T no longer boots: the PM8994 RPM regulator device
> fails to probe, so UFS, USB and the display never come up and the phone
> hangs on the bootloader splash screen:
> 
>   lvs2: failed to get the current voltage: -EINVAL
>   qcom_rpm_smd_regulator remoteproc:glink-edge:rpm-requests:regulators:
>     lvs2: devm_regulator_register() failed, ret=-22
>   qcom_rpm_smd_regulator remoteproc:glink-edge:rpm-requests:regulators:
>     probe with driver qcom_rpm_smd_regulator failed with error -22
> 
> The switch LVS2 cannot report its voltage, so the regulator core asks
> its input supply, vdd_lvs1_2, which is not described on these
> boards. Checking the 1.8 V constraint then fails with -EINVAL, and the
> RPM regulator driver aborts the probe of all PM8994 regulators.
> 
> Drop the constraints, like apq8096-db820c, which describes LVS1/LVS2
> without them. Keep the node, so that the SLPI still gets its px-supply.
> 
> Describing vdd_lvs1_2-supply as S4, as done on other MSM8996 boards,
> would also work, but it would only serve the constraint, which has
> nothing to enforce on a switch.
> 
> Tested on OnePlus 3T with the msm8996-mainline kernel based on v6.19.5.
> 
> Fixes: 27880745470a ("arm64: dts: qcom: msm8996-oneplus: Add SLPI VDD_PX")
> Cc: stable@vger.kernel.org
> Signed-off-by: Vladlen Grachev <webholt@gmail.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
