Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D4513A59A2
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 08:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788854537; cv=none; b=X3eAyR6hItGgIPruM24D6vLr1qR6wmXdO6NURnNWRzHadPZUgXyU0tx7U4i45X3YL3rF0x+Lr479SQFGKjoHTo36AP/Xl7u8GDZbkjRErty6z2dnMGNXXB58jIbUIIz1z339cxFvZMIE/mCKolGoVVCBmYdTteaOFv+UCVkn0qM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788854537; c=relaxed/simple;
	bh=SBgXFYdNYEUPVWubdVb9unTaNhEgBh6xGV7DWi4TnQQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e+yi5w0VkiqeCafSqO++u0GmHCzV5uDOQKsXQclS1OUJ54nPve+YyksYt7y6+z6ADpPkOHj8c5meFB4q85DFNgN1tUZXAhTqpHb4WA66e5hqPcKFhUSccT38I9TNM9z/5Q8MTvNphYKBwcVmM5vZ1TR+w9tQYihDa+at8rjwOA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=arIuAESW; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ZXI7+1KO; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="arIuAESW";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZXI7+1KO"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6886LjEl2172630
	for <stable@vger.kernel.org>; Tue, 8 Sep 2026 08:02:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	WozNudziLKgBxiX08uWyerO5nuWlCikb2YN/NDCsgqM=; b=arIuAESWcUWwrGI2
	pjqkoOyJNILtKK2cq6jHIw1appcqCWGaIrfPiN9hHaHs8t++cmtKy3CztvswBNVD
	t/6GjjGovrE5VKW00dJhb7Di5oG4pOLrSRwr8G6SqWWHV1FuFCfZmy4YkB9ya1+K
	ocMxPyWERANVyf/04rKh2xg5jPmZiBXA5WaefWlk1WEX21EhXsYBQ3zNmjkhImXz
	/7lfYFr6uGGQjS4gm+sKQ6MLV5ExzzAtYG7G/n3z9v55eWrDxNxZ/2IDzXUQUCDa
	O6gJ401SKTb7APWF/bnEwrDYZif3Ao/9o7AHNWUmW0JvheanXxCTexjM44ZEqwbO
	cpWkFQ==
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com [209.85.217.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gj1rrjd00-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 08 Sep 2026 08:02:14 +0000 (GMT)
Received: by mail-vs1-f71.google.com with SMTP id ada2fe7eead31-783743bffb9so61254137.3
        for <stable@vger.kernel.org>; Tue, 08 Sep 2026 01:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788854534; x=1789459334; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WozNudziLKgBxiX08uWyerO5nuWlCikb2YN/NDCsgqM=;
        b=ZXI7+1KOnex1vLq3oiTv+pwnS1arKhYcdBlEO9ktZHE6iIo6tSvOMFLZeT8feAMV7Q
         0vHutoax6xqfJQ6zYPJNoHe5u0z73dpc5xuqLwqe3gnhA5PLoAcnBZbbCPlstNpuVuNG
         2x6nuk2CMwElwJ2LNcvnJKrWg3mBzorMexyOdP8UWYNqmU1zobZyOxDthjR2ZlPlmWFt
         yC8SUShCqI5IEbg49qKmPa+7/H11ukYUWkrHGd0rDTqtR+fjUnE1DGiN1Cet8MkvRHjV
         0r3MGQuX5OftvJfyQtBHg+kCWKc9bDn+t+Z6Cpcc699pP71BqpI1rhepjSSBTyuoub36
         lPzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788854534; x=1789459334;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WozNudziLKgBxiX08uWyerO5nuWlCikb2YN/NDCsgqM=;
        b=bBGe7fZj0hucO7eZvqfJ0HorCD+WNKpMvwbBi73Qd41Gmn6jz6Uqx78d/4fZenpprW
         juGhOVIaCqCvUbo08ReyK5JpWMUWaoYnFuQ8+dqjC6inhYO7gR+YQg/nXoOGPzwDOOJm
         bn4CuMFIUkpqlNoq/2tqc7vxhySSjBQhOCRkeMajw+ygPiU4v7lYv2yg75SonwgK1Par
         qBl77MHMS2JXF92C5I8WFdB8QiJ/Vz0+ulFAhAdAYuGXQntUw3+hh8DOlcVKLhvI5LMM
         LHQZcqsyqpoT740/Z2PwnrjqQZnkyxQ4mydHWq5asRQnPeoQWH2pbilhHzDtRWHj/eVZ
         58Qg==
X-Forwarded-Encrypted: i=1; AKwUvBzuisj0qAwv+gIyAAti+EePfRrE15ke8dfPf//cNfPMquaubNrZPIQtpuvnl4FyyvUuPf+tt1M=@vger.kernel.org
X-Gm-Message-State: AFuF++kNnBVWlGMkcpe62mb+yfbvMoAYbBoP08JCGhq0t9Gwuu0Lwmxj
	yonBO/XXv4UlsW8emsj5fq6a7BQcGvZCJq+xtnigz7BZ8v8g5kbF1d9Ezd8ZMtumAix3tac9HHj
	VkkIUtNWrQWXJvnL6xaAybTi8wFgUi4twYwxO5q3qnl7yjK46/Zn2lNsn4cY=
X-Gm-Gg: AYBFou1zRamiPPF4nZBUtM+70fbh+Fo/qAGicEEtZc1/1Aw+p+LL8XvFpXgvNnETSuG
	r3cFMkRz3Lk22MToG9LTstiy1yasTPAdU9/l3CV4x58AkGKkoYepDMciri8hvEllQaynoq9DG9b
	BO8R6SiPlyBw/LXcJcjIQCVmxA5e6O6TTSR8vc0wDKp1+85d3aZYMCWoBCvBJEi5FW2AG+T2PQ9
	tozY1tlhiIzblM72ZIRGU1Yn108fX9Kc/UQqVXslidgJmoTDuRkUaEYchiG4Phd8wakTLwNQXD6
	rCKPLE6GLZYPhQmLAlF5N1nrUG0ZV4Psf7xNgEmK/9P463857zQKC6+f/WLuRbOZzGuAYWa9gsP
	qh0Miexj972WDngXxswa1fg==
X-Received: by 2002:a05:6102:b03:b0:781:9922:78f3 with SMTP id ada2fe7eead31-78a60e5b62amr2664046137.2.1788854533919;
        Tue, 08 Sep 2026 01:02:13 -0700 (PDT)
X-Received: by 2002:a05:6102:b03:b0:781:9922:78f3 with SMTP id ada2fe7eead31-78a60e5b62amr2664022137.2.1788854533373;
        Tue, 08 Sep 2026 01:02:13 -0700 (PDT)
Received: from [192.168.202.12] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c260d559364sm565451966b.35.2026.09.08.01.02.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Sep 2026 01:02:12 -0700 (PDT)
Message-ID: <06bb2b19-bdb0-4dcc-a6e2-6805edd9084e@oss.qualcomm.com>
Date: Tue, 8 Sep 2026 10:02:09 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/7] drm/msm/hdmi_phy: Cleanup after
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
References: <20260908-drm-msm-hdmi-fixes-before-eliza-v3-0-dcf8956878ca@oss.qualcomm.com>
 <20260908-drm-msm-hdmi-fixes-before-eliza-v3-1-dcf8956878ca@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260908-drm-msm-hdmi-fixes-before-eliza-v3-1-dcf8956878ca@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA4MDA4MiBTYWx0ZWRfX4y4tPKPDhi9D
 +a1d7Rxj+hHF6KTzLM7Qc9NJUkPZtirDkuYMpuBDdb2e3RfF8YhnL3TrJ2ScXNmYH3A+icRrVAx
 vsyg/aAvzU7TXXupunEbwNH4rBxwHAI=
X-Proofpoint-GUID: 0unZheoD3SFglYEUbAw_aNDvktaxQuoP
X-Authority-Analysis: v=2.4 cv=NsjhtcdJ c=1 sm=1 tr=0 ts=6a9fc106 cx=c_pps
 a=P2rfLEam3zuxRRdjJWA2cw==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=dCp4QOuT8fr3gmi_UlEA:9 a=QEXdDO2ut3YA:10
 a=ODZdjJIeia2B_SHc_B0f:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA4MDA4MiBTYWx0ZWRfXwWa8K4J6APBG
 6RapRSdw+35X0h9P2iJikoy5U8qQmTwGqR0DRHIJvbXGnhb2EMWDHkSddXAE0Zo8QF2CcHGISHB
 eDl/ezGEhQd800FbNpn1zSP51UqB1/9dyIUU2F/sA3JUFw0Dtmfa71NHIB2g3c9UvHtJxkYZMtU
 GxWgazpuFt5AfRVsCxkZJkMekLakS/PFBxZX7P5jRNEAgVzaP/Ym147ahWWZZmlK8aaYHGdwHCf
 wZErAohgTky4LQ0LRJd81CNy599tYVhZQT0D24NA9HRCaBlE6g5Zk6cbaj3XMmQaPnlGnAgSydc
 nSirPGjuJw7KQJjQMlmwvhbXdYFb6aekN87IyYdJPvSqGknvW6Mxorj0LzpB5Cllz089ZsZSMVG
 CImyILHVtXCpDwOoj43LqWoeZl/KcyrezWyz2z3hgqdvjIK4ky7fSeUsDFPIOI4Vh71m+3+wzti
 3ggK9OjfGwt6Gow9upg==
X-Proofpoint-ORIG-GUID: 0unZheoD3SFglYEUbAw_aNDvktaxQuoP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_01,2026-09-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 phishscore=0 suspectscore=0 clxscore=1015
 priorityscore=1501 spamscore=0 adultscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609080082

On 9/8/26 9:10 AM, Krzysztof Kozlowski wrote:
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
>  drivers/gpu/drm/msm/hdmi/hdmi_phy.c | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/hdmi/hdmi_phy.c b/drivers/gpu/drm/msm/hdmi/hdmi_phy.c
> index eb1088755cb3..15e37596bdb1 100644
> --- a/drivers/gpu/drm/msm/hdmi/hdmi_phy.c
> +++ b/drivers/gpu/drm/msm/hdmi/hdmi_phy.c
> @@ -67,16 +67,28 @@ int msm_hdmi_phy_resource_enable(struct hdmi_phy *phy)
>  	ret = regulator_bulk_enable(cfg->num_regs, phy->regs);
>  	if (ret) {
>  		DRM_DEV_ERROR(dev, "failed to enable regulators: (%d)\n", ret);
> -		return ret;
> +		goto err_pm_put;

If you're a fan, there's PM_RUNTIME_ACQUIRE_xxx in cleanup.h

Konrad
