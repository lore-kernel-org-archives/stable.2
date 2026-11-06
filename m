Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793954893;
	b=UZRRv9afqZQS1C/d7qPuFHEHAsuCeGkDoLYVmQDtMAmEG2FgSIytq9pal4AUe3FMRGXx
	 J2JuWl5lMj9Bjd52D9vUro2aP7LAkaAcs1IvYmrQs84zNjhvXqWINu8K8PYYjpvAlloZ4
	 8X0nJnimhSDC4VbxnGIn4fB7k32znc/REwWm2mRZokEnBatpk2bVGcOjjWVuBdhDV8Oss
	 QAC16WKEXof0/H+lOo6rChwH3/6SqfX4IzsBOHFJSgVndi7iZcm1GeSRgVU2ifIUIlimS
	 Mh+Zbz16YdOzSklvewGpCT0y0qdGFeRGnJ91as02mf5h5qKezoz7OxmkjaCIneKETlw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793954893;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=k2FbAyux9MGdLB8gSy+e7iMBMpdgqsliTMaQr2Ms7z4=;
	b=Ltxd2d+Qbh+gpFg2Ax9EXwmufJEGn95bO7oRAt3YdcCSfgqq8suw3QYYQqbq9IhmVwRR
	 fPLMTOgPamd/apc3Xkl6npvvYxMDuwYwVoOkXNJroN23Ef1cwxWK/0UX+7H+WpkNSORrD
	 tXXYIJZMlQS6BG0xuLMC+58M1CFSmvgpFXmV/CNb+iHS83QL9MICCqFkI/9zmVOukGt+n
	 jouJPVbdwwGsO4gu95/j1omOBcYuea0dwLeQynJ1SV/BxcN/QRw3M5n4Rg3Meyw3okP3t
	 Gwxfz54bHizD/JnzLwilxk80fhQcwh5bzgYsLo6pL9Tj4iKUJUREua0pnRoJIWfGyMA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=eZZK8WYj;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=KKUR54J3;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45805606A32E
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 08:48:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 45805606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=eZZK8WYj;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=KKUR54J3
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A67RCe8045324
	for <stable@vger.kernel.org>; Fri, 6 Nov 2026 08:48:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	k2FbAyux9MGdLB8gSy+e7iMBMpdgqsliTMaQr2Ms7z4=; b=eZZK8WYjuuP2/fLZ
	rGYutrJAe8m1ZiwNMwRjzAiU0mbshZjNaUGXok+JEBFwbFkWjBOUNco7RSycCygI
	TLq2Lmjfu12mj7W/vCOqvmHrsZp0O62aRhNt50aXT2YNyn4L3Afj83pgWsbwH9u4
	epd+KcZtbyD2ge9AF8EiagjR4CUIms8yKR1X5oZvVTuS1A6/SgDZacM7B7B1I2DT
	iWHjvatYEOg8fgKmJb1tBeb1xJ1QU+jlTFdAyGFLxYLjogmj8OCTcD/DA4VzEaEp
	XiVZHd7LqZ2agUaT4kk/FTmYMOCTE7+I+ra7Xb+Uwd2G2bD2fy3n3gZMCVsJUImG
	MIRmRA==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hs3p9t00a-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 06 Nov 2026 08:48:11 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-93ea6b66e53so10059485a.2
        for <stable@vger.kernel.org>; Fri, 06 Nov 2026 00:48:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793954891; x=1794559691; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=k2FbAyux9MGdLB8gSy+e7iMBMpdgqsliTMaQr2Ms7z4=;
        b=KKUR54J3FKaZCxRNQp+3Gogi+fMo+EXtq4jWF7XAnSXRIqt/GESvjwCU3Ld/ewGv4z
         ipOOlV+LuGPFzbIkQJ3FMwiUdtssSemTZ4StMYhhZ59Nsa1ta74GB2KvA3jePh/W3qUc
         UhoTd+w226LIcSQQe463ntnwIAtE3CqNlAim2ZFwXibHRJT2y7uFUZ/AH7RG9F6OSPHo
         DUSQIRSNZfNHYCdiek9IynkiBpodX9c1dsqa9WHP/1hDuedkjYTzqukGMbKMhl5/wNjg
         U/dcClyIYHLOr4dVqoa6JUxLnSqIVQoCqtUJArx5lhHdFQDfXR9nE+PuwX5aWiCIM55G
         gLkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793954891; x=1794559691;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=k2FbAyux9MGdLB8gSy+e7iMBMpdgqsliTMaQr2Ms7z4=;
        b=L6ZynNk2nf69cxEX8O56fZ+lyZDDa96OxLtoUkyd/QGs3kmsyjbpCpuIHvpeSN0aW1
         9RG0NwaGc6Z0M5+rhZYSpTJgLu3Kxvw+tijx8si9RTqbYnEmA6ljNUX1LA7fULCUtO9w
         y+fmUdUD/eOTkvRy9RpwqUyWBZwB5sHmBDhk9yzZtxE4sCIs7JEKBk3MQJcZRYMDR1TG
         GypIN03os4cuEjETanLE8aqRVAp3y/ztDT1MIvxnGfuAgSzon9A6OdOZQ73YCH27kLz2
         K0KrpqCFodVMUUtdUaxhx65rHnerNpZYHgmhcH4YkceelqnFTQykpCcEisGBHpoN6+Yq
         3/WA==
X-Forwarded-Encrypted: i=1; AKwUvBxLXzQUvEOMfSRwQdJQpMuhrM0tfgnoOAabDcz+sdDAX3FEEZIf8dN8kzDI50GenBMyb11TTFY=@vger.kernel.org
X-Gm-Message-State: APuU4Z9H+qdifi65iaUaPJpaGbg8RKnx5uoL5YcB0/yESytWqjjx4Mjm
	apHpuUYYdm4kApyaahFq1iJ1tNz+rzcFFXiKVhRCY2CVNlzA12ykugJWLY1wImIuBobRx3FQYsI
	EKNANBx+pHUkQNhMTMrdVujCtbDzgCm3dZM4QttoleDYXiwBwzGinSW1F2mw=
X-Gm-Gg: AYBFou2OdtW3CYXMW6x/ZMjmyydqqDumq/asGp5rP6R9qufrkB+F/duQyTQXeoP0K7g
	v1YwWi1TlOtwuVfs7rt7YJfFK05kF35lxxBZefCyykje6O4zBaI3fZdulQwpJztZQ/7Ae5C8sOc
	roSTTyi5SAzdbghhJMdp2NyFDE5dJ9iRqV7IuQM10W9yJRFkhcA0ovgClhvvMvh7wlWKyKrphqk
	YlPLCRu6zSNbwL5jGClJKeaIb1AA2gT+JXq1DmuJuokwfjOsAOKfEr9u+CITKFntz/uwLrgRdr6
	cl6ODzsaxuPrL3M6DFRNLHuJizdlEx5Z6Qe4yJr2+/AMNLEDNoanxUBO321rr5ZNoG85ISz558J
	9NmiZYCOqUUIpR8xTew9qPbZJeF5rvQZS0FvQBf90n0W1RFXKqpLYucmCPIkmYnqOFyyp
X-Received: by 2002:a05:620a:3c17:b0:945:e612:cf59 with SMTP id af79cd13be357-945f35e5863mr220662685a.5.1793954890672;
        Fri, 06 Nov 2026 00:48:10 -0800 (PST)
X-Received: by 2002:a05:620a:3c17:b0:945:e612:cf59 with SMTP id af79cd13be357-945f35e5863mr220659785a.5.1793954890185;
        Fri, 06 Nov 2026 00:48:10 -0800 (PST)
Received: from [192.168.226.1] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c4d3566e050sm61977266b.32.2026.11.06.00.48.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Nov 2026 00:48:09 -0800 (PST)
Message-ID: <e53010ae-6347-45df-9574-a121aa4711d6@oss.qualcomm.com>
Date: Fri, 6 Nov 2026 09:48:07 +0100
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
Subject: Re: [PATCH] pinctrl: qcom: check the return value of
 qcom_scm_io_readl()
To: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Bartosz Golaszewski
 <brgl@kernel.org>,
        Linus Walleij <linusw@kernel.org>,
        Christian Marangi <ansuelsmth@gmail.com>,
        Ajay Kishore <akisho@codeaurora.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20261105-pinctrl-qcom-scm-fail-v1-1-a23f96c6b313@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261105-pinctrl-qcom-scm-fail-v1-1-a23f96c6b313@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA2MDAzNCBTYWx0ZWRfX2492Zz1dv0PJ
 WyCkf03i1H8APgQWNFwBE/key3GOahDkc18YrwjLe9ijC/rIhuFnEHI0URMyr0eFUTmQEbkjEy9
 o/P+1gDCm9AuLxZ3P/AWSbWrK+iRERM=
X-Proofpoint-GUID: KjnaANX07inDUqLIRne7zeK9G0esI3YH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA2MDAzNCBTYWx0ZWRfX+BVTh353GUwI
 pzj5q63+ipyV8TgyB0VVqFeg+jZJ3Y4S3bTiX2rT5MH6RAPIYutJnMFyIvwECwii9915g0T9X4W
 1+NOS65dK6GyCYrCxBjZc/Du9IW5BX/qqSUZs44i2SqCQtddl6aop+Butl1PxdOEsAUYf9Ia8hd
 TP5CGDvnNpGXiveRF/7s+EA9kDCRcFQtqNmsJNDgoLbKWRM8W0PmI5NcFCP5EKLBpBeZfppfzo3
 o1wswBJBjVrikwCXroTLryJ2R5VLrUIXgO9JD+j+BLPTZbLfFXOVCohe/+bt08Ym0SnqlXpKMiT
 GDouMiZHkAd6/X+lLk8SOrTH/RSmsP4TtwP/j8qlkLN861xSa7JnklHSbcxgLaqNH2rj1iLdRer
 NKwqkK15J+0N9qkepcEu1+3PSatSJHsGlLjiHAWAsKUCUeqo1GkBqeyN2382UkXjsZteW+HqCRb
 SPKR221TqCxjLJPcPNw==
X-Proofpoint-ORIG-GUID: KjnaANX07inDUqLIRne7zeK9G0esI3YH
X-Authority-Analysis: v=2.4 cv=ZIZCCn7b c=1 sm=1 tr=0 ts=6aed944c cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=c92rfblmAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=PcXE8KnCS75fSRLkHuYA:9
 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-06_02,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 suspectscore=0 bulkscore=0 impostorscore=0
 adultscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611060034

On 11/5/26 5:18 PM, Bartosz Golaszewski wrote:
> qcom_scm_io_readl() performs an SCM call and may fail in which case, the
> stack variable val remains uninitialized and its contents are written to
> HW registers. Check the return value and bail-out on failure.
> 
> Cc: stable@vger.kernel.org
> Closes: https://sashiko.dev/#/bug/linux-a5545ffd-48cc-4856-94cc-4b2dd7968f50
> Fixes: 13bec8d49bdf ("pinctrl: qcom: use scm_call to route GPIO irq to Apps")
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> ---
>  drivers/pinctrl/qcom/pinctrl-msm.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pinctrl/qcom/pinctrl-msm.c b/drivers/pinctrl/qcom/pinctrl-msm.c
> index 32aa7b919e24a0e614078ddc70a248c746e4813b..0053d1d927dc134ee81377fe480befa2da87c7f5 100644
> --- a/drivers/pinctrl/qcom/pinctrl-msm.c
> +++ b/drivers/pinctrl/qcom/pinctrl-msm.c
> @@ -1117,7 +1117,12 @@ static int msm_gpio_irq_set_type(struct irq_data *d, unsigned int type)
>  		u32 addr = pctrl->phys_base[0] + reg;
>  		int ret;
>  
> -		qcom_scm_io_readl(addr, &val);
> +		ret = qcom_scm_io_readl(addr, &val);
> +		if (ret) {
> +			raw_spin_unlock_irqrestore(&pctrl->lock, flags);
> +			return ret;
> +		}

Linus already pulled Lee's fix 

https://lore.kernel.org/linux-arm-msm/20261103213002.1673560-11-lee@kernel.org/

Konrad
