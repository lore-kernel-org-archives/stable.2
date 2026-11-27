Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795781193;
	b=JOurcom7SQpQ3XAbsIrUu7J0xX4PYhJdhweENTQi1W103IAv4DtRSzoyVSnuKnO1YR11
	 /BTNtqxo6l90xqNFaJeKQq9Xf4ni1dhycRoAI1ViDpUyA3sEQxSjbcvNLru3rMkXYBZBp
	 ckAeIPpVe41GAfB/z08H4Ywq55DkIXqFBsTFfdC00IredOoMDIc7P7G3+AxarI5P4HvF8
	 xwnHJrzMY/JhFWcQ4Bdr91nCv4Tv1Ycwaj5l4YyoFAxiV3lAAjtjMkEx10cjZo2rpcC+y
	 7pu5ncG23muYBgbIhigWkME1XVTvPTS+sYCCsFyo/x1ESp9dmjBc+pujMWh8D4/VIIw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795781193;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
	 To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=FELi3FLt/Pi/OkzOMRJ8+hRRlAJ733i1PeWjERVJCog=;
	b=f3FLEI4Q6R/gDux8GHaVYvN4zH0x/LGACOpiA+ltdVs6FOEtgq8KwwNSV5ftRfz83snq
	 wKBHhWJQ8kcSSZkiRbTDKSQCjJH1eLWXtdvW4Ape1+t4gS8vQbk7/WvyxOQLkEK8QQITg
	 FxRbR2j1qpFZJfBPw2DsypVGaBIL0hhP1PzuPmQILb1uQLbLURsk751u3SWYQsZ+vSZ8I
	 h12d5CyIwKeOQK8VhxpjyIK4FzVux9Kj9ahiHSUymNdNYq/vXLmPZRwPACAGq3jp4CFkd
	 H7WZ9PENP2oGNdWyXMWAImfE+c8fVAQAdjVp3iYdTpnflAKQonYFbydibN8fZwAgIFA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=E+Wy2cEE;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=biOFgqye;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC7A2606A335
	for <stable@vger.kernel.org>; Fri, 27 Nov 2026 12:06:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AC7A2606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=E+Wy2cEE;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=biOFgqye
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ARApMp7273519
	for <stable@vger.kernel.org>; Fri, 27 Nov 2026 12:06:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=FELi3FLt/Pi/OkzOMRJ8+hRR
	lAJ733i1PeWjERVJCog=; b=E+Wy2cEEGp8cp9ec8ULDVVwt6zaET6LAMFhORq3/
	yfd67peeBurtHEtZgo52TiKmrOvoe6BVCBInWBPoKwApmXdisvXsEXYYW6rq/jMd
	kx6KQKyWZnD02QTRElFZgRnP5ubMkMFDepJawLPNrPemza5H4qunjxIvs8J/59Y3
	bTftW9LSA4ftxYqXvm3c74OQ1dXzYWD+RX6Wn7Yje1lCIjZX3rSvdpkRArqYump4
	Q1qnk5H6VHzoVwyM79CYICdIpcoQRlH3QrSWDtEsRfqnV7qX+nAnvC6olcMMJyCN
	JNe/jbVgU7HxNAf1lB0u4HwNHavdJFz5g7BQF42HHSvS8g==
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com [209.85.221.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j6u49aw3n-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 27 Nov 2026 12:06:31 +0000 (GMT)
Received: by mail-vk1-f198.google.com with SMTP id 71dfb90a1353d-5ece5510b79so5259500e0c.1
        for <stable@vger.kernel.org>; Fri, 27 Nov 2026 04:06:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795781191; x=1796385991; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=FELi3FLt/Pi/OkzOMRJ8+hRRlAJ733i1PeWjERVJCog=;
        b=biOFgqyes6rdNtNL+EX3DLscZYqZEeElPupO9KqIN7mhBjdQ0Civ8C/Z/pDlNh3t+5
         0N/tAfVB1UFbQ9jjBPlP4zD30tOh/zkzH3usDaNhUvDL5qOgwfkDVGMLcSaR8pMP7sKV
         LlVSbndPqSOkyx3Pbtd51wEsJKG3KsrlepRWXMN7GWSFFSur9sKFYt34Hud2MfW2xVac
         afBwZDFTq+oR87Px8Pv2hFQG9/m8O0fjE8EbJLo689ZsuGAtwa7uE69Av2tVD/0YowBg
         e4RHKYMO7rnkkjlyesEMqnEoHa/yrWJeOM4paMYrM3crgGkEUtQk1z7BvMHleHOSyj8x
         jPQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795781191; x=1796385991;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FELi3FLt/Pi/OkzOMRJ8+hRRlAJ733i1PeWjERVJCog=;
        b=VYvmFrc/Ha0Uxzg1NyqNl2EuOEXM9zsKkCNxzk9mNrFGZ6Tcsfdm4d7xwvGpj0QiZL
         WEul3IbgzE/AMDCCIo6fufi57uDsHDIvkivzlDUXewLSgh1BD/fPLTBtSPr4MaxH/rp9
         oS2psc/Kx38HT5EhalnoDigNfowKGiXpAW6ls/u6DDUBsG2f5iwyH+1eh8eUFd+HZkuI
         IowUddB+8+OiBUZY63Q5s7MYwp+vOphC1/LIfr47+XXeV7Zxnr1NI754ARuQ66rknNPh
         InwJcYGj136AzlJyNwxlje//x834sj4OaDEMx4FPjcM2pR+CXeAkQGdvekbqJTzdjavr
         Rt7A==
X-Forwarded-Encrypted: i=1; AL+hErHp7hEgh21tcwbgdopX/ksxoVFPc0tibBgdwV3P7lhDZoFnn/kd+GjJyBONfk82szZQkJoDloY=@vger.kernel.org
X-Gm-Message-State: APuU4Z/KDMjcq3OckR7DySiWTocMo56vntPif1NhjX9pia8oHHrHt5Ih
	9yEvMMh+cB4OlJlW+0YMjVa8aBfUSDttzrRRhnw+UrKnPr3F6cA0qJnpqJlQGoh83685k4Cny2q
	nC3gi7HwOCTugMsfSbiH8DqeOUVF3rpuU42TwzrUOqt/4M1e9z6DVa6CGMFZsKE4CmDC5VQ==
X-Gm-Gg: AZFdTZdLUikWQeMZUHezKIHzxBWv4LI1yIKDDQMQ+9XtCVFPGSu9D/tWKnbfrnxsNsY
	ThJVcvn9rQAmyqBrZaeb53RzgLkLEN+5ReEcBzOlV7kSEAxbiQMv/sN2w0bVbCgkB8F2EyVKMGT
	wvHWbgCwwXeldGg9Dr9RWrg1PHb57nlR8cdW+9KkyIe/VKvsLfFq3lS5JAmXvqUV/vyUHMCN9OB
	CjJ532KTU9++TNI2XZ/4Rp7iqTAkRqCMy9wmYipNbVAQGi7pEJauceLJXfg3c5apXoGBomy80DX
	ePt61spk5P+Ycqvya88eVjRU6DUcw2Ne5hzB2rV4+/BMFoZ53+z1ttguyii+UylGiq+cj2mu4+0
	vxnNsaNGSPZ5wj3JVfMN45DT+laMuWz0ULEFrfKojBWT9uknupS2eXdVbMlWPWDGxZztYta2omI
	6CH4x37YNHR/zYDOmvoeWjxpCyn8gC9rdPsYEHXU0WSAZfJL3sxZY0+4WkRQYiaA==
X-Received: by 2002:a05:6122:32c8:b0:5eb:7686:48f5 with SMTP id 71dfb90a1353d-5ee8af0af4bmr14128019e0c.8.1795781190765;
        Fri, 27 Nov 2026 04:06:30 -0800 (PST)
X-Received: by 2002:a05:6122:32c8:b0:5eb:7686:48f5 with SMTP id 71dfb90a1353d-5ee8af0af4bmr14127954e0c.8.1795781190044;
        Fri, 27 Nov 2026 04:06:30 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5c1bd04451csm5860852e87.59.2026.11.27.04.06.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 04:06:28 -0800 (PST)
Date: Fri, 27 Nov 2026 14:06:27 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Michael Burch <me@michaelburch.net>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Jun Nie <jun.nie@linaro.org>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] drm/msm/dpu: count the pending frame before kicking
 it off
Message-ID: <kcjghu2lpoijzanqtdvd3zid6g4onyesvsouqnehepo6q7liws@af36abycxzzh>
References: <20261013172703.12273-1-me@michaelburch.net>
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
In-Reply-To: <20261013172703.12273-1-me@michaelburch.net>
X-Proofpoint-GUID: AKvQIwlfcnVe1tzH0kJaE5ZJ-CvPHUKp
X-Proofpoint-ORIG-GUID: AKvQIwlfcnVe1tzH0kJaE5ZJ-CvPHUKp
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI3MDA0OCBTYWx0ZWRfX7aUdjnWwkLe5
 0K23g5FwiSpjFiHxP+/x+JLU1oKH7PBr2rU51rpEtq0p8E9DbfeulAI8bwNGGXjgDk/2qB+QJ6K
 Fgax3EuK6ONCy9hgs3msaLIqflyML1I=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI3MDA0OCBTYWx0ZWRfX052SrpEvVsB8
 T8tNBAzNJiaOUg2IUvVzL84hZNsNOehqEtDuQc+WKurqw1lXWhtELql7vbfzrSB6oGgaODkCIra
 HyW90Jxm2myByL5+dDPzCaMPO1sKfhnc9Ef36n8tSMDLx2rHQMvJU0YsOB5GLedhjfkXfgManBP
 hF5QLbPoPrbbMqtf/F941/SHSmjMqBZbjzXymbYBGFO8GMIlzWe9/s2YMz+PMsHavc3dFyM8CZq
 FtGmrolSqg2wROsFBSkxULFLlxX7Z7YIHjWuo8z4o8cRxHs7WIXJy48Ko9xPz0LFiGROJG3Gd2w
 DCWc+ZQ4S0+NJV7Gm1cawJxv8wDMsKPWNCPUfAiTdy8rCP2SdB5f1MicK6O6wGi/NUhFTW20Ehc
 dH3Kl07SEgzUg4ZglD16NWJuUCYJ88V8yp1xcYwDBwaOTst1pv/JZG9kjaBiqkX8r0BidkDUo/E
 gDhtbaAXFlhlRe0ziuw==
X-Authority-Analysis: v=2.4 cv=A875rKWG c=1 sm=1 tr=0 ts=6b097247 cx=c_pps
 a=1Os3MKEOqt8YzSjcPV0cFA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=VwQbUJbxAAAA:8
 a=OZ7Xlw-yAAAA:8 a=EUspDBNiAAAA:8 a=o7I13pbtrd0snOxpb2YA:9 a=CjuIK1q_8ugA:10
 a=hhpmQAJR8DioWGSBphRh:22 a=qwMvOfr3u-Fs83Rmfh-C:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-27_02,2026-11-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0
 priorityscore=1501 adultscore=0 clxscore=1015 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611270048

On Tue, Oct 13, 2026 at 12:27:00PM -0500, Michael Burch wrote:
> dpu_crtc_commit_kickoff() increments frame_pending only after
> dpu_encoder_kickoff() has sent the frame to the hardware. If the frame
> completes before the increment, dpu_crtc_frame_event_work() sees
> frame_pending == 0 and ignores the frame-done event. The increment that
> follows is never matched, so the count stays one too high until
> dpu_crtc_disable() resets it.
> 
> With frame_pending stuck at 1 or more:
> 
> - dpu_encoder_resource_control(FRAME_DONE) sees a pending count above 1
>   on every frame and never queues delayed_off_work. A video-mode encoder
>   therefore never reaches ENTER_IDLE and keeps its vsync interrupt
>   registered for as long as the display is on.
> - dpu_crtc_frame_event_work() never sees the count drop to zero, so
>   dpu_core_perf_crtc_release_bw() is never called.
> 
> On an X1E80100 laptop with a 120 Hz eDP panel this left the vsync
> interrupt firing 120 times a second on an idle desktop: 14,407 vblank
> callbacks against 21 commits in 120 s, with no vblank events requested
> by userspace. Every frame-done took the frame_event_more_pending path
> (591 of 591 in one trace) and the encoder never entered idle. After a
> suspend cycle reset the count, the same desktop showed 3 commits, 3
> frame_event_done, 3 encoder idle transitions and 25 MDSS interrupts in
> 60 s.
> 
> Until commit ad06972d5365 ("drm/msm/dpu: Reorder encoder kickoff for
> CWB") the increment came before the kickoff. Move it back: count the
> frame in each kickoff path just before its encoders are kicked off. A
> clone-mode commit that fails its encoder lookup is then never counted.
> 
> Fixes: ad06972d5365 ("drm/msm/dpu: Reorder encoder kickoff for CWB")
> Cc: stable@vger.kernel.org
> Assisted-by: Copilot:claude-opus-5.5
> Signed-off-by: Michael Burch <me@michaelburch.net>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
