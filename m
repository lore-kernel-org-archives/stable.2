Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A475F37CD33
	for <stable@vger.kernel.org>; Thu,  4 Jun 2026 04:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780548648; cv=none; b=WQLE2z/G6aDni1PZAsvM+9NUCT3rvhEvy6KI3+p0zmp2OMm7QrzDzEK3CNB6PCge6vskeeGFVw+04rihfuKpmWyE9R99sTYlmvJxnjahN5L0Bx6ijf02B06hAgzwJVSXQC8hq1iAXI6ZMfoYttlsbezivDjan8Qts4Er/YUCHOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780548648; c=relaxed/simple;
	bh=Wph+A2Eh0fRuUr8JeVccG39Urowhu5aGUrpMaWqUJ3M=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=kcZrsEjlKEyKKCcwDOwoQPooGSExD7guwT8zV3Iyh1m1W0go0dbPDC8O1due0uu0Sabl8FB9PbykVPlGo3/b41bSVf6XA/+VsliB26qqTJu43+iXRTnqSxXVtgr69rS1nwEYdt1itAln+bXXoz7KcTbonihJN8mHG4SoGChuUsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZXaoURqK; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=CS2Dlub5; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZXaoURqK";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="CS2Dlub5"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6540ntqa313666
	for <stable@vger.kernel.org>; Thu, 4 Jun 2026 04:50:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ESIghRZ2Q2Bdn6SkUB0gmkzzf5Jlh6Iv1X/YZJpA+ic=; b=ZXaoURqK9zJLktZ3
	ydE4bC2TKh7+eYCMg2gry3RyCa3cYUZ3v/s0LzZrtLNvBPKLo87FeIOUoYiAD/Hi
	i77lAVMck0KAnhI1tQR0h0eprXAIj/LuxB/mpIpObmNLpcuYhhoLGQOHAHxdmls+
	Uh4dIugxKi3MxLmjloPLbexXZP5Wtcclw8EaT2M1LDNn7P1TKtFHzzbLdiC0P98l
	KNATlkbrXr2VUA7c4tfsVB5Wae0voXfpUrWrtDPSbDUXjpQXn85fGZr6lK3TFSeQ
	cWpJrDyGnL0Hk52Byc7F2rbXR5FfZiMFApKcpnSZWebLhjaGIp0WVQf3so/DOkhy
	ZOfAWg==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ejy5v0pnc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 04 Jun 2026 04:50:45 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-8423f1fe39eso361851b3a.1
        for <stable@vger.kernel.org>; Wed, 03 Jun 2026 21:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780548644; x=1781153444; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ESIghRZ2Q2Bdn6SkUB0gmkzzf5Jlh6Iv1X/YZJpA+ic=;
        b=CS2Dlub5of2k5MMhSbL1FX8cM7ZyxAvbWWxQ/wWs/+Aa5isf3uDc5Jliv1DR98FK2X
         vHuH3EcKTcC7KMewnSBCX1KJr9d/cSa8M9Enbl4zfU36xpvEQ0v1LXyVyXB1jxXnjUEC
         6j0atYyCl9O0/eia8DSxnAMbz3IbhvaudzjD0et58SknSnlBxPOF/u2NraaD0AzCAZvZ
         9ZdHuV5NMbA5XAoPjmZqU6XZJS2EtFDmxCCe+GSx22/tZ8zFdk6JlI1QVAiWWaQ+bkuY
         eRiZ/tqH0AuNjAdZTuCiraREngjcOpd3gH/Gn+RtqeCT6ZmdPrnChsLqiQ2Ef5Okf/AL
         lMJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780548644; x=1781153444;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ESIghRZ2Q2Bdn6SkUB0gmkzzf5Jlh6Iv1X/YZJpA+ic=;
        b=ekPLlGQZwziqKwhZNbDJEGpoCEZufzHuLOoVS+r4K+wrwYnB3YhARENsNo+z5lasBA
         7WvDpXSeioXR23KNgGxq89Vl+to8REeWJLKveLFMUNksl+zxRIHIkQwaognPAlMuycUv
         kV3L3k9AH5boOXlH19mAN+TImDJ6xUys/s0v+Zzmq3S4lEFcl8a2K5sAK/zLdg2wZTIE
         LnZ/b0KUJqowOR/Pn+od8+LGSuoSp8kLj1Lw59U3xLDx+4QGq92FLDKTYtBe9w3qYVQl
         j/OT5NhvLe/1RWX1tGCwNrwELUwwciAMsE0IzLpa8wOKISmbRIc6WsO4aqr3TDnIwZXB
         Xhnw==
X-Forwarded-Encrypted: i=1; AFNElJ+NZOlmmlTNnVVmTXe9X7ZlbGQfTER8GkqTdG+hmA9egSytszawWHyMj6dYeBZrLfbtJhx8OBs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfQKNP0eU8PPM8Gcy2dbSF43bqmH+BDpiBpi2ZJkoiye0hMFxo
	cLziDUl5wiRGlJrmOTqvta98umIcr0hkgw8LjXyKscASok1tC9W0z/cfQVvxgdm0paSudOCYLjZ
	UyrYnmdR9LLnm3gn6dUVkPssrd3sNY2zArowychKuVUDJApUmoZQCIXS8utkJbULPmdk=
X-Gm-Gg: Acq92OEMDHiWTHsnLNAhU5PB+lJGqOBy7aAGfuYOwLlJpcvGToYyUH0SKPu9mgl5pT/
	E/6aWTGUf/gM0gvqWMZJN/g6H3T3eTwjjVnMIPK19I82Cpr7LDUcPUg37tR+J933gCKBKwx6JhF
	7xjGdyVrEzVLAT5P7WdGqCi/28IC1He9FqJ1iSnjvwndpVdsTnrJYxguoT3bx7XYbpNz+UgCjZf
	EjyJi3ZauuGYyfBs4hdgPoSxI1Q+/1ur8WJAYdgGCfqqzifeA5y9upZVE1ThURF+dBqm9JoaRta
	jK2pBdw0RPfDtsLrWylTMNg+ryzcJ/z+0FWG4XqL5WehpMb2G9LcVT0Ml+gZVxr7flZGY+mEx94
	nA4U5pAazfw78oSPZSaKEP1HoVCALnm7hYRI98wu0w7rEgE+rqYtYdNdHJNv4
X-Received: by 2002:a05:6a00:4191:b0:842:5931:7b88 with SMTP id d2e1a72fcca58-84284dcedc6mr6339880b3a.1.1780548644062;
        Wed, 03 Jun 2026 21:50:44 -0700 (PDT)
X-Received: by 2002:a05:6a00:4191:b0:842:5931:7b88 with SMTP id d2e1a72fcca58-84284dcedc6mr6339840b3a.1.1780548643554;
        Wed, 03 Jun 2026 21:50:43 -0700 (PDT)
Received: from [10.217.222.63] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8428291ed20sm5397566b3a.61.2026.06.03.21.50.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jun 2026 21:50:42 -0700 (PDT)
Subject: Re: [PATCH 3/4] crypto: qcom-rng - Remove crypto_rng interface
To: Eric Biggers <ebiggers@kernel.org>, linux-crypto@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        Om Prakash Singh
 <quic_omprsing@quicinc.com>,
        Bjorn Andersson <quic_bjorande@quicinc.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        linux-arm-msm@vger.kernel.org, Olivia Mackall <olivia@selenic.com>,
        stable@vger.kernel.org
References: <20260530020332.143058-1-ebiggers@kernel.org>
 <20260530020332.143058-4-ebiggers@kernel.org>
From: Neeraj Soni <neeraj.soni@oss.qualcomm.com>
Message-ID: <021127c9-baff-816d-e053-897a7d4043d8@oss.qualcomm.com>
Date: Thu, 4 Jun 2026 10:20:38 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260530020332.143058-4-ebiggers@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA0MDA0MyBTYWx0ZWRfX19tqATNpV+ji
 a47GBt7Vb/BPO+KAvEdHM/LvpBlyYh819JsHEytC1wT5P/84c4ZpMcan65CR8Hc5vbETOkja1gw
 R9kpduzZ2E0CIle9i/dkFuNjbs9hwa9ViiMYXbOrwsYfhnoehaNzjLSvASVU0smIvUHYjCLDrz5
 rurDc9pDaG73Wx2Jt87SMlBiwAKRU6mk382zOEEnr1izO0x0wdsmPg2kEt5Q6xksjqX3fTGPqQt
 r72QQqdsyNtdTHGLk03sT+WcFt4rRVUtObHOk+aTNpDjx1VxbQw3K2vVT5bt2Q2Red/bUOy3jX7
 GEJT3pwwP2wbKYTf5blGII8+EcxjlohVqJKGqspjof0cXu1b3fTvNd2EGvHEFRH5MKjxKWNhEk9
 5fD6Egq6R7r6QG+bygQqTuQFM586zX7zKXKYjQROAY/rS1EWD8WWGOfKhcEOQ+zlOzwRQxahOU7
 xXvg1SfuDYW2Gjr091g==
X-Proofpoint-ORIG-GUID: yAcyZDjXGXLSbRwEKPjXfnSiaioYuo9g
X-Authority-Analysis: v=2.4 cv=afRRWxot c=1 sm=1 tr=0 ts=6a210425 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=VwQbUJbxAAAA:8 a=cDBTOOi3T2z0a7_xwZkA:9 a=QEXdDO2ut3YA:10
 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-GUID: yAcyZDjXGXLSbRwEKPjXfnSiaioYuo9g
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-04_02,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 clxscore=1011 lowpriorityscore=0 malwarescore=0
 priorityscore=1501 impostorscore=0 suspectscore=0 spamscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606040043



On 5/30/2026 7:33 AM, Eric Biggers wrote:
> qcom-rng.c exposes the same hardware through two completely separate
> interfaces, crypto_rng and hwrng.  However, the implementation of this
> is buggy because it permits generation operations from these interfaces
> to run concurrently with each other, accessing the same registers.  That
> is, qcom_rng_generate() synchronizes with itself but not with
> qcom_hwrng_read().  This results in potential repetition of output from
> the RNG, output of non-random values, etc.
> 
> Fortunately, there's actually no point in hardware RNG drivers
> implementing the crypto_rng interface.  It's not actually used by
> anything besides the "rng" algorithm type of AF_ALG, which in turn is
> not actually used in practice.  Other crypto_rng hardware drivers are

How it was established that there are no active users/clints for qcom-rng
using crypto_rng interface? If there is no concrete way to do then this
patch breaks backward compatibility.

> likewise being phased out, leaving just the hwrng support.
> 
> Thus, remove it to simplify the code and avoid conflict (and confusion)
> with the hwrng interface which is the one that actually matters.
> 
> Note that while this means the driver stops supporting "qcom,prng" and
> "qcom,prng-ee", it didn't do anything useful on SoCs with those anyway.
> 
> Fixes: f29cd5bb64c2 ("crypto: qcom-rng - Add hw_random interface support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Eric Biggers <ebiggers@kernel.org>
> ---
>  drivers/crypto/Kconfig    |   1 -
>  drivers/crypto/qcom-rng.c | 175 ++------------------------------------
>  2 files changed, 9 insertions(+), 167 deletions(-)
> 
> diff --git a/drivers/crypto/Kconfig b/drivers/crypto/Kconfig
> index 3449b3c9c6ad..a12cd677467b 100644
> --- a/drivers/crypto/Kconfig
> +++ b/drivers/crypto/Kconfig
> @@ -658,11 +658,10 @@ config CRYPTO_DEV_QCE_SW_MAX_LEN
>  
>  config CRYPTO_DEV_QCOM_RNG
>  	tristate "Qualcomm Random Number Generator Driver"
>  	depends on ARCH_QCOM || COMPILE_TEST
>  	depends on HW_RANDOM
> -	select CRYPTO_RNG
>  	help
>  	  This driver provides support for the Random Number
>  	  Generator hardware found on Qualcomm SoCs.
>  
>  	  To compile this driver as a module, choose M here. The
> diff --git a/drivers/crypto/qcom-rng.c b/drivers/crypto/qcom-rng.c
> index b7f3b9695dac..48b605687b28 100644
> --- a/drivers/crypto/qcom-rng.c
> +++ b/drivers/crypto/qcom-rng.c
> @@ -1,14 +1,11 @@
>  // SPDX-License-Identifier: GPL-2.0
>  // Copyright (c) 2017-18 Linaro Limited
>  //
>  // Based on msm-rng.c and downstream driver
>  
> -#include <crypto/internal/rng.h>
> -#include <linux/acpi.h>
>  #include <linux/clk.h>
> -#include <linux/crypto.h>
>  #include <linux/hw_random.h>
>  #include <linux/io.h>
>  #include <linux/iopoll.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
> @@ -30,28 +27,15 @@
>  #define WORD_SZ			4
>  
>  #define QCOM_TRNG_QUALITY	1024
>  
>  struct qcom_rng {
> -	struct mutex lock;
>  	void __iomem *base;
>  	struct clk *clk;
>  	struct hwrng hwrng;
> -	struct qcom_rng_match_data *match_data;
>  };
>  
> -struct qcom_rng_ctx {
> -	struct qcom_rng *rng;
> -};
> -
> -struct qcom_rng_match_data {
> -	bool skip_init;
> -	bool hwrng_support;
> -};
> -
> -static struct qcom_rng *qcom_rng_dev;
> -
>  static int qcom_rng_read(struct qcom_rng *rng, u8 *data, unsigned int max)
>  {
>  	unsigned int currsize = 0;
>  	u32 val;
>  	int ret;
> @@ -77,41 +61,10 @@ static int qcom_rng_read(struct qcom_rng *rng, u8 *data, unsigned int max)
>  	} while (currsize < max);
>  
>  	return currsize;
>  }
>  
> -static int qcom_rng_generate(struct crypto_rng *tfm,
> -			     const u8 *src, unsigned int slen,
> -			     u8 *dstn, unsigned int dlen)
> -{
> -	struct qcom_rng_ctx *ctx = crypto_rng_ctx(tfm);
> -	struct qcom_rng *rng = ctx->rng;
> -	int ret;
> -
> -	ret = clk_prepare_enable(rng->clk);
> -	if (ret)
> -		return ret;
> -
> -	mutex_lock(&rng->lock);
> -
> -	ret = qcom_rng_read(rng, dstn, dlen);
> -
> -	mutex_unlock(&rng->lock);
> -	clk_disable_unprepare(rng->clk);
> -
> -	if (ret >= 0)
> -		ret = 0;
> -
> -	return ret;
> -}
> -
> -static int qcom_rng_seed(struct crypto_rng *tfm, const u8 *seed,
> -			 unsigned int slen)
> -{
> -	return 0;
> -}
> -
>  static int qcom_hwrng_init(struct hwrng *hwrng)
>  {
>  	struct qcom_rng *qrng = container_of(hwrng, struct qcom_rng, hwrng);
>  
>  	return clk_prepare_enable(qrng->clk);
> @@ -129,159 +82,49 @@ static void qcom_hwrng_cleanup(struct hwrng *hwrng)
>  	struct qcom_rng *qrng = container_of(hwrng, struct qcom_rng, hwrng);
>  
>  	clk_disable_unprepare(qrng->clk);
>  }
>  
> -static int qcom_rng_enable(struct qcom_rng *rng)
> -{
> -	u32 val;
> -	int ret;
> -
> -	ret = clk_prepare_enable(rng->clk);
> -	if (ret)
> -		return ret;
> -
> -	/* Enable PRNG only if it is not already enabled */
> -	val = readl_relaxed(rng->base + PRNG_CONFIG);
> -	if (val & PRNG_CONFIG_HW_ENABLE)
> -		goto already_enabled;
> -
> -	val = readl_relaxed(rng->base + PRNG_LFSR_CFG);
> -	val &= ~PRNG_LFSR_CFG_MASK;
> -	val |= PRNG_LFSR_CFG_CLOCKS;
> -	writel(val, rng->base + PRNG_LFSR_CFG);
> -
> -	val = readl_relaxed(rng->base + PRNG_CONFIG);
> -	val |= PRNG_CONFIG_HW_ENABLE;
> -	writel(val, rng->base + PRNG_CONFIG);
> -
> -already_enabled:
> -	clk_disable_unprepare(rng->clk);
> -
> -	return 0;
> -}
> -
> -static int qcom_rng_init(struct crypto_tfm *tfm)
> -{
> -	struct qcom_rng_ctx *ctx = crypto_tfm_ctx(tfm);
> -
> -	ctx->rng = qcom_rng_dev;
> -
> -	if (!ctx->rng->match_data->skip_init)
> -		return qcom_rng_enable(ctx->rng);
> -
> -	return 0;
> -}
> -
> -static struct rng_alg qcom_rng_alg = {
> -	.generate	= qcom_rng_generate,
> -	.seed		= qcom_rng_seed,
> -	.seedsize	= 0,
> -	.base		= {
> -		.cra_name		= "stdrng",
> -		.cra_driver_name	= "qcom-rng",
> -		.cra_flags		= CRYPTO_ALG_TYPE_RNG,
> -		.cra_priority		= 300,
> -		.cra_ctxsize		= sizeof(struct qcom_rng_ctx),
> -		.cra_module		= THIS_MODULE,
> -		.cra_init		= qcom_rng_init,
> -	}
> -};
> -
>  static int qcom_rng_probe(struct platform_device *pdev)
>  {
>  	struct qcom_rng *rng;
>  	int ret;
>  
>  	rng = devm_kzalloc(&pdev->dev, sizeof(*rng), GFP_KERNEL);
>  	if (!rng)
>  		return -ENOMEM;
>  
> -	platform_set_drvdata(pdev, rng);
> -	mutex_init(&rng->lock);
> -
>  	rng->base = devm_platform_ioremap_resource(pdev, 0);
>  	if (IS_ERR(rng->base))
>  		return PTR_ERR(rng->base);
>  
>  	rng->clk = devm_clk_get_optional(&pdev->dev, "core");
>  	if (IS_ERR(rng->clk))
>  		return PTR_ERR(rng->clk);
>  
> -	rng->match_data = (struct qcom_rng_match_data *)device_get_match_data(&pdev->dev);
> -
> -	qcom_rng_dev = rng;
> -	ret = crypto_register_rng(&qcom_rng_alg);
> -	if (ret) {
> -		dev_err(&pdev->dev, "Register crypto rng failed: %d\n", ret);
> -		qcom_rng_dev = NULL;
> -		return ret;
> -	}
> -
> -	if (rng->match_data->hwrng_support) {
> -		rng->hwrng.name = "qcom_hwrng";
> -		rng->hwrng.init = qcom_hwrng_init;
> -		rng->hwrng.read = qcom_hwrng_read;
> -		rng->hwrng.cleanup = qcom_hwrng_cleanup;
> -		rng->hwrng.quality = QCOM_TRNG_QUALITY;
> -		ret = devm_hwrng_register(&pdev->dev, &rng->hwrng);
> -		if (ret) {
> -			dev_err(&pdev->dev, "Register hwrng failed: %d\n", ret);
> -			qcom_rng_dev = NULL;
> -			goto fail;
> -		}
> -	}
> -
> -	return ret;
> -fail:
> -	crypto_unregister_rng(&qcom_rng_alg);
> +	rng->hwrng.name = "qcom_hwrng";
> +	rng->hwrng.init = qcom_hwrng_init;
> +	rng->hwrng.read = qcom_hwrng_read;
> +	rng->hwrng.cleanup = qcom_hwrng_cleanup;
> +	rng->hwrng.quality = QCOM_TRNG_QUALITY;
> +	ret = devm_hwrng_register(&pdev->dev, &rng->hwrng);
> +	if (ret)
> +		dev_err(&pdev->dev, "Register hwrng failed: %d\n", ret);
>  	return ret;
>  }
>  
> -static void qcom_rng_remove(struct platform_device *pdev)
> -{
> -	crypto_unregister_rng(&qcom_rng_alg);
> -
> -	qcom_rng_dev = NULL;
> -}
> -
> -static struct qcom_rng_match_data qcom_prng_match_data = {
> -	.skip_init = false,
> -	.hwrng_support = false,
> -};
> -
> -static struct qcom_rng_match_data qcom_prng_ee_match_data = {
> -	.skip_init = true,
> -	.hwrng_support = false,
> -};
> -
> -static struct qcom_rng_match_data qcom_trng_match_data = {
> -	.skip_init = true,
> -	.hwrng_support = true,
> -};
> -
> -static const struct acpi_device_id __maybe_unused qcom_rng_acpi_match[] = {
> -	{ .id = "QCOM8160", .driver_data = (kernel_ulong_t)&qcom_prng_ee_match_data },
> -	{}
> -};
> -MODULE_DEVICE_TABLE(acpi, qcom_rng_acpi_match);
> -
>  static const struct of_device_id __maybe_unused qcom_rng_of_match[] = {
> -	{ .compatible = "qcom,prng", .data = &qcom_prng_match_data },
> -	{ .compatible = "qcom,prng-ee", .data = &qcom_prng_ee_match_data },
> -	{ .compatible = "qcom,trng", .data = &qcom_trng_match_data },
> +	{ .compatible = "qcom,trng" },
>  	{}
>  };
>  MODULE_DEVICE_TABLE(of, qcom_rng_of_match);
>  
>  static struct platform_driver qcom_rng_driver = {
>  	.probe = qcom_rng_probe,
> -	.remove =  qcom_rng_remove,
>  	.driver = {
>  		.name = KBUILD_MODNAME,
>  		.of_match_table = qcom_rng_of_match,
> -		.acpi_match_table = ACPI_PTR(qcom_rng_acpi_match),
>  	}
>  };
>  module_platform_driver(qcom_rng_driver);
>  
>  MODULE_ALIAS("platform:" KBUILD_MODNAME);
> 

Regards,
Neeraj
