Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60F482701C4;
	Sat, 18 Jul 2026 02:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.164.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784342020; cv=none; b=fjPTj4f9tiu3zRJFnzqsje4+SuAlPdLHnNH8WgoVXr7d9MAWsBrMrP37APC05GmchT9hg79tc2qtsusgyNbVodhGx4He4N9MYC+gcCEhOCVUioWsUrrj8J8fLYloENncBbWlsb2xGtea9U12jH85fef99c9OuqKS+pghk3L9W5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784342020; c=relaxed/simple;
	bh=hInt62Nn+PLCqWcfO4lcxqgcRt5Rc5d9PfbgrQYEK/U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=a+ff0kBAIyzjczs4WBCgioWnp7ns6X0esJTBqp68CIgRPU0hxrtwT7pRt4riX0WD6+I+ndIXNv+8GSWo4nbhyun0RYdaDtkAPtuX8IFFR0Tb+iEOtnyk0oSIxYDDOSWKa6Sgc5foqJoPPN4XWv4MWvBujTNEuw3LkjwIXN7/hY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn; spf=pass smtp.mailfrom=stu.xidian.edu.cn; dkim=fail (0-bit key) header.d=stu.xidian.edu.cn header.i=@stu.xidian.edu.cn header.b=SO/WtFpa reason="key not found in DNS"; arc=none smtp.client-ip=162.243.164.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stu.xidian.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=stu.xidian.edu.cn header.i=@stu.xidian.edu.cn header.b="SO/WtFpa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=stu.xidian.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-Id:In-Reply-To:References:MIME-Version:
	Content-Transfer-Encoding; bh=UeY/U9/uFCjuu1iGC7h3yNiXOumPdWy+/9
	StxX1NQDc=; b=SO/WtFpaoUr2fPf2nfKBw+jlVzcCGIjcwiqgyLpEivAOgcoWv3
	XzNoj3qP32cDPItIWUobHziskUSWuAr4K9wGQS4kMHk1YfdPhJHvs5xUIglBNNfW
	H3w71DDHT9l6jY6cgjy/r2CHJQSAQmb3yz/dLdcQ4Rkm9SPEL4kNwOySI=
Received: from wmy.localdomain (unknown [115.53.182.64])
	by hzbj-edu-front-3.icoremail.net (Coremail) with SMTP id BbQMCkCW+9T25VpqJQQYAQ--.52490S4;
	Sat, 18 Jul 2026 10:33:32 +0800 (CST)
From: Mingyu Wang <25181214217@stu.xidian.edu.cn>
To: gregkh@linuxfoundation.org,
	arnd@arndb.de
Cc: kees@kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Mingyu Wang <25181214217@stu.xidian.edu.cn>
Subject: [PATCH v6 2/2] misc: ibmasm: Fix dynamic out-of-bounds MMIO access via malicious MFA
Date: Sat, 18 Jul 2026 10:33:24 +0800
Message-Id: <20260718023324.95237-3-25181214217@stu.xidian.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260718023324.95237-1-25181214217@stu.xidian.edu.cn>
References: <20260718023324.95237-1-25181214217@stu.xidian.edu.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:BbQMCkCW+9T25VpqJQQYAQ--.52490S4
X-Coremail-Antispam: 1UD129KBjvJXoWxCrykury7ZF43tF1fZF18Zrb_yoW7JFWUpF
	n0v3yrAr98ArW7trZFkr4q9Fy5u3Z7Ga1UGry3Aa4SvF15tF1UZa4UAa47WFW8X3WkW3yY
	gryDJFs5C3WjqrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmG14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jryl82xGYIkIc2
	x26xkF7I0E14v26r4j6ryUM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1l84
	ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4UJVWxJr1l
	nxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4
	CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvj
	eVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I
	1lc7CjxVAaw2AFwI0_JF0_Jw1lc2xSY4AK67AK6r4UMxAIw28IcxkI7VAKI48JMxC20s02
	6xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_Jr
	I_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v2
	6r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj4
	0_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8
	JrUvcSsGvfC2KfnxnUUI43ZEXa7VUUknY7UUUUU==
X-CM-SenderInfo: qsvrmiqsrujiux6v33wo0lvxldqovvfxof0/1tbiAgUSEWpaRvg-pwAAsS

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
 drivers/misc/ibmasm/lowlevel.c | 41 ++++++++++++++++++++++++++++++----
 drivers/misc/ibmasm/lowlevel.h | 20 +++++++++++++----
 2 files changed, 53 insertions(+), 8 deletions(-)

diff --git a/drivers/misc/ibmasm/lowlevel.c b/drivers/misc/ibmasm/lowlevel.c
index 5313230f36ad..7c211979cdf6 100644
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
@@ -63,8 +80,24 @@ irqreturn_t ibmasm_interrupt_handler(int irq, void * dev_id)
 
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
+			if (unlikely(data_size > sp->mapped_size - offset))
+				dbg("received mfa payload out of bounds\n");
+			else
+				ibmasm_receive_message(sp, &msg->data, data_size);
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

