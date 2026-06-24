Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED0593090C4;
	Wed, 24 Jun 2026 03:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782271507; cv=none; b=e6rM3bA2SLM8K0bH3iUj8oF0iR+2HpwBqVGzIRiz1/qE793dRmdsafEUKRWgLff3Qot2U3qG5W9hNN1JLOzIyzVNjT2UJ0lFO71ecxSceDWzda01xXC3dymOWjb71KQfot3/ngRXuml7F3pNU/SLigCaxLd7pKzG8HNND5RvYQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782271507; c=relaxed/simple;
	bh=HhLrPL3SMWVaTBO6J9c+BgeKcZ9uP33rA/on+I12Zqc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FKwcObCzFXmO8MeMIfJEy/z7rRqlEQyRom30hC8PLnVXN+fq+wosJX8hHuuyf9WlLHpLLY5wlg70qV26E/Im7V8TX52whNr1LgySbQtFzTJ0jyHYxNgqX1qXCbut4pG9h6hRh/fUn4VMpIRwhMLKAzDiIG3w9RWI2sO1LN7u+QM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=C9c7qBjY; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="C9c7qBjY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=5v
	2gfIM4UmNUMz7nzvsw8cP7DlOzDEgikjlLJAGnAWI=; b=C9c7qBjYs14TWfhIzD
	3bdHki3ex0SCBI9MIRNpDgejRAb7qVZmMA7vSTkwvcIlV5NLODOhlNFPYfzHffFZ
	FeeFWEqoL/Ps0Tc0vwiV/mv/0A5r0gW0j8jwe7yzK+ejS0NvtNbocEsEmEfdN6E2
	y9CD4ADjn20wOcqWRJoMLqdzA=
Received: from 163.com (unknown [])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wDHzV_rTTtqYc1IEw--.194S4;
	Wed, 24 Jun 2026 11:24:36 +0800 (CST)
From: w15303746062@163.com
To: arnd@arndb.de,
	gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	kees@kernel.org,
	stable@vger.kernel.org,
	Mingyu Wang <25181214217@stu.xidian.edu.cn>
Subject: [PATCH v4 2/2] misc: ibmasm: Fix dynamic out-of-bounds MMIO access via malicious MFA
Date: Wed, 24 Jun 2026 11:24:25 +0800
Message-Id: <20260624032425.384325-3-w15303746062@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260624032425.384325-1-w15303746062@163.com>
References: <20260624032425.384325-1-w15303746062@163.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDHzV_rTTtqYc1IEw--.194S4
X-Coremail-Antispam: 1Uf129KBjvJXoWxCrykury7ZF43tF1fZF18Zrb_yoWrKrW7pF
	n0v3yrAr9xArWxtrZFkr129Fy5u3Z7GayUGFy3CasavF15tF17Za4UAa47WFW8X3WDW3yY
	gFyDJFs3u3WjqrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jsnYwUUUUU=
X-CM-SenderInfo: jzrvjiatxuliiws6il2tof0z/xtbC4xT53Wo7TfQi7AAA31

From: Mingyu Wang <25181214217@stu.xidian.edu.cn>

The ibmasm driver reads dynamic Message Frame Addresses (MFA) from
hardware queues and uses them directly as offsets to dereference I2O
messages via get_i2o_message().

If a malformed or fuzzed device provides a malicious MFA, it can cause
the driver to access memory far beyond the mapped BAR, leading to an
out-of-bounds (OOB) access and potential kernel panic during runtime.

Fix this by validating the target offset against the actual mapped size
before dereferencing. This validation strictly accounts for both the
i2o_header and the dynamic payload size using safe subtraction to prevent
integer overflow bypasses.

If the bounds check fails, the invalid MFA is released back to the
inbound queue via set_mfa_inbound() to prevent a hardware mailbox deadlock.

Fixes: bdbeed75b288 ("pci: use pci_ioremap_bar() in drivers/misc")
Cc: stable@vger.kernel.org
Signed-off-by: Mingyu Wang <25181214217@stu.xidian.edu.cn>
---
 drivers/misc/ibmasm/lowlevel.c | 30 ++++++++++++++++++++++++++----
 drivers/misc/ibmasm/lowlevel.h | 25 +++++++++++++++++++++++--
 2 files changed, 49 insertions(+), 6 deletions(-)

diff --git a/drivers/misc/ibmasm/lowlevel.c b/drivers/misc/ibmasm/lowlevel.c
index 5313230f36ad..68dd493a7953 100644
--- a/drivers/misc/ibmasm/lowlevel.c
+++ b/drivers/misc/ibmasm/lowlevel.c
@@ -9,7 +9,6 @@
 
 #include "ibmasm.h"
 #include "lowlevel.h"
-#include "i2o.h"
 #include "dot_command.h"
 #include "remote.h"
 
@@ -34,7 +33,13 @@ int ibmasm_send_i2o_message(struct service_processor *sp)
 		return 1;
 
 	header.message_size = outgoing_message_size((unsigned int)command_size);
-	message = get_i2o_message(sp->base_address, mfa);
+	message = get_i2o_message(sp->base_address, sp->mapped_size, mfa,
+				  sizeof(struct i2o_header) + command_size);
+	if (!message) {
+		/* Release the allocated inbound MFA to prevent mailbox deadlock */
+		set_mfa_inbound(sp->base_address, mfa);
+		return 1;
+	}
 
 	memcpy_toio(&message->header, &header, sizeof(struct i2o_header));
 	memcpy_toio(&message->data, command->buffer, command_size);
@@ -63,8 +68,25 @@ irqreturn_t ibmasm_interrupt_handler(int irq, void * dev_id)
 
 	mfa = get_mfa_outbound(base_address);
 	if (valid_mfa(mfa)) {
-		struct i2o_message *msg = get_i2o_message(base_address, mfa);
-		ibmasm_receive_message(sp, &msg->data, incoming_data_size(msg));
+		struct i2o_message *msg = get_i2o_message(base_address,
+							  sp->mapped_size, mfa,
+							  sizeof(struct i2o_header));
+		if (msg) {
+			u32 data_size = incoming_data_size(msg);
+			u32 offset = GET_MFA_ADDR(mfa);
+
+			/*
+			 * Secondary check for dynamic payload size.
+			 * Use subtraction to perfectly prevent integer overflow.
+			 */
+			if (unlikely(data_size > sp->mapped_size - offset -
+						 sizeof(struct i2o_header)))
+				dbg("received mfa payload out of bounds\n");
+			else
+				ibmasm_receive_message(sp, &msg->data, data_size);
+		} else {
+			dbg("received mfa header out of bounds\n");
+		}
 	} else
 		dbg("didn't get a valid MFA\n");
 
diff --git a/drivers/misc/ibmasm/lowlevel.h b/drivers/misc/ibmasm/lowlevel.h
index 545dfe384117..c0f08106c52c 100644
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
@@ -118,9 +121,27 @@ static inline void set_mfa_inbound(void __iomem *base_address, u32 mfa)
 	writel(mfa, base_address + INBOUND_QUEUE_PORT);
 }
 
-static inline struct i2o_message *get_i2o_message(void __iomem *base_address, u32 mfa)
+/**
+ * get_i2o_message - Convert MFA to i2o_message pointer with bounds check
+ * @base_address: BAR 0 virtual address
+ * @mapped_size:  actual size of BAR 0 mapping
+ * @mfa:          Message Frame Address from hardware
+ * @msg_size:     Required size of the message (header + payload)
+ *
+ * Returns NULL if the offset derived from @mfa does not fit within
+ * the mapped BAR (including the i2o_message header).
+ */
+static inline struct i2o_message *get_i2o_message(void __iomem *base_address,
+						  resource_size_t mapped_size,
+						  u32 mfa, size_t msg_size)
 {
-	return (struct i2o_message *)(GET_MFA_ADDR(mfa) + base_address);
+	u32 offset = GET_MFA_ADDR(mfa);
+
+	/* Prevent read/write beyond the ioremap region and avoid integer underflow/overflow */
+	if (unlikely(offset > mapped_size || msg_size > mapped_size - offset))
+		return NULL;
+
+	return (struct i2o_message *)(offset + base_address);
 }
 
 #endif /* __IBMASM_CONDOR_H__ */
-- 
2.34.1

