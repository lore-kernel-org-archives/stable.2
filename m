Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEA173D3D1E
	for <stable@vger.kernel.org>; Mon, 31 Aug 2026 08:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788166331; cv=none; b=rjQXni2Wsa+sJVIm59PYfuU4mS/ZJ1kPoAD5lmV1He20CDU9/Xrbz8pGhNBr37ZJwqSkoxC2UhudeURY6g6TL1/HChfbV7fUiT/I2Btyag3JEREwJUTzrzXMSsY8mkUnNlNIfTtXtTtlQ/Ji4Qg9tj0fbWNgFOj/l8Uu25zH89I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788166331; c=relaxed/simple;
	bh=+2hOgK8tLcdWYDNwQNgvsfIaBdx8Bs2buQwhXdccyfI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RYwS1EoRzW2mzKxKp0y3H8OmH+bE6FoTpNQvULo+YNg8pUUGP/yI/mIxSeghuC1rOW/LDuwo5DV1acQAZ6sOs8v22qrpjmdzF/WWigxZ1Iyqy7W0Gve2IUAFn9w9kGnFNV7ooOcOvOoM/df1zxhKjJcoy6LFtOqntgN9Lz98NGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Cb9qiPO1; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ZKr0lqgg; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Cb9qiPO1";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZKr0lqgg"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67V7xEDW2332294
	for <stable@vger.kernel.org>; Mon, 31 Aug 2026 08:52:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	palpmFZZO8X/xAXI6fll/8vpW1RA6tZdCLOM/AIPfzE=; b=Cb9qiPO1ic/fp51i
	A9Y2ZhtgOkhSln+gHhILBIxKRU9q+EFTQfIhJ4xKf3wSbJzN0zhWjc1wjKvCjW/J
	20tRmMpCyW+/6NVKa9ju+y4z34Z1xhpfyAlboEeTtuW95Rucj6k1F4i1tL719VRR
	H7wYpvc/yeIs2lWB1lSE8pg+CBO0IWoWkT6ey/hVX/H+KRECt+7Fqi+odS+2dl0A
	qFhZoqADFb0HvLuYkRm1kwuOOxblBsRmGTx5jITenBO5AvipKEk6e0kwpMD4rdQU
	pwUrlCvklDqEPsTAtZqr77iOoDzCBPICWFBDq/2a/PhbXYlmLsDkqzi2JheDwFRQ
	RC/M7Q==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gbrq85c1m-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 31 Aug 2026 08:52:06 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-38e11baa66eso5503256a91.2
        for <stable@vger.kernel.org>; Mon, 31 Aug 2026 01:52:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788166326; x=1788771126; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=palpmFZZO8X/xAXI6fll/8vpW1RA6tZdCLOM/AIPfzE=;
        b=ZKr0lqggpERgyt2PwFFpwRR8N/Y327I9zHYwv6x4DsUqaHWXIVy7Mys44Brv3aA572
         ntoZQkBy14LK2sfd2PRsq+fVZpbd0Md5eIACexD6+JeeKSqPl9Wjj93X72cGHHq267CJ
         4WiOIP13ckxyKa5a/Ph7Rz1EV8dyMeNwi6tZfpkZlNK8g6hxgtCTyRmDhx2FfL16vR+8
         Bw0Hk7fu4+ZDJZclWLS9NqsLnD7fw8UqvPFwVABNIf68nsEroLoL7/mTDKftnbRfRkqA
         QdoowKGdsDlSxD5XGSD6IAlG2t4nK+C0TG11xtul8vsyRRbvfv+bAkxCx3R5WwCOHITd
         XUNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788166326; x=1788771126;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=palpmFZZO8X/xAXI6fll/8vpW1RA6tZdCLOM/AIPfzE=;
        b=PYO9N1m/W0ZGpN0RxnS4lYxTVcIYBeYfn1dtBaXJbJuDTaQnCYJ17q+JBZ7822ILro
         JB7D7HI1/ZN/BlmZXVv2yZl02JdhzwcYKXwRbWh0ZUMzB2UmJw9AQRllb6k7XQvuNQee
         EaS9XdbR9c1OXKiRmFGCkEPQ9cYS1Utk/8SdSwTeEKzHOSRb/J49Ulur1DAq7sGkHgr5
         Vea7B/JafCGYdPGi5jIaxSZ0gREMWechZRtdbOoGXX+ICIY3hjbxhlv1wlHZtsTbXFOP
         YXBsivgB7S+of9ZL3xvAEWByb4nLfkgK4YxYvMevi3XgcrwSmHEqV/YC6h+jQbkrRb9N
         JGgA==
X-Forwarded-Encrypted: i=1; AKwUvBwZeVIFJTUMNcIb0OurK4RPNzfZ4t/SQtk7q3L3LUgaGzRVReHICqXcygTrVd49eUmFGb5Kh7k=@vger.kernel.org
X-Gm-Message-State: AFuF++nfcJS0M7ij63hr7WnSR2xtaWbE/Z2O4O/wNhux68Bz+b8tAP+m
	1FJZMW448/CmikjVPwYzInjj8yf5GRcRdEDr/LxixJTfv9Nsk8GTqyTT99ayWJR4YFbpieaNSZI
	qWh2BMo6WBMbqmSmjch3jGV2oF/tPwOKNMyCIRdNIJiXI3aOLOiSOIVvGN10=
X-Gm-Gg: AYBFou3k182zu30mi9Zjd5e3ds25q1N9XX8RJnPCyNIgbZRs7BUUypO3QQrmJaEA9du
	3Rm1vNF7rnFKHrrgxEpzbjro2xcRMusjVVEIv26Ep9anM54c21LKcKybyq7LsIWRqgVPdLqgpaL
	RmJfZtCDghk6DkaWXZtUoAKog5g6yroxD6X4REiCV0UADovTmA9grwTkCiuVWNhbiSQc82LvB35
	kTWsZDJ25RBRmAC/kvM+oEwNms8U5icoMsPXBuqDhJ3B3ghcQM14j9TmgwxnMKKrhRJ+yYLb6n5
	vUbcTHjsmLx+onscTWKhHLuYoS65LhKEf0w+X9haG2R1+LAlI/WwQhhNgedeBipgdrPmIwhVXQn
	5mrORVBTqFsoI+89q/41B0SOb9RIl0aWJRQ==
X-Received: by 2002:a17:90b:4c45:b0:398:ceed:6d44 with SMTP id 98e67ed59e1d1-398ceed6d9dmr12393501a91.25.1788166326204;
        Mon, 31 Aug 2026 01:52:06 -0700 (PDT)
X-Received: by 2002:a17:90b:4c45:b0:398:ceed:6d44 with SMTP id 98e67ed59e1d1-398ceed6d9dmr12393440a91.25.1788166325630;
        Mon, 31 Aug 2026 01:52:05 -0700 (PDT)
Received: from [10.217.218.20] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-142e0df264csm46282736c88.14.2026.08.31.01.51.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Aug 2026 01:52:05 -0700 (PDT)
Message-ID: <8ec899c7-61a9-45cc-b332-a98d2c0ac344@oss.qualcomm.com>
Date: Mon, 31 Aug 2026 14:21:56 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] i2c: qcom-geni: release DMA channels on probe error
To: Shengzhuo Wei <me@cherr.cc>,
        Codrin Ciubotariu <codrin.ciubotariu@microchip.com>,
        Andi Shyti <andi.shyti@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@tuxon.dev>,
        Wolfram Sang <wsa@kernel.org>,
        Ludovic Desroches <ludovic.desroches@atmel.com>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Frank Li
 <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>, Yao Yuan <yao.yuan@freescale.com>,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Praveen Talari <praveen.talari@oss.qualcomm.com>
Cc: linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, imx@lists.linux.dev,
        linux-arm-msm@vger.kernel.org, stable@vger.kernel.org
References: <20260827-i2c-dma-channel-leak-v1-0-271d4adc03a0@cherr.cc>
 <20260827-i2c-dma-channel-leak-v1-3-271d4adc03a0@cherr.cc>
Content-Language: en-US
From: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>
In-Reply-To: <20260827-i2c-dma-channel-leak-v1-3-271d4adc03a0@cherr.cc>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 4Rx-zjs05kzxJxoZhQrNg2dbB0IjWs_1
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDA3NSBTYWx0ZWRfXxaRmT1L+UD3Y
 Kcbni8cGcR0rUJiT9vl8Hh1PKzSwbUE7kxYybFIhfYbtxC2cd7lnF8YvbU0vj8MpREjmRVEZqpW
 DGGBZvyG2H5+txGcdeI8Q6Hy0IzirK4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDA3NSBTYWx0ZWRfX0wfajNoD8U8/
 EfOycTTB6OXARERNDiSQaaD1C9GCrQ2N4uagfD8hz6XnkTVpcIuHHe9xfTgLKFcu9z7HK8Yj2OM
 3XaQqSLTdtodHsqyuX/F9GdHtoPCLIwPShiiP3eTicBFDbbXGYl1z7nuRdV5hToBIfsPYEmWRuK
 12y9PvF6Rb2xGgaJkj+BRicVqzKyj8IH706UyScVgW2j1GhHhtVwj1YsdMVUQN4XqGYHxNpVRzM
 jWycOXakzKZc+5A1ARa9thQZfux6iWeY6tXuEYlvnNO1ilKej/0VZyS9VtTw71fn7KwUvSm83rk
 YFpN7NTVO5cGUa321GCkD7SFK4XlBH/loIFCk5kJsP2nl9b4GKHdD3UDeHhR+4iHVUT0uqVuyQz
 9OdgdHTGjSlMHswtuMDzHpJuCueh+EBevSL+FTvk76j24xsyHL02WHMGPbuP7+KO1IhXoKJAgYs
 z86u4neTOVMUzWgL6RA==
X-Authority-Analysis: v=2.4 cv=ZOPnX37b c=1 sm=1 tr=0 ts=6a9540b6 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=FqpsaMCCsM1CaQCKzz8A:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-ORIG-GUID: 4Rx-zjs05kzxJxoZhQrNg2dbB0IjWs_1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_03,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 adultscore=0 bulkscore=0 impostorscore=0 phishscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608310075



On 8/27/2026 9:13 PM, Shengzhuo Wei wrote:
> geni_i2c_init() grabs exclusive GPI tx/rx DMA channels when the serial
> engine runs in GPI mode. If i2c_add_adapter() subsequently fails, probe
> returns without releasing the channels, because the remove callback is
> not invoked after a failed probe.
> 
> The adapter-registration failure path used to release the channels via
> its err_dma label; that release was dropped when the probe tail was
> restructured into geni_i2c_init().
> 
> Release the channels on the adapter-registration failure path, mirroring
> geni_i2c_remove().
> 
> Fixes: d8d3bb127ad1 ("i2c: qcom-geni: Isolate serial engine setup")
> Cc: stable@vger.kernel.org
> Signed-off-by: Shengzhuo Wei <me@cherr.cc>
> Assisted-by: GLM:5.3
> ---

Reviewed-by: Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>
