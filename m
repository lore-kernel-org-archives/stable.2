Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E2ED342C8B
	for <stable@vger.kernel.org>; Mon,  1 Jun 2026 13:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780320981; cv=none; b=kKi1geH6NwEFbiwTZ4JK2+k8437gQ0bPUWO801SAPSpuvd9D4Koi06xKkQ1YppsK/PjuPtH1XO028pHXMkMuufdkBtwb1gWK8yl05pTggwscN1Wpb/5RLUu+dUn15vJxIHqAP7dKy2zokOGr6Vn7CCglbleIo1FkcNItu5I4FZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780320981; c=relaxed/simple;
	bh=KhLfKQgQr9uiWbzwqjAHDKghxrHRfiwg1FPqIkFkOhA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G7UuCIufa979v+pmGLYGcNnPlquqnpABG67le70JAu7ft2Vgnnni4OLXC9at5DtUsCPrdpMyh/0pd5mNbbQ2hkl63RLjy8TQiX9WHpr+WxXF6C0eHj4FCBp129wNxu2OgQZnwGkoIyyZzXT2b6BiiF6c0jyZTv4NE3z+Ho5Ltwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EvFa3oyS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EvFa3oyS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 607E71F00893;
	Mon,  1 Jun 2026 13:36:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780320979;
	bh=59Pr8Pm506FjObzjI2Vd6JmFXGC3pNHECICJhG+EptA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EvFa3oySytHOqeX+6hfXRRuGgK12DHu6Ax2rTjrv9ahsao3x+LyRin4O85myW4YWv
	 67qwlmYaC6fZm8iTKvCAk4qM74Q9UD0q5zDokzBY3WTtGgUQrtPzu+qS/sHHqd8rmM
	 Qxag2dojojEOd7lF/4kz5vk/GAfqdgADeP7UGzD21zOBv8nf2ZR/lplDVm/nJ3hyUb
	 922vrFCEslBrDxA0x9sewXF5P9vKyRnHU/5X5DJDX4ziAxZMGFSqdrk0mTarYf+Ooe
	 2BuTcrX0KeDoQGSR8S6s1vcBSGnpLwNDuo4mV0Aw1kGJ+ZozVMjhy3V+SU6ow8zyVE
	 DoXVlBev2VPHg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Guenter Roeck <linux@roeck-us.net>,
	Sanman Pradhan <psanman@juniper.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.0.y 1/2] hwmon: (pmbus) Add support for guarded PMBus lock
Date: Mon,  1 Jun 2026 09:36:16 -0400
Message-ID: <20260601133617.789719-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026052829-nutshell-shank-d239@gregkh>
References: <2026052829-nutshell-shank-d239@gregkh>
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
Stable-dep-of: 9f1dd8f9491e ("hwmon: (pmbus/adm1266) serialize NVMEM blackbox read with pmbus_lock")
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

