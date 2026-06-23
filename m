Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CB9430D3F6;
	Tue, 23 Jun 2026 12:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782218619; cv=none; b=amq2EX2qhuHuqxxGe9Bm/Ugoagv+hSjhyOjnk/zdVYcwYHHXwRtRm6eNwz0yHucXc/0g6ngpXAWfIaYrKOW9fWBAbU5MvYdfEwfw1KYKmBGOEhVhkWKa5kS+q0CTB1ZvlCXyPFSH4oCisSNdcSr//JaUW0XJwrlD+RDVMe92ZoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782218619; c=relaxed/simple;
	bh=cy5PSMbwkZUUCfwn3RBKBuXpV1QKi/M9lW/uZuxSS2s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tag5wD4fw10ZnnmJWzLRYrsChflG/34cc26hlTBPj9cvY2ZYWgoJP0R8rQ/dr88UH13ZrNA+HgsMfCvIlsoO8zHLe/PJkseLY+Syu2VsNQc3AV6gt82x4tfFxSdRwaQqVI+ZLbPuRA+FyggcayFWd1G67gfIQQb6mf4lDmLYVtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=g4u3TMJb; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="g4u3TMJb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=zx
	EG4DTYxfaZtffQnovM0yyOfi2I4eNe++9QLh9Kk5U=; b=g4u3TMJb5ezuAssG7D
	SRp/cPzMepndd3Gy4SAA59R+CrBQiyzNqzpW+x6JvY+Hdm41n+Y8lsGu0rh68lLO
	6F6tTkO6ISIhIzeowv5bxepV1BE83l/ga6ZBUp3uJm+HmKrJuk4knXSqlpC8K9tU
	nT+r4VfVt7tbUTbp63UoKUY2Q=
Received: from 163.com (unknown [])
	by gzsmtp5 (Coremail) with SMTP id QCgvCgDHCxxZfzpqYyrLDg--.21141S3;
	Tue, 23 Jun 2026 20:43:12 +0800 (CST)
From: w15303746062@163.com
To: arnd@arndb.de,
	gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	kees@kernel.org,
	stable@vger.kernel.org,
	Mingyu Wang <25181214217@stu.xidian.edu.cn>
Subject: [PATCH v3 1/2] misc: ibmasm: Fix static out-of-bounds MMIO access during probe
Date: Tue, 23 Jun 2026 20:43:03 +0800
Message-Id: <20260623124304.371163-2-w15303746062@163.com>
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
X-CM-TRANSID:QCgvCgDHCxxZfzpqYyrLDg--.21141S3
X-Coremail-Antispam: 1Uf129KBjvJXoWxAFyfXw1rZr13ur1xWw4xXrb_yoW5AFWkpF
	Z7W3yFkry5XF4q9w47J348uFyrGa4xKrWjk3y7Aa4fZFyYyFy7Zr1jka47WryxJ3WkKF4j
	yryUJry3Wa1DAaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j8GYLUUUUU=
X-CM-SenderInfo: jzrvjiatxuliiws6il2tof0z/xtbC5AAhBWo6f2CB5AAA3q

From: Mingyu Wang <25181214217@stu.xidian.edu.cn>

The ibmasm driver maps PCI BAR 0 without verifying if the hardware-provided
resource length is sufficient to cover statically accessed registers.

When evaluating the driver against emulated hardware or during virtual
device fuzzing, a malformed device may expose a significantly undersized
BAR 0. This leads to an out-of-bounds (OOB) access when reading the
INTR_CONTROL_REGISTER (offset 0x13A4) during probe. A page fault here
while holding the idempotent_init_module() lock causes a cascading global
soft lockup.

Fix this by storing the mapped size in 'struct service_processor' and
ensuring the BAR is at least large enough to cover the highest statically
accessed hardware register before calling pci_ioremap_bar().

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
index 25f1ed07c3c5..c2d2e96ec4e9 100644
--- a/drivers/misc/ibmasm/lowlevel.h
+++ b/drivers/misc/ibmasm/lowlevel.h
@@ -33,6 +33,9 @@
 #define INTR_STATUS_REGISTER   0x13A0
 #define INTR_CONTROL_REGISTER  0x13A4
 
+/* Highest statically accessed register offset */
+#define IBMASM_MAX_REG_OFFSET	INTR_CONTROL_REGISTER
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

