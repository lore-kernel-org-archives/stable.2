Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795810312;
	b=MQWz+78zWpumHakxYem1uElwJ3x1nGz/t7OG57sf19O0moinGcO5ceQomnGxbflGbWYO
	 MjjUWwTEJxqBTysUb4aBlJo97hlB7b4dBOf+FA8RRUX2OsDZZmWVroMF5/zqVtoHOkD/G
	 wj2GzRK7D2CxLSPH+wXO9I2EaWENKenbbCGeDMaf4sLT4RZfFnc0xrBEU/uViS4Lk9cJo
	 g38cFeN24NX0wY1Ifhn8V8zAHhS6L/Yh0hv//lOwwL22d51vGoYAWy0QrtA//a6pvjnBo
	 RuQD7/nbicC78dBEnfC7be9Okfys8Da+y1+ukPG8NPFPDo7y+NVsnh4NhWGodFRbeLQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795810312;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=3v7gurQzooBPqI/Pghyoa7hB9i6x5nWr3F6I99hSAHs=;
	b=fryNisRpvlO8bQdi3j1T1nhWXiBBotIB/zhYrE5SoD0LVjpiPjXtqzdgzznb4wCgHZAi
	 lX0PEPBBSzpUI8uNTrJXwGZJAGkjlT4etw6bi4X8ozYjjZUX5bI5SqJlCUBL+YSbOnp0g
	 tJuAsb0Or0YPsTluD9gqwF2uIH2KBH+nE4LfQZ41kPc+d2BPKMLEZvcXwVPuFzk/v6DiI
	 zWGfP1Z1SNKqp2RBfpXGYV1ZmAK2lnmTZMmkb32TaEuaHcjaNXtwdOh8SUcptL2R98nub
	 GL5ki0PwdS+pPlDT/yayqhlWd3iMfmKD7QCSdiLaJ8+6Wd0ho+dXZkJwb0Mj3KBGAWg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hnW85OQQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5FE6606A682;
	Fri, 27 Nov 2026 20:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hnW85OQQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2705B1F00899;
	Fri, 27 Nov 2026 20:11:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795810312;
	bh=3v7gurQzooBPqI/Pghyoa7hB9i6x5nWr3F6I99hSAHs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hnW85OQQLieWue5wAdBHtwg3z+6Ot+mg0Ep6Xr8K3oJXidWUmXODRvjn4TjTAWdc/
	 h7MmOPd/i1v7wJp23qv9Zq0QfjKbH9IoejnJatR7tMw4I9OlYR8/IL/5/tySSHp4TE
	 GyxQcGqs8FFYd8as1OKzvH7qAi8pv3SglfSeTGqXvL3N7a7OKzBARd5qTqiwHoRyaT
	 n/wHCCzsF9vfYt5VVj/FJZ6JfKc7lBKCMewU2PzbWdFcE+NCFJ1VPw01j9JynYeG1v
	 P5sktMMImEkYN6WFiCr0nqmn/oJA6WXQa4naQunC2ctV9zaSqftn0CloyNV1BRwVOA
	 AnQKhUD5LFODA==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>,
	Dan Murphy <dmurphy@ti.com>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH 08/10] Input: drv2667 - disable haptics work across suspend and resume
Date: Fri, 27 Nov 2026 20:10:02 +0000
Message-ID: <20261127201050.3532488-9-lee@kernel.org>
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

drv2667_suspend() puts the device into standby and disables its
regulator without stopping haptics->work.  A pending or timer-scheduled
haptics worker can therefore execute I2C regmap transactions while the
chip is unpowered or the I2C bus is suspended, including when the input
device is inhibited.

Call disable_work_sync() unconditionally in drv2667_suspend() before
entering standby (re-enabling on suspend error) and call enable_work()
unconditionally in drv2667_resume() so the disable count always remains
balanced across suspend/resume cycles.

Fixes: 1c24622572d6 ("Input: add support for the DRV2667 haptic driver")
Closes: https://sashiko.dev/#/bug/linux-b8ddefd2-393d-487e-8c76-2dbc5ef46b64
Cc: stable@vger.kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/input/misc/drv2667.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/input/misc/drv2667.c b/drivers/input/misc/drv2667.c
index 18cf689d7ef7..3326aeb9874e 100644
--- a/drivers/input/misc/drv2667.c
+++ b/drivers/input/misc/drv2667.c
@@ -405,12 +405,15 @@ static int drv2667_suspend(struct device *dev)
 
 	guard(mutex)(&haptics->input_dev->mutex);
 
+	disable_work_sync(&haptics->work);
+
 	if (input_device_enabled(haptics->input_dev)) {
 		error = regmap_update_bits(haptics->regmap, DRV2667_CTRL_2,
 					   DRV2667_STANDBY, DRV2667_STANDBY);
 		if (error) {
 			dev_err(dev, "Failed to set standby mode\n");
 			regulator_disable(haptics->regulator);
+			enable_work(&haptics->work);
 			return error;
 		}
 
@@ -420,6 +423,7 @@ static int drv2667_suspend(struct device *dev)
 			regmap_update_bits(haptics->regmap,
 					   DRV2667_CTRL_2,
 					   DRV2667_STANDBY, 0);
+			enable_work(&haptics->work);
 			return error;
 		}
 	}
@@ -430,7 +434,7 @@ static int drv2667_suspend(struct device *dev)
 static int drv2667_resume(struct device *dev)
 {
 	struct drv2667_data *haptics = dev_get_drvdata(dev);
-	int error;
+	int error = 0;
 
 	guard(mutex)(&haptics->input_dev->mutex);
 
@@ -438,7 +442,7 @@ static int drv2667_resume(struct device *dev)
 		error = regulator_enable(haptics->regulator);
 		if (error) {
 			dev_err(dev, "Failed to enable regulator\n");
-			return error;
+			goto out;
 		}
 
 		error = regmap_update_bits(haptics->regmap, DRV2667_CTRL_2,
@@ -446,12 +450,13 @@ static int drv2667_resume(struct device *dev)
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
 
 static DEFINE_SIMPLE_DEV_PM_OPS(drv2667_pm_ops, drv2667_suspend, drv2667_resume);
-- 
2.56.1.839.g22a8290db9-goog

