Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BD0717993;
	Wed, 24 Jun 2026 03:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782271506; cv=none; b=qvK7rnux/PeuWD3SqFtZCXvTQ3CMj4dcPA6xMnUi0LLktTxZ4681pGCVLPdiM3YlnH3eJfA1moOEj6gDh9ShcqRtEexCZAECXm1izr688Okw3jsHnrJXlwHEOLwpXyKILJm59DCItr0KUPONJ773NUxgM+IWO9gHGu7TrLLWMec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782271506; c=relaxed/simple;
	bh=+lTpUgRCtrf8VF0923gYym4tDfLNTXnd8PEu0FloDW8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=g0zZNc2vT11d89jLEQ6gwQjnWiO+dX4rK2asWRyKQz/zQZeehc52+j8S5vBBPCt8sC1mCPG6c7RDdWyBTLmzqcpfGDauWMs0w3DB5E6F05WmZ8mGQKuTolv27vJqxctMmZCuQrZDTgtR4FMAoGxz4BXdyNtObtQUSGrUVh07Ssw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=EYc4LT+8; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="EYc4LT+8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=mb
	0O3oAJFL3s0sGT0jpjul5zEvGxeCo0r2tdQGi9uv0=; b=EYc4LT+8v0pTKrgjfK
	s/JtRsy26g6b6U0GaYcjzwMpDYLxtm/fMeTT+Z2LEKXN1KQyi7ZPxPnkxoPzXIYM
	/PbXct8SWnxV8qlC1l32t5mdOFjk2Qs7PVW1mX6SHY4wu9OPHJCo6xrXTOywvOrq
	AwRU1SpFxft+70X+De0pbl87A=
Received: from 163.com (unknown [])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wDHzV_rTTtqYc1IEw--.194S3;
	Wed, 24 Jun 2026 11:24:35 +0800 (CST)
From: w15303746062@163.com
To: arnd@arndb.de,
	gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	kees@kernel.org,
	stable@vger.kernel.org,
	Mingyu Wang <25181214217@stu.xidian.edu.cn>
Subject: [PATCH v4 1/2] misc: ibmasm: Fix static out-of-bounds MMIO access during probe
Date: Wed, 24 Jun 2026 11:24:24 +0800
Message-Id: <20260624032425.384325-2-w15303746062@163.com>
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
X-CM-TRANSID:_____wDHzV_rTTtqYc1IEw--.194S3
X-Coremail-Antispam: 1Uf129KBjvJXoWxAFyfXw13Kry8XrWfJF1DWrg_yoW5Zw45pF
	WkW3yYkryUJF4UWanrJ3yUuFyrGas7KrWjk3y7Aa4fZFyYyFy7Zr1jka47WryxJ3WkKF40
	yrWUJry5Wa1DJw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j8GYLUUUUU=
X-CM-SenderInfo: jzrvjiatxuliiws6il2tof0z/xtbDABP43Go7TfMxkgAA37

From: Mingyu Wang <25181214217@stu.xidian.edu.cn>

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
static access (offset 0xAC000) occurs in enable_mouse_interrupts(), which
is invoked via ibmasm_init_remote_input_dev() during the probe phase.

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
index 25f1ed07c3c5..545dfe384117 100644
--- a/drivers/misc/ibmasm/lowlevel.h
+++ b/drivers/misc/ibmasm/lowlevel.h
@@ -33,6 +33,9 @@
 #define INTR_STATUS_REGISTER   0x13A0
 #define INTR_CONTROL_REGISTER  0x13A4
 
+/* Highest static MMIO offset accessed during probe (mouse interrupt control) */
+#define IBMASM_MAX_REG_OFFSET  0xAC000
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

