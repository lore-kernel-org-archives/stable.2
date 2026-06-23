Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F464399001;
	Tue, 23 Jun 2026 07:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782198588; cv=none; b=rgVyLEQpOOmvUqRp4/XqnZmXJf938ZH+KzamY4mJiSL0fwMlKq+uZvc7MDqBlJGVoKT+2XW0ozajzn3uyzVZ7iRNcepme9e+sVAAQiVGUNUP0lAo/RLzaYxC2/pYO7Leyvlno0mRn/T53hn5Ta2TD4M7dBaLTv2aeKAygSgltWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782198588; c=relaxed/simple;
	bh=6vQ+XEkrFb3RhTebNAdikI3XbitfavAkgp6z/BNSqmk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=d8RGZjAtQEYCrujJ38IpREuiAp9NdByY+4Sv6XsQWDqBUBLR1doR+A9V1os7GrARY/z72E/SEULgotjRiwp107ZK0JLxUV5z8v7dhgxIoIhUQhLIJR6lNLnZieEplt+whbIKlElsrybAsC++mRDgotJyTIE5SwBazvMZYbCM1t4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=ODrthWF9; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="ODrthWF9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=JN
	/cE86GktJ6gz2daQCtaRTpzAtkNKIRKWpGJ+gjnQU=; b=ODrthWF9prpDLUSuWV
	2Uo6aTmBfPHzf1ZQoaRdu7C7ab7PvD77DkTGQP5cOkrQCL/d5GDO3CXRBQIXjiWI
	eOYO3nUPfj3ZKUXEm92Q6ETNGs6JvJ38JVeJUzYS0tOCma2e7wDR9A7AQ5Lc7teh
	UxEIPzpz+CFK84pGOCohrIQBA=
Received: from 163.com (unknown [])
	by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id _____wD3fwoXMTpqsMFREw--.15887S2;
	Tue, 23 Jun 2026 15:09:14 +0800 (CST)
From: w15303746062@163.com
To: arnd@arndb.de,
	gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	kees@kernel.org,
	Mingyu Wang <25181214217@stu.xidian.edu.cn>,
	stable@vger.kernel.org
Subject: [PATCH] misc: ibmasm: Fix out-of-bounds MMIO access during module load
Date: Tue, 23 Jun 2026 15:09:09 +0800
Message-Id: <20260623070909.362260-1-w15303746062@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3fwoXMTpqsMFREw--.15887S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxXF4DKw1kGr13tFWrXF4kCrg_yoW5Jw43pF
	93WayFkrWUXF4qva17J3s29FyrCay0kFWY939xCa4fZF98ta45AFnFka4UWF4DX3WkKa17
	trWUtry5u3WDAaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jFksDUUUUU=
X-CM-SenderInfo: jzrvjiatxuliiws6il2tof0z/xtbC-xp7X2o6MRrlRgAA3Z

From: Mingyu Wang <25181214217@stu.xidian.edu.cn>

The ibmasm driver maps PCI BAR 0 without verifying if the hardware-provided
resource length is sufficient. The driver statically accesses the
INTR_CONTROL_REGISTER at offset 0x13A4.

When evaluating the driver against emulated hardware or during virtual
device fuzzing, a malformed device may expose a significantly undersized
BAR 0 (e.g., 4KB). In this scenario, the readl() in enable_sp_interrupts()
crosses the mapped page boundary into unmapped memory, causing a page fault
during probe.

Because this crash happens while holding the idempotent_init_module() lock,
it leaves the module loading subsystem in a corrupted state, leading to a
cascading global soft lockup when other threads attempt to load modules:

  BUG: unable to handle page fault for address: ffffc900018433a4
  #PF: supervisor read access in kernel mode
  #PF: error_code(0x0000) - not-present page
  ...
  RIP: 0010:readl arch/x86/include/asm/io.h:59 [inline] [ibmasm]
  RIP: 0010:ibmasm_enable_interrupts drivers/misc/ibmasm/lowlevel.h:54 [inline] [ibmasm]
  RIP: 0010:enable_sp_interrupts drivers/misc/ibmasm/lowlevel.h:65 [inline] [ibmasm]
  ...
  watchdog: BUG: soft lockup - CPU#1 stuck for 266s! [systemd-udevd:182]
  ...
  RIP: 0010:queued_spin_lock_slowpath+0x243/0xbf0 kernel/locking/qspinlock.c:141

Fix this by ensuring the BAR size is at least INTR_CONTROL_REGISTER + 4
before calling pci_ioremap_bar().

Fixes: bdbeed75b288 ("pci: use pci_ioremap_bar() in drivers/misc")
Cc: stable@vger.kernel.org
Signed-off-by: Mingyu Wang <25181214217@stu.xidian.edu.cn>
---
 drivers/misc/ibmasm/module.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/misc/ibmasm/module.c b/drivers/misc/ibmasm/module.c
index 4509c15a76a8..47daef731778 100644
--- a/drivers/misc/ibmasm/module.c
+++ b/drivers/misc/ibmasm/module.c
@@ -93,6 +93,17 @@ static int ibmasm_init_one(struct pci_dev *pdev, const struct pci_device_id *id)
 	}
 
 	sp->irq = pdev->irq;
+
+	/*
+	 * Ensure BAR 0 is large enough to cover the highest statically
+	 * accessed hardware register (INTR_CONTROL_REGISTER at 0x13A4).
+	 */
+	if (pci_resource_len(pdev, 0) < INTR_CONTROL_REGISTER + 4) {
+		dev_err(sp->dev, "PCI BAR0 is too small\n");
+		result = -ENODEV;
+		goto error_ioremap;
+	}
+
 	sp->base_address = pci_ioremap_bar(pdev, 0);
 	if (!sp->base_address) {
 		dev_err(sp->dev, "Failed to ioremap pci memory\n");
-- 
2.34.1

