Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.71
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793514064;
	b=y2tK4q9fKRhTLj+j1w8rWK+nScCKvHeckZaHVO9tbsc54TXB6U8I+FYFQi8ycvrymwHo
	 7c4YLysejMJ5QRp7w1yRp6XoHCl3BIEVqZCZ83Az1BJiSszZ7hBCx90DuCZv+nz3hR7UC
	 kxG4a64rBh4Z+8LC9F2SmPd7qKf6rfPSYAkM77iQXq9csncmSNHxcz3QckiTzmii2dSkL
	 WtS6tS8ivEoa4qOgKpTZzcnwmEb8wRkJ03DSDfeA/rXhSEgmO0Ya91qePfWRKLkn05kLI
	 VDuXCQLlqZ6zxI78a3U12NzjL1gwLFWnRUrX5AGUuF04VlPm4Mg6k971IiloKFRlNlg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793514064;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:Mime-Version:
	 X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=yNCcoeaVZu8l86yYhX5AKYZ61AL1GukvPzV1U2a1bGA=;
	b=3wzAcn1f7bllqhyk/CCvZsheToYiycKVyP+4L/1WGDhjfvziQtAbOs8t/YSfO95WPrL5
	 Flu5TboR/6FTEMj5c92c5nWFQnsJhmWqB/ygapbn8L6gTztG9t/8k3oEk8c4WkotJKJK0
	 nYsBjy8fylHApKWUDH4mXFHy+GV8aLT0PyaPXPjz7aCZIfn0fU52R4P7D9V3ElJdZ58XZ
	 gmGWxFKHV/orpMcMRw+TNo8k9MSyM6oYnRhluuBgqd+52Px1/O9784w7mwR6JfiIMMuh6
	 ItrGm3lyGZkTFoRLY4/a1t91A/7onow29FN0q556OJ4RpResxUNa7fsYFXa/8FvhLKQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=mazfvG1D;
	arc=none smtp.remote-ip=74.125.82.71
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32606606A325
	for <stable@vger.kernel.org>; Sun,  1 Nov 2026 06:21:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 32606606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=mazfvG1D
Received: by mail-dl1-f71.google.com with SMTP id a92af1059eb24-189d17eca17so1533077c88.1
        for <stable@vger.kernel.org>; Sat, 31 Oct 2026 23:21:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793514063; x=1794118863; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=yNCcoeaVZu8l86yYhX5AKYZ61AL1GukvPzV1U2a1bGA=;
        b=mazfvG1DbvMQQjL3xskaNj7gXtORkR1b46M1XyNfYKPWGOLzN0/oTQLH7J2kbieYA0
         uMUJamU7SW7KweP3aLWdVsIO9idHieYDYqP5uPuHYgf9k7VghsX1nCmSqxtCc5O/69Yy
         nRSPpwUjPYQD2U4hHSp1sMkWn7T8UXVLkvlsl5H3H9uV8+zWxf8xETDnzjdClZv7O7Xi
         a40zQaFG702QiiNcZ1+RtZJbpzasht2QMSb5bkJSMCEiEjDn7QU+5Kmu28Z8B8OdYFI8
         kj3s36snSN1muKp0ixn9uFzFEiyT1K+Fw6h0XT+uGSxfrKvnafUY2yeqY7K9hbyn212g
         NIWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793514063; x=1794118863;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yNCcoeaVZu8l86yYhX5AKYZ61AL1GukvPzV1U2a1bGA=;
        b=sqIg4QwBV6KXKNOcHbHyq0hqD+gByusPTlYhINSHiGrjdf+NbM3URlLC9bg9YRfubj
         edgsA0p1g/HuNurwHQx6K37AxExYnuXtZ54pootHPrBn9zY8pkn7Qu2dY2ZOxS4WFrMn
         IbmIbRVmzrqscKqk9zqIRylI/UIExhw+XD3HU6LbXs3pxxiQiLnWd7sZbjNyl+kB5/7t
         XmZ7tJH1CkDOyle4mgzAViQm35zu6sUXxDZdrVczhcwXofrJxoG5yi+DMY03Ysoqhim2
         8Mwrmc7WKu4mc5NC48tLChTRX/DmrKTGugyrnYc6P7XswcUOIJPHTCTSEL04ows/dmYo
         i6ug==
X-Forwarded-Encrypted: i=1; AKwUvBxt+ztHlO/v7rdA5QOHdlP3Ms7LBvPnU+g55koBbANTxPuJ8i2Qm8302iKU82NVgUvTlV9xA/k=@vger.kernel.org
X-Gm-Message-State: AFq9FYJf5U41eeMbl9ImAmek8FjzV23CuOcdlXmpfBwlFB6MuFYT+PgC
	NitG//77gASlgplItgmqNL4nRHwqoOa2eYCh8KFIFRGITg1fe1e1x+zUFR7owYVLkfIuHrU3jty
	818wByaHpSVJpEAJLdjU5XcypcQ==
X-Received: from dleb6-n1.prod.google.com ([2002:a05:701b:4246:10b0:1a8:bca:6c0f])
 (user=almasrymina job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:701b:418d:20b0:1af:16c4:d06b with SMTP id a92af1059eb24-1af16c4d07emr4745927c88.10.1793514062994;
 Sat, 31 Oct 2026 23:21:02 -0700 (PDT)
Date: Sun,  1 Nov 2026 06:21:02 +0000
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.385.gac671c819a-goog
Message-ID: <20261101062102.1000477-1-almasrymina@google.com>
Subject: [PATCH v1] iommu/amd: Prevent spurious IRQ disable on high-rate GALog MSIs
From: Mina Almasry <almasrymina@google.com>
To: Joerg Roedel <jroedel@suse.de>, Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>, 
	Vasant Hegde <vasant.hegde@amd.com>, Jerry Snitselaar <jsnitsel@redhat.com>, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Cc: Mina Almasry <almasrymina@google.com>, "Joerg Roedel (AMD)" <joro@8bytes.org>, 
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On AMD EPYC (Turin) hosts with AVIC enabled, passed-through SR-IOV VFs
in KVM guests log interrupts targeting non-running vCPUs into the IOMMU
Guest Virtual APIC Log (GALog) ring buffer and signal the host via an
edge-triggered IntCapXT MSI (AMD-Vi*-GA).

Both __iommu_setup_intcapxt() and iommu_setup_msi() register their
handlers via request_threaded_irq(..., NULL, thread_fn, IRQF_ONESHOT,
...), using irq_default_primary_handler() (which returns
IRQ_WAKE_THREAD), while intcapxt_irqdomain_alloc() sets handle_edge_irq
which does not mask edge-triggered MSIs during oneshot thread execution.

Previously, amd_iommu_handle_irq() cleared MMIO_STATUS_OFFSET at the top
of the while (status & mask) loop before calling int_handler(iommu)
(iommu_poll_ga_log()). Under overcommitted multi-VM TCP_RR workloads
(1,000 to 10,000 flows across 4-8 VMs with vCPU overcommit), new VF
interrupts for non-running vCPUs arrive while iommu_poll_ga_log() is
draining the ring buffer, causing GALogInt to transition 0 -> 1 and fire
additional hardware edge MSIs while the IRQ thread is still inside
amd_iommu_handle_irq(). Because desc->threads_handled only increments in
irq_thread_fn() after action->thread_fn() returns, note_interrupt()
(kernel/irq/spurious.c) accounts every intermediate edge MSI as IRQ_NONE
(desc->irqs_unhandled++). Once desc->irqs_unhandled exceeds 99,900 out
of 100,000 interrupts, __report_bad_irq() logs "irq <N>: nobody cared"
and permanently disables the IOMMU GALog IRQ, breaking guest VF MSI-X
wakeups.

Fix this in two ways:
1. Drain the log ring buffer via int_handler(iommu) before writing
   status & mask to MMIO_STATUS_OFFSET (clearing only the status bits
   observed set so a concurrent overflow bit is never cleared without
   running overflow_handler()), followed by a post-clear poll pass so
   entries written before the status clear took effect are processed
   without generating redundant edge MSIs or leaving entries stranded.
2. Set IRQ_IS_POLLED on the AMD-Vi MSI and IntCapXT IRQs (clearing it on
   request_threaded_irq() failure paths) so note_interrupt() never
   spuriously disables the dedicated IOMMU event/PPR/GALog IRQ lines
   under sustained high-rate edge MSI bursts.

Discovered in production testing on AMD EPYC (Turin) hosts running
multi-VM KVM guests with passed-through SR-IOV VFs where the host
permanently disabled AMD-Vi-GA under heavy TCP_RR traffic, and verified
on the same AMD EPYC (Turin) hardware across 4-VM and 8-VM SR-IOV VF
test suites.

Fixes: 2379f3485239 ("iommu/amd: Refactor IOMMU interrupt handling logic for Event, PPR, and GA logs")
Cc: stable@vger.kernel.org
Signed-off-by: Mina Almasry <almasrymina@google.com>
---
 drivers/iommu/amd/init.c  |  4 ++++
 drivers/iommu/amd/iommu.c | 13 ++++++++++---
 2 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index de6db5621194..5eea9204f209 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -2404,9 +2404,11 @@ static int iommu_setup_msi(struct amd_iommu *iommu)
 	if (r)
 		return r;
 
+	irq_set_status_flags(iommu->dev->irq, IRQ_IS_POLLED);
 	r = request_threaded_irq(iommu->dev->irq, NULL, amd_iommu_int_thread,
 				 IRQF_ONESHOT, "AMD-Vi", iommu);
 	if (r) {
+		irq_clear_status_flags(iommu->dev->irq, IRQ_IS_POLLED);
 		pci_disable_msi(iommu->dev);
 		return r;
 	}
@@ -2579,9 +2581,11 @@ static int __iommu_setup_intcapxt(struct amd_iommu *iommu, const char *devname,
 		return irq;
 	}
 
+	irq_set_status_flags(irq, IRQ_IS_POLLED);
 	ret = request_threaded_irq(irq, NULL, thread_fn, IRQF_ONESHOT, devname,
 				   iommu);
 	if (ret) {
+		irq_clear_status_flags(irq, IRQ_IS_POLLED);
 		irq_domain_free_irqs(irq, 1);
 		irq_domain_remove(domain);
 		return ret;
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 960e1dc05ec6..ec392da008f9 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -1112,9 +1112,6 @@ static void amd_iommu_handle_irq(void *data, const char *evt_type,
 	u32 mask = int_mask | overflow_mask;
 
 	while (status & mask) {
-		/* Enable interrupt sources again */
-		writel(mask, iommu->mmio_base + MMIO_STATUS_OFFSET);
-
 		if (int_handler) {
 			pr_devel("Processing IOMMU (ivhd%d) %s Log\n",
 				 iommu->index, evt_type);
@@ -1124,6 +1121,16 @@ static void amd_iommu_handle_irq(void *data, const char *evt_type,
 		if ((status & overflow_mask) && overflow_handler)
 			overflow_handler(iommu);
 
+		/*
+		 * Clear only the status bits observed above, then poll once
+		 * more so entries written before the clear took effect are not
+		 * left unprocessed with the interrupt status bit cleared.
+		 */
+		writel(status & mask, iommu->mmio_base + MMIO_STATUS_OFFSET);
+
+		if (int_handler)
+			int_handler(iommu);
+
 		/*
 		 * Hardware bug: ERBT1312
 		 * When re-enabling interrupt (by writing 1

base-commit: 4dd16e31135ea8437a720222df34e8745f385d6d
-- 
2.56.0.385.gac671c819a-goog

