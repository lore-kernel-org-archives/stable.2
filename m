Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7717B2D5C8E
	for <stable@vger.kernel.org>; Fri, 16 Oct 2026 12:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792152058; cv=none; b=MmyVprVM7ysadazqNvGZUdEhhwPlEXv59J+tSozlzHXoHztlgnif8Gm04OPpbY5fq9HG+auyev1vHApeOkrvCGYNGJ3tQtF02C+i5d5k1miqhl982ZNTbk4nXz1VJOFLMGYsCnMe01rb74SAx8bLMkCjvczjXxsLwkavSybBNH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792152058; c=relaxed/simple;
	bh=oTSvWT5egyr1CETBh/x/wkC85/WmhMt+MS1XJCPi3H0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y3+xmL/ma+EUi80vLF3D1X2DGKfdXguJv2vvGYyWSA6JGVbqyjQ0zeOlY7SAws5nRp92kXlcvhIc5OrGBvW8JmDRITPXL3KfSsDn5f13VVPRDzi9oxID9yGtJRZ5fcP5hqjZDch7zQx/tgaJITxl88wtWh5UTuWUZpmoTVbfbws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=j+MDOWuu; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=aIOsBG8L; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="j+MDOWuu";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="aIOsBG8L"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69GAAXrG2403585
	for <stable@vger.kernel.org>; Fri, 16 Oct 2026 12:00:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	MFSnFBHYg/fTRbadTyfMpG/V5zT5Z8plQKNhaT3h4mw=; b=j+MDOWuuEAnLtaCj
	dhFfpJnZaceAOQg7i6HqGoiSNkMEqpi+VhjA+RPY1AWyLZJt3fV1CeQauB5MM0cJ
	h2upB3hlkhqTKsXo6fjvYEyDLzIfJleHYS8d3AsV6v22dqmIyqSIMxZ10MKAvHQ/
	7ZwxiaOxEa1dlBaPT/ULmtLCoATOdhbn/fbNBZSMqQCx5ncAFd7o+iG5tKw6kR9m
	cASy1YgBuiLiy6AyUO9C+FgVjbVLpo8sGSQXrPnX8fMdgLvxBICgthIgul9Fq8Ba
	vgREYwsQ3CjM5qGEFMNBA275Rct0ZEC6O6Nfi0/lu+dwkO+H1HL29vyTfP8YcLCK
	VbWWgA==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hb19m4aaf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 16 Oct 2026 12:00:56 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2e869e00005so35843135ad.2
        for <stable@vger.kernel.org>; Fri, 16 Oct 2026 05:00:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792152055; x=1792756855; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MFSnFBHYg/fTRbadTyfMpG/V5zT5Z8plQKNhaT3h4mw=;
        b=aIOsBG8L4VQ6drXqM3O7WaQtEhA3peFd6uKK8AVzRkOjGfrPNxQ/uGA3Cc9egCNQCc
         3yJlyP0bkBbMxJR7ikyP2qZcwpWu/BCb2mXvazgJtr8KPG3rnih93tvqMaPHlmEeSNjk
         HqkXf/DFMNc6XeWJ2pnuUajazMAtR8p/M71fha9abQdY/+M3pNgpMP0BlGiSgDJ9Xe9j
         qUXk17XQSUKmZaz0O7huydnGiKtM0+CKDEe6v/ldJr/KEkGohyqpWoVTtIcfUN9Y5CIr
         +uXkwca3Si4y3qtaGk25qRHxJ13NA8FfJtz01lRgkp1Q3i5hYRGb7FUGOb3prrq6gi2Q
         xixg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792152055; x=1792756855;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MFSnFBHYg/fTRbadTyfMpG/V5zT5Z8plQKNhaT3h4mw=;
        b=iZmys8astD5OCiUwVjbCqrCQ8Ypqw+mV66btI6NVnW2/3c2tOCXfEoxiw2ApR+vplY
         EXnXU5eBdfcWLzsFGwTc68o9Uf0NlqtdNoL0RRSaciHW17os+miCW0da58Qd4B6tXEdB
         cZYA1bvcWak32FvUYjsptrjov9smnASnbIPpp8OZFnLKOuVhBnV5Ig+HoJooKjEgWjD2
         ToftcmXiOa6fGunRKfPv1KoH4M7Q18Th7P+Ps4L/NUwAsjDZMezP8nj0vqhrxJCx/8/N
         lYslLcwU4luhV1/QiRKXWSlwrBz/hEz4bVUcdY2SIHijggKin810wlaG0VjQklfC9ODP
         XM0w==
X-Forwarded-Encrypted: i=1; AKwUvBzxtRzjaXPhvZbFhwIY57SfOp64eWiRrbzPi+wFfy3KfPlj0umFa0wjFeGIR1GiuqyzMR/ty64=@vger.kernel.org
X-Gm-Message-State: AFq9FYJgFm2WEWcdapaRiqcVdfkPra6+jNN7n8OQJAkhH9y+4VWQvppj
	zvZA/Kdu5XRfP05vuxGl8bUFoBOw6Eeus1xUheDB/3+S/+TwxSOeUUMJwYQ86+KW0g5/S3otvf2
	QOXRVEc6stSmiiR4wXxx55bKr2OwDyUHU4d92T2C7EkG4IDX4+7S81fUDHxw=
X-Gm-Gg: AYBFou3jxBKo+vSX4cbEyB+iDy1vz2W3UXj+CCY/leW12g1I0TW+abSudofTPogtDQZ
	QRUUdni+EvLRXe0lrq2/O5tkLYG3I4f7KVXc+yDakL3AfvmxHxOgx7B4/hxKEe2dfDjx5o0GUz0
	GS+lB2QvMD2EYCesWFrDiZ05kHnmWy5pPhzZiGRgGV3nBoOplRIE5/7R38OwBFcs8SG8pSE+e3h
	iAoyO4fxWAw+q6SqiNklPCCpPxdmkdOdgchP+syeZyb1GaNt9ZRbcmKNKMUGwt0WqBTLLJ2Dklr
	oBqtY+HLJ/oPY3i+5RmxXnKT+7HztNxmbJXTZBUh42qYEaRWECBNcue3AGok3m6PUXM+BPW0Pqr
	Ts91p0vS8yerniOX8ZrtRKuAEEOM=
X-Received: by 2002:a17:90b:274d:b0:3ac:aa8d:19f2 with SMTP id 98e67ed59e1d1-3acaa8d21b7mr3444881a91.62.1792152054904;
        Fri, 16 Oct 2026 05:00:54 -0700 (PDT)
X-Received: by 2002:a17:90b:274d:b0:3ac:aa8d:19f2 with SMTP id 98e67ed59e1d1-3acaa8d21b7mr3444817a91.62.1792152054113;
        Fri, 16 Oct 2026 05:00:54 -0700 (PDT)
Received: from [10.218.18.193] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3acc48e8646sm3775998a91.10.2026.10.16.05.00.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Oct 2026 05:00:53 -0700 (PDT)
Message-ID: <3e247695-90ab-425a-a8c0-d6350362d1d1@oss.qualcomm.com>
Date: Fri, 16 Oct 2026 17:30:47 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] ASoC: mediatek: mt8183: Leave cache-only mode before
 enabling clocks
To: mocker-mug-unwoven@duck.com, Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
        linux-sound@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, ajay.nandam@oss.qualcomm.com
References: <20261016-mt8183-afe-fixes-v1-0-f0db51e0c073@duck.com>
 <20261016-mt8183-afe-fixes-v1-1-f0db51e0c073@duck.com>
Content-Language: en-US
From: Ajay Kumar Nandam <ajay.nandam@oss.qualcomm.com>
In-Reply-To: <20261016-mt8183-afe-fixes-v1-1-f0db51e0c073@duck.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=aLdlOr9m c=1 sm=1 tr=0 ts=6ad211f8 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=oAJgE6QaAAAA:8 a=VwQbUJbxAAAA:8 a=RUIXpT8KVlbvrv2-URwA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22 a=x6WLLiyY5-E8SSaYOalI:22
X-Proofpoint-ORIG-GUID: NpfPa4tiLhL-CEayrPjTExcpRO73eXxL
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE2MDA0NyBTYWx0ZWRfXw8Bjum8sHZlx
 4C8VwJ2pXV13L6cn3he8ouAYtIBGxEs4ht+CNfN/o7kLYnRAr6pbcy/wFFx6rXBb3ZtGIiqNSeD
 VZ0ikL9Yzk0auZSjXGEUI3882KxFxP4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE2MDA0NyBTYWx0ZWRfX2dpqN2BbzaXb
 Zjf6v9HYaS93HN4UcUHhWwtp/2wz0d/DnbAb8bCfdqOPBtTfHNli4oOm0jmsfqfZ8OKW4XY1/8V
 IV7YZ8uoafH+O6WmHp31r9nB4X/t5RKTlggO/w7tEsCtMa9N5cO5CuG5huhrhQ3pNbnfIc5mRbh
 6vB3BepuTeVSmJbqCf3MFgTvs3Kuldzskq2c4QUvpUXBhGitjUIPjrFAOaXIc3oSL4nhK/wELok
 T5jRIcacWXZ/4u29l+pvTuhwpOkc4UwaVcrHHtFkeKqrZl+Drhl9cIMS4yCK48HPfr8Os8+dW//
 X88V9wDV0tFbI30Th0GeUt89AJFsyVtJuuhhF7RZ5c1P8hsXcEV+9JSQF6c9jSkoCSsZcHJ6UGO
 UbdY7sqvAnIFbPX0smzsxe+F1YAkI2PoNUhgqyY3nVaSuQVFDr3aWtmltYxXumIdhvhXJ01dSQB
 DzO3sSkJI8vPGfvaprg==
X-Proofpoint-GUID: NpfPa4tiLhL-CEayrPjTExcpRO73eXxL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-16_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 clxscore=1011 malwarescore=0 adultscore=0
 suspectscore=0 spamscore=0 priorityscore=1501 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610160047



On 10/16/2026 1:44 PM, HuskerMinion via B4 Relay wrote:
> From: HuskerMinion <mocker-mug-unwoven@duck.com>
> 
> The audiosys clock gates are bits in AUDIO_TOP_CON0 and AUDIO_TOP_CON1.
> The clock driver writes them through the audiosys syscon regmap, which
> is the same regmap the AFE driver uses. The AFE marks both registers
> volatile, so while the regmap is cache-only, regmap_update_bits() on
> them returns -EBUSY and nothing reaches the hardware. The MediaTek gate
> clock ops ignore that error.
> 
> mt8183_afe_runtime_resume() calls mt8183_afe_enable_clock() first and
> only then takes the regmap out of cache-only mode. After probe the
> regmap is always cache-only at that point, so the gate enables are
> dropped. The clock framework then counts the AFE and I2S gates as
> enabled while they are still closed in hardware.
> 
> On the Amazon Echo Show 8 (2nd gen) the bootloader leaves these gates
> closed. Playback and capture never start: the memif current pointer
> stays at 0, no AFE interrupt fires and aplay fails with an I/O error.
> clk_summary lists aud_afe and aud_i2s1 as enabled, but with hardware
> enable N, and their power-down bits in AUDIO_TOP_CON0 are still set.
> 
> Leave cache-only mode before enabling the clocks, and go back to
> cache-only mode if enabling them fails. The bypass case used during
> probe is unchanged.
> 
> Fixes: a94aec035a12 ("ASoC: mediatek: mt8183: add platform driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: HuskerMinion <mocker-mug-unwoven@duck.com>

This fixes the ordering on resume, but what about the suspend path?

runtime_suspend() still switches the regmap to cache-only before calling
mt8183_afe_disable_clock(). Should the clocks be disabled before 
switching the regmap back to cache-only?

Thanks
Ajay Kumar Nandam


> ---
>   sound/soc/mediatek/mt8183/mt8183-afe-pcm.c | 16 +++++++++++++---
>   1 file changed, 13 insertions(+), 3 deletions(-)
> 
> diff --git a/sound/soc/mediatek/mt8183/mt8183-afe-pcm.c b/sound/soc/mediatek/mt8183/mt8183-afe-pcm.c
> index d8938542b..d6175da3b 100644
> --- a/sound/soc/mediatek/mt8183/mt8183-afe-pcm.c
> +++ b/sound/soc/mediatek/mt8183/mt8183-afe-pcm.c
> @@ -706,16 +706,26 @@ static int mt8183_afe_runtime_resume(struct device *dev)
>   {
>   	struct mtk_base_afe *afe = dev_get_drvdata(dev);
>   	struct mt8183_afe_private *afe_priv = afe->platform_priv;
> +	bool reg_ctl = afe->regmap && !afe_priv->pm_runtime_bypass_reg_ctl;
>   	int ret;
>   
> +	/*
> +	 * The audiosys clock gates are written through this same regmap and
> +	 * are volatile, so their writes are dropped while it is cache-only.
> +	 */
> +	if (reg_ctl)
> +		regcache_cache_only(afe->regmap, false);
> +
>   	ret = mt8183_afe_enable_clock(afe);
> -	if (ret)
> +	if (ret) {
> +		if (reg_ctl)
> +			regcache_cache_only(afe->regmap, true);
>   		return ret;
> +	}
>   
> -	if (!afe->regmap || afe_priv->pm_runtime_bypass_reg_ctl)
> +	if (!reg_ctl)
>   		goto skip_regmap;
>   
> -	regcache_cache_only(afe->regmap, false);
>   	regcache_sync(afe->regmap);
>   
>   	/* enable audio sys DCM for power saving */
> 

