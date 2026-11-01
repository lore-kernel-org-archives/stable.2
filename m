Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793530723;
	b=U9kCEiDF9czmy6SL5wsPt6F86e/rw917UbCQnpU6ASbngMtIPh+vqgz1zOLeDawHQFG3
	 3nLGMtN24Bp7gTPyDNW5m8VqiSsagjqtw4Kn7cli8ZRVfIr2Q4fOt46TUCW8i0jvWiZKc
	 /w+xRpFyribiKsORm1SW+KoaDJRoHO2GV3iXwrnoyKURnAfzib4/RgWf1ykdV0Gw6f/Gt
	 KvZ0mzykpnBNFfzRkSAUXUmVLbDX8I/CwvtxmDjbu4xM07BYeTJwo51VJUTaq8kyrqZBD
	 hX48e4CvM3drj++m7l9dRTIcLAm/bSsG7vMgRAoIHndPfUXYalpeUPLWfTE5UO6Gm6Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793530723;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
	 To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=V26Rxt/dvQi8UJT1RGBvNKJzELhSQFEnT8mAHiQZZLw=;
	b=rpbOMsKv9YVnWKnNU8B9RGVo4z4Mv5QlrygaVmXL2f3t9GfvEcQj6VCvIfO883mPq5jA
	 kteckDbEXx5pERLjRJFA7mK8IE+T8tk9ntP69yCtLQNtQGVZ8F9Z9tox9DFQVdFcM4poS
	 ZHQNOaHJ+wYY4YQF+/XQglyPUYSrMpE3G4Aw5Ussza9WDGL1cPdH8abHTdRelEJQGTrS6
	 Gs5TsSVCtjqJg9byex0CFsHN62QsV1mehNbfcV5COZMeZhjjZWJve7n2DH3uEbIF4IzB0
	 yrz6QnSrlMUeuMh3Jxetoza0v9HWRZhx2gppqvqixgsmTO9htHDhM59QTzWdo0qo3bw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Cbjp4+2E;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=B5HuIFvr;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ABF7606A331
	for <stable@vger.kernel.org>; Sun,  1 Nov 2026 10:58:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4ABF7606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Cbjp4+2E;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=B5HuIFvr
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A18K3sn2929113
	for <stable@vger.kernel.org>; Sun, 1 Nov 2026 10:58:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=V26Rxt/dvQi8UJT1RGBvNKJz
	ELhSQFEnT8mAHiQZZLw=; b=Cbjp4+2EQhHPRe4vPcA3aMWtw6AnTDzXXsMkAlkP
	NSvAZTe2toamPYew41bCKmT4KDChnIS1gKngGgUBhdjsxtsNIqS00CYsdIdaJmH0
	OF5YOlJsIyUujDJLmR8dCOTpgrege3HvmDNrcwcviJGmfg/39VGIbzgeD7Lu5uRL
	KINv8MNjjuGoQEw0CqTNyvSlSEqYM+QPUQZpipu3NFNEPAGEkV7HbCbcXmmYbHTY
	2IOb/70CtbgBZ1Sm8qa2PL6yWKBC9pXYQwlK41+oKbQCxoZ7jBFhj/rYrI6Vb0iT
	wBvPXBRHGFahrJxOVOX8NdBhpc9+dAhjFY55MB5VOgy/Vg==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hn9gk300p-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Sun, 01 Nov 2026 10:58:41 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-93e92aad34aso427614885a.0
        for <stable@vger.kernel.org>; Sun, 01 Nov 2026 02:58:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793530720; x=1794135520; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=V26Rxt/dvQi8UJT1RGBvNKJzELhSQFEnT8mAHiQZZLw=;
        b=B5HuIFvrltXt3DRLKTE71NMB3GmaZLifzUlmU+JpjOu4hxO7j3X70Hj70eNAmlYuqX
         3feDbwewF6pmCBH7dTGLqs2/4xQknowoOFtmo5OISHSqMZpVcL45NPjyeQeLmOHEmsDX
         pQu2C0cdVkG1N9JM6ENODOkg//0W3Ca2R2IVd7i9OsoY6Uccpya16ydhQO/W1FGIF7Ab
         ampc7/T9y0vJi/eRot4siqqswvHGZQToVf+rO9rmQlf3LJWZCZnuez7KCgVxVBl50plu
         Ub3mGwULxC4eIQDOKu0XfA64nhjjkQFZJZFRPxGrJ/rxS3iTSg5zeqtvjTtFDnHIkmDE
         OD1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793530720; x=1794135520;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=V26Rxt/dvQi8UJT1RGBvNKJzELhSQFEnT8mAHiQZZLw=;
        b=R0fRlZV030AWmTL1YQDbZc8G7PcWnZmteBE7Lv7Vc+vYTZxGm7bPw4uFCBw+8GmPC2
         s57GaCS4W4AQNUjwkWMD1dzHGKiWsrDbUOTSueK1S+ReMHV1WLlaK3SXGpGWkma6BYxy
         qxk/tVCCJns9lcbZBA5o66O4K07tOzEPM/lVsNn9rFQYoZmT7qjLMKDAah0PL3lvQdwi
         muY06RCd4X8BB13c28pZl4V+qkxLJ7cd+rEyGCz9obVKB7VWUlwCBmi5LQCRSzt+NuZW
         1cPRsuF1f8YSMwD45tijF59n1hfgHDoc5GtzmAx9nc3ZhNQuf9Lvr1teRdlMEDNP94w2
         CC5Q==
X-Forwarded-Encrypted: i=1; AKwUvBxehjG/6mVpb/93hx4psI/4Vg5d07riQq30Lrm+Y0se8mbPfHe1ALGlnsuB7LjPRIqfJJXzU8E=@vger.kernel.org
X-Gm-Message-State: AFq9FYLmHEiOZtboIrQEAJs/9DiXNlMT3+10OBd9i8L77lHTyZjzdUMP
	q6fZ1WoMVaO+Wenzxh/mfN2z+9Rre6za/MOjCj3sFZfq0GDAl1wrojXIwK74QOjAdz+Dy/hQc8i
	gIlSeiY1BQifF+1C+pvZOTPJtHQrLgX+qfYBojo1ZFDfoaCGGvCbfw5+uPkE=
X-Gm-Gg: AYBFou0OFGA+f03dKLIS1CXDnroan6Am31S3bOd8wDvKZjpyDGLvfmOF+GF6HVE3B5+
	I3AjF+6eqah+Psj3VLlETfCSBaZr3Y7jm0EozM3Q5kLmWOsKl7FC2W2xsZfyhgB8ccHQiz4MVdw
	6TKtcpIacSu0xtf0wt0xbtG2I10Zhq/A5v1pIvU+O8cjZpGLvvmZFNDe9K4BiJJqWfe4HqDetA0
	DNgwjh6oJtJdTTFHXsY2RM+55+dOxqrzuxuqgtJl0Uw3cgi7XwxTXzW1hvnRodyAl6GI2GqvnKg
	vx5SeiwLzgjU965UstxEDdmBIosVLmTVosYogLAtZm89+7vUDjRtt43OVBED8wP3UUTMpCIDubg
	j+XFK/bZHvLal3dRGAilldsaAMStpPFrI6I/oLZd0cAX2IebEMielHmNBLl8rf9DIxIx8slGUql
	3NnxjK/0K/5HBDLgHHGkw0dhrn4+AyvT+y3umk1u9TZdvdxBzyX9leD4cpCmuE
X-Received: by 2002:a05:620a:4724:b0:93e:c12c:43fa with SMTP id af79cd13be357-9442171c8a4mr1167598185a.71.1793530720218;
        Sun, 01 Nov 2026 02:58:40 -0800 (PST)
X-Received: by 2002:a05:620a:4724:b0:93e:c12c:43fa with SMTP id af79cd13be357-9442171c8a4mr1167596185a.71.1793530719592;
        Sun, 01 Nov 2026 02:58:39 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5bfe07541b4sm1027580e87.81.2026.11.01.02.58.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 02:58:38 -0800 (PST)
Date: Sun, 1 Nov 2026 12:58:36 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: "Beat M. Liechti" <beat@softbase.tech>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Federico Amedeo Izzo <federico@izzo.pro>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH] drm/msm/dpu: don't reassign resources on color
 management changes
Message-ID: <5jypdookmvfmrdaef2c54aab5kfcpjvejc6f2jyxvbjhwpqgzd@ipvdiwk3zxvc>
References: <20261101095754.33840-1-beat@softbase.tech>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261101095754.33840-1-beat@softbase.tech>
X-Proofpoint-GUID: z9lxwqE1KacYZtlLd-RthTCAajScrgNH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAxMDA0MyBTYWx0ZWRfX/ri/yBX4uqPd
 NT1UsIIWsLwLFbq2/YMELbxI1PWU1cFDI+QEJPgb1pqz2UYFYCRHcbHFz/fSuwLQsQbjD18KotJ
 V/miO+fD9Yp+UgZ9uTlMWWjXBFQ25SrhO/fzQembShW8IlCbA7DicHbDKriJdFrq4zdqcfzZLiO
 NCTwrVp86mRrrD3qvj4o12jw4PqXjLj8NflDWFo3X6gqD3QQeavddl6eVrb7mtSDWO46j7LobNl
 cbu97xIqYeeIXvtJJ/e4xugtj7yr5MSCPzsqW69jpbPurar8dP8/y9pTEOW6gXdSPaGtoLr1TSz
 zOMPuxX2IeRewFahG1U+wBCDbiHym9wxjvnN1/pXoPVYHOiSFo541m4nuHpVxaV0kI2wG1ySNuq
 L7Q4CFyOnGLKWwsoSrxHtDlsPU/n36bowxbZf2+r54PhOhlNVKsPbZ5uVVPe7cUvShNv8/v5ZP8
 mr/zVuz5E6u+QLEZyXQ==
X-Authority-Analysis: v=2.4 cv=HNBWhYtv c=1 sm=1 tr=0 ts=6ae71b61 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=e5mUnYsNAAAA:8
 a=VwQbUJbxAAAA:8 a=Ox7JqDZjdXA0ESHpvBYA:9 a=CjuIK1q_8ugA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAxMDA0MyBTYWx0ZWRfX0woCw6qr5QmE
 gtZ29kFnLbIdCVm4QJbDHafvKQcjcp7jgwApHJeeVcTSMZUJ07pgiGMdbZpxBOn8rJZFOMtayVQ
 dFCniKvYOxmx3b8Z0tIZUuUbkzflB8g=
X-Proofpoint-ORIG-GUID: z9lxwqE1KacYZtlLd-RthTCAajScrgNH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-01_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 priorityscore=1501 impostorscore=0 bulkscore=0
 adultscore=0 suspectscore=0 phishscore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611010043

On Sun, Nov 01, 2026 at 10:57:45AM +0100, Beat M. Liechti wrote:
> Since commit 39a750ff5fc9 ("drm/msm/dpu: Add DSPP GC driver to provide
> GAMMA_LUT DRM property"), dpu_crtc_atomic_check() releases and reserves
> the hardware blocks of a CRTC whenever color_mgmt_changed is set, not
> only on a modeset. A commit that merely replaces the GAMMA_LUT or CTM
> blob of an active CRTC can therefore move that CRTC to a different
> CTL/LM pair without disabling and re-enabling the pipeline, and the
> hardware keeps scanning out through blocks the driver no longer
> considers in use.
> 
> This is easy to hit with GNOME/mutter on a laptop driving an external
> display: closing the lid disables the eDP CRTC, and in the same atomic
> commit mutter sets new color blobs on the still active HDMI CRTC. With
> drm.debug enabled, dpu_rm_reserve() moves the HDMI CRTC from CTL_1 to
> the just released CTL_0 while its encoder is neither disabled nor
> re-enabled. A few seconds later the display SMMU reports context faults
> at the refresh rate and the external screen fills with garbage. Opening
> the lid again leads to a stream of "vblank timeout" and "frame done
> timeout" errors and the machine has to be power cycled.
> 
> Color management affects the topology in only one way: DSPP blocks are
> requested when either CTM or GAMMA_LUT is set. Handle that case in
> dpu_crtc_check_mode_changed() by forcing a full modeset when the
> presence of CTM/GAMMA_LUT changes, as msm_atomic_check() already does
> for the CTM, and stop reallocating resources on a bare
> color_mgmt_changed.
> 
> Fixes: 39a750ff5fc9 ("drm/msm/dpu: Add DSPP GC driver to provide GAMMA_LUT DRM property")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Beat M. Liechti <beat@softbase.tech>
> ---
> 
> Notes:
>     Testing: ThinkPad T14s Gen 6 (X1E78100), GNOME 50 / mutter on Wayland,
>     LG 4K60 monitor on the HDMI port (DP to HDMI bridge), logind set to not
>     suspend on lid close while on external power. Without this patch every
>     lid close reproduces the corruption and hang described above. With it,
>     closing and opening the lid produces no SMMU faults, vblank timeouts or
>     frame done timeouts, and both displays keep working.
>     
>     That testing was done on a v7.0.14 based distribution kernel (Ubuntu
>     7.0.0-42.42). On msm-next the patch has only been compile tested (W=1,
>     no new warnings), not run.
>     
>     Open questions:
>     - Like the existing CTM check in msm_atomic_check() (see the FIXME
>       there), this sets allow_modeset on behalf of userspace when the DSPP
>       requirement changes. Rejecting such commits without
>       DRM_MODE_ATOMIC_ALLOW_MODESET would be stricter, but could break
>       compositors that toggle GAMMA_LUT at runtime (night light). I am happy
>       to change it either way.
>     - The RFC "drm/msm/dpu: Force modeset if new CTLs have been reserved"
>       (https://lists.freedesktop.org/archives/freedreno/2025-March/036824.html)
>       addresses reassignment without a modeset in general. This patch only
>       removes the color management trigger.
>     
>     The root cause analysis of the drm.debug trace, the fix and the
>     changelog were developed with an AI coding assistant (Claude by
>     Anthropic). I reviewed the change and tested it on the hardware above.
> 
>  drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c | 26 +++++++++++++++++++++---
>  1 file changed, 23 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
> index 42d0a529b..3b304a896 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
> @@ -1516,6 +1516,20 @@ int dpu_crtc_check_mode_changed(struct drm_crtc_state *old_crtc_state,
>  	    (!clone_mode_requested && clone_mode_enabled))
>  		new_crtc_state->mode_changed = true;
>  
> +	/*
> +	 * DSPP blocks are reserved only when CTM or GAMMA_LUT is set (see
> +	 * dpu_crtc_get_topology()), so enabling or disabling color management
> +	 * changes the hardware topology. Changing resources on an active CRTC
> +	 * requires a full modeset; otherwise the CTL/LM blocks get swapped
> +	 * underneath a running pipeline.
> +	 */
> +	if (new_crtc_state->enable &&
> +	    (!!(old_crtc_state->ctm || old_crtc_state->gamma_lut) !=
> +	     !!(new_crtc_state->ctm || new_crtc_state->gamma_lut))) {
> +		new_crtc_state->mode_changed = true;
> +		new_crtc_state->state->allow_modeset = true;

Having allow_modeset in the atomic_check() code was a hack, which should
not have been allowed in. We are trying to get rid of it, not introduce
new instances of it.

> +	}
> +
>  	return 0;
>  }
>  
> @@ -1534,9 +1548,15 @@ static int dpu_crtc_atomic_check(struct drm_crtc *crtc,
>  
>  	bool needs_dirtyfb = dpu_crtc_needs_dirtyfb(crtc_state);
>  
> -	/* don't reallocate resources if only ACTIVE has beeen changed */
> -	if (crtc_state->mode_changed || crtc_state->connectors_changed ||
> -	    crtc_state->color_mgmt_changed) {
> +	/*
> +	 * Don't reallocate resources if only ACTIVE or color management
> +	 * values have changed. A change in DSPP requirements is turned into a
> +	 * modeset by dpu_crtc_check_mode_changed(). Reallocating on a plain
> +	 * color_mgmt_changed would move an active CRTC to different CTL/LM
> +	 * blocks without a modeset, leaving the hardware scanning out through
> +	 * stale CTL/LM state (SMMU faults, corrupted output, vblank timeouts).
> +	 */
> +	if (crtc_state->mode_changed || crtc_state->connectors_changed) {
>  		rc = dpu_crtc_assign_resources(crtc, crtc_state);
>  		if (rc < 0)
>  			return rc;
> -- 
> 2.53.0
> 

-- 
With best wishes
Dmitry
