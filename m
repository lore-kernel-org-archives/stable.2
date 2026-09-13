Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA7B5390239
	for <stable@vger.kernel.org>; Sun, 13 Sep 2026 08:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789289909; cv=none; b=GasFr0Sc67QHsBwUrtcC7HA6be/Ded3Oj72y73IDY2NRCQX3B1uWvpu7V0Xa7bv0LzB6/T7ebT1gPtZG5YC5D+9Hnw3BqRl2wK4XXKyPooVC0y09VFe5wLrn4drp5ZN9IbYpvIopaaiiltzkVSBiUusOqgu3Pe0B2V8WWvXaaMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789289909; c=relaxed/simple;
	bh=gEn8gO3+qsCgamZRVk3MUEWgT0RKdoTB6mm/mj4N5AU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=O6WaUM+BPruqlz9AJSMSKpsWjt/c1lQo3PDcdc+eF/+OqK3NOM5Wk+fwAa6qNkPIXXQB+nB0wxWhphfPoSTEnW3d96fsQ9h3nhJ/fADnl7eXgcqEAH5IvFRhraND6o98ZPWlRS+K/gq4HG5KxR9itqhCWrNB9jUHVjRxZ0nEQqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kyc1M7EN; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kyc1M7EN"
Received: by mail-pj2-f13.google.com with SMTP id d9443c01a7336-2d90ba1d807so16519925ad.3
        for <stable@vger.kernel.org>; Sun, 13 Sep 2026 01:58:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789289907; x=1789894707; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=g12Q/omnE3PC2Amf1XAPg7bzaI1F+/7aB6gxdSUP4b8=;
        b=kyc1M7ENT69oE+/yVlww+0gSjMql7LtAFttVl/GBvYAjkmJceeqQ7OxnCHiZKltthl
         TGj046z8srItlTkpnjRkxsMwSlCNCWY7uuyXMN9qhJwriv++gDRBpLTYe8ePMi+Qbqkb
         OzYIv8PZ5Ka+l2k7jizVUMFJj+CdITSddd9WV3zoWJ6lN1drhY6FTD7xlfWhmtZP+hDH
         Hql54JP75eJ1IyBGPV0byAu9mM+GHDRq4pV8t4uWyUS7uvK1LIkC7yowmJC3h7bDBil3
         eZKTBUGbkAbXoL72FyiCxWKMVEg8FkNh1SRZNZR106VPXEmWmqG3JkDqMaAsuvPlprwu
         PxGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789289907; x=1789894707;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=g12Q/omnE3PC2Amf1XAPg7bzaI1F+/7aB6gxdSUP4b8=;
        b=XxS/I4MaBX4vVlFavj4nL7f3VuARv0C0EO8VF6HHtAaQYNm5ZuuagryfuHk91tBsol
         +MDgLaR052lcKnl0BWqEUxrpTpyLtlSFI4fYeRdVOQ6ctl0flSEaRD47T4VrTbgnrv/6
         jXlQ8bbOxUpmMkcbjuQ6XW4v4OyJiYt7ZYwcanelstVFik7wb76R4HWmtyxO2xA3bJDi
         wRxFFZ7UUVP1mmJvW+QCqafqB/kjSpron0p+it0R1PTtQcfs3hLd1dYgbwJDQhlYqkqq
         xAocEfy+VXXNd0JrGpG+FHd/HQ/A7kYt+35TStguyi7HVAjUXs0NKdl9MkgyuMjSFlYe
         Bmkg==
X-Gm-Message-State: AFuF++mS3uErFcOf6uDasxVqxSWtNHfktxoBcgzVVXIyGZINg0+0yNn3
	V0BQa4DqJ5Z6GQX2S35glP6RYMU32lyBiVcZ3QH0tM1q2OpkSCqwcJxu
X-Gm-Gg: AYBFou154Vs0JMlpHw1LU6qp3MZrIAg7Jn7Kc7g8vU1PMvAAmiU4T4rvbrxY5gle/nl
	6GuJBdKTTatdsTAvjSqsifRjZwVgTZaWjdYO7u7B3H/xyF5Iwnk9mEmcUueQvIdfcZ3Gv9uefsn
	cBvoR1g54QEc+3L9ObNKFqP+CoFmHUKsWhCHNQFk2iH1guuAVYKKOhBqOdmw2AKAUlNrKm/viKo
	LrD7ZjyQqNgQwQjfR5SEbW8tDy12V930VTud6W4OwAOQKkgm8H94Y1bY7M08QdJkw3qmBwhuDbD
	vVdBNRQ6stgG8d5iNtff3ILCtD1DP1BfV1Mah6vMM4GhCAYlJ256FHMl6E7VUh1Pa8ALpSG9/jz
	m4Q92jt79h4Sb9z7LCh3scNst028Kjq6s+Q6X9dKfWZMJXxpV9PeqjY5d2JA2oHIozjj9f9Ym0t
	hWIipm/7JSj8TnIHUUU/wI/O8XRVNZ+AsOyWOGzo/9PPlN2+KHZSYS2hp8EQO3BwXD
X-Received: by 2002:a17:902:db0e:b0:2da:dcd8:713d with SMTP id d9443c01a7336-2dd2a34f6e6mr211164165ad.15.1789289907022;
        Sun, 13 Sep 2026 01:58:27 -0700 (PDT)
Received: from lgs.. ([2001:250:5800:1002::de93])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2dd48ae3cacsm17494875ad.26.2026.09.13.01.58.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Sep 2026 01:58:26 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
	Dmitry Baryshkov <lumag@kernel.org>,
	Abhinav Kumar <abhinav.kumar@linux.dev>,
	Jessica Zhang <jesszhan0024@gmail.com>,
	Sean Paul <sean@poorly.run>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Guangshuo Li <lgs201920130244@gmail.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
	Archit Taneja <architt@codeaurora.org>,
	linux-arm-msm@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	freedreno@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH] drm/msm/hdmi_phy: fix runtime PM cleanup on probe failure
Date: Sun, 13 Sep 2026 16:58:14 +0800
Message-ID: <20260913085814.1509352-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

msm_hdmi_phy_probe() enables runtime PM before enabling the PHY
resources and initializing the PLL, but failures from either operation
return without calling the matching pm_runtime_disable().

The remove path disables runtime PM, but it is not called when probe
fails. As a result, runtime PM remains enabled after an unsuccessful
probe.

Route failures after pm_runtime_enable() through a common error path
and disable runtime PM before returning.

This issue was found by manual code inspection.

Fixes: 15b4a4523859 ("drm/msm/hdmi: Create a separate HDMI PHY driver")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/gpu/drm/msm/hdmi/hdmi_phy.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/msm/hdmi/hdmi_phy.c b/drivers/gpu/drm/msm/hdmi/hdmi_phy.c
index eb1088755cb3..77dce35cd45e 100644
--- a/drivers/gpu/drm/msm/hdmi/hdmi_phy.c
+++ b/drivers/gpu/drm/msm/hdmi/hdmi_phy.c
@@ -168,13 +168,13 @@ static int msm_hdmi_phy_probe(struct platform_device *pdev)
 
 	ret = msm_hdmi_phy_resource_enable(phy);
 	if (ret)
-		return ret;
+		goto err_pm_disable;
 
 	ret = msm_hdmi_phy_pll_init(pdev, phy->cfg->type);
 	if (ret) {
 		DRM_DEV_ERROR(dev, "couldn't init PLL\n");
 		msm_hdmi_phy_resource_disable(phy);
-		return ret;
+		goto err_pm_disable;
 	}
 
 	msm_hdmi_phy_resource_disable(phy);
@@ -182,6 +182,10 @@ static int msm_hdmi_phy_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, phy);
 
 	return 0;
+
+err_pm_disable:
+	pm_runtime_disable(dev);
+	return ret;
 }
 
 static void msm_hdmi_phy_remove(struct platform_device *pdev)
-- 
2.43.0

