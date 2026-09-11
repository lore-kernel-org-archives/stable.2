Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58D93351C1C
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 10:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789122598; cv=none; b=jqNZfGFf9tHqBUZb6u9Rkdlg7EloD8U2tJFhqQnrTHMEZpUgmoPKXWARsJCTJ1th2pXpzWROzpAG6ok2nOyghg6z5544DAZPObnTWUahbdVWRReL/BgHDIqhIah78qt8iEOFohX6TnN+0aSKeAxeo+gmx3PwS1HkJDlMoVKzMU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789122598; c=relaxed/simple;
	bh=XH66GnTgugpnLWEqmx30iK26F7dqgoZ1zE1rBdQ5ZS8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZGjxMB6Zwv8jmWCGt2N+TxCqtNuuk972WUlImfNhZD5t767o/N2jx5cW8YUAPchp85Hh4C+bGH/rA9QeCqV5/KadBZ37a6HeNvyiJbIh8kf7Q723XsCuzEUG07sCi4EpR7HxC4MB0qXrbaw1LKaBlshy4LYhtlQ5GsZt68rFG1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CSMZJ8lR; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Wjy+NXJO; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CSMZJ8lR";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Wjy+NXJO"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68B9mWvs3292256
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 10:29:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	FSrRHRs+USEOkCNabKEpUzOvaX+AzMaMbvbk8haZkZI=; b=CSMZJ8lRNYF1d4T7
	b4DjaqBMCmjhAQ37Z4kw9QixzrdDa0KAJ55mssNCmxs7JVhCr9WRHeNvQWGfFQMP
	RXyip6GlhwYIMbE46SvRI7QQoH5VABVivDtq6zNnP4wBVmQKRfyYC9XhiwSGk+QB
	v1p+Q42/u9baFXLSz08tA7zW7ebs3UQaNCKY91HEQMcuqePCEighyX7Qg+zf/DHM
	vqVyImfaOcqbrSoQhuHQNEZwIJIf09Rdj68WdnRTicrbthUNrD7sbddEsvrJviId
	yOPKSIOS03GVGPOV0rIWl5ydPSf+I7wNVe0GidunuC2nn0O8i7h4cJMhRt27+9q4
	cwDw7Q==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gmfbbg50n-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 10:29:56 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-939a6937513so97726485a.3
        for <stable@vger.kernel.org>; Fri, 11 Sep 2026 03:29:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789122595; x=1789727395; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FSrRHRs+USEOkCNabKEpUzOvaX+AzMaMbvbk8haZkZI=;
        b=Wjy+NXJOCi/Qri551Hn/1msrCcBgfCUGS7bfMzXFhNIBAxwO21P/RnVqeo09yiFdX3
         OC/3YzcNpti9RER/G8mbKjEoNHJBoi83wiW9o1OOQ1LaICyj3UQCICPlROq/pQ+dTF56
         rnun056hbB5Q62iN8dsrKv+/7sAm22DA/f1BjP69D95yHws/DBxP6Y1toEgoTopPMYzf
         aKd/gEE8F4tKqNiMNbC4D5rfO+9wxNZ7RZYRkaH1fkgzwDKaKm5hbwh35rFVFd/nh9Pz
         AV5/hkwHElCJis+KxvL9VAdbx2M4iqOTFhLoqAe/TL4liZ+IHjTWKPiwp4twBkxNTsUJ
         tZEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789122595; x=1789727395;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FSrRHRs+USEOkCNabKEpUzOvaX+AzMaMbvbk8haZkZI=;
        b=ESwb6wikWu4+97A5EGpb9iUcajSfIpk3ELsSWvXteEZoMloY81ll8irzUU6EclQ0Dh
         z2mKRvipXo1aYGrFPEWddp+pkxFMzAGtFbehkh0BMYCW+2t8DfO4q1VEQBj20w/0oRVy
         GqsapgiB+da092cJJ9zUt5yST5XfeRs761yoU0ffT7A6y9+vavJsMMQhOYWAVQHFzSKZ
         W88axxyaJDCFSizu9abSebfIudfTPrEvLF+rCegVXWt16bNuvSaAKYObWnoEyGiDgeqc
         uJF4XVoRuZlqhuNr1RAjbEig1NdSWgD0xDMk6bUp8EV/RoGzwDRpG2zboDIHpBx/MIJ3
         xJOA==
X-Forwarded-Encrypted: i=1; AKwUvBxF+4aFqLRzgsJZKKiiJf4qTapkmbONOAcdSPP8tS+nOjH2CAbx5CPuy9uewoTXSdSifohDReo=@vger.kernel.org
X-Gm-Message-State: AFuF++liAjWzVpddA4r0LDkj9rZLTysUs4WbgotIa38oZyQKblZrjRDl
	gEb/kdGdZpcJosWh7azvhvSgvya+zEGCtgX/+ZV/SE0vvhDC1EAcjROXQNEJ4PvmsWhBCtxIAnO
	r4qhxdf/qWhRSGymCQpVxXcXLJd7yv+G081eo7toV9nXimyb1SaM4GclICbg=
X-Gm-Gg: AYBFou3I/SJZqxwSHUDHIRpZyyW9fSmGc7OTZJNiSdFcoV2ZNwZOrnoDbi7r250ImXF
	FeL67rwxeJdeMQeskGO8BrdhS3dnq9jHyTktBqgYGiF6B1hy5AqY1nCyfggYF5ajonS3LrMvhAd
	siMLwUSoiPWeji6mnMCA837I3Z4lvh18TioTGWjmA/V5qXWX69peCMXHvv63WjsgPOtfa805MBH
	DwBZnWT2Nl/yWblNjAlqxVQ2jK06+nqxtcs2KIzZyrcU8F11fpPYU0SKcabif6fwpscUVQLPTYD
	xT58wtj2XbZ8knzYp0aB7u+LVojU3bFpQeQ0DVIVjSNqgIk9BFeZCMv+nrAgYloMxKU6FXOvLdX
	9mtoefLgD+7jmiSCzhSoTlo0=
X-Received: by 2002:a05:620a:43a9:b0:936:623e:2603 with SMTP id af79cd13be357-939ea06ff04mr392335585a.17.1789122595387;
        Fri, 11 Sep 2026 03:29:55 -0700 (PDT)
X-Received: by 2002:a05:620a:43a9:b0:936:623e:2603 with SMTP id af79cd13be357-939ea06ff04mr392331985a.17.1789122594922;
        Fri, 11 Sep 2026 03:29:54 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.214])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49e61a81943sm38651965e9.1.2026.09.11.03.29.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 03:29:53 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Date: Fri, 11 Sep 2026 12:29:36 +0200
Subject: [PATCH v4 3/7] drm/msm/hdmi_bridge: Correct poweroff/audio cleanup
 order in post_disable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260911-drm-msm-hdmi-fixes-before-eliza-v4-3-87bdb9f1987f@oss.qualcomm.com>
References: <20260911-drm-msm-hdmi-fixes-before-eliza-v4-0-87bdb9f1987f@oss.qualcomm.com>
In-Reply-To: <20260911-drm-msm-hdmi-fixes-before-eliza-v4-0-87bdb9f1987f@oss.qualcomm.com>
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
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1299;
 i=krzysztof.kozlowski@oss.qualcomm.com; h=from:subject:message-id;
 bh=XH66GnTgugpnLWEqmx30iK26F7dqgoZ1zE1rBdQ5ZS8=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBqo9gSmcfSFcKQbToEryQ/sbRBEp0E85MoJSCa4
 eGEScNxwYqJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaqPYEgAKCRDBN2bmhouD
 1+/fEACYbLTLMYCCYNYY614e8AJPNlr2hZiZ+bCfgxFKdd4RaDfhX3BZU4AyRXmWsUbgLyMc199
 YEZu93YLjrjLP+s2RRQetCGPScFAsNe5liReqEQMD5wQB9Y/S7AkXJ5NSXskXwpwJWUoPV8eJ1t
 EXrvUmEoUr6GlfLVLyqxr7VuueWQX5p3wE2TXNbTzSCrPf6slIkNquInZlIa/Ei5xDKY6Ok8GiP
 uhsSUBD+7DkLwjU2uolYhzVnHg/0DCK+dQ+yhZAldBd49oSkk4e7GNl+OrOadDo6jTGZYlr0Drb
 gbBRxb6f8RxFYN3t4xxz6P+Hn4mIrzZy2xEoSaLiHtLAQRFbwCgdQzNd4uSsmyi8vFdstIgdYB4
 WIvryUZPl7VyvvnzIhu2EOCyQpM5ZVZt7kF3D69V3emkTnZN31XcMOu7XAbUuAYTVxNQmdMTFcw
 +uvxffFBiZ+3d5hTfIPxB8RzNz3B0FQ7a7ZQLOr7Y6iPzRDVV8sAcJQH2q5tWPmU/p2lCwwitj9
 UZQnZujaPPMiJe9XRh9l88XeD8GYqWa+HMAaIaFd88gaHJEGvaGJ4r5Cb8Y9oauHlHOoylYrhpA
 pavfPZH1l157iRjmQ3O25w7B3niQcMBrR4/Ras1j4zfmebz2jN1GmSTfQTuQ/oVwP5v9ZFTqbz7
 agmupQwlLYWueAA==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
X-Proofpoint-GUID: Ccg2thEWtaLl5BkiaDTtWk07uLqgQK8-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTExMDE0NiBTYWx0ZWRfXxRWTwYV80EL+
 +fWL/6G0DDp2qQp96udFmHMUcp1bRtFujsy/6jw8siXKGAyl0qsj58CJ2eITmC7anYsZC0u0ilL
 UaTCCacoYVu3h5uLVvN5OP10+Q2FWZfCko9xs0ckzwbm8qAXB3Rfgou1C5dhETAkfYPH7Zl7X1i
 7ncyLzvQHU503UG/6krEzpksEqydo64QR7A0hwV6aIiymn2YcQNFnf62EJ8oIzBlQDDX7nf2IYP
 Xuu7hdBhK6K9Kb3akk8QNk+tOp1+tnp2DYSiK0UG0YFNtHzmjQ1Z+K7N103mkSJp5xB4xkASWe6
 CorKpVlqCaqCAabn1sWJ+n1N6IrQgbJ0XGtj453bApqQ8F4tpIxl43HonxVpBogkCgT2Wp97J9E
 mqaa8LHPNg8trsGeIURd1dMGEoua6gFOCgxDBWL6/cZrqMTj02A2l42Z0nUzZVCK3e5B7IC8Rog
 Udd/1foRP5QJI7snsBw==
X-Authority-Analysis: v=2.4 cv=X6jHu2Te c=1 sm=1 tr=0 ts=6aa3d824 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=+bKQE0WJfmhK2875HamI0Q==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=agfB2vzvzBSRJA4gfngA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTExMDE0NiBTYWx0ZWRfX5/q2XTF4Tky6
 w/ybxbGYiEzFK/mE6YpjWsKEoyg99Fw6avZzGGdRjNifeTXwVYUARb7QwkWt8HUNYSFQ+kMjjEv
 KJPWiC67Q0tK2WNzJCub3YZKKqkgxRE=
X-Proofpoint-ORIG-GUID: Ccg2thEWtaLl5BkiaDTtWk07uLqgQK8-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-11_03,2026-09-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 adultscore=0 malwarescore=0 clxscore=1015
 suspectscore=0 priorityscore=1501 bulkscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609110146

Turning off the power in msm_hdmi_bridge_atomic_post_disable() should
follow reverse order of powering up, not only because it is logical, but
also because msm_hdmi_audio_update() accesses registers thus block
should still be powered on.

Depending on specific timing, existing code could have accesses to MMIO
of powered off block.

Cc: stable@vger.kernel.org
Fixes: c0c0d9eeeb8d ("drm/msm: hdmi audio support")
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
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

