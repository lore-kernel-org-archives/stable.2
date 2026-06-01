Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33EFE3A48ED
	for <stable@vger.kernel.org>; Mon,  1 Jun 2026 13:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780321887; cv=none; b=NzAOFDpE6b18xRHwPfj+Zo+cwdWRIz4dU3fkQIA+H0jjWXsNQ4QSfhdEQQVemQFLClYBFUd10Qs0lBclPE+yBAaFBgScfSwNuPtd05yoAsmLZPe5BSgSVHc0LJUYZoLk1IGMAoA/YIfUP6ZNjHynh0K9ctWjK3h04b4suUXdOAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780321887; c=relaxed/simple;
	bh=KhLfKQgQr9uiWbzwqjAHDKghxrHRfiwg1FPqIkFkOhA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e52F1EN15uE9YLKdxpOt/SWneperRPmQZdrjmq7c6Gz1Hk3m+oXrg9bxf//H/d84qhzA7Z2MCDosjMfI3AOs6nhbDYzhRrbF3ybaawWQ5KAZUntAQi2qd4fu/iHAnvjbHE10x6N2UZSBwcavEYd4bhnoSYOx/K3zAUH44B5rjQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mSVzA9f2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mSVzA9f2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 695B31F00893;
	Mon,  1 Jun 2026 13:51:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780321885;
	bh=59Pr8Pm506FjObzjI2Vd6JmFXGC3pNHECICJhG+EptA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mSVzA9f2bZNO6MDQqPUlQeXLF4GDElGc4O2JHYO4wKQKYFOTM2pusgyP0fDBDITUS
	 c4Lo7+wqlGG+nsoCiBOCWlEnlOPv1hx4I1NQX9zhWPHzUi2qKsW4HTR7HjzvFD6kHY
	 M8g5cIrJQtJaBlZDjwd4CFJOSe2pDnGJN5a4c8irznjaHHDfK5p7ErbUcbRrYTt903
	 G5nOvt8v8pqgHKMyNIjYd/cgM4Qb1n9/wrHSA4VFb+xJJXIgwQOCC7TY/qD5IrmJgq
	 yM1auVYaTJ69pJawIATMPJQ2vyo8DrPX4xXDaCkRdGpagniIVjAcJR2s1e029tqP61
	 bN0FVT9h89LEQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Guenter Roeck <linux@roeck-us.net>,
	Sanman Pradhan <psanman@juniper.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/2] hwmon: (pmbus) Add support for guarded PMBus lock
Date: Mon,  1 Jun 2026 09:51:22 -0400
Message-ID: <20260601135123.797428-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026052830-amicably-spoon-d982@gregkh>
References: <2026052830-amicably-spoon-d982@gregkh>
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

