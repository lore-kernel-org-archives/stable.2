Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 200F828FFF6
	for <stable@vger.kernel.org>; Wed, 10 Jun 2026 13:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781098002; cv=none; b=fZfpH3/CmQabqSugRJU3z0SS8RHroIQu/drWz4DtUI7xE1JTdQfERAkNa3lbpyyXzHsDAol6+/rIDYN82EygjokCYVEGTXDbi5p6iZ/aPzYMJQvolTRrA6HBvufy9AjjGNC0ywtSn2h5Nrg866ms5YXrukm4eh0Si6YNBsnUn7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781098002; c=relaxed/simple;
	bh=2M2q41OtBWgY2Am2LjNyc0iL7gSnB5ihdyNkg4plOWA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u6/aDhxoMeNgwvi7UUTvQGYCxKfEcvMtyv30gFDicQpm4CQM7sHJH35E7hOp+/Q+SEhpycdtFjS1qtspkCIWXcUptRjPxdCkgi0wJ5ed466kZ1t/X/GT9GTWzOi9JMDfhdhO1bFaHeC5bjXYjiM6D/XJiGl0mj3nq7nhuZEYwBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=k0zc5CRj; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Rc7dodUg; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="k0zc5CRj";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Rc7dodUg"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65ACCGtO1607877
	for <stable@vger.kernel.org>; Wed, 10 Jun 2026 13:26:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=hamOhHe/t8QAdeAMj8Ua1YUB
	t/FdWZO2oEFl5p9GAOg=; b=k0zc5CRjCHshLDdhSryPwwLfcD19Yzzyd+QBUuKf
	tqgP1eyB/+mn2t/NOXK8YVnAF3NgMxbtkne15sgIZ9IaZouo7m2TW2gvt8WPUOMX
	F91AwMp6QuVajkxRaiSHlUoc/D14b2/a9v+/SfCSrg1fHDaJlU7wvsQgKA3apnFz
	Y8y5e3Tl5v9P27bNdTTAiY2PBusZ9JeSdyaV/qybYGVtFfhhpJxd+lK1Kza+IL71
	gOO9fuhWSoPXA0m7WuSXaRpzVQGL38PHgJAO/O0U3j3dnphdOOAApULPCAt6twOl
	UbAWdX0TlB1n0Frj0Pyq8TVqO2zUTyrWuHDGapLgumsrzA==
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com [209.85.217.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eq10a9ywu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Wed, 10 Jun 2026 13:26:40 +0000 (GMT)
Received: by mail-vs1-f72.google.com with SMTP id ada2fe7eead31-6c67361f5easo9515115137.1
        for <stable@vger.kernel.org>; Wed, 10 Jun 2026 06:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781097999; x=1781702799; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hamOhHe/t8QAdeAMj8Ua1YUBt/FdWZO2oEFl5p9GAOg=;
        b=Rc7dodUgyZUPeLRusxK6kxSdPX9Axa+LvO+nW0mWAT4lIpIkznZBfyPNr+mFKdob6l
         6Wux2hLZQBrjlSpcnH0ZU6lEOPScWo6DWTJ4PvJyVnyroIIUAHPrJzbr05iGY5Ceeak3
         mbvIvYu1+0WCcXtcSJ0PZmmhHRWym0hzVzgtjlqZJyYKY7WCre+4el/9QBRQxs2ffyLs
         NwAOIUWZFC+6G2sYte5D59jWqok2zOeszaDWb3GvhOj5Vpr2aZLnotDTnz1eYX5GmemD
         W6iZ72kF2y9s1/cXieWcUGYtkN+WBN1DSeI5WoXJBPvknnT5GFRRRvipzpmBbLOKddFR
         wIUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781097999; x=1781702799;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hamOhHe/t8QAdeAMj8Ua1YUBt/FdWZO2oEFl5p9GAOg=;
        b=c+O3QkhJHIeKG2IkGQtH6v92iGKH1ILtjH2r5QaBeBHnCC4dr5rxaT4BxHtyWvBDLp
         i7iuta7kwFvOmdpi2fWPMPNsoGDnQSp+ca3R5OPnKwk4BKrs4kCfoXedYLrkF6RJRpeY
         pk8yYhqdKXa/8d6KCGlYs3/zLB41PxTXoDYdjLGIcOwXtHzhMVJ/lQFmmbxlLanmb0Ct
         acAyxQ0TyNZs+EzGlm7MYazELNC7NTfu8vQM1JH65MMFTxFZQV6kMFmxh9wdDVGY//uv
         I4VHncjh6sSiwpkmPqpJcMK1qHjZYYaIpOSo1LejcMv/qkdQzoKgaYzTXcanAdjViYaX
         etXg==
X-Forwarded-Encrypted: i=1; AFNElJ+l8k6e6EEo/xOEMLlsHJIav7+7aF10h3vqoRyd4hDabP4GusVuxmS6kckqPLdeF5zN1sj3Jas=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDG28CGyqXODcikua/isbD/DcVMxD1M8CQJF35qF6asejszLRQ
	dnFEfZBvHJqYXn5ZHcBpXUpTk/isKaVgd2uO4gZXyBJkHlVESyOcIfFWSiTNWd8EiyNkMUevpSk
	O+E4D5juXCGnEEqmflVCGBEcVpoSgyll69kxGLQcDReW79mZNp4Tui5F+I5I=
X-Gm-Gg: Acq92OG93cIsqzmCuLXIEF77kD/UONrR49tPKnA5slvG1S2Ke7n+h7SJGHkmMBFpR/o
	T2vKgJrP66WF2Nj8BigXgvJXvNsLZrdpCCV60vqsCY/yyz+V2QiZjym4icKMDcl6zgctPCO8FLC
	Ix8QYJwiefJuqpiZW6jlFGASTKmy7iZD6YJ8SyBXMGgJRZl/RzxrRs5Bv2rZvpoIaIOL5HEQVpX
	CNS7tenYCmCoN3BLf8VzZoTA0jUdtmlj89ZSYzu1nlTfLKQ/3kNdqUq51IDprQGwgRo678e1udG
	CGBD52qVZBsdpIi6BfTNO6XqwLg28kAeDHdkov2zIl7m4XaVhIPAdywKWv88NBMS57HdYvzQ+T0
	vcyUKepTsTCbZoNv32WKfxCq0i3bi7EeR7qTnhNkajTEM3MAx+0FjRjgPCt8qNE+zltJVkkWIjY
	z/z4v1RmzTOgtEz8Tm73BxcmxN3enk//VgQHjybwbWjJOirw==
X-Received: by 2002:a05:6102:529:b0:6cf:2b61:3fa9 with SMTP id ada2fe7eead31-700359f5a86mr6477775137.10.1781097999517;
        Wed, 10 Jun 2026 06:26:39 -0700 (PDT)
X-Received: by 2002:a05:6102:529:b0:6cf:2b61:3fa9 with SMTP id ada2fe7eead31-700359f5a86mr6477740137.10.1781097998994;
        Wed, 10 Jun 2026 06:26:38 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5aa7b97afbasm5570958e87.50.2026.06.10.06.26.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 06:26:36 -0700 (PDT)
Date: Wed, 10 Jun 2026 16:26:34 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Mohammed EL Kadiri <med08elkadiri@gmail.com>
Cc: quic_vgarodia@quicinc.com, quic_dikshita@quicinc.com,
        bryan.odonoghue@linaro.org, mchehab@kernel.org, hverkuil@kernel.org,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 1/2] media: venus: fix payload size returned by
 parse_caps() and parse_alloc_mode()
Message-ID: <td2t7blr46ltikytckufcqpdwg73ycgepqjc2pvekycp7o765i@b7yyvw2fn424>
References: <20260610125655.10517-1-med08elkadiri@gmail.com>
 <20260610125655.10517-2-med08elkadiri@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260610125655.10517-2-med08elkadiri@gmail.com>
X-Authority-Analysis: v=2.4 cv=GoFyPE1C c=1 sm=1 tr=0 ts=6a296610 cx=c_pps
 a=DUEm7b3gzWu7BqY5nP7+9g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=VwQbUJbxAAAA:8
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=yqHQtdB_UFgTmeLkYVgA:9 a=CjuIK1q_8ugA:10
 a=-aSRE8QhW-JAV6biHavz:22
X-Proofpoint-ORIG-GUID: 3G6zDac-xxJgdUHLDa2gazpNuf8VVjmh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEwMDEyOCBTYWx0ZWRfX5zSlAQtXbUUb
 /cfhmzqv95sbdZSSJuHErUQqaXIbBMCAbRzLcumBubIUiGRPuPC02tclE3MeAYUJOmqb/bPGMlb
 t+4NLa014RftY5r2/h29MlojUfDPziA3y2wqDj/FHTXbFoX4mI8i377dIplDj4bHWAUWgQyQLgn
 j8bTSTV+YZqEwLAjflJHSQwL6WID5zQlRGYiV/L/x1ift2y+WzzztXS0eUkrPlAg3TgE5vHXDG4
 TsR2ZxwhcEr/3mwys7lt8TB6eHddYB8qpRRL+NDa7YzPa7Z7TGH3gMj3Bqnssx1raX2+fLlAII4
 PS4K3cXmdkmaU7PkGW+0JlBMbf7gdCeg71AKs9RLVoFQRSgvco1OprT52oJU+sXUb+wkAfO5MKU
 FNK+/4mlltYTWF+xbJfsI1Yu6hcILa032KXCMauel5K+k4/ipayFXiUcuqal4B0Oz7QusfUG2LF
 NV6xSHJWz0uNmytD0fQ==
X-Proofpoint-GUID: 3G6zDac-xxJgdUHLDa2gazpNuf8VVjmh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-10_03,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 priorityscore=1501
 suspectscore=0 adultscore=0 clxscore=1015 spamscore=0 phishscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606100128

On Wed, Jun 10, 2026 at 01:56:54PM +0100, Mohammed EL Kadiri wrote:
> parse_caps() and parse_alloc_mode() return only the size of their fixed
> header fields, excluding the flexible array payload. hfi_parser() uses
> this return value to advance through the firmware response buffer, so
> underreporting causes parser desynchronization.
> 
> Return the full consumed size (header + entries), matching the correct
> pattern used by parse_profile_level().
> 
> Fixes: 9edaaa8e3e15 ("media: venus: hfi_parser: refactor hfi packet parsing logic")
> Cc: stable@vger.kernel.org
> Signed-off-by: Mohammed EL Kadiri <med08elkadiri@gmail.com>
> ---
>  drivers/media/platform/qcom/venus/hfi_parser.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
