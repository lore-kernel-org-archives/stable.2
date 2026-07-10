Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B147397E91
	for <stable@vger.kernel.org>; Fri, 10 Jul 2026 20:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783714919; cv=none; b=XRfs+9d4hHqTC7TOsppfj3Lvxk6eXDn5ASJ/97gNhgE9nzuBNz460ye4NQz+O7XfPMu87la167XsO5XMN8QROjNWlaEs2kCnaNy5i9aSW1OZAPhegCKmg2Ac21vRqlspBoN1FQlF+dZdye9WQ0q71zZWGv9nPLSJRMCkP7s7TpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783714919; c=relaxed/simple;
	bh=mwmcHxrVR+kz/WQi8iOjtcMfnkGRz+vLnMOAEhzR2Uo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HArtVvuXulx4agkjRpUf+PihEIxKfFZspRtFYjbmHIkM0PY0czdTeq4PNpeanOfyg+1nXWGRCaE41x41uer+1pItE54QI4lNW8k61THZU+HVX4mxiWvt017YefeLLv0iOwLRPA6Bc0oblImL6k+shpwK3JKEhPcb//bF86X+JVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RRaayQZ5; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=CeNYHzfd; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RRaayQZ5";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="CeNYHzfd"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66AK3kDS1840941
	for <stable@vger.kernel.org>; Fri, 10 Jul 2026 20:21:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	f5MBPQjfTBEuM72l/dKsAgwUJbCHso/oUhnZImxy64I=; b=RRaayQZ5SX846iDI
	LV0P5ysidPkoDfl8AHncZ6zLIPkh8pIQNfFx5uEucad6t39P5//Q+Gk2+jHRaVbH
	vPJR716lgEY+dOIiWziGWqwrLNCK8L6hBC6ruKLTSK0AjI1Mv1Q1cuRK+pxqxEFN
	lWpt+iKZ9gCqiEFVaDNLPWFRBiF49NnLInuaOBZnYsRSaw7O1TA44y3kO3GoXYeX
	eL+OuWAEjjlYg7eIasHjLOLjoHXSJ/OK+hjSshOCEaBx8nWwMAeGP7mvjeTJ101X
	Yel0bA/vddguKGpWA2Gf+5yGiFeuWSZLmQwZUDgdlYivwuVxDIXErTQSnXpSr7x1
	5gRxIg==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fas6n3j5c-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 10 Jul 2026 20:21:57 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-c85798977dcso1925988a12.0
        for <stable@vger.kernel.org>; Fri, 10 Jul 2026 13:21:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783714916; x=1784319716; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=f5MBPQjfTBEuM72l/dKsAgwUJbCHso/oUhnZImxy64I=;
        b=CeNYHzfdzWxuUc4MPdpJOr/C+st3TfiYb+DNvAH4GAWewpJTyeypDAavZqt4bB5fvb
         HFCNENNJBa1Qh771iSBzRylkFeUyXMraUMUX8CBg/O0Lefwks8Vfn6SQzR45+6sz27XO
         rZHWpcpxOxtM4h0XHUmxoyFBalMiQta78MdNnu1eDLgMB+Hvzq63yucGKWokMxWLVMJQ
         irVX3bk5Gj6B64SM+eqc1s3M/4GKV1/DtUp7Dffy+U59mrrejbIBYqIzrNwwaDE6X6+b
         M7lS0Kasgfg4ihPAabuRTKeY54wyfy7VOToq/blYD/iz8JP05VkRnI+RyqfzQ6NFwuZ+
         LSwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783714916; x=1784319716;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=f5MBPQjfTBEuM72l/dKsAgwUJbCHso/oUhnZImxy64I=;
        b=QWFzIr8TxFFQXJIcefbrf4RVbs14eCjkP+/y0mQJOCCiMc3ZeGMA2nRa+jSrONVdfG
         c/LaCE7Rn8Jx/GSykO2b//fSqTRLA5wR+LuHHwxnF4oCUzadvk4s3hEhKs4IZk+zNDFl
         vOzqpJsOGC3oE3zQ6mOk2gibU7lAnK7tzR++1YNg3gczWGri9wXFs5ix/YDrQUqP2Uh7
         Ui06IvFdgMWWD7r//dWMa3f1UUwbcqTrpEv+X6D9ddPMcw2vCtuo1yE9WaKEq56vEWuO
         dO4iPXz7qIYSoUTPR5j63ey66MTAPTsBX5enqiZ0OgkMjSdkIlUfgB2CZUWFT1OvlYIE
         oS9g==
X-Forwarded-Encrypted: i=1; AHgh+RpW6SwS+unB81O9GwnxR3Ca0lAs3ZimA2Y4VYt1L2RWwsnXRw3taoJO48qrLQp8RZ6aFtqaBLY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1BsYX+K017LhYx/fQxfzHIvlbTmGKFyFC8mO5n1uD5mlE/i44
	vPlS3TjPCGqyUR/6U/SnNxmvph44n30s2gpVXXRuSe3D2OxyZDZU0YwUxwlYdmLHlZsdBupf8x8
	JzhDQGxPZLX4Q3pXVJdM4Vb8CNLZ22QCOjUPxAQDTOaMpEDAfM7J1TsQJmTo=
X-Gm-Gg: AfdE7ckgINXlhhQQlF2nRUz1r8DsxwbmV4IqyR75LcdeHE7d46Q5koF/qjTlMEiz1n9
	lXxxuYucckKjlkidPIJLkOfUHusU74/MeTGf09628hs9x+Ooaq6eG0Ew0F3ns1ayMwVgPSFgz4t
	nk5FeWKjQvxKBD82+1qjTo+G7jgkDcvNs0r87ZQ5Yo594HaXUObMf2e2lHKvREEEl6CUDEhL3kW
	PFllqXv+fPrlEpoxTjfQFM/in+l4x68ArKSeW2CFQKUoKW4vuOYwuOAg+GbGaMgMuQibakdXqt5
	NOxcJ1Pbw12KS8h1xohUIB7zcxlv+gi3fbohuQ0C4Z3juv9Tn5PdI6tg0uSf+ib3gI16CAVfsNP
	NagWUFDq/Lnx8jRNLhLrCyiSdWZW/S+0PooZR
X-Received: by 2002:a05:6a21:e083:b0:3bf:7fa5:8922 with SMTP id adf61e73a8af0-3c1100092dfmr545789637.2.1783714916056;
        Fri, 10 Jul 2026 13:21:56 -0700 (PDT)
X-Received: by 2002:a05:6a21:e083:b0:3bf:7fa5:8922 with SMTP id adf61e73a8af0-3c1100092dfmr545761637.2.1783714915523;
        Fri, 10 Jul 2026 13:21:55 -0700 (PDT)
Received: from localhost ([50.35.46.84])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b658a99afsm41399058c88.0.2026.07.10.13.21.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 13:21:55 -0700 (PDT)
Date: Fri, 10 Jul 2026 13:21:51 -0700
From: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
To: Laxman Acharya Padhya <acharyalaxman8848@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
        David Lechner
 <dlechner@baylibre.com>,
        Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>, Yasin Lee <yasin.lee.x@gmail.com>,
        Joshua Crofts <joshua.crofts1@gmail.com>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] iio: proximity: hx9023s: validate firmware size
Message-ID: <20260710132151.00000f37@oss.qualcomm.com>
In-Reply-To: <20260710152842.53659-1-acharyalaxman8848@gmail.com>
References: <20260710142212.52225-1-acharyalaxman8848@gmail.com>
	<20260710152842.53659-1-acharyalaxman8848@gmail.com>
Organization: Qualcomm
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDIwNCBTYWx0ZWRfXx5QMgPHdfecG
 zlQ4Jz3GDLcNWgviXvV+8nUOKt95js7mC0B+butRuW0zbf8KggbELu/sgrmh2V3soTmRMwYLySx
 KNZV5C/dTjkOK45lwiRRCgkmazev8ZA=
X-Authority-Analysis: v=2.4 cv=DYgnbPtW c=1 sm=1 tr=0 ts=6a515465 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=qC1CW/w66vtJz1P9yTJxNA==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8 a=I__WuZVpHmGD6N4htagA:9 a=CjuIK1q_8ugA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-ORIG-GUID: ymbvfbXFVZswUiOuDwxhwiPN7YW7ydTI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDIwNCBTYWx0ZWRfX6CRzJlW38lHN
 DYkr29eFbBVglQN5rMnwyveMjPlfCeshPsIIBrdfk7twrEBc3bntAon7Xkdoy+lARwnZhz6jt0t
 hGhwgweKeKXcpYNgXpxp+j6a2aVZXESv32QKlRqjfXkrlYnvDNuo5i+cnTHJNA4eS8ayjKtNx/r
 8sE+W06KTHEv8lVOpO0EmcUmuO46dQU6R/HneXmBk41KAol11fmOeB+9rnS1QzrZR6pOQqf3Vk7
 fRFs7Rgj+s4RYDeMp1UkeqBGaM26qqHIRBRE4INr2TKuy8PN4QF5cxnD7eo9knujBwu7mkErUU0
 ssVaHaDxJ1R1pliUlymLk6NlaQxVptWAaYqKCRw8s/rLEjZS8V4MH5uOD+7ZECiiAxNd4eluuEg
 /nU4xVWgAMmy2Z0Le7eCtmHa39SYlJEH3fTeIf+LrJKKA/5ZQSQ6MMXzq0VXJn2RhVyT7S1SYxJ
 KrCM2aoWLVvKWRKNjBA==
X-Proofpoint-GUID: ymbvfbXFVZswUiOuDwxhwiPN7YW7ydTI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_06,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 suspectscore=0 bulkscore=0
 clxscore=1011 phishscore=0 malwarescore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607100204

On Fri, 10 Jul 2026 21:13:42 +0545
Laxman Acharya Padhya <acharyalaxman8848@gmail.com> wrote:

> hx9023s_send_cfg() copies the firmware into a counted flexible array and
> then reads fixed offsets from the copied data before walking register/value
> pairs starting at FW_DATA_OFFSET. A truncated firmware image can therefore
> make the driver read past the copied buffer during probe-time configuration
> loading.
> 
> Reject firmware images that cannot contain the fixed header, reject images
> too large for the u16 fw_size field, and validate that the advertised
> register count fits in the remaining payload.
> 
> Fixes: e9ed97be4fcc ("iio: proximity: hx9023s: Added firmware file parsing functionality")
> Cc: stable@vger.kernel.org
> Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>
> Signed-off-by: Laxman Acharya Padhya <acharyalaxman8848@gmail.com>
A few minor comments.

Thanks,

Jonathan

> ---
>  drivers/iio/proximity/hx9023s.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/proximity/hx9023s.c b/drivers/iio/proximity/hx9023s.c
> index a6ff7cbe9e6..9d91ce681ac 100644
> --- a/drivers/iio/proximity/hx9023s.c
> +++ b/drivers/iio/proximity/hx9023s.c
> @@ -18,6 +18,7 @@
>  #include <linux/i2c.h>
>  #include <linux/interrupt.h>
>  #include <linux/irqreturn.h>
> +#include <linux/limits.h>
>  #include <linux/math64.h>
>  #include <linux/module.h>
>  #include <linux/mutex.h>
> @@ -1031,8 +1032,11 @@ static int hx9023s_bin_load(struct hx9023s_data *data, struct hx9023s_bin *bin)
>  
>  static int hx9023s_send_cfg(const struct firmware *fw, struct hx9023s_data *data)
>  {
> +	if (fw->size < FW_DATA_OFFSET || fw->size > U16_MAX)

Add a comment on why you've picked that upper limit.

> +		return -EINVAL;
> +
>  	struct hx9023s_bin *bin __free(kfree) =
> -		kzalloc(fw->size + sizeof(*bin), GFP_KERNEL);
> +		kzalloc(sizeof(*bin) + fw->size, GFP_KERNEL);

This doesn't belong in the fix given it is just a reorder. Maybe it makes sense
but if it does, separate patch with an explanation of why.

>  	if (!bin)
>  		return -ENOMEM;
>  
> @@ -1041,7 +1045,8 @@ static int hx9023s_send_cfg(const struct firmware *fw, struct hx9023s_data *data
>  	bin->fw_ver = bin->data[FW_VER_OFFSET];
>  	bin->reg_count = get_unaligned_le16(bin->data + FW_REG_CNT_OFFSET);
>  
> -	release_firmware(fw);
> +	if (bin->reg_count > (bin->fw_size - FW_DATA_OFFSET) / 2)
> +		return -EINVAL;
>  
>  	return hx9023s_bin_load(data, bin);
>  }
> @@ -1058,6 +1063,7 @@ static void hx9023s_cfg_update(const struct firmware *fw, void *context)
>  	}
>  
>  	ret = hx9023s_send_cfg(fw, data);
> +	release_firmware(fw);
>  	if (ret) {
>  		dev_warn(dev, "Firmware update failed: %d\n", ret);
>  		goto no_fw;

