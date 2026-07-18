Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BBA8282F3B;
	Sat, 18 Jul 2026 03:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.164.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784345846; cv=none; b=BblgZF1pdOzAEg3jgTwnQsCdUhzogMsbYbVzG0a7GwRMgYQZvCBRyIdBkJoJHwME8vTsYPQhk3WorO1WtOCyN2lji19DPBpSh5QwUtqAFkCSB0blsGkH5Vnu5+NvNsowi1kJUsjfLYbT8eqXw4TSegLaHg42abstxjWC8H48hcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784345846; c=relaxed/simple;
	bh=5q7B43fyajE4DGGa49jjyAyKCpQTYwONn3Yajn1jUaw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oEANrFe2f/wIV4yhC44m0yZx8CT53Q6zezf7iw6wttgMzoOZsnwie35wreWbsJiQ+ANvr03wZfov8rJRoKJn+JwUQHY4eiT4aZo0WEC89YCk1QrBoodUhSDrYFUm0Fxtwy9h1vIpshR1Su1xaIgorTqsYrw2DO0LU6TJJfBH8yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn; spf=pass smtp.mailfrom=stu.xidian.edu.cn; dkim=fail (0-bit key) header.d=stu.xidian.edu.cn header.i=@stu.xidian.edu.cn header.b=stcFEtRG reason="key not found in DNS"; arc=none smtp.client-ip=162.243.164.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stu.xidian.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=stu.xidian.edu.cn header.i=@stu.xidian.edu.cn header.b="stcFEtRG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=stu.xidian.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-Id:In-Reply-To:References:MIME-Version:
	Content-Transfer-Encoding; bh=Fm0aPj/P9I0xkLeqWDqqZ6m7wXLQD0IPvN
	QFjbuLnMw=; b=stcFEtRGhqs56MZ48kae+0wtpb5gd0VTnpFpAjg9n923weEx8i
	HT9O6JoKBrMTllGPi7p/uSrsJjh4EvLuqhhNKOkVJoTx9fGQfFMxqRLRrQ6TRHss
	d58yYCztXUjam//wXf5FxIsrfrvjM+QJ13FhyHumrTLRwFbMe1NH6g5y4=
Received: from wmy.localdomain (unknown [115.53.187.56])
	by hzbj-edu-front-3.icoremail.net (Coremail) with SMTP id BbQMCkAmitPk9Fpqy40YAQ--.283S4;
	Sat, 18 Jul 2026 11:37:15 +0800 (CST)
From: Mingyu Wang <25181214217@stu.xidian.edu.cn>
To: gregkh@linuxfoundation.org,
	arnd@arndb.de
Cc: kees@kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Mingyu Wang <25181214217@stu.xidian.edu.cn>
Subject: [PATCH v7 2/2] misc: ibmasm: Fix dynamic out-of-bounds MMIO access via malicious MFA
Date: Sat, 18 Jul 2026 11:37:06 +0800
Message-Id: <20260718033706.95929-3-25181214217@stu.xidian.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260718033706.95929-1-25181214217@stu.xidian.edu.cn>
References: <20260718033706.95929-1-25181214217@stu.xidian.edu.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:BbQMCkAmitPk9Fpqy40YAQ--.283S4
X-Coremail-Antispam: 1UD129KBjvJXoW3Jr1fKr4kKFykCFWrZF15XFb_yoW7AF4DpF
	n0vayrAr98ArW2qrZFkr4IvFy5u3Z7GF1UGry3Aa4avF15tF1UZa4UCay7uFW8X3Wvg3yY
	gr1DJr4rC3WjqrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmj14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jryl82xGYIkIc2
	x26xkF7I0E14v26r4j6ryUM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1l84
	ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AKxVW8Jr0_Cr1U
	M2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64
	kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm
	72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYx
	C7MxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j
	6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7
	AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE
	2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcV
	C2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2Kfnx
	nUUI43ZEXa7VUUByIUUUUUU==
X-CM-SenderInfo: qsvrmiqsrujiux6v33wo0lvxldqovvfxof0/1tbiAgUSEWpaRvhGDAAAsA

The ibmasm driver reads dynamic Message Frame Addresses (MFA) from
hardware queues and uses them directly as offsets to dereference I2O
messages via get_i2o_message().

If a malformed or fuzzed device provides a malicious MFA, it can cause
the driver to access memory far beyond the mapped BAR, leading to an
out-of-bounds (OOB) access and potential kernel panic during runtime.

Fix this by validating the target offset against the actual mapped size
before dereferencing. This validation strictly accounts for both the
i2o_header and the dynamic payload size to prevent integer overflow.

Additionally, this fixes a pre-existing logic bug where the driver passed
the total message size (including the header) to ibmasm_receive_message()
while pointing to the payload buffer, causing a 12-byte OOB read. An
underflow safeguard is also added to ensure the hardware-provided size
is at least as large as the header.

If the bounds check fails, the invalid MFA is released back to the
inbound queue via set_mfa_inbound() to prevent a hardware mailbox deadlock.

Fixes: bdbeed75b288 ("pci: use pci_ioremap_bar() in drivers/misc")
Cc: stable@vger.kernel.org
Signed-off-by: Mingyu Wang <25181214217@stu.xidian.edu.cn>
---
 drivers/misc/ibmasm/lowlevel.c | 45 +++++++++++++++++++++++++++++++---
 drivers/misc/ibmasm/lowlevel.h | 20 ++++++++++++---
 2 files changed, 57 insertions(+), 8 deletions(-)

diff --git a/drivers/misc/ibmasm/lowlevel.c b/drivers/misc/ibmasm/lowlevel.c
index 5313230f36ad..a494172cf5d8 100644
--- a/drivers/misc/ibmasm/lowlevel.c
+++ b/drivers/misc/ibmasm/lowlevel.c
@@ -9,12 +9,23 @@
 
 #include "ibmasm.h"
 #include "lowlevel.h"
-#include "i2o.h"
 #include "dot_command.h"
 #include "remote.h"
 
 static struct i2o_header header = I2O_HEADER_TEMPLATE;
 
+struct i2o_message *get_i2o_message(void __iomem *base_address,
+				    resource_size_t mapped_size,
+				    u32 mfa, size_t msg_size)
+{
+	u32 offset = GET_MFA_ADDR(mfa);
+
+	/* Prevent read/write beyond the ioremap region and avoid integer underflow/overflow */
+	if (unlikely(offset > mapped_size || msg_size > mapped_size - offset))
+		return NULL;
+
+	return (struct i2o_message *)(offset + base_address);
+}
 
 int ibmasm_send_i2o_message(struct service_processor *sp)
 {
@@ -34,7 +45,13 @@ int ibmasm_send_i2o_message(struct service_processor *sp)
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
@@ -63,8 +80,28 @@ irqreturn_t ibmasm_interrupt_handler(int irq, void * dev_id)
 
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
+			 * Secondary check: total message size must not exceed mapped
+			 * space, and must be at least as large as the header itself.
+			 */
+			if (unlikely(data_size < sizeof(struct i2o_header) ||
+				     data_size > sp->mapped_size - offset)) {
+				dbg("received mfa payload out of bounds or invalid size\n");
+			} else {
+				/* Pass only the payload size to prevent +12 byte OOB read */
+				ibmasm_receive_message(sp, &msg->data,
+						       data_size - sizeof(struct i2o_header));
+			}
+		} else {
+			dbg("received mfa header out of bounds\n");
+		}
 	} else
 		dbg("didn't get a valid MFA\n");
 
diff --git a/drivers/misc/ibmasm/lowlevel.h b/drivers/misc/ibmasm/lowlevel.h
index 970d30478c7b..83b20b1d7021 100644
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
@@ -118,9 +121,18 @@ static inline void set_mfa_inbound(void __iomem *base_address, u32 mfa)
 	writel(mfa, base_address + INBOUND_QUEUE_PORT);
 }
 
-static inline struct i2o_message *get_i2o_message(void __iomem *base_address, u32 mfa)
-{
-	return (struct i2o_message *)(GET_MFA_ADDR(mfa) + base_address);
-}
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
+struct i2o_message *get_i2o_message(void __iomem *base_address,
+						  resource_size_t mapped_size,
+						  u32 mfa, size_t msg_size);
 
 #endif /* __IBMASM_CONDOR_H__ */
-- 
2.34.1

