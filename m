Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A100F389460
	for <stable@vger.kernel.org>; Sun, 13 Sep 2026 22:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789339692; cv=none; b=XhLjPvrku7t5ejWdy0zy+emuZz+/2DYhFU2RsWNr7gmtowarXIJZdCyoXrFuHWDQS6ESCI4bWKdgP8QnNXrbBX0bmr5QnHkEaRo/fwBRkQ5hylinL7S/xHJQ0Zfffb1fbTM/V9UYHQZuAITYYWHlDeSwpBq2bNMTNpJdMK+5fUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789339692; c=relaxed/simple;
	bh=58OgDlTMM2M00oxH9nm1BTrz7jrOAurzgvEz8WXteGk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tdDgMKb1HHq1p0CMTXOCQf8rK23On4cDCPyapVV2XzbZLWKP8GVZzAxK3e3yG04k4iNq85/C0der/WtIw61seraU4KVJy9B9O5F+2FadyeslB+uBYU9l9TYbMcNHh5fQGOQNYNPXudsy8O2sbXGsTgIPVdilmvlzcG6IqfyNK2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Lz5rRZ5D; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=MzYtkcAU; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Lz5rRZ5D";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MzYtkcAU"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68DK03c73217860
	for <stable@vger.kernel.org>; Sun, 13 Sep 2026 22:48:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=UClHT6BNKVMxCVVP0I8xuLd0
	OwsPHW+1D4sWw1kmvxQ=; b=Lz5rRZ5Dd5AzE7gS0Jn9i3iiurCBGSRCfwyVxN/g
	CxZYWhCMqwH3WEWRWsr/9uW+6pJ9MwFZb3iRAQSKiIuNnIE2VAjRUWM8Q0M3vv0J
	UgBygzx9XcUaRiUNUBjGhevVG1QjUP+0p4TC63tUSLCDFELTIKRf7KBiSHqA6Y/e
	YTrL2kETJ49NWMqTzuj8+wU066KHimFTtfGPlxt9pSj3RezT+r7IsawXHoXr79H1
	LRcSmuTCSqQIAuB7ZRdLuov64jdsrXKEZpiU0dly+V87iBqXPFztBBgi+zOkQIur
	CD80ex1IaAos6ScioZ40A4Aqwi9A6gTUs2V7XXEzx50GUg==
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com [209.85.221.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gmy9dm9rk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Sun, 13 Sep 2026 22:48:09 +0000 (GMT)
Received: by mail-vk1-f198.google.com with SMTP id 71dfb90a1353d-5c82b120e93so624875e0c.3
        for <stable@vger.kernel.org>; Sun, 13 Sep 2026 15:48:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789339689; x=1789944489; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=UClHT6BNKVMxCVVP0I8xuLd0OwsPHW+1D4sWw1kmvxQ=;
        b=MzYtkcAUDHxaj1finVz9ID7OJMqNTpnstWER0Sc2l8hNkjQoRPliMCAHssoTZf62En
         1cjglcgw9/9x7KA69Nzbv4PZ7sU5YoOgLMu40Lb2ri6jjLkFpKNnIjLv7D2HKi6oeQGI
         v+VtSGIxV8WkxBZB5j5ahXa8LCn2SilccywlBSQMc6YtR8EAKJzp/pmeEYjG4HWHzxfP
         jRZfr0MJBFhILto2JZfS+jxmnYF5uPhIFL3Ag8wT1I1Kfyx5nsI5M7+yixeKPTwDk/fq
         i7Y+ufGU1NFLNZj3HJINqOdb/glTTGlfUZU/wHncqwzXo9nfE+unCv9sE/y7YZmosgE8
         GwSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789339689; x=1789944489;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UClHT6BNKVMxCVVP0I8xuLd0OwsPHW+1D4sWw1kmvxQ=;
        b=MLjutQXHsRJyJF2itRoWf5HJ/VXUTEgrNMZ8eHe0tn3W8ZtwzYaH2I3Yg9H7JbVFrd
         4l55GzYX4xfgX69XPng+fssaGpBVcp+u69U0nBThGqhubdhK4xrKmn46amsTqs2qCqS+
         AygRf5ItN2zZCGD9POKZX/wVdU7HqYFqN95PSG681OAerCjRAkM5G7n+HMDtqePVR8vC
         HT3a8QICIk3Ez9tR5rHjuUvmkRcir3VUdkRbRE5MHJvpp5on+VVjmqWKlnDRsT0/do5O
         Z/Pn7g/xxk/BFdtkNNwqn9B0jiJo9SWXgLv3C6AKpkXTBtlfTkXvloUJ+M7sx5Ujti3M
         pSRw==
X-Forwarded-Encrypted: i=1; AKwUvBx/dpE3CkqyAIsbNe8Duv7DiR8zpvfZyH61yDQ3T4X7x0hLo3Y4mJJAHoZ3up/JgqSB+PXl6qs=@vger.kernel.org
X-Gm-Message-State: AFuF++n/YvlOa+a/IVAppigf2P7ai09A8m74Zyj+JqkWS26G4ijXqKmb
	/90XbT4Xx6bqpyniy6VXz6AF2q3507wSsGVkOxdvHBGmARk+B8L3AksxTApP8DSVQpqWs5Te0YG
	A3GGCW62FFhA9QWa+nyWJJhnohtIiLTXbLY6WNw9OIDtRfy7A/Lguv0QqDXI=
X-Gm-Gg: AYBFou1dWO19faHL4znTRO/DGgv1ps0n+rCXVd/TWNpqK8n5GvQx9H/2OsbIEbgZeYi
	pKbTa9EPOwnXevWHRuhczGJBhplQcgazSnmh/gvp0iwyq2mbxE3o8mHLGdDBy7WTmLJkSU0n1y6
	22ppRvA77Io8fptHeD5AonN2FT4zZq6bEyY4pFzov8OebG0xpcY8kP0fVZ/PzILvsLPuRCD7ZhV
	bYIBOT8ej5h/J+WncLIyc3Wc7zkX9NKWJZXGPYg8N6+OIsx+wTgIoaChd4VdXpIBlRjKXL/nHoY
	0hCWHBtqVwaGyt86MU/EkSR0XqaJJXvHIZLjkugXSLm1L5gbnGpXxbNFuBhaVK0vXagbgiukRbR
	7Ogsg/uY/WivW2zE4BgfnlX05puCxO42GAnSA36r6qwy8KKNm6nhwhDlFfMT8jQ7TGPUTArHP6Y
	F/qJ4Ve5nSF1b+
X-Received: by 2002:a05:6102:554a:b0:784:d83f:2a59 with SMTP id ada2fe7eead31-795aad394c0mr5074050137.9.1789339688791;
        Sun, 13 Sep 2026 15:48:08 -0700 (PDT)
X-Received: by 2002:a05:6102:554a:b0:784:d83f:2a59 with SMTP id ada2fe7eead31-795aad394c0mr5074036137.9.1789339688314;
        Sun, 13 Sep 2026 15:48:08 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3a5a3144a4esm22118731fa.0.2026.09.13.15.48.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Sep 2026 15:48:07 -0700 (PDT)
Date: Mon, 14 Sep 2026 01:48:05 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Guangshuo Li <lgs201920130244@gmail.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        Archit Taneja <architt@codeaurora.org>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] drm/msm/hdmi_phy: fix runtime PM cleanup on probe failure
Message-ID: <rwzplkleui7i334kfsaort2iqgqwvg6pesk7xm3v272zupgmae@7whuqr2rk7if>
References: <20260913085814.1509352-1-lgs201920130244@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260913085814.1509352-1-lgs201920130244@gmail.com>
X-Proofpoint-GUID: jgMBBBvgrjeDcow6gPWRyJtNS4ZkePHU
X-Proofpoint-ORIG-GUID: jgMBBBvgrjeDcow6gPWRyJtNS4ZkePHU
X-Authority-Analysis: v=2.4 cv=NelzRGD4 c=1 sm=1 tr=0 ts=6aa72829 cx=c_pps
 a=1Os3MKEOqt8YzSjcPV0cFA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=VwQbUJbxAAAA:8
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=eqkjudQgZ73XcBGNVqcA:9 a=CjuIK1q_8ugA:10
 a=hhpmQAJR8DioWGSBphRh:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTEzMDMyNiBTYWx0ZWRfX1U83Q8XKWXJs
 6NhgNYS9e3iIBOYVGM9H3e8X9BBlz1a7JUfH2DAUwMvO1R43mb8hQAaSGE6zKmQ117sL6GHYDzJ
 QYsmY9WCTZOw9MzU2swfLbon3tKA9Zc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTEzMDMyNiBTYWx0ZWRfX4L9Q0FtEDZo4
 VfB7gpkXr/qYT64sscdwRhk5KsKttWGy7pIRex52rYcAC8w0cU9S3fLfHJKL43/+v+F6lYBb5r3
 2+KqHy+okp43BmpSHiDqn1t85Pum/gUBz5xi4eyYpeO/yQVSqiTUgLkPvXcbxq3PWblWlbYRXvF
 LX+V1kJHldLPBHor/x2TCPgny3yo9joEnSG+VRGHSV1fL+lAK+tF8o1U+Mgz9x1r8ELNt1KpXkL
 ztGl8rl9XAyWU5RfxSs1JL2el/drNbZVssRwWNP91ixP0wbJVDSYEsIMuEpi+eXzj0eH2sfVMGY
 jxM2SGUnre98CseQHL2CvzjIztGa54CpjauDiy9m6ndM8HVf4qckDmIj8fIflBgGsVEVZqVA/FZ
 /OaN9dYq7+QRTTT01hRGXahXbWLEI3TuXzpt8NJVpAE6neqV7+An/cPJIGzcptGM1AuXU+JDRpO
 kfTFLtU/U0Q4HISBMRA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-13_07,2026-09-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 impostorscore=0 priorityscore=1501 clxscore=1015
 spamscore=0 malwarescore=0 suspectscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609130326

On Sun, Sep 13, 2026 at 04:58:14PM +0800, Guangshuo Li wrote:
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

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
