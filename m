Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FC361A9F97
	for <stable@vger.kernel.org>; Sat,  3 Oct 2026 00:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790988431; cv=none; b=AHylviiW41unm9h1V+WWKN2/44W5u8AOkMW9LrZy0IctqXJ97w4I0LhxBZnfTawTJjzhMNtfnutTQwDzPcUvcnvDKAMWC6ckKX8a7vuc8U8wVMYRRcLXeCLlDdkGD9G5aLIr7zr/mggZbIQobpBlYUdnmiuvZGa6cUvtRd3mOkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790988431; c=relaxed/simple;
	bh=33LME4hv75+NsrUKSNfoFPL28+UrDXNe+o4qJIbYyI0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iI7I82alj+YSgoeLjhyBl/VngLfe+9+rsWymtc4/33YJBxFcv8SS/1I/oOWJ8Qt2zOVXHGqBnxi6VLI85mhIwOOM00/6L9KBFtsIjGJ9EUt8D4LoKZFATOaGAmBh3y602bZzbO2rG3SHcRiYdgVmwieJDzkignhjh/5u669CzAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kmrw37eX; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=GIpWmVTg; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kmrw37eX";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GIpWmVTg"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 692NeYQG2502322
	for <stable@vger.kernel.org>; Sat, 3 Oct 2026 00:46:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	vL80ugemMWRtDW2vSlsMcf7Zak5YaCa9SLUyIJHsouA=; b=kmrw37eXy6VLn1HD
	URi+EdBB8WmglvmupkKmMxCWNA5OLkEKOXkvIXotgZYpg282D240xBs94RCdc974
	+VCcU4VejxVLmFMb706Aipp7a1A6uIlDbBrVoxWhdIJCQiPu4wi44Up4o7RtbIH1
	roFj5H2qYpGqftRQJQNhGCdlXloN3y1AgWD16cRofo3mtz3ayzwovEG2ujT7VM32
	Gi/BGSp1hSckfrJ3aYOnXmawmpWEur88eR0P3aZ5nbpwn3l2lzKPEo0HB/b0ZJNa
	/rPFjwIJIUPVgN70CjjHtLuQcb/9sHJ0Ce3TPGppM0SIL3uDGn6KMNISs1y1Jm7V
	lJN2WQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h2ft8st5a-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Sat, 03 Oct 2026 00:46:58 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-93c58ee2116so27152285a.3
        for <stable@vger.kernel.org>; Fri, 02 Oct 2026 17:46:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790988417; x=1791593217; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vL80ugemMWRtDW2vSlsMcf7Zak5YaCa9SLUyIJHsouA=;
        b=GIpWmVTgv7jAW1NzVBVKeSmFwx1AtCPEF2MfCtovYnH4DyREM+0tVWRzfbOFA4os8X
         9+Tzr5znna94zXs+NhK0zAeyJFw49cbu0Um4FwMJfqWj9m4G0HQb56uZyOZlEUgtlMN2
         HEqDg/hFRgQhWKHZjDF92F4Eh6rzndt0KzRGdQ1RSivVkfBky5BCiHy6/uhslKoFeU70
         16zavlK0K8R4snEmj5gzIDcdB6V5mMhalWgluo/AOrwEP/VteCdtUq+467X89wbWHNmY
         LYcmHPmXmmVKvD9y1GbNKbzo9ve/fKsMD1EFHBgpRPGcLPQOYTijXLq5TWMM6oVuNjSt
         klCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790988417; x=1791593217;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vL80ugemMWRtDW2vSlsMcf7Zak5YaCa9SLUyIJHsouA=;
        b=qsnfg11iYaYXFjFM0WW1z49G3h+K8OyFDk4LxKvHZ52b+D1FaH6o2Fi8QpeliFezCe
         qrn+c/ikE4pHkJqM1y+aQPX6xTM7JjAHVnfZVqLyflXyfqlZmiIfu0RHdvJdxkwEsG7d
         Jpvy+xt5J7K3mbrkHgabkzSE2ORo9GTeO1gQUCm9ltfRQ2RdBWve1mRkybfYev8Xh/d+
         ZRNliind57ye3nzTfdTY6qYAOxIc9WDhTe1cMRRj8J3m311nKoqJtIaazsdB6Mr5V5X6
         SYUOofyDMmIE4XRrwMLb65q2teTXdu0iARg5b2acqiVAAY9j9jTdYXDNpjl/2d7d28eQ
         xiUA==
X-Forwarded-Encrypted: i=1; AKwUvBw6mNjCkeN+ok4bLH2eEEJV9H71+vJQ6w8hXfNxwqVeKB/GiWIASFCXgdk64yfMauOO9UOy6qA=@vger.kernel.org
X-Gm-Message-State: AFuF++lzsR2cn1MYgbwwawX/6U9gcq6FiEPOe9qIUSn3F0VUxe50dXSw
	i28C6pzF5DJOM641csm8dyPKyZXUL+3viPLCUbn/Gvge9kwlKmKEGN4OhHZQQdMWBlIBfz+JaRb
	FZrhIxKSfAalWnXz9wN8vyONIg7Vh7dhfLIL2q9VssDV0nIwLAaRDW9sn540=
X-Gm-Gg: AYBFou04VVQjVrMjowFVRWePFqVIzXDtJK1qOMxCo/8eEfQThJk7CYu8qrmevPnI92Y
	go8IkDVWt3s7nGhRrIzh5zM/lQpGmE1R9j3B5ZVfMThz/yoZKnWTjJJLuyDBs/nmuS/AzLKgYgt
	cEopz8PCIQAcagd3EbR9NxIkCC94FXuP37H3UOIMwAuhPX4hTUiN5IV/0YsVEFim9BzuMSyq0w4
	e+udhxM2CfRt/wFXIWtfISH6tdgaece0GwCSIjvmu6hlIb1BYZV7wLooodqNtn5lJSNcJNqa9te
	TPyATZHXv1x5qvLaaSkXVOF+1/34NjLypUcFkHpCkQ02F+LkUe+0F3QFp/nvrm4tYugOHkLN39b
	37xTYX+vHuBAPi+Jbfmt2UP/VQ1LG4Wr2MjhA+jeWIxrW2h1W4rvrkdsNYGOVkLHt/YvFjbgJ18
	6Al+JSIihRe0Lu
X-Received: by 2002:a05:620a:a18d:10b0:93c:2946:5702 with SMTP id af79cd13be357-93cf1752323mr610228785a.39.1790988417084;
        Fri, 02 Oct 2026 17:46:57 -0700 (PDT)
X-Received: by 2002:a05:620a:a18d:10b0:93c:2946:5702 with SMTP id af79cd13be357-93cf1752323mr610226585a.39.1790988416613;
        Fri, 02 Oct 2026 17:46:56 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5bb7c71911bsm1160748e87.11.2026.10.02.17.46.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 17:46:54 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
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
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, stable@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Abel Vesa <abel.vesa@oss.qualcomm.com>,
        Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH v4 0/7] drm/msm/hdmi: Fixes/Cleanups before Eliza
Date: Sat,  3 Oct 2026 03:46:51 +0300
Message-ID: <179098834081.3641559.14344283439671349892.b4-ty@b4>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260911-drm-msm-hdmi-fixes-before-eliza-v4-0-87bdb9f1987f@oss.qualcomm.com>
References: <20260911-drm-msm-hdmi-fixes-before-eliza-v4-0-87bdb9f1987f@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: zLTo-XZuNHCSae7W0ifmsKb_-Qn2JU0O
X-Proofpoint-GUID: zLTo-XZuNHCSae7W0ifmsKb_-Qn2JU0O
X-Authority-Analysis: v=2.4 cv=c8M+0h9l c=1 sm=1 tr=0 ts=6ac05082 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=bC-a23v3AAAA:8
 a=EUspDBNiAAAA:8 a=e5mUnYsNAAAA:8 a=UAEniXUar9Pip7w0YYAA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22 a=FO4_E8m0qiDe52t0p3_H:22 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAzMDAwMiBTYWx0ZWRfXzLQ3xt1peG/F
 kpG6g5U7ncGEO5bR3R6bSQ7/NUpHyXpuYGOj6H5A1BpL+ZfDu5HfE5+jMne9OlSHdRbrZXUgYyg
 2V0lbSc0HkZmzenvU6MUWgIFkVzzct0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAzMDAwMiBTYWx0ZWRfX3lzcTsUs0Sat
 9UTOR/rPvAVT3rAYdD0eQmEZJIH2TRMoGTXQNm3l/8d0f9jjHAAwYdNTF4i8vu9Tzj9Hhq5mIyC
 wJd2KxSeTDweuIMk7SQcSz8eDdjZoKmz7ea5RFNvoSMriiqd8xQe+cwB878lnkfpG+xW88mGfd6
 jvHUrNmNNJ9SqIQFPGm0un9HgNVNHFspdAMmuDS4DsogePo4sXoMMuTlfWN2q386Yi6pG+GP51j
 S46ppOUG0ajRfUKkFdypVcftIZktjTJ01XcZ/ffFWOBMGUpMyDV91Owc6oMZE2tqnqkqR88FPlf
 M7BiB8JkYisMwXLPYOT9OG25BgezsuO+z+GynxCYGAKWPg1DPdVOmMeOSDODqzRDLUiSqxRD/vb
 35LxVhA7CkNueE6te6agwoSQtjoZtJXUR68P+riTpi2aFLt0H/r4f+kLFqm17PfomBFJ/fuoc2v
 jk2sSGjfQWsg5U5bipw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-02_07,2026-10-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 phishscore=0 clxscore=1015 malwarescore=0
 bulkscore=0 spamscore=0 lowpriorityscore=0 adultscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610030002

On Fri, 11 Sep 2026 12:29:33 +0200, Krzysztof Kozlowski wrote:
> Changes in v4:
> - Fix second name in "Properly handle msm_ioremap() without name"
> - Tags
> - Link to v3: https://patch.msgid.link/20260908-drm-msm-hdmi-fixes-before-eliza-v3-0-dcf8956878ca@oss.qualcomm.com
> 
> Changes in v3:
> - Add missing regulator_bulk_disable() in msm_hdmi_phy_resource_enable()
> - Set hdmi->power_off=false before calling msm_hdmi_audio_update()
> - Link to v2: https://patch.msgid.link/20260907-drm-msm-hdmi-fixes-before-eliza-v2-0-b097cf1eac77@oss.qualcomm.com
> 
> [...]

Applied to ttt, thanks!

[1/7] drm/msm/hdmi_phy: Cleanup after msm_hdmi_phy_resource_enable() failure
      https://gitlab.freedesktop.org/lumag/msm/-/commit/d27f831aaf20
[2/7] drm/msm/hdmi: Handle msm_hdmi_power_on() errors during .atomic_pre_enable()
      https://gitlab.freedesktop.org/lumag/msm/-/commit/dd6ecace5785
[3/7] drm/msm/hdmi_bridge: Correct poweroff/audio cleanup order in post_disable
      https://gitlab.freedesktop.org/lumag/msm/-/commit/0499f0576e44
[4/7] drm/msm/hdmi_bridge: Drop redundant initialization in msm_hdmi_bridge_init()
      https://gitlab.freedesktop.org/lumag/msm/-/commit/07bd8f9379c2
[5/7] drm/msm: Properly handle msm_ioremap() without name
      https://gitlab.freedesktop.org/lumag/msm/-/commit/14fe0ea79e0e
[6/7] drm/msm/dsi: Fix indentation of if block in dsi_mgr_bridge_mode_valid()
      https://gitlab.freedesktop.org/lumag/msm/-/commit/8b7a90dbdfb1
[7/7] dt-bindings: display/msm: hdmi: Correct name of disallowed supplies
      https://gitlab.freedesktop.org/lumag/msm/-/commit/3309f5c88860

Best regards,
-- 
With best wishes
Dmitry


