Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35F4153444F
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 11:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788952065; cv=none; b=ernFAH/gr/TMPRdVu7auLM0oMsgIHArY0Gw3EDoY8e1DN6BCOg4OFjQ0ut8JAKem/s4QLF96CJMLMoqzQ4emBoa3bwbZ1sqDJJ4D7et2DdHf3hbA0UaG7VQS7ritoS901Co+D/OBzsrw2he4Pm0pt12PK6oigyIde+vIGiXyqiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788952065; c=relaxed/simple;
	bh=vpqjBUjCUd4b+k1tRmZf9wOYjoHMtkk+27pWM3svxdk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jrl+Ue1WeDE7vlPEysDU3eRx23zZ0MbdsmZ0fNjjiZFyLuSy15YdAvXiRgEaWy3ww0HWNrYht5JDNduq0k2aYfgZf/Ayox6dfkDKdl9m/MJO+KAEHdn2S0BT93n1Ztjy+Aj+wVFdpVy4E5gXFilCYd4UHfFo2eYf/+c+ebFEUgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cu/VY0Vr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cu/VY0Vr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AAC51F01568;
	Wed,  9 Sep 2026 11:07:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788952061;
	bh=zbwQPU1DHj2kn5Sw1RoeTqzsGfMSY/O0ziC0PKyteLY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Cu/VY0Vrikud+orXB7ek9x7lPu8PqnfF4o7VvRB12S+7rIpRg4y9gvjeGFfzVgfT/
	 V25fkv84IlKYxvSpVsn1QdEPcud+SQY0PSVL8PxlLzXTvzOM/6ZajM0nYD3eV1rao4
	 yRrcFI3/FE6jF6d9buQnXhu5qY+gyT8u2pciUADlXYh+0gK89SIFMNLoFTzmx6zamH
	 MdMFSRUgVukvt2Xi2W9PlHI02cjcDFBJRPT9WmfBNlvfYUNiJh9gTfK4oIrS1JFV++
	 RaybIg9MYIo6PYGBf7I9chSoNqN9LlvoGpudZVSiqiuIRHEehMSjo6EixWb6oF9YWE
	 78b182vOquT4g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Andrew Davis <afd@ti.com>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/3] power: supply: lp8788: Use devm_power_supply_register() helper
Date: Wed,  9 Sep 2026 07:07:36 -0400
Message-ID: <20260909110737.1741580-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260909110737.1741580-1-sashal@kernel.org>
References: <2026090352-endanger-avenue-c367@gregkh>
 <20260909110737.1741580-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Andrew Davis <afd@ti.com>

[ Upstream commit 2abb571143c39f581df9951d263948726db42d86 ]

Use the device lifecycle managed register function. This helps prevent
mistakes like unregistering out of order in cleanup functions and
forgetting to unregister on error paths.

Signed-off-by: Andrew Davis <afd@ti.com>
Link: https://lore.kernel.org/r/20240123163653.384385-7-afd@ti.com
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Stable-dep-of: 831c29a12d56 ("power: supply: lp8788-charger: fix use-after-free on remove")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/power/supply/lp8788-charger.c | 21 ++++++---------------
 1 file changed, 6 insertions(+), 15 deletions(-)

diff --git a/drivers/power/supply/lp8788-charger.c b/drivers/power/supply/lp8788-charger.c
index 20694deb05275..54f663ba95700 100644
--- a/drivers/power/supply/lp8788-charger.c
+++ b/drivers/power/supply/lp8788-charger.c
@@ -406,12 +406,6 @@ static const struct power_supply_desc lp8788_psy_battery_desc = {
 	.get_property	= lp8788_battery_get_property,
 };
 
-static void lp8788_psy_unregister(struct lp8788_charger *pchg)
-{
-	power_supply_unregister(pchg->battery);
-	power_supply_unregister(pchg->charger);
-}
-
 static void lp8788_charger_event(struct work_struct *work)
 {
 	struct lp8788_charger *pchg =
@@ -667,18 +661,16 @@ static int lp8788_psy_register(struct platform_device *pdev,
 	charger_cfg.supplied_to = battery_supplied_to;
 	charger_cfg.num_supplicants = ARRAY_SIZE(battery_supplied_to);
 
-	pchg->charger = power_supply_register(&pdev->dev,
-					      &lp8788_psy_charger_desc,
-					      &charger_cfg);
+	pchg->charger = devm_power_supply_register(&pdev->dev,
+						   &lp8788_psy_charger_desc,
+						   &charger_cfg);
 	if (IS_ERR(pchg->charger))
 		return -EPERM;
 
-	pchg->battery = power_supply_register(&pdev->dev,
-					      &lp8788_psy_battery_desc, NULL);
-	if (IS_ERR(pchg->battery)) {
-		power_supply_unregister(pchg->charger);
+	pchg->battery = devm_power_supply_register(&pdev->dev,
+						   &lp8788_psy_battery_desc, NULL);
+	if (IS_ERR(pchg->battery))
 		return -EPERM;
-	}
 
 	return 0;
 }
@@ -721,7 +713,6 @@ static void lp8788_charger_remove(struct platform_device *pdev)
 
 	flush_work(&pchg->charger_work);
 	lp8788_irq_unregister(pdev, pchg);
-	lp8788_psy_unregister(pchg);
 }
 
 static struct platform_driver lp8788_charger_driver = {
-- 
2.53.0

