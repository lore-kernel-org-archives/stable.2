Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29D7D28FFF6
	for <stable@vger.kernel.org>; Wed, 10 Jun 2026 13:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781098014; cv=none; b=B6FD7KYOztml43ks1xHixvO+evEqGRDUPLE3CULwsmJyhqRsaft839pMIBORhGsj12VZLeow81MDsWdnmF2uNSdRrThzW574p6Qj2qGmQWTT4RgRdhHYuPsphMCRCNCm/HSWYbf2VWMi+D56S8OHw/jsG8dkM4Krr6zlAcJ2TsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781098014; c=relaxed/simple;
	bh=m+xt0OKMYFPGrtA47zn/bJ/T1qaTtH9D6LA2llCivto=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YSchfKVuIuBEY9Tjjj8etH1ffZzAZpAXPnqAUN7iueyGaxwPEc7CDiapooO3oGsl4yrT7bvP4Ks2L5v1bybiGYY9Ki6YCmN3eNS2DMww9HCBfCLinSHAxQdGYxLcJ1zc4QZNn/Ixx8ukoCGsDojWqBDZ7nhC8KHs3El9oBR+lNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BgDWq7BF; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=SQk3wCWe; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BgDWq7BF";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="SQk3wCWe"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65ACCHxw1472585
	for <stable@vger.kernel.org>; Wed, 10 Jun 2026 13:26:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=cPyo9aCMcqtXkO/xZlkG2ODm
	crf0CwEfPgyHB6erVLw=; b=BgDWq7BFEs61H3EmbBL49tTQEvoLxKwLqx6iz9e/
	R19ukDcAFzK9ExVmDINW5GSoTXXFIfWzxVuX4WXDeW7Qx54adPgfEXKMp4Azf3uy
	Xofd1J/BwOnFuJxR1HK4fWCNDTFvGmT3GVy3X0fpofj3vHft2/xknsk6ClVTshCr
	TAYkOD6jBkTZEyaJpRs7XKxfBKlwa3Go+mPc0o9GpgTPGSS1pS03/E9Ybw0Hs/AV
	YtpzOsqQIx1YjQaw25eC8+8Mt6mYVLpdxNLC0uOITOaEDJZZRar3lNIlwvGnKdQQ
	9Nz4ePhUNhSxyG4NhKFDbBlwox29dZ+4omgBSoat3idBKQ==
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com [209.85.222.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eq0kda1de-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Wed, 10 Jun 2026 13:26:52 +0000 (GMT)
Received: by mail-ua1-f69.google.com with SMTP id a1e0cc1a2514c-963df05f08cso1752506241.0
        for <stable@vger.kernel.org>; Wed, 10 Jun 2026 06:26:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781098011; x=1781702811; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cPyo9aCMcqtXkO/xZlkG2ODmcrf0CwEfPgyHB6erVLw=;
        b=SQk3wCWexmPlmqiMlD5sacB2s6pTdMTy5Iv02o+cm5KyWGCxoDWxaJMFm64xku+mKR
         C7tx343up6JPHNi9F438tRTvzdP6mxT86U6NS1bwBnOhwNGvgQSS89Jl7F9dvSJ2oXBT
         4Svk7GZYcsksRUp9/rUuD61CFf1ul/0Gqvxgu+Vl3dUe9lEzKd2YyFjM2PSATL7z5PQW
         SSP3D53hVuE9dXec/Mib4egt6BUvxNzeSmGrhr/WPKIzrpr+UL3qp1Uf9toLO7nQ2koP
         e8RZw7snmfbed/nCtVBvzRLmgFjY3U1t8bEtHWUuvsfJtaY3nIk5bwucwTqNzY1f+6aW
         jjXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781098011; x=1781702811;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cPyo9aCMcqtXkO/xZlkG2ODmcrf0CwEfPgyHB6erVLw=;
        b=m0FcoTeudmkuTEcgQeAhv0R1DkiO1jcnn1EJyq1qexb3seoPE1uTjSS/9bFBEpizd6
         /DatZOyMZy/80QJaPPUJ/JlM9p8j3/nlB8gzKhjaH43yYtXbQ5qgU8WGfQB39t2BC3X9
         EBH9mn3XS4cYna8NSYvNofz75N/+qZMY3FIuwrHc5nodEEVLYwBHeKTfdVqRAkPwhvFe
         cj7qngBsorH/O2t1rt08gG89A90k9iTquDDbf0GK2C+F3utwqKIr3heB3mPf3TZmFSr3
         Db1OQ1f8N5cfLVqG/+Ivlb6JBDJoEju9GjhRaXd7DPD6J1TGJkbDYAiOz68Ybg3uy/UK
         heQA==
X-Forwarded-Encrypted: i=1; AFNElJ+TZth1CWsG/PPjJmq0Z2FyavbXy6kGS7B3favduKDlaLth4uL9UACH3NZ4zMqUAEWcGCOPS3g=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQ3CyAvMwwdUe/rWo3h6JLfBLzsOhs/Nc7AxHfqOTdStktfUaS
	OQu0jgzEhuSgYIegBvi8C9YHpXfvLpztsRGh/jIyEjwWF/XJJdnWd+3lFHqnti1/W6T3zBEiyuT
	ZDdRUfhL5u1wjyffNeU9ACccZoh0ekoz/D+hwwewPFq19vyVOcVFkyynw4uU=
X-Gm-Gg: Acq92OHCqRWktWD1WUXIAF+quJX8ib2uVehIkEgpe7IRDa77WBhR/aYTB7TOWfmUbg/
	WTsSpd6HkugrJzXQYBFG3mpQpAkEKZK7IhXZ//cHSzcJTOBDOF8Rj1KcFoCBvxvc//8DE0hv3cq
	7B2IgkYdxW5w9u9goxfixShKuH3MjSA8e5ky47bQzt0CMj5tBjuRbBSEBxUlxwGYGRKj0UvV4i0
	XdcdyhhARJ8WysVGYcVcybS5C8fwXc2b6u2KEKgoTY//DUhacYFgcZleYKKjsbRfy5V4ZMk08lf
	yixDSSGIMRYtgIjZHYW/WW+dFYVOLLjls7xU59gVivvmW+Z8lQAoKLLu55CLW7w1rU0bC9o5SIY
	7BwCdptolggmS1R5dH7WM9b90CypHXYbTfTv0ls5POeQddqKahzAM+7lvmecAxePpwfLzWXX8pd
	JLywqa9Lw8WjZigR+E5qlsU1IJ7fCKiFQaLB6eJKiV1Jr0Bw==
X-Received: by 2002:a05:6102:510a:b0:612:c135:1b77 with SMTP id ada2fe7eead31-6feff62a683mr13342351137.27.1781098011511;
        Wed, 10 Jun 2026 06:26:51 -0700 (PDT)
X-Received: by 2002:a05:6102:510a:b0:612:c135:1b77 with SMTP id ada2fe7eead31-6feff62a683mr13342318137.27.1781098011112;
        Wed, 10 Jun 2026 06:26:51 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5aa7b990486sm5332813e87.68.2026.06.10.06.26.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 06:26:50 -0700 (PDT)
Date: Wed, 10 Jun 2026 16:26:48 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Mohammed EL Kadiri <med08elkadiri@gmail.com>
Cc: quic_vgarodia@quicinc.com, quic_dikshita@quicinc.com,
        bryan.odonoghue@linaro.org, mchehab@kernel.org, hverkuil@kernel.org,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 2/2] media: venus: fix payload size calculation in
 parse_raw_formats()
Message-ID: <n46tdwyiol3c2br3epxh3lffxmxey67qt2xbrbwwwtlolvcdk2@4r5mj4hmy66e>
References: <20260610125655.10517-1-med08elkadiri@gmail.com>
 <20260610125655.10517-3-med08elkadiri@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260610125655.10517-3-med08elkadiri@gmail.com>
X-Authority-Analysis: v=2.4 cv=TeamcxQh c=1 sm=1 tr=0 ts=6a29661c cx=c_pps
 a=UbhLPJ621ZpgOD2l3yZY1w==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=VwQbUJbxAAAA:8
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=uTaGIaT9vMJbWL2ccsAA:9 a=CjuIK1q_8ugA:10
 a=TOPH6uDL9cOC6tEoww4z:22
X-Proofpoint-GUID: 3PgU_s3avWNilnF6q15Vl0tqHn7kUh5R
X-Proofpoint-ORIG-GUID: 3PgU_s3avWNilnF6q15Vl0tqHn7kUh5R
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEwMDEyOCBTYWx0ZWRfX4VRgI5iatbi4
 WhIjpZzoLYE8npocqtPB00yqdX7yfxLwk01L9IZVn6ns/COMRcFX6T0uwxljlQ/KE3bgnG6fw1D
 z7PXB/NVqvwJE0Yk8SpnhQdjmgfwMT7kCclF5i5UeV0LiWmChkMQZ/kbboB/MsK3/NDFXsPZT1D
 c7VZjePqTLTTRNdVLpGWyZoo7dzKAam2Wgx16zfbfeVS/v2yzcEPjplJ97YScvg7qLQ85iJMNAc
 ME8JMeyrATlvksghqFa9w+Fdi52tkW9gyuM6NuUQAkSlVuYtPhWJ2qxrUjQUtXrTzK6HeTaAKU5
 PRZd3rH0c6QlMdJRIrcLt/f/QxaONwi0D39js0bpNoA1KdWXR8Mj0x60jiCkbVV4AkkI/cekFtk
 opp7R0rxlGdnJLPSx+O+autszWRM1KfADF+vEpe1pjejAPU2mu5az55lFBRsj3cxtSIPrpl8j+4
 GMyNS7EjYSa+21+ZO3g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-10_03,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 malwarescore=0 phishscore=0 spamscore=0
 impostorscore=0 clxscore=1015 priorityscore=1501 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606100128

On Wed, Jun 10, 2026 at 01:56:55PM +0100, Mohammed EL Kadiri wrote:
> The consumed size is computed after the loop using the num_planes value
> from the last iteration for all entries. When entries have different
> plane counts, this produces an incorrect total.
> 
> Accumulate the actual size during the loop instead.
> 
> Fixes: 9edaaa8e3e15 ("media: venus: hfi_parser: refactor hfi packet parsing logic")
> Cc: stable@vger.kernel.org
> Signed-off-by: Mohammed EL Kadiri <med08elkadiri@gmail.com>
> ---
>  drivers/media/platform/qcom/venus/hfi_parser.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
