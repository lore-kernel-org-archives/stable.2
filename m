Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D0EA2E6CB8
	for <stable@vger.kernel.org>; Mon,  8 Jun 2026 06:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780900750; cv=none; b=sLBv1qWgxIlch+hs/bDVQoElwXNkpVHRNfi+nlUwnLxEwcKd9Sl0DB1HgpRhmabhEDs2UhtSC9pHBfJaOxL5pDGHk5hoBrOXDghHbjsRt/hWCYmlUzcsvOmkfQFHdhmEjlVNMISJSn5ZtpFg5nxJiV1ly/JqI0XwlGI72JFQgY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780900750; c=relaxed/simple;
	bh=Nym8V+yNjQn6A5qW+sv7Bee/PVugLXo2OIQNUGl5aSo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k6neHWvRcz5QozXcYL60yXapVHQN03gHgHD56OtoKHyxVVcRKWBlCWLpX6E+mOFSsS+8LJy8VgsaUJ/cBxMXKCmLYs0nV2XM/jw4vB//9a/80AyTKYveL/QfRdOS3r8/FBejMkEBHbP2Ip52nNtl2emX577CCWDvW44yrdErxFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=e+NizCMt; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=CK/WThVe; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="e+NizCMt";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="CK/WThVe"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6586Olfn2347159
	for <stable@vger.kernel.org>; Mon, 8 Jun 2026 06:39:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=EkzA2skdq2rjPRHzoDUllfBf
	pNhhxszp0NCx5+beOtE=; b=e+NizCMtvGZwqyNlIj1DUDwD8H8DVYSsi4NntMMe
	sbdT59YDe+6QWfpee8GcTJrGhh9lGHdcBwY+QTJcLMYUaP+oEjm5ssPsfBrZOfDI
	OsC+Kj/BmztE8OhZUb2/yVlWgyVE9eGMJ+Heot5lL/Kw7ZyldUI4ZPsmnkzXje0Y
	BiX4B64vEdsDPS8RaUbor8XqZ/iHgB2pHnrlJREhplx8X+v9Qi8ydJz8L0fuHsTm
	GWdJ8cLNrGoZsSmVi8gmEOHwyMCbAUc3twXdECWy4ckPYt8bcn1ktKFQc7aIm9v9
	DyvlWrG0BuifytSko/vxdV84FjAn704Yo1Z/LiqLWriakQ==
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com [209.85.217.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4emagrekg2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 08 Jun 2026 06:39:07 +0000 (GMT)
Received: by mail-vs1-f70.google.com with SMTP id ada2fe7eead31-6cf9627010bso4765836137.2
        for <stable@vger.kernel.org>; Sun, 07 Jun 2026 23:39:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780900747; x=1781505547; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EkzA2skdq2rjPRHzoDUllfBfpNhhxszp0NCx5+beOtE=;
        b=CK/WThVenzrc2ANjA4Mbu7m3OYGwBpiu/pO6wY2gHtpT+a59P59ul5QjEXpKDmvhKP
         Q3HxJB73BhE1YNWuiCPvMocQDzeEhlF3EK16KmVI+uIbtlEpHsSrVS1axqD2oqdUH8y6
         YT8Xhg9Z/E6dsIzpWM4s9JJbnSOYCJwVqTCs2hI9jN7vLJ0/O9srIovG7wxS5q4ed3AE
         Ow1Kd/XFCjzfg5sfyAYQ8xmGtdGKGzZkqjHpafkQBzpksRO8+gVKEenraxsrKy6xHJGs
         qsnCAObuS2bA+lD5yg+WBQyZmt+e6gH51kJAejkEN5BOEfvVyPT4YdC7b5KXqITrAjmP
         /Q9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780900747; x=1781505547;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EkzA2skdq2rjPRHzoDUllfBfpNhhxszp0NCx5+beOtE=;
        b=sSsLFIIcLsdcOllraWfr3aVyPQbw8WYcvWn4Ic0Tp+orSaYHb6r+G9xilXOfh9hxdN
         xsLsYl0ztC4A6nYLWSXWHiE10XCJXyHPJa8vRX7p6e3U4f49R5ROKY9WzO+IIj96ohN1
         Raz1h+H3U4irkOT+l5SwePu6ql/2CZYSVlv6BxBMSiD5QbB4HJFQ8b7uyKGdIa0Y0tpK
         BU9dPN0YboJ9NjKFllraK12wxGhUstxRTOW5HoNabEROc6GCAXC6+cxzk410a7M1FLw5
         hulbmlYqVh9647+oEOTlu6Yg/nSR3uWws1orNY7VVrF3NMMHoqVmR8VkxOlGg/CzNIVo
         nRmQ==
X-Forwarded-Encrypted: i=1; AFNElJ+qdKyO5Xnwh384KUaDjYHd8HqvC2niWSX/5CuEqhrz/lYy/XJMClaCSgUGKOFBtu8OUG9Mdhc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAj+gWHVOsvA9IRaNuxIJO5cEp07DXhN0c4aP2ebuXHRMn0C6q
	IUgHcWlVNRhmBFiAg7rC1iu6tv9rjO39lVONcHxpxPQXyaMl6nbfWkxVy8CEk7kMJVADHLozghT
	nTe8veoQ8SALIw60OuxL2sIKSfEEUxrIZEQI3Zut0pmpdQX9S/yc2JJSI2KY=
X-Gm-Gg: Acq92OFvfGshzHw2pfnFHVDVw+KxlKr2E1rld19d2+zvjZQ9y2srzeHFZyhS3gR20bP
	anVuYQq8jqjiWgcnc9rQ2QFI9wf19+WHnUmNT+XyZWUErCqSLPc4a+IajFXmfOCquC7vOJUclm4
	moSIfMOFYlj0gmSUi5q318Y/NEzdRPe/Z8x2OTYSQ6zX2lB0bUIqqTXNbr4KDv06FTeACYovZzr
	5TB93ZK/RaYO6baZiMN0MbD+2KhxhTQd+Zkk4ZWIjJcj7B1oRsQlJh8mQ4fZzRI/VvpGSAlDol7
	MV3qdNwgiQWPKdEO/ArkP5GARqtdOADh3Jj7Vwl2WDWp4c56Q4mbbiWU5/o7u4wGA7tqi4w8Qj0
	IyEfFFLeZoAzJPpYk7rqXvrSwwwKr0JwS1myUZ035ONYXCEsUi0sZ1P8KQgLW2LikuH9w6cEcRc
	M7ZhBqjaaBotvHi3VPuwEeNp+FXOGQkyCxSAm9D7OJCQvGfg==
X-Received: by 2002:a05:6102:5486:b0:607:95f4:53b5 with SMTP id ada2fe7eead31-6feecfb6c3dmr6704993137.4.1780900746811;
        Sun, 07 Jun 2026 23:39:06 -0700 (PDT)
X-Received: by 2002:a05:6102:5486:b0:607:95f4:53b5 with SMTP id ada2fe7eead31-6feecfb6c3dmr6704986137.4.1780900746468;
        Sun, 07 Jun 2026 23:39:06 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5aa7b9995b5sm3534596e87.76.2026.06.07.23.39.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jun 2026 23:39:05 -0700 (PDT)
Date: Mon, 8 Jun 2026 09:39:03 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc: Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil+cisco@kernel.org>, linux-media@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH] media: iris: Enumerate cap->bus_info to differentiate
 between encoder and decoder
Message-ID: <6qnzj5pmsc57nc4auxg3qh7wa3kaszu6ao73a72fog4duyb7g4@lmbldld3l656>
References: <20260602-iris-simple-name-fix-ci-check-v1-1-5ec9d0d00983@linaro.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260602-iris-simple-name-fix-ci-check-v1-1-5ec9d0d00983@linaro.org>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDA1OSBTYWx0ZWRfX6V628pmgcwd4
 It2IEQizOKgvF7c1aP2vGRHScr7CXMIpQL6WN44jzXIIBxh2DTU2eYnU/sPOyiUZZkqc+1+u6Ka
 Au5e/KZyts7LrQXM7uZLwM/HPE3Ng1tAy6pXlLWyOf4gIBLeeh4k7+5q4Y5fHQaUQ+2xotiTJHp
 vZ9fBTpknjiZWMm3Qz7nJRxLjUDhYGYQKW8AK/9mRvhUuU16MWk7rXdsU9Hp3YwQzDk7Zz22n2N
 3bbb1Us2llHf4MCl0hbCFTYtL9+tT3H8tYLtmLu+IkYTQXfs1rzeZxvhpRj/9e1FO3a8oU2ZRTF
 2SzAU0KTduvBkVPzm1RFNnBJbpc3zk84boGefoRBGnfp+W9YR11x/e3QScz3QjyO1WhXeUZ7m/V
 9Qptp7pLHqjfmjMtuBNFXxTFOSkaiqEchbPktltPHdH23KdTKBnkVqEgp1wdMSulwx7niY/U849
 KBoZgHb6VBK7O96IVxA==
X-Authority-Analysis: v=2.4 cv=G/4s1dk5 c=1 sm=1 tr=0 ts=6a26638b cx=c_pps
 a=N1BjEkVkxJi3uNfLdpvX3g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=VwQbUJbxAAAA:8
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=sEgayuerTQoX3LKLxq4A:9 a=CjuIK1q_8ugA:10
 a=crWF4MFLhNY0qMRaF8an:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: WzAmx8ljXH8kQOioUPgPLDawBHIPhiou
X-Proofpoint-GUID: WzAmx8ljXH8kQOioUPgPLDawBHIPhiou
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_02,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 malwarescore=0 spamscore=0
 lowpriorityscore=0 suspectscore=0 phishscore=0 impostorscore=0 bulkscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606080059

On Tue, Jun 02, 2026 at 02:59:21PM +0100, Bryan O'Donoghue wrote:
> commit 66c744e28b69 ("media: venus: assign unique bus_info strings for
> encoder and decoder") introduced the naming convention
> plat:node-addr:video-codec{enc|dec}. Right now Iris does not replicate this
> naming convention.
> 
> When we do v4l2-ctrl --list -devices we see:
> Iris Decoder (platform:aa00000.video-codec):
> 	/dev/video0
> 	/dev/video1
> 
> Enumerate the bus_info field of the capabilities structure for namespace
> parity and appropriate differentiation:
> Iris Decoder (plat:aa00000.video-codec:dec):
> 	/dev/video0
> 
> Iris Encoder (plat:aa00000.video-codec:enc):
> 	/dev/video1
> 
> Fixes: 5ad964ad5656 ("media: iris: Initialize and deinitialize encoder instance structure")
> Cc: stable@vger.kernel.org
> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> ---
> A really simple fix to differentiate encoder and decoder in user-space for
> the Iris driver as we have previously and recent done for Venus.
> ---
>  drivers/media/platform/qcom/iris/iris_vidc.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
