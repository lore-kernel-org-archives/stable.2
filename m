Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792610729;
	b=SJzeYFSSPWjXAIWQWQVFWNbAiwEkw/WCv5mNVjBa7x2EKit8X8GTeDqI06ba96onXT/V
	 SSRZYNxqyDgWcUyRDbucmPziKSIDJ112KHpYzJeJRhMzZY6tWSKX3wWFGUWD5tRdDumrC
	 9+vit61788lb+j62L94U/liTqHMZgP7ogTyfq6rrhf85174NWLPlEVp+JMPz4npn7f4GW
	 G37WUBtsahHfMK8WA0QtcJ7Q1Cbd2/xlcaNkbxiHx9mKfGrrh2o2H5QRZFVKl9qy4Pw6R
	 jjGMpszO5dMPMdDWoFOfcrfm+ZuZT3dNdqV0hORFX/d5lQsORSkpPvIVBLvtsy/VHGg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792610729;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=KSwASh3+nzVRN/nYBdatxNuVy06KpiX/R3rqyByNzCo=;
	b=fNkRdRpV4lnSACYGpJtSbaduJ8t/Mx7sVlMypk8bz4q7UONx/kw5fUJZMwfz/z9bQp2p
	 22pbiO624PRsWJSMBBhpXLj60eVd8xfz7a1LUV1D8F4UAtXkqA99JoISyvvEi/7Z2YDcU
	 pLqsUnIPwiFLGJ6WgN5oCFf5qjjzXH9VxADlp/4bv7B9ssZzTRdtX0h9ZlqaP3j6GpS2v
	 N6fGkopN4HpWqRaYVfd1i8fiOoyH1qL6SRYxJeTECM6G6puziao9rv3QiLxt+av0nnvLF
	 N/MftRTM+fIuOrz5envQ5a2L2WYWpURA+3JayBVboVxyPne6UkQ+VNylrobFg3rDE/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RktqCIdr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3CA9606A324;
	Wed, 21 Oct 2026 19:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RktqCIdr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 425A81F000C2;
	Wed, 21 Oct 2026 19:25:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792610728;
	bh=KSwASh3+nzVRN/nYBdatxNuVy06KpiX/R3rqyByNzCo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RktqCIdrpmze2315z674QeKhIDp8VvZDoSNiCx0udn02Y5wCh4nCgzJTBREEjl1nh
	 7MKtUYo9GwfA0MHEIYBSI3w+DUyCqiUlLsRflW80RI6G+/OuLfr87Lab2Q5QEmcSzN
	 NHP2bBY0CUW7JikBG5hPwG+yXb4QNWFILO7MGK0ka0yx9/3ZjcRMACWiPoPkyDRqBy
	 wthofs1XhsnEWGQLAVuNdbIQNWWY6OCApCZWT96R70lw3ntq2ILUQ7cGbf7an8vbpL
	 lScj6Y5K5QsqLR5uJowTxOMZbomlFN8XODJCShxpVV1GO78/Y8D63F8c63ttAfUuzv
	 sxfep3DF6Jjhg==
From: Imre Kaloz <kaloz@kernel.org>
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	linux-mips@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 1/4] MIPS: sgi-ip32: Mask MACE PCI interrupts in CRIME only
Date: Wed, 21 Oct 2026 21:24:15 +0200
Message-ID: <20261021192418.7246-2-kaloz@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261021192418.7246-1-kaloz@kernel.org>
References: <20261021192418.7246-1-kaloz@kernel.org>
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

Masking PCI interrupts in the MACE PCI control register overwrites the
error and arbitration enables set at init, and a read-modify-write can
hang CRIME 1.1 machines under DMA load. Enable the slot interrupts once
and mask them in CRIME.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Imre Kaloz <kaloz@kernel.org>
---
 arch/mips/pci/pci-ip32.c      |  7 ++++--
 arch/mips/sgi-ip32/ip32-irq.c | 45 +++--------------------------------
 2 files changed, 8 insertions(+), 44 deletions(-)

diff --git a/arch/mips/pci/pci-ip32.c b/arch/mips/pci/pci-ip32.c
index 7ae89d0c7099..30aca6f76563 100644
--- a/arch/mips/pci/pci-ip32.c
+++ b/arch/mips/pci/pci-ip32.c
@@ -125,10 +125,13 @@ static int __init mace_init(void)
 {
 	PCIBIOS_MIN_IO = 0x1000;
 
-	/* Clear any outstanding errors and enable interrupts */
+	/*
+	 * Clear any outstanding errors and enable interrupts.  PCI interrupts
+	 * are masked in CRIME, so the per-slot enables stay on.
+	 */
 	mace->pci.error_addr = 0;
 	mace->pci.error = 0;
-	mace->pci.control = 0xff008500;
+	mace->pci.control = 0xff0085ff;
 
 	printk("MACE PCI rev %d\n", mace->pci.rev);
 
diff --git a/arch/mips/sgi-ip32/ip32-irq.c b/arch/mips/sgi-ip32/ip32-irq.c
index 29d04468a06b..b9c72af481ed 100644
--- a/arch/mips/sgi-ip32/ip32-irq.c
+++ b/arch/mips/sgi-ip32/ip32-irq.c
@@ -160,38 +160,6 @@ static struct irq_chip crime_edge_interrupt = {
 	.irq_unmask	= crime_enable_irq,
 };
 
-/*
- * This is for MACE PCI interrupts.  We can decrease bus traffic by masking
- * as close to the source as possible.	This also means we can take the
- * next chunk of the CRIME register in one piece.
- */
-
-static unsigned long macepci_mask;
-
-static void enable_macepci_irq(struct irq_data *d)
-{
-	macepci_mask |= MACEPCI_CONTROL_INT(d->irq - MACEPCI_SCSI0_IRQ);
-	mace->pci.control = macepci_mask;
-	crime_mask |= 1 << (d->irq - CRIME_IRQ_BASE);
-	crime->imask = crime_mask;
-}
-
-static void disable_macepci_irq(struct irq_data *d)
-{
-	crime_mask &= ~(1 << (d->irq - CRIME_IRQ_BASE));
-	crime->imask = crime_mask;
-	flush_crime_bus();
-	macepci_mask &= ~MACEPCI_CONTROL_INT(d->irq - MACEPCI_SCSI0_IRQ);
-	mace->pci.control = macepci_mask;
-	flush_mace_bus();
-}
-
-static struct irq_chip ip32_macepci_interrupt = {
-	.name = "IP32 MACE PCI",
-	.irq_mask = disable_macepci_irq,
-	.irq_unmask = enable_macepci_irq,
-};
-
 /* This is used for MACE ISA interrupts.  That means bits 4-6 in the
  * CRIME register.
  */
@@ -299,8 +267,8 @@ static struct irq_chip ip32_maceisa_edge_interrupt = {
 	.irq_unmask	= enable_maceisa_irq,
 };
 
-/* This is used for regular non-ISA, non-PCI MACE interrupts.  That means
- * bits 0-3 and 7 in the CRIME register.
+/* This is used for regular non-ISA MACE interrupts.  That means bits 0-3
+ * and 7-15 in the CRIME register.
  */
 
 static void enable_mace_irq(struct irq_data *d)
@@ -436,20 +404,13 @@ void __init arch_init_irq(void)
 	mips_cpu_irq_init();
 	for (irq = CRIME_IRQ_BASE; irq <= IP32_IRQ_MAX; irq++) {
 		switch (irq) {
-		case MACE_VID_IN1_IRQ ... MACE_PCI_BRIDGE_IRQ:
+		case MACE_VID_IN1_IRQ ... MACEPCI_SHARED2_IRQ:
 			irq_set_chip_and_handler_name(irq,
 						      &ip32_mace_interrupt,
 						      handle_level_irq,
 						      "level");
 			break;
 
-		case MACEPCI_SCSI0_IRQ ...  MACEPCI_SHARED2_IRQ:
-			irq_set_chip_and_handler_name(irq,
-						      &ip32_macepci_interrupt,
-						      handle_level_irq,
-						      "level");
-			break;
-
 		case CRIME_CPUERR_IRQ:
 		case CRIME_MEMERR_IRQ:
 			irq_set_chip_and_handler_name(irq,
-- 
2.47.3

