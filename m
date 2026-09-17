Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A26B643BDC3
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 08:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789634523; cv=none; b=gtg/42aPXa8HCcOONE9I1FLcKjnbPFB3UL73Ph8YWds+TRSJJbd1/EIXjFb6p6uiHEUX6FdzLaOrsCJ9yEXqgwBOwugzyBb/Qklzz2LmfGNG1EsGN0QCaI1BlBHDvhn41hXn8iVyLohM6Sxfjac7mAlitud7pyh90wvcVDDNwbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789634523; c=relaxed/simple;
	bh=KDaJqLXNcCVyqguB7u6yZb8TXNUYjurXSZy0CIDUH2k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Tvuvkce3Nu8VOKunr5ixWWTtF5kc0+C7pVU+e0J9xazR62HHmD9IPcY1sOmj8apiEF6qA8IeU5s4gyV7e2h4KD+d+Zy6VhHG02jO9yck4xSW7M3VKYabsmdJx8co03tq5OP2XuHbMTlFz4NqDwipgrqPxJ/2q6knfylFHTTFIqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=U33FJM/j; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=LdXuHhu0; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="U33FJM/j";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LdXuHhu0"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68H60tg21031676
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 08:41:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ZjQDioJHJpaRJll5O5OcVoNVSPLQ8ff8oyq/g5k0SXc=; b=U33FJM/jPVwxzlKh
	dN/VZ7rR7FwaTuIESZ30pMuQkxN2KkVdjxUyhDWCXs6HnM6F5CujAZEueRJUwvOr
	keswmPgMrOJJTPsRIvslVQ2GrDV3iRvi9qANKcgfspKm0DjQq92Pn8V1Bmio2CGC
	YTZ0EKotJLR6sfPVEhqJ5FSS3UetBq6WeL7i0S5JeTKJEjPr6pLba190l+rSnv2K
	AOToNyB8HITveSDYhqaUjEMWtb9qeMsnWjIrDBqGCL+e2t2bSmR7bnEkOYZ4ubNe
	ixpm8BpMSS3ASQTE9hG1VMBvYiKEXUStfeX3bHz/fGCyJwe7kq9Enpj0pYxx+o4A
	xe5+qQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gqy7hbawn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 08:41:43 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-939f8e7ff71so13813185a.3
        for <stable@vger.kernel.org>; Thu, 17 Sep 2026 01:41:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789634503; x=1790239303; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZjQDioJHJpaRJll5O5OcVoNVSPLQ8ff8oyq/g5k0SXc=;
        b=LdXuHhu0dzJcyQr9l7UncFAEZHQU45DFp4Lcqc8vYGwDY1RyTFBP0m+XuJ6zb5YC9O
         cGFd3hyU/slDPICBGFj//O+6pWKr0Uonnbl1xbjaFHknPMzfK/78Z62tOigCuqvFTriQ
         faJvmUuAICKlHgdsEYeZlv+huYZ8wPjG1JVBcMjEcb95h4swY9YZyFfOxIX80EIoICmw
         B432FgYBSwR9J9TvbJUxccer1XdTiBkKbhoWj6A+sjwg+YvJR3VErwUUkfi5QqIJoP6y
         RHEgaeZUMnda3JPklxgpv7Q9KcyV3xgKilpHmqrdb1UJ6+op9EHzCm459pIf91ANbYNU
         0fJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789634503; x=1790239303;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZjQDioJHJpaRJll5O5OcVoNVSPLQ8ff8oyq/g5k0SXc=;
        b=MuVSPvX6vmIWjG1yGcCCcMo/PDp0n38g9efA9CiYvYqAjNGMW1W9Wdm5nqxMU1apmE
         gwwwYLUqOlJ8mwP8v8SfCdV8keN6D0FPle6t46FslCmSfy1c32JSeNjlYEsW9rUdRvWM
         iHmlbL0iGh97oc1bAWI9gt0b6U7FJTR4nU8nC7/646g/akTNSA/Wt3YSoqh2xG6Bmtfg
         rcz1pZ4LaGjqM71XrKU9LEKGu0rkTVxeXwgP1iLv2gYMIpusK2/bTQdz6O3ge9BegtHJ
         8Ecjvy20JRbUy3xGYJ3myWh87NkwNOjNUDRm+ku4sAndVt6UBr83dUZPScCzkKuBrNfg
         3iDA==
X-Forwarded-Encrypted: i=1; AKwUvBy+gBYrow2xlnCL7B/ZdTUftbFsmiadeFXK6JipscmMRPW7xibPfoRTGwcSKaBWFg6zVlEtYLU=@vger.kernel.org
X-Gm-Message-State: AFuF++kpuFLbQ3DK5/hrglxGlkFLFul375KcoKSNxdo2TslcDKt4cLhO
	0qGUnSDBsAnY3Crrua0GJg/ozJynDjgGZiefEclrYlaDWpwVGCQOLMo7FLSGtbhrKuUMm1cywPs
	GNdAj/rNxJTcQuJwCGShu7FuJA3mzGDNFDHSEVlgrGfadmHXcEHgLHKg8Y6M=
X-Gm-Gg: AYBFou0eu6SDqW3LKP6Uz93vIlOCTYBSKKkQPmLrRLtUZRmc+rQU2hf7uCWBr4uz9ih
	IMg2ld9znt8I+5ehG/BGI+R5c9Vt/V7zUjp54ZlcKPSkWT/AliN/Fj6h1phNMlekeKgo1/FMU5t
	voUbLVylrFbKQifYsSAo5KxiotiMKFgggmIJHg5YM3yi4/IRT2W2P4DDLruahP2TwrIYOqxvuDd
	xzj9PbsgcXR4NQBl2qSgTugMh+oKcxEaoDuCfLQvIxv5euZM6FlgfLcP44IIkIOD6t8bmiil4Cy
	y2RntC4R5KsnAR/Z8QLYwD1d14sEZMhONqilnjQIQ/4KYKIAIY+3fuHtGFOvvLDsZE0wvBlHfdW
	zztTmZB2fxDZ/b2Cuv6bgjw==
X-Received: by 2002:a05:620a:a189:20b0:93b:beb1:5790 with SMTP id af79cd13be357-93bbeb16790mr525453085a.5.1789634503283;
        Thu, 17 Sep 2026 01:41:43 -0700 (PDT)
X-Received: by 2002:a05:620a:a189:20b0:93b:beb1:5790 with SMTP id af79cd13be357-93bbeb16790mr525451385a.5.1789634502896;
        Thu, 17 Sep 2026 01:41:42 -0700 (PDT)
Received: from [192.168.202.12] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c29de0898bdsm260029866b.5.2026.09.17.01.41.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Sep 2026 01:41:42 -0700 (PDT)
Message-ID: <6c61d38e-e874-4278-b188-166cbfdad067@oss.qualcomm.com>
Date: Thu, 17 Sep 2026 10:41:39 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] pinctrl: qcom: nord: fix GPIO interrupt target width
To: Zhangfei Gao <zhangfei.gao@oss.qualcomm.com>, linusw@kernel.org,
        andersson@kernel.org, brgl@kernel.org
Cc: pankaj.patil@oss.qualcomm.com, maulik.shah@oss.qualcomm.com,
        dmitry.baryshkov@oss.qualcomm.com, shengchao.guo@oss.qualcomm.com,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260916085720.771498-1-zhangfei.gao@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260916085720.771498-1-zhangfei.gao@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE3MDExNyBTYWx0ZWRfX6qlu9aEkssu9
 GaL7WKDTx59ETlEvqPywfyU6sLQ3TG9nM39OBwY9JR1pRfNJWeTtq7iAbinUr6d7TmUxCMAp3zA
 h8OqhwDqCNih86HXn9JZdYD6HpcfN6Xfiwr4C90JcQlxTb+h4Ddrbwbb1mOyhqOXfJuzGr4YqVT
 YEo+1Zblgn6jo/JJMfXa5IokwUhCR4PU8+cqOgE8qvvKWOYxhEC/AsCtXO/jhv8fCCI50wIVQTk
 DiUI9gNUhOh8fIATEW1gOZFoYS47f0CCNgrVKy5ViDN8G417rGLuHNvHv6iza1u5GR8qrjsFAkq
 TTh1Wxo9GNQD9HDsLTK8blMyc4ESYnKOTjI/5dKJBezaVgJLMDWC3hDtjUQbDqDWBOvHOzWra4Q
 zq97Q06R11xCG4RfW4mkjQIrfFFKxzETPjGKiROeE8/SY5TD+tH+gftG1AUuZ9c4AR65+6svJvc
 kK1eLrmp4ga804TWTbA==
X-Authority-Analysis: v=2.4 cv=L8aI0OT8 c=1 sm=1 tr=0 ts=6aaba7c7 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=NCczGnymYEpDLu10qSUA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-GUID: rw6ZCinGgeM_IgxS5Hawp6rvxU3FuWuC
X-Proofpoint-ORIG-GUID: rw6ZCinGgeM_IgxS5Hawp6rvxU3FuWuC
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE3MDExNyBTYWx0ZWRfX935DwzcM6kZ4
 hIR3KA+e+kIeEWw+enbvG+sGknbrOc17cOfVZRr5PDtXfJTpW94WbKjYWxQEQBhxmOdCfWzULKj
 FCveWXwT8Jd7rIWmzykAASB2l+ixl/o=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-17_01,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 spamscore=0 phishscore=0 bulkscore=0
 clxscore=1015 suspectscore=0 adultscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609170117

On 9/16/26 10:57 AM, Zhangfei Gao wrote:
> The TARGET_PROC field in the Nord GPIO_INTR_CFG registers occupies bits
> 11:8. Describe it as four bits wide so the common Qualcomm pinctrl code
> clears the complete field before routing an interrupt to the application
> processor.
> 
> Without intr_target_width, the common code uses its three-bit default
> mask. Since GPIO_INTR_CFG resets with TARGET_PROC set to 0xf (NONE), bit
> 11 remains set when the driver programs HMSS target 3. The resulting
> target is 0xb (HPASS_DSP_1), observed as an interrupt configuration value
> of 0xb1b instead of 0x31b.
> 
> The GPIO interrupt status is consequently latched, but the HMSS TLMM
> summary interrupt at GIC SPI 208 is never asserted. This affects all Nord
> GPIO interrupts using the TLMM summary path, including the Ethernet PHY
> interrupts on GPIO55 and GPIO141.
> 
> Fixes: c24dd0826f06 ("pinctrl: qcom: add the TLMM driver for the Nord platforms")
> Signed-off-by: Zhangfei Gao <zhangfei.gao@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
