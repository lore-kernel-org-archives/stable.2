Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A1123C3797;
	Tue, 23 Jun 2026 12:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782218617; cv=none; b=bZDlgKFJi6c/ISf0e4SAbtbyi/NrkgfEuKjkepbJjDQkVGOjqW7cZQn4gKEGHAkb28sOEztVwS29+pn0AvlBxPl9XwuB0QrR3RxYHdN8A+kM5ZzcJzf/2Xx1T1B5JNreYp6G4Y0Hcu4D2khGaii76nStYP2y9K+eGubvQRrEhTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782218617; c=relaxed/simple;
	bh=7SzTjjMMr/9wT0aFHWszU3uEtKwe1hCWbnqf1gGQivA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UjcetyDmT1t3+Pq7G3YiuOZVuGNBQeF3Ae2M6Y8engdtMLdSPEIpDmU+5BX0mrOuezC9W/tYjouBdVYyQyHTm4TBzmRr8FGOUwoOgXV8OwGg6DbeXhB0CEVHyYzWcHriQ+qJCs1aDh6Rw65IvOijZlbGfbIraCUhdo2MlaLv6JY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=YELCGXvP; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="YELCGXvP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=it
	vni2KkcFeeMqpT2q0t5SmOI2O9w3jJ76sBnia2gc8=; b=YELCGXvPdhMmqq4po4
	HmVl72hZNbxV2zTyxyAu/+M2jJpfNyl8y16dEECgE+rltiy+SvLYyYiadXd8lb+F
	lctpoggrOxyK4fvvXGNiOXwc621ZqBL3iU6MmuPjbAgx6uI5YTK0vFLJ5Sr5/mdr
	t4ASxrTiRATxgL/a13xkTJstA=
Received: from 163.com (unknown [])
	by gzsmtp5 (Coremail) with SMTP id QCgvCgDHCxxZfzpqYyrLDg--.21141S4;
	Tue, 23 Jun 2026 20:43:13 +0800 (CST)
From: w15303746062@163.com
To: arnd@arndb.de,
	gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	kees@kernel.org,
	stable@vger.kernel.org,
	Mingyu Wang <25181214217@stu.xidian.edu.cn>
Subject: [PATCH v3 2/2] misc: ibmasm: Fix dynamic out-of-bounds MMIO access 
Date: Tue, 23 Jun 2026 20:43:04 +0800
Message-Id: <20260623124304.371163-3-w15303746062@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260623124304.371163-1-w15303746062@163.com>
References: <20260623124304.371163-1-w15303746062@163.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:QCgvCgDHCxxZfzpqYyrLDg--.21141S4
X-Coremail-Antispam: 1Uf129KBjvJXoWxCrykury7ZFyrKF1rJr1kXwb_yoWrWF4xpF
	1qq3yrAr98ArW2yrZFkr42vFy5u3Z7KF4UCry7Aasav3W5tF15ZFyUAa47XFW8X3Wvg3yU
	Kr1DJrs5u3WjqrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jsnYwUUUUU=
X-CM-SenderInfo: jzrvjiatxuliiws6il2tof0z/xtbDAAEhBWo6f2GoKgAA3p

From: Mingyu Wang <25181214217@stu.xidian.edu.cn>

The ibmasm driver reads dynamic Message Frame Addresses (MFA) from
hardware queues and uses them directly as offsets to dereference I2O
messages via get_i2o_message().

If a malformed or fuzzed device provides a malicious MFA, it can cause
the driver to access memory far beyond the mapped BAR, leading to an
out-of-bounds (OOB) access and potential kernel panic during runtime.

Fix this by validating the offset against the actual mapped size before
dereferencing. If the check fails, release the MFA back to the inbound
queue to prevent deadlocking the hardware mailbox, and discard the message.

Fixes: bdbeed75b288 ("pci: use pci_ioremap_bar() in drivers/misc")
Cc: stable@vger.kernel.org
Signed-off-by: Mingyu Wang <25181214217@stu.xidian.edu.cn>
---
 drivers/misc/ibmasm/lowlevel.c | 19 +++++++++++++++----
 drivers/misc/ibmasm/lowlevel.h | 24 ++++++++++++++++++++++--
 2 files changed, 37 insertions(+), 6 deletions(-)

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
index c2d2e96ec4e9..8c9700fc70bb 100644
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
@@ -118,9 +121,26 @@ static inline void set_mfa_inbound(void __iomem *base_address, u32 mfa)
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
-- 
2.34.1

