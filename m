Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794417031;
	b=DEAZkWWoISMlXy4GHidM92HjjfcBoYniCx/p6DN4uu67xLCuqp+iWLZyP5upKRFgnwrJ
	 je5CvUaHWT+shlTYD+RE31LTlSurl+23nWQRa4TpfVQxQBF6MQjS9yNKgVvKBz+CZQ9xH
	 YTYs9cVMIFW9gGcl3RODbNX1LdmRgfbTlsYIXHcp0VUnxQDjxRjuf+qzzyyhLIS3B7Ut4
	 SjJmeGPNl8d/W04/rMngN7Ucg7Gm3aIcUeRlaSd2Lg2bi0tR5mwYV4HxlrLKE6TjnYnLx
	 ggyuu2Y5SO9EqD4PdVcdQs3Cs6mwBTzin9AhWpX2KQDiEXwNNzOtkvXwYm94KFsA5Cw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794417031;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=QzcudBV4MnTxAthGSwaebNiGUIppXdtoTg9qGoQa4AI=;
	b=giFni7u98Rdno518rIh8dHVYngXOulbofPxIj7/2TVTevyp24nsqxLECohYwqEQBorXb
	 gdNmrCX1n06DAmMHcAqvlO7GEaRhzfnTZ5kjSu5tpsl/TPjSjSiYVrgEaLTFHxuhpPGLn
	 8eLv5dnwDoHzTR2YmaYSq6AeS5j7crgk5HJdY4UgOmfCOMSPVAez+PFFvvtYfsHhE/P3S
	 iP/XilDAbRmeJRgKQhfumpnqDF2Whelj9kGoKLODimAPB1RejC3j5TidrWCRYqgNVG5Xx
	 YFbvQmj4pD5nYIX3490yNOND43dmuMZk3EC48VdEhAG32UwbrEdhUH8hfZRPNKaZysw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y3ZYdKDd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C45E606A327
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 17:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y3ZYdKDd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 612ED1F00A0B;
	Wed, 11 Nov 2026 17:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794417030;
	bh=QzcudBV4MnTxAthGSwaebNiGUIppXdtoTg9qGoQa4AI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Y3ZYdKDdjvPvi17guP0nLDG8ndSYrMGlq0h6xa93ChiaRSEK5cJ7dJgDZZAQmZBR9
	 2Cc2HeZVon4KeCWPU8UiWlLD2ysG5vL3blCtFRtSyqVOqZ1KdITkEnPda48mqibylW
	 sAkEOFVCmQMwrVwXy5nQCD+sCwLHFcue7jvv/tQwBQTvx6z0sbTOE5MwoJS9OxEzUj
	 fhLWarIJUqmcxRcp/tGYE38xZSEk0NSKAumqff6HCVhGNuS9FKNGXbGyxVkeFVtlhz
	 mf6VOV42uFK5GUHijYlC7SZcu9VOdpTzYyCOeNJ3fW4wz+VstHZSL63WfUFhpSb7Cj
	 mDW7Z6VVJNlnQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 2/2] drm/msm/hdmi_phy: Cleanup after msm_hdmi_phy_resource_enable() failure
Date: Wed, 11 Nov 2026 12:10:28 -0500
Message-ID: <20261111171012.3471965-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261111171012.3471965-1-sashal@kernel.org>
References: <20261107061756-failed-5.10-d27f831aaf20@kernel.org>
 <20261111171012.3471965-1-sashal@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

[ Upstream commit d27f831aaf20aaf06e41ceb1b260e10672269155 ]

If msm_hdmi_phy_resource_enable() fails, e.g. when enabling regulators,
it should reverse the state of things already changed.
msm_hdmi_phy_resource_enable() is used also in probe path, thus such
failure, which could be simple deferred probe, would leave these
resources permanently enabled for the rest of the runtime.

Cc: <stable@vger.kernel.org>
Fixes: 15b4a4523859 ("drm/msm/hdmi: Create a separate HDMI PHY driver")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Patchwork: https://patchwork.freedesktop.org/patch/752654/
Link: https://lore.kernel.org/r/20260911-drm-msm-hdmi-fixes-before-eliza-v4-1-87bdb9f1987f@oss.qualcomm.com
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/msm/hdmi/hdmi_phy.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/msm/hdmi/hdmi_phy.c b/drivers/gpu/drm/msm/hdmi/hdmi_phy.c
index 326b43c803f09..1bdaa1f94c29b 100644
--- a/drivers/gpu/drm/msm/hdmi/hdmi_phy.c
+++ b/drivers/gpu/drm/msm/hdmi/hdmi_phy.c
@@ -62,16 +62,28 @@ int msm_hdmi_phy_resource_enable(struct hdmi_phy *phy)
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

