Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1614C2D5C7A
	for <stable@vger.kernel.org>; Fri, 26 Jun 2026 15:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782487268; cv=none; b=UBgGruTaXehBAhfvPeLNo/Jet4IIH2HpGDhFcTm5PenRx0Qka9xohngG9Ty+CryZ5eO4D+959yFpjVgpHfrGUBEwM5jP19roB0/HSCuHhAguLDjpwi5oIt3TuunzOnSKWYs6hbrodkt2Xiy7e1+Wn7K3Ch40jExESn0YADFO7Qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782487268; c=relaxed/simple;
	bh=ltF69OA17UroLUHIyRP59/gUxyGuE4XTfNICw6WzzjA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c6C+TAwpWmx+1Bs7skBgGWUMjZP77/H5Bt8sdLBZuJFAb6YMRukxUiaBti6fVi4vWiM11lS/yrgfBoXUmPeJr+heHim3K6b3fBvyTYXGHhxcqnphF2VLSB91075dEWjy5x3jgwVnuBFuGeduPhHh5J4oMbaIfVs4vZowG5su/xE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YMyMKV93; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=XuFhQAuF; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YMyMKV93";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XuFhQAuF"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65QF3j1k1198321
	for <stable@vger.kernel.org>; Fri, 26 Jun 2026 15:21:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	xsLefAcDlircrvxuJgRyUJKceptb02A05dP+2K8RIh4=; b=YMyMKV93K5L61CUJ
	RnXS++4Q5kEcgoNkQq1IDRQKQV09BaAaHqQGbhtExVfiBH7V196vgY6y2iIJlLwZ
	Z+/wiev1EOWfH2XDF0k/sXh2qNKAlVm0sw/kq+Nt3Pos2SPq3deHEqwXmh2uZn11
	9jT8ccJp/ntRjCewDSdFtxRIxnL/Qh4VgwX0bSC8TzU5RtmKAbfuPnh7LPg3vOoo
	IGvnKv+jXqRezr10fc3y1nbr2mL+SdJpGcVritQc+w2apuLlTSYucaLcwRoSNbyY
	v7kVpkrHuVs9dU3j3Lgz/be0Lo2UccLKqpmeThJNTlvK7Frff0nTxVPLqEiWXRbi
	wNxCbQ==
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com [209.85.217.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f1t0qrhbk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 26 Jun 2026 15:21:05 +0000 (GMT)
Received: by mail-vs1-f69.google.com with SMTP id ada2fe7eead31-729420bc3c5so48210137.2
        for <stable@vger.kernel.org>; Fri, 26 Jun 2026 08:21:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782487264; x=1783092064; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xsLefAcDlircrvxuJgRyUJKceptb02A05dP+2K8RIh4=;
        b=XuFhQAuF8eAlWhY1uhqkkq4dAk1yi6mWGwquBdJEg/hJkfu2U3/Fe/sgVcB3VsITN6
         e/ImoP1Yse9CVN3VxcdtvpU1HOrpcMvmx/yF4MiZzmubxl6a1GR6CCrrSBB/CK1ZGtQt
         FU/Uk0n/U/wuH9De2theHaLImFr4XaBSvZ1hKT1OOcxatRGGFjqd8oihLAjUO8ZkNhZt
         F1l5x/wna1JAMZrtgwMCIX7Md1CAxyiZvRrIktkJjhQS8ELaFDnSp9afSnATZdxOVAHW
         q5qNlQ8ecoaC3IF8HxspSbev9RsN9rSYVqraAUm8g/4fF5GbZmje7BRyH3HvLBzhqHhx
         xWDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782487264; x=1783092064;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xsLefAcDlircrvxuJgRyUJKceptb02A05dP+2K8RIh4=;
        b=W7ySteKBMkR+xIg7vI0cJX4V8aoSNPl3NvuXbqm/FgSF8J0SnJ1o7aOJOVX0Y5xkyw
         lZ1RNT0CZ2Di1GzwiC9JpwYUI39xUwcd7QN0FbsZyj/i/gclNKxuxtIvcFMERkr7QvZH
         jSKfjxfJljGdCjFrg9/crY7bmTttX3mU8z9X+gy9zJAuQsmF+PJijmzL1cYcHJCH9pNC
         Nc10j2noMZODmo5zjWx7OkJYO/kth8IVp1clORSKBS3cMm0oTg1gUKkso1atT7Gj5WoL
         57pKpPhkD8DRUS36ProjqezY3/LMTgclVhv8REysfjYk6wfcDHHRBbyumsS1KOWBvEeh
         PKbg==
X-Forwarded-Encrypted: i=1; AHgh+Rq0xWQBxXcU5Cy6iUKDEzvnQLVxaColepUFPzpuW4IQ7Wme2ISNtrLlgdbnt0otMKxYXL071tg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8ZNA8EOsYN6btlksQ4w2CDZ5E4H4FBfuViSWKguo4cHBMz/Pt
	2SQhZj6VmjENoFQlbpqpVvVUu3TTeu7ZX2E7FxHPWQX2yq+zG7TEsJfANrw1Gqd89RxnQCEr/oi
	/OCZQ8Tq615TMIzGJhS2k0NCFmBTTGJYdvqKnJchPExpv1XkOsb8K1f1eupM=
X-Gm-Gg: AfdE7cm1ZyM5VUYa8JusgOds+w1/Fy0mjouFhM2/iIwcJ6Nu8JyalRmaiDi01iZyRUu
	qJR4Gzcd2Z96bkNTbqdOh30v6MehGmWYydgMVkPzOOywOTbnrhJfKVje0aZWpOYK+fybqx9NJ2M
	keeWKufhzMKbld671483CCXk+Ve1Zjm54pAUgolt0FC2YnEE1yV3qczf2MmEOQtb2reodRFMAUi
	QLUqBwRiANzUYNUDv6vNRVPTMwMGaaF1FLLhOhYtSVZWGRE1s2cFD3jvc+vBzA2WSC4IxwVBBRJ
	4d/urvsGjrGPWTkge9LDyIi5rTXXCYnFWrfqFLVWuEyLNli9jhJp4bdsOw2oSr9HqX2iJjoootQ
	A3/mxLi/y3aw7USF5R5L6tFW8QD2p0JCpclk=
X-Received: by 2002:a05:6102:cd3:b0:631:25ab:8bbe with SMTP id ada2fe7eead31-734366bedd7mr1212347137.5.1782487264313;
        Fri, 26 Jun 2026 08:21:04 -0700 (PDT)
X-Received: by 2002:a05:6102:cd3:b0:631:25ab:8bbe with SMTP id ada2fe7eead31-734366bedd7mr1212332137.5.1782487263890;
        Fri, 26 Jun 2026 08:21:03 -0700 (PDT)
Received: from [192.168.120.170] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5ad6957a7a6sm3475196e87.40.2026.06.26.08.21.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Jun 2026 08:21:03 -0700 (PDT)
Message-ID: <f07dce35-f807-48bd-a04d-76d69ae74f37@oss.qualcomm.com>
Date: Fri, 26 Jun 2026 17:21:00 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: qcom: sc8280xp: Fix DWC3 core register size
To: Xilin Wu <sophon@radxa.com>, Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        Krishna Kurapati <quic_kriskura@quicinc.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
References: <20260626-sc8280xp-fix-dwc3-reg-size-v1-1-ddcba897b19d@radxa.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260626-sc8280xp-fix-dwc3-reg-size-v1-1-ddcba897b19d@radxa.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI2MDEyNiBTYWx0ZWRfX18LsVRmEh5b2
 yeJ+JYdLAMXxH5Df2c7c9h/yxm4uB7VVp+A/sagu0FK7ioy/eRnsEHsSNxaI985zgG2+iFI3Q8/
 3nwl0qGLu4TaYEMIMbTPKUztAJ7icyw=
X-Proofpoint-GUID: 6fK1SnOi2l8yGjVfhwjz9R6ldCJCFgAB
X-Authority-Analysis: v=2.4 cv=StqgLvO0 c=1 sm=1 tr=0 ts=6a3e98e1 cx=c_pps
 a=5HAIKLe1ejAbszaTRHs9Ug==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=VwQbUJbxAAAA:8 a=ksxQWNrZAAAA:8 a=8AAO5B-9T0azXVr5E88A:9 a=QEXdDO2ut3YA:10
 a=gYDTvv6II1OnSo0itH1n:22 a=l7WU34MJF0Z5EO9KEJC3:22
X-Proofpoint-ORIG-GUID: 6fK1SnOi2l8yGjVfhwjz9R6ldCJCFgAB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI2MDEyNiBTYWx0ZWRfX7dwCOh2XFHbE
 lH9hs/oydlNT8tcMkilrHpBg3HuzCpIe1S84GiBBWeKxOy1fkm3/qbuVYC6nu83Ro20zLdhI39h
 14klF2oMUtnZht9wnEfw8D7qFDmhez4LWArCQmOzn84xV0H9sagBNI36BPa/xFiFHiALgt9x2mn
 rkd7TphwpYmP5k3kohd6xcvJwwPz49wP2B5UpNdR8RtQVZ78z+7zcBgDPWVPVkphYEVxKsanUsD
 8/Muk7cwkzfIFwM58dkLdN6ry0NDiuGucCC/JM57nM33Aonc4j9v23eZ+ofsUs5dClwj3S7m+AW
 /0D3kIOF2wxCVF9mtA6TqJCWQR3vZwYJz+PF1qQFUnRS1R46jKpumn5CbHR3yBIuNNHvw/g5b/V
 dv4e80gh2zQ76MM6uQc+zf8cQI6Zq6rooNU9gUPw7q9+USZEenJyagGsvQ7hN6ZFb/g1RUs6j83
 UOqYElXR18ezSi/K0HQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-26_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 impostorscore=0 spamscore=0
 priorityscore=1501 malwarescore=0 suspectscore=0 phishscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606260126

On 6/26/26 5:07 PM, Xilin Wu wrote:
> The SC8280XP DWC3 core register regions are currently described as 0xcd00
> bytes, but the hardware register block extends further. In particular, the
> DWC_usb31 LLUCTL registers start at 0xd024 and are accessed by the DWC3
> driver when a controller is limited to SuperSpeed using
> maximum-speed = "super-speed".
> 
> With the shorter resource, probing such a controller can fault when the
> driver programs LLUCTL.FORCE_GEN1. Use the correct 0xd950-byte register
> size for all SC8280XP DWC3 core instances.
> 
> Fixes: 152d1faf1e2f ("arm64: dts: qcom: add SC8280XP platform")
> Fixes: 3170a2c906c6 ("arm64: dts: qcom: sc8280xp: Add USB DWC3 Multiport controller")
> Cc: stable@vger.kernel.org
> Signed-off-by: Xilin Wu <sophon@radxa.com>
> ---
>  arch/arm64/boot/dts/qcom/sc8280xp.dtsi | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> index a2bd6b10e475..d06f79b7680c 100644
> --- a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> @@ -4034,7 +4034,7 @@ usb_2: usb@a4f8800 {
>  
>  			usb_2_dwc3: usb@a400000 {
>  				compatible = "snps,dwc3";
> -				reg = <0 0x0a400000 0 0xcd00>;
> +				reg = <0 0x0a400000 0 0xd950>;

Let's do 0xfc100, the QC glue driver already does out-of-bounds
accesses into the base+0xfxxx space..

Konrad
