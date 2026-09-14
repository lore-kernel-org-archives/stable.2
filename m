Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 098AF33260B
	for <stable@vger.kernel.org>; Mon, 14 Sep 2026 10:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789381545; cv=none; b=F1obCMkxTn+sDHKzpdc2SvihlvzMzhvZ4Uynv7c3OtvR2yvWC1tuRTe5BljVB1KEC9fBagKSI2UJ9osK70Win5FuEYXownyqGHcsB94ZiNhjI6dminD1QGaPAnpS3pQMfKPG8lGu9HCv03LEbAzURIs9P81CGkQ6o4n5moHRjfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789381545; c=relaxed/simple;
	bh=OOWFS0fW8PalHpuUVagUzGyLfGec2bM6XnZpla9OrZw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PuUQhoANKtyeovwOltLO0RH2b3Lm0gk0pquUqHDYnqNnhVtAaywZ7SPPnIukbBG1Jt4XOyxef53vOsWfK9pXgK+nWrATPeCV/Zr3Xg6Sxp8g8rjEgHob/SyKk1PRF36PFCW5GpgvJBQNgqHjYslI907VE1I1IEY92GQKqdgn2Ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cnzhIN5V; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=LXMKi8k8; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cnzhIN5V";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LXMKi8k8"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68E9nkYW1086523
	for <stable@vger.kernel.org>; Mon, 14 Sep 2026 10:25:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	JX+0a+hStUyRWI2lGYq3KNdkSglVyMZwq3O+0P0j1GY=; b=cnzhIN5Vo1Za/wEv
	iMIWGnZ/ZNlCOPEn0dLGgl2lbE/Y6zmJQxqkHWj1HZ0RlzzbH/X9oJIGFfx6uUss
	YlfJAlMxBA5Sif3PUYnaLeijGTGtmxszQkU5gPELQQpalkZtnGJ/+2zFU/eEn0F9
	K3FhQN8CTJfXQu4/ZmQS4G5KTDbhihEpcU7MsX28EpFVnt1f2FcKX8TgC0T25+Fx
	XO8+has4seybPo68RyZrU3k6oeLScIuHpDdZHbogp/55tx0WYZRS/A5tMhVgaPSs
	Mfn89sTqStt53pqGs326mWxWdWnwKnTFSnOBXcQuUfazkO0apCT6m6X0fLivrorR
	1yIsiA==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gp3k09yga-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 14 Sep 2026 10:25:43 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-93821883e26so85194885a.2
        for <stable@vger.kernel.org>; Mon, 14 Sep 2026 03:25:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789381542; x=1789986342; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JX+0a+hStUyRWI2lGYq3KNdkSglVyMZwq3O+0P0j1GY=;
        b=LXMKi8k8BGD7f0yXH++i8uRRGqOmZNchiFOtB2cT2zErtL5YGzWqjWGAc9Mj4AN2jh
         cR+KxCAP3BfRhXkvN7Vpa8mDubIfaXddtEOfVYa16dyZleJ1nG6ofZhwniIDTfxdKPKT
         aB9PQEk+l+qgs8jbbLQGNgg0IZ962RWb3afHbaZvl6BHn+GThPRoEaqkZ7higWHED2e2
         ADqqDvHSbRZBTbDw0Dq1LoZMspiZq/TbHQXGkLx9pgbcAH+HX7hg8Np1qm+iZUoUggaw
         ppF5ZTEeNjCP6HAGLkx5SCYFSIPxnSyiX0oPIu7ArALLZRUfpSgLISeeD8+ip2PPEyLt
         n5Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789381542; x=1789986342;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JX+0a+hStUyRWI2lGYq3KNdkSglVyMZwq3O+0P0j1GY=;
        b=ewWYX8klTJN3C0XoRLaMIuYQoJWA45arN8DPrYr57w6QG51TqVlEew/mMhF5LsjRwZ
         /4H4JxZOnv4NU4tWMlbLxtU/pVnpNuc4peyQfVcPqpk2ErV2/JBFpvAZSDAp5Ss57liT
         CYQMO8qO5M+PjgCpzAm8Eh/R6AzT597IuuwJyzpQlEn/HPd9NkmQvRgDmzsuCzzA/I4w
         bTZIE9KwDJLJ7x5VNosfCman/p5uI9/KKzLAvZ9bylfE1YRtJqbeciFNy09KqvsxZdx9
         rq5P2GSUTL7LfdMbm1vMnRfqlRWKWzsK4DdRaTIPJho++UjZyemhQdifEbeDuhzRxr0h
         NXmA==
X-Forwarded-Encrypted: i=1; AKwUvBzQSdO1X37/3Aa6EHHi/mADWAw9vP+o1t9BkHLUnziqP054nvu2UMoYVaVUfN7DSwhSVWnWTkQ=@vger.kernel.org
X-Gm-Message-State: AFuF++lSDectSfFJVaoellkAMPE7lya8q3FjLXXO20K2NJf1aiShjQvy
	GbK8YBMgksBChGpK+izv7tNk+TRRiajjxwLOYyTZLs6Q0Ml28IVi3rcsM3NIqpAXuEw5ZuJZpXy
	oVQE/blIjChEVprenFUG8H/eiYauqJ+RO7RssUgRsGvEk/i7EP7n9APC2ogc=
X-Gm-Gg: AYBFou3nmGUQ2arQnO+pjzN6FSbhKKN0xgytWlVxlgaKqAssoMfelbaB7Kzu5JzyhEh
	WnznAKyQPjlYKkqcs43f4F60Mcl4cQ0ZvOq1kjb6UOb71B5E9NkE35EVOjc4V6pU0miw9NN6wf+
	CSc1dZ/7aOs1g8fsKZufOs2wDZqZbb5YNwwTyi/hkPr5zU9tkBIaEibW31Qruj5sz8JV6fsT1xP
	mhMokkDxPdc/A6i/On36BwJCfOLAt9cbejzUg/Ur76V6+E7p9SxvYqc0DBh0UlfjxnfL6Mg/KrM
	ero2CrqBFUVyz0exAFRxJlX0aFRl06Kf2hKzx2t/FC8ZOsw24gf5BrJJS8Py0ausoC4/ug2EPF8
	w/uTYiS/3Yb60Twiw3s+vzg==
X-Received: by 2002:a05:620a:4707:b0:939:de49:6c78 with SMTP id af79cd13be357-93a297cbe3bmr211356585a.2.1789381541950;
        Mon, 14 Sep 2026 03:25:41 -0700 (PDT)
X-Received: by 2002:a05:620a:4707:b0:939:de49:6c78 with SMTP id af79cd13be357-93a297cbe3bmr211352085a.2.1789381541452;
        Mon, 14 Sep 2026 03:25:41 -0700 (PDT)
Received: from [192.168.202.12] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c29660234f2sm404140166b.12.2026.09.14.03.25.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Sep 2026 03:25:40 -0700 (PDT)
Message-ID: <b96659e1-d2e4-4272-8e78-8042cd5bca9b@oss.qualcomm.com>
Date: Mon, 14 Sep 2026 12:25:38 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] usb: typec: mux: ps883x: support TYPEC_DP_STATE_F
 like qmp-combo
To: jens.glathe@oldschoolsolutions.biz,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Abel Vesa <abelvesa@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Sebastian Reichel <sre@kernel.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, stable@vger.kernel.org,
        "Dr. David Alan Gilbert" <dave@treblig.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
References: <20260914-ps883x-disable-usb4-v2-0-523c32b4e4d7@oldschoolsolutions.biz>
 <20260914-ps883x-disable-usb4-v2-1-523c32b4e4d7@oldschoolsolutions.biz>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260914-ps883x-disable-usb4-v2-1-523c32b4e4d7@oldschoolsolutions.biz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE0MDE0OSBTYWx0ZWRfX42w+lW0MjiuZ
 TTBI8H+005D7ooqf2Zbxfw01oeNF4kXBOwCzmczNXnPAyChdwwzJEMmY2g+facjbHdoP2oRoqBe
 Ifp/ugJ47cWtmNgka5f4P8aj9ZuT1lU=
X-Proofpoint-GUID: ccGGBE_aRyaxLDOSraozYSbRSem0wrfd
X-Proofpoint-ORIG-GUID: ccGGBE_aRyaxLDOSraozYSbRSem0wrfd
X-Authority-Analysis: v=2.4 cv=BtAIUoX5 c=1 sm=1 tr=0 ts=6aa7cba7 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=gxl3bz0cAAAA:8 a=lhgTqZXDA9jZt3rOk0sA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22 a=kiRiLd-pWN9FGgpmzFdl:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE0MDE0OSBTYWx0ZWRfXw5pSJ6UHxj73
 pSK1DsUnQftJoJJun6EGjpY5kutiRfWvSW+H71B4Pa5TddFkANFEdtfGb82S7YQdBIKyBMN0Vv1
 NVZGL7glKno9X/YhyTXNNeF2JMvV9EcQ24Keuxt+eJ0nufPiH29Dkx9YFE/FSp4skdxdJhrLiQH
 DBC6edLCMpZ+jeHeumJXhfeyvioOxMO6XBuJRng9MTFPwYzrQWG839HUrB3bwf4SezKCyrZsPGo
 khTobAMm6ypJu3WIvnS2a+y2gw+ebvHQJAuWEocKK2mxp/eLfagBPdqTRySSYSTDNRNiTHEkVXr
 fwwdz12adD299h/pOVmfCzDM1MxMvXV+3YxLM0uqr9vkcmGuOAGdt32K3it6dZ2/d/ds7GCL+/G
 VflhuoYnWvuq27yYiNy3f8AZ4RGdPnJdjfnFK4AKQu0vBvb5aru9oZPj2uga5t6kXB2dzNSY+NE
 EMbKHaDCYmRQnbziqcw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-14_03,2026-09-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 phishscore=0 impostorscore=0 suspectscore=0
 bulkscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609140149

On 9/14/26 8:05 AM, Jens Glathe via B4 Relay wrote:
> From: Jens Glathe <jens.glathe@oldschoolsolutions.biz>
> 
> Several docks, including the Lenovo 40B0 and SSK SC220, still send the
> legacy TYPEC_DP_STATE_F mode request (deprecated since DisplayPort Alt
> Mode spec version 1.0b).
> 
> Keep the handling in the existing DP altmode path in ps883x_set() and
> mirror qcom-qmp-combo: pin C/E are DP-only, pin D/F are USB3 + DP.
> STATE_E is grouped with STATE_C the same way.

The premise here is entirely wrong, you shouldn't assume wholly
different hardware should be programmed the same way

> 
> Assisted-by: Grok(xAI):4.6
> Signed-off-by: Jens Glathe <jens.glathe@oldschoolsolutions.biz>
> ---
>  drivers/usb/typec/mux/ps883x.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/usb/typec/mux/ps883x.c b/drivers/usb/typec/mux/ps883x.c
> index 64e0a61b776a1..c185d8897e3a4 100644
> --- a/drivers/usb/typec/mux/ps883x.c
> +++ b/drivers/usb/typec/mux/ps883x.c
> @@ -205,21 +205,24 @@ static int ps883x_set(struct ps883x_retimer *retimer, struct typec_retimer_state
>  			cfg1 |= CONN_STATUS_1_DP_CONNECTED |
>  				CONN_STATUS_1_DP_HPD_LEVEL;
>  
> -			switch (state->mode)  {
> +			switch (state->mode) {
> +			/* DP + USB3 (pin D, and legacy pin F) */
>  			case TYPEC_DP_STATE_D:
> +			case TYPEC_DP_STATE_F:
>  				cfg0 |= CONN_STATUS_0_USB_3_1_CONNECTED;
>  				fallthrough;
> +			/* DP only (pin C, and pin E) */
>  			case TYPEC_DP_STATE_C:
> +			case TYPEC_DP_STATE_E:

STATE_E must not set the CONN_STATUS_1_DP_PIN_ASSIGNMENT_C_D bit
I don't know if that's the case for F too, possibly.

Setting DP_SINK_REQUESTED seems to be valid on _E.

>  				cfg1 |= CONN_STATUS_1_DP_SINK_REQUESTED |
>  					CONN_STATUS_1_DP_PIN_ASSIGNMENT_C_D;
>  				break;
> -			default: /* MODE_E */
> +			default:
>  				break;
>  			}
>  			break;
>  		case USB_TYPEC_TBT_SID:
>  			tb_data = state->data;
> -
>  			/* Unconditional */
>  			cfg2 |= CONN_STATUS_2_TBT_CONNECTED;

Stray change

Konrad
