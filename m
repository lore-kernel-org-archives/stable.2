Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 670153AC17
	for <stable@vger.kernel.org>; Sat, 12 Sep 2026 15:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789225729; cv=none; b=XNdnMKpgxxlSyyALF1MSl690QIV7RvHZJ0J1Cl4DG9Ahimf4FkjH2b5GaOccmGD6LuiB3QyaZIrCNgLEupB1eNOu+AYRXXhC3mSGY25srD+bi9cwbZMQzQ81VYescF7SCwjrNh0MY0lIMcCiO1ivxvlPdBV+PzcPpWWwEUZu6hU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789225729; c=relaxed/simple;
	bh=JVC14T0NlR91z9MdhqWTlHIW6Ij3gw2JjdgenNfnY/s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HaCSAJH+4DWQotQZtwdbgaIvGJ27aWhsTDDB8FgUxqf/t1xZTjk/6XLiZxa/kwvWqDeKU4dwZO6e4c+VXBALefob0Sa3jPez8eC/MBOpPOa8/m22gczhUsJpPEfepY/lbq8npqCGMt5WBJXXfUjtL+tR94+lZBX7v8KzQCfyV4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ky3SFMKI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ky3SFMKI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 940501F000FF;
	Sat, 12 Sep 2026 15:08:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789225728;
	bh=pdKRAcOJqkWunvBEfX61EFAN3Mj+gdKa5faqq6sm9Pw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ky3SFMKIbIPfiyrWJUKUWT4XmRiqK362JtqzP4/EHkWMHSa7yHmkdtuzLLKa//KUE
	 KBWT+v2jmAy9Cq0H9NZ5oMXma5rp4uTR1cVrIrvp8IgwcT8RdAl8MXZMCH61kiZDdd
	 EXqzd2irou/qj7rOR1mFuxgjr5cDdZD+DzzngsrW8Y8x+jVayMzjcw65J0T9Vfc4jD
	 ZWb7pPHwBqYikByQoyPKoTgw7e0b/9EcXhgLFyVAeZzbyYEGYyFaQOEzR6WwimlayE
	 aDAr3VEJhjjSZwU9+18LjgP1ipAo1z6jPsx3ogtURj3b2TR2uSdAXdaAhOjBvmmd0D
	 seVu0RTHyTfGQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Rob Clark <robdclark@chromium.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 1/3] drm/msm/dsi: do not enable PHYs when called for the slave DSI interface
Date: Sat, 12 Sep 2026 11:08:44 -0400
Message-ID: <20260912150846.3054393-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090910-activist-busily-77c5@gregkh>
References: <2026090910-activist-busily-77c5@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

[ Upstream commit a14440042fe8dac6b7c507a946f46a6f50c9c05d ]

Move the call to dsi_mgr_phy_enable after checking whether the DSI
interface is slave, so that PHY enablement happens together with the
host enablement.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Link: https://lore.kernel.org/r/20210609211211.2561090-1-dmitry.baryshkov@linaro.org
Signed-off-by: Rob Clark <robdclark@chromium.org>
Stable-dep-of: 6cd33b6f4155 ("drm/msm/dsi: round 6G byte clock rate to the PLL-achievable value")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/msm/dsi/dsi_manager.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/msm/dsi/dsi_manager.c b/drivers/gpu/drm/msm/dsi/dsi_manager.c
index fb421ca56b3da..5736665da97b5 100644
--- a/drivers/gpu/drm/msm/dsi/dsi_manager.c
+++ b/drivers/gpu/drm/msm/dsi/dsi_manager.c
@@ -381,14 +381,14 @@ static void dsi_mgr_bridge_pre_enable(struct drm_bridge *bridge)
 	if (!msm_dsi_device_connected(msm_dsi))
 		return;
 
-	ret = dsi_mgr_phy_enable(id, phy_shared_timings);
-	if (ret)
-		goto phy_en_fail;
-
 	/* Do nothing with the host if it is slave-DSI in case of dual DSI */
 	if (is_dual_dsi && !IS_MASTER_DSI_LINK(id))
 		return;
 
+	ret = dsi_mgr_phy_enable(id, phy_shared_timings);
+	if (ret)
+		goto phy_en_fail;
+
 	ret = msm_dsi_host_power_on(host, &phy_shared_timings[id], is_dual_dsi);
 	if (ret) {
 		pr_err("%s: power on host %d failed, %d\n", __func__, id, ret);
-- 
2.53.0

