Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794416732;
	b=rqB5t565yToivjM9kOFJvKYCspSU4I7MrHmtYd4GgVwM6YeO8cLHrXRHKaCQmBa8ZAHq
	 hpnt2nMSC9ZTU2LefrFKg+IbWcMewgG1o6gcVxga8IC3kfF50hJ1EhpREPNgiFrmqo9cz
	 aGvIUJIKvETySL3q+dY/sb7jW/3AkZRUVyvUCaSckD1kPa5nwNaekNUagtglO6awB16Le
	 r/drJkcb/QBDgz2kfKmBnG8n6EePK8b+W6cJfHngVcTG1FMCbfM6rzjLzIJ56mgQdxMKk
	 QOYO6P0rR6bRXF9iRaa32ziPATt/Pfsz81jYNTXQ6yqfiwA5RPZBZV06hiVxUICTydQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794416732;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=QzcudBV4MnTxAthGSwaebNiGUIppXdtoTg9qGoQa4AI=;
	b=yPRe5628MLM07wubxohkd9occUfQ6/1eqyKhLiRQmx6FP5hxO7umjTeUkmHOSEeIBtp5
	 KVEvmW/INzBTemf5Las7FW28J7/YcE8fsZ3p3EkdnAXUpc5d/8tBvQzwOi1L1vPRcErKi
	 gixbg+9KxrDXLinlAfdfFG7hC7QKneaRhTIbCy9z4IIyCvgTbX+YUag5M8DfbCgm45a7S
	 IVOiPGTx1C565k3sFpUd39tP8lMDwfcgw5aVW0OGgAx0miodvha3ygLCYhFCCBDG6SXJo
	 TjPjkAUQKwtpQE5pey17Q0qXQ8nk0765o471/HHbCvB28akl/2BVcnNz7Z6wbcdpgXw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Dil3lyVo;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2750C606A8B2
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 17:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Dil3lyVo
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E95B1F00A05;
	Wed, 11 Nov 2026 17:05:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794416732;
	bh=QzcudBV4MnTxAthGSwaebNiGUIppXdtoTg9qGoQa4AI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Dil3lyVom3Hu7yZaaD9HfIV1ngzpAj8sVyYGDf0qBb8he6RCb5kLyPQkZkBVoEUJA
	 HUUA0WY8hKb/wQixQ9xTrkChRlMww9s+27Vz+WTXAosceeaXhh6SM3O1dsk3XfXNdU
	 pHK9dYTyZ10wbHQPF9E5bMGPNdSPXupiD5HHGBzv7Ck24+Lad2f7ibjH+wQ2CxnOWy
	 GALGNrtni2UobfuXSWbuMcM6HUscp/B6tGHbl1dzcOd9ZMFfxdZjn3+mqssoWpQBQG
	 i7sEvUT2rQ+g0iazRowyE+vWH6s4NsgRbBLxE5A2LugeS7KYifXQqIHrsWuXaLD/x4
	 /3ozVLZNZfxRQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/2] drm/msm/hdmi_phy: Cleanup after msm_hdmi_phy_resource_enable() failure
Date: Wed, 11 Nov 2026 12:05:29 -0500
Message-ID: <20261111170441.3401882-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261111170441.3401882-1-sashal@kernel.org>
References: <20261107060115-failed-5.15-d27f831aaf20@kernel.org>
 <20261111170441.3401882-1-sashal@kernel.org>
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

