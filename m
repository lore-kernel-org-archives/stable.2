Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DB4A378D8E
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 08:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788854446; cv=none; b=dXCbyXbMK2eEHLR1qpfu8gy/YXeyPTA0caxtYjR+63M6oGS3cWPnda7j7iKthhfEvPqekBKqRoLtyh0H22nfRoUecO57CTZ/H/53yinhqJno7ABTMt5iUHOvPuMHuP882nxQCR71ANY5nrdJqjLG4YcITQtXe30kMbzqW+REpYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788854446; c=relaxed/simple;
	bh=d3+dSVc+d1QajUTVYCFzTEXO5nx+Cf3F8uVePoP+3hM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WVTPPG0Uv+7p2wEzeMU5h0RQs2o7CBfheIMJq4x2k9r/ZDPZPSYzc9u4hjj7cowhQjt117GQWg79Z0KeY5nKyFiiWtBNb0OHTiq+YxRsUbpo2idZYLkqKJ20wD0XkklhmR6XgikWEc4/h1l0ZYThaIbHyXz7Jz5AzoqC9oZySyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NkCXs8g1; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=NDSx8l+A; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NkCXs8g1";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NDSx8l+A"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6886LqL72172782
	for <stable@vger.kernel.org>; Tue, 8 Sep 2026 08:00:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ftOcMLq3GmIjv/8ZjcZBuH0q4Y4m34ZtQA4zDPU13TA=; b=NkCXs8g1T6e/kcQ8
	3LCq7wK7GG90UQimigTvNwffh8vfCx9bH5IXT8VvYqBGWLlRhlp2uUQjPK0AZHEW
	6xicy/3Q2e2pj214fgikSy45UByEJg33BFmlgPBzjKlqX934DdDxkye/k9VAdNur
	GxDfq5I5gogRGvJ4Wi88bb/cldgCOemfnalTGKWjqwZnlyg9WGqCGQZnIR4IvffQ
	Ji9X8q4pMqGsyn9qQCvqMf+YI1KTySNeRBKrupw2kjyZU46sRizOV8ncNFHxqU+P
	/amaHRs/7z4d6ONFWV2OFz24PLKVJaJ+Gxd+SF+v674qfUAKN6WP9evKAYnu+ZFc
	CU/BLw==
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com [209.85.221.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gj1rrjcq7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 08 Sep 2026 08:00:42 +0000 (GMT)
Received: by mail-vk1-f199.google.com with SMTP id 71dfb90a1353d-5bfc08e95ebso100806e0c.1
        for <stable@vger.kernel.org>; Tue, 08 Sep 2026 01:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788854441; x=1789459241; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ftOcMLq3GmIjv/8ZjcZBuH0q4Y4m34ZtQA4zDPU13TA=;
        b=NDSx8l+AF70Tbh+RV/5hbGKfs+uHY61PUEWdGbvzhx+zlXW0BWYYD682bpwWXV+ii9
         AKhwg9dVY6qr5Lp9eE7pqer9enPlKWqG68Z2RteKgJkXPFOB4Wf5YJjmeXqMwEQzOmVe
         Ro8seiZFqymF3Gi8SJCSrX+uQy2WWom6t+Uw1/pOxlZLW5bq+fqP6w30UusBZZnIJ+fr
         9uuZM8SNgJ5nfPPpLObbQg7OZVCoeBg0H7jBbYBPjGs1I2cdS/4zvc8239PoypB7cRUj
         QgFjScFdyvUC1aBecG6LuOiCATJkqKqvE30CWKjfazALwhVfc2piAkQHQVm8KqlxbX1F
         tIwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788854441; x=1789459241;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ftOcMLq3GmIjv/8ZjcZBuH0q4Y4m34ZtQA4zDPU13TA=;
        b=mP9Mw4+WOCNYtm6ghgqPJHR9rZjJLu3JzHcHpYfwNoaSlE+ykpahLxZidQyoEs+Mx0
         kgTIdp2QREY28MsfOqgyq2sLPZQCDjexL8bnEUjkc74R1ri+QlVGxgCgMvg4lKu29jP1
         Ed1iHNmoH0VbMsTdSVXMobbvUvOQSrMzaxWBVKvn5D5TSwaeTgkgYHP5sOTzrr8DZsui
         Lnn5fxAQFI76e90FukfRY5MFbp/SSwJDzclRa7wLK6K6HvakvXTJ+F3t7QkLfF/lxLCF
         Dn+aVzutd1MR9jGuxOH9ze1/2yuAkAA6w3Qg05RQNKs0KZV2z2j0Z0UNlk8ZNw5FDxsu
         PlZA==
X-Forwarded-Encrypted: i=1; AKwUvBwLCiKqF57+70SDj42Axhyb5iffy4DxYboeqVZ5tkJn2Kzmcbqw70GFvfXu2QI2l9zI5gktipE=@vger.kernel.org
X-Gm-Message-State: AFuF++k0ga6jXnN1CaKZFE0H13RzjltcOHUdNiCsApqnv9f30NQl1LG9
	CatRKr/CokFJnm4KiEucpEeKSSqgVyYF3bQd9KmDjdlwNaZqBqyAi2MySYHVv6ZMOQe2JWmW47t
	flsG2VF7Kgws33sJ8+9VS1dLGqUR4jx5BXF0fsCFVfo8WoQ+nunAd2RvsxM8=
X-Gm-Gg: AYBFou1drsmJ7CEpmVgoKMUxXT5YTpfW0TTLKBziiFv6TBhr3pLArszo12tkq8IGaHu
	/KweDnezTDo83/hcS37wZJ62JmUW8GTL0y8J8xUFObHm+ir6YLTeJwKuoWYaotMP6vut25tyVzQ
	bzPbq4mSVmFVkEaoeOcdYvAFx3C3r+J2UqxoC2Y/+NVQi3xd5FusTkeUcp6WLdzZPtdG2kAyiSZ
	SDYDv81COqdcCZLX6dJcHzK3+D/XlvwybyEWO1L27LeyGPbB+IlEaKgUQ4703OKcyXgjCg0C7zE
	JaEAV9WrTdDFZwILFEnUGRzG6txYLwjyEh/+xlitwYlebBmAP6oZIr9FfTmGneF+3p9kPpdW9rQ
	j3E5BJVzwqFHbOFfeWmFiOw==
X-Received: by 2002:ac5:c88e:0:b0:5bd:9cbc:93c6 with SMTP id 71dfb90a1353d-5c7fb54d026mr2461865e0c.0.1788854441543;
        Tue, 08 Sep 2026 01:00:41 -0700 (PDT)
X-Received: by 2002:ac5:c88e:0:b0:5bd:9cbc:93c6 with SMTP id 71dfb90a1353d-5c7fb54d026mr2461861e0c.0.1788854441099;
        Tue, 08 Sep 2026 01:00:41 -0700 (PDT)
Received: from [192.168.202.12] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b61669ae43sm2831689e87.3.2026.09.08.01.00.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Sep 2026 01:00:40 -0700 (PDT)
Message-ID: <7faefff1-5aa4-4277-a250-add84a880a19@oss.qualcomm.com>
Date: Tue, 8 Sep 2026 10:00:37 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/7] drm/msm/hdmi_bridge: Correct poweroff/audio
 cleanup order in post_disable
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov
 <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Archit Taneja <architt@codeaurora.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, stable@vger.kernel.org
References: <20260908-drm-msm-hdmi-fixes-before-eliza-v3-0-dcf8956878ca@oss.qualcomm.com>
 <20260908-drm-msm-hdmi-fixes-before-eliza-v3-3-dcf8956878ca@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260908-drm-msm-hdmi-fixes-before-eliza-v3-3-dcf8956878ca@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA4MDA4MiBTYWx0ZWRfX3m/A23JuTI+E
 R4jQesX3cZrndSZeBfqr+Tzh3RD74QaSuPxEHFHa0YAllLdM04CcbVI+FjX4dXaC/f8Kw3kBRa3
 FnxLoresT0sIHNFyH1ctMsp1uvHDVL8=
X-Proofpoint-GUID: MSuiVAVzczA1rEYKWLPKtwDJ5t2Rh-Ey
X-Authority-Analysis: v=2.4 cv=NsjhtcdJ c=1 sm=1 tr=0 ts=6a9fc0aa cx=c_pps
 a=+D9SDfe9YZWTjADjLiQY5g==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=1VKk1TRdkn99K7eK9r0A:9 a=QEXdDO2ut3YA:10
 a=vmgOmaN-Xu0dpDh8OwbV:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA4MDA4MiBTYWx0ZWRfXy2RT/eCmt37w
 heJCQ2fD14jC4wX34PhX2bHZAupwf+kgmOJ8vsdZre2IMKb72xzGb+rBIgBRjCjoL3iCjPBek3H
 ApOEEF9l7D7VCs+zhfXD89qjy/DInTA0D7wgzKfQMzKJYDL9qFn52IOlbuY3UutQe/fxRtikW1N
 V0HoR2dbp5pusQj7hY15Tv5tP7szlFNbWy1YK7k6Ucm0nChAmt3rBWrgrRx1njwVmtqKnQZFgNz
 MqTkpiB4rUYmM+r39P/wWJ7gqpTqeThBshTAp7oxR5h2PMv4Tynnc79XX/5lwsmmZW22GUPbHYU
 Q048QmMVl0f9djpr+vh/ehRnte/H81pMKEGqFcMzMkv2S3A+L+ji+8IMT9zIubY8+WIO/UX73+N
 32glqY5RcPt/WMHZXWRmE9xl1AuNgLdbo50yV4wHkLG4NZXrfl0WCdUTXM8G5OsvQmHzJ5uPtKt
 Snu2Q7ZtOXZ9/WnY4Qg==
X-Proofpoint-ORIG-GUID: MSuiVAVzczA1rEYKWLPKtwDJ5t2Rh-Ey
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_01,2026-09-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 phishscore=0 suspectscore=0 clxscore=1015
 priorityscore=1501 spamscore=0 adultscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609080082

On 9/8/26 9:10 AM, Krzysztof Kozlowski wrote:
> Turning off the power in msm_hdmi_bridge_atomic_post_disable() should
> follow reverse order of powering up, not only because it is logical, but
> also because msm_hdmi_audio_update() accesses registers thus block
> should still be powered on.
> 
> Depending on specific timing, existing code could have accesses to MMIO
> of powered off block.
> 
> Cc: <stable@vger.kernel.org>
> Fixes: c0c0d9eeeb8d ("drm/msm: hdmi audio support")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
