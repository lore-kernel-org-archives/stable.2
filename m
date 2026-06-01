Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41E2A39E167
	for <stable@vger.kernel.org>; Mon,  1 Jun 2026 13:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780320990; cv=none; b=TAYeTgqQpTHPuOG6SZjrxjoL3WngIoZ/Wg0VSJuv1oJQnt7Z6NZNTxPW7Rsb2R6WCYObCF1u/F6PjnTLwN63+A723DwKtfFFKA0uWdGz3i04NZOU7h0TCVgvcZWhFgAom69pL/bbaam8M6/vvAtW8V8ISck5Hbkv0kDHNHaTcLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780320990; c=relaxed/simple;
	bh=KhLfKQgQr9uiWbzwqjAHDKghxrHRfiwg1FPqIkFkOhA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pExPSwUkaZfUXVxqizZjRxulA/nIqPsXmY/+KDOcm2B5z5iQZkDjcG8x4LotxUnTXIXcGXBVALY0U/BQBkgUiaHxFqIp7QNI0MqZVrruhJi7f7R9YA+Qt9YRVHPqiogymUeRSFOM5RubKUQ9mVCCm6XNqvyVtXmHIlauR8btZyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bgInyBvr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bgInyBvr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C7881F00893;
	Mon,  1 Jun 2026 13:36:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780320989;
	bh=59Pr8Pm506FjObzjI2Vd6JmFXGC3pNHECICJhG+EptA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bgInyBvr1Z4q1sePMoVv/AjYa2+XDXLJLpALq3zFSVRHJh2hzj5TUAXOR02xcK+6m
	 x/bYfxcomdtKFuuU1OZxTnoGxAFcd2ELJEhWJJxqbEFZ2EC6IeRlX8UNCoV1nOinOs
	 CsFTx0rhJCrPBxzyY6/bSijf0/6H1LdMAmoZuXTv7hry6NRgUSw6UK80g690KRmbn8
	 IU64pwvXiqSPRk/h0BRLWUGDNeFKlPDlDpi384FtRfEttk5GmErTLx0ZvTB/gX8ApF
	 IccmGERO1YeLLdhJHHOjMTUlwVlTeubqjuNMFKRqPsOIu3RGpG7vlOkWwbATqDpiZH
	 rzciE9U5Tq0Dw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Guenter Roeck <linux@roeck-us.net>,
	Sanman Pradhan <psanman@juniper.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.0.y 1/2] hwmon: (pmbus) Add support for guarded PMBus lock
Date: Mon,  1 Jun 2026 09:36:26 -0400
Message-ID: <20260601133627.790087-1-sashal@kernel.org>
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

