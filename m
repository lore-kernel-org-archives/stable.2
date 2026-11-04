Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793780247;
	b=Qk0YF4nq1YySFKVgJKQP00+34MMwHoFE1MqdlhjwCx8m3cOKxscbZdAlkxae6rDfwks3
	 RiZzT3RoLjD8cea6JwS0yrF59O1iRh226N0zSxIdgs+43mpdKMVu7bDY5kcu54P0n7yLE
	 U1gN0UPXkx3OHir67Ra9lvu6c1tJrwXycusjdAYpBtGigvRub13A6GBOuM2L/wtYw1Yhe
	 lAx34oq+Aw4PWQI+VaCstMbGLfYbN+dJGcvujHtEJKzjYvgIQPMXPccU5STpOBlcRuK68
	 EY+Xn23A12OP9VxsTHX9N/LZdgMa99uELwjd+J/cRqCC/LZq4SNEN4Vu1qrCoTNdl8A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793780247;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=6IdHy8wNPHVQzU0a8sO+LjN2NQHUa37ZPDyoHc/zCyw=;
	b=DbZZNA85GHlTViVY7rfHTrqgkfk49ay05df+hIwqyEPVNTG/E8n3GO+Ck0r+HNozfK6Q
	 14N9Ztc/C2bKoYYz/jAG4YAtR/4+qxKdcqMHqauRr5/2ADfAElaMfQ9HuigGsuMT5vx/7
	 x5akNW4dT0oZja3Ti097zNRYH9A0FIzysFFBx16GvX38SJgbxw3yfXwnAdu/vB7an2AEo
	 5bV4GgHxUxUVSIyhZnKR463u6nkK6xBsgqh0olmltGB2tVhjdkRgPnHkQaC0lqoTw+SQV
	 3IfnU3hGQ5XDY6u+Pe3NBlFu7kGpvLkwVs5KnDXEFSKR5hYkQ9Z9p0Znj6o7qLQ0zig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ZjPaLixx;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=eHOhW9S4;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44F11606A330
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 08:17:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 44F11606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ZjPaLixx;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=eHOhW9S4
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A43OqSO267284
	for <stable@vger.kernel.org>; Wed, 4 Nov 2026 08:17:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	6IdHy8wNPHVQzU0a8sO+LjN2NQHUa37ZPDyoHc/zCyw=; b=ZjPaLixxKZWZPP8X
	8kyd36Uu3KY4HkNGJOalvoY7Wd/omIKyQidf087yBX4mMa1VZOaiIPLvExnzuSjS
	PXXPtcT2X2dT6G9cFwxXu3v/XOwFG7XOynrzXK+rZZppVOgu3BiBpmydeBZYXTwJ
	GlkB+EK15D0NYv1ICHAS25DmSvlxAXSBxxTUri1R9CRJgFHPggEsNa/Ya9K244jo
	OIOIPofyMccH422nQNVG0I8D4Gl/l5ugO2ol4psuscX2vLL4jCqfKp+4KnmnmCWl
	3LAj73E7jlrtUXKs5rozQX9aryLev4wWMxvC5V66KaCxt2CpEM5c3RKT2JWRSuv9
	T3aLxA==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hqvsg9230-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Wed, 04 Nov 2026 08:17:25 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-943fffbc5dbso11724885a.0
        for <stable@vger.kernel.org>; Wed, 04 Nov 2026 00:17:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793780244; x=1794385044; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6IdHy8wNPHVQzU0a8sO+LjN2NQHUa37ZPDyoHc/zCyw=;
        b=eHOhW9S41ZMX9fUeIteXJknWzjZu+1QPCVKNzhwlk/z8qHtrKsPYPllGJi5ePzhxP6
         jytsgofXy02/Ng0dIibw74mqjYpvH0siWcUAp+WEWWL7e+2Uqk5ZA0flwfCwd4HuExvC
         3WyN7WBlnYTHrgP3l/IvF0TveyItsxcBPvai2ESYjYjnPTwEDN4wOAWlb1MobPqpI3FP
         v2y8K3Og1w7wVyHzmmkPbpSbAFHYZbO86gOuO/Qg3G5H8bFScn2DXTmr/AqdPC4Q7H1H
         XDlcWqF+ymL+U+yYih4T9Ul3W1gZjkg8jJHVZiPoM4FXHZtr0UWGkvnR1G/GH4sfcECm
         uxVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793780244; x=1794385044;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6IdHy8wNPHVQzU0a8sO+LjN2NQHUa37ZPDyoHc/zCyw=;
        b=NDKmRYrVWJnHj0dH4VR0fTuoJVfg517imFfHfcfA9Zi1Ny+HaKsFC3AAt+H0QlCWgC
         PcKSibDfLK19XWm/M8HjP/PoNiOp0TuQtBsCGIxbEol+cZuKxfdty/tj0ynSZs+3fwbr
         BoTGIMW++j3s6JG9kq+ARovr8E2ypJXbDZvzb+i5XlHdXQxNwL1Ic7j6k60YbnjJghCv
         7cf6Y3e+9BNDXq1+zShoqTZQpCLrBW01aCQyKRZPv1aEL+qYtMrFcuyXChPgUps0US2q
         ochYncvyjF6vWdtMQtrX5uFjcKoF9NXYA+NlUDa9pnM2roI6QCl6Q67hNLwcJamooPFj
         7ivA==
X-Gm-Message-State: APuU4Z9Ya7awYnoMoPLwJ4CvaoyVKmi+nnpRGY/YzWd+CZlmeZHTxtfi
	3Q25prN4tbl3BuJdrsEUOzt7NAkWj9qsPGPXz+rSDmz7GHc7jvatx6vjGFTFkDY0JdFYcIbyINm
	Rs7GcvMlAyea+kEd0q5GhFNs5Lgn6TFtyL4gUTuon8F7fZMR5Us7KYu9o2Pw=
X-Gm-Gg: AYBFou0ee3nrdvnhF0g2t12HieCurO9exobiuH8hbVy70j3t8henVWq81tMw98CpZoU
	9DtajzA4ewM8IdYZ4rmjKr9DsnPkowbADPln5y8hbBS1sjer3S+t+fZPBK9zXXgCHCHhL8QLaH7
	6FCbWbam2pQpbQTF9BFMewTC8RfeqmFExVvsDzUO1L52pSk/u5I4w9FpHLHKk9WzYnlgZhu6GK6
	xiGCs8LK0jzduPcXunMOx5LayUf2e7NGvH/SI9Po4g4CnkWu/kpa55tdqAUdBvXCcE5l7R9EXKy
	bzKyf3Q5An7AHRh9eSjgB0FBRzz9duEOfn4WNI7TuL7UbmXltjfux0ktEyxQvExQ/QDX06KB/4Z
	uGbFIP/U428JC17/6tz3y9ynRpfdHdjg82BpVn2mFf5gsOFHdpY/ytQNY3jUsbzS0mDqk
X-Received: by 2002:a05:620a:414b:b0:945:dc04:c4b6 with SMTP id af79cd13be357-945dc04c858mr23611185a.6.1793780244292;
        Wed, 04 Nov 2026 00:17:24 -0800 (PST)
X-Received: by 2002:a05:620a:414b:b0:945:dc04:c4b6 with SMTP id af79cd13be357-945dc04c858mr23607485a.6.1793780243794;
        Wed, 04 Nov 2026 00:17:23 -0800 (PST)
Received: from [192.168.226.1] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c4d0ddcfa78sm46641766b.0.2026.11.04.00.17.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Nov 2026 00:17:23 -0800 (PST)
Message-ID: <8eac300e-ef21-4dd1-88c0-63e798afae2b@oss.qualcomm.com>
Date: Wed, 4 Nov 2026 09:17:21 +0100
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/10] pinctrl: qcom: Check qcom_scm_io_readl() return
 value in msm_gpio_irq_set_type()
To: Lee Jones <lee@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Linus Walleij <linusw@kernel.org>,
        Ajay Kishore <akisho@codeaurora.org>,
        Christian Marangi <ansuelsmth@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
References: <20261103213002.1673560-1-lee@kernel.org>
 <20261103213002.1673560-11-lee@kernel.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261103213002.1673560-11-lee@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=GtnXaU1C c=1 sm=1 tr=0 ts=6aeaea15 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=c92rfblmAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=-MbjPq3b4U0PC_0A3OAA:9
 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-ORIG-GUID: -zzUChiVLVzpFg6fTOdyHZqBqlzxVZO4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA0MDAzMiBTYWx0ZWRfX+TXLxoxao7de
 Mviyv+jejEEt6lI5tDlHxeuTQQrbXupFvjQMif66h6uf76krZ1fmL7sspicyMA2k+YixrZZfMn6
 hAq8YNKo3gR2w3o95+Jn5j96qdZZx10pS0IUe+/4RMVdutiae99CnYWYB6jQ/z/BMXfrFntKR5z
 QKdmnkHa4DGAk4RUz2I8N8D+9Md2x4B77kZ6+oaemPL3aomj9MYrEXieRPxjdqQUv2yJsf5pUlM
 gK7S4qMmgacFVTZO7RlO2KRUKtFNoMBZGtLAtm2qP/ml3FkBq7hMRC4GI3nKb2mWmf/E3LA/zuX
 1ZGWRj4jWZsBlDuC8UOzZiggHEzgYC5+POC9Ds6GzILbCqVFoabv8VRZHN3gYZ/NEURpL/MnCY+
 kz3QkOJUlWE3YG1TYElQgfr4MZ2366YO3JURIK2PNttvOqCyp941HIHQvibFVacB9VQOdJRJnA7
 amkxG7WgdgeaW0yT1bA==
X-Proofpoint-GUID: -zzUChiVLVzpFg6fTOdyHZqBqlzxVZO4
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA0MDAzMiBTYWx0ZWRfXwSCcGdO88vYy
 +h/M5xdQUWZZUetZybtgO97xGN0s6bSMItN9Z/wk62TgKZ6UCS36RIGRy/IUErv0Gd5791yg8vy
 Db7+lWv6YmYR9hZQVvWmKlfNDTTvKtc=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-04_01,2026-11-03_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 malwarescore=0 impostorscore=0
 spamscore=0 bulkscore=0 clxscore=1015 phishscore=0 suspectscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611040032

On 11/3/26 10:29 PM, Lee Jones wrote:
> In msm_gpio_irq_set_type(), when pctrl->intr_target_use_scm is set, the
> return value of qcom_scm_io_readl(addr, &val) is ignored.  If the SCM read
> fails, val remains uninitialised and its stack contents are modified and
> written back to the hardware register via qcom_scm_io_writel().
> 
> Check the return value of qcom_scm_io_readl() before modifying and writing
> back val.
> 
> Fixes: 13bec8d49bdf ("pinctrl: qcom: use scm_call to route GPIO irq to Apps")
> Closes: https://sashiko.dev/#/bug/linux-a5545ffd-48cc-4856-94cc-4b2dd7968f50
> Cc: stable@vger.kernel.org
> Signed-off-by: Lee Jones <lee@kernel.org>
> ---
>  drivers/pinctrl/qcom/pinctrl-msm.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pinctrl/qcom/pinctrl-msm.c b/drivers/pinctrl/qcom/pinctrl-msm.c
> index 27f06bbc113c..1b46735fc4bc 100644
> --- a/drivers/pinctrl/qcom/pinctrl-msm.c
> +++ b/drivers/pinctrl/qcom/pinctrl-msm.c
> @@ -1105,11 +1105,13 @@ static int msm_gpio_irq_set_type(struct irq_data *d, unsigned int type)
>  		u32 addr = pctrl->phys_base[0] + reg;
>  		int ret;
>  
> -		qcom_scm_io_readl(addr, &val);
> -		val &= ~(intr_target_mask << g->intr_target_bit);
> -		val |= g->intr_target_kpss_val << g->intr_target_bit;
> +		ret = qcom_scm_io_readl(addr, &val);
> +		if (!ret) {
> +			val &= ~(intr_target_mask << g->intr_target_bit);
> +			val |= g->intr_target_kpss_val << g->intr_target_bit;
>  
> -		ret = qcom_scm_io_writel(addr, val);
> +			ret = qcom_scm_io_writel(addr, val);
> +		}
>  		if (ret)

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
