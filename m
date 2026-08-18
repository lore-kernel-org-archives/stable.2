Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 743213FB7C1
	for <stable@vger.kernel.org>; Tue, 18 Aug 2026 12:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787055749; cv=none; b=SMxIt0CSRaoaB9D8qUnpzsrv6pP1nbbPCjpSSamOHFy5hKQO0bn9sZB+ZTO6ize9NTwr+fNeoTob2IeG03mlUmOcUhn55x1iNHvYhhf4ZUNL4uzdF/UKntISMvjlrmenBKeeKxdAM0ILlhO60iPRERi80Ysou9aYMyTHzXqoYEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787055749; c=relaxed/simple;
	bh=8kO2VHWuXi8HRc0kEaow5D4nc+h/R0Hiw0R1pGv46ro=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=bktho0Um5JEbIn608lph5T3dghYRKJa1tMaAgpYGTT7Cg8pR/t75lG0e889Kh5YRv6DeuDkjOtLQ4zrczOd0dJkvtJF3OPjOSqjDQC/M7dKYZqERDfx4AEFOOrZ95yAm23baSYF9O2GMyjET5zA7y8ZsBg0PSY1NoT7kXvr16ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TGizrxsq; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=NNy7Dppv; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TGizrxsq";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NNy7Dppv"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67IABtqN600467
	for <stable@vger.kernel.org>; Tue, 18 Aug 2026 12:22:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	kCXqzalmkhIpG31lnKOThkzlwOR/mMpYM6LvnVk4AYg=; b=TGizrxsqdT3dYAEc
	uBbkltHWLY619Dk/pbN+KvCurxiYOEanNrluguVPCUPHrVZ9r26XBJB0lMponfaF
	InaToIORSTtiP4529qwW8qhbE7ELOjmW6beE7+HnxK9Bt4dpEgUmimAD5gKk6vuv
	hOfhtVxkaUs81aSXSVsDm+Ay3eW6u+o4BZ1RwTb+riMfxlnex4v/HW6gyHyeyvAz
	LSBZJqsv21LBVkWaBB5qImgujFiP/NBfuFrEQfHqjfhLpyslY8Vf0j4zD/EZB2yt
	zZiFDBnB3nT2r9/CCy/MySy/doQl0kcM21BekRY5oyw3CrdPF0T+8la5mdrp0EA1
	kJHs8g==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g4eqtt9aj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 18 Aug 2026 12:22:26 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-92ec3146553so49345385a.1
        for <stable@vger.kernel.org>; Tue, 18 Aug 2026 05:22:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787055746; x=1787660546; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=kCXqzalmkhIpG31lnKOThkzlwOR/mMpYM6LvnVk4AYg=;
        b=NNy7Dppv3OKclJtUTQDAV0LpxG8bCUGmqnQTjxfMEdJCn2ehTrHNF7Wv6CJTTbMaV5
         UpaINmk2Q9vi+wVXDf5gQeGsfbMBIoIxMihxvWFYTU0R8Tz8uLrcTkkZMgU1A/McH1/F
         zQO1sHj0WRtZpyt7xHaZDQVd2j/l9EOuBGgyiJktjg51xUFp62D7i5+5RybYuiTsMolx
         9OP3gdcevdmRiHVgN0/ij8+h2YsFesuaCp3TTDN7SP6vCdvHwEkEX8Tz2oqi5CsPJzqM
         2Kf+ybUVzCtzS74nXH7eWSnoRCfDCaj3KzQ9gDg0QTiW/UGLkLJpwwNbKAcQJwgF+vjq
         XZSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787055746; x=1787660546;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kCXqzalmkhIpG31lnKOThkzlwOR/mMpYM6LvnVk4AYg=;
        b=Gw07c/Fk/5Deue06hAfgYYsgVIts3tLjWp+I9jzJFf7ie/2gRpz3qDg1rJvSoZHWUl
         xg7QlOjehMBgPv3JtSGj1EqBGsUqlEliGKsNVlYDI1Acp+n0ZXPTFwfiJg31xrIfFx8K
         k+PKg0Hi9BJ1LGfGIWDzgQT1H2V+2EIHnnNMo7Nddyw9eVr0JXxfEpgFgr+AUXZA5Xi1
         YvtEjR3Vy1ZDrAeEi0ysUKqE31BFo57iqLYgcm5/bA5OC10+FcdjRLIOde2p2dfrGj1z
         xvugJNmBsHWZDQ6guFsCXirkaj9jN5IHzuhnduVcVyk60K9N0c9Erw0lsOXfHbl97N4r
         vIww==
X-Forwarded-Encrypted: i=1; AHgh+RqhdrJfsGJyTX66n96Dv1sNp6Ww1Bc2KHxYz3A1uWdCQWFIsEAAdmms/8QLwrvGLeO4ZkgkALE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgrHY/MicwbIajnPXkuxuNDYSk2zCWPq99gyiHv29Xowi5W99H
	wnaFKAujyt8o4sAzmRADSAoERJ6ROpJqg8KnNM6p5p1Y/OObIdZsu5/qPxbt+MP4Gp+6hAxwfl7
	EtnPZSHkMTGjvaDLEfbuWAgwI7Bmjd0DhS3n/hjQfvRFkuy4CaQ9H9KP5LlL1nHeGt+4=
X-Gm-Gg: AR+sD10QGbTocYcRYD5BQxj8SQDluIxhkFeJc4VmNIpM3evZzaVJOMcKpWa0XD9UwJI
	i1QCf7jgHSrpr8wFalA3fG9hW3cjJcSCw4X3bSiSEv5nnDQIVqOKoL4QMza7tnDocjKETWPhydc
	JiEZMghQW3ciVZ212ahyGCdCEcSsuOuUCmuH+KxQfjWlQv+nkswqXfSdMMa/tnXCDdWyPapkBMb
	x85tD6xd5fA83RgaDltW3JELH8mMNCfMWTiQiwCOUUfP5/2zpNUY8KXl8t+lLncUlLskVG3Oogv
	/sngmucyxzWgEPtOObopamxKVTXIs5NPtscZrLPnvr3GIjnvDH157dZuBPj7z0Mam8NmzHm6avp
	wCjTlqdr6neA3myTLIl+Iv6OVMIi3CpdNQ6trwDe0IIugvMuvZyPRI53WnAByLmClYdesCkPbFd
	KPkhyB3xg2LWVJl0W5bw8pBCtA8gI0wSoaQpEqKt3EbCmJWYdaSGP5tJFjWMsF6seXNCs=
X-Received: by 2002:a05:620a:2b85:b0:936:e80c:e0ba with SMTP id af79cd13be357-936e80ce8dcmr2480291185a.0.1787055745616;
        Tue, 18 Aug 2026 05:22:25 -0700 (PDT)
X-Received: by 2002:a05:620a:2b85:b0:936:e80c:e0ba with SMTP id af79cd13be357-936e80ce8dcmr2480285385a.0.1787055745204;
        Tue, 18 Aug 2026 05:22:25 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a3d852d915sm1700676a12.9.2026.08.18.05.22.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Aug 2026 05:22:23 -0700 (PDT)
Message-ID: <fabcdf9e-e825-4bcf-876f-0aeea9524b00@oss.qualcomm.com>
Date: Tue, 18 Aug 2026 14:22:22 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Hans de Goede <johannes.goede@oss.qualcomm.com>
Subject: Re: [PATCH] platform/x86: int3472: Increase handshake GPIO delay to
 200 ms
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Daniel Scally <dan.scally@ideasonboard.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: platform-driver-x86@vger.kernel.org, linux-media@vger.kernel.org,
        James Alexander <opensource@inspiredexperts.com>,
        stable@vger.kernel.org
References: <20260818121445.160751-1-johannes.goede@oss.qualcomm.com>
Content-Language: en-US, nl
In-Reply-To: <20260818121445.160751-1-johannes.goede@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDA5MSBTYWx0ZWRfXyea3fdDuL9vP
 Ct5qaTUbhjJn4g/ndf7x8NxjZDN6GgutInrHeU+FN0z6EZE6okfZJ+6eh9ER3C52QLe1prPR4/E
 A1nSjm33k+3q4G4k/G18pN/DJjUzkYI=
X-Proofpoint-ORIG-GUID: xXD-85eMINoAqgwk4B-2VWTOSDPnfaRZ
X-Authority-Analysis: v=2.4 cv=UfFhjqSN c=1 sm=1 tr=0 ts=6a844e82 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=VwQbUJbxAAAA:8
 a=BEWJZVgQAAAA:8 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=isYjQQs3ymCD79PP7cMA:9
 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22 a=r2lMSnxMdfrVB7dy-wwo:22
X-Proofpoint-GUID: xXD-85eMINoAqgwk4B-2VWTOSDPnfaRZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDA5MSBTYWx0ZWRfX1PKGUN9sTu0M
 BXaLb1c79pZIkNd4lXCP4KkwszpSHWC2VkjChTFFuQawpTtd3+9hwSSg3zhK6DmfUGxFeF7ERr7
 bviVcMgBInm+ljdnT216Bb2pPWLcUKiYzmIFKA0NivFNj3vz1384ZffZicQaxGICHkbFYybmlLv
 s0nwib+LJA5MVMr99GYIOMgsrNhtYU6lu3nJeE1WG6XMgDN6Gu2CrBcfBSTftRmx/8s+ORdmWpk
 M/OJRlqizuizfp0nMBZR3r3EG/aGTWA0kbMgxXSVtiM/CtDKX6yVVp9y6Jbb2bouWDNpDoPMx5y
 W6iLPmnuOmRbkNp1UFRqz62sfev4fejaY3XL/wvkcrmr/05mc+/QgD8Dgp/21bsxRIU4QQu32kI
 0yc8BYP2xJlSxTLR9iRKh66QurPw6KWG4AWi4hTsB4qAf2b7w+upveZ8g0OSHgWTfyWhyiCus9U
 16d7vnbo0fuZtaEfKkw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-18_01,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 impostorscore=0 suspectscore=0 adultscore=0
 spamscore=0 priorityscore=1501 clxscore=1015 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608180091

Hi,

On 18-Aug-26 14:14, Hans de Goede wrote:
> There have been several reports of the sensor not properly powering on,
> on laptops where an INT3472 handshake GPIO is used. Both with ov08x40 and
> hi556 sensors.
> 
> Testing has shown that a delay of 200 ms is necessary in some cases.
> The handshake GPIO is typically used to signal an extra bridge or other IC
> with that IC running the full sensor power sequence based on the handshake
> signal and also possible controlling I2C pass-through.
> 
> It seems that in some cases that extra IC takes up to 200 ms to before
> the sensor is fully powered up and ready for I2C communication.
> 
> With the default handshake signal delay increased to 200 ms the quirk to
> increase it to 45 ms for the ov08x40 is no longer necessary and is actually
> undesirable since some ov08x40 setups also need the longer delay, drop it.
> 
> Fixes: 30359c239ba8 ("platform/x86: int3472: Increase ov08x40 handshake GPIO delay to 45 ms")
> Closes: https://lore.kernel.org/platform-driver-x86/20260816204247.2844986-1-opensource@inspiredexperts.com/
> Reported-by: James Alexander <opensource@inspiredexperts.com>
> Closes: https://bugzilla.redhat.com/show_bug.cgi?id=2333331
> Closes: https://bugzilla.redhat.com/show_bug.cgi?id=2333647
> Cc: stable@vger.kernel.org
> Signed-off-by: Hans de Goede <johannes.goede@oss.qualcomm.com>

This does not apply cleanly on media-committers/next, let me send a v2
with this fixed.

James, assuming you are not running a -next kernel, if you want to give
this a test run you can use this v1 for testing.

Regards,

Hans


> ---
>  drivers/platform/x86/intel/int3472/discrete.c | 12 +++---------
>  1 file changed, 3 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/platform/x86/intel/int3472/discrete.c b/drivers/platform/x86/intel/int3472/discrete.c
> index 115bb37577a1..f9e42959647e 100644
> --- a/drivers/platform/x86/intel/int3472/discrete.c
> +++ b/drivers/platform/x86/intel/int3472/discrete.c
> @@ -15,6 +15,7 @@
>  #include <linux/platform_data/x86/int3472.h>
>  #include <linux/platform_device.h>
>  #include <linux/string_choices.h>
> +#include <linux/time64.h>
>  #include <linux/uuid.h>
>  
>  /*
> @@ -157,13 +158,6 @@ static const struct int3472_gpio_map int3472_gpio_map[] = {
>  		.type_to = INT3472_GPIO_TYPE_RESET,
>  		.con_id = "enable",
>  	},
> -	{	/* ov08x40's handshake pin needs a 45 ms delay on some HP laptops */
> -		.hid = "OVTI08F4",
> -		.type_from = INT3472_GPIO_TYPE_HANDSHAKE,
> -		.type_to = INT3472_GPIO_TYPE_HANDSHAKE,
> -		.con_id = "dvdd",
> -		.enable_time_us = 45 * USEC_PER_MSEC,
> -	},
>  };
>  
>  static void int3472_get_con_id_and_polarity(struct int3472_discrete_device *int3472, u8 *type,
> @@ -234,8 +228,8 @@ static void int3472_get_con_id_and_polarity(struct int3472_discrete_device *int3
>  	case INT3472_GPIO_TYPE_HANDSHAKE:
>  		*con_id = "dvdd";
>  		*gpio_flags = GPIO_ACTIVE_HIGH;
> -		/* Setups using a handshake pin need 25 ms enable delay */
> -		*enable_time_us = 25 * USEC_PER_MSEC;
> +		/* Powering up the sensor through the handshake pin takes up to 200 ms */
> +		*enable_time_us = 200 * USEC_PER_MSEC;
>  		break;
>  	default:
>  		*con_id = "unknown";

