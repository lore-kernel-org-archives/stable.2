Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795810306;
	b=RDBi5g/nara/ss8tgmoiB2C4kaeRh7MayrFvxtI8HDAUUUuZItlY7+EVR8htjodbfUtP
	 c57c5Z64eeFKI/OQMdzzG0MrkHJA9yOVr4mVhJ0ShArC5ft77+QxP/mXZRNneUhkasQDu
	 qryOyNk0u/LD8DK+/1iy1KJJts07Am2f3E51iIWdSNpszxL68W0tC8IkVlsygg3qRBbkK
	 yyvkLfJeI7iT8eZxdTSVyFGBDR3gJTbIHZd0fjw+F3LtaCszoYYmo6iLvUFbZUgO5uFpF
	 gOyE5EsXA2MwUohzGqTRwA3i1KpuJ7qeUcnxYdnPEsCElexvGgnYE0MNj4lj7csis9w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795810306;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=/aO07p9edFZdoG2hB8TFUOLNKp+B/c/NIsghkzVaaxc=;
	b=dlWPfvY/jMxBfrfShMaQNCFhKBHvv4mljmO83wptQL4224yEAU31XSvWIOp+5PMAti6N
	 oOpSVr7WHNgwd+YulYYwES1mcs8TaMYAr8K9+Vy0eLaBB/ojFAjdh5EVy09mX1zd22WpM
	 VEDuQu7erjEQ/2xDglBqQcy+tYn4aivQI4Viq4mUo29tnqNWOiZI3jlQcRrgq6WmZJAzN
	 PA/vjOMeIDl3IWMD3+aHz9437SFngctELUhP7AYaLdrL+qUwNhvvl0feLgBdlfH7Fj1Yd
	 6Kftv4ZyeIULPbxV/b4jQZZM5Fgfa6+ZfpUpY0izfb/Fhig7x9LUBEqd+hLPcN703kA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VbT6ANcB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AA26606A31C;
	Fri, 27 Nov 2026 20:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VbT6ANcB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C682C1F00919;
	Fri, 27 Nov 2026 20:11:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795810306;
	bh=/aO07p9edFZdoG2hB8TFUOLNKp+B/c/NIsghkzVaaxc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VbT6ANcBM/6KWc2eB994TNVUEPChfxuqbA7QutenW1oIhd70aCMlt0HsJCCL9TmBh
	 aYZFWaCDSZ5hfe6BpafJOYFMG4fvAxOfTxlbYEa+jhmilbEooYnjb1oUSXLkXD9GGD
	 SXZduO3kkeQy9KrYhzixcJR4CliaNVGMirS0EkylxxGnnw7qyBBAFeSmqA5cbdxtKa
	 ZsxDnYFCFGDTR3B6IIRb0wZ++Pv+EZONewDNYGQxdqhjLoDBvNVeFIl0JCsBG29jz/
	 EEqx1VJmfUnSLE3KJq5625C7pxjsSIUcuzHApMH41gIyxNkhtPIGpCYwwYbIqb7dIU
	 tQi1HOb86s12w==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>,
	Dan Murphy <dmurphy@ti.com>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH 07/10] Input: drv2665 - disable haptics work across suspend and resume
Date: Fri, 27 Nov 2026 20:10:01 +0000
Message-ID: <20261127201050.3532488-8-lee@kernel.org>
X-Mailer: git-send-email 2.56.1.839.g22a8290db9-goog
In-Reply-To: <20261127201050.3532488-1-lee@kernel.org>
References: <20261127201050.3532488-1-lee@kernel.org>
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

drv2665_suspend() puts the device into standby and disables its
regulator without stopping haptics->work.  A pending or timer-scheduled
haptics worker can therefore execute I2C regmap transactions while the
chip is unpowered or the I2C bus is suspended, including when the input
device is inhibited.

Call disable_work_sync() unconditionally in drv2665_suspend() before
entering standby (re-enabling on suspend error) and call enable_work()
unconditionally in drv2665_resume() so the disable count always remains
balanced across suspend/resume cycles.

Fixes: 4d10da13467e ("Input: add TI drv2665 haptics driver")
Closes: https://sashiko.dev/#/bug/linux-c1b30f7c-1836-440f-8a6a-75ada49be7d5
Cc: stable@vger.kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/input/misc/drv2665.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/input/misc/drv2665.c b/drivers/input/misc/drv2665.c
index 90407f8797c7..3ade96308192 100644
--- a/drivers/input/misc/drv2665.c
+++ b/drivers/input/misc/drv2665.c
@@ -228,12 +228,15 @@ static int drv2665_suspend(struct device *dev)
 
 	guard(mutex)(&haptics->input_dev->mutex);
 
+	disable_work_sync(&haptics->work);
+
 	if (input_device_enabled(haptics->input_dev)) {
 		error = regmap_update_bits(haptics->regmap, DRV2665_CTRL_2,
 					   DRV2665_STANDBY, DRV2665_STANDBY);
 		if (error) {
 			dev_err(dev, "Failed to set standby mode\n");
 			regulator_disable(haptics->regulator);
+			enable_work(&haptics->work);
 			return error;
 		}
 
@@ -243,6 +246,7 @@ static int drv2665_suspend(struct device *dev)
 			regmap_update_bits(haptics->regmap,
 					   DRV2665_CTRL_2,
 					   DRV2665_STANDBY, 0);
+			enable_work(&haptics->work);
 			return error;
 		}
 	}
@@ -253,7 +257,7 @@ static int drv2665_suspend(struct device *dev)
 static int drv2665_resume(struct device *dev)
 {
 	struct drv2665_data *haptics = dev_get_drvdata(dev);
-	int error;
+	int error = 0;
 
 	guard(mutex)(&haptics->input_dev->mutex);
 
@@ -261,7 +265,7 @@ static int drv2665_resume(struct device *dev)
 		error = regulator_enable(haptics->regulator);
 		if (error) {
 			dev_err(dev, "Failed to enable regulator\n");
-			return error;
+			goto out;
 		}
 
 		error = regmap_update_bits(haptics->regmap, DRV2665_CTRL_2,
@@ -269,12 +273,13 @@ static int drv2665_resume(struct device *dev)
 		if (error) {
 			dev_err(dev, "Failed to unset standby mode\n");
 			regulator_disable(haptics->regulator);
-			return error;
+			goto out;
 		}
-
 	}
 
-	return 0;
+out:
+	enable_work(&haptics->work);
+	return error;
 }
 
 static DEFINE_SIMPLE_DEV_PM_OPS(drv2665_pm_ops, drv2665_suspend, drv2665_resume);
-- 
2.56.1.839.g22a8290db9-goog

