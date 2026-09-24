Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1D7840F73A
	for <stable@vger.kernel.org>; Thu, 24 Sep 2026 16:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790267239; cv=none; b=GsRk/9Eqq9cP89LuPJp5hhqQsVvhcXb3EEbss58JYQabe0O4DDUF6cx2dvPAMPNHSY5HXR6fxk+MEEPArtUAbcnt0d3FXNj4JzajcSktaNIpfcpTMlIRI+mLH3ASFOi2Y+s2gmM5mvoSmkTEgFlnTuu2x6yn+f4+8uL/LTCpsQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790267239; c=relaxed/simple;
	bh=O3ZVq2aN57CDDJqcDeeMkmvA4zgCpKP+7hCd9oVPOYM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t04e58oixjsM1rsj6Qoqg+QdztPTku1c/ytMZKNBiQawX60K/mTAIeY+wpjWc7rVKdJ4xlCFM7uF68gbLCjVR25CfKaS049JuyDAd1lS6MXgKTbrFVzS/a65CcINMOa5fjMUQbjgfLNpUbKzlTUCphEbGwLSQa0X9aY00ihT4Mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LP0vSOce; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=CYCQXMbW; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LP0vSOce";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="CYCQXMbW"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68OFeMlQ1899626
	for <stable@vger.kernel.org>; Thu, 24 Sep 2026 16:27:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	CDRoRsm88bQqknBg7q9Dc+jZIAjIk1EGfL4tnHnxT9U=; b=LP0vSOcetlf67NYE
	yN3Fu7Lc8lAUDT/B7GDoMweqSY+1ejiSwJJV5/7VghmYQsr48mUWf2wxP0umRul2
	nBiYijy5wDpaarF8AU6dGUmwXENH+O8owuI/+Fjbm4Qg4tMUQCRUqpyTNYtukJHO
	ETy/zjbLM44/p13a2DatA3Okl4Qu9jiPM8J0ifShqnHKElO8nxC7hUnv2C7ZtXyc
	MrWHfBg8F9eKiPg/yHq2aagWuT0jRaBq64ckImKdij9Q89exJ/4+xeUJmNghuFW7
	rNP9pjRAM9MqggryWXXPORVQijzA1hoH7DKLcKbnKaq3+xfPHJbwmm8z8hq/Ui6z
	9seIxw==
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com [209.85.210.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gvvghb2ut-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 24 Sep 2026 16:27:17 +0000 (GMT)
Received: by mail-ot1-f69.google.com with SMTP id 46e09a7af769-80139a2495aso3976067a34.3
        for <stable@vger.kernel.org>; Thu, 24 Sep 2026 09:27:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790267237; x=1790872037; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=CDRoRsm88bQqknBg7q9Dc+jZIAjIk1EGfL4tnHnxT9U=;
        b=CYCQXMbWWhZ0rPEZ/5No5CY2DzOafhJ3N4A2kW6FDsbMJtYTBQtOHOaH617RAucbHf
         UBBLSNqU+Q6ztCy95mjM9JdJtxmjGiBVAtmaF63YOI/LaizSLifkqNdRztN3neSNXZq6
         EEZypMyCkq3dPfq1j0OOaa73wl4K4QI4j7z6T+5tOKubYyA6svJ++O8EXis2hm+lJNnY
         gRtzxDzesvQ6Wuan+oSw2ZPboSFHDt5ihIZ/VbhvbMcbqxVzAQRLpotu/AQKEz8Ypf3V
         6rBY0xtUIXKxiiLkzMx0ZYK9K/Kl3Upsa5V3LivGp0wjem/3EWNIZJ2G02qC2GeCVQHW
         VR6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790267237; x=1790872037;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CDRoRsm88bQqknBg7q9Dc+jZIAjIk1EGfL4tnHnxT9U=;
        b=J0OSZfm8qLd8sKWaMLoDZZAZjuYmsU31YipwiTdgRvqWF+OpRUb6MwPPkHmDGTDSlZ
         wnu//XTB3HD7M1CMe8QIroFvU1iQDth8/nonF03G/YSr5toxwigegY3NrI4ZrSwrNRnL
         I5ap4Fem4NjXSYc496BnzWYVA4BRX62C9WQKrBH+HBoSw8eD4EJeSRbFD+4avMpObc9U
         JFDATsMSn5k4C0cDCdUJ69kHAQu36kfxwbS0Id3qlig5PsZzasLoOF1s7XsJ9yPDERXu
         XWh9i2ckCffD51uK3dn20JT11gSNZ2rtdUmOcoeMaiB9Q3qvjLRM2nKrsDAf/lbB5pl5
         VtfQ==
X-Forwarded-Encrypted: i=1; AKwUvBzUg81gCPgos8XqS6byxfQ8RrAcj0Y3S3Uf5WQEQTEIYuLP9vL8/dF89EM3PZO+hVhoYlfTgzY=@vger.kernel.org
X-Gm-Message-State: AFuF++kgbiIyjQjCR5G57e10sEYNR0mfEJQdptBplLYswskYKePBDiLX
	nza8UyJv5Mr0ZUpSXg4CrFMFb3Xm/pBaQ3pU++EVVM6Q3zAzFBhhGfaQOwqoUEHhcXMf0eCM33C
	nPQZiU1nuVyLA9EX10S/AoHBDhafRDO+f3LFhuWUrL/8tY4TC56n8UDu4UJE=
X-Gm-Gg: AYBFou2sExTMmMaIbTjbNiM5Obnn8soaXSHUzJoDPzhYGtsK44iEYks2hYwPZrQc293
	SP2EhmULX1M+DmORsk2lzYduyr9uZaaVY1Gue6YncVHN/ZgPJ6dEeYLY2I9SwaJcqJ01PNJ77ll
	4dAm05GeDVx4p3fFABXQQxG6EZuk39gbs17vqPxXNz79UpDyb+gPWpqJ1wb+QqkgzprY6sJdYYX
	Ar/MJY2vmdOXxCffIBvGMTbws/WaQo0v1krJv9fUjPByLf7yx6sCQWb3qj8Mys+W80x4tmFlrd/
	BwUHqRS8Pg6SXzWy2OdW5wzqDdNKH44nQGTRpcgjK0ysvz4KY5oGzTfc7ltP8bB7WyHGsJ9szcR
	Fs23X6dyoHs1xuXUdErQ8dwaEWRI1tcI=
X-Received: by 2002:a05:6830:6301:b0:805:2785:fad5 with SMTP id 46e09a7af769-81783b984d0mr3079647a34.27.1790267236775;
        Thu, 24 Sep 2026 09:27:16 -0700 (PDT)
X-Received: by 2002:a05:6830:6301:b0:805:2785:fad5 with SMTP id 46e09a7af769-81783b984d0mr3079606a34.27.1790267236296;
        Thu, 24 Sep 2026 09:27:16 -0700 (PDT)
Received: from [192.168.0.15] ([183.83.142.107])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-816018d81f8sm6712807a34.3.2026.09.24.09.27.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Sep 2026 09:27:15 -0700 (PDT)
Message-ID: <8bf0e48f-e98f-76b3-0cee-527af9461ea5@oss.qualcomm.com>
Date: Thu, 24 Sep 2026 21:57:09 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] media: iris: reset AHB bridge before enabling HW mode
Content-Language: en-US
To: Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Birk Skyum <birk.skyum@pm.me>,
        stable@vger.kernel.org, Renjiang Han <renjiang.han@oss.qualcomm.com>
References: <20260924-vpu_hwmode_fix-v1-1-531498f3499a@oss.qualcomm.com>
From: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
In-Reply-To: <20260924-vpu_hwmode_fix-v1-1-531498f3499a@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=KYhHIgYD c=1 sm=1 tr=0 ts=6ab54f65 cx=c_pps
 a=z9lCQkyTxNhZyzAvolXo/A==:117 a=BUSZCRnG/G6/Li3ahCSwQA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=hkYZVY6NqzSJq9KjeRUA:9 a=QEXdDO2ut3YA:10
 a=EyFUmsFV_t8cxB2kMr4A:22
X-Proofpoint-GUID: H5DKrNRvCmnbu1cmxIWWMQoQxn70zco5
X-Proofpoint-ORIG-GUID: H5DKrNRvCmnbu1cmxIWWMQoQxn70zco5
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI0MDA2NyBTYWx0ZWRfX8ZJwIwgV/Qdz
 8Q30WRv/kfch2IZwEGYzvJzvxCymcLroVxTrZeVriWY79J9JHtdh78YrkOYSZGfIdqUo/+pQJGa
 5BDtH9ZA4FKBXndxeBmrjwNgawEAZlo=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI0MDA2NyBTYWx0ZWRfX562OIxsUhHG4
 6XDWjdEf+pTc4Ac5F2hj1VRHKJyx+Muq9pIc4JLX+eEL4W29WCPQJtOUn0a/IZU2DLPmkNxhIO3
 C7nqJIy7j9Mq/+luudykk+SS8Yx+aiL+4GbmVbT1Xd9frQQ1FTryPn7Zkurq+fYP8Sy1kU3pwmu
 wk6kES2EcBC4WXGT0O3amTv2BI5yaoIiMC+MrrkaxBeU5gZe/WLGbJwkrrQwshQzToa6PEy0RS8
 6PVX2cx5fT0/8pzPMS1fKVTre+Yk59RRKoRqM5iIgNBNSjzpGCoqHiOSZgyO/4Nb/vbBmWw9rRN
 hF8CGsQbQErn+hXJhFPa4BA2wa1ds3pQBZTipF4suP3u3C7SzZFN8cS10gElSARyT58THfgvyvr
 YI2Xbwmrhd2AMNuDij0mrEP0bLlZIFMidE4uaa7a5a7Laqd9T0b0a/3gleMP5geiuOubxQa0RET
 6eGx/MV4bcjcXKtxupA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-24_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 adultscore=0 lowpriorityscore=0 bulkscore=0
 clxscore=1015 spamscore=0 suspectscore=0 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609240067


On 9/24/2026 8:00 PM, Vikash Garodia wrote:
> When video power domain is switched from software-controlled mode to
> hardware-controlled mode, the core may be powered down without the AHB
> bridge going through the required reset sequence. This may leave the
> bridge FIFO in a stale state.
> Reset the CPU-to-VPU AHB bridge before switching the power domain to
> hardware-controlled mode. This ensures that the bridge FIFO are in
> reset state before going for mode switch.
>
> Reported-by: Birk Skyum <birk.skyum@pm.me>
> Link: https://lore.kernel.org/all/20260913194707.91885-1-birk.skyum@pm.me
> Fixes: 95a337f92f0a ("media: iris: switch to hardware mode after firmware boot")
> Cc: stable@vger.kernel.org
> Co-developed-by: Renjiang Han <renjiang.han@oss.qualcomm.com>
> Signed-off-by: Renjiang Han <renjiang.han@oss.qualcomm.com>
> Signed-off-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
> ---
> This is tested on X1E80100, and is applicable to all VPUs.
> ---
>  drivers/media/platform/qcom/iris/iris_vpu_common.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/media/platform/qcom/iris/iris_vpu_common.c b/drivers/media/platform/qcom/iris/iris_vpu_common.c
> index e4847c1077097160cfc8324e807b4aabd9747812..2ef8004e976e34ac3e5ad1971894253fee77648d 100644
> --- a/drivers/media/platform/qcom/iris/iris_vpu_common.c
> +++ b/drivers/media/platform/qcom/iris/iris_vpu_common.c
> @@ -311,6 +311,11 @@ int iris_vpu_power_on_hw(struct iris_core *core)
>  
>  int iris_vpu_set_hwmode(struct iris_core *core)
>  {
> +	writel(CORE_BRIDGE_SW_RESET | CORE_BRIDGE_HW_RESET_DISABLE,
> +	       core->reg_base + CPU_CS_AHB_BRIDGE_SYNC_RESET);
> +	writel(CORE_BRIDGE_HW_RESET_DISABLE, core->reg_base + CPU_CS_AHB_BRIDGE_SYNC_RESET);
> +	writel(0x0, core->reg_base + CPU_CS_AHB_BRIDGE_SYNC_RESET);
> +
>  	return dev_pm_genpd_set_hwmode(core->pmdomain_tbl->pd_devs[IRIS_HW_POWER_DOMAIN], true);
>  }

Reviewed-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>

