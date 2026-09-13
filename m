Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CE48366045
	for <stable@vger.kernel.org>; Sun, 13 Sep 2026 21:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789333617; cv=none; b=CzDUxguuhKSBrqFTgsn4W6LZ5doSKcKvMdwRPd+QBK+VeKPQrLjqAll1kB6ZO9YXIg/36HT2K64qV0LVE/HRzwmh2/hivP9yWZXtekzfLljNqpir+x1Z2bgKtxHEORQuO9xxo7FCWAbfDDUB/Q8FLEYMFBwy5+xWeqyNUjdSvLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789333617; c=relaxed/simple;
	bh=Rc3rXnon0EQSw8KwGfyrwFTj1nXUy4ld2WfIZRqodMM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dr++56JvtoslYUsg9VI3ou3odXAoLlHQ2ToWtU/sbUajAN6EcpP2n9mNmOKB0qRqJJN3uGddIKmyHGEbemIgLTCDeBfgz3lBG3zSsCcRX0DCHJW7+XZnWun4GUjhNFrfR5GkEkhNyfSSFiY6IKjFT1e8GuQpIvTYgrrBdGEMxno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=IUJA4TFa; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=a/Xnk5m9; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="IUJA4TFa";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="a/Xnk5m9"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68DJxiW62848945
	for <stable@vger.kernel.org>; Sun, 13 Sep 2026 21:06:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=CuOZZ+1bOWWW+56MFTScBnnN
	4DrpUl8zDP2tJWpYYOw=; b=IUJA4TFabIVCWVLJ1k/WNtI+t+aNF4Qx/N+NuPlV
	68/LKjTRHsxloRbPMOP9GROn1MsxIvCQ1y5nvma6lCKtf7fzdgWpv1Um4mzXF6Lp
	vDgBaJX6lMidWRDmOdD6xYM6Y1KG+tVTu6Vm6+PiG4nApUNcMMpJx0Qw3+/o7vE9
	AZf9HERE6fg7jIDNVYOS1KXlGSHugVq+a5dAI5+iEOj+fMrdiIomtb2LELvBXz9B
	r7UUwg90f2kNKp3gYNVEVDoGykOu6t/W414oHG13WMIlXeu9x+aPUdulM7Dz7GCo
	K9zOfaNb6rwR9aWEwP1uPuaPwvkFjyzg2IENHs/MkcctOg==
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com [209.85.217.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gmy9cc4c2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Sun, 13 Sep 2026 21:06:55 +0000 (GMT)
Received: by mail-vs1-f71.google.com with SMTP id ada2fe7eead31-78f4d6af128so484934137.1
        for <stable@vger.kernel.org>; Sun, 13 Sep 2026 14:06:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789333614; x=1789938414; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=CuOZZ+1bOWWW+56MFTScBnnN4DrpUl8zDP2tJWpYYOw=;
        b=a/Xnk5m9ur5GT3zURzA6w8fnIrBnR1v9Sl+MsrNm9RE9ZEEKXyJPYJBNh3BDb8eLkz
         68GFyzafEEzlN3dR9/v3FoJvCp7ehd1UdpTXzrmaIzV1DIpXbCzFN4esjFLNLzW4Z0fJ
         TlDiwYFC0o7JvVIADDrWUGmIaI3893tl5snQeUeRABDElC4WHFhlfHIWaQqnelfGAw5x
         Djri66Yvwu55YBmkd0CG/Nk5MwaFQIo2aAbt9DE86QUg1s3NKt42sjxPqoZzWcxque5Z
         CZoKM/8uz8Ch0u4gyTiOV7FNxki3T39mWJ49SdIxUuggQkfyBKXQuvbuNtTOvpbURrfA
         Qbiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789333614; x=1789938414;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CuOZZ+1bOWWW+56MFTScBnnN4DrpUl8zDP2tJWpYYOw=;
        b=BTQlf5vYfl7MWisRpTGKnk0ZCmBwbXNo01F//ZalcbJCKNVM7N8nUhYMLBA0WkqfXk
         qLMMRRppkB97bJ8LY5zmk1Zq+RGXnF0PK/airAWUNS8eqzimeH4fA1b1TK2PwGy7ZIS0
         tPOsXg51Wi7yn2hT64fjhsXHth7HWYFGUJeEAZLpFiS2U0F3wP9RTJ/CNkIJbnDHquGY
         Jg/mVLTznaLvikHD6S7EYy6cpjQWq/d2dX/NGZ1YLLYDarfo38gqDjQAdKPKDq73Nz5d
         57o8wZWiPKxTEwO5z4crSK89emQtKmhbPzzH6uzyPhnlzvQxa6fXSPafdJWT132jA+pk
         tnWQ==
X-Forwarded-Encrypted: i=1; AKwUvBzWYXVPyc9rb5eP+s8QFCpJqzPXtr1EnKTYlY4nDr3icDOgsw0I4pGAxnKxNqOj1gdkXDUcS4U=@vger.kernel.org
X-Gm-Message-State: AFuF++kF1kfNXcG4Vil+qS9yT7xHeE5AFF8S1L4VbOkmdOfMkZplBoQA
	hk3lGAwpVW9JjYdQQyQUjg53WIjQWkD4t2nc2Q2fnQNkwflzkBasqn1oxH+5N6dzRLUvmFeWPcL
	9N5hKHHwJBkMsAPLawo6JKceep6BVd0LGerOssMXnHJgx89hmHyGgGpXwa0Y=
X-Gm-Gg: AYBFou0jo7JAuaRLbK07+WLzDqT53dFLrOrPU4XU07sxdry+4tu8T+HcL4Hc092FpBx
	czK2wAmIOjVpwoMyJJimAEjoW/7lmM6P3OHsm+OMLzq++O7LVlrba+nfuq25UIcYwaVOPTfEqpg
	kK0JcyOfJSBKiAZbYBCTarBulMHn0KmSrr8cqvVCNCLujujp7QhTcbnTslaxJRw8h96jfUNtco5
	m8tYwCLm6a8KYqkNFq/dRP5NPwFVs7iS26OSqL3jLg9Lf6YnmQKOdLueLsYRRiZiF3EkFvaKgVc
	j56fQGclFUoD58giQbkKEkaL8l8d0dZ0AJKzU+pXXwKphzmhEdWt7dgZfIPZ69tY/nZOQh8rM3k
	VJtGUccfUdBkyF0/Hzjfc2JWgUB9borWJOiZ099BUXqNyr5JVxaEUCvyIYQlVXodFwP+SBCIJlk
	nkcpOMlHOAhvN8
X-Received: by 2002:a05:6102:8607:10b0:78f:5bab:4761 with SMTP id ada2fe7eead31-792a93b4e87mr2736743137.8.1789333610781;
        Sun, 13 Sep 2026 14:06:50 -0700 (PDT)
X-Received: by 2002:a05:6102:8607:10b0:78f:5bab:4761 with SMTP id ada2fe7eead31-792a93b4e87mr2736729137.8.1789333610333;
        Sun, 13 Sep 2026 14:06:50 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b8a045f6f3sm1914073e87.35.2026.09.13.14.06.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Sep 2026 14:06:49 -0700 (PDT)
Date: Mon, 14 Sep 2026 00:06:47 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
        Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Akhil P Oommen <akhilpo@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jesszhan0024@gmail.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH] drm/msm/adreno: fix autosuspend cleanup during teardown
Message-ID: <vwnlgp3ysnoimdxlx6gowktonakwpita2ted7tcdfd3a6vyjy2@p3slguu75r6d>
References: <20260808131624.2854412-1-lgs201920130244@gmail.com>
 <e5964398-cc23-440c-8c69-01353b5a5ecc@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e5964398-cc23-440c-8c69-01353b5a5ecc@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=e+mT2qp/ c=1 sm=1 tr=0 ts=6aa7106f cx=c_pps
 a=P2rfLEam3zuxRRdjJWA2cw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=VwQbUJbxAAAA:8
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=owhB9EOPmpqNCIfoPYQA:9 a=CjuIK1q_8ugA:10
 a=ODZdjJIeia2B_SHc_B0f:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTEzMDMwMSBTYWx0ZWRfX6dIvnsjgRh1Y
 0Dest5AoSwEWHkZmKWi+yPalv3gtRjqAUNBD33ENpLhjt37ZDYkhNeYDy9vXWJJIWi9bWZ5BDhU
 zUcO9mGlh6uEny0jIni5VnSDP2CzUWg=
X-Proofpoint-ORIG-GUID: mck-BW850Vbj870ldYdVPtQ1hbUpY_R5
X-Proofpoint-GUID: mck-BW850Vbj870ldYdVPtQ1hbUpY_R5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTEzMDMwMSBTYWx0ZWRfX5bT90qOW2twi
 nbx68dc+CpJeJ5vLrP1zKpRKNXEVm3EpV6gWfMQsf8HcosUmIQKYOFG0Ra9I9KaNncYaOHYaDkI
 GmK66pXj8sp3Px0wbCAVZeggDsPU2QTU2kIZBFXJcnw3G7L5TgtybxslYscGayCsHWoDG8pGrtX
 mR65BzrRIeb6raKJbamxXcobguv1UpNTPhd88N1Mk3x5BbVCseEz/HYJ+TIHGKAV7TGWSPBoqcX
 g8cXf3aDctazAcvqHRb1po/E8O6ktqM16DkluN1wHRrs9eDefoWkkgesTQhyw/xtqGJTZ4m8047
 AS9tE+nOCQvJk/R9ah3WXBtuul6GIAddHYy1b6HypRNdb7KWxN7dHUzqsB96jP9s/VG5uH9S18d
 gN9Y1WRlBEX7I9VA33SyDBuPFhqgD73erbiyC5xNtw1LBhSCHTWBj6YXCFlHt6iBLt1agZ5Fqba
 7CuAV8y25x6kCLNxfxw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-13_07,2026-09-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 phishscore=0 impostorscore=0 spamscore=0
 suspectscore=0 bulkscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609130301

On Tue, Aug 18, 2026 at 12:40:27PM +0200, Konrad Dybcio wrote:
> On 8/8/26 3:16 PM, Guangshuo Li wrote:
> > adreno_gpu_init() calls pm_runtime_use_autosuspend(), but
> > adreno_gpu_cleanup() does not call the matching
> > pm_runtime_dont_use_autosuspend() during teardown.
> > 
> > If the autosuspend delay is set to a negative value while autosuspend
> > is enabled, the runtime PM core increments usage_count to prevent
> > runtime suspend. Without calling pm_runtime_dont_use_autosuspend()
> > during teardown, this reference is not dropped and usage_count remains
> > unbalanced.
> > 
> > The documentation for pm_runtime_use_autosuspend() also notes that it
> > is important to undo it with pm_runtime_dont_use_autosuspend() at
> > driver exit time, unless runtime PM was initially enabled with
> > devm_pm_runtime_enable().
> > 
> > Add the missing pm_runtime_dont_use_autosuspend() call to
> > adreno_gpu_cleanup().
> > 
> > This issue was found by manual code inspection.
> > 
> > Fixes: eeb754746b14 ("drm/msm/gpu: use pm-runtime")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> > ---
> 
> I think we can use devm_pm_runtime_enable() instead, which will take
> care of cleaning up both the autosuspend and runpm halves

Not really, beacause the driver's group device is DPU / MDP4 / MDP5
(in case of a merged display+GPU), so the patch seems to be correct.


Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

-- 
With best wishes
Dmitry
