Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7525B23A561
	for <stable@vger.kernel.org>; Mon, 20 Jul 2026 02:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784514945; cv=none; b=F+KG8KDDEARyKQlNvpfBv5RgkV13P1/UaTFaL62xHUwsSTyTrV3br3akI1HiAmZwgLQOCapIaKk5hS1EO3BfFbwGfJ2YNb0Em80inNpAINmdi7AFBtSs/u+Miin5i+PVieqVAIc3ZhfdNzXrCOpt4uctErRd5Tc7R6bY1C+0ONk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784514945; c=relaxed/simple;
	bh=cS14Qr0yi2Hkj2bYGgY8QJ+Fd5FqY2dvQHF7NJJbRFg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BUAEI6HLgrnHCCGzuQ+zhHrFbeL9QTfK6S9ZQfqHoFjIZAM8pUKb7bRapzHVmY5nqAo2HK54Pa2CsDn/84AErG/BAOUiOpVKr85UYYF6Y4T+jg5xMIxQdwOEDKsA1TZsplAT0U/EEoGJRcKeyRunF6PUlSeEYor036Whbu5hm4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Txh4b42r; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Txh4b42r"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 931FB1F000E9;
	Mon, 20 Jul 2026 02:35:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784514944;
	bh=4FS7D5RYeehyCsguuK7hUZrzNrjK0cvry5Gav58C1S8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Txh4b42rOPgVEzz6k8vx6fYRysW67+zgNiJbbMeByWnku6U5+OmimdsBkGT40mMyQ
	 cvUQW6uX73VSYIGbxLsIW96501Hce9nJ6fJa4h7OpWQlz/izbvA5V6isQB3Pc6in+/
	 Cj90OOqc7RmJ6clG3tXTRvSAcJPtD/nqZLIozRQOzFVLW9Vi2GIYrfINVZzFjEL1YO
	 ZXvSMANWZAq8rlwQZpTx6rgrK6EtzsI1CACrkCxcWcuJCFrotOT7RIIXmKYu5HCjur
	 FpeJaaO80lz+hhV5jgeFYC5SXxQ1MVZ/rwvbSUGR70E14FaZR1594VvfTULbXgMLyM
	 nM+Q5f/lW+e5Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Wolfram Sang <wsa@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 4/5] gpio: pca953x: Make platform teardown callback return void
Date: Sun, 19 Jul 2026 22:35:38 -0400
Message-ID: <20260720023539.2968115-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260720023539.2968115-1-sashal@kernel.org>
References: <2026071423-employed-mankind-78ba@gregkh>
 <20260720023539.2968115-1-sashal@kernel.org>
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
index 7f7f6bae21c2d7..e2c6087991293b 100644
--- a/arch/arm/mach-davinci/board-da850-evm.c
+++ b/arch/arm/mach-davinci/board-da850-evm.c
@@ -519,8 +519,8 @@ static int da850_evm_ui_expander_setup(struct i2c_client *client, unsigned gpio,
 	return ret;
 }
 
-static int da850_evm_ui_expander_teardown(struct i2c_client *client,
-					unsigned gpio, unsigned ngpio, void *c)
+static void da850_evm_ui_expander_teardown(struct i2c_client *client,
+					   unsigned gpio, unsigned ngpio, void *c)
 {
 	platform_device_unregister(&da850_evm_ui_keys_device);
 
@@ -532,8 +532,6 @@ static int da850_evm_ui_expander_teardown(struct i2c_client *client,
 	gpio_free(gpio + DA850_EVM_UI_EXP_SEL_C);
 	gpio_free(gpio + DA850_EVM_UI_EXP_SEL_B);
 	gpio_free(gpio + DA850_EVM_UI_EXP_SEL_A);
-
-	return 0;
 }
 
 /* assign the baseboard expander's GPIOs after the UI board's */
@@ -700,13 +698,11 @@ static int da850_evm_bb_expander_setup(struct i2c_client *client,
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
index 117f5a00ee7039..76c0c90647f664 100644
--- a/drivers/gpio/gpio-pca953x.c
+++ b/drivers/gpio/gpio-pca953x.c
@@ -1073,20 +1073,15 @@ static int pca953x_remove(struct i2c_client *client)
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

