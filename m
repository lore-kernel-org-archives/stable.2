Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B6E339D6E8
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 07:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788851467; cv=none; b=tNaT4f99Pb4NfIoUmPFnk2vZk8bV2uICvOXPcvsB0TWbsjEQbYCkQhfbwq5M2UkJMg6zKLwKw3L8fuEFRvtcrSyrMOvR1cD6sxE4Ce+OVGScgCXxagCrTVGmZpr2vEUBFV/r3WP91MVpBk+WOcH9yDu3LK59P55p1nSrVDvjsjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788851467; c=relaxed/simple;
	bh=NIsM6HvCeVJ35nWFFLJNWwCPf0RLm8el3fb5T4Hse0k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AzQVSr67GyedmFSHW1qiNrTfYAJ8p0fCCDvIOjOJ5+K6neZYkybFCZ8Sa+WahmAXDbWjnxThwFwns9QnOMvtI7qCU5gQRCB1B9GX65/1FOIBtA8TDPrEi6+/yRAS9IgWIUA2Oa5YteJgNl60qiEBA67cuax4x79TMecgkwz5+sA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=A8Xz7Zdy; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=h46C9GOJ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="A8Xz7Zdy";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="h46C9GOJ"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6886Lmwu2502326
	for <stable@vger.kernel.org>; Tue, 8 Sep 2026 07:11:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	q2zFzzLUBztHpAlThCWGXoxQohXTYyYKFSjILxdt7DI=; b=A8Xz7ZdyAkeaAwLJ
	6UJTfNONpzJAFMrh8KS8KVLccPftP/jj9BYeLN6w3C5lLW+yU05kyDq2M+Q2x7HA
	wffZqzsPYWTHg6fBicjTyFwQh8ptakbow0VCAy/m8ElHElu/jX1xtOrqY9Ql2lHn
	DELf51Il/pj2k2HTv9VCHUnK0tpHJ97HLJj36obqum6KySg/QhMyM2S4Vg0isEY3
	whyaf5Q71MJN44Z6U0Hm9LVRk0PLMaGo9oDs0fxiP1v6tsth7TF/jS1jHjkYMNzi
	amB6BKRO5jkeFlr56FacfVCHu4kabvoklPzO0X8HOmICs3iFkmMuiIQkWFjupB0+
	pSFm/A==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gjcv7g8p4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 08 Sep 2026 07:11:04 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-92e53b8a302so795143985a.1
        for <stable@vger.kernel.org>; Tue, 08 Sep 2026 00:11:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788851463; x=1789456263; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=q2zFzzLUBztHpAlThCWGXoxQohXTYyYKFSjILxdt7DI=;
        b=h46C9GOJKkGWjaSd8SU2dUE70+ltaQAm5IjTPG+F1Zcc1AljTnO9Nl1aVCBWmOdKJ8
         cCn2LUxWECYMu89Auej1iTLXibJzXHVK3hCvwvhIvwga9E614x7Q1uX2B2k7PdxfmzPL
         DfyYyRKeeDhpky6BIoGqzI5Rlmpy8U0ASm1jwk2VIvobJ22pBrvp+SVSiPTZPRrrEJAb
         93Ua9rfk+ajLI/Was9U587M4kvN6nTYxTwUamM8pUzzSFZE0FDBsaIaz05VijVLYxgpN
         InEG7RktySbWtxpjJpCYQye2/Eqiywp1ewwWt/9ZPO1nB7jG6R2wir3k2Qi/mVRzQHps
         l3lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788851463; x=1789456263;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=q2zFzzLUBztHpAlThCWGXoxQohXTYyYKFSjILxdt7DI=;
        b=qEYnPUQFYj4o/ZJFfvvCX+oJD2a2Qt1jR+rt/N7knZBCKgQvffTfGuPsH1//o29X8X
         rtySCAQJi9fbiT2cUXeJ0lISPhQjjRDjK9UWlW5ai6Yl7lCavtUh7Q6FDpJoXM6L9hts
         bfkvNRcOMG0HoxrrRkXiWQ3xmZF6WWTpd9iuZUDlzAoov/q1ggoNCIXIPY7NLW4amJ8m
         eWucgTg40dICniOoq2Mu/RwOy+EPQXiusmvifEMKoi7u07lI4v60KSQoWynX9J2Ux3ZY
         H+0b6X8cW/S1cf/nRKcfdkJixTTGQDUlAaHHfMydvemJ3cGkZssrBJJ7cac7PByu8ux+
         sJEQ==
X-Forwarded-Encrypted: i=1; AKwUvBy1328rQM7gjNtMu5Ixt5GzdPpyzfPQTZUIN1geGM7T0etPH8shhYYlVGE4H+monBhHHG14FlM=@vger.kernel.org
X-Gm-Message-State: AFuF++nIAKNA2W3OagwK1ZPE9tEjTtz8moVWWcXVFfdMBke140pL16WC
	1f7gMZemdSj/d1AJJafB9IFbM1fGNpeauPYMsyk6TgkNUpGaQRP7HePfPsSjEkfVBypyzxaDVo6
	heJHEBoXiOhgsaQBWA0EyCIedcbkSPboSablXVlV1+Sy4YaOxjOnyuFxcKHw=
X-Gm-Gg: AYBFou2NQWKBsTRUTBYRvAFKNc+V+JR+LrKVoHiLr0nXd0YDJuYxBFrbWABRNVR3qb9
	AzjjRNdidaveAyGHta1Ib4WBVmthcHiFlzTfNz7gzltBz+l4jBIwP68TCwLwS/xZ09UxND2vB2d
	FkndRqIvNN4/eP/UxUZ20albb8VX3Afs8qBNQ2QEN2Dfrx6oyUc7lMVS67a+IJgJwPG/oEI1UC7
	FTVhfC24fj+9E9ChGA8s6qVfG6pySsKF646Ax5VDjKSB3TIzTFGJhd9iJpoLO68WzV3dBufuT4E
	WlZ8VBpvtCeZoH+17H+X36yMPB2CLnjeo0w5YoKfncLAegZx3Idr9fnPVyFlZnhBkxaKsVxW1Eg
	Hv/xPlmSgNvmAUnIuwhLHfsc=
X-Received: by 2002:a05:620a:3941:b0:939:c0b3:6d8e with SMTP id af79cd13be357-939c0b37c88mr163059585a.30.1788851463487;
        Tue, 08 Sep 2026 00:11:03 -0700 (PDT)
X-Received: by 2002:a05:620a:3941:b0:939:c0b3:6d8e with SMTP id af79cd13be357-939c0b37c88mr163053785a.30.1788851463045;
        Tue, 08 Sep 2026 00:11:03 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.214])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49ce5927b68sm453173805e9.1.2026.09.08.00.11.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 00:11:02 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Date: Tue, 08 Sep 2026 09:10:43 +0200
Subject: [PATCH v3 3/7] drm/msm/hdmi_bridge: Correct poweroff/audio cleanup
 order in post_disable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260908-drm-msm-hdmi-fixes-before-eliza-v3-3-dcf8956878ca@oss.qualcomm.com>
References: <20260908-drm-msm-hdmi-fixes-before-eliza-v3-0-dcf8956878ca@oss.qualcomm.com>
In-Reply-To: <20260908-drm-msm-hdmi-fixes-before-eliza-v3-0-dcf8956878ca@oss.qualcomm.com>
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
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, stable@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1240;
 i=krzysztof.kozlowski@oss.qualcomm.com; h=from:subject:message-id;
 bh=NIsM6HvCeVJ35nWFFLJNWwCPf0RLm8el3fb5T4Hse0k=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBqn7T5bK0YomfryI+UZIU9Qa8Ma7aQK72X//AJY
 Ac8FAPhtiCJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCap+0+QAKCRDBN2bmhouD
 11jbD/oC1+H811NF0TnKCwrr0Pqpxtgsk21hz36/GUYUtCUHvz7fDXG8dmh7218pz2qYSqvoC88
 Fs0i81yoVdKcsd0TNM6v5wPYMk7ec2+scAC7KgIrxiupAFdnOpTHSLaGrg4HdnkHEZSKAkk8uoI
 XptY651pioNBvNz4rmjACNZU2Np44zer8aWXSlGtz5vde/AuYtqDAkHL//3d5Ql3NVjfzWm1rUH
 YIVqzbexMaV/wvamlkAtxr7J+2/el42mgj4PTMLMObB4peGbMpecUXzOtXtadDO8Y/AXMiwiSVX
 Y8nIO/GTvvtkIwc0MJseXE46JbLdt8gQngmADmIABFpJ4JRoa8zZJm+G/1gRVXxauruqgfmyTZh
 gj50iQGe+1Fvl+2vQ6KZ6L9fzJLmoCnrxRu9wAgDAcxeZWrjcW8FiUczqNBffcDrvymBAcjmSe7
 cMXARBgZdeiu36dNcnfIOXDRftZ41cDfZtsgl/UTGDhq7KHPIKytwwthb4GCepicVpY8Dfne6n+
 NoCD9oQCo02I2YO6Cqo6YEdIZIjhhC57rOmqcyuthO41K73DK7R0Oyk66aXdRuRLqSt89i45NUj
 2b9t/EAon0M/ik/1j4fqZBCedG1Y8BVikzqZCjMBLmzrXdGS6V+QegloQXByLPIDHn+P8CIAnxD
 4eAOjPmEhxoWy4g==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
X-Authority-Analysis: v=2.4 cv=CMEamxrD c=1 sm=1 tr=0 ts=6a9fb508 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=+bKQE0WJfmhK2875HamI0Q==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=agfB2vzvzBSRJA4gfngA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA4MDA3MiBTYWx0ZWRfX4ZqBbgqfwwVt
 5DIJbpfnE/Gg84T2Tutnxnf3bunJ9ONteeTYpwdO6yoLdsNspkhcOMAbpNUtfXxlK++rUz2kYzE
 nZZOQPFuFr4tJdroNOuHukREd1a4Jno=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA4MDA3MiBTYWx0ZWRfX+P08lUtangx4
 t1TGekTTZs4IkqmOuq6bPYpTV+1UCvLp9kZoAxE6W7SZD6jPuOiocbZEUsPO5qB2d7dWAS5kmX2
 Q3f2zMx/zJ7Mb00iGLYl/Hx7qixWpDWP+hVJv9sqfO4r3bt0xTMEQG8ISG/rXZeBGzrBrv3DjIW
 pFemnZPaCtFhSJI4BOnXtxavBLrDJaIeX+j5FWfrBspwYj8ZnM9p6XxgLMWm9CMlObezgo2GtDC
 pH6f2PbpnYdRPkJYwcCJadDOUZRYk+ZKBj/ej+GUXQe1kROlSX/+I91N5TJqdH7xcTjNDvRtEAR
 TFem4T8Cx97xpMUnutsHkyMJdqEqhvjKVgL5hH5OEwwuRg70HW1FFedFghzpdwNvvkNiCdmo8uL
 9MsqOPlpY4m4+NwH17clqeALW1RgqiSwKVGWbO4ePc/Tr8qYrMxbrsBlcL+SN6hYsMGSOeZMfnU
 MHMkuiq/IPhx1xx4Ugg==
X-Proofpoint-ORIG-GUID: 9RSw9Nn-5PFkxa_Z-zya6VqHl9JXBLlt
X-Proofpoint-GUID: 9RSw9Nn-5PFkxa_Z-zya6VqHl9JXBLlt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_01,2026-09-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 clxscore=1015 priorityscore=1501 bulkscore=0
 spamscore=0 suspectscore=0 adultscore=0 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609080072

Turning off the power in msm_hdmi_bridge_atomic_post_disable() should
follow reverse order of powering up, not only because it is logical, but
also because msm_hdmi_audio_update() accesses registers thus block
should still be powered on.

Depending on specific timing, existing code could have accesses to MMIO
of powered off block.

Cc: <stable@vger.kernel.org>
Fixes: c0c0d9eeeb8d ("drm/msm: hdmi audio support")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/hdmi/hdmi_bridge.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/hdmi/hdmi_bridge.c b/drivers/gpu/drm/msm/hdmi/hdmi_bridge.c
index db85400e574e..1860605850c9 100644
--- a/drivers/gpu/drm/msm/hdmi/hdmi_bridge.c
+++ b/drivers/gpu/drm/msm/hdmi/hdmi_bridge.c
@@ -339,10 +339,10 @@ static void msm_hdmi_bridge_atomic_post_disable(struct drm_bridge *bridge,
 	msm_hdmi_phy_powerdown(phy);
 
 	if (hdmi->power_on) {
-		power_off(bridge);
 		hdmi->power_on = false;
 		if (hdmi->connector->display_info.is_hdmi)
 			msm_hdmi_audio_update(hdmi);
+		power_off(bridge);
 		msm_hdmi_phy_resource_disable(phy);
 	}
 	mutex_unlock(&hdmi->state_mutex);

-- 
2.53.0

