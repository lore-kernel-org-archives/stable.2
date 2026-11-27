Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795810056;
	b=STKZTTJO1R2cfQ2SWFtIxNbresPKBWji42p0gsXYfZs/5TLQq5PASH2i23o04fphgj3O
	 LKtgMJukkMInTnqPumcaWYwuZgiIlcCWOKJvzkTRcKp06fa8qNSCMR0uCji2miFb+I9lT
	 ExqvPKXuqguBMWwEAgG9XPGJO3Afwxhx25dqQuCUW01tT37tmJZnNecyyl5Aq3dpV9TVa
	 Leul/d9YLl8H+fr9fwxlG4OHJYM7lgueuqtzq0Xd9WrGtdqxFzu4JLQQ1MOPj8u2gLH9g
	 AsJkB61HRq8LlxH2daIMbC0v44vNRZRKvEz1ThjFr4D1YS4eridXTyURk6b5tjvMQ6g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795810056;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
	 To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=oh/vzk19jdClXLP1dpmBN9YXjCpwvxMhmfZBVEqASFQ=;
	b=D6XyT8/bwL/iltjZbKH2FTGsxzVd89EhQGR7/RqK41SwbYPDcQbbHOZK0PojLyFIlvBY
	 XX1RsCEz6/Zio1hsuIszG+s1J6w8mJ2GU4UdRstIvfnyKEIvn8OXz9lxYdPM7vgcAdSZ6
	 HJ7wSfokHmoQ6YmUIBqwZ40X+SqHa926R3YYDxfDYY5fNhJJmomEbEaLKTIJS/FtvCCG1
	 zlK7deUWS7WghdMMZwH1vrhIuJTSmKIO55Fi2hXQN/B0XzXOIdxILtkYLajfd9XAZVbPW
	 zQ4KGUpYqv+oylz3j976vScyewVVXmiTRi9v4fdTnSULgaEGSySq5/rsflbjOTdsnWA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=SQU2CaV4;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b="c/0s/R/S";
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A47F606A31F
	for <stable@vger.kernel.org>; Fri, 27 Nov 2026 20:07:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4A47F606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=SQU2CaV4;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=c/0s/R/S
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ARJB9Nd3039156
	for <stable@vger.kernel.org>; Fri, 27 Nov 2026 20:07:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	oh/vzk19jdClXLP1dpmBN9YXjCpwvxMhmfZBVEqASFQ=; b=SQU2CaV42WfJHzIa
	TY/FASVsPYHtxLcb2w4hUwSrnUMTz6jVyF0haDNWqhPuQb+jXkGM6PoaRccjkMOH
	Hc9s/bcQeRTBTrFs4sEyCpjcAg9wdLixKIa4LZXj0rc0LN3+159SaJ8yq9UT+3wE
	axKiPrjPX6yvbKeE60bNuiSL/ud6LsrIFw6D++DYFFYvJ2ASvMciE5OUp0twPS8x
	FP/DuWdZgpCHQ9dcRt7V7RzauF/Apa1fXoJ/SrZwheVNjKPKMj22uFcVlhoYnV0U
	Xsp8D9k8Pb/1dHGFQMhfJchUz/qxMGll8WEaBs1LXDZeW74C0sLVJ4YLG25ArHUd
	CgkNpA==
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com [209.85.221.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j7e4ngde5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 27 Nov 2026 20:07:34 +0000 (GMT)
Received: by mail-vk1-f198.google.com with SMTP id 71dfb90a1353d-5edfa36f42eso5739466e0c.3
        for <stable@vger.kernel.org>; Fri, 27 Nov 2026 12:07:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795810053; x=1796414853; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=oh/vzk19jdClXLP1dpmBN9YXjCpwvxMhmfZBVEqASFQ=;
        b=c/0s/R/SoT5OKiEKm6qu6CW86m0V1nuNxfjnnCMelYsYstTWSHtM7FcmcxIGZdgwUZ
         QVo/0cvfycVsJ4l0+9fjbZbsNywdzNLOq7WwI0JfBs/RDyNuIH+vDPic6tXyorV6bE7n
         x/zIFJMgSIvQ4QxbUtm6AG8+MvzKOPfnymi5RVREV9dQadHUYA3763NqLMK5YNJ0zMIl
         eQKvKQam+vCAfga9kizEc628mdA+5H2NXMgSni/p9dpZ28JYbLIYPUBXrtnxrpawkpaR
         T1YgMAeZcG78GV5dnUzTQ+/kwvN1wXbZh63uCaDwtGRqPHXg5Qis+UHQmFairouA6hfe
         xYHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795810053; x=1796414853;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=oh/vzk19jdClXLP1dpmBN9YXjCpwvxMhmfZBVEqASFQ=;
        b=lS/F9yggpGRsmodYR0+rlPQwt3IUURXUgZNAIX5fV+IVxUycgriYxrNRCkv/eb685G
         cwQeaZPvBbjx9wX9+aR4oJBZv+0+rUYCfRqr0LbLIhR09DlnS4MVmOLGTWLVxagFQ0M8
         ZWqmPf4D0j3b23C9NpKxf64qZiGgqCfnziGF/rZNMCjdAA52znVm6FsQzdtFicB1ljOK
         LzFo4CVRw1XEhaUp/jQTFF10H+fdd30PpWfjKwa7i5KyZ/MbMxn6kzv1icmsyLNktnOe
         X/laZTa/T2kWEPEFZYT7pxnTnBhafAb4ZJFPFqrw7/6dtRVRPi97LmTtnXqBtN2bWfeQ
         2+CQ==
X-Forwarded-Encrypted: i=1; AL+hErGKPWsM5ja2+FEss9hiQTCy2WSrP2YifkaJVlOgu0CHYSahtV5DKvnABxeiW/5jTdyi73YEzLc=@vger.kernel.org
X-Gm-Message-State: APuU4Z++JSbV2q9tGsG4v4nXdU+Ks6HFVZmzxHqm4Z+IIShToRIrMNku
	e9jixzy1ngwjOGbZvCPU9F9pd0JOT94DR20aiYSvXg2JHbJzNWdVvDcTrqNAyeNyljR9snwuXOS
	38IpvYMLEXu3nhcTZ4A2zICibn7bEvohOWe2ap/XOu+yTjYcBMd78gZ3kI0Q=
X-Gm-Gg: AZFdTZdcSfpxoIrQYZruDw8JW+qkQ4QQhdAT0swUPUkxUHVpsTqRgWcHCZggErG9NqV
	U+x50MZvPbbOaF+QT/6DQ5EDwSbHXtbP5KYXD2iPAmNDgcBF7We6z7+PBwI8/NK/309zx6+Kbil
	3ffZqg+WB3Ib4WcaqtlWJQ40tH0YZfkIyH8WFNjn9b2wTmC7LFyao0SyYvYNkhx/U/SgtB8tVOG
	y/GyMSf6bVffF/By5UxNCqg2Hr35wIaLDz6325WcbTFGMt1FzK1EY02cMZA6IJDFVjOP5Y3sAdC
	NRjUfd1dg05my+7lNbdCcjEyTAEb8pKqoo54L5uTUd1tSvSCAygSh1F+Kn6g58KCAsbfDAyHiJb
	N/xvJz6vl/ybAZbyjF801R58SgrLgAX+veFzG8xAAVU9ggr87nCsQn5zWF1KEYjqmX6lOywwUkm
	Xhb9MQD8eDAK7i0+jIEgiNiPpMQsljhYnhHraB8HqKwxjxuw2bOgeX7I705LwpNw==
X-Received: by 2002:a05:6122:3d10:b0:5ec:16d2:4537 with SMTP id 71dfb90a1353d-5ee8aebfff6mr16711949e0c.7.1795810053427;
        Fri, 27 Nov 2026 12:07:33 -0800 (PST)
X-Received: by 2002:a05:6122:3d10:b0:5ec:16d2:4537 with SMTP id 71dfb90a1353d-5ee8aebfff6mr16711865e0c.7.1795810052932;
        Fri, 27 Nov 2026 12:07:32 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3ae8044e00dsm69559081fa.3.2026.11.27.12.07.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 12:07:31 -0800 (PST)
Date: Fri, 27 Nov 2026 22:07:30 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Alexandru =?utf-8?Q?Andrie=C8=99?= <alex.andries.aa@gmail.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH] drm/msm/dpu: use single DSC encoder when slice_count is 1
Message-ID: <urgy4kbfvofgjznraum7gtjtrhikbthq4sfad35nc3jbzb7kaz@uswmsjw4ygav>
References: <20261119-upstream-drm-msm-dpu-dsc-single-slice-v1-v1-1-4744ad5b9747@gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261119-upstream-drm-msm-dpu-dsc-single-slice-v1-v1-1-4744ad5b9747@gmail.com>
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI3MDA4MCBTYWx0ZWRfX4N0s8N21XEXG
 pOrGvieaZ7bfdER8UoogowAA66CbStEfQqwCqTGGO2HccFkqsCqfjRLIFBjlDzHJxcKTWYSQ5nS
 40Lt7jD3xcedHrMc32k8IceqC2fmV0c=
X-Proofpoint-GUID: RUV_lLWCCICsrlDTVf5cbKHXOvtk_6Gn
X-Authority-Analysis: v=2.4 cv=LPLz05W9 c=1 sm=1 tr=0 ts=6b09e306 cx=c_pps
 a=1Os3MKEOqt8YzSjcPV0cFA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=VwQbUJbxAAAA:8
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=4NFimAn6xQd1D8YDhw0A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=hhpmQAJR8DioWGSBphRh:22
X-Proofpoint-ORIG-GUID: RUV_lLWCCICsrlDTVf5cbKHXOvtk_6Gn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI3MDA4MCBTYWx0ZWRfX/b0ZB3SrOzXS
 52gCgVbSI+4iUyMbWHPbkGdddfxyMzeFAs89OnEBvh+x+SFug9ZdEsFaW/RXSmR5MmMjohllTWi
 4tvjL7XTMP5n8UHrB6EP69nhycr85Jag4lt1QinxpTNSXpvUjOyTWMpLcpuL6AUe114FoYkKEZ9
 NRGdEBT86T6cfqZO60p1J6L8sOoOrEbnMAv5qO+CKEIZO8B8mzDOHbsT3MjqTRP0hoAMFY9/Yfo
 gsYAyU2oh7N4qx6BTe0E1DEYItnGwOrRpGDwfpqNhGmnxrBtPYTi0JK/Pz/yPUFqSqpBJlU5wPn
 Sd7K4Nztdes+QOuMYtT41W4AJvOlamS3cSNlITbMt7O8X6ZSrQd+I253FnmPCke4OP/dhKZOYGi
 4ifke6p7QUQVXe4kdAHkRv+SK5/vC2kq5BNLaNWTzizpfeqGLTcpB9F84zz54N5oqTl+P+zIdAX
 3PPoBs25tXuKw2vDPtA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-27_04,2026-11-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 bulkscore=0 impostorscore=0 malwarescore=0
 suspectscore=0 clxscore=1015 lowpriorityscore=0 priorityscore=1501
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611270080

On Thu, Nov 19, 2026 at 01:47:58AM +0100, Alexandru Andrieș wrote:
> dpu_encoder_update_topology() currently selects 2 DSC encoders whenever
> catalog->dsc_count >= 2, even when the panel only uses a single DSC
> slice (dsc->slice_count == 1).
> 
> A single slice cannot be split across two DSC encoders: merge mode
> halves the per-encoder input width below slice_width and, on DPU 7.0+,
> computes num_active_slice_per_enc = dsc->slice_count / 2 = 0 in
> dpu_hw_dsc_config_1_2(), dividing by zero in
> _dsc_calc_output_buf_max_addr().
> 
> Require dsc->slice_count >= 2 before selecting 2 DSC encoders on a
> single interface so single-slice panels use 1 DSC encoder.
> 
> Fixes: b6090ffb30f3 ("drm/msm/dpu: Fall back to a single DSC encoder (1:1:1) on small SoCs")
> Cc: stable@vger.kernel.org
> Signed-off-by: Alexandru Andrieș <alex.andries.aa@gmail.com>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
