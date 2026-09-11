Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3F0549B200
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 15:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789141684; cv=none; b=sFm/p5shB7IfpnhiKBPmEbZ71cLyogSeHo1rdC8tMSK+5eY1bVxlu9gYOvXDX1xy1toW05t19cnevGjdC/nixna0A9YDgECW70hcy61Q1gh/ELGIcwZscuDIq1DjM1uU85z1SB6u0cisAOaVshY4F+TdI/kCVgTwzYUpamUaDmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789141684; c=relaxed/simple;
	bh=Gf1Q0sTU/UBy5u52sv5kJvv2O4ZJCxnZRcFqED9rhiY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gJ45/4YBF00LDBAAzFMhZ+EJl14WQd4lzYDqJRMoRoC+LARMO7dxtTqjw82kf62yJKnXDoT+6I/dDq2SMxNwx//4gIg9HVbqUHiY8XBkAyI2XICkROtb0aJkB7kpu1EgzdY3fqFhDo0jE5NC+tSg6d69E4fxyqxjIhbhTAwMwWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NCpPo+MJ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=cBIf8h8d; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NCpPo+MJ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="cBIf8h8d"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68BF91bW170844
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 15:48:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	UfwvCJZ18lp93+WPqAxfERzMxNsd00Xm06mrFwnyhZs=; b=NCpPo+MJDgFf29jc
	jKcs3c7NPOXvzixt1cRi/VTasJ3xtoZZbYy/22fn4N0GiRKcaW4/kTtajBvta1fj
	bzGVpSwg+dCjMrhUn19SM14/L83MLfmuDpmVJfw6MkLo8drwuJhVNXJKWhfN69b+
	D9b+AC2fUKo3J6J0mcgSfZL+YUvCoU3gC5WvYzJ0px7mTqh2mm80dxAxLWCFuTte
	+diXadbQUlcpQT3bxwfD/8+eEkbtFzABNB9Cw8b20Uinr+6S7arO+KVENv8659GD
	wRaU8ubXpBt9cFkrKoFKZ4VbhxPW06t254skdkxJy9FEkGUIQ6y20sbN83qFAM18
	ol9atg==
Received: from mail-vk1-f200.google.com (mail-vk1-f200.google.com [209.85.221.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gmm1e85cj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 15:48:00 +0000 (GMT)
Received: by mail-vk1-f200.google.com with SMTP id 71dfb90a1353d-5c82f9e26ebso36307e0c.1
        for <stable@vger.kernel.org>; Fri, 11 Sep 2026 08:48:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789141680; x=1789746480; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UfwvCJZ18lp93+WPqAxfERzMxNsd00Xm06mrFwnyhZs=;
        b=cBIf8h8dFTycAWsYO3LpCfAChfRgFAR8KoBqSYc5bDInilr48ND/AHtHziQCeihboU
         czGHIW3qT9spUfd70c5p4veNDDjqw8Hq/Zr9IA61tcUMGE6VPkS82IfkBRlQ2WC9zhf2
         scdty1mFsNouD80HNmncSG7S5HngMKpXc0/Q15TMD80QqHhoQYob6VYEEpsdhIrmPWmO
         Xm8iLK0XxZVPS5xJnXmB7SdRjm0NClG147X25MjxA7NLEcL4lfTU/hEIsMOWfgTv/9/u
         K6+DUo8o12eR53rewtErUGloP4LQdo9FpHTdEXxwBr9uOZ+wAs1KiZzY8oecxUxKqYk4
         a5DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789141680; x=1789746480;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UfwvCJZ18lp93+WPqAxfERzMxNsd00Xm06mrFwnyhZs=;
        b=LS9tAPgo9kiho+Mb+Vr+1RLIe02fPNQCJJeSzgnrk8mDpcIICIfBB2B9bDzEYip5/D
         lb9GtvjFarnezSL6tu4oZb6jPzTnh2wZLZdC2M9JRXAv2VL7vnkDXKlWyPq/ki8PMerh
         H1oH2dUheZzs1IVE32KtICT0VDPy646D/hgRIVZxneCc30GzAPr7XMUUb1gWqTqqGi0D
         v9yb2cw7Vj3MSnf5ZK/8Z8BmKwtD1rqUCcGokTKJ7eKxpQc6xuWt5L4AUOv98xME3Y1p
         eAONFuhelsyajwTwLIKNdHbPzcZigmLDaGjhgQCXBnfXzJ1+EMLX1raqXiC0inW5dH2G
         5vXg==
X-Forwarded-Encrypted: i=1; AKwUvBzGlCVeZX/L9L2c0IJlFKIQcI+mIy/tw6ricz92IbwYAZmG55DvLHdGfGwkLzVdyjA6NMffCOQ=@vger.kernel.org
X-Gm-Message-State: AFuF++m4mX+HuTVBggspNdMdwHjrtO3BvEDicNP1Rrq/hEiObdWJj9mH
	k06vGxuEA7FzV3SNMEpQmuWzYN0nsL+lIUfgMfdAz18uH69fUjMCiS3tOZH0cg73kYEgJ5C1whP
	qVlbldmzQSt9NZyPLJ229f/0dPhZxa4Zv5aMjBIInIuzU2wtN7bT0hUocMAY=
X-Gm-Gg: AYBFou01Z8AGBfhkPLbblA7FrkpHiQMXp0BE/yzp2Uq02tMGVV3pOTx9e5BZKmGJWsI
	bqqGrzfU0LsT6w7qCwnmS4/gjwwTEbcLTeyn1doUHbwWm3hLo2VaE+xA9khIPi/K0+VyxMjgemO
	rX9Gw9BASeTjzDVqLAZdCAuv6TcEkXmYkPB8ztl7AAngBaDJLoLRqx6G6kMlIoF9yILKdqXB+zb
	s0E2HdzHmO+a1+YOmuQKuGl/0y6Zj20A9kJ0x9yLj03/lbhrR04NZ8C9eEIgFArA5kvAtq1c4J7
	lKyna7n7xFDGPsCJie6xb3gfysxYMQGUcCGRkYVY7tYIgeGM2L4llF8S7oPTTm4LCcp15Bk2U0W
	H2qiajmOaoyJuvw+spaEWLA==
X-Received: by 2002:a05:6122:4a1b:10b0:5c3:a1f5:7569 with SMTP id 71dfb90a1353d-5c8460814acmr1633997e0c.1.1789141680157;
        Fri, 11 Sep 2026 08:48:00 -0700 (PDT)
X-Received: by 2002:a05:6122:4a1b:10b0:5c3:a1f5:7569 with SMTP id 71dfb90a1353d-5c8460814acmr1633976e0c.1.1789141679590;
        Fri, 11 Sep 2026 08:47:59 -0700 (PDT)
Received: from [192.168.202.12] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b8a047fd69sm716054e87.83.2026.09.11.08.47.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Sep 2026 08:47:58 -0700 (PDT)
Message-ID: <5ab7084b-1bbf-4e1d-a8b6-fa29dd9ba5ea@oss.qualcomm.com>
Date: Fri, 11 Sep 2026 17:47:55 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/7] drm/msm/hdmi_phy: Cleanup after
 msm_hdmi_phy_resource_enable() failure
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
References: <20260911-drm-msm-hdmi-fixes-before-eliza-v4-0-87bdb9f1987f@oss.qualcomm.com>
 <20260911-drm-msm-hdmi-fixes-before-eliza-v4-1-87bdb9f1987f@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260911-drm-msm-hdmi-fixes-before-eliza-v4-1-87bdb9f1987f@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTExMDIyMCBTYWx0ZWRfX94tjIfUXqOy3
 YYK2iRy6J2MQcw4Fvyy8LssuQbOkhfH9Z3YuSmM5QhMtJp/T3+NhwENrgR9S60iGqZcwjUxqyY5
 pnYUUy/O7UYlaPbldgCeBF5m3hEhiipaE4IO/Ab23K/i60eeBAVLdwqU7J3BjULK/4fevcHk9qX
 EEeCz6BrXxFWY7DWIRg28rTzSYNnyaVl4DCaPHd9SKNkYngwOrsxnyNhcFzseNHUDPjZ62lovob
 orrMLxCLM7faUD6Lt+Is452ategfUNN+JcmkC7s1FojlfrnFvhjVnjDHJDTv+hvczwCLP1zMdec
 XhboLlOmsYjSrjcAGYgI1k93Vx7lHvJJj98YxpcipTvhguiL95sU+6XbJs5O+nu6SlQPC0+sl4j
 wMZFcQdR8ykNTUeabGYH0xt3PHYtF/qOJ8FVrMUAm2sb5hq2MZ0tAB6M+Znlf1n9qZxf1KIMaFZ
 OlGdH7sd0i8G6/pXdRA==
X-Proofpoint-ORIG-GUID: KwHSAFjXvzCqwlNpD3xCh7OwQv1PFyu8
X-Proofpoint-GUID: KwHSAFjXvzCqwlNpD3xCh7OwQv1PFyu8
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTExMDIyMCBTYWx0ZWRfX1d54+NY6E/8Q
 SRP6pfkEiptsSwCvwR30YtH+m8foW15vxpa4DWNqCxjMNmZcFnAI7kLq9tDBH2xwLkPTOFwBD0Z
 tBgHNLQjjuH2o6u2Xwk85EwsvLRkybY=
X-Authority-Analysis: v=2.4 cv=LrwHWXdc c=1 sm=1 tr=0 ts=6aa422b0 cx=c_pps
 a=wuOIiItHwq1biOnFUQQHKA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=5N7f0bWkOQp0pCbeU4sA:9 a=QEXdDO2ut3YA:10
 a=XD7yVLdPMpWraOa8Un9W:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-11_05,2026-09-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 adultscore=0 impostorscore=0 bulkscore=0
 lowpriorityscore=0 suspectscore=0 priorityscore=1501 clxscore=1015
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609110220

On 9/11/26 12:29 PM, Krzysztof Kozlowski wrote:
> If msm_hdmi_phy_resource_enable() fails, e.g. when enabling regulators,
> it should reverse the state of things already changed.
> msm_hdmi_phy_resource_enable() is used also in probe path, thus such
> failure, which could be simple deferred probe, would leave these
> resources permanently enabled for the rest of the runtime.
> 
> Cc: <stable@vger.kernel.org>
> Fixes: 15b4a4523859 ("drm/msm/hdmi: Create a separate HDMI PHY driver")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> ---

[...]

> +err_clk_unprepare:
> +	for (; i > 0; i--)
> +		clk_disable_unprepare(phy->clks[i - 1]);
> +	regulator_bulk_disable(cfg->num_regs, phy->regs);
> +
> +err_pm_put:
> +	pm_runtime_put_sync(dev);

This can apparently fail too.. one more argument for PM_RUNTIME_ACQUIRE_xxx

Konrad
