Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794364000;
	b=k8jQ76ASdC8NwWJnGg9EFzMt1It/m17Pwm689NIhUxR7DZMjybdi0gmX9hFniAT74lhF
	 IWTwgW+VbwRrw64vlw86f/ZXwLxZbSQwXPd3NCm/Vy3xpo889koVUCzFzAZHr6/60uPcx
	 lFHTT9nMTDDMiHMfJWBQomcb+nVmcaOrGyUmE5S+H8D8fdkxS7f66xJjYvDDvlGUeu+e3
	 DEQiEwm4uZTMOAu4cJQ38TdnaBNwSwiyl9iTbaqXsde3DZyS8OsQrR/8Bpz7zRVEcrOQq
	 IL0rr1+yqdwfFIDZ1oYTh1yvgNpU+/Ggo0/pKdYIIRVbqB0JmfWfj4on3VUuf07hjhQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794364000;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=GrXYQ6fCepb+9l0KbIHuNF/yP0Ze04rufN4NpWL4Jpc=;
	b=BtugClvlNXVToaoIQSBp2B0xWfCG+cVbKZbI3A70X4LoMk0QD8Q2Y1GlEiHHpDzajqA7
	 qTnjFBD8tCjMXl1xIxlE9mVhSV+6OujkeWdnWObalCZRBGp5MWBRfVd7RqxZ95eeAzkcM
	 1eUi/O8giw7uiXlzgWOWMCIixKaBa2s1uAOyiLVNJjhD7nfNlEyjPWd24j9HiUdEty36T
	 1bbDUFl7q6RAkNw/99LcVk9ZqlqHdEZD7eYIYmjahYUp/SibUR41qu4941WZU0PivaIVj
	 mSZFGKEk4o83qxglVf09ihugxlfNZW/DLEq35elu6BkpO6ymUoohwYdCtMZ8/CmWeCw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=M0PyfVvf;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB777606A33E
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 02:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=M0PyfVvf
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 182AF1F00A07;
	Wed, 11 Nov 2026 02:26:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794364000;
	bh=GrXYQ6fCepb+9l0KbIHuNF/yP0Ze04rufN4NpWL4Jpc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=M0PyfVvfgDiSeD+f6bbnP/HMFHwh1mNhDXQbHfDP7qNVwp2CqmkJSNBElifKdUZ04
	 Y8CNVdJUCF5YSA/OTnOZ0u2DuVog+yJcOMQuLUyBkmgmlYNnPvyrF1nJLOTqIjV9/s
	 kPLNKwrGtdIDE/NvQXKRvMm1UAMrNXFSx5eIe7R6D72+wmGf8mfT0/tJzT2a1gkbW1
	 iHjdf7HxKBA3UFEzpYbVyDaFymM5n10revIkCWNih7JFTgEONqo4nBI3mxqBJRXzPm
	 Ob+pclKgpNXt3f+A16kzpnK1w0FNh3HYPYyG7eJKE9pR/ntfO9WmOqGz4iZlmdqRCD
	 F8RbEBIKYWLVA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 3/4] power: supply: Use devm_mutex_init()
Date: Tue, 10 Nov 2026 21:26:36 -0500
Message-ID: <20261111022629.681261-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261111022629.681261-1-sashal@kernel.org>
References: <20261107051652-failed-6.12-db560f4b1c52@kernel.org>
 <20261111022629.681261-1-sashal@kernel.org>
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

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

[ Upstream commit 7d715345a86941b9e6c8e520b40078692baed4a4 ]

Use devm_mutex_init() instead of hand-writing it.

This saves some LoC, improves readability and saves some space in the
generated .o file.

As an example:
Before:
======
   text	   data	    bss	    dec	    hex	filename
  35803	   9352	    384	  45539	   b1e3	drivers/power/supply/rt9467-charger.o

After:
=====
   text	   data	    bss	    dec	    hex	filename
  34792	   9008	    384	  44184	   ac98	drivers/power/supply/rt9467-charger.o

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Stable-dep-of: db560f4b1c52 ("power: supply: bq27xxx: Ensure poll work is cancelled on remove")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/power/supply/bq27xxx_battery.c | 11 +--------
 drivers/power/supply/mt6370-charger.c  | 11 +--------
 drivers/power/supply/rt9467-charger.c  | 33 +++-----------------------
 3 files changed, 5 insertions(+), 50 deletions(-)

diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/supply/bq27xxx_battery.c
index fc76fd9e2b96f..b0dec20fb37e8 100644
--- a/drivers/power/supply/bq27xxx_battery.c
+++ b/drivers/power/supply/bq27xxx_battery.c
@@ -2150,13 +2150,6 @@ static void bq27xxx_external_power_changed(struct power_supply *psy)
 	mod_delayed_work(system_wq, &di->work, HZ / 2);
 }
 
-static void bq27xxx_battery_mutex_destroy(void *data)
-{
-	struct mutex *lock = data;
-
-	mutex_destroy(lock);
-}
-
 int bq27xxx_battery_setup(struct bq27xxx_device_info *di)
 {
 	struct power_supply_desc *psy_desc;
@@ -2168,9 +2161,7 @@ int bq27xxx_battery_setup(struct bq27xxx_device_info *di)
 	int ret;
 
 	INIT_DELAYED_WORK(&di->work, bq27xxx_battery_poll);
-	mutex_init(&di->lock);
-	ret = devm_add_action_or_reset(di->dev, bq27xxx_battery_mutex_destroy,
-				       &di->lock);
+	ret = devm_mutex_init(di->dev, &di->lock);
 	if (ret)
 		return ret;
 
diff --git a/drivers/power/supply/mt6370-charger.c b/drivers/power/supply/mt6370-charger.c
index ad8793bf997e1..16ffa927147f6 100644
--- a/drivers/power/supply/mt6370-charger.c
+++ b/drivers/power/supply/mt6370-charger.c
@@ -761,13 +761,6 @@ static int mt6370_chg_init_psy(struct mt6370_priv *priv)
 	return PTR_ERR_OR_ZERO(priv->psy);
 }
 
-static void mt6370_chg_destroy_attach_lock(void *data)
-{
-	struct mutex *attach_lock = data;
-
-	mutex_destroy(attach_lock);
-}
-
 static void mt6370_chg_destroy_wq(void *data)
 {
 	struct workqueue_struct *wq = data;
@@ -895,9 +888,7 @@ static int mt6370_chg_probe(struct platform_device *pdev)
 	if (ret)
 		return dev_err_probe(dev, ret, "Failed to init psy\n");
 
-	mutex_init(&priv->attach_lock);
-	ret = devm_add_action_or_reset(dev, mt6370_chg_destroy_attach_lock,
-				       &priv->attach_lock);
+	ret = devm_mutex_init(dev, &priv->attach_lock);
 	if (ret)
 		return dev_err_probe(dev, ret, "Failed to init attach lock\n");
 
diff --git a/drivers/power/supply/rt9467-charger.c b/drivers/power/supply/rt9467-charger.c
index be65b0f517210..be1ca7f61c0bb 100644
--- a/drivers/power/supply/rt9467-charger.c
+++ b/drivers/power/supply/rt9467-charger.c
@@ -1145,27 +1145,6 @@ static int rt9467_reset_chip(struct rt9467_chg_data *data)
 	return regmap_field_write(data->rm_field[F_RST], 1);
 }
 
-static void rt9467_chg_destroy_adc_lock(void *data)
-{
-	struct mutex *adc_lock = data;
-
-	mutex_destroy(adc_lock);
-}
-
-static void rt9467_chg_destroy_attach_lock(void *data)
-{
-	struct mutex *attach_lock = data;
-
-	mutex_destroy(attach_lock);
-}
-
-static void rt9467_chg_destroy_ichg_ieoc_lock(void *data)
-{
-	struct mutex *ichg_ieoc_lock = data;
-
-	mutex_destroy(ichg_ieoc_lock);
-}
-
 static void rt9467_chg_complete_aicl_done(void *data)
 {
 	struct completion *aicl_done = data;
@@ -1218,21 +1197,15 @@ static int rt9467_charger_probe(struct i2c_client *i2c)
 	if (ret)
 		return dev_err_probe(dev, ret, "Failed to add irq chip\n");
 
-	mutex_init(&data->adc_lock);
-	ret = devm_add_action_or_reset(dev, rt9467_chg_destroy_adc_lock,
-				       &data->adc_lock);
+	ret = devm_mutex_init(dev, &data->adc_lock);
 	if (ret)
 		return dev_err_probe(dev, ret, "Failed to init ADC lock\n");
 
-	mutex_init(&data->attach_lock);
-	ret = devm_add_action_or_reset(dev, rt9467_chg_destroy_attach_lock,
-				       &data->attach_lock);
+	ret = devm_mutex_init(dev, &data->attach_lock);
 	if (ret)
 		return dev_err_probe(dev, ret, "Failed to init attach lock\n");
 
-	mutex_init(&data->ichg_ieoc_lock);
-	ret = devm_add_action_or_reset(dev, rt9467_chg_destroy_ichg_ieoc_lock,
-				       &data->ichg_ieoc_lock);
+	ret = devm_mutex_init(dev, &data->ichg_ieoc_lock);
 	if (ret)
 		return dev_err_probe(dev, ret, "Failed to init ICHG/IEOC lock\n");
 
-- 
2.53.0

