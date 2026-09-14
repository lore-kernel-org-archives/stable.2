Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAFD117A314
	for <stable@vger.kernel.org>; Mon, 14 Sep 2026 00:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789345612; cv=none; b=jsScbQ6nVB+oh/VY/N7sYCJTd8xYemQfK9vwj7Ig8OjKW2K9KbiP+R+ltmVAgolOcAQNLOvJaIhY0Q6Mxe9Cp1UBiN1iyb426Gh6vMVsbtbku07JlrViy8nphMNFO33eWIP7pO9YhWFy0MfOR455mdiqJZaSAdLeb68H6XAGqgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789345612; c=relaxed/simple;
	bh=j3pqj6wX2Y9j33bl/gZCdlghWUqkVbHEl14PKZ2w38I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IkgO18DhfTNYdWNUc3pmEEDXwNeHdPEPSrETNiLzFqm1HHW26RrQtxjv5TkpF6VwR3BsJspOPqcnySbQP0pNtLGKd8Cx+ppUy0EOfcCLrLJTsGFdH5axVrTb2qsRj1zePCErIZNaY4spkGY3O5mNlcBw7/eWLqsN6nMYhdcLptQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=AEH7RHt3; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ZJ8mzZmA; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="AEH7RHt3";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZJ8mzZmA"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68E06OQ42660946
	for <stable@vger.kernel.org>; Mon, 14 Sep 2026 00:26:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=fhHkV5ZH2IWbRWw4FpuzKYxl
	rQHT67Pv+hyugolUmOE=; b=AEH7RHt392v0JFqubQvGMbrb+Bdmsxhn89rvkWl0
	jV1+rcG9FMUUK8myYDDs19gnBQTjqNkkfjy47SYrGHSagk1R0CWqYaxZUHMXQroN
	qRQ7VdIVuVtZBKbVVkXfQwAr031KTzjdMr8oqF7oFRUt2gRCQl8CuHnKG2tf7/jT
	lf/CHAp89RGIyZ2EvXf4BPUqF8uKqVRBW0GlR9FXwEEuQx60nUdEVX9j7Eut3aOT
	IVSyWzCjHOy8JZLJbIo22hcOKTtHzZOUBJ7fBQfwSjATyv1K3FPsil+UP7oAumaS
	pSVeP23W+iMraoWttGxSSn7gHUGXao0LDZWGtsuvVI4z9A==
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com [209.85.217.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gmygd4f3e-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 14 Sep 2026 00:26:49 +0000 (GMT)
Received: by mail-vs1-f69.google.com with SMTP id ada2fe7eead31-78a58df134aso489196137.2
        for <stable@vger.kernel.org>; Sun, 13 Sep 2026 17:26:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789345609; x=1789950409; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=fhHkV5ZH2IWbRWw4FpuzKYxlrQHT67Pv+hyugolUmOE=;
        b=ZJ8mzZmA3pB8ZMzjOruYdEW6IeqsxKDcyQZlQ+ZJPmabLbot130xITRyeRXwmMBZDi
         iLXkPAVC0DdM2s+Zg3M19j53EA5OBDYDXcF8XIWcD/WNm8lb778znoindYe5fHVSFjRD
         F01UIFSiorRx2FFqvsUFsecOYeqvlgVvcgMUooxHqvXcRtNyvq4X/ynd0qbtTxkQ2Qp+
         AY8HS/GNz1cDz69VuDxCF+rzNCKUHIOG56tnXkifH87selFmF7FQ+Cydn4rmHQ8QRczk
         KSG11f2Q3ly9ARfAdp7pGe07QoipbqgaJZH9Ee/kIkyDdAw1igz6Iw/kuYn+w3x8z9LG
         UB9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789345609; x=1789950409;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fhHkV5ZH2IWbRWw4FpuzKYxlrQHT67Pv+hyugolUmOE=;
        b=CnxzaKxCbVtVBHmNgXtrNV4fbh20u+xfxU72xdigLaSD9dZHIJNPCxHNytxoi/aXcb
         RR0n4UpABiJrq6oJtooUlHclLWXELfpRpDXKG+zt/ALIlf0YmoI2//saj1PbGIyEvPbT
         ebYw4liYQaqS821gzdcan5nEAb4Z65AMgkH+QP1bFBZEFu+VHmQcsGYuAPrr8hzOZOyA
         pjbCFOrsps6IvtD4fEiFfE5rktCVmvZnPZQf8sfVhd18SHwKiJsuOe05SuOKRkvaC3L6
         Oj7O7qVKOJ2ccnAianXJC1THqf8kD/vmsxdbNQNzmugI0PaVFGtzze0XqJ1w02yeb/Ge
         d0HA==
X-Forwarded-Encrypted: i=1; AKwUvBy2nGrNmYObjrB/5xxQGbthOCCwQKnCH5JTT4naBIpy0/nyLOdOioh7zru7EYi+RLH6zqk0VdQ=@vger.kernel.org
X-Gm-Message-State: AFuF++kSr4kVotmxd3E/E2SM8UjsOMkp/RB4HmIPEHUQrZ7kgnmxPhpN
	+wVpuD8n8VIpTpRWUce0L7akwp7mFulEKfCD/xeWjulYWCNVxhes/VNpSw1rFqePRiyPT0NmII/
	eW6Rvd0HMuLMtDDJwKYEpCXYhUXkxZrG8DOVB59+3+TQdcCGKm6JYqa9TuLY=
X-Gm-Gg: AYBFou0S1kNDo9GXWEYuxOm2TmVQntrrF2u4Ky2aQGYKP+kWTboFaVOIbdF/9xMWmUI
	klVQSw2UgWW6JF7riAA4ZoJMslI5OKvMpVv2dRef682uPvzAXyaa0YRhXAqY3CWGPMn1q3pzgkF
	EujPkM/v+Sj6FbjTJQsBiKA9jmuzenupzBoQaPhzmTZm5mOFOzx48SnRsOetclNH+TnV2NFq+b7
	3aSAXG9Xglyqv/lHyH36gM8gY+1baGbCZx853mmOLlmp6rUuye8D4AYe+liKq76zR1fDhYFBs1G
	eGRAtGu4ysdUTB63xJXU3p3SeQZauYZ7blVYnzIMxEbo8/Tl3icXOsDjZSweW4GdglbKueg5dCj
	aTDdYWvt3G1Emk33hlqdh8ooa43fp/ECQ3FvgtAQ7dBW0x62P8TlV514D+rTWXvheY/YYXxgjrn
	TFB1QoEKt+GXrh
X-Received: by 2002:a05:6102:b0f:b0:785:c39b:6a1 with SMTP id ada2fe7eead31-79b5d8a21afmr86434137.6.1789345608904;
        Sun, 13 Sep 2026 17:26:48 -0700 (PDT)
X-Received: by 2002:a05:6102:b0f:b0:785:c39b:6a1 with SMTP id ada2fe7eead31-79b5d8a21afmr86411137.6.1789345608432;
        Sun, 13 Sep 2026 17:26:48 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b8a0456644sm2091675e87.18.2026.09.13.17.26.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Sep 2026 17:26:45 -0700 (PDT)
Date: Mon, 14 Sep 2026 03:26:43 +0300
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
        stable@vger.kernel.org
Subject: Re: [PATCH v4 1/7] drm/msm/hdmi_phy: Cleanup after
 msm_hdmi_phy_resource_enable() failure
Message-ID: <zfytnhu7vipotsoztncetoffnlzkw62vz2scuoogieol6et7ro@io7nslu5sdho>
References: <20260911-drm-msm-hdmi-fixes-before-eliza-v4-0-87bdb9f1987f@oss.qualcomm.com>
 <20260911-drm-msm-hdmi-fixes-before-eliza-v4-1-87bdb9f1987f@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260911-drm-msm-hdmi-fixes-before-eliza-v4-1-87bdb9f1987f@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=RY0FmFtv c=1 sm=1 tr=0 ts=6aa73f4a cx=c_pps
 a=5HAIKLe1ejAbszaTRHs9Ug==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=dCp4QOuT8fr3gmi_UlEA:9 a=CjuIK1q_8ugA:10
 a=gYDTvv6II1OnSo0itH1n:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE0MDAwNSBTYWx0ZWRfX+1tCu6MbNfV5
 uwSkftnfg0DmaLh1qeaOUhMsiObuP8vNRp41RvKWUoddvbGpeZJaUl6BFMCdC651ioLBuKiKQAA
 S9cZ4H7s6O2+7bzwr+4spU3GTQpOwdXM8WPGEF/QJ+hdbR1AHJIIIXhT3PXoOm5+SjNgyf10OE8
 /fdypWf33D0D80OuhcLdBiIJbT9KHzXPmDM/73TXBCU55AkavaCTMh4DfaZl1nQWKIrxIawL/0M
 TsRjfwg5NpB87drwAIeU1SCGvbH+0IBNzGpyi0eoFX1NHxvszqlnr45EwJXDxxgT3/JavTy/4OH
 R7FG/FDUWifnrZSOYOUbnsgr8S0YlnINvwgDpr6p06c39PvF4L9MwOUQIkQfaqB08AUmzgqLFQc
 MF6ZGtzsUtTTxMD/xOTmQdlhKU9gGqNGo31L9VmTMtb/Xlzhui27wEAZaKWahOj/gaJUdNWSJUc
 oY9LyLwZ9vPLIQHcb9Q==
X-Proofpoint-ORIG-GUID: oRHs1GIXx8ZNEwesxp6KandJiYzluDAn
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE0MDAwNSBTYWx0ZWRfX8P20l6W14Jye
 caU4ioFoaT/dEWgtIRugwVXfJwSKQsOsx4DAjVA+86i8AhNSEOrWDOemE1Ej4Y6lY7LUXJQcxfG
 ExKURfFJHpJ2o3jZ3kArS2NG+4ejM6E=
X-Proofpoint-GUID: oRHs1GIXx8ZNEwesxp6KandJiYzluDAn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-13_08,2026-09-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 spamscore=0 suspectscore=0
 lowpriorityscore=0 impostorscore=0 phishscore=0 malwarescore=0 bulkscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609140005

On Fri, Sep 11, 2026 at 12:29:34PM +0200, Krzysztof Kozlowski wrote:
> If msm_hdmi_phy_resource_enable() fails, e.g. when enabling regulators,
> it should reverse the state of things already changed.
> msm_hdmi_phy_resource_enable() is used also in probe path, thus such
> failure, which could be simple deferred probe, would leave these

There can be no -EPROBE_DEFER in the middle of the
msm_hdmi_phy_resource_enable().

> resources permanently enabled for the rest of the runtime.
> 
> Cc: <stable@vger.kernel.org>
> Fixes: 15b4a4523859 ("drm/msm/hdmi: Create a separate HDMI PHY driver")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/hdmi/hdmi_phy.c | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/hdmi/hdmi_phy.c b/drivers/gpu/drm/msm/hdmi/hdmi_phy.c
> index eb1088755cb3..15e37596bdb1 100644
> --- a/drivers/gpu/drm/msm/hdmi/hdmi_phy.c
> +++ b/drivers/gpu/drm/msm/hdmi/hdmi_phy.c
> @@ -67,16 +67,28 @@ int msm_hdmi_phy_resource_enable(struct hdmi_phy *phy)
>  	ret = regulator_bulk_enable(cfg->num_regs, phy->regs);
>  	if (ret) {
>  		DRM_DEV_ERROR(dev, "failed to enable regulators: (%d)\n", ret);
> -		return ret;
> +		goto err_pm_put;
>  	}
>  
>  	for (i = 0; i < cfg->num_clks; i++) {
>  		ret = clk_prepare_enable(phy->clks[i]);
> -		if (ret)
> +		if (ret) {
>  			DRM_DEV_ERROR(dev, "failed to enable clock: %s (%d)\n",
>  				cfg->clk_names[i], ret);
> +			goto err_clk_unprepare;
> +		}
>  	}
>  
> +	return 0;
> +
> +err_clk_unprepare:
> +	for (; i > 0; i--)
> +		clk_disable_unprepare(phy->clks[i - 1]);
> +	regulator_bulk_disable(cfg->num_regs, phy->regs);
> +
> +err_pm_put:
> +	pm_runtime_put_sync(dev);
> +
>  	return ret;
>  }
>  
> 
> -- 
> 2.53.0
> 

-- 
With best wishes
Dmitry
