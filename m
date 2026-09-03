Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 086964C77A8
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 15:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788447820; cv=none; b=tXWCcWHiq7BSau8+cXnKT9LsGHKStQizGGo6hF6BnD9v5LCegZavhsRkpiltA+jWOiQ295KDB+aGSR4prhCqfqAqsI1cP+RuGdsJ9KRx/JmMB6W8OFihZPeabOMfkMQvli1/lGbWlup2heD2G6pJXxnuG+XWwo7w3pGuZfXWEKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788447820; c=relaxed/simple;
	bh=2G5pT6RLur+hLR1AAtsdAvfGChtDPYxb2lNRTUl+zZ0=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=tl4iUkjGBcm/z7PpDt54qVHQ1aU63VqIVlZPKOvYHXWta/3+GoxP2IL9eaI2pZyWV5/S2l3hVFwL56FzaC+H9ENspk7T5jvXAzqrW6Ntsuo8KoLeMK/Mf7FZZdIShj/yyNkpslInAyfKAZBT0GomivOOra7otYLA8Cd6fkbZ4o4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MN9CuGAy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MN9CuGAy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62E881F000E9;
	Thu,  3 Sep 2026 15:03:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788447818;
	bh=zd10F924NG8BUBcYQJ9mXmxQ3EgzbdlXsgJ7HF88X5c=;
	h=Subject:To:Cc:From:Date;
	b=MN9CuGAyyf9XujeYk55ocVJOeixgHW6lX1qcGarMI8jWDy+POjv2qXvVO2v66lLy5
	 TdCn5Ldl09nV8AyTZ/eStq4/h8gDNCBpGcCLTl28zjQ9lbp+ebzTBy7tnz8A64Fhaq
	 u81AWi0hGp+zQCLGjH0S7WSQ343pW6b3MoA9Faxw=
Subject: FAILED: patch "[PATCH] power: supply: max17040: drop incorrect I2C functionality" failed to apply to 5.15-stable tree
To: m13940358460@163.com,sebastian.reichel@collabora.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 03 Sep 2026 16:40:05 +0200
Message-ID: <2026090305-streak-absinthe-62ae@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 4e4b9f5ce9dfb8ed4b8d1262a504b8043ac09d87
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090305-streak-absinthe-62ae@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 4e4b9f5ce9dfb8ed4b8d1262a504b8043ac09d87 Mon Sep 17 00:00:00 2001
From: Jianing Li <m13940358460@163.com>
Date: Fri, 31 Jul 2026 16:42:59 +0800
Subject: [PATCH] power: supply: max17040: drop incorrect I2C functionality
 check

max17040_probe() rejects adapters that do not advertise
I2C_FUNC_SMBUS_BYTE. The driver does not issue SMBus byte transactions,
however. Its regmap has 8-bit registers and 16-bit big-endian values, for
which regmap-i2c supports either raw I2C transfers or SMBus word-data
transactions.

Consequently, an adapter providing raw I2C transfers or SMBus word data
but not SMBus byte transactions is rejected even though regmap can access
the device. Conversely, the current check can pass an adapter that regmap
cannot use.

Drop the stale check and let devm_regmap_init_i2c() validate and select
the supported transfer method.

Fixes: 6455a8a84bdfd ("power: supply: max17040: Use regmap i2c")
Cc: stable@vger.kernel.org
Signed-off-by: Jianing Li <m13940358460@163.com>
Link: https://patch.msgid.link/20260731084259.916-1-m13940358460@163.com
[Fixed Fixes tag, so that it points to the regmap introduction instead of the initial driver addition]
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>

diff --git a/drivers/power/supply/max17040_battery.c b/drivers/power/supply/max17040_battery.c
index 98d34d5f3c80..b641d7387311 100644
--- a/drivers/power/supply/max17040_battery.c
+++ b/drivers/power/supply/max17040_battery.c
@@ -470,16 +470,12 @@ static const struct power_supply_desc max17040_battery_desc = {
 static int max17040_probe(struct i2c_client *client)
 {
 	const struct i2c_device_id *id = i2c_client_get_device_id(client);
-	struct i2c_adapter *adapter = client->adapter;
 	struct power_supply_config psy_cfg = {};
 	struct max17040_chip *chip;
 	enum chip_id chip_id;
 	bool enable_irq = false;
 	int ret;
 
-	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE))
-		return -EIO;
-
 	chip = devm_kzalloc(&client->dev, sizeof(*chip), GFP_KERNEL);
 	if (!chip)
 		return -ENOMEM;

