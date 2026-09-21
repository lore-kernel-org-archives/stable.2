Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 167C9468C23
	for <stable@vger.kernel.org>; Mon, 21 Sep 2026 09:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789982860; cv=none; b=hGgnjEDWYp3sWVhxTpDIkxllMlnvNm+mWeBbWMQ0g0JH2h5SLYioOmH6hw44ECvLS1B1sc1JkpoGBo4pA4k8982ASllkpDxB8JCGzSmm3Khc3m8sXqSgEfOfUai3oHW18b+eSyFXgSiD5TKcSLDypf4dYrtaXLLRq7/4Ef9uwu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789982860; c=relaxed/simple;
	bh=N7Bwiz8vNzShNEWWo1hbEjNmyTi8IpUXmCv1WVc77gw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eZ2SO+6ek/wf5fRo2kU6mYQwShoYOIOh2b2uBCyinqoFAEMfET5wX+uz0n7TzrjXASjf7hIjAv/gYz7BEyJhsUhs5XHwmGC9Tal1stmMxdxB3DXElA9zegXYA6qF43dOo4ew2NBRfDw5PAEpOWDN0OoeYn/bD+M8zYLMBImGa9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=emtK+myv; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=JPFTvmwg; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="emtK+myv";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="JPFTvmwg"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68L7EGgj759193
	for <stable@vger.kernel.org>; Mon, 21 Sep 2026 09:27:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	6y9zQn6vdVFp1pIjeU34Sa+AThYw+cYdoj6+lWv6DoI=; b=emtK+myv3usdP24s
	OllM6ZLLActmbGIWq2Dsd3DlQZsIk+9Zg4RY+DSIH1KzrEkwP0XtH1p2heGqZwlv
	hpc0RnbFu7RCi2ETWJIXuctcgK2Y9r1NcaK6fb4kUTiH5fGyFpBZEQeJdzgz7Uou
	sCI2F8YJlEVkRJwCU3vUrIZx52YSEZhasX+1wJc0lrLUpku7pDP6CmtETVcFeWac
	CPPIuKYW2Q8NlxkjUPZ35ukMIJLzOZEfcwfyrWotYX/6/ve7VXvENjXPXqkbMYvX
	RvgdTpNzG8kv2GO8wTM/Fn+2qFVYzv6Pf0mD0kfr1EvKeaqb4RsRoiv0GKZ/8/w/
	7ocMAg==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gu0118hsw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 21 Sep 2026 09:27:37 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-92eebb130dcso89302985a.1
        for <stable@vger.kernel.org>; Mon, 21 Sep 2026 02:27:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789982857; x=1790587657; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6y9zQn6vdVFp1pIjeU34Sa+AThYw+cYdoj6+lWv6DoI=;
        b=JPFTvmwgPbAmq/ddV9qE6qiw/GTc4AkFv+KR/iLmZNC19sBEwUSBVmaO749ZL/xg+k
         8NYI9cAoMk6ZcuKSToRn8gfja7UgaWHla3Lt4PU3egU0yCVLRklMKOH2umeeEF1El7PV
         7E4acvbTTIEqEUOf0yDsiYMV/NZ8sFLslnE43ksnxc2ixA/FXGKwBKUSc46M7Ek61hyP
         HpCJJs5MHeW8OYyFQFENdYEomzHw+jo4aGxYloD2D9QOtdO/vczCzjEIa8Eb7K0pdex6
         DODiOjeGhLzBnK6Yy08alJYBpkc9JZ31Kt07NVmiv6h609ATga+a2/f/9HBNmB2CYXSh
         ATew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789982857; x=1790587657;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6y9zQn6vdVFp1pIjeU34Sa+AThYw+cYdoj6+lWv6DoI=;
        b=XDFTVh1i0a1+fqYwsWRYz3Pa/LjMOEx9bDa7fSaFnILr03W3+q4U7qextpGYTzgkG2
         6FG/A7fjANkAzUCXcwQ5VrBD/HenrHFYJZFa4z9FkxR0gIHg8DvtJgcbuMxZAIAMhGDa
         qxJFP6nNqWG1G2Q/QriTs4w2WI6aGUwx7T/hdLhMqka4yOoiAiK2wSf++Lq9GfLte0M/
         gGW6XCTqv29Jdx6YFMjjf/s10mJ1Dn58UmMnNAg4KJMQTQFBpF3lV+294FjV8n3deMIp
         X/Y8Uog8I9av8ZKOGyYBLR12aujYKW6BvAgEKvEx8xz18R4ImKUefuxDaBZrlzh72zwQ
         FOmw==
X-Forwarded-Encrypted: i=1; AKwUvByHw/y4HUawEhsYnD5EdPUQdTIUB7hDXWxvEc/rReBtSu3pdzq8nNwPJixG27NnQG1lepRqnyE=@vger.kernel.org
X-Gm-Message-State: AFuF++kUmqfpqBAlaAn2rikG26+hLhiXymf9XJRq/zGQXk59l3U4W9hq
	YytxaS4sAoIbPdBhR1x1rzRZ2HtWF6wS26fmmkc9M5gf2vVnQ8KWszl8q2rHcaaGg7EmrsAmRIM
	OcKrG8SDRagT9uZvKXu6Dx7QyPQWVNXHutdpqDv/S51cDrr1lUc569C17e6s=
X-Gm-Gg: AYBFou1umRByz8Vw61UsrKjnOI1ksHRVgat5+RzjmHP/advBTD0/H1EQbcOgAYPP4Ph
	dOIoH1DzKk5OcdET4y1KzJXSIU09boADVrLTWhGw2KgaDtvUhWdTezY1gmvtm4z3ObX0s3uR4WK
	neJYjryrlJF6V7TPNs822XOHR8sRiRWoj3+mIau3bwmo0iXFnCA7Dv6jE56qWSInnixVKJZhZVx
	JvrSAYwR5OFzitZ3zhOJ8Rjo3SEssj4JBgWO4YbjtGoZKjWyG89V7YkMo7TfsNulLAyY5+ZGrEd
	EOmRjy7S0OkEi+Fxl9kmWPmp4pM8xJmWXZQbqc0Kaso0xBpNTLkQSZTB7me0RYuYmGar8c/KD94
	SXhBFTmdfGToaekGY6Y85eQ==
X-Received: by 2002:a05:620a:470e:b0:939:c6ab:e3f3 with SMTP id af79cd13be357-93bf574e359mr981019885a.3.1789982857289;
        Mon, 21 Sep 2026 02:27:37 -0700 (PDT)
X-Received: by 2002:a05:620a:470e:b0:939:c6ab:e3f3 with SMTP id af79cd13be357-93bf574e359mr981018285a.3.1789982856852;
        Mon, 21 Sep 2026 02:27:36 -0700 (PDT)
Received: from [192.168.202.12] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2a3573ce12sm276656166b.35.2026.09.21.02.27.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Sep 2026 02:27:36 -0700 (PDT)
Message-ID: <989c8883-c481-4132-b6ca-3a333aa0788a@oss.qualcomm.com>
Date: Mon, 21 Sep 2026 11:27:32 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/4] backlight: qcom-wled: Fix NULL pointer dereference
 in PM callbacks
To: david@ixit.cz, Lee Jones <lee@kernel.org>,
        Daniel Thompson <danielt@kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>,
        Kiran Gunda <quic_kgunda@quicinc.com>,
        Marco Mattiolo <marco.mattiolo@hotmail.it>,
        =?UTF-8?B?QmFybmFiw6FzIEN6w6ltw6Fu?= <barnabas.czeman@mainlining.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        phone-devel@vger.kernel.org, Joel Selvaraj <foss@joelselvaraj.com>,
        stable@vger.kernel.org
References: <20260914-qcom-wled-backlight-v3-0-d69fe9843841@ixit.cz>
 <20260914-qcom-wled-backlight-v3-1-d69fe9843841@ixit.cz>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260914-qcom-wled-backlight-v3-1-d69fe9843841@ixit.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 7VXZDTRlZcTuNWfwGWCqtDyMPsxohfOB
X-Authority-Analysis: v=2.4 cv=dPczC+Zb c=1 sm=1 tr=0 ts=6ab0f889 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=VwQbUJbxAAAA:8 a=WGO8Zn8UdcYOddqErpsA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIxMDEzNSBTYWx0ZWRfX7NK1BbClyKWc
 MOF+mqj7wymaX3AYeiqkIvBziiQwrM1iIuCPg/ArWD208yEwWaBcQJ+3NE0K5/3JNvg/lkY7Vi8
 fRIJjpJIUSCmOPSWbKHS4QGUeBBZJFAeVrEGnXhoRdnx6b0P+rzMa4IZ6woWaeCPm7MQiQc1sVF
 szDux45WXy4rKk3gJ2cxb3nv8wS7AAHh6ID51QpE3bfS/KZOvVsdjpcPSpYsOmngxpP/k5P5io6
 MFV2Ty6vS9EkM4cnWDhz4f4BEmm5ITxl25RSiMt85JEroBPFwEIPosGF5MPG/wQA8v2lBQm7HEQ
 jhwqYTmyAjpPpP9+4Vqhs5JJQHFZspuOyCtQVKv9dmlWq5Z1Kfs1ytYPRJgQIY400Xt2dJeooik
 7becoY++xuKGw3f6XN2O4DF8IcKglaYK1gvgToYEqyPI69lCS6sNPi/4b5Gmxu5x4pKrYumW0eD
 3zJhid4+yNfMujTxMLw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIxMDEzNSBTYWx0ZWRfX0B+OGlXu/GNX
 ov/x/Qp18ojzZQurnexW9YWv+WgWhVs75Wj1Vl9MrP3W/7XyGCnqXmiVrIw9jvLawKMFO4bg9iv
 S2sjinvAdPy/CHaQkLLvRJJaIIU1H3U=
X-Proofpoint-ORIG-GUID: 7VXZDTRlZcTuNWfwGWCqtDyMPsxohfOB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_03,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 clxscore=1015 adultscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609210135

On 9/14/26 8:14 PM, David Heidelberg via B4 Relay wrote:
> From: David Heidelberg <david@ixit.cz>
> 
> wled_probe() doesn't set the driver data for the platform device.
> As a result, dev_get_drvdata() in wled_remove() will return NULL,
> leading to a NULL pointer dereference afterward.
> 
> Set the platform device driver data in wled_probe().
> 
> Cc: stable@vger.kernel.org
> Fixes: feeab87b3072 ("backlight: qcom-wled: Add support for short circuit handling")
> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---
>  drivers/video/backlight/qcom-wled.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/video/backlight/qcom-wled.c b/drivers/video/backlight/qcom-wled.c
> index 650dd95f06ef5..a76158a298335 100644
> --- a/drivers/video/backlight/qcom-wled.c
> +++ b/drivers/video/backlight/qcom-wled.c
> @@ -1747,16 +1747,17 @@ static int wled_probe(struct platform_device *pdev)
>  
>  	memset(&props, 0, sizeof(struct backlight_properties));
>  	props.type = BACKLIGHT_RAW;
>  	props.brightness = val;
>  	props.max_brightness = wled->max_brightness;
>  	bl = devm_backlight_device_register(&pdev->dev, wled->name,
>  					    &pdev->dev, wled,
>  					    &wled_ops, &props);
> +	platform_set_drvdata(pdev, bl);

This does make the pointer non-null, but it stores the wrong object

Konrad

>  	return PTR_ERR_OR_ZERO(bl);
>  };
>  
>  static void wled_remove(struct platform_device *pdev)
>  {
>  	struct wled *wled = platform_get_drvdata(pdev);
>  
>  	mutex_destroy(&wled->lock);
> 
