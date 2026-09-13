Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 696E83537CE
	for <stable@vger.kernel.org>; Sun, 13 Sep 2026 21:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789336780; cv=none; b=b5b3hKZ0w9SsvDYNsa5jtqUTKeh14BYY7+05KVKVheABD4wg1eLUbj8qQljSE8Ap+fyjUr7/94J0h+E6WT/EXWmDDJ/E+A5kbDK8g1RQYbhNOUvv2cz6SXoPyMP14sAbrHL0xJN3Mg5vKiqtGSTzGECNPoTUpuI92WH5yHPNtEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789336780; c=relaxed/simple;
	bh=F4CyhSRXsOKZ0xZf1afrsqQt9p9O5tstOdz0XZsat/Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NmZQmLFHj1NJZO/agQEfbhKdHX/qrCn9CNXUaYxxtI6wn+ZRa0We7JJxzA6If2XWy/i0i4evZf2wp9+XciSvrgQVSJmzVSJBJNYReVW48zOs/10QDi0h/meDS4tG0prgtQJjnriMfOFXrG5sRHwrQ5AIZAIW87prV7qu7Ape3cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QIv24318; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=KKXcs2Vf; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QIv24318";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="KKXcs2Vf"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68DJxMU41926167
	for <stable@vger.kernel.org>; Sun, 13 Sep 2026 21:59:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=C5HYUvgwnNyezi4DPkW8H3ba
	CzRfmbYpk5g0hHr8iEI=; b=QIv24318GDSw+I3oxP6aB1sILBiVgSXDetUkMeGz
	29IUAhrqAja6P2giZ3Zv0Ve4Mu61H6U21K770k/LlzaGoq7dZOOyVq79ih2rVxQN
	uRZhATZVBp6IXQiTRMb7ectV/fjyRSF7jufX67EINMhrDn+cuP166Q/uZBmfnoQI
	nmXcuE5xFMEWeuWr124W/FoIcU3gtkmua8aTEoBWO0n1JT2G9k13QWHFR7ak634o
	7YKK2YoQpJQ2mvy0IsuOtIIV38NqnZgyt7dbSZSxUl18gXld7KMVvVyOvwD1U5Uv
	cH77OFbPAdnlPQX7XavOKHeGRgB5l+8tdhig+dmysZEkUw==
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com [209.85.217.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gn018m316-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Sun, 13 Sep 2026 21:59:38 +0000 (GMT)
Received: by mail-vs1-f70.google.com with SMTP id ada2fe7eead31-792f917d31aso2240586137.3
        for <stable@vger.kernel.org>; Sun, 13 Sep 2026 14:59:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789336778; x=1789941578; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=C5HYUvgwnNyezi4DPkW8H3baCzRfmbYpk5g0hHr8iEI=;
        b=KKXcs2VfkR+c1hSP1oKdJ5SuwXdj4iUZRAj0J0kUojHbGNunv8oEBb7YZmUDSe2HvP
         U+M4sRRX7owRfSjTqaMmosG+orUHqmb/JR4t44u6c7eA8EPXXRfpk5FUt9VeA1QWnbuS
         nRd9w4LLeIgRtuPIFBruI0zfKJJYK0teiL/TermpADMnEAcUHseLl8cnA2Eje+PV1kPX
         bgbM9hnsjjYrjuUOIkxVB4x5Wx9+8VRhNjTh+aSN+wepfwkEjvciwDefyIVx6VnWJUbm
         F6Eu4Jb2K+NT2uUMJoOreyuxoN+9ppWCqYJNdzVDMzJYfG3M4xVkoOg51q+tA0THi/U/
         jleQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789336778; x=1789941578;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=C5HYUvgwnNyezi4DPkW8H3baCzRfmbYpk5g0hHr8iEI=;
        b=OHOuQCEwoLlzjNaY6eH0oUNhnuyQMGuNOaVYACtlkgaB2xRkbu8x7AJCp6b5YwCIGo
         p7HvCLpUKf1vVlKNA9yrS/zWVrYhR1j17zphXgEB2f0b76KFi59rN0mTb2h56TKbXaX7
         rw3jH4nR6XQHohTGBcFqQNNU5ZugYI7CNUB7r/alAVlhQHMDJNwMengr+VLswVmwgBt7
         ou5CUG/fuG72j07d/9ldGVVRsUeMxY6ep1txMaG47Y1r4ahKAXY/I1JR2ioh7h21TXRw
         KCfJQ+N9Q3RDGjurvd7fivJk01Mxt43eZq5vwrwftnihZCu9Lkm25yACNdgCLmOwlgh7
         2PUA==
X-Forwarded-Encrypted: i=1; AKwUvBwp6UTwt3EX61HYnv/xeY91iUmXy63JBb39henN884jqlwpQbk9zDKhZx/Fc3kX4SyqYpJHL0Q=@vger.kernel.org
X-Gm-Message-State: AFuF++mHok/BdzIuJiCXwcQKMnMgTvvg2C1G7bfwije+lGnYurFZ3bkd
	CV0vrx7YZBrV8+F3zeoN/FGIuHpXPd3l9mw6j8ThQ4XjdMwxJzDESp9XRHtPEXcJz+vDEM7Wohk
	01gdP7wKh+RneQyW4wb+pEV/LO1lNNnFoyiwtgePzkAvUcD7CrlCEz6bhAko=
X-Gm-Gg: AYBFou2hhR1YfoRr2sau2+WGGcpRarwSIP968BHd6RnqURwSB79ccAdX5bVEKVRGcVu
	LOYh49QTe2dQZmlKMf6F4hLNkjiLMQmQEacLb3u6tnCGDZYLl/VSN04rJci9OkPaN2PmyoZ/J8P
	AIRfnDvPuWsvEnTg4+U5EBkKCN0SEQje8XojsbjGp3WdJgEXIZbtvvJ4Lc+5GgxCQCxsPPs/pD/
	Y+6CdGZ88udgSHeTkKUuYuxLNGvvk87zrSzoOzSzS973DuVpKsiIgtErFty0ZNesCwFKDJyQOwA
	JkPC2bCz97m4a1Nzk9+pCjByGmiiQzPpSuyZXvvSuIKQFl2gWgr4COwLlxlRpvXb00X4Kgwsozs
	x04KryCcYzG7TY0q9PrAzoRrAp5P4p8g6wXJnDmnlWkUG3ImAxiB/0lUsiFLKcrItfR5tOTmdYs
	ht0Hdr/HbdzIRs
X-Received: by 2002:a05:6102:869a:10b0:79a:62cf:2a50 with SMTP id ada2fe7eead31-79a62cf501emr764809137.7.1789336777697;
        Sun, 13 Sep 2026 14:59:37 -0700 (PDT)
X-Received: by 2002:a05:6102:869a:10b0:79a:62cf:2a50 with SMTP id ada2fe7eead31-79a62cf501emr764768137.7.1789336773560;
        Sun, 13 Sep 2026 14:59:33 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b8a0457189sm1907495e87.25.2026.09.13.14.59.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Sep 2026 14:59:32 -0700 (PDT)
Date: Mon, 14 Sep 2026 00:59:30 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Saim Shujah <saimzst@gmail.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH] drm/msm/dpu: clear pending flush state before physical
 cleanup
Message-ID: <wyoltftfpoxowxs4g4uwa2vi2pnspubn4vw4l2y52bwrhcjvew@xh3og5yp7uaq>
References: <20260826182459.1506522-1-saimzst@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260826182459.1506522-1-saimzst@gmail.com>
X-Authority-Analysis: v=2.4 cv=c4g+0h9l c=1 sm=1 tr=0 ts=6aa71cca cx=c_pps
 a=N1BjEkVkxJi3uNfLdpvX3g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=VwQbUJbxAAAA:8
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=r5cTPNi_baYN2tIuLokA:9 a=CjuIK1q_8ugA:10
 a=crWF4MFLhNY0qMRaF8an:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTEzMDMxNCBTYWx0ZWRfX7eGresfC9oJO
 Q4sRaEvhBZZObEBZY4v6RGuvSuSGPwLENQWRMENSMzhFUxozc0jLJqaG21V85kLWZLU84+8lQEz
 faWuyTVP32a+kjDfI9810bFzRk1g1vw=
X-Proofpoint-GUID: jI00GHXDGjZq_I7ZTHvxSLUFxZHhpNuF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTEzMDMxNCBTYWx0ZWRfXzd2byz8CTAAT
 uDojK51XIMCYGSDdTRmb36mMVzO6K2kbJ6ByaATxZmpshJpXjpKPiHajQj5iMdUqkaasqt7FPYG
 +/mkLZv1Dieje0VjJASTom9Zs9OFfLuupx4etmY0+z7ngwk4Fk59Sec4xyPGKY4Tj0YZEZj9xQe
 UelwVAiDeuMZdZeGRDGj/jb48+bNMryI2SZ6NFrdsVZPSOtnzI01R1UdbHVDA+V6J4kpXSQJwvg
 LEA4cRqFcnTsMoox+QCyHs9Q4zC9S7iwEKsCB50HM+63yYkMl/0Dvx3iBw/z89DU46tEw6Gq4BE
 ZUnbQRv9nkvT6n9XWH3o3DZd29hVZpY46NTJqqmsa7CAfF/RgApuyl4PzavdUEOW7fWD2I9egKK
 uciH9okctSdesLyAAilpu/UuTG+secsDjuwi340I/eHKcxJOBbNujKYW9UzxePVadh4lt53KRii
 AmnZRe0aDoXDdTBlc6A==
X-Proofpoint-ORIG-GUID: jI00GHXDGjZq_I7ZTHvxSLUFxZHhpNuF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-13_07,2026-09-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 adultscore=0 bulkscore=0 impostorscore=0
 malwarescore=0 phishscore=0 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609130314

On Wed, Aug 26, 2026 at 11:24:59PM +0500, Saim Shujah wrote:
> Hardware can consume an active-frame CTL flush while the cached software
> pending-flush mask retains the submitted bits. Video-mode disable stops the
> timing engine before physical cleanup, which then adds teardown bits to the
> stale cached mask.
> 
> The teardown trigger can replay source-pipe bits after timing
> stops, leaving one pending and preventing the first commit after re-enable.
> 
> Clear the cached pending-flush bookkeeping before constructing the teardown
> state. clear_pending_flush() updates software bookkeeping only; it does not
> write the hardware CTL_FLUSH register.
> 
> Fixes: 22cb02bc96ff ("drm/msm/disp/dpu: reset the datapath after timing engine disable")
> Cc: stable@vger.kernel.org
> Signed-off-by: Saim Shujah <saimzst@gmail.com>
> ---
>  drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

> 
-- 
With best wishes
Dmitry
