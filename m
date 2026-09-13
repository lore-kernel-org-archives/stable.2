Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 104F838F24D
	for <stable@vger.kernel.org>; Sun, 13 Sep 2026 10:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789295543; cv=none; b=qcVZ4WGweF+KoC+PU2sQdUutvh0+JffWLLlXZ00Peq1w/loKPx5wwUhbL0LvzPqNh6kXjviY/hKc29JmtW7O+UlM6V615DNiNQSVEbhG8Ed3RrTQbv6GV+ZA3T/7JPflcak7O4OiZTRMuSNtrfg5IDJOqDB7wLxckmK8O9rh4JE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789295543; c=relaxed/simple;
	bh=tHosPNT4fdBSE5OakR+2naVgGAE2PYaT5qCsKmvw6UQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WfhnoUGX61y3THRihRaDc+cuTbOMwTh/6/Femty66u1jAT/A1jN4EXPBhdXuzpTmrheBs6GeuQFYS4PbIGifkvQxn2b95XAq+90JoCEILqC8JVNc9Gx/S0teURw2J/eyB6df6VJ6wxCPlxClBziLb4ArwAJhA7o6hN72/WAO9L8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DjlRF3a0; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=EE6g63V/; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DjlRF3a0";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="EE6g63V/"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68DATwDB1004547
	for <stable@vger.kernel.org>; Sun, 13 Sep 2026 10:32:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	D5vAKqT6Wkkpii4lrLSYCVCPovwE6ZV45z1ikvs4rFc=; b=DjlRF3a0oH/oZqUd
	sXxPdDvrvayU7rLuv9n8W/fBt75uI7MZorhxobwtNTwZWUAIPTgbNAglaqHNu/gY
	3itqSnnWoT8RFzuVwXzI+hCjHP3RfkapSK0/OMJjKinAwTLfGvQSjOS2Gwi2VJSk
	9CcACRh1f6M8lKy+dZWH/cqFVftH8bn1wemff/+xWwwNkqfVDrMMVS3vl70D9+Cl
	WpH5Bt/crC51uIfpOuza9LoUoNOXzlZS+jandBp025RgHNSMrm+Zbdcl2Qpw451w
	V46vo4N3pJQhwI87KuWX8ZmnlMN9fXEZGoZvmwArpEQVQn5uWYBFBUHNNZ4nB7Cd
	XwL8Ng==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gmygd33b3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Sun, 13 Sep 2026 10:32:16 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-934963b2bc0so480628585a.3
        for <stable@vger.kernel.org>; Sun, 13 Sep 2026 03:32:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789295535; x=1789900335; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=D5vAKqT6Wkkpii4lrLSYCVCPovwE6ZV45z1ikvs4rFc=;
        b=EE6g63V/oCfdS3fm4BqY/S6LqrszbwJJzqi10bheGoe0dv0o4IX2otmqNX4+e4XG0P
         LHU8FdkNAID70rCHvkgNhPQtlVu/LJ1ym7GrO22p2gfzX0KGiZIj9z7+1SaDG1WScut4
         ievrHQmeC85z30AK7D0PHUdBsSV0xyOIqTH164BkIF1hdqsQCYP4ey5SBZGrTxBIbVUc
         nEIWptZwC6K51R0JQCZK7aZd302a62+t5BnGA5Wc6hXnipfddeAreqxhkDAGMkkH9BgL
         4soHBUovcqjD1b99cr+ozoEPzUEMaodTobMpgeHqi20AgtI8NWmeu/GfVHZGk3rLktm3
         UczQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789295535; x=1789900335;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=D5vAKqT6Wkkpii4lrLSYCVCPovwE6ZV45z1ikvs4rFc=;
        b=XkZ6Ssl4yWY/K4GLmTzdXrGiDCTtCf8D3UQdHEH5EdYFJ+3ZC2G9Q4mu2762RGDT0S
         n5TlXuB1JEJBaJYdyx8BnrsZ5aYfocTDrBbWo/R9IyPhRqB2GQycDZqCl8UPNtjZD1oW
         uJLRQWNTZUEcSv1GH6EVzz2/UjLZvgkB55FpfnCsbXuqWsh+n4lY1lm7uCY4QH5TbYL1
         QSmEYgf5EwFxzBNoMPv/OZt0v1z5LvqtRMoGs26mjXtfuAWEFdCc56aACvOiy5ekIkyI
         4cDl1b7tpKbFkeANOaJ9sDiSRHHfxHzo9Wmy4KYfFxuaX5gkWVbzERpd8OsSxqkfaf38
         f/IQ==
X-Gm-Message-State: AFuF++n3kQrLlXGwfKLltvSKbDh1y0q9xJWUAg/vbiMo8xhnBvf/IKAy
	qoQihj2H1JmIku6mUHzhG6HW+nAS7QHPE9ZeKjvpi0nS5rV47ZnD0LdFMV3k3fmCF9vqRV0wKNy
	sdrVCY21Mcn1wdUur0irCmB72YeCXpZzmtR0g1wiPQ4+KWLceyUcZ/7cEpHw=
X-Gm-Gg: AYBFou3a82lb4WFGzHmIEaisrPHDbucqh+1B3e8dCqRSj8NKdmR3Bv7F0KdIYeXXkQr
	+i8cWBWBHeIX2eQhmssgSxwKWrDseSMwPB8qWtRFtr5/J6h+Xnwndy4gmNbvqjvTIpBaz6D7Tmt
	iv6cf7KYiFXFSJCdTKVK6c2cMh1Hp5C+jozxzVTM1sqgEjNm6Kb6RH7BzgYuweBmxNTJNv+qXiC
	AComHUCYJfcnc1AfuleOmLhAvd7ZBxc3V1Su5Udd3SlxBUBf0SNCsuK2a4vtnGFE36hzhxW0g64
	S1jw5lOgcvD8WiB7MiTTol++nsZUAZbaguP10AZ/U/gPmwzFwTikRRv/nlcEYS3UWk4rvCd3xwr
	i/thj37HkrBkygWN3Y1NGXxC9y29w
X-Received: by 2002:a05:620a:4409:b0:939:5f4d:67b0 with SMTP id af79cd13be357-939ea037da2mr1792432085a.8.1789295535244;
        Sun, 13 Sep 2026 03:32:15 -0700 (PDT)
X-Received: by 2002:a05:620a:4409:b0:939:5f4d:67b0 with SMTP id af79cd13be357-939ea037da2mr1792428585a.8.1789295534807;
        Sun, 13 Sep 2026 03:32:14 -0700 (PDT)
Received: from [192.168.1.110] ([178.197.219.214])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49d26c2985dsm519682395e9.6.2026.09.13.03.32.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 13 Sep 2026 03:32:13 -0700 (PDT)
Message-ID: <c478a074-f0b7-4eee-8cea-5f926b6044df@oss.qualcomm.com>
Date: Sun, 13 Sep 2026 12:32:11 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/msm/hdmi_phy: fix runtime PM cleanup on probe failure
To: Guangshuo Li <lgs201920130244@gmail.com>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov
 <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Archit Taneja <architt@codeaurora.org>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
References: <20260913085814.1509352-1-lgs201920130244@gmail.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260913085814.1509352-1-lgs201920130244@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=RY0FmFtv c=1 sm=1 tr=0 ts=6aa67bb0 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=+bKQE0WJfmhK2875HamI0Q==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=eqkjudQgZ73XcBGNVqcA:9
 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTEzMDE0OCBTYWx0ZWRfXz+tdVWCaFL7O
 SeMAkR/xqaL+Ge5XX+tlPfRnVuldU8/H2xbPkxC1rB7isPyTFpD/SK/ajuJRHeY2CXZvgcPBl6s
 0gTVnuiISC2yYtgHWhbusUuLC/+SQjv6u0Zi6cE9DPp7FqRcxmQ1s8UniPhmqHYtDtxztlSzbMf
 nEGak0bmPfStNqfTMF5ajm1pGydMre2y488VpT0OWmNuDdnkMl+Pkp2NClp+rxiDgp2wel8suim
 vqQrw7QhoofdCsWAnog+w8WimiGXxymuheQNnSaI5UFXQrlfpVqRL4szjQouBn49C9B9oLJTzYq
 TFDpFkBHDvj1hsQK5UFMWSX+gthKoqv5q8z/gmJ7DUxNJbBtYgxaktYDj1YgLDkyn9eOUONuwvm
 kzYmXJgKfR6EusnEfLXciIqV9dALMGdIl2gisEhzkEmfqbuF5wnWMA+aCd84sKTffKhniiq4M2h
 Bvt83G+WGlE+hYFDX8g==
X-Proofpoint-ORIG-GUID: 6Cl8oVdkKkZGmRMZ32cfrXQCs-t-juvw
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTEzMDE0OCBTYWx0ZWRfX7L5rPWqzDPR3
 ysfKVsnLhFHNwrPeBZE9FAzeHsKLoq94R0is7IA0wWY+rbRhCTIKGYN7rjjbEgkEUSzCZ3yL49R
 WI8NKSzvztT31e2U0dIB/ByAmAR0Qbk=
X-Proofpoint-GUID: 6Cl8oVdkKkZGmRMZ32cfrXQCs-t-juvw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-13_04,2026-09-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 spamscore=0 suspectscore=0
 lowpriorityscore=0 impostorscore=0 phishscore=0 malwarescore=0 bulkscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609130148

On 13/09/2026 10:58, Guangshuo Li wrote:
> msm_hdmi_phy_probe() enables runtime PM before enabling the PHY
> resources and initializing the PLL, but failures from either operation
> return without calling the matching pm_runtime_disable().
> 
> The remove path disables runtime PM, but it is not called when probe
> fails. As a result, runtime PM remains enabled after an unsuccessful
> probe.
> 
> Route failures after pm_runtime_enable() through a common error path
> and disable runtime PM before returning.
> 
> This issue was found by manual code inspection.
> 
> Fixes: 15b4a4523859 ("drm/msm/hdmi: Create a separate HDMI PHY driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> ---
>  drivers/gpu/drm/msm/hdmi/hdmi_phy.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof
