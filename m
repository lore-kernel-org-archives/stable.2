Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0C9C4B8DFC
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 15:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788447823; cv=none; b=O3V8kQ3GpXra21/hgp7t+xRcd8D17nLY8/TE0fmxeuBzvGDRvRG1slT2cPhwW8T2UNf5hjWWM29nnulMLxCBUVW7F4A6oTjh2wIb4PkPoU4nFUhjSVnN4tXQkw0XPm3Ih6CTftBK4+V6cLNY6ylQv/a1KbygPw3L6PWqGozgma8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788447823; c=relaxed/simple;
	bh=kIvjT1Lb8jZMoUl0i9weoQ2K20KKRR9za5MkT1noPIA=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=GnCsVf9gNRE7dhVEKzW4Zb9qte4yBlCbj6fldnxOfCQh1z+7AsXd/GuVxbTs11VDoQ/ZP2zJutotsdQYR6LlodlrOndnGat7QRoWaFeWrflSTcmBBNFWOSeccC/f9ldletOOWGUpD/EYEnZxFy67XkUhKtgNB8JfhVWQBJipXoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SurqVhDN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SurqVhDN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 390821F000E9;
	Thu,  3 Sep 2026 15:03:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788447821;
	bh=OGC4ju6dIx4Zgkw5gp7lomM5IWhfyhCs0HPVviTTqY4=;
	h=Subject:To:Cc:From:Date;
	b=SurqVhDNmwlMnAAZ2WUXYTCcL7Kfi2FP3ewDHGaE9ufDzTI6KGAywcCXwuLh0zsX/
	 lsApVoS0Ifek3lWJBcbbZm9u2wezDh0BnY108Z/MkkP+Ksf+tB5gGyyAzq8wpvcg2Q
	 +X7iGcH9CMWl096vxmJ7aOhA68/Gz/xwnrWX8AAA=
Subject: FAILED: patch "[PATCH] power: supply: max17040: drop incorrect I2C functionality" failed to apply to 6.1-stable tree
To: m13940358460@163.com,sebastian.reichel@collabora.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 03 Sep 2026 16:40:05 +0200
Message-ID: <2026090305-skinhead-nursing-7dcb@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 4e4b9f5ce9dfb8ed4b8d1262a504b8043ac09d87
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090305-skinhead-nursing-7dcb@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

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

