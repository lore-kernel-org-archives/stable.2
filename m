Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9142D25E469
	for <stable@vger.kernel.org>; Mon, 14 Sep 2026 00:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789346734; cv=none; b=MJvkjDMnKCF3+iWC2v9a3AO5gJPMfNu+fcSwoDzoP7kUhzgGqoITzkThyqoirCxobmTEtrG+4WmGiPxE3HlNxSfwn9V2NyHscypFRbnAmpJsvxPZFDIDbfbQJRAzaY9EPP2dbJ7G99yLMDrULVgTZmoMxYjhBDzjTXDp3R91+T0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789346734; c=relaxed/simple;
	bh=XzMeoPZutr59xPBNvG3H53GR1/lgdd7UgAsCi8EaT4Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PFPQQyiFbJRvBGTiia7QVcPRGNf03EX2zXhexSFN2MFi84s59xfx/oXnMOesXhVfCyThmOyKPwRfS3eDMiO/6KPjJc+DA8LMmIRtc17eNjspi/rvAbKosy08SaHhr1ciTxrxO8o5X+42c2fG5wBaQTrM2KgYgL+p8/twadQxD98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pV4RbnyS; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Ctt9z5H+; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pV4RbnyS";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Ctt9z5H+"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68E06UnE3027104
	for <stable@vger.kernel.org>; Mon, 14 Sep 2026 00:45:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=m6cyjb8rvJgjpNHcKIGuyrR4
	K/63avLkOqM4IYNdfLc=; b=pV4RbnyS+ZKMb067rnZasHmxkw5OKRNsqUexRM0r
	gLmXg/DXevHf8mGodUB8QyzZnDZAl02+F11Egy56d6rdUCAAa9uUjkPH+V5cnMMD
	LpzwTrQPNMqLPQYuh3X/II0l1XNsoqDcONm/QPB5tnJcfUMSBD9zNkOFlMMXTJkw
	23U2BvVhNUfIWJNjRTDirs8izA22ZC8pLKGW9Jnc4evYRParlF1JMO6GOm50qzgk
	2pYq5r28xIWBLmOoKtkCVf8jnP2DS4IGYlYeUVfxcAgZYquIG9DtPRje95zrslnW
	ZXwtac6UuS5talmniY68gJZTDeGKbxay3bZDh8DMd9lR6w==
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com [209.85.217.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gmy9dcecj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 14 Sep 2026 00:45:31 +0000 (GMT)
Received: by mail-vs1-f72.google.com with SMTP id ada2fe7eead31-798c310ebb9so640921137.2
        for <stable@vger.kernel.org>; Sun, 13 Sep 2026 17:45:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789346731; x=1789951531; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=m6cyjb8rvJgjpNHcKIGuyrR4K/63avLkOqM4IYNdfLc=;
        b=Ctt9z5H+x0+oeG3ZlOrHQLCggskf8TUt8Dskvlg54+gTsQm5DhwzHwZbD2aZ6xkrio
         o5LSS4fl21OoOZByH0UMJ2b4ClzVGea2d+uBToqH9q67WKcNYrls01jboHsGvloVDNpV
         IQVnUY5Fz/5y7NeWOEfX2RUJodstXfB571My5LpQ0O+Vjq1G4esxaONDVyV2ZWYSiPaN
         hyqsUU8GQUIViIcsxwzWTNqR4Vb0sXs1QMbFK6UOKCD6ZPwJmkr90HEOzkIz26420xlR
         M7LjIVw9O7VhOUPbARdr5yHnB5Bz1r4v8qmJf2T9MW8GzZ739mfMO23tHCo1bdHO9N/h
         1xCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789346731; x=1789951531;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=m6cyjb8rvJgjpNHcKIGuyrR4K/63avLkOqM4IYNdfLc=;
        b=DF/Cl/MHeehjbXIzv3zv1B9RIO6FXpMiufXHxLxL5e1jvRIZhUo0+0m47NBGTixVzZ
         TKo5OpivqrFxKMJ9vYso0JdjWlQGOBEn3Li349LUN3jNcEz5IZqTxWYyXvYBng+e4iVo
         ggtTS1QtsPbqR+yza4k9PM4dDO5u9Wp6huZxXHqopf9I0UheptAbheCdnIC7ajZRFt+w
         S2XqdyXww0ajkEMh9YooPVuTpd7mJxpJ5oi7bFNcu58DuLEZGSD+VHvPPi6wZE8ErN3T
         q3IljjFpqYOSNUKQGFqvon9VditDojdJKVZSsyELUYedu08TKUoS2eIFd2x/Om/SMzhH
         L/EQ==
X-Forwarded-Encrypted: i=1; AKwUvBwYyVkXmNNJt9/ZcXEihyOblSfg1UjJZsttbT7FRv29Lz/aZI3iacK/jZ2cnTnOND/2X7EZtQc=@vger.kernel.org
X-Gm-Message-State: AFuF++kTewqEFFAkasKyyVydjyWiXcoVNifeCPy/HCCONsW7Fsl7JKfQ
	QRBHVXoP8fejiwERdmRc/UngPGco8BHYs7J7pdofndqjlUmDOirXaGIuWxU+2CXakz08huzFmCM
	5VmoYepi/18k48KfJqUJ5GXyNzuRxugSXSFUzq0V8FCudh4Z2GsVebSMZ5q8=
X-Gm-Gg: AYBFou07co9b4tq/O/cmhTxbaVaFahkZo3iRDMqPRLw9whBm6rIKAbRt/ZTs8e6yrOp
	zyizoBXijKNBa9uLM57qlsggmfPcfew0DNMz0raT7c8dlpZwybzEuY5K+BidwYRsyKYV+camEzE
	HZLNfXwZ/6w93n9quwZA0bm7wZV27bUFqMfM7CF0UeF3QKZFRrJryT7zDCgY7+AJIoK69C99uV+
	DfrrnLsGsg1j/8YTqnVjgESN1yqXPNc7emzd5Cqlt8pCXLHJMjFQjOL1Cv/u71XmT7yxgFGfiXb
	FXy4IgAQMDgi1Gjz7bPPPMcqekxprXfuRGvPvi3uYKzsH82filXkjompaTaCcDfQH4PjKBPsWxD
	7jthx787jBFv8tX/rxI3h7TMYr7CBDnGLbd10rTko88VriGGMhuw3dvJU/y9J8yUEKGqOoQxDkB
	czMkfGPOud283m
X-Received: by 2002:a05:6102:f09:b0:784:b882:9567 with SMTP id ada2fe7eead31-79b5838eb62mr114116137.6.1789346730823;
        Sun, 13 Sep 2026 17:45:30 -0700 (PDT)
X-Received: by 2002:a05:6102:f09:b0:784:b882:9567 with SMTP id ada2fe7eead31-79b5838eb62mr114008137.6.1789346725637;
        Sun, 13 Sep 2026 17:45:25 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b8a04795d2sm2093901e87.68.2026.09.13.17.45.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Sep 2026 17:45:23 -0700 (PDT)
Date: Mon, 14 Sep 2026 03:45:20 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Archit Taneja <architt@codeaurora.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        stable@vger.kernel.org, Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH v4 3/7] drm/msm/hdmi_bridge: Correct poweroff/audio
 cleanup order in post_disable
Message-ID: <uw3yo7jli2pv7byofdezzhklr62fegzsxdb4l6umq26nt72r6a@5cetzwxi7cvn>
References: <20260911-drm-msm-hdmi-fixes-before-eliza-v4-0-87bdb9f1987f@oss.qualcomm.com>
 <20260911-drm-msm-hdmi-fixes-before-eliza-v4-3-87bdb9f1987f@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260911-drm-msm-hdmi-fixes-before-eliza-v4-3-87bdb9f1987f@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE0MDAwNyBTYWx0ZWRfX0cPXAbuhUtaP
 /Yq/wRvlgZKu7nNRLS8yXACRfMe8IC1HDvXghPHB+726RdlLvqGt8xeV74mtxjCDoK/MX2dKvoy
 qP+NHV59dQd9q8UOHntfML+Qsw7YNd2UQLG11L78O4Mf+ppclmO2no1WcNF9NyLOAeBp+LFBYxo
 2Bg81DBkhRproR5QrzgHGaE23PXSL0CWRWUlo7zj+YQK0XknhpcuhMhlUfHuxhMBGrMqizkM8Ke
 OMm+klzmjVKOqhd3d711LgSYAo7U4yMQR0UU1GGTx6QwlJHYtsuBBmYxJRKrsEOYFuFW5+CdxX1
 r1fq0AqRqgMpwvWKE0RlubCQDqaTXFfqgEJpVe9rAV9sQIhUb+b7b946eI2d18R/uHGb9bYjzDD
 tVXvTJmgGyFu3jbU8uU/r2WwKCqS6nHszx52CecXe5qkXSXjS+atLrBkqa09QIK5hI3UGtHbvm3
 6K8M5J0hOv+p+NNMFUA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE0MDAwNyBTYWx0ZWRfX4xoXSLVFxvqx
 XvschIsZ8HBlGmPrGj9Ba5VCBNXsNykG6xZsOkZ5hWHd6xsyO/6Hq5LdBbTwQmmqI4ghf2UJJXQ
 kADWQbnNinanMBt1Katym2QinOI4rWk=
X-Proofpoint-GUID: WYUJ8guwv5AL0gyjbvrLlzfBMPCZpHnx
X-Authority-Analysis: v=2.4 cv=OeUNnRTY c=1 sm=1 tr=0 ts=6aa743ab cx=c_pps
 a=DUEm7b3gzWu7BqY5nP7+9g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=1VKk1TRdkn99K7eK9r0A:9 a=CjuIK1q_8ugA:10
 a=-aSRE8QhW-JAV6biHavz:22
X-Proofpoint-ORIG-GUID: WYUJ8guwv5AL0gyjbvrLlzfBMPCZpHnx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-13_08,2026-09-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 phishscore=0 bulkscore=0 spamscore=0
 priorityscore=1501 suspectscore=0 impostorscore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609140007

On Fri, Sep 11, 2026 at 12:29:36PM +0200, Krzysztof Kozlowski wrote:
> Turning off the power in msm_hdmi_bridge_atomic_post_disable() should
> follow reverse order of powering up, not only because it is logical, but
> also because msm_hdmi_audio_update() accesses registers thus block
> should still be powered on.
> 
> Depending on specific timing, existing code could have accesses to MMIO
> of powered off block.
> 
> Cc: stable@vger.kernel.org
> Fixes: c0c0d9eeeb8d ("drm/msm: hdmi audio support")
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/hdmi/hdmi_bridge.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
