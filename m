Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792586104;
	b=H10kY3Ugyk6QzTsHgNzRyT4fRaXB6FpO46PTCRqvjqHq+S4pjX9IcQ50foCgj9RICHNz
	 DQH3qAqMo416A64fNVgGSMmV8pKv9KMVmA7g/6pWaBEleY0erSYl8knfOlLsBtG6YuR4E
	 Tkl9SVA2xN8mIDumF/4I34sIgHnRB2uk576ib8jhk8gt2IXe1H/fdk0oleha2YK7L0/9H
	 BI6Vr95vcEcQQX6KDB+1fdTvyBqCBNrVRmzhjtbp7XttCDoIXmB+ZpYOGPwccZa3Iory0
	 3GO2BGigcGpZE8+jjoi+nNY0tX/2Rfk0hHY/sZjr3g5NotBf1mKW+mwt9vf6wJvKrbg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792586104;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=4HHwPh4rEshU8o2SqCBOtfq1VQDPTtfMOkIFtYsIIX8=;
	b=HQ1u8Ev/L138WT8Ry9hUkzR84VEy4gL9YE0drpDNnnqmz88TmJuXwJ9MvRbiE+fkCpCL
	 +/nBkGSpf17P0pfHMdhIFKZl7bj96fkKPQ2OnFv+9Hi2+EacNlpleAts4hJBhlAD2IiFY
	 YUxqPCxnZMCE94LbUxKZXgqceDF9uV30jH+70BK1C2HtTsdL5FTJZOnshM5biwCwSGV4Z
	 dIzm4GPObEaHcTr5uiHgpHWqP4zT4VrYk/CSmH50jQ8uN9Mnb3qZNBr+mRLu/nArqnQS9
	 T/letca9zEGrKqmz0CSm1j9BtD/ZmRLNOjSfFp79paSE6OMMAAYfxd3qpIAALU0d7tg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XVieGYKr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E89860A4AD8;
	Wed, 21 Oct 2026 12:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XVieGYKr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E801D1F000C5;
	Wed, 21 Oct 2026 12:35:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792586104;
	bh=4HHwPh4rEshU8o2SqCBOtfq1VQDPTtfMOkIFtYsIIX8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XVieGYKrznQ+g0V1H1Lnm8B8cgMpC/EgAl9PBDICyh3YO9Pn5S7dykthf3BFPIVij
	 rSvIFDJknCChR7v0dmyM7o7w6BCpq2FpS//kNXDzb1iOan05IoJrlUeGCqF5Ft6J0W
	 6fhfbgaR4hdMnWteAldjqAckmRv+S8xQXppvyMtb4aRRTSKvRUDPQLVtPDpkx0bdKH
	 qlRp910Z3/1co2ofXK7AMFhwaDFh4/Pmo5YbK1eUb8Tf96LCTz9WYt0cs2SSlNPidN
	 27ePdrl/m1iduGBMfzqrn/g8rgfPh/4D51xrDgmh1QoTxsbXbsuJxxyegLQ9CiEQQN
	 pk4Tq5C787S3w==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Pavel Machek <pavel@kernel.org>,
	Luca Weiss <luca@lucaweiss.eu>,
	linux-leds@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH 08/21] leds: sgm3140: Replace powerdown timer with delayed work
Date: Wed, 21 Oct 2026 12:32:17 +0000
Message-ID: <20261021123406.3163547-9-lee@kernel.org>
X-Mailer: git-send-email 2.56.0.218.g1ec904b173-goog
In-Reply-To: <20261021123406.3163547-1-lee@kernel.org>
References: <20261021123406.3163547-1-lee@kernel.org>
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

sgm3140_powerdown_timer() runs in atomic timer softirq context and calls
regulator_disable(), which acquires sleepable mutexes, as well as
gpiod_set_value() on GPIOs that are otherwise driven via
gpiod_set_value_cansleep().

Replace powerdown_timer with a delayed_work item so that the powerdown
sequence executes in process context and can safely sleep when disabling
the regulator and driving the GPIOs.

Fixes: cef8ec8cbd21 ("leds: add sgm3140 driver")
Closes: https://sashiko.dev/#/bug/linux-8c3788a3-17f9-49dc-89be-c9f5844b0b95
Cc: stable@vger.kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/leds/flash/leds-sgm3140.c | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/drivers/leds/flash/leds-sgm3140.c b/drivers/leds/flash/leds-sgm3140.c
index dc6840357370..478573da1d61 100644
--- a/drivers/leds/flash/leds-sgm3140.c
+++ b/drivers/leds/flash/leds-sgm3140.c
@@ -6,6 +6,7 @@
 #include <linux/module.h>
 #include <linux/regulator/consumer.h>
 #include <linux/platform_device.h>
+#include <linux/workqueue.h>
 
 #include <media/v4l2-flash-led-class.h>
 
@@ -16,7 +17,7 @@ struct sgm3140 {
 	struct led_classdev_flash fled_cdev;
 	struct v4l2_flash *v4l2_flash;
 
-	struct timer_list powerdown_timer;
+	struct delayed_work powerdown_work;
 
 	struct gpio_desc *flash_gpio;
 	struct gpio_desc *enable_gpio;
@@ -52,10 +53,10 @@ static int sgm3140_strobe_set(struct led_classdev_flash *fled_cdev, bool state)
 		}
 		gpiod_set_value_cansleep(priv->flash_gpio, 1);
 		gpiod_set_value_cansleep(priv->enable_gpio, 1);
-		mod_timer(&priv->powerdown_timer,
-			  jiffies + usecs_to_jiffies(priv->timeout));
+		schedule_delayed_work(&priv->powerdown_work,
+				      usecs_to_jiffies(priv->timeout));
 	} else {
-		timer_delete_sync(&priv->powerdown_timer);
+		cancel_delayed_work_sync(&priv->powerdown_work);
 		gpiod_set_value_cansleep(priv->enable_gpio, 0);
 		gpiod_set_value_cansleep(priv->flash_gpio, 0);
 		ret = regulator_disable(priv->vin_regulator);
@@ -75,7 +76,7 @@ static int sgm3140_strobe_get(struct led_classdev_flash *fled_cdev, bool *state)
 {
 	struct sgm3140 *priv = flcdev_to_sgm3140(fled_cdev);
 
-	*state = timer_pending(&priv->powerdown_timer);
+	*state = delayed_work_pending(&priv->powerdown_work);
 
 	return 0;
 }
@@ -117,7 +118,7 @@ static int sgm3140_brightness_set(struct led_classdev *led_cdev,
 		gpiod_set_value_cansleep(priv->flash_gpio, 0);
 		gpiod_set_value_cansleep(priv->enable_gpio, 1);
 	} else {
-		timer_delete_sync(&priv->powerdown_timer);
+		cancel_delayed_work_sync(&priv->powerdown_work);
 		gpiod_set_value_cansleep(priv->flash_gpio, 0);
 		gpiod_set_value_cansleep(priv->enable_gpio, 0);
 		ret = regulator_disable(priv->vin_regulator);
@@ -133,12 +134,13 @@ static int sgm3140_brightness_set(struct led_classdev *led_cdev,
 	return 0;
 }
 
-static void sgm3140_powerdown_timer(struct timer_list *t)
+static void sgm3140_powerdown_work(struct work_struct *work)
 {
-	struct sgm3140 *priv = timer_container_of(priv, t, powerdown_timer);
+	struct sgm3140 *priv = container_of(work, struct sgm3140,
+					    powerdown_work.work);
 
-	gpiod_set_value(priv->enable_gpio, 0);
-	gpiod_set_value(priv->flash_gpio, 0);
+	gpiod_set_value_cansleep(priv->enable_gpio, 0);
+	gpiod_set_value_cansleep(priv->flash_gpio, 0);
 	regulator_disable(priv->vin_regulator);
 
 	priv->enabled = false;
@@ -235,7 +237,7 @@ static int sgm3140_probe(struct platform_device *pdev)
 	 */
 	priv->timeout = min(priv->max_timeout, FLASH_TIMEOUT_DEFAULT);
 
-	timer_setup(&priv->powerdown_timer, sgm3140_powerdown_timer, 0);
+	INIT_DELAYED_WORK(&priv->powerdown_work, sgm3140_powerdown_work);
 
 	fled_cdev = &priv->fled_cdev;
 	led_cdev = &fled_cdev->led_cdev;
@@ -284,7 +286,7 @@ static void sgm3140_remove(struct platform_device *pdev)
 {
 	struct sgm3140 *priv = platform_get_drvdata(pdev);
 
-	timer_delete_sync(&priv->powerdown_timer);
+	cancel_delayed_work_sync(&priv->powerdown_work);
 
 	v4l2_flash_release(priv->v4l2_flash);
 }
-- 
2.56.0.218.g1ec904b173-goog

