Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBC6242F700
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 10:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789122597; cv=none; b=mVxcUngpufKWaezMYgZXfLENvv/1wptv0IBBv89/lGdRurR48QVkG5MaowdmlVoMwQ/ZY10WhI6aFy0Y3BzmcHKgmJ6bzFPQkgG3oAF0QvYcBI/uSGqIc3nPlYWVPaxbdhMPIsC+ob4VOUbf5KFUOHUbCYAYYrXcK9YqpPbJNkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789122597; c=relaxed/simple;
	bh=ZG093MO2ef10q/LWPvFaNq71LX74/rGkq31nYz5GUvY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ntCMwJQrHQdoKm+cN+cE/nJTkfFQ9HJclk6pky0EsC7iU33310wNk3j/N8T4ZmBwbQVYiJ5xNT4/FG+zkoLcUx0t41Qn7szt+NAVKFfY7jLQX3boVCqsLZxwlQ86rfr3DKxkeP95P2UBtMfDU94jolxm5gXU3fXcM/zA0Bq7Hbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=I/DZKTDj; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=UabA2Bfc; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="I/DZKTDj";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UabA2Bfc"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68B7kl6B3845340
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 10:29:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	89kOUuqbTMD7KBwxWQmwEktFk33uBWpQA+q0IsoXFqk=; b=I/DZKTDjmhSTvIGb
	QsmmmXilwWEUyUu6wBHwE/SOfshnkJ36+XtfmYcYVHn7UgJvhotzwLZD5ECiKj2l
	58m+EmCH06BJoRrdoKkfxH3p5CkpPu+t1sunbS5YbsWbskh9tr/q53JXe60+jHDo
	YsObcHE8lhTniLTbYWm5493BlwYvXVvtwHgq2WLq+7s8rdIbvFPhI6Q+HAzDPADh
	UL1FvarMYGQLUdU8hAtZHZ7Y0AspUrRsr1ygS/zBArOaIJDFZ7mynW2x7fGwLd4P
	JlZXfMyPfJohbxq++WQ70Z9j6fzELh5TOCCbIen/N/0ZyFgeljEbrFM12o2PopGk
	X244Nw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gm5q42dss-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 10:29:54 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-936aa34873bso112457885a.3
        for <stable@vger.kernel.org>; Fri, 11 Sep 2026 03:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789122594; x=1789727394; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=89kOUuqbTMD7KBwxWQmwEktFk33uBWpQA+q0IsoXFqk=;
        b=UabA2BfcgatV9z2qgHoGQYJuGDvY9/mdM6bKtgHYkEyF7RsgujBFHZIneHEL4Thlpw
         Zg6+MejrKOW+W/POa2rJFlFZT/hDv2wReS7cr1l+t2npSxeRJ2O7CPNFT4arJyyG8h3R
         hePRHYy471vld9Bk4aQ29POdycYbttHuS4k50KpXapHQI84CjY6ui+p/AOT5rzzXuEPc
         nDBGzdQiWFq78lXvqKWKxTHeNLr+5H4W7GJ8Qh41wqz7qBM1yGS2RKp+gUFmdFtVwHvB
         6hakB5PbE9Le10sZF1GuLNyGJC+N6sWoFbYO5c2mRhxAFwQgMfnBf9v7lp9J8IBkWXca
         E5SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789122594; x=1789727394;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=89kOUuqbTMD7KBwxWQmwEktFk33uBWpQA+q0IsoXFqk=;
        b=XMrMWDMt4pQvJYlNwm/KXzJZwFJld4bKS4eE8MVz4a+GfCMuJkGbSgPHHiF21oX6J4
         y7X+6kUyoZiyHDqEYWdBHwERbZzBv4KN3MZHc+0/fMxXRIhMvO5jnKXT+N00HRH2wHg5
         JEQ9nKZb50Sh75NRE/NkDD/KAnUVDNv9PX3ayqkrZpGlVxZbv/NBuQdeZkJJjsK5qWji
         5IV8AXH48kT4ZsmfCkxdQwQZqQ+pJY094yjQOGYDj8RhHxFfr14IP208hiaE7NfIo9YI
         pvQLNEzC8kwLZMfvwuKJwGx5aEPG2imJYI3DvB1LuNtAjBz5K1AGINDDLhMF5oDQsSmv
         Lj+w==
X-Forwarded-Encrypted: i=1; AKwUvBzDp1I6yotFao5yK7Xx8QDLLWJuFVZzjsVtXwqRUA0ZVyXp9flFM+v5MJFRZ2VVs5Dtgz5GZTQ=@vger.kernel.org
X-Gm-Message-State: AFuF++kjCN52U9RQAkiEhB79OxIdOgb2I+sw8mDAxQymUao0yCpuJtky
	tS0aoR1RoHer7bGqwJWQnVZiAgqA0onDznllEd4jTREXo3zWjcVCLNcUPo3DH4VN8Ft9kQFRQvv
	ZS7Vg/pCA9Qg/s/wt5OYaw0usu7ptH8Wg+qnpVo+HHhpd4TW155abrz9nqrE=
X-Gm-Gg: AYBFou3JG5v5iDzaZ+6HOBgUh1jOyulk6kD2uPztc246a9TpZWTwbWR7m181Dnir87U
	T7B0nUY4uDuEcLbxJ2Mezl6B+GFgz55co+lN3X9tPbVk7lz5NmlbKodPGj69FXK8fs02rYCc/2v
	rPRqToT62DfcYlMIKCbpUVhE8N8taepSvGYnp2u6CU34T0BDEpoYHgKjNwcull9XFdWCq2pCExg
	aeicXHdskzUx1PMRHjPDA1lZkIdxwNx6mlepCcZSquXJYtGaDNsVTxDSNDki4jw/jTGHAsfzKT1
	CE50Ny1bxMN8Dm8p1XwZeNMQslB28oSw2ac1MGGQsLsSL9Qp2IlH2Y5vxJ5s+cZ9NfAL3gRy6TT
	iXGyeyrOfwAyRm9X27c7HKho=
X-Received: by 2002:a05:620a:2a05:b0:939:72ae:e536 with SMTP id af79cd13be357-939ea08d7f4mr427003785a.13.1789122588918;
        Fri, 11 Sep 2026 03:29:48 -0700 (PDT)
X-Received: by 2002:a05:620a:2a05:b0:939:72ae:e536 with SMTP id af79cd13be357-939ea08d7f4mr427000585a.13.1789122588563;
        Fri, 11 Sep 2026 03:29:48 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.214])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49e61a81943sm38651965e9.1.2026.09.11.03.29.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 03:29:47 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Date: Fri, 11 Sep 2026 12:29:34 +0200
Subject: [PATCH v4 1/7] drm/msm/hdmi_phy: Cleanup after
 msm_hdmi_phy_resource_enable() failure
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260911-drm-msm-hdmi-fixes-before-eliza-v4-1-87bdb9f1987f@oss.qualcomm.com>
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
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1590;
 i=krzysztof.kozlowski@oss.qualcomm.com; h=from:subject:message-id;
 bh=ZG093MO2ef10q/LWPvFaNq71LX74/rGkq31nYz5GUvY=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBqo9gQpFoZjDhMzPsUy+LdmdzrFOl71cZhEMXi1
 mgUxSmEFceJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaqPYEAAKCRDBN2bmhouD
 15LsD/4/L0NDXHF/U4+guLhfAlcFLxQHsCCkbhDa9SOS7C/sitVrIcbNTbKbx2SaBDKTzOIw2Vt
 7fBhdDez23YI8P6u/LyNQl5OOzReoKr4QHgoiJznFhA7kDD5g7uivqKOQk5gLtoUzdC2v4LhDvN
 bc0kf+BHkLPNrtZjXxnHrbai3byrm3eG0S2uSximL2J2iBxbw20Yq/Al/jaFyzp/RoTBBfqcpRp
 G2lRAzNdW6oTkplvqMfsArEIpSBhxhUefh9HTMwcQ6GXzuMpJTZt2xhF9lzWMIevTQ89wn/p/px
 lOGDeaCXHXkVVdyoGglrP1wZFoiPDRfXqtP84gsD97V1+InM8iel/9wAyhFzq+DoSxs4YoagUbE
 UVKdtRU8cyWu94bEJVIUq+PqsIm/j2xtl68qOyLls03WVMFf7fhz3yx9kxzytJJGymPrb6p3w+z
 qkgL4q007YVdg9DnaEjPnogP59GM6b8ftIaUTEDU2lb9rhv447d2EyqHriIqarFmqWJOPqbjikr
 Sc2Ich4Mekhl6pe0ih/foIR/m5gAB/D5s4W+gFOe2wRxaEso3MyWe+Nglgdgg4zcNX1g1v3JRsN
 PHpj53uzFB3laL/R+BBF8EtRVZANl365wFnxP31ti6FZhX8VMSzrLPLxhD6R7eMzuIbQJJYKx+T
 yaZAFMi7MQwvBZw==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
X-Proofpoint-GUID: 5TqG_8FjQTJQz8igM7HioFruFwFPL8qG
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTExMDE0NiBTYWx0ZWRfX9FI0J9gZxzOx
 wrTAaPp0OAJb1LMnITsLYX8Ib9+wfq5Q/3PsDwfAFf9cc1Cb43tioWdEKIB5wx5A00kwmL0v0Zu
 h+J/ceRySORia4lfBpIusbrlG1AETxs=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTExMDE0NiBTYWx0ZWRfX4OIL5WPaQ5nf
 Fbh4yrhfhvbKST284fmoRgfrciIfIsZvGHQRUGUUBB7Z1XO2UDqjlVdaJ5bWvbpqfmM1Qm1W9aX
 8XHYgT7TELivkRF2F2m0a8IAdIrjkYmDYoidUV64dXjV3fCt4qmW7Q1khTFtIyfs0wC1f+YlgKF
 V91kQUFgocveJujxPhlGwXABW6m9wyq2jrrrCeYUDzcqQ/mdknMFnYSWnEZGWu/Ufp8EOb0tqDv
 noCeEH/j8VFJK/wNVtxuIXtHaPrmgRuscWrMimiWSr6xLoZoqhXqu0zTFIMdAbiZyM9FzYqRCv3
 7AsHrWMQtNT5HchjpCk45pNyAyregvrNzuevnQzWY3CIY4BJlSlImJHp7VUDGNMxJd8oMgsDAut
 12DFS/8V8Gv0qnBL65WPwrsy+KWeAeEQPs7GB/nKgG13IdN+QMHpPQBdy0Y8m2pxxpsjKQ/l3MN
 wTPjvx97uDBx8aMwvGQ==
X-Proofpoint-ORIG-GUID: 5TqG_8FjQTJQz8igM7HioFruFwFPL8qG
X-Authority-Analysis: v=2.4 cv=Wsa+otfv c=1 sm=1 tr=0 ts=6aa3d822 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=+bKQE0WJfmhK2875HamI0Q==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=bp1g5Iz1D7c7guLF1_8A:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-11_03,2026-09-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 priorityscore=1501 suspectscore=0
 spamscore=0 bulkscore=0 impostorscore=0 clxscore=1015 adultscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609110146

If msm_hdmi_phy_resource_enable() fails, e.g. when enabling regulators,
it should reverse the state of things already changed.
msm_hdmi_phy_resource_enable() is used also in probe path, thus such
failure, which could be simple deferred probe, would leave these
resources permanently enabled for the rest of the runtime.

Cc: <stable@vger.kernel.org>
Fixes: 15b4a4523859 ("drm/msm/hdmi: Create a separate HDMI PHY driver")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/hdmi/hdmi_phy.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/msm/hdmi/hdmi_phy.c b/drivers/gpu/drm/msm/hdmi/hdmi_phy.c
index eb1088755cb3..15e37596bdb1 100644
--- a/drivers/gpu/drm/msm/hdmi/hdmi_phy.c
+++ b/drivers/gpu/drm/msm/hdmi/hdmi_phy.c
@@ -67,16 +67,28 @@ int msm_hdmi_phy_resource_enable(struct hdmi_phy *phy)
 	ret = regulator_bulk_enable(cfg->num_regs, phy->regs);
 	if (ret) {
 		DRM_DEV_ERROR(dev, "failed to enable regulators: (%d)\n", ret);
-		return ret;
+		goto err_pm_put;
 	}
 
 	for (i = 0; i < cfg->num_clks; i++) {
 		ret = clk_prepare_enable(phy->clks[i]);
-		if (ret)
+		if (ret) {
 			DRM_DEV_ERROR(dev, "failed to enable clock: %s (%d)\n",
 				cfg->clk_names[i], ret);
+			goto err_clk_unprepare;
+		}
 	}
 
+	return 0;
+
+err_clk_unprepare:
+	for (; i > 0; i--)
+		clk_disable_unprepare(phy->clks[i - 1]);
+	regulator_bulk_disable(cfg->num_regs, phy->regs);
+
+err_pm_put:
+	pm_runtime_put_sync(dev);
+
 	return ret;
 }
 

-- 
2.53.0

