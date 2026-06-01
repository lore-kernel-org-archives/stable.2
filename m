Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E825C3C0637
	for <stable@vger.kernel.org>; Mon,  1 Jun 2026 14:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780325218; cv=none; b=PvC4Ednqh+UnNZHGv34nvHGmHyBkReV8DGtXJ7tnT/PelohJZhOjGRPC+hzL1ol2ZBikLQGHB4U9nxltPj0UNGiTYJP/zNTowlQrIdoy9EIFXWvaVNI1WuPfIjm5RKNH/w7EMthSMUgXQTe6qzT3D4ePWmfH+frAe5DuwPz3sUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780325218; c=relaxed/simple;
	bh=KhLfKQgQr9uiWbzwqjAHDKghxrHRfiwg1FPqIkFkOhA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lEOMvLKBJtAvO0FxPWE1+sM9JXoDqYOhKR0675J53D5Dle04f8vaL9dh0zvTrL81MK5X0PuDAM0MJHpq3qQQFy1E/rV0K7C49imDxCqc02qAeYKAeO3JQ+vRKG0hBCHX2tYq1WJZo0/yN0+FArCAzKG7AZ+ut/vOQrhv0X3Q1nY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B27hfEil; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B27hfEil"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 179AA1F00893;
	Mon,  1 Jun 2026 14:46:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780325217;
	bh=59Pr8Pm506FjObzjI2Vd6JmFXGC3pNHECICJhG+EptA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=B27hfEilJKL/IZhEnAihnBEGIN2OZPiB2d4/ypRJfkrKBPnh8cU2JpyYxRwY37AVz
	 eGnL32OruMT/x5JSFApCToKTGP6nadQhZ99fIW7NXrCITdTMe8DhQpC5w/09abyK/o
	 k0VJce8p+JulRCedpa5vmnLzqZ3DGP7V8ctMD4FmKB2urEOSHsFZfq/2+jEDjrFCO9
	 22DC95kb+TTDH0NgFrpApBc2bjzy1bNYGLg6eT52OYM9XOsLhFt5aqLYkgnqVf1wDM
	 kNY2230gxry3B6XCx+GstuOtkEgi+t8XFz0n4lgIh/O7zsKSkqJ9MM88pWp0NDSyAk
	 HhLCCp31EBPbw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Guenter Roeck <linux@roeck-us.net>,
	Sanman Pradhan <psanman@juniper.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/2] hwmon: (pmbus) Add support for guarded PMBus lock
Date: Mon,  1 Jun 2026 10:46:54 -0400
Message-ID: <20260601144655.887986-1-sashal@kernel.org>
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

