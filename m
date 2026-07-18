Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BB402727FD;
	Sat, 18 Jul 2026 03:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.164.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784345846; cv=none; b=TbLCKCgeK3DlsdXvk7wPxE/H34bmVPZEvSrnbb9mu49WQIohxiMDo95qLOxyGn6V1h7CKDlAX+jXFS/D1p3bgYEajjMIQKnVCkWueWQehGwsuKSOB3YPNxwUjpqIEQByIM4LiypVZb+oEHVDPn5BB4KUfk85baUkAskSbuyg0ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784345846; c=relaxed/simple;
	bh=T48itO9BTAprMr+guQs8A9h6LUkElMQGpmoF+Dltuoo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LJBKLmee9sYxWpRmTfav/Ku/bORUeDUcOdOVhgu2y6BqafPTmC4z9eOoffvdOWKdIGPBjeeRw252sVj6GQ8nMTw78vHWl/Il6cnkfypudV9rIwN78H9jRxrIjNhpNTf/h+xXE9XV+PJ2hzDE1dEIIM20r0BLLefPpuFAKuOGKXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn; spf=pass smtp.mailfrom=stu.xidian.edu.cn; dkim=fail (0-bit key) header.d=stu.xidian.edu.cn header.i=@stu.xidian.edu.cn header.b=6lKKSk4t reason="key not found in DNS"; arc=none smtp.client-ip=162.243.164.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stu.xidian.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=stu.xidian.edu.cn header.i=@stu.xidian.edu.cn header.b="6lKKSk4t"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=stu.xidian.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-Id:In-Reply-To:References:MIME-Version:
	Content-Transfer-Encoding; bh=+i0pzYp5ov+CVjL5Zd1h9BUIvraHx8sSVD
	W7eroboWs=; b=6lKKSk4tdYlk9EVy+4DgSCRUeq+1B0qACyYY1aHrBPD3cylxJ7
	XNgVLhlyWYbGAxbns50c/RpwE42q53SNXNvnhORoI2ibqYx3hu0oWMExCMmLTq3W
	FFnxbHdRY/rGSFkjAcW4FQ7GWLFuj+0lasQ+gI3ri5GMheMpqssGECw8o=
Received: from wmy.localdomain (unknown [115.53.187.56])
	by hzbj-edu-front-3.icoremail.net (Coremail) with SMTP id BbQMCkAmitPk9Fpqy40YAQ--.283S3;
	Sat, 18 Jul 2026 11:37:13 +0800 (CST)
From: Mingyu Wang <25181214217@stu.xidian.edu.cn>
To: gregkh@linuxfoundation.org,
	arnd@arndb.de
Cc: kees@kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Mingyu Wang <25181214217@stu.xidian.edu.cn>
Subject: [PATCH v7 1/2] misc: ibmasm: Fix static out-of-bounds MMIO access during probe
Date: Sat, 18 Jul 2026 11:37:05 +0800
Message-Id: <20260718033706.95929-2-25181214217@stu.xidian.edu.cn>
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
X-CM-TRANSID:BbQMCkAmitPk9Fpqy40YAQ--.283S3
X-Coremail-Antispam: 1UD129KBjvJXoWxAFyfXw13Kry8XrWfJF1DWrg_yoW5ZryUpF
	Z7W3yYkrWUXF4vgw47J3yDuFyrGas7KFWj93y3Aa4fZFyYyFy3ZF1jka47WryxJ3WkKa10
	yrWUJry5Wa1DJaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmj14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr4l82xGYIkIc2
	x26xkF7I0E14v26r1I6r4UM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
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
	nUUI43ZEXa7VUjW8BUUUUUU==
X-CM-SenderInfo: qsvrmiqsrujiux6v33wo0lvxldqovvfxof0/1tbiAQUSEWpaR2pGSwAAsX

The ibmasm driver maps PCI BAR 0 without verifying if the hardware-provided
resource length is sufficient to cover statically accessed registers.

When evaluating the driver against emulated hardware or during virtual
device fuzzing, a malformed device may expose a significantly undersized
BAR 0. This leads to an out-of-bounds (OOB) access when reading or writing
to registers such as INTR_CONTROL_REGISTER (offset 0x13A4) or mouse
interrupt controls (offset 0xAC000) during probe. A page fault here
while holding the idempotent_init_module() lock causes a cascading global
soft lockup.

Fix this by storing the mapped size in 'struct service_processor' and
ensuring the BAR is at least large enough to cover the highest statically
accessed hardware register before calling pci_ioremap_bar(). This highest
static access (offset 0xAC1FC) occurs via the display_depth() macro
during ibmasmfs filesystem initialization.

Fixes: bdbeed75b288 ("pci: use pci_ioremap_bar() in drivers/misc")
Cc: stable@vger.kernel.org
Signed-off-by: Mingyu Wang <25181214217@stu.xidian.edu.cn>
---
 drivers/misc/ibmasm/ibmasm.h   |  1 +
 drivers/misc/ibmasm/lowlevel.h |  3 +++
 drivers/misc/ibmasm/module.c   | 13 +++++++++++++
 3 files changed, 17 insertions(+)

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
diff --git a/drivers/misc/ibmasm/lowlevel.h b/drivers/misc/ibmasm/lowlevel.h
index 25f1ed07c3c5..970d30478c7b 100644
--- a/drivers/misc/ibmasm/lowlevel.h
+++ b/drivers/misc/ibmasm/lowlevel.h
@@ -33,6 +33,9 @@
 #define INTR_STATUS_REGISTER   0x13A0
 #define INTR_CONTROL_REGISTER  0x13A4
 
+/* Highest static MMIO offset accessed during probe (display_depth during fs init) */
+#define IBMASM_MAX_REG_OFFSET  0xAC1FC
+
 #define SCOUT_COM_A_BASE         0x0000
 #define SCOUT_COM_B_BASE         0x0100
 #define SCOUT_COM_C_BASE         0x0200
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

