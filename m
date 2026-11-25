Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795640264;
	b=wvgHXTy53ses3uVu61DM35jomjCk30mJb52nPdeNidLZ3Pt54F/Gjxb6ug+RNj20gdks
	 1DEiL2HsFZsRxBx+8qO0NzayWTBpWeUMD28MaIbWo6VbARNF8/rnaHgEkyXNejeVt5/L+
	 Ff/fl/KKXlG7MGqBElRUhdHmVI6SWCPct2VoM+WO9N4eQvfyTgynUwwZ5ef6eVJuGEapd
	 K1YmDqKsWEO8A78xhHUDlI61Ucj76Cat13YA/AIQ18iFNsvbdaNd6ZJXJwe7FChF+7d16
	 0kuhFz1LKo+9vwDvV+SU42SIIl6yPQHZJACu+E6OzrDBCzifnSzIA8MXKTBuNgWhoGQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795640264;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=/SmMtYyBPwSZXTQ550J+XLVhisinAxeecSwCXQFBhX0=;
	b=zDVx1S3PdnoL9ist8NokX+L5+qY/OxvZcLR9eGqzyo459MgXJxx/g4JCkrAzPhkRCVak
	 UgdmwWsR8tfRW7ztqASKlp6eZm8BkxR/KNaH/I0q2gGqvpXfX9cxs4nJFnUTsu/lrhqAu
	 GqXsoKp3XbozgTb8Tq9eYUkRIP5m8vIBbcFaHF+wdIi3RbC9aXY4H3rDe/SmnnKde4K8o
	 CBhFSHqWuYa9igEF5imreSsmuYDw07KeQmJqH0glgDPHJFFxI0PAWeBScBu8oANxpQd9S
	 V2IvzTZ4uhhlfWax/yhMkMDeS0R7jBSN4+mv9IXCx4eA9lA+JC9f6vXdXFbOTAafNPw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DivM0DRJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40196606A31E
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 20:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DivM0DRJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 895AF1F000C0;
	Wed, 25 Nov 2026 20:57:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795640264;
	bh=/SmMtYyBPwSZXTQ550J+XLVhisinAxeecSwCXQFBhX0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DivM0DRJ+IotYkwUzOZ11NHe8as0CICiD10RBC/QSlIoPVdhnRO/Vn3HJHBFQnlNK
	 EFpuV904cM958Oiavc2zsW2/DSGV4Z583fKlyDqd5mHG6k3+91mmNwQEwQ+svfyykE
	 ynghTc5I2HfFxw2MxxSbkOuStzV96waw6SIRU186OUk2UaBjjn7dMkmSKzekFFRxpk
	 FymBD8Sa0Ggm3ep15mYXCLWpOPccOskqwvRWInTe9iJRg442P3jgQPgao2ahNVvSC5
	 LhKs8+2zKFGewOOOTCyW8MyjMweEQZpAc+jbijfjJtC9ZNBZOexiSZDc7ai+ln9NZQ
	 6vgVaa0UwcgwQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Wentao Liang <vulab@iscas.ac.cn>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] gpio: keep the chip reference when deferred setup fails
Date: Wed, 25 Nov 2026 15:57:42 -0500
Message-ID: <20261125205720.1491832-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112507-repossess-kinsman-0ff2@gregkh>
References: <2026112507-repossess-kinsman-0ff2@gregkh>
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

From: Wentao Liang <vulab@iscas.ac.cn>

[ Upstream commit 7e899fe007d2ffc753e6aa5bc8f2ae0a802b9e07 ]

gpiochip_setup_devs() runs once gpiolib has been initialized and
finishes the registration of the chips that were added before that.
When the registration of such a chip fails, the function drops the
reference taken in gpiochip_add_data_with_key() with
gpio_device_put(), and only then logs the error through &gdev->dev.

For these chips that reference is the last one, so gpiodev_release()
frees gdev: the dev_err() dereferences freed memory, and the chip is
still linked in gpio_devices, so the next lookup walks into the freed
object as well.  Here the registration cannot be undone the way
gpiochip_add_data_with_key() does it, as the driver already got success
from gpiochip_add_data() and will call gpiochip_remove(), which unlinks
the chip and drops the reference.

Keep the reference and only report the failure.

Fixes: 16fdabe143fc ("gpio: Fix resource leaks on errors in gpiochip_add_data_with_key()")
Cc: stable@vger.kernel.org
Assisted-by: DeepSeek-V4.1-Flash and OpenAI Codex
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
Link: https://patch.msgid.link/20261104025345.1527526-1-vulab@iscas.ac.cn
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
[ sashal: Adjusted the gpiochip_setup_dev() prototype and its call site to take struct gpio_device *gdev instead of struct gpio_chip *gc, since this tree has no per-chip gc lookup in that loop. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpio/gpiolib.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index c9dae5cf4db34..b3a557c41fa91 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -787,7 +787,8 @@ static const struct device_type gpio_dev_type = {
 
 /*
  * An initial reference count has been held in gpiochip_add_data_with_key().
- * The caller should drop the reference via gpio_device_put() on errors.
+ * A caller that tears the chip down on errors must drop the reference via
+ * gpio_device_put().
  */
 static int gpiochip_setup_dev(struct gpio_device *gdev)
 {
@@ -860,12 +861,16 @@ static void gpiochip_setup_devs(void)
 
 	list_for_each_entry_srcu(gdev, &gpio_devices, list,
 				 srcu_read_lock_held(&gpio_devices_srcu)) {
+		/*
+		 * The reference taken in gpiochip_add_data_with_key() is
+		 * dropped by gpiochip_remove(): this chip is still registered
+		 * and its driver has not been told about the failure, so the
+		 * reference must be kept here.
+		 */
 		ret = gpiochip_setup_dev(gdev);
-		if (ret) {
-			gpio_device_put(gdev);
+		if (ret)
 			dev_err(&gdev->dev,
 				"Failed to initialize gpio device (%d)\n", ret);
-		}
 	}
 }
 
-- 
2.53.0

