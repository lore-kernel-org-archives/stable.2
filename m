Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793866437;
	b=0WjAy8mO0cAPkxXcrW53oCdaZh1grXWv9tmKCYHbaPJk/p+hBsX5Ls8wlG2Eq72RIP5I
	 TZcz6iQNYDJULMgp//ZjFU1h8u/CV8tPSIYnSsY2301IcYsTzc3Hc+H8+SyAiH9gR1fCs
	 DzGvSwiv6hY6fBJoVRV/LLXP9rn125tKgw87NpydIKGZNiX9sefPo1rwNTJNZSZb5xfuo
	 yguJm3EEqKV8n6qDEFATldjZHqpZOJPwmh2nT8Le+1r8BnsPpbpi/9YL0api/vOt06N3k
	 pjKVvr/IS2dwnYFjYb+WIYktUWP98W8j1UoeQPmh/1jXDJLz7zQLCv3PL9K6oUUVTJA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793866437;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=92R01FMCRyJRd7lrWUUeliuFDksWX3spjItrLc/CiMU=;
	b=ZpHI/DGwhguOBG9F+fSvRxptZWfJcgOa1X8Hs8VFrBVsHSwt+OQZeo0y6P706kjMizcg
	 VMr6n/XPz8ETwR4qXWdkLWdqc8hkqlcMk0BL2IifkCb7JcJAwJ2vtplCM/gCcG5KiCt1j
	 L0mVb4w2aUgI53xQmD/Zk2/7HqbtfUSHIHUi7Snn7siV/X4EsQf5IfCPSIWVoSu62ajmj
	 Xn2r98eFu+4V/X8s99kdJhLM8viFDpb62X9iiKP+ITxotoEI1ilxLb1ud7+rpPIfG3ak3
	 ySn11WQAdySaGGNvmZJoJB68XJT2fNqOzt/r4lhD0laRZBC74GhSfn1eNAzZGMxW+hQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Zsj4yhUx;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=NCiP47kF;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29E08606A328
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 08:13:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 29E08606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Zsj4yhUx;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=NCiP47kF
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A56UZEO595348
	for <stable@vger.kernel.org>; Thu, 5 Nov 2026 08:13:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	92R01FMCRyJRd7lrWUUeliuFDksWX3spjItrLc/CiMU=; b=Zsj4yhUx3fB/7g43
	z5tJ9j1Dzf287bjQpuykmLSzBhhTUd+JO/SkwgbnukQ0jnwK39P5Cal5up5XDRDN
	VDyGL/IW+17MiJvu5RzUND4cEPuMDaXcPjYBhFFz/dx0bpWY3p8rkPFpb7u6WvyE
	Yf0DrV5WcabBL2O783wpDsKfdY1JFhxbjc+4KhHbCg91ihfQlHP6heqbekB9Sewm
	bdWTk6yUAkKDqV2MuX7rbYZPTSFrZH7qBOn3IVjRtu/12/wCzDP05E1rehyogCGt
	7D6N/6Li8wzFjbEcNOnBjQ6+VSgvntwg+UJC5UEy2FTO2H+pmbvBbR3Utv9lCo7E
	d/+qlw==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hr8rv3dc5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 05 Nov 2026 08:13:55 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-91e83d614c8so2301406d6.2
        for <stable@vger.kernel.org>; Thu, 05 Nov 2026 00:13:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793866434; x=1794471234; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=92R01FMCRyJRd7lrWUUeliuFDksWX3spjItrLc/CiMU=;
        b=NCiP47kFHd2kcmF2wOTQ0+GW5EXh542X7cgv3tKjvJNmfj+tgqdfhlVUq9VOI5pMZH
         j5mTXh6P6nNA6LgOWMht7icM+pp+5A6cXBCBfCQfiAxqikGPI+k/tPK9gN3TxNBZWOwI
         m1s8uEb1bDWiD1LoZIqdOxLS27T9iUVZKrNwMTKg/Gp5hlqe6OkeiVkpojotp9WL5Pfd
         KiEeDpR2t9rn7rj3UwEPhm6evOKE0WRgJWNhA0Fi9DoTywbKUkoVtiUJnD4lCBplpEeq
         o7vKpEX0ZPyPZVNTUKoy5GkPrHgYMu/u5I1Zkr/RaTcYm+Gif+ELC3C03bLof6GeinqU
         W0iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793866434; x=1794471234;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=92R01FMCRyJRd7lrWUUeliuFDksWX3spjItrLc/CiMU=;
        b=Vq1WiV6OWypHeOfDmZblxQPi/f3qM/f1krY0/IhOZIZRXTM0cgaJxtHa+n9Vvs58Np
         9xPnEzobgxbVuiFITlnZISsfU/bKOaUD3ImAjk3wndm/Vh/5Y+gAdXPpKccw5j5Ov4Ip
         jo6mocQ2gjc1GE+7RMqQHzJGPp4RrC39dhthWildeKUzYKgw31zJGfywjiDIrTdXpHiP
         TUVqbWoEV1RZXy98LirqN+DP/Dxi8usoKoIzurv8nlP0hAhayD98GGq4k6ecLc9bxy1z
         KbdloOfyfiKPVogtuqzXpETKByTbtMMdozRWq7akzD9rn4wq72voWq96DJ9VKoKjqUSB
         pv7g==
X-Gm-Message-State: APuU4Z/KRO4doEI2EadxhGu9yzRr313bH04OgwvqIYCaW0DzpRUSxtdx
	wzZrLfdc/oCccayK9bohpTxEP5RyiHFC2WFbm+Vhtr+awmUljYzd5+bI2sk8o25nakznjzlsU6o
	LFv9WIP2y5qlsacn4mv1cV1+qqVsffh6Q1w6ZCiWHCHMCweU8pKUvI1R1EGI=
X-Gm-Gg: AYBFou2b8guRdpslEX7hvMwXEmRO89VohXnGds/u7ol+2Erz+4mV3JSE5oxYhBiYdjN
	AoKwR45VTpmv+R4BvOzdJuhKLeveZ/dF5vf8KcphaQNPFqGcW0UhkZeP5Ki6/KYKezVX+XCyt63
	X2+XV8lS3TzGo7tG9jsY3rivf9fCjipm8oBVWGw4Bmjm6PpizwJPsp97Jx04SyzEGlVLuslx8rj
	NDURgNVeRVUcZDWhyCqQYRVr5pnSg1+h5KvJZig2W4OSqVh+TbqfwDwdFHahgmJgUs+dkWZ2PoK
	Pn1pbrgC1vRd8KkQ5gol1oYB7rUme/D2Vx86bXLCwe2C437j3WhY4JqSp9Bcs5rYLLLeylEg2dO
	CNgA7658L95Srv1WJJCbFpPQ8wAlux7Yt/pRCzssn6Lb/K42pJho7BBLDNLCjv5iSkwlo
X-Received: by 2002:a05:6214:1943:b0:914:4464:41c4 with SMTP id 6a1803df08f44-91ca4b23661mr390679796d6.4.1793866434395;
        Thu, 05 Nov 2026 00:13:54 -0800 (PST)
X-Received: by 2002:a05:6214:1943:b0:914:4464:41c4 with SMTP id 6a1803df08f44-91ca4b23661mr390679386d6.4.1793866433953;
        Thu, 05 Nov 2026 00:13:53 -0800 (PST)
Received: from [192.168.226.1] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c4d0e42479dsm150842066b.17.2026.11.05.00.13.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Nov 2026 00:13:52 -0800 (PST)
Message-ID: <50bb3200-3110-4739-8a15-173bdfb8c220@oss.qualcomm.com>
Date: Thu, 5 Nov 2026 09:13:50 +0100
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
Subject: Re: [PATCH 4/6] backlight: qcom-wled: Manage teardown via devres and
 remove wled_remove()
To: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>,
        Bjorn Andersson <andersson@kernel.org>,
        Kiran Gunda
 <quic_kgunda@quicinc.com>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org, David Heidelberg <david@ixit.cz>
References: <20261104183935.1214630-1-lee@kernel.org>
 <20261104183935.1214630-5-lee@kernel.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261104183935.1214630-5-lee@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=Vtm2kO2n c=1 sm=1 tr=0 ts=6aec3ac3 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=c92rfblmAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=qHjM3Cc90Y4xjM8bFJQA:9
 a=QEXdDO2ut3YA:10 a=iYH6xdkBrDN1Jqds4HTS:22 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA1MDAzMiBTYWx0ZWRfX+zpmbOzFjUc3
 uSVNrkV2TfuFuQJjl3Oe53iE9KPizfkFZyT7AVbCo/r3PMuh1iA0KmrWUMwb+462SAs3OLfvONc
 VFOUrkzlM3HfffA47ulKUtjlbAdG8Qw=
X-Proofpoint-ORIG-GUID: AMIR1hLOHKEcohrq6yoEsrtorxUskLPU
X-Proofpoint-GUID: AMIR1hLOHKEcohrq6yoEsrtorxUskLPU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA1MDAzMiBTYWx0ZWRfX0lShUs3frCq2
 ubMPSV1zIZGq/iXM+jksxRCjSJLjKjU/aWvXJOTz9nppO15ugih0+F+rDZKN9DzBsi4BRIM1+kS
 nCYeBvpJwizjSfKw1nH34PaJASZTFh5FJ7BTDHUx+ERwOjo0r0vsEd446yN/EUuxJm0SOi3Yr8E
 hmD2h2wwE9rX9cnHhbvx10SSfiXNk2glO2EO3x0c2+Gi74o3LFmWRUQxuZEgG6JuQxjq9oEyebB
 f6aDL677FvNRCJlh7KrZXZqzhN/aphLbSt0aNiG13DvNtq4au+EePBEGynnR78depDsRa8b23uG
 FgJJVVxaRbG77D9UGaDOOdlLJLnrQAYH06rzW201gRYeQMgJrQBDnkTwMxnNOX8jesSkXx7oDlx
 RN45gMfw8hdGAahpISvUlBOBNfTs1LfHyRzFJAWLH8SE0bi6E246ALzD46/fcMXzfYM+ZgscZnU
 wkrKcAnjAuaUArQ441g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-05_02,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 spamscore=0 suspectscore=0 malwarescore=0
 phishscore=0 lowpriorityscore=0 priorityscore=1501 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611050032

On 11/4/26 7:39 PM, Lee Jones wrote:
> wled_remove() currently runs before devres tears down the backlight
> device and threaded interrupts, resulting in two teardown bugs:
> 
> 1. mutex_destroy(&wled->lock) and cancel_delayed_work_sync(&wled->ovp_work)
>    execute while the backlight device registered via
>    devm_backlight_device_register() and the short interrupt requested
>    via devm_request_threaded_irq() are still active.  A concurrent sysfs
>    brightness update or short interrupt during unbind can acquire the
>    destroyed mutex and re-schedule wled->ovp_work before devres frees
>    the wled structure.
> 
> 2. disable_irq(wled->short_irq) and disable_irq(wled->ovp_irq) are
>    called unconditionally even when the optional "short" or "ovp"
>    interrupts are absent from the Device Tree (-ENXIO) or unused (0 on
>    WLED3), passing invalid IRQ numbers to disable_irq(), despite both
>    interrupts already being managed by devm_request_threaded_irq().
> 
> Initialise wled->lock with devm_mutex_init() and remove wled_remove()
> so that devres tears down the backlight device, short interrupt,
> delayed work, OVP interrupt, mutex, and driver data in reverse
> registration order.
> 
> Fixes: feeab87b3072 ("backlight: qcom-wled: Add support for short circuit handling")
> Fixes: 8663c188beea ("backlight: qcom-wled: Add auto string detection logic")
> Closes: https://sashiko.dev/#/bug/linux-51cd5e35-3cae-4e4c-986b-7261263507cd
> Closes: https://sashiko.dev/#/bug/linux-44e5ed80-c35c-4786-8bf8-9ee955967d0b
> Cc: stable@vger.kernel.org
> Signed-off-by: Lee Jones <lee@kernel.org>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
