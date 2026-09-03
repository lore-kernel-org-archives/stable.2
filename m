Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4DEF4C77CF
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 15:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788447825; cv=none; b=rsC+v06oDvL5bcu03mRgE2jqmHVcn51ZzBDJBgFOlL+QLloihY9nP2DRK3V2uEpSedduOxpV4RWVymscfJr16TTiKUrWTCw6fL9+heUGLrQZTMt/n41VmCDMXMJvxXE2nbhaw+Y06KSouBbD+fO30jsNcyKzhalNRfXbS1Tga4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788447825; c=relaxed/simple;
	bh=2rL3u0Wtr+nNEiReGeX8y86OiHBVVO0UtS6sgaIqa8A=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=tp9OiKx1hunhA9Pl5lJj7t34032nEgbTAn7FYmBUF/Gz2KQFOM7b1JQiOWtWTkIKkoBAtGe64aZ2+YmmnD+tlqPQ8puJaDn9xXOVXgcObksn6tRzZJ9ljAL0Lkvw/AEbiu5uBrsJQu8xA47SCG06VgOP8jtd8rTzF5G+MYVOS8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=R3jtnBe7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="R3jtnBe7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C71D1F000E9;
	Thu,  3 Sep 2026 15:03:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788447824;
	bh=CWVzzFmM3sYSQNV+ByFGiBzfbriypCofTzUj1IaZpVo=;
	h=Subject:To:Cc:From:Date;
	b=R3jtnBe7jlMehRkjG6IdS6oD2STETKViQWYFyFPGtlH2vRGyMVTERrY7OpNrndLRE
	 yYy0by3V2KYAyVvtQCSoOPLIOkzZ0Wfn2OjW/rjZT4tgLGmVxgJvInhEYY3uoLXwa4
	 cFf6mtKwFnQNJs09JTIRYn+o604oqe188ZE4MH9c=
Subject: FAILED: patch "[PATCH] power: supply: max17040: drop incorrect I2C functionality" failed to apply to 5.10-stable tree
To: m13940358460@163.com,sebastian.reichel@collabora.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 03 Sep 2026 16:40:06 +0200
Message-ID: <2026090306-rabid-rug-adb0@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 4e4b9f5ce9dfb8ed4b8d1262a504b8043ac09d87
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090306-rabid-rug-adb0@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

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

