Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 130743A48ED
	for <stable@vger.kernel.org>; Mon,  1 Jun 2026 13:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780322021; cv=none; b=lqn6dp/9PfMQvn02vAfVRec6t6DHLcTmh51E20QEITfWz5sobP2kPKfw6LXD+m26wIHLwymPTAw59Gh+qI75uvRY7fhlyFntGYG7m7wYzuO4k9PZ9FKijVAlhR3GFVAiuxz90V5HbjK/Aml0to2q3RjMw7A/k+1zTBPNIBWMvP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780322021; c=relaxed/simple;
	bh=QlmJWxL1Jm9pKGUIjgONOuieZ4Y7BJhgM91SgyAsccM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tTiup5xDZhRbfKLW8WF5NbbvoCUiJ7JH2aWIT6OErAPLD6dQ2P8q/r3iMsuqb7PJtRNC6so4K0lozuwq0lDLKUJJtufT395lOv6vYTz33hdLOSQwQ6ohqmxw759GLkqT8tI9u16Vv6wekAjMVIKqRM9xgvXRf+fkOOqa2nzNQcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dX3ml5N3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dX3ml5N3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 758AA1F00893;
	Mon,  1 Jun 2026 13:53:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780322019;
	bh=8M1n566b0xLrwcP5VjKaUoqyQDbA/JKxkRSbNY9qWLU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dX3ml5N3w9giONDS8dkDiJhNj1hHoZNLRoaC+p3ODo32eWRWgtucBXTTW+cLSZzLW
	 5O/Sb68vvgAUHTpHfanX0mj1SEarfsaXiVyY0D53YoQ9bHJyInKjHHxhkJXtK6QQ15
	 3/yJ/epsm4oFD1vULDilJaCLjL8wv6AYI0LtS3SbF63J2eScQvKF7vp/DHr3BOQrgK
	 uPFni4402rSj+EjY3+9tTjZPzTKCNtvKC9y8Er3rpWuazyEiM36vSeMMgwQ3Sn7Scu
	 QYMu8iikuTey91Z03tZhX7uwOueFsmfsQ+e1X8sPZCqNLLifdIekeLXagPxkYGnqCq
	 JnIZ/o41nxUmA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Guenter Roeck <linux@roeck-us.net>,
	Sanman Pradhan <psanman@juniper.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/2] hwmon: (pmbus) Add support for guarded PMBus lock
Date: Mon,  1 Jun 2026 09:53:36 -0400
Message-ID: <20260601135337.798956-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026052841-exquisite-attach-1b4c@gregkh>
References: <2026052841-exquisite-attach-1b4c@gregkh>
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
Stable-dep-of: bab8c6fb5af8 ("hwmon: (pmbus/adm1266) serialize GPIO PMBus accesses with pmbus_lock")
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

