Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 382E32F8E9D;
	Mon, 13 Jul 2026 15:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783958173; cv=none; b=hwqAPyywJluh93/GQzSJ0g690IqSAWgMXix227hFexz0pyrRHGLYx1qcfurjkI/5h6QXQ84xfWBiZnQQ3nvrtYxVFaYY8/jlM/qEM6jjPJjsfBq6mFRgJYEXWOH6p04hsjw4zQEb97oCbCbecoietSUyUja9kv9Pd2q9JxbG/60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783958173; c=relaxed/simple;
	bh=qwrq7LpC08ZjSStAQgp888cE2YDXb0mIxpKFUlDH6ZI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b5CnDHCt1ifpKGEipu6EKBie0T/8EBnJyHv1F34zMDBtP+6PyfjRZKsBiriP8BwxN3Dpe8k5WO53sr6y9Gr+B94rQM/fHoptNA+YqqEYZU5VdphpXTxdUW3tifRWSrZPA/ZQiQMvP+GXhnyxZNuy1Rqf/pIWJhBJZla/hAbkEps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ja/3jPRN; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ja/3jPRN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783958171; x=1815494171;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qwrq7LpC08ZjSStAQgp888cE2YDXb0mIxpKFUlDH6ZI=;
  b=ja/3jPRNkHNp5FjzwdyI63rBIA01hy7szDgsNNt0rur/NG5xUUIETMuK
   vdOfpnHlpKpSLTFLgpiF0fhF7LNuPZ7IaSpkcCPpdNfgXncTMz/ZV9q/j
   Wp+VMR3GtHfEjTQTRARRu18H82jH94KhkdX/Pezx4V4KqTlU8dHvsMhdu
   gF35l+R7P3+yp4s0pEEG30xfgfnqohEwljPM03ofoL+YSZAX2I5hZAkcx
   Xh/5VTfA3h17adVV43o3UzOviLUVAG/IT9+1YBg1npjUaHJghvsflxYjC
   U7wLHkYFicKnZjJX3DX+zKABnEqBuLBCE1uw/4MuityL2CtWaljjeMvUc
   Q==;
X-CSE-ConnectionGUID: tr/xWAPcRFG8wtNinnTqBQ==
X-CSE-MsgGUID: cjSxD2tkQRez2SWv15Np5Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="88393419"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="88393419"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2026 08:56:11 -0700
X-CSE-ConnectionGUID: dS5mVy80TTOppFFAtzbulA==
X-CSE-MsgGUID: DSM3N9RhThWXKXvFgKY2BA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="293774655"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa001.jf.intel.com with ESMTP; 13 Jul 2026 08:56:08 -0700
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Matthew Brost <matthew.brost@intel.com>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Raag Jadav <raag.jadav@intel.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Andi Shyti <andi.shyti@kernel.org>,
	Ramesh Babu B <ramesh.babu.b@intel.com>,
	"Michael J. Ruhl" <michael.j.ruhl@intel.com>,
	linux-kernel@vger.kernel.org,
	intel-xe@lists.freedesktop.org,
	stable@vger.kernel.org
Subject: [PATCH v4 2/3] drm/xe/i2c: Fix the interrupt handling
Date: Mon, 13 Jul 2026 17:56:00 +0200
Message-ID: <20260713155601.711389-3-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260713155601.711389-1-heikki.krogerus@linux.intel.com>
References: <20260713155601.711389-1-heikki.krogerus@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The platforms that support the interrupt from the I2C
adapter can not handle the amount of interrupts the adapter
generates because of the way the IRQ is routed in the
hardware. The I2C controller driver has to be kept in
polling mode because of that.

The AMC MCU can still generate critical alerts that have to
be handled. The interrupt from SMBus Alert is left enabled
and handled separately in the Xe. The alerts from the AMC
will cause the device to be declared wedged for now.

Fixes: f0e53aadd702 ("drm/xe: Support for I2C attached MCUs")
Cc: stable@vger.kernel.org
Co-developed-by: Ramesh Babu B <ramesh.babu.b@intel.com>
Signed-off-by: Ramesh Babu B <ramesh.babu.b@intel.com>
Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 drivers/gpu/drm/xe/Makefile           |   4 +-
 drivers/gpu/drm/xe/regs/xe_i2c_regs.h |   2 +
 drivers/gpu/drm/xe/xe_amc.c           | 173 ++++++++++++++++++++++++++
 drivers/gpu/drm/xe/xe_amc.h           |  25 ++++
 drivers/gpu/drm/xe/xe_i2c.c           |  93 +++++---------
 drivers/gpu/drm/xe/xe_i2c.h           |  13 +-
 6 files changed, 241 insertions(+), 69 deletions(-)
 create mode 100644 drivers/gpu/drm/xe/xe_amc.c
 create mode 100644 drivers/gpu/drm/xe/xe_amc.h

diff --git a/drivers/gpu/drm/xe/Makefile b/drivers/gpu/drm/xe/Makefile
index 67ada1d6c2fb9..c92468cb9b894 100644
--- a/drivers/gpu/drm/xe/Makefile
+++ b/drivers/gpu/drm/xe/Makefile
@@ -153,7 +153,9 @@ xe-y += xe_bb.o \
 	xe_wait_user_fence.o \
 	xe_wopcm.o
 
-xe-$(CONFIG_I2C)	+= xe_i2c.o
+xe-$(CONFIG_I2C)	+= xe_i2c.o \
+			   xe_amc.o
+
 xe-$(CONFIG_DRM_XE_GPUSVM) += xe_svm.o
 xe-$(CONFIG_DRM_GPUSVM) += xe_userptr.o
 
diff --git a/drivers/gpu/drm/xe/regs/xe_i2c_regs.h b/drivers/gpu/drm/xe/regs/xe_i2c_regs.h
index f2e455e2bfe45..37550e4a20f80 100644
--- a/drivers/gpu/drm/xe/regs/xe_i2c_regs.h
+++ b/drivers/gpu/drm/xe/regs/xe_i2c_regs.h
@@ -20,4 +20,6 @@
 #define I2C_CONFIG_CMD			XE_REG(I2C_CONFIG_SPACE_OFFSET + PCI_COMMAND)
 #define I2C_CONFIG_PMCSR		XE_REG(I2C_CONFIG_SPACE_OFFSET + 0x84)
 
+#define I2C_REG(reg)			XE_REG((reg) + I2C_MEM_SPACE_OFFSET)
+
 #endif /* _XE_I2C_REGS_H_ */
diff --git a/drivers/gpu/drm/xe/xe_amc.c b/drivers/gpu/drm/xe/xe_amc.c
new file mode 100644
index 0000000000000..60ac4936a5f89
--- /dev/null
+++ b/drivers/gpu/drm/xe/xe_amc.c
@@ -0,0 +1,173 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2026 Intel Corporation.
+ */
+
+#include <linux/delay.h>
+#include <linux/dev_printk.h>
+#include <linux/i2c.h>
+#include <linux/pci_ids.h>
+#include <linux/slab.h>
+#include <linux/string.h>
+#include <linux/workqueue.h>
+
+#include "xe_amc.h"
+#include "xe_device.h"
+#include "xe_i2c.h"
+
+/**
+ * DOC: Add-In Management Controller (AMC)
+ *
+ * Handler for the SMBus Alerts from the AMC. All the alerts from AMC will cause
+ * the device to be declared wedged.
+ */
+
+#define AMC_COMMAND		0x0f
+#define AMC_GPU_I2C_ADDR	0x8f
+#define AMC_VERSION_V1		0x01
+#define AMC_DESTINATION_ID	12
+#define AMC_SOURCE_ID		8
+#define AMC_FLAGS		0xc8
+
+#define AMC_MSG_TYPE		0x7e
+#define AMC_GET_ALERT_REASON	0x01
+
+enum xe_amc_alert {
+	AMC_ALERT_UNKNOWN,
+	AMC_ALERT_FW_DOWNLOAD,
+	AMC_ALERT_THERMAL_TRIP,
+	AMC_ALERT_OOB_REQUEST,
+	AMC_ALERT_OOB_RESET,
+	AMC_ALERT_CATERR,
+};
+
+struct xe_amc {
+	struct xe_i2c *i2c;
+	struct work_struct work;
+};
+
+struct amc_header {
+	u8 command;
+	u8 len;
+	u8 address;
+	u8 version;
+	u8 destination;
+	u8 source;
+	u8 flags;
+};
+
+struct amc_message {
+	u8 type;
+	u16 vendor;
+	u8 command;
+} __packed;
+
+struct amc_request {
+	struct amc_header header;
+	struct amc_message message;
+	u32 reserved;
+} __packed;
+
+struct amc_response {
+	struct amc_header header;
+	struct amc_message message;
+	u8 error;
+	u8 value;
+} __packed;
+
+static const struct amc_request amc_get_alert_reason = {
+	.header = {
+		.command	= AMC_COMMAND,
+		.len		= sizeof(struct amc_request) - 2,
+		.address	= AMC_GPU_I2C_ADDR,
+		.version	= AMC_VERSION_V1,
+		.destination	= AMC_DESTINATION_ID,
+		.source		= AMC_SOURCE_ID,
+		.flags		= AMC_FLAGS,
+	},
+	.message = {
+		.type		= AMC_MSG_TYPE,
+		.vendor		= htons(PCI_VENDOR_ID_INTEL),
+		.command	= AMC_GET_ALERT_REASON,
+	},
+};
+
+static void xe_amc_work(struct work_struct *work)
+{
+	struct xe_amc *amc = from_work(amc, work, work);
+	struct i2c_client *client = amc->i2c->client[XE_I2C_CLIENT_AMC];
+	const struct amc_request *request = &amc_get_alert_reason;
+	struct amc_response response;
+	int ret;
+
+	ret = i2c_master_send(client, (u8 *)request, sizeof(*request));
+	if (ret < 0) {
+		dev_err(&client->dev, "failed to send request (%d)\n", ret);
+		return;
+	}
+
+	fsleep(20 * USEC_PER_MSEC);
+
+	ret = i2c_master_recv(client, (u8 *)&response, sizeof(response));
+	if (ret < 0) {
+		dev_err(&client->dev, "failed to read response (%d)\n", ret);
+		return;
+	}
+
+	if (response.header.len == 0) {
+		dev_err(&client->dev, "empty response from AMC\n");
+		return;
+	}
+
+	if (response.header.command != request->header.command ||
+	    memcmp(&response.message, &request->message, sizeof(struct amc_message))) {
+		dev_err(&client->dev, "response does not match the request\n");
+		return;
+	}
+
+	if (response.error) {
+		dev_err(&client->dev, "AMC error 0x%02x\n", response.error);
+		return;
+	}
+
+	dev_dbg(&client->dev, "%s: Alert reason: %d\n", __func__, response.value);
+
+	switch (response.value) {
+	case AMC_ALERT_FW_DOWNLOAD:
+	case AMC_ALERT_THERMAL_TRIP:
+	case AMC_ALERT_OOB_REQUEST:
+	case AMC_ALERT_OOB_RESET:
+	case AMC_ALERT_CATERR:
+		xe_device_declare_wedged(i2c_client_to_xe_device(client));
+		break;
+	default:
+		break;
+	}
+}
+
+void xe_amc_handle_alert(struct xe_i2c *i2c)
+{
+	if (i2c->client[XE_I2C_CLIENT_AMC])
+		queue_work(system_long_wq, &i2c->amc->work);
+}
+
+int xe_amc_init(struct xe_i2c *i2c)
+{
+	struct xe_amc *amc;
+
+	amc = kzalloc(sizeof(*amc), GFP_KERNEL);
+	if (!amc)
+		return -ENOMEM;
+
+	INIT_WORK(&amc->work, xe_amc_work);
+	i2c->amc = amc;
+	amc->i2c = i2c;
+
+	return 0;
+}
+
+void xe_amc_exit(struct xe_i2c *i2c)
+{
+	cancel_work_sync(&i2c->amc->work);
+	kfree(i2c->amc);
+}
diff --git a/drivers/gpu/drm/xe/xe_amc.h b/drivers/gpu/drm/xe/xe_amc.h
new file mode 100644
index 0000000000000..b1d5311fee536
--- /dev/null
+++ b/drivers/gpu/drm/xe/xe_amc.h
@@ -0,0 +1,25 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _XE_AMC_H_
+#define _XE_AMC_H_
+
+#include <linux/i2c.h>
+
+#include "xe_device.h"
+
+struct xe_i2c;
+
+static inline struct xe_device *i2c_adapter_to_xe_device(struct i2c_adapter *adapter)
+{
+	return kdev_to_xe_device(adapter->dev.parent->parent);
+}
+
+static inline struct xe_device *i2c_client_to_xe_device(struct i2c_client *client)
+{
+	return i2c_adapter_to_xe_device(client->adapter);
+}
+
+int xe_amc_init(struct xe_i2c *i2c);
+void xe_amc_exit(struct xe_i2c *i2c);
+void xe_amc_handle_alert(struct xe_i2c *i2c);
+
+#endif /* _XE_AMC_H_ */
diff --git a/drivers/gpu/drm/xe/xe_i2c.c b/drivers/gpu/drm/xe/xe_i2c.c
index bd956776b10be..7fa1b16598ee6 100644
--- a/drivers/gpu/drm/xe/xe_i2c.c
+++ b/drivers/gpu/drm/xe/xe_i2c.c
@@ -12,8 +12,6 @@
 #include <linux/err.h>
 #include <linux/i2c.h>
 #include <linux/ioport.h>
-#include <linux/irq.h>
-#include <linux/irqdomain.h>
 #include <linux/notifier.h>
 #include <linux/pci.h>
 #include <linux/platform_device.h>
@@ -24,9 +22,12 @@
 #include <linux/types.h>
 #include <linux/workqueue.h>
 
+#include <linux/designware_i2c.h>
+
 #include "regs/xe_i2c_regs.h"
 #include "regs/xe_irq_regs.h"
 
+#include "xe_amc.h"
 #include "xe_device.h"
 #include "xe_i2c.h"
 #include "xe_mmio.h"
@@ -61,6 +62,20 @@ static inline void xe_i2c_read_endpoint(struct xe_mmio *mmio, void *ep)
 	val[1] = xe_mmio_read32(mmio, REG_SG_REMAP_ADDR_POSTFIX);
 }
 
+static void xe_i2c_handle_smbus_alert(struct xe_i2c *i2c)
+{
+	u32 stat;
+
+	stat = xe_mmio_read32(i2c->mmio, I2C_REG(DW_IC_SMBUS_INTR_STAT));
+	if (!stat)
+		return;
+
+	xe_mmio_write32(i2c->mmio, I2C_REG(DW_IC_CLR_SMBUS_INTR), stat);
+
+	if (stat & DW_IC_SMBUS_INTR_ALERT)
+		xe_amc_handle_alert(i2c);
+}
+
 static void xe_i2c_client_work(struct work_struct *work)
 {
 	struct xe_i2c *i2c = container_of(work, struct xe_i2c, work);
@@ -70,7 +85,7 @@ static void xe_i2c_client_work(struct work_struct *work)
 		.addr	= i2c->ep.addr[1],
 	};
 
-	i2c->client[0] = i2c_new_client_device(i2c->adapter, &info);
+	i2c->client[XE_I2C_CLIENT_AMC] = i2c_new_client_device(i2c->adapter, &info);
 }
 
 static int xe_i2c_notifier(struct notifier_block *nb, unsigned long action, void *data)
@@ -112,16 +127,6 @@ static int xe_i2c_register_adapter(struct xe_i2c *i2c)
 		goto err_fwnode_remove;
 	}
 
-	if (i2c->adapter_irq) {
-		struct resource res;
-
-		res = DEFINE_RES_IRQ_NAMED(i2c->adapter_irq, "xe_i2c");
-
-		ret = platform_device_add_resources(pdev, &res, 1);
-		if (ret)
-			goto err_pdev_put;
-	}
-
 	pdev->dev.parent = i2c->drm_dev;
 	pdev->dev.fwnode = fwnode;
 	i2c->adapter_node = fwnode;
@@ -163,7 +168,8 @@ bool xe_i2c_present(struct xe_device *xe)
 
 static bool xe_i2c_irq_present(struct xe_device *xe)
 {
-	return xe->i2c && xe->i2c->adapter_irq;
+	return xe->i2c && xe->i2c->ep.capabilities & XE_I2C_EP_CAP_IRQ &&
+		!xe_survivability_mode_is_boot_enabled(xe);
 }
 
 /**
@@ -181,8 +187,7 @@ void xe_i2c_irq_handler(struct xe_device *xe, u32 master_ctl)
 	if (!(master_ctl & I2C_IRQ) || !xe_i2c_irq_present(xe))
 		return;
 
-	/* Forward interrupt to I2C adapter */
-	generic_handle_irq_safe(xe->i2c->adapter_irq);
+	xe_i2c_handle_smbus_alert(xe->i2c);
 
 	/* Deassert after I2C adapter clears the interrupt */
 	xe_mmio_rmw32(mmio, I2C_CONFIG_CMD, 0, PCI_COMMAND_INTX_DISABLE);
@@ -212,45 +217,6 @@ void xe_i2c_irq_postinstall(struct xe_device *xe)
 	xe_mmio_rmw32(mmio, I2C_CONFIG_CMD, PCI_COMMAND_INTX_DISABLE, 0);
 }
 
-static int xe_i2c_irq_map(struct irq_domain *h, unsigned int virq,
-			  irq_hw_number_t hw_irq_num)
-{
-	irq_set_chip_and_handler(virq, &dummy_irq_chip, handle_simple_irq);
-	return 0;
-}
-
-static const struct irq_domain_ops xe_i2c_irq_ops = {
-	.map = xe_i2c_irq_map,
-};
-
-static int xe_i2c_create_irq(struct xe_device *xe)
-{
-	struct xe_i2c *i2c = xe->i2c;
-	struct irq_domain *domain;
-
-	if (!(i2c->ep.capabilities & XE_I2C_EP_CAP_IRQ) ||
-	    xe_survivability_mode_is_boot_enabled(xe))
-		return 0;
-
-	domain = irq_domain_create_linear(dev_fwnode(i2c->drm_dev), 1, &xe_i2c_irq_ops, NULL);
-	if (!domain)
-		return -ENOMEM;
-
-	i2c->adapter_irq = irq_create_mapping(domain, 0);
-	i2c->irqdomain = domain;
-
-	return 0;
-}
-
-static void xe_i2c_remove_irq(struct xe_i2c *i2c)
-{
-	if (!i2c->irqdomain)
-		return;
-
-	irq_dispose_mapping(i2c->adapter_irq);
-	irq_domain_remove(i2c->irqdomain);
-}
-
 static int xe_i2c_read(void *context, unsigned int reg, unsigned int *val)
 {
 	struct xe_i2c *i2c = context;
@@ -307,12 +273,15 @@ static void xe_i2c_remove(void *data)
 	struct xe_i2c *i2c = data;
 	unsigned int i;
 
-	for (i = 0; i < XE_I2C_MAX_CLIENTS; i++)
+	xe_amc_exit(i2c);
+
+	for (i = 0; i < XE_I2C_MAX_CLIENTS; i++) {
 		i2c_unregister_device(i2c->client[i]);
+		i2c->client[i] = NULL;
+	}
 
 	bus_unregister_notifier(&i2c_bus_type, &i2c->bus_notifier);
 	xe_i2c_unregister_adapter(i2c);
-	xe_i2c_remove_irq(i2c);
 }
 
 /**
@@ -360,19 +329,19 @@ int xe_i2c_probe(struct xe_device *xe)
 	if (ret)
 		return ret;
 
-	ret = xe_i2c_create_irq(xe);
+	ret = xe_i2c_register_adapter(i2c);
 	if (ret)
 		goto err_unregister_notifier;
 
-	ret = xe_i2c_register_adapter(i2c);
+	ret = xe_amc_init(i2c);
 	if (ret)
-		goto err_remove_irq;
+		goto err_remove_adapter;
 
 	xe_i2c_irq_postinstall(xe);
 	return devm_add_action_or_reset(drm_dev, xe_i2c_remove, i2c);
 
-err_remove_irq:
-	xe_i2c_remove_irq(i2c);
+err_remove_adapter:
+	xe_i2c_remove(i2c);
 
 err_unregister_notifier:
 	bus_unregister_notifier(&i2c_bus_type, &i2c->bus_notifier);
diff --git a/drivers/gpu/drm/xe/xe_i2c.h b/drivers/gpu/drm/xe/xe_i2c.h
index 425d8160835f4..c95f98c2053d5 100644
--- a/drivers/gpu/drm/xe/xe_i2c.h
+++ b/drivers/gpu/drm/xe/xe_i2c.h
@@ -11,18 +11,21 @@ struct device;
 struct fwnode_handle;
 struct i2c_adapter;
 struct i2c_client;
-struct irq_domain;
 struct platform_device;
+struct xe_amc;
 struct xe_device;
 struct xe_mmio;
 
-#define XE_I2C_MAX_CLIENTS		3
-
 #define XE_I2C_EP_COOKIE_DEVICE		0xde
 
 /* Endpoint Capabilities */
 #define XE_I2C_EP_CAP_IRQ		BIT(0)
 
+enum XE_I2C_CLIENT {
+	XE_I2C_CLIENT_AMC,
+	XE_I2C_MAX_CLIENTS = 3,
+};
+
 struct xe_i2c_endpoint {
 	u8 cookie;
 	u8 capabilities;
@@ -38,13 +41,11 @@ struct xe_i2c {
 	struct notifier_block bus_notifier;
 	struct work_struct work;
 
-	struct irq_domain *irqdomain;
-	int adapter_irq;
-
 	struct xe_i2c_endpoint ep;
 	struct device *drm_dev;
 
 	struct xe_mmio *mmio;
+	struct xe_amc *amc;
 };
 
 #if IS_ENABLED(CONFIG_I2C)
-- 
2.50.1

