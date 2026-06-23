Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D85E1379C23;
	Tue, 23 Jun 2026 11:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782214880; cv=none; b=NMAw4w+cBatBxRQhOZ2TG+wvJxNsZXTQpgf93x811otB6LIRw5uDpbhg3zMWH3TcOXmqnhVErr+JOdK25AuHpp5U7z1UYrzxolfzRAO7F0CiC0b6meWk40wF65mfRQ4Mezo05pO57/oXjTfWo+OosmLB5yaf6czoqU8Ufk9LXXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782214880; c=relaxed/simple;
	bh=P1O4Peh2GQajhAgi2qRFo0a504zzt+m8zHHplCe5OQ0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DCg3/Pmq2hr0hdVTE37cFThCIEa3c3fJkUkIkOaP+5uYWdscbjzfNQf9B57zLZ4sklbfn2crlOS1Sy/LP8uzvfKd9j3zQprOEBFwLl+tw3qL6stmFNeFxX1DI2XP9AWUNoopuAlCXQIpqGDALTRnoZMRfKJusqMqC/buSsz7X1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=XS8RxKKT; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="XS8RxKKT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=Bx
	YXQsgR/auECzMSZJFFhJW9pN2lNiQIvoFrCfIi9Kg=; b=XS8RxKKTev/LSmLOm0
	7aHFUE3WCphSUX8BI1v5kojfHvAwhTNzBCF2olEdcxsZWf2ioaCLIZU8RROZFYES
	VAKrK/kYci6pXjWpGbsCpFx4DgzNds4pyZZG46BISzitH9GOvZRclGbqUeU3b+O7
	tnpz+O0O7PDFQGvbreZE5Y3VI=
Received: from 163.com (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wD33xnAcDpqTl49FQ--.44205S2;
	Tue, 23 Jun 2026 19:40:51 +0800 (CST)
From: w15303746062@163.com
To: arnd@arndb.de,
	gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	kees@kernel.org,
	stable@vger.kernel.org,
	Mingyu Wang <25181214217@stu.xidian.edu.cn>
Subject: [PATCH v2] misc: ibmasm: Fix static and dynamic out-of-bounds MMIO accesses
Date: Tue, 23 Jun 2026 19:40:46 +0800
Message-Id: <20260623114046.368089-1-w15303746062@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <2026062354-crawfish-t-shirt-d45d@gregkh>
References: <2026062354-crawfish-t-shirt-d45d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD33xnAcDpqTl49FQ--.44205S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3XF4DGrWxtFyfuw4DXFy3twb_yoWxCF1xpF
	n0v3yrAry5AFW2vws7Kr409Fy5uas7KFWUKrW3Aa4fZFyYyFy5ZF1jka47XFW8X3WkK3yj
	yryDJryru3WjqrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jFBT5UUUUU=
X-CM-SenderInfo: jzrvjiatxuliiws6il2tof0z/xtbC4wN1WWo6cMMzCwAA3X

From: Mingyu Wang <25181214217@stu.xidian.edu.cn>

The ibmasm driver maps PCI BAR 0 without verifying if the hardware-provided
resource length is sufficient.

When evaluating the driver against emulated hardware or during virtual
device fuzzing, a malformed device may expose a significantly undersized
BAR 0. This leads to two distinct out-of-bounds (OOB) MMIO access vectors:

1. Static OOB: The driver hardcodes access to INTR_CONTROL_REGISTER
   (offset 0x13A4) during probe.
2. Dynamic OOB: The driver reads dynamic Message Frame Addresses (MFA)
   from hardware queues and uses them directly as offsets to dereference
   I2O messages via get_i2o_message(). A malicious MFA can cause the
   driver to access memory far beyond the mapped BAR.

If an OOB access triggers a #PF during module probe while holding the
idempotent_init_module() lock, it leaves the module loading subsystem
in a corrupted state, leading to a cascading global soft lockup.

Fix this comprehensively by:
- Storing the mapped resource size in 'struct service_processor'.
- Ensuring the BAR size covers the highest statically accessed register
  (INTR_CONTROL_REGISTER) during probe.
- Validating all dynamic MFA offsets against the mapped size before
  dereferencing to prevent dynamic OOB accesses.

Fixes: bdbeed75b288 ("pci: use pci_ioremap_bar() in drivers/misc")
Cc: stable@vger.kernel.org
Signed-off-by: Mingyu Wang <25181214217@stu.xidian.edu.cn>
---
Changes in v2:
 - Added dynamic MFA bounds checking in get_i2o_message() to prevent runtime OOB (prompted by Greg KH).
 - Implemented hardware mailbox deadlock prevention by releasing MFA if bounds check fails.
 - Fixed potential unsigned integer underflow in bounds check arithmetic.

 drivers/misc/ibmasm/ibmasm.h   |  1 +
 drivers/misc/ibmasm/lowlevel.c | 19 +++++++++++++++----
 drivers/misc/ibmasm/lowlevel.h | 27 +++++++++++++++++++++++++--
 drivers/misc/ibmasm/module.c   | 13 +++++++++++++
 4 files changed, 54 insertions(+), 6 deletions(-)

diff --git a/drivers/misc/ibmasm/ibmasm.h b/drivers/misc/ibmasm/ibmasm.h
index a5ced88ca923..8d69198bf10f 100644
--- a/drivers/misc/ibmasm/ibmasm.h
+++ b/drivers/misc/ibmasm/ibmasm.h
@@ -140,6 +140,7 @@ struct service_processor {
 	struct list_head	node;
 	spinlock_t		lock;
 	void __iomem		*base_address;
+	resource_size_t		mapped_size;
 	unsigned int		irq;
 	struct command		*current_command;
 	struct command		*heartbeat;
diff --git a/drivers/misc/ibmasm/lowlevel.c b/drivers/misc/ibmasm/lowlevel.c
index 5313230f36ad..db84e5f827cb 100644
--- a/drivers/misc/ibmasm/lowlevel.c
+++ b/drivers/misc/ibmasm/lowlevel.c
@@ -9,7 +9,6 @@
 
 #include "ibmasm.h"
 #include "lowlevel.h"
-#include "i2o.h"
 #include "dot_command.h"
 #include "remote.h"
 
@@ -34,7 +33,14 @@ int ibmasm_send_i2o_message(struct service_processor *sp)
 		return 1;
 
 	header.message_size = outgoing_message_size((unsigned int)command_size);
-	message = get_i2o_message(sp->base_address, mfa);
+	message = get_i2o_message(sp->base_address, sp->mapped_size, mfa);
+	if (!message) {
+		/* MFA was reserved for us; must release it to avoid
+		 * deadlocking the hardware mailbox.
+		 */
+		set_mfa_inbound(sp->base_address, mfa);
+		return 1;
+	}
 
 	memcpy_toio(&message->header, &header, sizeof(struct i2o_header));
 	memcpy_toio(&message->data, command->buffer, command_size);
@@ -63,8 +69,13 @@ irqreturn_t ibmasm_interrupt_handler(int irq, void * dev_id)
 
 	mfa = get_mfa_outbound(base_address);
 	if (valid_mfa(mfa)) {
-		struct i2o_message *msg = get_i2o_message(base_address, mfa);
-		ibmasm_receive_message(sp, &msg->data, incoming_data_size(msg));
+		struct i2o_message *msg = get_i2o_message(base_address,
+							  sp->mapped_size, mfa);
+		if (msg)
+			ibmasm_receive_message(sp, &msg->data,
+					       incoming_data_size(msg));
+		else
+			dbg("received mfa out of bounds\n");
 	} else
 		dbg("didn't get a valid MFA\n");
 
diff --git a/drivers/misc/ibmasm/lowlevel.h b/drivers/misc/ibmasm/lowlevel.h
index 25f1ed07c3c5..8c9700fc70bb 100644
--- a/drivers/misc/ibmasm/lowlevel.h
+++ b/drivers/misc/ibmasm/lowlevel.h
@@ -13,6 +13,9 @@
 #define __IBMASM_CONDOR_H__
 
 #include <asm/io.h>
+#include <linux/compiler.h>
+#include <linux/types.h>
+#include "i2o.h"
 
 #define VENDORID_IBM	0x1014
 #define DEVICEID_RSA	0x010F
@@ -33,6 +36,9 @@
 #define INTR_STATUS_REGISTER   0x13A0
 #define INTR_CONTROL_REGISTER  0x13A4
 
+/* Highest statically accessed register offset */
+#define IBMASM_MAX_REG_OFFSET	INTR_CONTROL_REGISTER
+
 #define SCOUT_COM_A_BASE         0x0000
 #define SCOUT_COM_B_BASE         0x0100
 #define SCOUT_COM_C_BASE         0x0200
@@ -115,9 +121,26 @@ static inline void set_mfa_inbound(void __iomem *base_address, u32 mfa)
 	writel(mfa, base_address + INBOUND_QUEUE_PORT);
 }
 
-static inline struct i2o_message *get_i2o_message(void __iomem *base_address, u32 mfa)
+/**
+ * get_i2o_message - Convert MFA to i2o_message pointer with bounds check
+ * @base_address: BAR 0 virtual address
+ * @mapped_size:  actual size of BAR 0 mapping
+ * @mfa:          Message Frame Address from hardware
+ *
+ * Returns NULL if the offset derived from @mfa does not fit within
+ * the mapped BAR (including the i2o_message header).
+ */
+static inline struct i2o_message *get_i2o_message(void __iomem *base_address,
+						  resource_size_t mapped_size,
+						  u32 mfa)
 {
-	return (struct i2o_message *)(GET_MFA_ADDR(mfa) + base_address);
+	u32 offset = GET_MFA_ADDR(mfa);
+
+	/* Prevent read/write beyond the ioremap region */
+	if (unlikely(offset + sizeof(struct i2o_message) > mapped_size))
+		return NULL;
+
+	return (struct i2o_message *)(offset + base_address);
 }
 
 #endif /* __IBMASM_CONDOR_H__ */
diff --git a/drivers/misc/ibmasm/module.c b/drivers/misc/ibmasm/module.c
index 4509c15a76a8..87d4d698a5ff 100644
--- a/drivers/misc/ibmasm/module.c
+++ b/drivers/misc/ibmasm/module.c
@@ -93,6 +93,19 @@ static int ibmasm_init_one(struct pci_dev *pdev, const struct pci_device_id *id)
 	}
 
 	sp->irq = pdev->irq;
+	sp->mapped_size = pci_resource_len(pdev, 0);
+
+	/*
+	 * Ensure BAR 0 is large enough to cover the highest statically
+	 * accessed hardware register (IBMASM_MAX_REG_OFFSET).
+	 */
+	if (sp->mapped_size < IBMASM_MAX_REG_OFFSET + 4) {
+		dev_err(sp->dev, "PCI BAR0 too small, need at least %zu bytes\n",
+			(size_t)(IBMASM_MAX_REG_OFFSET + 4));
+		result = -ENODEV;
+		goto error_ioremap;
+	}
+
 	sp->base_address = pci_ioremap_bar(pdev, 0);
 	if (!sp->base_address) {
 		dev_err(sp->dev, "Failed to ioremap pci memory\n");
-- 
2.34.1

