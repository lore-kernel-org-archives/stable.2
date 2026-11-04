Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793817596;
	b=Fg5lkaWA9imeeBy8XkmYQCI+8RQvn/q6xoVlEz0aOOeYMfL6DgXGcbg+3upHhquBB54B
	 0/vs+Vyxzjf0JxM5seH2NSgbuF3g36af4ZvUGqhdzvrY25wiCPOUJbcTyJzpw8wdFDIRz
	 4ZjiR7NCcyOEuyU4sUQBlZm8rxfji98tj30CEJLR5XIJpew1kxvuG4kOo1ZTckRZQnVde
	 B7Rg4i8qvLn2p7phbfzeUiK/OC1vvL9w9EPMBXCEB83PrZGXj+B/VY2O6yChOkMvIhLy5
	 fOcCdGLRL+Jlel5+JQQlyDzR0zbsf8wkauFbwoGv//Svg1ZX5g9eN4zsD37dgWbfoCw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793817596;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=WrWVnFt+gMmW6UyySZSsEBy9rc04kufaU+4Np6Ge3dQ=;
	b=38gZXZMemFf+HwMTAWfT9HN5QBK4wUxBs5enH8xXtjvWH9+SYqHLurFmDfR0QCXSMMQX
	 3Ts2KAAg69MV+gvAdOKxQVeg/dyxn1FFR84l35eMnI/0aK4CmK4Qr4sXzayFCtf9HL6sZ
	 xC5T5s56m7M328NPH9Eybm72sVGVlrgbjcGLNEx9mhsUAqMa3SkhiUj3nhCjnYTzqyvOm
	 F+5c3fFTfzQwfH0KmmixCw6sE3tOgvnvC51enPDTKktfHl0z4pT0B/I7DW2GfHfNauNSC
	 ib3pVKkYVqYBWey14N1P5Gn3gon5uccM8DAwbJ8xgoPM3Ze1HE/vgHntmxUo/mTXAJQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=b3wnpglg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B21B5606A332;
	Wed,  4 Nov 2026 18:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=b3wnpglg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAEF81F0093A;
	Wed,  4 Nov 2026 18:39:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793817595;
	bh=WrWVnFt+gMmW6UyySZSsEBy9rc04kufaU+4Np6Ge3dQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=b3wnpglgLK3cQAqmikW2pMiOWnTHyjagncLsUiwv7og2dLlaaVotGdsQeiwp3YvGS
	 N5l8eQLuoLHIaGZcpQRrXIj5RvFTS1Ny12EfUEqVSgLFCh7EtG/SM7v5Zmf38B/r76
	 R3jqEI1JrbbrrpWBnKc6/B64YDHfXo6w1exIDVPFVAoV1WBbtHLHeI4uPtOrjdQW6U
	 0GHwf854bfASfAyFOu0C2nzb+uh+PGXYBiTRmdXgRoR0QJSFfzjXgkXYjtbUx0UBPD
	 Z33g85oRRBsn3qWOaYPU/28uYtav46pk5SfrTIIYKA5sT0MDpqeMnNU0YIYVe07r5g
	 9KtxfU+jkamcQ==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Daniel Thompson <danielt@kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>,
	Helge Deller <deller@gmx.de>,
	Jin Park <jinyoungp@nvidia.com>,
	Samuel Ortiz <sameo@linux.intel.com>,
	dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH 2/6] backlight: aat2870: Initialise driver data before registering backlight
Date: Wed,  4 Nov 2026 18:39:03 +0000
Message-ID: <20261104183935.1214630-3-lee@kernel.org>
X-Mailer: git-send-email 2.56.0.398.g882cbad275-goog
In-Reply-To: <20261104183935.1214630-1-lee@kernel.org>
References: <20261104183935.1214630-1-lee@kernel.org>
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

aat2870_bl_probe() currently registers the backlight device via
devm_backlight_device_register() before initialising its private driver
data (aat2870_bl->pdev, channels, and max_current) and backlight
properties (max_brightness, power, and brightness).

Because devm_backlight_device_register() immediately exposes the
backlight sysfs interface to userspace, a concurrent sysfs write to
attributes such as brightness invokes aat2870_bl_update_status() while
aat2870_bl->pdev is still NULL, causing a NULL pointer dereference.  In
addition, aat2870_brightness() reads the backlight_device pointer from
aat2870_bl->bd (which is only assigned after registration returns)
rather than using the backlight_device pointer passed into
aat2870_bl_update_status().

Populate the driver data and backlight_properties structure prior to
calling devm_backlight_device_register(), and pass the backlight_device
pointer directly to aat2870_brightness().

Fixes: 4b0d711be39f ("backlight: Add AAT2870 backlight driver")
Closes: https://sashiko.dev/#/bug/linux-9a61532b-5d7a-467d-b3d1-d6420978c8f3
Cc: stable@vger.kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/video/backlight/aat2870_bl.c | 43 ++++++++++++++--------------
 1 file changed, 21 insertions(+), 22 deletions(-)

diff --git a/drivers/video/backlight/aat2870_bl.c b/drivers/video/backlight/aat2870_bl.c
index 8b790df1e842..53eaa3e1e7a3 100644
--- a/drivers/video/backlight/aat2870_bl.c
+++ b/drivers/video/backlight/aat2870_bl.c
@@ -24,10 +24,10 @@ struct aat2870_bl_driver_data {
 	int brightness; /* current brightness */
 };
 
-static inline int aat2870_brightness(struct aat2870_bl_driver_data *aat2870_bl,
+static inline int aat2870_brightness(struct backlight_device *bd,
 				     int brightness)
 {
-	struct backlight_device *bd = aat2870_bl->bd;
+	struct aat2870_bl_driver_data *aat2870_bl = bl_get_data(bd);
 	int val;
 
 	val = brightness * (aat2870_bl->max_current - 1);
@@ -70,7 +70,7 @@ static int aat2870_bl_update_status(struct backlight_device *bd)
 		 bd->props.brightness, bd->props.power, bd->props.state);
 
 	ret = aat2870->write(aat2870, AAT2870_BLM,
-			     (u8)aat2870_brightness(aat2870_bl, brightness));
+			     (u8)aat2870_brightness(bd, brightness));
 	if (ret < 0)
 		return ret;
 
@@ -122,24 +122,9 @@ static int aat2870_bl_probe(struct platform_device *pdev)
 		goto out;
 	}
 
-	memset(&props, 0, sizeof(struct backlight_properties));
-
-	props.type = BACKLIGHT_RAW;
-	bd = devm_backlight_device_register(&pdev->dev, "aat2870-backlight",
-					&pdev->dev, aat2870_bl, &aat2870_bl_ops,
-					&props);
-	if (IS_ERR(bd)) {
-		dev_err(&pdev->dev,
-			"Failed allocate memory for backlight device\n");
-		ret = PTR_ERR(bd);
-		goto out;
-	}
-
 	aat2870_bl->pdev = pdev;
 	platform_set_drvdata(pdev, aat2870_bl);
 
-	aat2870_bl->bd = bd;
-
 	if (pdata->channels > 0)
 		aat2870_bl->channels = pdata->channels;
 	else
@@ -150,14 +135,28 @@ static int aat2870_bl_probe(struct platform_device *pdev)
 	else
 		aat2870_bl->max_current = AAT2870_CURRENT_27_9;
 
+	memset(&props, 0, sizeof(struct backlight_properties));
+
+	props.type = BACKLIGHT_RAW;
 	if (pdata->max_brightness > 0)
-		bd->props.max_brightness = pdata->max_brightness;
+		props.max_brightness = pdata->max_brightness;
 	else
-		bd->props.max_brightness = 255;
+		props.max_brightness = 255;
 
 	aat2870_bl->brightness = 0;
-	bd->props.power = BACKLIGHT_POWER_ON;
-	bd->props.brightness = bd->props.max_brightness;
+	props.power = BACKLIGHT_POWER_ON;
+	props.brightness = props.max_brightness;
+
+	bd = devm_backlight_device_register(&pdev->dev, "aat2870-backlight",
+					    &pdev->dev, aat2870_bl,
+					    &aat2870_bl_ops, &props);
+	if (IS_ERR(bd)) {
+		dev_err(&pdev->dev,
+			"Failed allocate memory for backlight device\n");
+		ret = PTR_ERR(bd);
+		goto out;
+	}
+	aat2870_bl->bd = bd;
 
 	ret = aat2870_bl_update_status(bd);
 	if (ret < 0) {
-- 
2.56.0.385.gac671c819a-goog

