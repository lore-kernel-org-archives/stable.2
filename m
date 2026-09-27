Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8FCE429000
	for <stable@vger.kernel.org>; Sun, 27 Sep 2026 17:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790531744; cv=none; b=mxeY3z0e4c3wsWzCMhZiAjJs3ktK6S9+YswVqSkH8hp89F8T5xqr7FSXVWK/qyuSNL65hCXZeCNkqScIS9QJLLBM3pLDtvhGQ27zaSjB/EshzaPQIBef19EVewqLa7W0YeKxJsOA/sxHZYfZYGrL+ccEgPJ5ctN2Dn3ubjzZzvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790531744; c=relaxed/simple;
	bh=uzulCFmfSKx4L2uI+AawFiAkCbCZ9nYjgV+Klw292bc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ELh+ZW252wTXB18Y4ciX8Xj4Jyi48Pz9LimOKpJik3F14qcXB8DEgKKzoWte8BrIJXiIp8xQJRVmhHqBk+/zpK0SzZeo5ByZyiGI7XixhbCK/djq6vl+fNZfEF0UtMHUCs/FZR0GplcT1KcnIM625gd7H8lRcNWQaJKco0i1g0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TGt0TzC1; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=au0sNVU9; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TGt0TzC1";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="au0sNVU9"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68R1redq1788180
	for <stable@vger.kernel.org>; Sun, 27 Sep 2026 17:55:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	eYTBzgG20csW2zfR3sxsuXAX1IOCeJol8XD1eAHh4xM=; b=TGt0TzC1W+DHwGVw
	W6Ou9mO0ezipe8xZwRbureLRbkcGzR9g4nF2P6i7aD6nnNpsftwQxK98gCRkYRZ9
	gDq7TDk35Rmf7aUT3h80U0+Zv2oAJ84er1BoOrdfZlF6amZt/oZSyT4ktBu3O99X
	6GxM9w5oIWukMXAq7qWNgnpABMhyrt5lWDNmrW0B17K0/BE4NvZcaCU0+urDDxXj
	rEFcpGiRzhV3K2CqcTCnZFQq9ifnXHbw/76+ryCAd0oHCVoS2kP1av87eF1UkxfX
	NHd75BVCj2dZR83xZpvUE7Zr+6Ow7RDvqsDciKXnqYP/hDmgNIaSrxECxIWgTLC1
	LmPvNA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gx526kh8j-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Sun, 27 Sep 2026 17:55:41 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-93c5ab5c136so213640885a.3
        for <stable@vger.kernel.org>; Sun, 27 Sep 2026 10:55:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790531741; x=1791136541; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eYTBzgG20csW2zfR3sxsuXAX1IOCeJol8XD1eAHh4xM=;
        b=au0sNVU91100p4KEVo3fPpjlp/apx9zBJ8fA1wOUNPPcfd5oAN36xSh+V+ENw/wFeV
         OpHT5wMkJ7b1ZzBs7inY1fR3Z3gCMVe5avJCCX12MoBUnbprQ50Q5yh7GN7PBcRez5in
         up4Zgqb6WD+0Kz9oEm5E/682JBfuAleRalnSFr9N92ZM24B2rBEt6/Hiq4DBYh/KK7l+
         /jBqFLmrpNoZvj730slpfxLRi/H48mljTRFbyuZsDvltfUaxcqJVbgv03oOmq1M08uO2
         kf9slDWtoja7VW2o+C6gSupnwZ0IW6N0VVf2Z7JwFkUsvkg6zNck/MS8I9j+0oy/25x2
         UyPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790531741; x=1791136541;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eYTBzgG20csW2zfR3sxsuXAX1IOCeJol8XD1eAHh4xM=;
        b=R3UQy+5+BCw2JKz6HnUEcUh5lftIhCGU4HkyLvx+zAaNt6kjjoEkinKYzD7+5Q7zmj
         tIIbZIFXcgnkrDvv2lvnL59VIIMrB6vhj3gBw3RM/cUt8CoEnNCmhEV/YTI8a4MFT/5E
         dX5Nk0khtB4ZRXpjC/21uhs3A1IyZChm9iVGVjSj25MLmYOafBAntNKnkpTmv+N8H64M
         iAL1nrz43WzIgvhE+H2gqGvbQsTPxngZVwO1mpYimD3pKDsaPPN++seRwOWug/xhe2og
         oO07AVJAm9IgU/KZ/YQ7sQSFH0uliyC0oaNaqExGAva6YCBnzV4+z2ivujoi1+a0PAQG
         WwAA==
X-Forwarded-Encrypted: i=1; AKwUvByrXafgTG94elPgF1VmISnzqnnBifRkD2hNNbcaAK9RVTWyArLXkgYFEsUYrF3dPxD7Duw4yuQ=@vger.kernel.org
X-Gm-Message-State: AFuF++m/JAeKYQClg9dhMgBJWq4KEqXLLixKoZjGuyCpQfIwxSpf+egv
	roe+FqzYQzbCLlkC5Joo/WfxoMV/z8+PtlFJoP+ER1eAdzAeg8boUVIRspK0DOHRvxu4HBKJpTS
	hRhoXblzkKg0z5uSSXZY569CHUWLD3SLFE7INYHOZ+J1/+i9aoqpVP39CWdc=
X-Gm-Gg: AYBFou3cDDlyhawjzclBiDbQ/9PaOqyEaAu0/awdgf/W4svH4WDADmB0/JjvXNR8E3Y
	M2v42QRDZ26jH0iv1rl3HAmOZbWpNA/nSGGt7zXx2v7WIgt32Hp+mX1mk8WF4qMDKRhwFB8WpRW
	VcDTX/CFrolWAm5AuIkvhoq7OJ4+2Y215et5IMbSE+rTsaZKg3geOUJ58Dwi8PGwTDEph7MV+X+
	APmrXKk5XQeuNDjBZkhLKXJ7qihaQ4IS6HuK3z8oQMmHKRPYmM8gKFGCBrGhBN1TSuK9SGI8mp8
	XYb39KrSrvUBhUxUVSPDiUhRX1zF87HDSc7bLpfw2rUto5EQYOQW1hAlecHUbTYLAciqjvqRVwC
	Xdm+y/tKVbIOQkLI64k4Y/AIcog==
X-Received: by 2002:a05:620a:2686:b0:93c:208:3d9b with SMTP id af79cd13be357-93c43cd656emr1657227085a.41.1790531740758;
        Sun, 27 Sep 2026 10:55:40 -0700 (PDT)
X-Received: by 2002:a05:620a:2686:b0:93c:208:3d9b with SMTP id af79cd13be357-93c43cd656emr1657223985a.41.1790531740248;
        Sun, 27 Sep 2026 10:55:40 -0700 (PDT)
Received: from [192.168.68.120] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4a00179c729sm116866795e9.15.2026.09.27.10.55.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Sep 2026 10:55:39 -0700 (PDT)
Message-ID: <9f76e45e-5b0e-4a79-b4b0-a41795d9d025@oss.qualcomm.com>
Date: Sun, 27 Sep 2026 18:55:38 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] ASoC: qcom: lpass-cpu: use DAI table index for
 playback constraints
To: Zimeng Li <me@lizi.moe>, srini@kernel.org, broonie@kernel.org
Cc: lgirdwood@gmail.com, tiwai@suse.com, linux-sound@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, stable@vger.kernel.org
References: <20260927010911.51980-1-me@lizi.moe>
Content-Language: en-US
From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
In-Reply-To: <20260927010911.51980-1-me@lizi.moe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=VvS2kO2n c=1 sm=1 tr=0 ts=6ab9589d cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=ZsC4DHZuhs/kKio7QBcDoQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=iDUYOmZZWeky2fLdnAoA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-GUID: 1b5MuQakT0hRTLOyOoANHVr2vi0d31j0
X-Proofpoint-ORIG-GUID: 1b5MuQakT0hRTLOyOoANHVr2vi0d31j0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI3MDA3MSBTYWx0ZWRfX7yvxJ244Xu7W
 cdcYpKXooj/+uBExX2WrC9bJmCn574lFXTw9GGlwlC/0YZ8WL/2jM9dZOZJphtK7kggP2LCnDOL
 PPOKEbCodcU3oxz+CFFwZbtxU1iKSsQ123r65AI/bmtcxneHDeMFmaH2YMsvUVb+hE2Qf9HcYHO
 LmPnhkZt72yqFitX7IOwFTtshWmstgE9Qxq1MSsD3fTv+VCggCH0tOsMh6CxesVoozZ9IPJP1rI
 k91chf8k9IuuAN1UA0EdbtDpfx7XMoxZYjUN/32rNAeC+Hq/oAMIQ9qCv87jeD8JCTpiiAyD6VY
 /rn4E2OBWTXSFSd9SSR/0OM42LY+v22eVetDMuFOD6KFb3iSjqbi101Z88d/zHT27imWOdfY/N0
 8MYJYHVNhz9kIv/BiX4EaBTAW6NVBePxI8bBMmu2jGAECKwY7mbO+k0uC1IZTAPJEDrgFs98cDV
 ni+xjdUKNT0eRtRbtsA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI3MDA3MSBTYWx0ZWRfXyRunb+uhq21S
 w5IOSyRl4JK0ym/q9vjrd4QtnXY0mr+kgMHM167i5ynbkT71CSIZea8G6QFmqYs8VPN2atuaOVC
 BC38N3mqIkqZZTJRr0v6QJ8m1fiH9y4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-26_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0 clxscore=1015
 priorityscore=1501 spamscore=0 malwarescore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609270071

On 9/27/26 2:09 AM, Zimeng Li wrote:
> The DAI ID is a hardware port ID and is not necessarily the index of
> the corresponding entry in variant->dai_driver.
> 
> When configuring a DAI with LPAIF_I2SCTL_MODE_QUAD01, the probe code
> currently uses dai_id to index variant->dai_driver. This is incorrect
> for platforms where DAI IDs are sparse. For example, the IPQ806x MI2S
> DAI has ID 4 while it is the only entry in the DAI driver table. If
> that DAI is configured for QUAD01 and probe reaches this branch, the
> code writes beyond that single entry via dai_driver[4] instead of
> updating the DAI being processed.
> 
> Use the loop index i when updating the current DAI's playback channel
> constraints, while retaining dai_id for indexing the hardware-port
> specific playback SD-line mode array.
> 
> This fixes the incorrect DAI table access for platforms where the DAI
> ID does not match its position in the driver table.
> 
> Fixes: c223f41c1a52 ("ASoC: qcom: Add four speaker support on MI2S secondary")
> Cc: stable@vger.kernel.org
> Signed-off-by: Zimeng Li <me@lizi.moe>
> Assisted-by: LLM-assisted source analysis
> ---

Reviewed-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>

--srini


> Changes in v3:
> - Describe the assistance in Assisted-by, no longer name the model.
> 
> Changes in v2:
> - Add stable to Cc.
> - Identify the model in the Assisted-by trailer (superseded in v3).
> - Clarify the conditions for the IPQ806x out-of-bounds access.
> 
> The code change is unchanged from v1 and v2.
> Compile-tested with LLVM for ARM using multi_v7_defconfig with
> CONFIG_SND_SOC_STORM=m. The lpass-cpu.o, lpass-ipq806x.o and
> lpass-platform.o targets built successfully. Not hardware-tested;
> the IPQ806x example is based on static analysis, not a reproduced crash.
> 
>  sound/soc/qcom/lpass-cpu.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/sound/soc/qcom/lpass-cpu.c b/sound/soc/qcom/lpass-cpu.c
> index 242bc16da..079177a6d 100644
> --- a/sound/soc/qcom/lpass-cpu.c
> +++ b/sound/soc/qcom/lpass-cpu.c
> @@ -1234,8 +1234,8 @@ int asoc_qcom_lpass_cpu_platform_probe(struct platform_device *pdev)
>  		}
>  		if (drvdata->mi2s_playback_sd_mode[dai_id] ==
>  			LPAIF_I2SCTL_MODE_QUAD01) {
> -			variant->dai_driver[dai_id].playback.channels_min = 4;
> -			variant->dai_driver[dai_id].playback.channels_max = 4;
> +			variant->dai_driver[i].playback.channels_min = 4;
> +			variant->dai_driver[i].playback.channels_max = 4;
>  		}
>  	}
>  
> 
> base-commit: 0ed6f7f62318a581fe9698f8a4e98c7ca01160e4

