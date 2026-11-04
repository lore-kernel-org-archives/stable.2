Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793816560;
	b=wRYxL6QQDv1S/g0VtmM7rIjLMO6iTCIwbcInSTzQBsvN25m/w0lFjEIvKydM9ykjT8Z1
	 3LkORdGIr9ZXjI7uvnQR/HlcPW+n2x0uAdCK4LqT05Zwn85OTz0LCA5TyCHJFkTr6euef
	 lFMQVG79cfNOYzKXq3uqq1AXIHu0zKDAyMEVh5CvO7Kr9Gneoqty+Qy+dCw7wWcUnyTVn
	 Usf8isXKJhaP3DtT+BTupmmiUdloEa40SPYuzN2eYZ7IDKta3X6er106+w3w21EQaWNMB
	 X2JIFhJS1tKRi6MuOUbAZPh231k4AO3ve0woKLT0mKNza6QDMvXUudbfZJtYj4t2xpw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793816560;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Yo6BkmDzCdHosvq1ZJtX7h+XH8Z3on+/wuzIB4+u7aU=;
	b=QxVw77gBymcKwkwmiL/tQw0iinu2UoknNl1+QE3lFP1o2bf/Zyb3OK28zTsM1cDEBco0
	 69arTuDlbNm2uLEhEZMuibZMuTDPQbD/DqYMrXIG3jtqC6tYCqTnblOVZRX/283cLNmS7
	 uJTMhUhgvzteHQzro54jJJT/zHj/Z638y8jM4HmHPjUn5ljpqk7t2gpsrjWP+a/zOjBJJ
	 HaeP+Uv7h6YU0VfZ661NABmGM1aqQnWuhRm42gvdlM1Yb4uJccTFmVb8i5xx8H6APr2Ru
	 Emr5uindU5a61aKeXmEN7xLBebx/MnUDughDsfn7kb5i/MBo1nxn+Ss+JzAptrqTFVw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Yh18YsKN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A06EC606D2EF;
	Wed,  4 Nov 2026 18:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Yh18YsKN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 676121F000C1;
	Wed,  4 Nov 2026 18:22:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793816560;
	bh=Yo6BkmDzCdHosvq1ZJtX7h+XH8Z3on+/wuzIB4+u7aU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Yh18YsKNHNPbknW0PVVIXbmBI3tqJjpz6L3d5MyJ1aR4DvusiobwlQWdNspjMmGdI
	 kasOXT/SKCXcMrdfz6DHzSWO0p1JoAfnHREHZMRZ5NKy9RsVxc9EXdJ6u7cG+/d/gW
	 jn62ueKiNmVteqyjwG+5l+6ztOH0ayNcTqA+7yCl5+u0dZQEHSrvf8f7iEFxlrtTo6
	 5sEkk3lPkGtI1CHhycqWDF/NgpQ1GswPm1smkQYqew+RAMSBxkQAlSZz0zanrkuvVa
	 RqCfamItkMoJ9cztopH06Zkp1gNcdaDXK3Pd3yqH8Ydr/92WgwAIjOiMGLHJZNhASN
	 YOx1FLUeAAZtA==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Chris Morgan <macromorgan@hotmail.com>,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH 07/10] regulator: bq257xx: Propagate GPIO error in bq257xx_reg_dt_parse_gpio()
Date: Wed,  4 Nov 2026 18:20:57 +0000
Message-ID: <20261104182148.1176116-8-lee@kernel.org>
X-Mailer: git-send-email 2.56.0.398.g882cbad275-goog
In-Reply-To: <20261104182148.1176116-1-lee@kernel.org>
References: <20261104182148.1176116-1-lee@kernel.org>
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

When devm_fwnode_gpiod_get_index() fails with an error other than
-ENOENT (such as -EPROBE_DEFER), bq257xx_reg_dt_parse_gpio() logs the
error and returns void, leaving the error pointer stored in
pdata->otg_en_gpio.  bq257xx_regulator_probe() then registers the
regulator and bq25703_vbus_enable() / bq25703_vbus_disable() pass the
ERR_PTR to gpiod_set_value_cansleep().

Return the error code from bq257xx_reg_dt_parse_gpio() via
dev_err_probe() and propagate it from bq257xx_regulator_probe().

Fixes: 981dd162b635 ("regulator: bq257xx: Add bq257xx boost regulator driver")
Closes: https://sashiko.dev/#/bug/linux-0d1fc150-1400-4ba5-ad27-3d7376fb2d7d
Cc: stable@vger.kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/regulator/bq257xx-regulator.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/regulator/bq257xx-regulator.c b/drivers/regulator/bq257xx-regulator.c
index 577b277efd7f..0db99a74e9e8 100644
--- a/drivers/regulator/bq257xx-regulator.c
+++ b/drivers/regulator/bq257xx-regulator.c
@@ -103,7 +103,7 @@ static const struct regulator_desc bq25703_vbus_desc = {
 };
 
 /* Get optional GPIO for OTG regulator enable. */
-static void bq257xx_reg_dt_parse_gpio(struct platform_device *pdev)
+static int bq257xx_reg_dt_parse_gpio(struct platform_device *pdev)
 {
 	struct device_node *child, *subchild;
 	struct bq257xx_reg_data *pdata = platform_get_drvdata(pdev);
@@ -111,12 +111,12 @@ static void bq257xx_reg_dt_parse_gpio(struct platform_device *pdev)
 	child = of_get_child_by_name(pdev->dev.of_node,
 				     pdata->desc.regulators_node);
 	if (!child)
-		return;
+		return 0;
 
 	subchild = of_get_child_by_name(child, pdata->desc.of_match);
 	of_node_put(child);
 	if (!subchild)
-		return;
+		return 0;
 
 	pdata->otg_en_gpio = devm_fwnode_gpiod_get_index(&pdev->dev,
 							 of_fwnode_handle(subchild),
@@ -130,13 +130,14 @@ static void bq257xx_reg_dt_parse_gpio(struct platform_device *pdev)
 		if (PTR_ERR(pdata->otg_en_gpio) == -ENOENT) {
 			/* No GPIO, will only use register writes for OTG */
 			pdata->otg_en_gpio = NULL;
-			return;
+			return 0;
 		}
 
-		dev_err(&pdev->dev, "Error getting enable gpio: %ld\n",
-			PTR_ERR(pdata->otg_en_gpio));
-		return;
+		return dev_err_probe(&pdev->dev, PTR_ERR(pdata->otg_en_gpio),
+				     "Error getting enable gpio\n");
 	}
+
+	return 0;
 }
 
 static int bq257xx_regulator_probe(struct platform_device *pdev)
@@ -144,6 +145,7 @@ static int bq257xx_regulator_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct bq257xx_reg_data *pdata;
 	struct regulator_config cfg = {};
+	int ret;
 
 	device_set_of_node_from_dev(&pdev->dev, pdev->dev.parent);
 
@@ -154,7 +156,9 @@ static int bq257xx_regulator_probe(struct platform_device *pdev)
 	pdata->desc = bq25703_vbus_desc;
 
 	platform_set_drvdata(pdev, pdata);
-	bq257xx_reg_dt_parse_gpio(pdev);
+	ret = bq257xx_reg_dt_parse_gpio(pdev);
+	if (ret)
+		return ret;
 
 	cfg.dev = &pdev->dev;
 	cfg.driver_data = pdata;
-- 
2.56.0.385.gac671c819a-goog

