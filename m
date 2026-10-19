Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A10340099C
	for <stable@vger.kernel.org>; Mon, 19 Oct 2026 09:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792400904; cv=none; b=RkHuSyYldjZ6MS7UFOmp+Qu//06m7iAacR7VSxmZDJF650cSw8NNrlPf70nO4J6yZKSByne1ZBUHw1WutibP5ulwAoZxfFiJf1+lO/B+Kvye7ustf21Z+Npp6nqn6+BWut8xSQ/r37DX8PA0b0Srgz8m2+O0+GZAYKTZZfqY77U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792400904; c=relaxed/simple;
	bh=ANWtDHrUN8yaLtWHmbxn0S/UOd3W2HnelMg3mN8P9Sg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Qx19RngKM3TFtNu5IU1FFVA3b3fVoVNE4mRyIJRHWnfP+rOptvpzv/w+SHYz43pD++jvG/3ibz9UJT+0/ykSLW1cEiPIEoNdon+ngv9iF5XHuKcxePM8A6giTCbm/drtPF3LeyxTL9RinXM47YfpbHjS6OIL+UiDeU8q8xvKU2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=He0AHl1x; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=SpISH4L+; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="He0AHl1x";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="SpISH4L+"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69J8P1Ii2042000
	for <stable@vger.kernel.org>; Mon, 19 Oct 2026 09:08:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	iDOJUKPZ+vd5FVmRMKIpfjJCtt51gYVRZlZPGq8hbR0=; b=He0AHl1xU03PyNTv
	xDsm+upddU4Xsx967MQJT4Wt34HjxqKkeRZI44q+7420ZbSnex0wMlSdCpI7KeRS
	CkovQFWNZYbFqwMK1I8pXSatwO89sH4ShObIo0auHRPtOBek18pZh4iiPhWcKcJG
	sPqmATo88qW7jjs43fw0bbAgcuR2ZcG8BQ5m//Qiom59mQ/zXYJ5FaSxHGNasN5H
	qg1pnEk9iBohfJJITAZrEiILn9wSbAzyOViIBnWc4/1Hq9sbrW+lxiEpMK1ywBkT
	+PgTeVlBqzSnySNuH1a29xXmH7uT5jgfbT50qWkSKq7Lt1nSAhazIAELbxuBK8I7
	+Z7KAQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hd5ur1y11-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 19 Oct 2026 09:08:21 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-934a8cd3a8bso38179585a.3
        for <stable@vger.kernel.org>; Mon, 19 Oct 2026 02:08:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792400901; x=1793005701; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iDOJUKPZ+vd5FVmRMKIpfjJCtt51gYVRZlZPGq8hbR0=;
        b=SpISH4L+31opgNM3JGDUOi3zMxXLD0wmm0NdEmcLbeyE0577We3FZGyDzr1ozT2jQ0
         kqA9deawQpXBSNR1BqBcVAr3a3DSmntlg0vn1IOYic9Pk8PIZidx+42hO3gLHnu/uUsa
         byWa/AdRkXGtKrO1f5atsbavMSE1OdLZMIZI/sUWWTQFxE/tuyW/HpyhB6fvJnR0Ap44
         xq8EhYn7h+G9Chfc2xyuaLQ+oibPUXf/arLBc38hVkSVplvWbTYZ/P3Luo8N855zFWUo
         i8+OMMY7f+gdUfhwrq9vn9BkFaWUS4QTNArzlnWoov+wH/+2HaZQ0gk34nfJU1hYm+7r
         sYUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792400901; x=1793005701;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iDOJUKPZ+vd5FVmRMKIpfjJCtt51gYVRZlZPGq8hbR0=;
        b=oAK1jbUK851WOLZX84UU90rFGEYJea10OqO8n/7NYesWYru/9VOGzcr3rfRrGMjr56
         0tDdADAc8HSyk9CZEy5wyjv6PP+p0JE13QQOdOk30p+BMRNcJpE77d4VmQHurY0FwXhP
         fvAp37OhK+XDCPAJpTueLYGhJRCNZOukGoKjEdZgQ7kt0xYgzD3/VN/twFv/PRtm13YT
         Y3uRHnDfTAQrrVLnrp83/XFxLDUBLwTjlADA4CHnheehC2UyFH/zkNcyxJhGRToAK0/M
         av9dlsE9Z78s67SaXU4K5cih9RJQEeQ+KdfirOOtGT1RoxfbPvDCybiOKSd5afV76rnk
         CqrA==
X-Forwarded-Encrypted: i=1; AKwUvBwd9+g5/376kSuV+6kBIcmBPsv+nwdEYCowwHaa3m7amgcZzt1dIqH2n1CEtiU2bej1ErBSitc=@vger.kernel.org
X-Gm-Message-State: AFq9FYKgn1QV7CrEZBRQMBpsKQGfk4eEfNZBExG3/pSrsWgtXtlKV8vR
	Yc3IS0TfWHiCr7IaZuSLNohAi3Ygil5xpU6eexMbEwNS/coe6N6uqOqvw/dp8+4Aj4bx5cwqBoP
	2eN7j3uPlxam6RYy/SDWF2vPxdC1rO7M+V1e5kc49jbXg+S9iph9dpNN6zxg=
X-Gm-Gg: AYBFou2p2K/gNAki+Pi44rKZPRvZQXvFtXiJrAV9WaMGZ+KhWBfOLtTqZ/3yggNHPe3
	NTgTY4u+U4D5FJK0vfFDTecCKhLlIaSojON4vfUQwYfL8WPVtQatCN1B7OxGYNrJwltQFRWLYLx
	28nwuu0i3Cu/nqug8/3ku+vQIC6CufbjXKW6m5PlUMDyhMrmUdOxegQP8+Fiww3SN+eJwGhUQYm
	kzq52S3gcV6dlEPT0AR7UlTjw4ayHzpCih68stxvt9PPdgsUsQVDd8/3IrEzDDafWR3QHaMdDnU
	fl8t+fbw/CR07dxR4TnzarpcjPNVnMTj3cegJMWTEh/mZ164ysPKLVRERiDhcFFBUF7JB/fgQPs
	Y6IieagAy1FcEv1w99C2MvQ==
X-Received: by 2002:a05:620a:4452:b0:93a:14c:329c with SMTP id af79cd13be357-93f29b38f59mr1324501585a.1.1792400900972;
        Mon, 19 Oct 2026 02:08:20 -0700 (PDT)
X-Received: by 2002:a05:620a:4452:b0:93a:14c:329c with SMTP id af79cd13be357-93f29b38f59mr1324497185a.1.1792400900469;
        Mon, 19 Oct 2026 02:08:20 -0700 (PDT)
Received: from [192.168.226.26] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c4090dd10ebsm339452466b.22.2026.10.19.02.08.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Oct 2026 02:08:19 -0700 (PDT)
Message-ID: <20553686-c073-4b13-a23b-a4936da33dad@oss.qualcomm.com>
Date: Mon, 19 Oct 2026 11:08:16 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/msm/a6xx: Don't set GPU freq before the GMU freq
 table is built
To: eng.m7mdhashim.1@gmail.com, Rob Clark <robin.clark@oss.qualcomm.com>,
        Sean Paul <sean@poorly.run>, Konrad Dybcio <konradybcio@kernel.org>,
        Akhil P Oommen <akhilpo@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar
 <abhinav.kumar@linux.dev>,
        Jessica Zhang <jesszhan0024@gmail.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
References: <20261018-msm-gmu-freq-guard-v1-1-dd92dcccee86@gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261018-msm-gmu-freq-guard-v1-1-dd92dcccee86@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDAzNiBTYWx0ZWRfXw8V0lRXHX6S+
 v/nyHcBnQSL2rUYZ9E6ivFn+Kt82gnRH8R7MsB/7UZt8de1tSnjZzoiPwCV0E07AYiO6EuxrHfg
 j5p8gKfLyLK704GSZIjAufwdzImenq0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDAzNiBTYWx0ZWRfXymjfjrli4/pJ
 QnRyQYV6NNZOr1f24wn7SBwtJ+n/uK0bPCHfMmhGkFm/0sMkOIxmjidpWG+exyy5FgqGwJ5VJId
 oggLlT0vGEK/+6gPUDnT0c2/v8mLgEC54DO3KBi4T6qg9nbsGhfd++LggeQUX4tlD5n5FmqQ9j+
 XGT/LSDvMOL5eLEtfUUjj0+V8o4n5f75gpvCd9PWjHqydezX9Upu1jNTlb4vEGLihNcWTdhU8Ou
 +/0x+rKD6ei3UWeK01NmrtSfxP+PAl50ZNyE4JxBQCMs4zkBOxlZyZnMXVXPI3OdAtYWQpw8oQL
 bRPON0KgO0tCh3iFmRCzuUMkuLFKFXNdIYz/aoEumP0bsBMrGt2G19Y3rbAEkQfbMRjWiM399Vd
 DPG8Zf0yMGEyNgeve31W9H+azrTHce38Fncoh7fGeEpGSdGXf3nLDY8nnCPG94vkXFGv0600++3
 Ri2Xt/qaXBfoA7EyUmA==
X-Proofpoint-ORIG-GUID: by_s7ILlDgSJpAQUrr8Z2tNDPQH2_Edk
X-Proofpoint-GUID: by_s7ILlDgSJpAQUrr8Z2tNDPQH2_Edk
X-Authority-Analysis: v=2.4 cv=CP6/zhrD c=1 sm=1 tr=0 ts=6ad5de05 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=pGLkceISAAAA:8 a=TId0fF7HYP2RL42ZpU8A:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_03,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 clxscore=1015 suspectscore=0 lowpriorityscore=0
 priorityscore=1501 spamscore=0 impostorscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610190036

On 10/18/26 8:29 PM, Mohammed AlHashim via B4 Relay wrote:
> From: Mohammed AlHashim <eng.m7mdhashim.1@gmail.com>
> 
> a6xx_gpu_init() registers devfreq through adreno_gpu_init() ->
> msm_gpu_init() -> msm_devfreq_init(), and only afterwards calls
> a6xx_gmu_init(), which fills gmu->gpu_freqs[] and sets
> gmu->nr_gpu_freqs. The devfreq sysfs node is visible in that window,
> so a write to min_freq or max_freq can reach a6xx_gmu_set_freq() while
> nr_gpu_freqs is still 0.

[...]

> If you'd rather fix the ordering, so devfreq is registered after
> a6xx_gmu_init(), I'm happy to rework it that way.

I think that's the cleaner fix.

Konrad
