Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 096F22F28FC
	for <stable@vger.kernel.org>; Sun, 13 Sep 2026 21:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789335971; cv=none; b=G4VWSx1WRSZcQVRmqt6PIwfyxiIU9xo9KVopVys/t3U9D6qJXf+Es0ZuzUhjsBdQngPNhAYFPQjXfIP99AupnuImPjKX/NAGxVKxf1tuePP+sJGGrmLE9qDc40xw0Pn1+szTxikVFhePayze6sR8mg+q6M5ebRVEsY5yvnhlAqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789335971; c=relaxed/simple;
	bh=ZkAksoF7ZmwppBOX4liC5lkJMiOS/s1heEZxMpA7zt4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cEYqq/1Zp8M4awfdVz9IhYvQx7Luz+LTRFYW8VIcf16DKVwt56H/0r4s3wo4DkPOtmmGJyiacA1raIgfIB7zmSCOlC2cAgF33/NmsukvBJ7goXkg5Ywpp2MiY1wG57PHSEnva7Oby5RisiI3z2k2PlK2aXX0uHGjXUvNrAc1rB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NQ70ZX31; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=TAz4rLQI; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NQ70ZX31";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="TAz4rLQI"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68DK03qS2632626
	for <stable@vger.kernel.org>; Sun, 13 Sep 2026 21:46:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=vbAlXC0DW5rovY2mimpWnBtg
	9Fpne77lgrVF++LV5Ls=; b=NQ70ZX31srNGMLUNu1TbIFmX017U5TDAwdZh4+IT
	GHgBjBs6FEe4oLQwvAEt7OLthE0zK0FQRx/Tb2lmqC6xeipYB8OpoYKaK5t8gGUl
	szMg4hhlXrJXNlsLY+YOKXCsjuX66gTAxEiNMJiG+KBzxE6hdzTdfQlZexG0Wxnx
	RDAfgGPwT07AEBCJd9hR/4+sEAzV8+x+AxwD+JHhXhx1k6d4lj33Sr4HrgMS/Lid
	9ZS30EfGICfwJBPGpe9ErLt1xOVxRLvj9cJs3qUhaYwfsC6GcqZWfL7/STrTPTTV
	vTT/m40rlPjxtWX8iZUeWx2TFRw8PyO1VxHt8iir3X7O2A==
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com [209.85.222.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gmy9c4761-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Sun, 13 Sep 2026 21:46:08 +0000 (GMT)
Received: by mail-ua1-f70.google.com with SMTP id a1e0cc1a2514c-980989f5030so2260169241.0
        for <stable@vger.kernel.org>; Sun, 13 Sep 2026 14:46:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789335968; x=1789940768; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vbAlXC0DW5rovY2mimpWnBtg9Fpne77lgrVF++LV5Ls=;
        b=TAz4rLQIWuZ2cU1BRCPHC9rXtnT8VCNmCjwd04cTb+kGOKAD/opzSBAP7QiF6PBP75
         lpVVWAAII+cCUxnOMU3uEqmgKxH2f8h0+grewKhGDAiw1DJppl4pdu3e7miJLCTIY4Ba
         dnctihWDl7SOwD45MScCq5Ce02i8rNwBTbo4G+Y7sySuYn0XB3OHXQyM5PIQe9DUoHdA
         hpiPZB9ZM3Mog3bDkXmbmkrQQkPdT9eh6fuQcu36pulxWTP3iPL63l5/mkWDT1p1AQzZ
         JcKIq1QUA5IMe6gENNVQFbs5E61+P7Kq79TOHGYF72HUwTvW/tytJWJOCFK40f1wdDAK
         DWyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789335968; x=1789940768;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vbAlXC0DW5rovY2mimpWnBtg9Fpne77lgrVF++LV5Ls=;
        b=SMqhjvYZne8ZhmUuCK2g0ecWAvxZ7KAgHi+exgHSu4d/HVC8UjkYMqxsYbPcfI/fNV
         XqjzEM6GW5Ot+EVzA73k0O06xWUcZ/eAs32/q9hrfLLY5XWi6rKgu5N/fk3zcBdh0vop
         0EGsjpYAoqyp6Ioq+EtCT7LDlE8UXJcEgFmb8VpBMVZIwJS7xX7a4zS5tcblfNUMBL1A
         dSbI3aY01qqZgndOFbecRBc27o67MphNsMnxFGt2lF0yx7rZZh0dFifnzskdhQDs4hpy
         51XUiKtgxL0Lj/haHu9P8Ds2ak6FjaR1r3bSXpobMA56W0/a57yyd0ci5G9MLRDPLzSE
         be4w==
X-Forwarded-Encrypted: i=1; AKwUvBwPF5wPolOwY9WaIPhV6BssSDL03Ix+TgwSnEKzNIwAU6tR7av3Jxkofwy6QGc5WIXM1op3bv0=@vger.kernel.org
X-Gm-Message-State: AFuF++nOW7+wz/BYJxKYvk6q6ltSFrcty2aoJw3SJcvtc4RYYDBAyWVL
	6LIiOqxd769QkAcRJpc3oZtVaIE66QvhzsiHhLjFrcYybbNfu0Kqc48YI0u8U3lqMy9ezSF5VWu
	PyvrfTv/bEGsPWQReq2NxdXHZQJQhO9qoFCEASVD1yNheNz21X3ePsDxYkOs=
X-Gm-Gg: AYBFou32gLFgazY5suktruabDQ40sKgEYDG7vmvGuEYsI1CjS1cxg7R9A8mqLBK7BoT
	pRv2/yQnUdE7E6U7pbTc1Xubg1JeZ5ZXJgrZnD/MGSUPkk5UBBY/as0iAMsXN9iVBsyoxnEIPoG
	3fS6zPnVlPuHfxXo1H65sCVmnBGSV7Pfff8FHqQL2j60GXS3VT3R+bGY35m1Bo2tNTdy73fo0lr
	AqnxA2LE9LfwxHGIgxKqGGv6MvQh92KqjbSByLvoXTpMgjmeNTzsIUrIlRRD8tJwTuk6n6KBuli
	wvL2Nd2TYyUxddfc89QK1CbaJJQaiZNx5SVXn67kGZ/HNSOwmmEM4zTCLSv90F2JPUOkVsMAD2l
	Ypls68/jSn7PWPM9orOJ1qgBYtyjTECnwGUoto6WKAwNLUNsc3p5cHOfc76awFe7vsswpCamvGM
	lqs1llhgGqykdV
X-Received: by 2002:a05:6102:578f:b0:79b:1b6c:4f66 with SMTP id ada2fe7eead31-79b1b6c5faemr48532137.1.1789335968019;
        Sun, 13 Sep 2026 14:46:08 -0700 (PDT)
X-Received: by 2002:a05:6102:578f:b0:79b:1b6c:4f66 with SMTP id ada2fe7eead31-79b1b6c5faemr48479137.1.1789335966559;
        Sun, 13 Sep 2026 14:46:06 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b8a0474df5sm1981637e87.64.2026.09.13.14.46.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Sep 2026 14:46:04 -0700 (PDT)
Date: Mon, 14 Sep 2026 00:46:00 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Saim Shujah <saimzst@gmail.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        Paloma Arellano <quic_parellan@quicinc.com>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH] drm/msm/dpu: clear pending peripheral flush state
Message-ID: <skz4w7uewtxgmiuhyfav6krul6b7itlfb6io2ysmcypql4dka7@ar5hawrzijaw>
References: <20260828065440.140410-1-saimzst@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260828065440.140410-1-saimzst@gmail.com>
X-Proofpoint-ORIG-GUID: stshMR0aYEjdQFgqKrmy4o2mUt_KUmuj
X-Proofpoint-GUID: stshMR0aYEjdQFgqKrmy4o2mUt_KUmuj
X-Authority-Analysis: v=2.4 cv=c5Y+0h9l c=1 sm=1 tr=0 ts=6aa719a0 cx=c_pps
 a=R6oCqFB+Yf/t2GF8e0/dFg==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=VwQbUJbxAAAA:8
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=RN2DTS20WyuIpY-t6BoA:9 a=CjuIK1q_8ugA:10
 a=zgiPjhLxNE0A:10 a=TD8TdBvy0hsOASGTdmB-:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTEzMDMxMSBTYWx0ZWRfXzq2raAHqtRB8
 grxWEsU6srlOwZUN5hrVyIXrkuVwLqpsxh/YHthUO+Cio1YnY6aXnuHm9wPBlmAhYx/DHdWXJM5
 QXRSG0C0vM/xMaIa+hJ3ikPWiM8YAwWpdO1VDE5yPvK77RfSvNP8y/wfafBB7k53UTETc+aEmm+
 S+vmnjfYqmeBj8vlwt8d+98htH0VW6+FsQ8iQrlrjzFaOpGCItwaUZcFPf9J1rYQ2GWbThN8xfh
 wFun6zevd0FLGpRgfms4M3JKN7HldKI2v/NzIIou52mlmutDadBlO3Wgx5OIS7OtGaUdIo9YFhZ
 P023st3bvlO5ID8jmefEQByTGrfIANlWib98IgOkXrLbEJG4yMgYx/Zyre/BoQhe/D6+FolhTmA
 dO81oVuotq0ICGcSbGIvHAYvPx+FRxzCtb/R7p+RijBvn+BHzEAA6YbSERsNhtQO0yH+owszAVE
 MTLGQF2KsacyfsejcAw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTEzMDMxMSBTYWx0ZWRfXxwPFHYDbrIQJ
 DNzQAlfSOhBc7WkC4V8aZrUc2X36J4eoPnSL3paFQ098KpYNNuQFJuF1MgUWq/6K5fCXnPUE5p0
 bnWQh+2lBaBkQ6gVGlo3Ea/cgCGQzjg=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-13_07,2026-09-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 impostorscore=0 suspectscore=0 malwarescore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609130311

On Fri, Aug 28, 2026 at 11:54:40AM +0500, Saim Shujah wrote:
> dpu_hw_ctl_clear_pending_flush() resets the cached per-block state after a
> flush transaction, but misses pending_periph_flush_mask.
> 
> The peripheral flush updater accumulates interface bits in this mask. A
> later transaction which sets the top-level peripheral flush bit can write
> stale interface bits to CTL_PERIPH_FLUSH together with the current state.
> 
> Peripheral flush support was added after the helper started clearing every
> individual pending flush mask. Clear the peripheral mask together with the
> other cached child masks.
> 
> Fixes: 64f7b81f0358 ("drm/msm/dpu: add support of new peripheral flush mechanism")
> Cc: stable@vger.kernel.org
> Signed-off-by: Saim Shujah <saimzst@gmail.com>
> ---
>  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c | 1 +
>  1 file changed, 1 insertion(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

> 

-- 
With best wishes
Dmitry
