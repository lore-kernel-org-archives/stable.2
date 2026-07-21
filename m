Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5492D471271
	for <stable@vger.kernel.org>; Tue, 21 Jul 2026 18:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784658483; cv=none; b=mKB9m4Os/q1Y96eTBLJgI/LSBqmOZzULANsBPqhchhDRUoW4+hNajWRmRZY136+pvACkFGDbfCaSdygIbOABxv0pq1j/ueucI+pFGmx2r0pHLjn+zdpRKEhrfrVWl2T0eO1BmxRfFEPlM6XgKbkQlbSPe0bQ1Y2gvnk84MRSXEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784658483; c=relaxed/simple;
	bh=1+4oDfuamLa6fmUIbHdVv4PGf3/tBJhyDcW1+EEeUYc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=usCOjaSBL/Z+/XK/w145PJhldNHc7J3bimOa/tuVTethC+OlqTiYZfVhiLg2tnZGYEob+NpEJaM0hSnVTSC8Y2yTnc06e+TNdoU5ihjWfbXoVv7uJns4nEpKoV0jSkoiJ63mLypaaaxRQqP1iagwq2l6/SXkCOlVQUU4+CgVY34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dVBIs073; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dVBIs073"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F4061F000E9;
	Tue, 21 Jul 2026 18:28:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784658481;
	bh=7PnnmfXtAdUQsi7QOPDjTl/FdZ2RGdVypRtxrkeecfM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dVBIs073G+bCWRruBnhjGZzv+dqh/nZVixxL9exmR7Kerv6OaEfV/DYX9zcuxhWNB
	 rjzDy1L/yV3mE+lwWOZruF5WhaN7diTXA02U4wkkFwqJT4wEH+o8P1FzDPa+apZeTu
	 nbU5nlvOyY94kh3m11Pcv6K6tHCQPoD4K+jOmfcvWNfZD1p9lpI6EIRpBB6pOzipDU
	 rUSbUnUQPjvdd5WT5r69nWSTnadYkYwRTSLjC4h7eHENJ3TH41ZhBz0kpySOB6nPpn
	 e0MQ7j5UTIt53IJziGwEGe1rsRLVhUGLvmSY3cT60WZNyy0WWh+diYsoAdqUEqoWGP
	 SjPkrM+XO2FxA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Johan Hovold <johan@kernel.org>,
	Phil Reid <preid@electromag.com.au>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/4] i2c: core: fix hang on adapter registration failure
Date: Tue, 21 Jul 2026 14:27:56 -0400
Message-ID: <20260721182758.332454-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260721182758.332454-1-sashal@kernel.org>
References: <2026071636-amusing-conduit-3c6b@gregkh>
 <20260721182758.332454-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johan Hovold <johan@kernel.org>

[ Upstream commit 3c7e164344e5bcf6f274bbf59a3274f5caad9bc1 ]

Clients may be registered from bus notifier callbacks when the adapter
is registered. On a subsequent error during registration, the adapter
references taken by such clients prevent the wait for the references to
be released from ever completing.

Fix this by refactoring client deregistration and deregistering also on
late adapter registration failures.

Fixes: f8756c67b3de ("i2c: core: call of_i2c_setup_smbus_alert in i2c_register_adapter")
Cc: stable@vger.kernel.org	# 4.15
Cc: Phil Reid <preid@electromag.com.au>
Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Stable-dep-of: 07d5fb537928 ("i2c: core: fix adapter debugfs creation")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/i2c/i2c-core-base.c | 49 ++++++++++++++++++++++---------------
 1 file changed, 29 insertions(+), 20 deletions(-)

diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
index 4b3bc72ef53ddf..14f09576bf5fc5 100644
--- a/drivers/i2c/i2c-core-base.c
+++ b/drivers/i2c/i2c-core-base.c
@@ -63,6 +63,7 @@
 static DEFINE_MUTEX(core_lock);
 static DEFINE_IDR(i2c_adapter_idr);
 
+static void i2c_deregister_clients(struct i2c_adapter *adap);
 static int i2c_detect(struct i2c_adapter *adapter, struct i2c_driver *driver);
 
 static DEFINE_STATIC_KEY_FALSE(i2c_trace_msg_key);
@@ -1595,6 +1596,7 @@ static int i2c_register_adapter(struct i2c_adapter *adap)
 	return 0;
 
 out_reg:
+	i2c_deregister_clients(adap);
 	debugfs_remove_recursive(adap->debugfs);
 	init_completion(&adap->dev_released);
 	device_unregister(&adap->dev);
@@ -1738,29 +1740,10 @@ static int __process_removed_adapter(struct device_driver *d, void *data)
 	return 0;
 }
 
-/**
- * i2c_del_adapter - unregister I2C adapter
- * @adap: the adapter being unregistered
- * Context: can sleep
- *
- * This unregisters an I2C adapter which was previously registered
- * by @i2c_add_adapter or @i2c_add_numbered_adapter.
- */
-void i2c_del_adapter(struct i2c_adapter *adap)
+static void i2c_deregister_clients(struct i2c_adapter *adap)
 {
-	struct i2c_adapter *found;
 	struct i2c_client *client, *next;
 
-	/* First make sure that this adapter was ever added */
-	mutex_lock(&core_lock);
-	found = idr_find(&i2c_adapter_idr, adap->nr);
-	mutex_unlock(&core_lock);
-	if (found != adap) {
-		pr_debug("attempting to delete unregistered adapter [%s]\n", adap->name);
-		return;
-	}
-
-	i2c_acpi_remove_space_handler(adap);
 	/* Tell drivers about this removal */
 	mutex_lock(&core_lock);
 	bus_for_each_drv(&i2c_bus_type, NULL, adap,
@@ -1786,6 +1769,32 @@ void i2c_del_adapter(struct i2c_adapter *adap)
 	 * them up properly, so we give them a chance to do that first. */
 	device_for_each_child(&adap->dev, NULL, __unregister_client);
 	device_for_each_child(&adap->dev, NULL, __unregister_dummy);
+}
+
+/**
+ * i2c_del_adapter - unregister I2C adapter
+ * @adap: the adapter being unregistered
+ * Context: can sleep
+ *
+ * This unregisters an I2C adapter which was previously registered
+ * by @i2c_add_adapter or @i2c_add_numbered_adapter.
+ */
+void i2c_del_adapter(struct i2c_adapter *adap)
+{
+	struct i2c_adapter *found;
+
+	/* First make sure that this adapter was ever added */
+	mutex_lock(&core_lock);
+	found = idr_find(&i2c_adapter_idr, adap->nr);
+	mutex_unlock(&core_lock);
+	if (found != adap) {
+		pr_debug("attempting to delete unregistered adapter [%s]\n", adap->name);
+		return;
+	}
+
+	i2c_acpi_remove_space_handler(adap);
+
+	i2c_deregister_clients(adap);
 
 #ifdef CONFIG_I2C_COMPAT
 	class_compat_remove_link(i2c_adapter_compat_class, &adap->dev,
-- 
2.53.0

