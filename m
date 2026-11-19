Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795115896;
	b=qFboE/CpLo0zQArdblVV9a+GurndUf4siUQLvBG4IkcVCmiFxZKbxz0FgSrtXrX9uzvB
	 LL2mmuNIKuJOaWkcsXzqyfzNFbo0EfCl3aHisCFIun60Qy/UAj9wGrzaSwKX12ZQKJNls
	 dFB1RhfuS3+H2SUUW303c9atGY16pVBUfiWCaC4gHLghfSGThV5gGxdEOQL6f+xtuFPUl
	 Ug7UTusAkOTfHnJ6GZ7MK7iO1jyQklPvQgbsinemqdc6TlblkZECUkNoB6XfV5Gegxxx0
	 RXCiK34eHf0BhXefyInrWqeNv4hl4BMy2tUEXdFhu+WGI7ibJ3oBgimY1UmWJIAKnPQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795115896;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
	bh=VtOWtZ3YiekVd4GKDKB0dokNmDLbKi4y9lRQRY8pzpo=;
	b=fiN4nViEB6/1X+WHDA8fE8+N+tR5qpyW5Ol1HsyfmYj1VD+arvn9rODmb0oIqL9NZmLK
	 mTFOfOgnqGoEr7x9aoPpbgga0b9TvsTLtWPNwI5qCGUFJBdqTkZGj+IaWNnlrwkuh8TZz
	 8Vl6K9zSYYQGzDtZKXof7W4WvbtOpsNratMCzSjQbBxME9GSVJIKkx3hTf1nbB6syyvMr
	 TpndJo2oTRfX4WMgQFYD+T7smGRQGJl8WPye89dyANq6vsU85D4IC4wlcodZotT8fRTh2
	 7gPfnjXlw6yHj3DrLNeJL/KJt2flN1EP2rwm29Kp2K4zB31XVkNpuADdw/Z6A05haiA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=yDbqjUqB;
	arc=none smtp.remote-ip=209.85.208.47
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CC5A606A330
	for <stable@vger.kernel.org>; Thu, 19 Nov 2026 19:18:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0CC5A606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=yDbqjUqB
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-6ba38c41804so521a12.3
        for <stable@vger.kernel.org>; Thu, 19 Nov 2026 11:18:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1795115894; x=1795720694; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=VtOWtZ3YiekVd4GKDKB0dokNmDLbKi4y9lRQRY8pzpo=;
        b=yDbqjUqB8/LIQbMMrTTmylORaM8GCLvTtIU4IxxHQOGwJvgrxbIC/bvsEypIPl4Pxn
         sLOBpEvn89kCCYo3rhA7/nZKfazVpJQOLk5q/hZ41kfXVU2CIee2gp+58245ghBIMSxF
         /ogAAeCeI7lHZXba1wkuPO0gjqXp/1T0qcZ5Iyyi2BdNoJL+Re5CzGOmXYZe8+Ydh81g
         lPcb7T7R/53oKOpeNNJZnORBV3m1lv4CeYhMIumhFHPNCRGXfh4qOKDsfX8Y2qHOwoab
         NvZLAr1cFhrpQUdI+zOInh1y5JhKlMNt8tUgGk6dCoQXVIxHklSh4SdsM2fUCg64Gf80
         MHqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795115894; x=1795720694;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=VtOWtZ3YiekVd4GKDKB0dokNmDLbKi4y9lRQRY8pzpo=;
        b=uo6ps/JXJsqkKT71mapQAhO/KD/qmDhlK4sACz8ZGmPLFv+QEyJ9pEt9t04EeMP68F
         9cOQUb2nH3xsuyAYf4YCjvShH+eE2GPTz5o5FFJL7/d1+XeJOgdPHiZaEof87/JjnquH
         +ty4MxkAR2m/BYX5bVzdHYJuhpR8DJTo8tMcxc3iXNQlssNiKEpD/Xf81ygQssHORuPN
         Lz2HNgaNgvXiiIEA8MW8ce+4/+dHrsS3Q+FVT0O+x6M8raxBzSy51DZB3GSiwsTUaBES
         c05K8TXPnLMqbdrBYnU+Why1ljYVX1eYQEimKkIyfT2PNzzYt0EtOGo3JGrmnHNGVF0q
         laqQ==
X-Forwarded-Encrypted: i=1; AL+hErGwIBbtmuU0lREfvydLWHyODhvGI73amUeIUDZUBSseSCx7jpuUu3Z4TmvkSqX98BTAo6bjCU4=@vger.kernel.org
X-Gm-Message-State: APuU4Z+vpX+ba9UWg5Kr8PfPDuPN5HDaECvrkon+h27KoZfcYp8jfaNm
	fJWJ6ZWWuoMk+MTpVMwcY/s6r/S2Oh99eeShD3msSlnL4XUOUVMbxzy1SBYbhOFiEDU=
X-Gm-Gg: AYBFou0wLNReJ77iWRCn7YmRvQY5vB23m847R4NDlo7AOna78bQVOJOIY68Yq9mXM6D
	tNqAU3hR1kV9AbpK20XFJQQoVey9579HicPL8CL5kZYCSysJY2nTEPI6E+dwqRosggRFG2z2JWO
	Us2Jva85DM9sbuO+sLUVmoLxiP1kb4vVetYf9v0GTPkrX1K/3EDGccyo7I4nqNEggR4zXZtCBAB
	StFif40Zh3Rglm7h5iPOxS/bZIVxyZippAWJ9lVZXCY7trEQXerQhekfO33yvkdcg2jEBi/i9vF
	2LPqRMzqWU+qNYS4bMBhQF22An8BWZEhq7a8CowsM0v1NE4sskPKmhZC6MW4Y6ZDJZWc6YpWGJ0
	3tmv9743BKgaCnoGSErgQdBb/SYzz1hTn5hPsDYrT9nfP0n9MZwmIW0fY/1ienBYA2CxMkTM/m2
	ETvOsHOIznMNF8o1Esmsxr0P2UXUbD4i5sJ11MQolmAphr3WT4Y54dmujEcXtQ/YwcvIe6ny0qn
	BljScDogarq5/Z1EJQvDpC6TtIwgcUC3XEw1ZDkKGMKsO1RbPg51jN9LM0fNRBERjNk4f3V74+v
	aWdtKumYy5XQzzQpj3UrsoWdTyvMhVBR2mleag6Ia2IhY/JJS/igVQnVJA+gCckMVpOcQwnExoc
	wafe0OH/4NlcflZ/OD0W0ZqBQrnPBUZxWN5YkRDU=
X-Received: by 2002:a05:6402:540a:b0:6b1:c5c3:9624 with SMTP id 4fb4d7f45d1cf-6ba37e75559mr319355a12.22.1795115894304;
        Thu, 19 Nov 2026 11:18:14 -0800 (PST)
Received: from puffmais2.c.googlers.com (226.124.90.34.bc.googleusercontent.com. [34.90.124.226])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6ba370cd368sm217651a12.8.2026.11.19.11.18.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 11:18:13 -0800 (PST)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Thu, 19 Nov 2026 19:18:12 +0000
Subject: [PATCH] phy: exynos5-usbdrd: gs101: re-init PIPE3 on orientation
 change
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261119-gs101-usb-phy-orientation-v1-1-bf3c4bbf328e@linaro.org>
X-B4-Tracking: v=1; b=H4sIAHNL/2oC/x3MwQqDMAyA4VeRnA00pYjbq8gOrkvbXKo0Thziu
 xt2/A/ff4JyE1Z4dic03kVlqRbUdxDLXDOjfKzBOz8Q0QOzkiP86hvX8sPFcN3mzRSGEOOYKCT
 nHZhfGyc5/u/pdV036x4sgmsAAAA=
X-Change-ID: 20261119-gs101-usb-phy-orientation-44cc8f14f020
To: Vinod Koul <vkoul@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, 
 Krzysztof Kozlowski <krzk@kernel.org>, 
 Peter Griffin <peter.griffin@linaro.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>
Cc: Tudor Ambarus <tudor.ambarus@linaro.org>, 
 RD Babiera <rdbabiera@google.com>, Juan Yescas <jyescas@google.com>, 
 kernel-team@android.com, phone-devel@vger.kernel.org, 
 linux-phy@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
 linux-samsung-soc@vger.kernel.org, stable@vger.kernel.org, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
X-Mailer: b4 0.14.3

The SS lane mux on gs101 is programmed only when the PIPE3 phy is
initialized, based on the Type-C orientation known at that time.
The orientation switch callback just stores the new orientation and
relies on the USB controller to exit and re-initialize the phy, which
only happens if DWC3 enters runtime suspend.

If a cable is connected during boot, the phy is initialized before the
TCPC reports the orientation (e.g. ~4.0s vs. ~5.3s on Pixel 6), so the
lanes are programmed for TYPEC_ORIENTATION_NONE, i.e. as if reversed.
DWC3 doesn't runtime suspend while the cable stays connected (and
runtime PM is forbidden by default anyway), so the phy is never
re-initialized and the link comes up in high-speed only.

Re-run the PIPE3 init from the orientation switch callback if the
PIPE3 phy is initialized and its lanes are programmed for the other
orientation. Rewriting the lane mux registers alone isn't sufficient,
the link still comes up in high-speed only with that. Re-initialize
before signalling VBUS valid, so that DWC3 only sees VBUS once the
lanes are right. A failure is only logged, so that the TCPM still
configures the USB role.

Mark the PIPE3 phy as initialized in the same critical section that
programs the lanes, so that an orientation change can't get lost in
between.

Also stop storing TYPEC_ORIENTATION_NONE on unplug, so that the stored
orientation always describes the lanes: while the PIPE3 phy is
initialized, they stay programmed for it, and when the phy is
initialized again after phy_exit(), which gates its power, they are
programmed from it. This avoids re-initializing the PIPE3 phy when a
cable is plugged in again in the same orientation and the phy stayed
initialized.

Cc: stable@vger.kernel.org # 6.15.x: 2ef1e78ef722: phy: samsung: usbdrd: propagate GS101 PIPE3 lock failures
Cc: stable@vger.kernel.org # 6.15.x
Fixes: 09dc674295a3 ("phy: exynos5-usbdrd: subscribe to orientation notifier if required")
Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
 drivers/phy/samsung/phy-exynos5-usbdrd.c | 61 ++++++++++++++++++++++++++++++--
 1 file changed, 58 insertions(+), 3 deletions(-)

diff --git a/drivers/phy/samsung/phy-exynos5-usbdrd.c b/drivers/phy/samsung/phy-exynos5-usbdrd.c
index 2186b745d58f..ccaf0f27c4c8 100644
--- a/drivers/phy/samsung/phy-exynos5-usbdrd.c
+++ b/drivers/phy/samsung/phy-exynos5-usbdrd.c
@@ -509,6 +509,7 @@ struct exynos5_usbdrd_phy_drvdata {
  * @regulators: regulators for phy
  * @sw: TypeC orientation switch handle
  * @orientation: TypeC connector orientation - normal or flipped
+ * @pipe3_initialized: gs101 PIPE3 phy is initialized (and not isolated)
  */
 struct exynos5_usbdrd_phy {
 	struct device *dev;
@@ -532,6 +533,7 @@ struct exynos5_usbdrd_phy {
 
 	struct typec_switch_dev *sw;
 	enum typec_orientation orientation;
+	bool pipe3_initialized;
 };
 
 static inline
@@ -1713,6 +1715,8 @@ static int exynos5_usbdrd_gs101_pipe3_init(struct exynos5_usbdrd_phy *phy_drd)
 	u32 reg;
 	int ret;
 
+	lockdep_assert_held(&phy_drd->phy_mutex);
+
 	exynos5_usbdrd_usbdp_g2_v4_ctrl_pma_ready(phy_drd);
 
 	/* force aux off */
@@ -1737,7 +1741,17 @@ static int exynos5_usbdrd_gs101_pipe3_init(struct exynos5_usbdrd_phy *phy_drd)
 	if (ret)
 		return ret;
 
-	return exynos5_usbdrd_usbdp_g2_v4_pma_check_cdr_lock(phy_drd);
+	ret = exynos5_usbdrd_usbdp_g2_v4_pma_check_cdr_lock(phy_drd);
+	if (ret)
+		return ret;
+
+	/*
+	 * Set this while still holding phy_mutex, so that the orientation
+	 * switch callback can't miss an orientation change.
+	 */
+	phy_drd->pipe3_initialized = true;
+
+	return 0;
 }
 
 static int exynos5_usbdrd_gs101_phy_init(struct phy *phy)
@@ -1783,6 +1797,9 @@ static int exynos5_usbdrd_gs101_phy_exit(struct phy *phy)
 		ret = exynos850_usbdrd_phy_exit(phy);
 		if (ret)
 			return ret;
+	} else {
+		scoped_guard(mutex, &phy_drd->phy_mutex)
+			phy_drd->pipe3_initialized = false;
 	}
 
 	exynos5_usbdrd_phy_isol(inst, true);
@@ -1880,8 +1897,48 @@ static int exynos5_usbdrd_orien_sw_set(struct typec_switch_dev *sw,
 
 	scoped_guard(mutex, &phy_drd->phy_mutex) {
 		void __iomem * const regs_base = phy_drd->reg_phy;
+		bool reinit_pipe3 = false;
 		unsigned int reg;
 
+		/*
+		 * The SS lanes are configured during PIPE3 init, for
+		 * TYPEC_ORIENTATION_NORMAL or else as reversed. If the PIPE3
+		 * phy is initialized already (e.g. the orientation is only
+		 * known after the USB controller probed) and the lanes have
+		 * to change, initialize it again, before signalling VBUS valid
+		 * to the controller. Rewriting the lane mux alone isn't enough
+		 * for the SS link to come up.
+		 *
+		 * TYPEC_ORIENTATION_NONE (unplug) isn't stored: while the PIPE3
+		 * phy is initialized, phy_drd->orientation is what the lanes are
+		 * programmed for, otherwise it is what the next PIPE3 init will
+		 * program.
+		 *
+		 * Don't return an error, so that the Type-C port manager still
+		 * configures the USB role.
+		 */
+		if (orientation != TYPEC_ORIENTATION_NONE) {
+			bool was_normal = (phy_drd->orientation ==
+					   TYPEC_ORIENTATION_NORMAL);
+			bool is_normal = (orientation ==
+					  TYPEC_ORIENTATION_NORMAL);
+
+			reinit_pipe3 = (phy_drd->pipe3_initialized &&
+					is_normal != was_normal);
+			phy_drd->orientation = orientation;
+		}
+
+		if (reinit_pipe3) {
+			const struct exynos5_usbdrd_phy_config *cfg =
+				phy_drd->phys[EXYNOS5_DRDPHY_PIPE3].phy_cfg;
+
+			ret = cfg->phy_init(phy_drd);
+			if (ret)
+				dev_warn(phy_drd->dev,
+					 "Failed to reconfigure SS lanes: %d\n",
+					 ret);
+		}
+
 		if (orientation == TYPEC_ORIENTATION_NONE) {
 			reg = readl(regs_base + EXYNOS850_DRD_UTMI);
 			reg &= ~(UTMI_FORCE_VBUSVALID | UTMI_FORCE_BVALID);
@@ -1900,8 +1957,6 @@ static int exynos5_usbdrd_orien_sw_set(struct typec_switch_dev *sw,
 			reg |= HSP_VBUSVLDEXTSEL | HSP_VBUSVLDEXT;
 			writel(reg, regs_base + EXYNOS850_DRD_HSP);
 		}
-
-		phy_drd->orientation = orientation;
 	}
 
 	clk_bulk_disable_unprepare(phy_drd->drv_data->n_clks, phy_drd->clks);

---
base-commit: 749a4de370409464cf8501ec5b2451df45c84eb4
change-id: 20261119-gs101-usb-phy-orientation-44cc8f14f020

Best regards,
-- 
André Draszik <andre.draszik@linaro.org>

