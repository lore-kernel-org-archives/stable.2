Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794663462;
	b=qVeIB14PptkVTo0o+vtvRPV+Z5bQpT5JI/haVGyt62QqW0xjxXIypcvB+JhGKKm+Aqr5
	 XAQpDDxQJBYpv0FU+hEEz63bKs1kgCESHIyJJFPrTWm81p343if2VgFzXDYjhQST2ZLG+
	 Jp2vRZnwQ2GyY4Tp53w/91ZtPKaRlM/vucUAvLEiZg6/zgkEcuZZZKjZfQfsNvrHt7qHQ
	 iaM+nxXdiLpIx7WwrdCk7dQPx3gZPPY0bkPgp5RNnHidLYH3nwAe2Tc0rjQFtDAPMrL6a
	 8QUTHwb4A7sFm+U7zG1KOEVV89Ts5V95VYIAubprdtmdydlT7EeKpgUAkR+YcAHV0Cg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794663462;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=1aisXE/Mnz/GaVHezDHTY2TUxsmFNrmsLepJDfVkiso=;
	b=OjebPHHC0US04+Th8tPceEqMbFhS+YJOndbLkAJ3NMZ0s15TP/N4RAdXCrAZLC+P8x0g
	 WGEMyrz0DwjVuY9JvU+vbzVVShuFW0OVsrSAR3rHnN1QlnufHJg+6xtu7dp9iKvtCFcoV
	 aexle2i/CDWVx6Kzzj4WXJyyjjB051zXoxybSTXRDwFi5u6dzgPIcqKCttb69qN/+YxC4
	 KbNi9EWSZ+N7wSTXNNpYEtsfvhtumYDcvSRHgBQfi+Wo5C+6ppf5YHa6v362xYfD8io5x
	 OZ2ZmtT2Ug2n/I3w9peaUAd1347jcrks9Rro0phRjPMYVX8B8U5jyl8ofGd7bpW/hdQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=linux.com;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.128.44
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF4B0606A32D
	for <stable@vger.kernel.org>; Sat, 14 Nov 2026 13:37:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EF4B0606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4a5177d78c7so23800085e9.2
        for <stable@vger.kernel.org>; Sat, 14 Nov 2026 05:37:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794663460; x=1795268260;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1aisXE/Mnz/GaVHezDHTY2TUxsmFNrmsLepJDfVkiso=;
        b=LQ4XvKsMQo3Dm4z8q3kzgj2MN/xbtMTBJbdKspblxoQZc6IlXlOkK7kZb/oEOHQNO9
         0GlAvLIfuY0jFit+OWP2q+8mbosIFLei/1pjkBmbQpeqrYOT1QZTqqIyV0ujWIUo2ZFG
         6r5OnhYqil7M2WCGWiYyppesjD1HOTh2PcV5l/a54IwaUDTF3/3JQUYNx7Kr8qkGhJ7i
         gN5Z/mZUCCLSn+7ZVoGacCy+BuW6Uc14qTP26Vu0LKnezv6Yfv+JiXsMCS1GFAOdf/nq
         Iz8XFW1FTwdIEtGx1fBBp8Lz/2ZzgbLAmTfMAa8OFgBbg2J41mQRNGbI/ss9+/2zc8tQ
         zj6w==
X-Gm-Message-State: APuU4Z+jlB5QCyKjqcFx0zR9N+nSQy+7C0N+01HrkjZg8ZjSeAPasJbR
	DwrOo6Y0Jyetpmu8Z6wzTucd/+1sDYYsmU+SuvGGjvMlWAKcV5C+FtiK
X-Gm-Gg: AYBFou07JEaqacIajKIX5dMcw+uJHD862VrFews6uj3i5W5UtoBeuYz1mKQbU8vY/F4
	Od/rK+e4P1WwPNQQz/sh8wWGHPIFEWkQL2GAjp53OrHjZOgOQmKjrqPEKElnRYiGZqw1fuDrzLp
	DcdRsSEQVEiTxBXjllECklC+9eND6sp3i2B0lis6TqR1B7s227OqkvE92KTY1rwNFMiArfyIYKx
	3bhRxb1YVGJHlaBqiwPcSrJ1TWqheFo2zyO9TAXB0+yvIT3QPqQghHq+5scXJoiQcUm+rcpk0R6
	7QZs6XxWM56KMuYFcnGb0/fRtAvkSKNhzE3Lu8lyq9Axayr+Pxsqd8xtNCaxZ+StPFiqCFqA5qb
	JGw5yhewGrpkI4us7aAoPLbu8JrwxYM3mi34fGJ6P06cu1C6pA/hYHAo5QxKE7Px8ZJAS1mOVCk
	4QP4EVnjwiP99VnB8AfuAXwUzC5zx/S8PMNetHQWVUUGOWX6jXlKgrStyqgFT6U6fLc7LfKaI1f
	iHHed6q5uIUjN+BkqLVJvWdb4UHpBrYcgvj6tmUPALh1aQgFVn4FPBh4YU1k/qyOH60NKFKy4f7
	4IvUWJRujnjnAeliyr2xuxtDrDHwUmKx6P9VUrk3L+/NoiBKSThUxtZmguouMU8GSjub8aeeClo
	CmCkWFJYwDXqGzS1JDE8AXyaT
X-Received: by 2002:a05:600c:8905:b0:4ba:4395:5755 with SMTP id 5b1f17b1804b1-4bb55a6a5fbmr77311935e9.5.1794663460057;
        Sat, 14 Nov 2026 05:37:40 -0800 (PST)
Received: from threads.localdomain ([84.70.166.92])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb55a68c5asm131315015e9.1.2026.11.14.05.37.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 05:37:39 -0800 (PST)
From: Lucas Tanure <tanure@linux.com>
To: "Joerg Roedel (AMD)" <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	iommu@lists.linux.dev (open list:IOMMU SUBSYSTEM),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/Rockchip SoC support),
	linux-rockchip@lists.infradead.org (open list:ARM/Rockchip SoC support),
	linux-kernel@vger.kernel.org (open list)
Cc: stable@vger.kernel.org,
	Robin Murphy <robin.murphy@arm.com>
Subject: [PATCH] iommu/rockchip: do not walk the page tables of a disabled MMU
Date: Sat, 14 Nov 2026 13:37:37 +0000
Message-ID: <20261114133738.52817-1-tanure@linux.com>
X-Mailer: git-send-email 2.56.1
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A page fault handler running while another CPU detaches the same IOMMU
can read a cleared RK_MMU_DTE_ADDR, turn it into a linear-map pointer
and dereference it, which panics the machine. A dummy or firmware-left
address is as unsafe.

Seen on PX30 at reboot: the display controller still fetched an
unmapped framebuffer, its IOMMU sat in a page fault, ignored the stall
and paging-disable commands, and had RK_MMU_DTE_ADDR cleared during
the handler's second run.

No wait works: the master shares the line, the RK3588 NPU driver
detaches from its interrupt thread, where synchronize_irq() deadlocks,
and synchronize_hardirq() skips a force-threaded handler. A spinlock
orders the walk against the register clear.

6.1 vendor kernel log, rk_pagefault_done is the walk, per CPU:

  CPU 1, init, reboot path:
  [ 1069.789374][    T1] rk_iommu ff460f00.iommu: Enable stall request timed out, retry_count = 0, status: 0x0002cb
  [ 1069.791314][    T1] rk_iommu ff460f00.iommu: Disable paging request timed out, retry_count = 0, status: 0x0002cb
  [ 1069.830197][    T1] Call trace:
  [ 1069.830922][    T1]  iommu_detach_device+0xd0/0xdc
  [ 1069.831483][    T1]  rockchip_drm_dma_detach_device+0x1c/0x34
  [ 1069.832033][    T1]  vop_crtc_atomic_disable+0xb0c/0xc44
  [ 1069.832751][    T1]  drm_atomic_helper_commit_modeset_disables+0x348/0x690
  ...
  [ 1069.836601][    T1]  drm_atomic_helper_shutdown+0xa0/0x158
  [ 1069.837152][    T1]  rockchip_drm_platform_shutdown+0x18/0x2c
  [ 1069.837870][    T1]  platform_shutdown+0x3c/0x54
  [ 1069.838599][    T1]  device_shutdown+0x194/0x260
  [ 1069.839160][    T1]  kernel_restart+0x40/0x128

  CPU 0, page fault handler:
  [ 1069.790364][    C0] rk_iommu ff460f00.iommu: Page fault at 0x00000000ffee0000 of type read
  [ 1069.792129][    C0] rk_iommu ff460f00.iommu: Page fault while iommu not attached to domain?
  [ 1069.792184][    C0] rk_iommu ff460f00.iommu: Page fault at 0x00000000ffee0280 of type read
  [ 1069.794604][    C0] Unable to handle kernel paging request at virtual address ffffff8000000ffc
  [ 1069.805998][    C0] Internal error: Oops: 0000000096000006 [#1] PREEMPT SMP
  [ 1069.809484][    C0] pc : rk_pagefault_done+0x1b4/0x3c8
  [ 1069.810548][    C0] lr : rk_pagefault_done+0x19c/0x3c8
  [ 1069.832390][    C0] Call trace:
  [ 1069.833116][    C0]  rk_pagefault_done+0x1b4/0x3c8
  [ 1069.833844][    C0]  rk_iommu_irq+0x64/0xc8
  [ 1069.834395][    C0]  __handle_irq_event_percpu+0xe8/0x2ac
  [ 1069.834945][    C0]  handle_irq_event+0x40/0xbc
  [ 1069.835675][    C0]  handle_fasteoi_irq+0x118/0x28c
  [ 1069.836404][    C0]  generic_handle_domain_irq+0x44/0x6c
  [ 1069.836954][    C0]  gic_handle_irq+0x60/0xf0
  [ 1069.837505][    C0]  call_on_irq_stack+0x3c/0x5c
  [ 1069.838235][    C0]  do_interrupt_handler+0x4c/0x94
  [ 1069.838963][    C0]  el1_interrupt+0x44/0xa8
  [ 1069.839446][    C0]  el1h_64_irq_handler+0x18/0x2c
  [ 1069.839997][    C0]  el1h_64_irq+0x78/0x7c
  [ 1071.215224][    C0] Kernel panic - not syncing: Oops: Fatal exception in interrupt

Fixes: c68a292152d3 ("iommu/rockchip: rk3288 iommu driver")
Cc: stable@vger.kernel.org
Signed-off-by: Lucas Tanure <tanure@linux.com>
---
 drivers/iommu/rockchip-iommu.c | 28 ++++++++++++++++++++++------
 1 file changed, 22 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/rockchip-iommu.c b/drivers/iommu/rockchip-iommu.c
index 1fa3110b142a..0f40d9678344 100644
--- a/drivers/iommu/rockchip-iommu.c
+++ b/drivers/iommu/rockchip-iommu.c
@@ -115,6 +115,7 @@ struct rk_iommu {
 	struct iommu_device iommu;
 	struct list_head node; /* entry in rk_iommu_domain.iommus */
 	struct iommu_domain *domain; /* domain to which iommu is attached */
+	spinlock_t lock;
 	const struct rk_iommu_ops *rk_ops;
 };
 
@@ -543,7 +544,8 @@ static int rk_iommu_force_reset(struct rk_iommu *iommu)
 	return 0;
 }
 
-static void log_iova(struct rk_iommu *iommu, int index, dma_addr_t iova)
+static void log_iova(struct rk_iommu *iommu, struct iommu_domain *domain,
+		     int index, dma_addr_t iova)
 {
 	void __iomem *base = iommu->bases[index];
 	u32 dte_index, pte_index, page_offset;
@@ -563,6 +565,12 @@ static void log_iova(struct rk_iommu *iommu, int index, dma_addr_t iova)
 
 	mmu_dte_addr = rk_iommu_read(base, RK_MMU_DTE_ADDR);
 	mmu_dte_addr_phys = iommu->rk_ops->pt_address(mmu_dte_addr);
+	if (domain == &rk_identity_domain ||
+	    mmu_dte_addr_phys != to_rk_domain(domain)->dt_dma) {
+		dev_err(iommu->dev, "iova = %pad: page directory %#x is not the attached domain's, not walked\n",
+			&iova, mmu_dte_addr);
+		return;
+	}
 
 	dte_addr_phys = mmu_dte_addr_phys + (4 * dte_index);
 	dte_addr = phys_to_virt(dte_addr_phys);
@@ -593,6 +601,7 @@ static void log_iova(struct rk_iommu *iommu, int index, dma_addr_t iova)
 static irqreturn_t rk_iommu_irq(int irq, void *dev_id)
 {
 	struct rk_iommu *iommu = dev_id;
+	struct iommu_domain *domain;
 	u32 status;
 	u32 int_status;
 	dma_addr_t iova;
@@ -606,6 +615,8 @@ static irqreturn_t rk_iommu_irq(int irq, void *dev_id)
 	if (WARN_ON(clk_bulk_enable(iommu->num_clocks, iommu->clocks)))
 		goto out;
 
+	spin_lock(&iommu->lock);
+	domain = READ_ONCE(iommu->domain);
 	for (i = 0; i < iommu->num_mmu; i++) {
 		int_status = rk_iommu_read(iommu->bases[i], RK_MMU_INT_STATUS);
 		if (int_status == 0)
@@ -625,15 +636,15 @@ static irqreturn_t rk_iommu_irq(int irq, void *dev_id)
 				&iova,
 				str_write_read(flags == IOMMU_FAULT_WRITE));
 
-			log_iova(iommu, i, iova);
+			log_iova(iommu, domain, i, iova);
 
 			/*
 			 * Report page fault to any installed handlers.
 			 * Ignore the return code, though, since we always zap cache
 			 * and clear the page fault anyway.
 			 */
-			if (iommu->domain != &rk_identity_domain)
-				report_iommu_fault(iommu->domain, iommu->dev, iova,
+			if (domain != &rk_identity_domain)
+				report_iommu_fault(domain, iommu->dev, iova,
 						   flags);
 			else
 				dev_err(iommu->dev, "Page fault while iommu not attached to domain?\n");
@@ -651,6 +662,7 @@ static irqreturn_t rk_iommu_irq(int irq, void *dev_id)
 
 		rk_iommu_write(iommu->bases[i], RK_MMU_INT_CLEAR, int_status);
 	}
+	spin_unlock(&iommu->lock);
 
 	clk_bulk_disable(iommu->num_clocks, iommu->clocks);
 
@@ -921,16 +933,19 @@ static struct rk_iommu *rk_iommu_from_dev(struct device *dev)
 /* Must be called with iommu powered on and attached */
 static void rk_iommu_disable(struct rk_iommu *iommu)
 {
+	unsigned long flags;
 	int i;
 
 	/* Ignore error while disabling, just keep going */
 	WARN_ON(clk_bulk_enable(iommu->num_clocks, iommu->clocks));
 	rk_iommu_enable_stall(iommu);
 	rk_iommu_disable_paging(iommu);
+	spin_lock_irqsave(&iommu->lock, flags);
 	for (i = 0; i < iommu->num_mmu; i++) {
 		rk_iommu_write(iommu->bases[i], RK_MMU_INT_MASK, 0);
 		rk_iommu_write(iommu->bases[i], RK_MMU_DTE_ADDR, 0);
 	}
+	spin_unlock_irqrestore(&iommu->lock, flags);
 	rk_iommu_disable_stall(iommu);
 	clk_bulk_disable(iommu->num_clocks, iommu->clocks);
 }
@@ -997,7 +1012,7 @@ static int rk_iommu_identity_attach(struct iommu_domain *identity_domain,
 	if (iommu->domain == identity_domain)
 		return 0;
 
-	iommu->domain = identity_domain;
+	WRITE_ONCE(iommu->domain, identity_domain);
 
 	spin_lock_irqsave(&rk_domain->iommus_lock, flags);
 	list_del_init(&iommu->node);
@@ -1051,7 +1066,7 @@ static int rk_iommu_attach_device(struct iommu_domain *domain,
 	if (ret)
 		return ret;
 
-	iommu->domain = domain;
+	WRITE_ONCE(iommu->domain, domain);
 
 	spin_lock_irqsave(&rk_domain->iommus_lock, flags);
 	list_add_tail(&iommu->node, &rk_domain->iommus);
@@ -1227,6 +1242,7 @@ static int rk_iommu_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	iommu->domain = &rk_identity_domain;
+	spin_lock_init(&iommu->lock);
 
 	platform_set_drvdata(pdev, iommu);
 	iommu->dev = dev;
-- 
2.56.1

