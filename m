Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4080B265606
	for <stable@vger.kernel.org>; Mon, 14 Sep 2026 00:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789346608; cv=none; b=IL85RN3aecbXLdPfR+fmAo8vKR1lVXgI/M675CXU7arV8Sft660Atmo47FncAKkKx90RRs95SnJ+5kv2QIgbmuzqp1ip0zotWOvI0Y94HIiPJjEb5aqvfs4RHk9QWdDsCapBnCmB/64Ku9da//9SVUvLmpZSIdUp60PeL8qt49A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789346608; c=relaxed/simple;
	bh=g4Sb+4EO6utuPttACpx7esnqjC4tL1wK9PbH7KgaxpI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MbFTpnHfkd4RU7Pa0qjFhw+Hqbh/cT04jmbj+9EqVObSYuSLRzp16Tk9YbjV+VDPvue8eKXVkI2YexXUifuD2XRE6jsSwrvd9ezRylweW1u09eSSKtUmP+A7uIBUNIyet29V9Q92MeeUg5+XjFPWj4KqJNcjCBtkzFxEOWRQKzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bgQfIVCC; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=FoduFFMb; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bgQfIVCC";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FoduFFMb"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68E07Clc3029224
	for <stable@vger.kernel.org>; Mon, 14 Sep 2026 00:43:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=Lj9pFcVapk0XSSP7vk2Ibgx2
	B2uTAyJseO6HX7OHZTQ=; b=bgQfIVCCMV3iD6UZqTIHicnGFEy/PC9xmmStr4hW
	iyC32DhH9LgnCniqdkSEuCp+18iX2NujkqzB1cYtn95L8LVUk38FeprgNUjoEObo
	F1txYgUXb12oxATaUNxoV7SsKqhQbgyAqLs1qnT1eg2kzJEIYOFCvXccLkNm/YRd
	aC3vPCNpJiZbmz1REOfDqdv6wJ42UIKuVkkfm7QFOBiWNYEJThgAh3RD3xHMQdzC
	6Bbuf/rwqlQTj5DOZn+sS4Bt1FFCprFi7kiLdLEx0DvAjUEGldr9FSevg0hvgOpa
	ceQrTpifSKXCoMijz+EzO9JZOtJZtsFbE/l5hG2JPdZYmw==
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com [209.85.222.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gmy9dce8g-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 14 Sep 2026 00:43:25 +0000 (GMT)
Received: by mail-ua1-f70.google.com with SMTP id a1e0cc1a2514c-9806e283b0eso2150559241.3
        for <stable@vger.kernel.org>; Sun, 13 Sep 2026 17:43:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789346605; x=1789951405; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Lj9pFcVapk0XSSP7vk2Ibgx2B2uTAyJseO6HX7OHZTQ=;
        b=FoduFFMb4QvrYTNj3PWf/z6Ap4i/xSOfgjqFI2OM0T6wREgJ8V2SrrRVqo43GfE0T6
         JESM2OW3Gbc9Hzvd6/LJKrXX9L/rQBYWG6n55UdLGkMDYoo3SVbJaVAUMCBEnZP3VvFS
         UeAbPciVsZxkjQX73n3GqxuWFZX3aBm4VDqrCnOgtpjWUrqoA4nP4r7SRperejKEB6or
         B3RVYHtomKjQZAn49Z8Eq62I8/Aes5QfMBB5R+p73wWDCBqeIbAr/LILl/5PtJYe5U6W
         FwGVd2aQ50YghJ1IaZZiOa9byjL2zmG/YENAt7Cu/aU6ArsZmW2GQwuBQP3AbHB/i2to
         JErw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789346605; x=1789951405;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Lj9pFcVapk0XSSP7vk2Ibgx2B2uTAyJseO6HX7OHZTQ=;
        b=ayUC+fOEzqG+xH9H2hsgJBFY6gloAUDpuJw9z0b8XdyUsPVtDha4P/FXsCmNZ2iLNn
         T/DkkkD/67FMZ2aQhFcpWS33MWnv0GYJSYlkR1TFTi9ekDUCZrOCiQP3cDKBSy903Ber
         aqQQSq0wMheWHvJ+dcp/HLNOFDfvxL71U413W+N/AWDowS8ADAnWNe983lGopGSdcIb6
         Vgsgb3RBcYaib0C0I5UqIC1tHKL7T+l0TU448tp4P9VHjT2MzIj08kVjl0metB0/vGCH
         NbdkNjnKdO6HJoyIuTIdHZ2Lho647enY7KHMjro+IN9hz25P3kSVVG8k6haNJSp4eN3k
         SFKQ==
X-Forwarded-Encrypted: i=1; AKwUvBz/WqPGyoJrnr78P+hQ9V79uBOjer2lYVrUAHPj5PiDXQ5dgmQj1x23VK73cgiviMbuNArkNDU=@vger.kernel.org
X-Gm-Message-State: AFuF++kzzjeSmfI0ahkNGbFW9cLMFiztyavyKfiGykpnlFbCGAVOtwyD
	8r6HjbGL8oBB80EFxOBYuhs2O9OT0j+XCZ3YHvRkB2ndJmZxG4Vn872Ry1DQlIuwODA1WhaZZDb
	OKW+Qtar1in+2O1OcxhmshGgdsuRaUvWyZ0+Bi6gS3jf5PVK3ogMamdHgE2c=
X-Gm-Gg: AYBFou0xXNksmEIgMOOJSHKUpFFq3NYH2H+BM9KfkFqM7iGhdipmh1GtQRSB0+yFBUb
	hRc0stvzFLrbfpq8DcpkJ90ZTHB5pCvAdP7E/hYKDv+4pTUMJsgxLxz8kXa26P1/0zQSqiwZkFK
	r/lcsj54mqXJXZNJKUzEl10IzMGl/kRvJ3LKqrmN+rUl8KqnYjOKstp6bnfaOxvQ94YHWcxyKT8
	KlV8T6MjKV0eIr+2vmPra6iTOEnrIS2p4I8fovsdxj/l/pLgLMH7SaM6mA25Dq4tv8ufprWUYnG
	j7M/+vv5IE22xN4VxGYrB+8KcOxSGERYCRa0CZu6ha/KcaDgg1Wz93xLBm4E+bLJU0zBgYiI/pm
	2oBCAiFz/1EOQ6RTy/xBFs12wPnfUua1ZjDvcMeeAuK71VdSr7BQurnZcTOtFdze//hiVkjZ8SH
	neSDQpBk5dYlzG
X-Received: by 2002:a05:6102:a48:b0:79a:1d27:a8ac with SMTP id ada2fe7eead31-79b5878ad50mr144541137.5.1789346604711;
        Sun, 13 Sep 2026 17:43:24 -0700 (PDT)
X-Received: by 2002:a05:6102:a48:b0:79a:1d27:a8ac with SMTP id ada2fe7eead31-79b5878ad50mr144521137.5.1789346604268;
        Sun, 13 Sep 2026 17:43:24 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3a5a3303fc9sm23868501fa.6.2026.09.13.17.43.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Sep 2026 17:43:23 -0700 (PDT)
Date: Mon, 14 Sep 2026 03:43:21 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Archit Taneja <architt@codeaurora.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH v4 2/7] drm/msm/hdmi: Handle msm_hdmi_power_on() errors
 during .atomic_pre_enable()
Message-ID: <udst66v6mxlbugyqehsrluvf3nvuw34plt7fzj75wwzrwgev6m@wzyiuexzeu4o>
References: <20260911-drm-msm-hdmi-fixes-before-eliza-v4-0-87bdb9f1987f@oss.qualcomm.com>
 <20260911-drm-msm-hdmi-fixes-before-eliza-v4-2-87bdb9f1987f@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260911-drm-msm-hdmi-fixes-before-eliza-v4-2-87bdb9f1987f@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE0MDAwNiBTYWx0ZWRfX5vFLQ1M5deI9
 VFdIoleHfO4Cxs3O4JqHqTO7f24XpD+00KnjPihjvnuiBQaoRxNpkoG/GvtLqYzgx73WdV8baXY
 AI+MpqycI5ddAqmH9QTRaeovEONjMBIR+UkiZM0c1inJIetRLPIRGYc+yXwHzgdUgfBdUtjwVKJ
 RKBh9ce58KGmCHIbEuHwCIXMIHjT3mJcjn07N6+oYb51kKp8WfIrDAmbUZRQ+BcHYiPVMyi8Uj2
 GApFWl1Fckxd10ZnVRCuHt+7whgNTpVCgT36/LcwaSfB5CtnkT5CRkt2XNoC/mD86pbYJLPVaV6
 YnRRKh/VjYmf2umWwWuwmGl1aHcKJETBUxrhslpTNiznTyFwRDdO5BhG9/s/pqLlhn+qQqfdPRk
 iMG/9HWft8KLCs8mqahUHnLKl6JSH/8+jmvfz1VKADugxEvNgogOtm83KKU9+kFTig68ylNCnm3
 tvscN1EUoOHGdv2uM6A==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE0MDAwNiBTYWx0ZWRfX7/wjGJIkQsb8
 risVHh0qPInIWdwCC05iFR71U3s0mcoUiGI5qMOUuu/foqqB78dIEFYVMSjZ4EsNLuXNeOLC170
 HI85PA1VngFhRoI9UidQZr6/W1fqTuE=
X-Proofpoint-GUID: EAJfeshYSrt-dG2svRuqtPqG-__-OWWR
X-Authority-Analysis: v=2.4 cv=OeUNnRTY c=1 sm=1 tr=0 ts=6aa7432d cx=c_pps
 a=R6oCqFB+Yf/t2GF8e0/dFg==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=yaZh0le1K7A__2Wy8xAA:9 a=CjuIK1q_8ugA:10 a=zZCYzV9kfG8A:10
 a=TD8TdBvy0hsOASGTdmB-:22
X-Proofpoint-ORIG-GUID: EAJfeshYSrt-dG2svRuqtPqG-__-OWWR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-13_08,2026-09-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 phishscore=0 bulkscore=0 spamscore=0
 priorityscore=1501 suspectscore=0 impostorscore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609140006

On Fri, Sep 11, 2026 at 12:29:35PM +0200, Krzysztof Kozlowski wrote:
> Properly handle power up failures during .atomic_pre_enable() by
> aborting the .atomic_pre_enable() to avoid accessing registers why
> blocks did not bring up.  Otherwise this could lead to imprecise aborts
> when accessing MMIO while entire power domain is off.
> 
> Cc: <stable@vger.kernel.org>
> Fixes: ba3d7bf3a7ab ("drm/msm/hdmi: Convert PHY files according to new design")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/hdmi/hdmi_bridge.c | 30 +++++++++++++++++++++---------
>  1 file changed, 21 insertions(+), 9 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
