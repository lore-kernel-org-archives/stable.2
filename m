Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA6A5371D08
	for <stable@vger.kernel.org>; Mon,  1 Jun 2026 12:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780317437; cv=none; b=HWJ3xzodICPrns7qwoLEi8N6w8WnXFdeSI7adE3ci94kA8jiE1b8MKz5YR+hbywfXDj/7ZDYu8Qy5DVFJFv/RboTNnQShhhKoYO1xOG+JgjgCXzFb7i15sRp/Zkuqky2WVLzFbS3a4Nq+QOXQCuRpxTKxOnBNfZ1St9U0gD1x6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780317437; c=relaxed/simple;
	bh=UeuPLvOAXO0PgPZuPCJdVXx497EuEZw4yG64HJQOr2Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uVq1Kh22rsD37x4z6+KbySF+hY4Jxiud9nZK11zHe5C8H031YvZTP4HAaNI9pbvcsemoTV3PWjaFI3WiDRXe+oqMlbQp2j4tEPlRvo4OhkUL8RJN1L8h/SqJah2QB4lmIOT45EENK6HB1BtZbhboDjhS54t4F9XA5UzCoDAQ5rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EkrzXTJD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EkrzXTJD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 390931F00893;
	Mon,  1 Jun 2026 12:37:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780317435;
	bh=1erm8ibW2jwrRcAn/oIMjdMpj7Qych7Vl2Gu7gWaRMI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EkrzXTJDxXGRKQA5U6kAUZHGId8WcKHhUTyvBzFgeEp6kwpHqYr+2p3FL0fUU7Fs3
	 lWT1BZkqL+ADvlOFx3Yh8qmE6ziGhfJIgf1Sjtqw/p0GT+IOVnDOFuarXlWWY/RtgC
	 N+w+ttY51ygR0KLikVrxbUNNOrlmZFNvhyaM++f0TcJ9Izo3hccXdUlykVpC6AWxGA
	 YscEv1zC7zalLHXdZViX/rnmLOTE5PdwEhag3O9WdkTo7W5czCaj3t/lmktwi8xwuR
	 sYjUpaV4O7r7BgLg4AhfBpP0uzoNd/WTtYuO28JpGc3CDAEbjdT3ddLEeOMCF1b827
	 A+Xw0csw+axWg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Guenter Roeck <linux@roeck-us.net>,
	Sanman Pradhan <psanman@juniper.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.0.y 1/2] hwmon: (pmbus) Add support for guarded PMBus lock
Date: Mon,  1 Jun 2026 08:37:12 -0400
Message-ID: <20260601123713.718815-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026052822-saloon-auction-5094@gregkh>
References: <2026052822-saloon-auction-5094@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Guenter Roeck <linux@roeck-us.net>

[ Upstream commit 1814f4d3ff358277a5b6957e7f133c2812dc80ec ]

Add support for guard(pmbus_lock)() and scoped_guard(pmbus_lock)()
to be able to simplify the PMBus code.

Also introduce pmbus_lock() as pre-requisite for supporting
guard().

Reviewed-by: Sanman Pradhan <psanman@juniper.net>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Stable-dep-of: 4e4af55aaca7 ("hwmon: (pmbus/adm1266) serialize sequencer_state debugfs read with pmbus_lock")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hwmon/pmbus/pmbus.h      | 5 +++++
 drivers/hwmon/pmbus/pmbus_core.c | 8 ++++++++
 2 files changed, 13 insertions(+)

diff --git a/drivers/hwmon/pmbus/pmbus.h b/drivers/hwmon/pmbus/pmbus.h
index d2e9bfb5320fc..e499cdae9442c 100644
--- a/drivers/hwmon/pmbus/pmbus.h
+++ b/drivers/hwmon/pmbus/pmbus.h
@@ -10,6 +10,7 @@
 #define PMBUS_H
 
 #include <linux/bitops.h>
+#include <linux/cleanup.h>
 #include <linux/regulator/driver.h>
 
 /*
@@ -563,7 +564,11 @@ int pmbus_get_fan_rate_device(struct i2c_client *client, int page, int id,
 int pmbus_get_fan_rate_cached(struct i2c_client *client, int page, int id,
 			      enum pmbus_fan_mode mode);
 int pmbus_lock_interruptible(struct i2c_client *client);
+void pmbus_lock(struct i2c_client *client);
 void pmbus_unlock(struct i2c_client *client);
+
+DEFINE_GUARD(pmbus_lock, struct i2c_client *, pmbus_lock(_T), pmbus_unlock(_T))
+
 int pmbus_update_fan(struct i2c_client *client, int page, int id,
 		     u8 config, u8 mask, u16 command);
 struct dentry *pmbus_get_debugfs_dir(struct i2c_client *client);
diff --git a/drivers/hwmon/pmbus/pmbus_core.c b/drivers/hwmon/pmbus/pmbus_core.c
index 572be3ebc03df..7150f12d26300 100644
--- a/drivers/hwmon/pmbus/pmbus_core.c
+++ b/drivers/hwmon/pmbus/pmbus_core.c
@@ -3871,6 +3871,14 @@ struct dentry *pmbus_get_debugfs_dir(struct i2c_client *client)
 }
 EXPORT_SYMBOL_NS_GPL(pmbus_get_debugfs_dir, "PMBUS");
 
+void pmbus_lock(struct i2c_client *client)
+{
+	struct pmbus_data *data = i2c_get_clientdata(client);
+
+	mutex_lock(&data->update_lock);
+}
+EXPORT_SYMBOL_NS_GPL(pmbus_lock, "PMBUS");
+
 int pmbus_lock_interruptible(struct i2c_client *client)
 {
 	struct pmbus_data *data = i2c_get_clientdata(client);
-- 
2.53.0

