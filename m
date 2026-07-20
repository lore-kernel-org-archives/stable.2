Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79FFD19049B
	for <stable@vger.kernel.org>; Mon, 20 Jul 2026 02:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784514343; cv=none; b=CJhxC72DoZm+9D+/OA+p7LvZix554UEF6HzXBmKe4InGvzC9zcYhQBuUAss1uq/Jt7ohia5WaqluULtYUwylgAyHjaewFIgDBn2AdfJKFjelOYut18ErYde9/FnVe91tXrGYTaJO2bU039aBAq5nY8fbP93nAEAGM8mvC6a41uM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784514343; c=relaxed/simple;
	bh=ACjAPGjoItH8JZPtzwkIPh2/bcGu+QDNLdcnR8Rc9rk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YtVmvy5AP7yeGjj+zzdK1mpa06us3RkOL3lhSoLaUI63UQ9x+Rh7XqQ3nvIiBTqowWakOQAO3kGYhWnzpSIJZHjY5gW59cVFGvu/QbA7lFYSUdNhbewb055yVUTVTmkwbmEVbkhaZwxaGF5h9vA6TJDLPIHXQ0mYNzfG4YQ+NuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QvLm05mv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QvLm05mv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D1871F00A3A;
	Mon, 20 Jul 2026 02:25:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784514342;
	bh=brOE4XBxe0VaJhziKMOpLAYEYPC+D+EZsJDsN7Vt1Vs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QvLm05mv5oZyboK/5g3XUxL6LCWXNBgiQjtTYWRZIH9Ro2sn9lFwKR3aA7pnZN4s5
	 eOY9b8Aa0LOR1+AAsCmBezutWOF134puOaD3Of7elqFcuwEDina4V19fvJ4uzDoiUZ
	 vD5hSnXxYmzK0BQmSYwqB+NjlOmGjBHLqp1HdpoU+8/Hes+M/Nn6BWuUoB/P4ACK1y
	 ye3Ia8PVblUOEuU76hxJgCt0bfprLco7oLdWLqbWo/ct8UYyfyahru4QQQrGcxw6e3
	 2NiECv6I/RkBSMQNobe6Z/hIRBmtK378wg2ADVIC/m4UPUShEuOGi7p19ksKctgNft
	 sOCRVA/Mzbliw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Wolfram Sang <wsa@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 4/5] gpio: pca953x: Make platform teardown callback return void
Date: Sun, 19 Jul 2026 22:25:36 -0400
Message-ID: <20260720022537.2927284-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260720022537.2927284-1-sashal@kernel.org>
References: <2026071422-comment-stardust-654c@gregkh>
 <20260720022537.2927284-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

[ Upstream commit 6a8f359c3132e4f51bdb263ad74ec632c65e55fd ]

All platforms that provide a teardown callback return 0. New users are
supposed to not make use of platform support, so there is no
functionality lost.

This patch is a preparation for making i2c remove callbacks return void.

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Acked-by: Bartosz Golaszewski <brgl@bgdev.pl>
Signed-off-by: Wolfram Sang <wsa@kernel.org>
Stable-dep-of: 1f0bdc2884b6 ("usb: typec: ucsi: ccg: Fix use-after-free of ucsi on remove")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/mach-davinci/board-da850-evm.c | 12 ++++--------
 drivers/gpio/gpio-pca953x.c             | 11 +++--------
 include/linux/platform_data/pca953x.h   |  2 +-
 3 files changed, 8 insertions(+), 17 deletions(-)

diff --git a/arch/arm/mach-davinci/board-da850-evm.c b/arch/arm/mach-davinci/board-da850-evm.c
index 1601a74261a67b..71bd7c53048c5c 100644
--- a/arch/arm/mach-davinci/board-da850-evm.c
+++ b/arch/arm/mach-davinci/board-da850-evm.c
@@ -517,8 +517,8 @@ static int da850_evm_ui_expander_setup(struct i2c_client *client, unsigned gpio,
 	return ret;
 }
 
-static int da850_evm_ui_expander_teardown(struct i2c_client *client,
-					unsigned gpio, unsigned ngpio, void *c)
+static void da850_evm_ui_expander_teardown(struct i2c_client *client,
+					   unsigned gpio, unsigned ngpio, void *c)
 {
 	platform_device_unregister(&da850_evm_ui_keys_device);
 
@@ -530,8 +530,6 @@ static int da850_evm_ui_expander_teardown(struct i2c_client *client,
 	gpio_free(gpio + DA850_EVM_UI_EXP_SEL_C);
 	gpio_free(gpio + DA850_EVM_UI_EXP_SEL_B);
 	gpio_free(gpio + DA850_EVM_UI_EXP_SEL_A);
-
-	return 0;
 }
 
 /* assign the baseboard expander's GPIOs after the UI board's */
@@ -698,13 +696,11 @@ static int da850_evm_bb_expander_setup(struct i2c_client *client,
 	return ret;
 }
 
-static int da850_evm_bb_expander_teardown(struct i2c_client *client,
-					unsigned gpio, unsigned ngpio, void *c)
+static void da850_evm_bb_expander_teardown(struct i2c_client *client,
+					   unsigned gpio, unsigned ngpio, void *c)
 {
 	platform_device_unregister(&da850_evm_bb_leds_device);
 	platform_device_unregister(&da850_evm_bb_keys_device);
-
-	return 0;
 }
 
 static struct pca953x_platform_data da850_evm_ui_expander_info = {
diff --git a/drivers/gpio/gpio-pca953x.c b/drivers/gpio/gpio-pca953x.c
index a8f6ef4006fef9..94c888510243c2 100644
--- a/drivers/gpio/gpio-pca953x.c
+++ b/drivers/gpio/gpio-pca953x.c
@@ -1074,20 +1074,15 @@ static int pca953x_remove(struct i2c_client *client)
 {
 	struct pca953x_platform_data *pdata = dev_get_platdata(&client->dev);
 	struct pca953x_chip *chip = i2c_get_clientdata(client);
-	int ret;
 
 	if (pdata && pdata->teardown) {
-		ret = pdata->teardown(client, chip->gpio_chip.base,
-				      chip->gpio_chip.ngpio, pdata->context);
-		if (ret < 0)
-			dev_err(&client->dev, "teardown failed, %d\n", ret);
-	} else {
-		ret = 0;
+		pdata->teardown(client, chip->gpio_chip.base,
+				chip->gpio_chip.ngpio, pdata->context);
 	}
 
 	regulator_disable(chip->regulator);
 
-	return ret;
+	return 0;
 }
 
 #ifdef CONFIG_PM_SLEEP
diff --git a/include/linux/platform_data/pca953x.h b/include/linux/platform_data/pca953x.h
index 4eb53e02399786..96c1a14ab3657a 100644
--- a/include/linux/platform_data/pca953x.h
+++ b/include/linux/platform_data/pca953x.h
@@ -22,7 +22,7 @@ struct pca953x_platform_data {
 	int		(*setup)(struct i2c_client *client,
 				unsigned gpio, unsigned ngpio,
 				void *context);
-	int		(*teardown)(struct i2c_client *client,
+	void		(*teardown)(struct i2c_client *client,
 				unsigned gpio, unsigned ngpio,
 				void *context);
 	const char	*const *names;
-- 
2.53.0

