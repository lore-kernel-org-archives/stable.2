Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 554953E63A4
	for <stable@vger.kernel.org>; Mon, 14 Sep 2026 23:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789427327; cv=none; b=Hn9LHR+tPrbwtDDtip+tShSxuZEQ57bgdrK5h0IDDAxgVALoIeyFgNpkRosBr6wIqRQgOGx3uy0EZOmOBNC8fSFgWtgOWZR+SPbLDG0AB/PsyX/08KEqfO1iU9evF7QNsEXmmALlqPTdcFPt6p0pVJNoGhM1ffpMLO609ZuNe28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789427327; c=relaxed/simple;
	bh=MM4HmYEslwlFT8HkcEYriN+iKsGM8sUFm0m8up2LJO8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BZoiRPwHSQWBbVBJQcVv43pg+iGtG8BEsFLTPysTaVoIL/z4Z3G1qYQ6H5xu1madhqv5d+JXc1KYun39KTrgv1CLimdU2ujrWBKaByhzCpHckUskb52sOdSNFlUgYCMDn61ynihVjrhWb+3oV8fxmAtsAbXhy1dR6b5XH5RubMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CWYERCwE; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Qnfropyq; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CWYERCwE";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Qnfropyq"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68EMxsab688290
	for <stable@vger.kernel.org>; Mon, 14 Sep 2026 23:08:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=EOf9jLDathiKO1GdPmBUWCGG
	kUylbrTzUgoCUbTBCZE=; b=CWYERCwErA9YwhYo+x2NFwrUzqRRohzsoxsqdi1a
	95MeXnHD1MH/ik6G9oONeC1tThhdKaRMj1ngfDplCwnOWI226dqbLP4lFEeDg/fG
	6Cvz3pFB85SdkdccAYBTibDxN05WnUe/QbLbJf9MJWz0Nx20vIsi16L/n9mhwjL2
	s0ZQeRgNJHf2ahzIVZQjuU8sQsJ2Y3bD+6fH0Imm2kZQ6z2DXiiJr1oT7qjYE6Cv
	7u+1iP5g84Sg3fhmr7a76kJKDQNvqPv/ZOtiNXqVIAkwrc+PGn/4j6NtqFbczyvD
	UAZ0jCXrn62A285mppAxpCuoFQjQweEA4LxxXHMvTKgPQQ==
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com [209.85.217.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gpergay3h-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 14 Sep 2026 23:08:45 +0000 (GMT)
Received: by mail-vs1-f69.google.com with SMTP id ada2fe7eead31-6751db2792dso899930137.3
        for <stable@vger.kernel.org>; Mon, 14 Sep 2026 16:08:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789427324; x=1790032124; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=EOf9jLDathiKO1GdPmBUWCGGkUylbrTzUgoCUbTBCZE=;
        b=QnfropyqyoXkaay8wEOgR/YVLdbvU0SVMUX8eRmVJyNxpH2Ksk/l+EPzPCOcLhAOjU
         Ar3ffEDe1CckRQAZJ+1DA26EUNacRBPrBhLOyDOo0YLIiaUzprGzRBDLloxs5DKpfRpz
         jPu31kLiQ6QLs8Ro9TfjfU7cpqkcrLBtYzXdVfFXAjeo+9OSYbnqjgIAOY/IMCkBYB0q
         kkN4QNxvefkbZh48Upz3ZUpaVo2Tm513DYWtCyeIuqszINRKQN94EbpsNTCc2FA9J7oJ
         3wyAMyfN+h7VLj9LhTZ5B/hwM9sbWJjAGydVp7DHyee2DeDZKzl7X85cfAcWU4W+uIMj
         OkRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789427324; x=1790032124;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EOf9jLDathiKO1GdPmBUWCGGkUylbrTzUgoCUbTBCZE=;
        b=eqhDCtKoXPesVINFqDDF/BWuuTfO5vjsPim0V5+iR5JsMdblkv4VAZ/oA7CHXwjwO1
         ubnkp9JxXsfbTJIVdpfdBg2QUUz5CYOW5tJBC6oBMB86MKqDktRbPQVXxUNcr4XJ3pmc
         vQbCS5hnr3ZJyXe/nmy3ghaonq58TUsPQRbibqiXNZM0vOaxT3Yj43vmjeFXnCSacaMn
         Gbtcauy6L4A48DpXMcpef9xScLH8dgZhKaWFs22ope//d/eL1N5NvDW8B1okQMcKl2pI
         C3IA+c2Y4l9cYjCwPhoOKA9GrtsIuwTmTYRjQbuNxtBQkmfGSP47p149aYnt24ScGlIh
         i+ew==
X-Forwarded-Encrypted: i=1; AKwUvBzjpc+tj3bmRixWz5nnZk6pgZS6d4P4xZb3L4vsFib+19kt1lQFPbiRhNebd+9ewHgxpoqSaQE=@vger.kernel.org
X-Gm-Message-State: AFuF++lQ8m74A/ecAk06nJlDta4gguQRuNIwAeQYJiWOcDEwfnsAHM5C
	a48JOo8grABzZXguHGwFaFpqD/R3BcMcpIXDwCeM+p0PPug9H38aDzQD3rvnv/MCBjcpuLoqqNC
	3ENo2ZGGZbwO40V++PbjW3B//UFn/bILdpXRkz89L1C9w69ui+UwoaMRkkvc=
X-Gm-Gg: AYBFou00YowZoMmL3sI5rPNTPIzLE0oh7jkf+h1jK8KSfbfuv0Mhwl8GRASFDPOtVIe
	w1pkFcL7uza1khLtjAq1c+Scr3oeU2DBABkON5IiIb+8pmyG53eKPCiAvGaqSRkZ2mbtEb//gPb
	CAmwFF00xTinFsBONwX4gfiZqHGfaWld7Mr9DvaXU3JVgaVvCTXIAbhAn/rgYOSo5VeYo10Dm+c
	qg+T7xhBWCfqn09njKzKHQ6d+HlKnV1ov1uM7HcIoTkRsvXsFuXwm5Qr3U5mj0d/oLQsjI38wPF
	lWO2UsRIkUaw80gF0TTztd+mmo55H6AVhjkktlFslwMBJCPACP1wObhDa0eN2PRTOGHPEW/Aj8y
	J70zp2AzMl+s0KwJdDIrFvRHyZZOv21pfAC6gVEhaHtgMZlcvwYBHHIcqhX3F7b1YuRTXLqTinI
	FB7o7NERV2ToEu
X-Received: by 2002:a05:6102:160b:b0:785:e069:6c5 with SMTP id ada2fe7eead31-79b5adb091dmr5457417137.8.1789427324371;
        Mon, 14 Sep 2026 16:08:44 -0700 (PDT)
X-Received: by 2002:a05:6102:160b:b0:785:e069:6c5 with SMTP id ada2fe7eead31-79b5adb091dmr5457408137.8.1789427323825;
        Mon, 14 Sep 2026 16:08:43 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3a5b433b5a6sm22229601fa.4.2026.09.14.16.08.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 16:08:41 -0700 (PDT)
Date: Tue, 15 Sep 2026 02:08:39 +0300
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
Message-ID: <3mhqndcw4defdpdo7t5wgb4ysh5cai6b7rq4sargypesxr67bj@6ibdnfmgyrol>
References: <20260826182459.1506522-1-saimzst@gmail.com>
 <wyoltftfpoxowxs4g4uwa2vi2pnspubn4vw4l2y52bwrhcjvew@xh3og5yp7uaq>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <wyoltftfpoxowxs4g4uwa2vi2pnspubn4vw4l2y52bwrhcjvew@xh3og5yp7uaq>
X-Authority-Analysis: v=2.4 cv=QK/91QLL c=1 sm=1 tr=0 ts=6aa87e7d cx=c_pps
 a=5HAIKLe1ejAbszaTRHs9Ug==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=VwQbUJbxAAAA:8
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=pG1nA-xtObB0exEfb0QA:9 a=CjuIK1q_8ugA:10
 a=gYDTvv6II1OnSo0itH1n:22
X-Proofpoint-GUID: IFYFf294rj1evX06m_QUfjp_P7AkBsF8
X-Proofpoint-ORIG-GUID: IFYFf294rj1evX06m_QUfjp_P7AkBsF8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE0MDMzMSBTYWx0ZWRfX199eOO5EXrVn
 pa11MZQ2FrrmlmvdWr+Iwerv5ZOdiyAeqM70fGI4SuVoOdqlUnpKVJc9ws4POHWjqzmt02kwYaJ
 1H8ScooWEBZwgs8pkHOa0hG8tJpYdj5TYrpsB0GqgQCw+rxmIpNe01Ri4Vg0Nqs1ZqAcOzAcUJ8
 VLrs8j8dnv5ZCOqHwJRfw8QK32TOhW/vqolicW+FA95w1JCqh+AOhfulfz/VT7zNefNdRnredwy
 9LTBgdvkeFUdmM0GaJ7802WmOLqFMoF4+5HU9W01HSmaYLdjQ3sAnahvdyz4xNIwPFOvaU9448q
 vusOoD5NT2HALT0wKWiDZeVJputXWZ+eEfJcNIAztHfXEYrfF/O2BIGZkN5EFekjVUJlu0qWqmi
 wp9MKrXFZz7bgcf0Nf8PlJerlGenoWiAk2hdQZHFQaF05tHk7bJS9XlDmSdyfXA4+zBSeBPl7ad
 tPeNvOAyF9QYEsVHjqQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE0MDMzMSBTYWx0ZWRfXxdMW/IA8NGXK
 KSYqR+pBaciO+MkwaPNyoMdTp2xSz42Ljx8aigphne4/P+EzzoZqfNHmeJASGFmpxNcq9jABprb
 Po39VDKe1aGQt+DLNjMvvUgJnF1CKRE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-14_05,2026-09-14_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 suspectscore=0 lowpriorityscore=0
 priorityscore=1501 spamscore=0 adultscore=0 bulkscore=0 clxscore=1015
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609140331

On Mon, Sep 14, 2026 at 12:59:30AM +0300, Dmitry Baryshkov wrote:
> On Wed, Aug 26, 2026 at 11:24:59PM +0500, Saim Shujah wrote:
> > Hardware can consume an active-frame CTL flush while the cached software
> > pending-flush mask retains the submitted bits. Video-mode disable stops the
> > timing engine before physical cleanup, which then adds teardown bits to the
> > stale cached mask.
> > 
> > The teardown trigger can replay source-pipe bits after timing
> > stops, leaving one pending and preventing the first commit after re-enable.
> > 
> > Clear the cached pending-flush bookkeeping before constructing the teardown
> > state. clear_pending_flush() updates software bookkeeping only; it does not
> > write the hardware CTL_FLUSH register.
> > 
> > Fixes: 22cb02bc96ff ("drm/msm/disp/dpu: reset the datapath after timing engine disable")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Saim Shujah <saimzst@gmail.com>
> > ---
> >  drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c | 1 +
> >  1 file changed, 1 insertion(+)
> 
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

Unfortunately this patch breaks several IGT tests on sc7180:

kms_plane_alpha_blend@constant-alpha-max
kms_plane_alpha_blend@constant-alpha-mid
kms_rotation_crc@cursor-rotation-180
kms_rotation_crc@primary-rotation-180

-- 
With best wishes
Dmitry
