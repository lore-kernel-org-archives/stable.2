Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56490339366
	for <stable@vger.kernel.org>; Wed, 22 Jul 2026 10:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784716233; cv=none; b=XTB3E72J0vVc0W3WzGFgD2eDhtwek3stzRozuO/vZDJ2+pt+ssA+/rjiio+PmBHJqEE4XOsQRpuVfMERaz3gdEenCYhUtFitTxiX6ceQRH+gRIYSnmLzh1t1hB5dJD9bRR1jKJWnljHbf02nSW+gg/2mbmzchwtddVdo8JRxyeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784716233; c=relaxed/simple;
	bh=cHDyEUFx9LIx526QEoMFoorFVyZa5as/hpWeR3f4h2Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dKzP0X5VHtIqzSr1tLC7I9Xg8fMOtzNFx6I1rg+rqgCjkZ7ZBKRtVMZQxpvJ8L9xQjPaSd0Rb4WIrfGkJqQn/8/mPKI7dPgr0voUGn3zKGywscG4hbA98j9D/Z6N2W1gSRvDaHMZ68KeVnAyCbU38s46dsyoaCxzg+LcTQNRMzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b3ZDUq6D; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b3ZDUq6D"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7189A1F00A3A;
	Wed, 22 Jul 2026 10:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784716232;
	bh=zOPk47IEbqjiMu9c1TrZY+SWaVZMg0NMQzpCqfYDORs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=b3ZDUq6D9ylYbZ/4y3U54xOixY7xl4SaazdPWth7HvYFtgBNdCXrmCazIMO7C0pbJ
	 PCrN8jAqPLuzQgkkeDSYjAHj5vSdXGxs47z9RBLYIIOL+ZeZ4ZwWfFce1Ewf8fFceF
	 DOBVG/TTuS0Vx1q6AwcLeZpEf4wKC27lNK1ET7O1dv4U/3cd49nKy/D+U24h25yQqL
	 MlWIMLMZrjlseYqXn51WYZL3Q9c9CJWc+uYYR26IqacCDIJrXulgXMHiuxsxhAJK89
	 HyLk9Jfn5awW9dtsuOuBvjHmEiroZAjzQz0ztaUtDzgbHWBSDx0o5PQ66SfyxD/GY/
	 /ydQqZAJ7VhSQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Akhil R <akhilrajeev@nvidia.com>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Wolfram Sang <wsa@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 2/7] i2c: smbus: Use device_*() functions instead of of_*()
Date: Wed, 22 Jul 2026 06:30:23 -0400
Message-ID: <20260722103029.890864-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260722103029.890864-1-sashal@kernel.org>
References: <2026071657-book-manhandle-a0e6@gregkh>
 <20260722103029.890864-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Akhil R <akhilrajeev@nvidia.com>

[ Upstream commit a263a84088f689bf0c1552a510b25d0bcc45fcae ]

Change of_*() functions to device_*() for firmware agnostic usage.
This allows to have the smbus_alert interrupt without any changes
in the controller drivers using the ACPI table.

Signed-off-by: Akhil R <akhilrajeev@nvidia.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Wolfram Sang <wsa@kernel.org>
Stable-dep-of: 158efa411c57 ("i2c: core: fix adapter probe deferral loop")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/i2c/i2c-core-base.c  |  2 +-
 drivers/i2c/i2c-core-smbus.c | 11 ++++++-----
 drivers/i2c/i2c-smbus.c      |  5 +++--
 include/linux/i2c-smbus.h    |  6 +++---
 4 files changed, 13 insertions(+), 11 deletions(-)

diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
index ef6d52a38b5c94..7228ac451dd0f0 100644
--- a/drivers/i2c/i2c-core-base.c
+++ b/drivers/i2c/i2c-core-base.c
@@ -1464,7 +1464,7 @@ static int i2c_register_adapter(struct i2c_adapter *adap)
 		goto out_list;
 	}
 
-	res = of_i2c_setup_smbus_alert(adap);
+	res = i2c_setup_smbus_alert(adap);
 	if (res)
 		goto out_reg;
 
diff --git a/drivers/i2c/i2c-core-smbus.c b/drivers/i2c/i2c-core-smbus.c
index f5c9787992e96d..8b588a14acba71 100644
--- a/drivers/i2c/i2c-core-smbus.c
+++ b/drivers/i2c/i2c-core-smbus.c
@@ -14,6 +14,7 @@
 #include <linux/err.h>
 #include <linux/i2c.h>
 #include <linux/i2c-smbus.h>
+#include <linux/property.h>
 #include <linux/slab.h>
 
 #include "i2c-core.h"
@@ -699,13 +700,13 @@ struct i2c_client *i2c_new_smbus_alert_device(struct i2c_adapter *adapter,
 }
 EXPORT_SYMBOL_GPL(i2c_new_smbus_alert_device);
 
-#if IS_ENABLED(CONFIG_I2C_SMBUS) && IS_ENABLED(CONFIG_OF)
-int of_i2c_setup_smbus_alert(struct i2c_adapter *adapter)
+#if IS_ENABLED(CONFIG_I2C_SMBUS)
+int i2c_setup_smbus_alert(struct i2c_adapter *adapter)
 {
 	int irq;
 
-	irq = of_property_match_string(adapter->dev.of_node, "interrupt-names",
-				       "smbus_alert");
+	irq = device_property_match_string(adapter->dev.parent, "interrupt-names",
+					   "smbus_alert");
 	if (irq == -EINVAL || irq == -ENODATA)
 		return 0;
 	else if (irq < 0)
@@ -713,5 +714,5 @@ int of_i2c_setup_smbus_alert(struct i2c_adapter *adapter)
 
 	return PTR_ERR_OR_ZERO(i2c_new_smbus_alert_device(adapter, NULL));
 }
-EXPORT_SYMBOL_GPL(of_i2c_setup_smbus_alert);
+EXPORT_SYMBOL_GPL(i2c_setup_smbus_alert);
 #endif
diff --git a/drivers/i2c/i2c-smbus.c b/drivers/i2c/i2c-smbus.c
index 44582cf29e1622..cacdadb9415c5d 100644
--- a/drivers/i2c/i2c-smbus.c
+++ b/drivers/i2c/i2c-smbus.c
@@ -13,7 +13,7 @@
 #include <linux/interrupt.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
-#include <linux/of_irq.h>
+#include <linux/property.h>
 #include <linux/slab.h>
 #include <linux/workqueue.h>
 
@@ -178,7 +178,8 @@ static int smbalert_probe(struct i2c_client *ara,
 	if (setup) {
 		irq = setup->irq;
 	} else {
-		irq = of_irq_get_byname(adapter->dev.of_node, "smbus_alert");
+		irq = fwnode_irq_get_byname(dev_fwnode(adapter->dev.parent),
+					    "smbus_alert");
 		if (irq <= 0)
 			return irq;
 	}
diff --git a/include/linux/i2c-smbus.h b/include/linux/i2c-smbus.h
index 1ef421818d3a8f..95cf902e0bdae3 100644
--- a/include/linux/i2c-smbus.h
+++ b/include/linux/i2c-smbus.h
@@ -30,10 +30,10 @@ struct i2c_client *i2c_new_smbus_alert_device(struct i2c_adapter *adapter,
 					      struct i2c_smbus_alert_setup *setup);
 int i2c_handle_smbus_alert(struct i2c_client *ara);
 
-#if IS_ENABLED(CONFIG_I2C_SMBUS) && IS_ENABLED(CONFIG_OF)
-int of_i2c_setup_smbus_alert(struct i2c_adapter *adap);
+#if IS_ENABLED(CONFIG_I2C_SMBUS)
+int i2c_setup_smbus_alert(struct i2c_adapter *adap);
 #else
-static inline int of_i2c_setup_smbus_alert(struct i2c_adapter *adap)
+static inline int i2c_setup_smbus_alert(struct i2c_adapter *adap)
 {
 	return 0;
 }
-- 
2.53.0

