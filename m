Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793097428;
	b=DcRPOxi/SRiNlu4hX8nADYUtcg12+gen7eaWAOTQwKji15I6FETXTMlQ9Yb0lJkqFZF9
	 GkSeboSsTPZgqChQSZntY8HbGi3SVGijMvvlaG477h8zshWa0vz0e8QWHrtZ6cvYsmr9s
	 fSD8pwA0h/bBjVE0yImB/npEKVPEJolsG4LHAOVj02pCzVQPJGVqC2tVu/QBHVonh24qM
	 /KKCl1DLYTOJRH131+9vfUfA1yWM/yAxjqtXRCixY54M82lmd9nya9+l/Mw3Za9zaeG7b
	 fHiRZKQfZmXrA2fLOYh/s/yZxV7S6X/1DFuEzRNtfTDbr8TzZv9R0Oyc9mBjzkUrrmg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793097428;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=F3U/F5SLemlNyKQRB0guqkLTdXKOKLmVioIhX/xtkwM=;
	b=HLFq/tgGCmC67XrZFrnHD/n2S3/fngOEItYaUt8gVLvttH/UaH/NEqNaWG0jCqapDN1c
	 wQuTHlV5DcvGLfZTM/lHxgIIr+rcWPv12J41qpBEq95WuDFfCvsnhSkCeUK4ZVplReqs3
	 wU08MOQDOukiNP7H8PgaaBtn6LRDJJQPxcPDYN20/gVGS2JhNqhyNHNAC8wAyMX/OAo6F
	 ghKRv+MCaSjRGYPPElLLlAL3Jbkaklln9lgmageSEPcJJvJDVEJZp1md/j3NlvD4IxDOA
	 idPmm/UjpSXapFKhZMf4D916r4Y8nhDp9uZUrAppXGxtETM6BnyPMihA5mISn3pdtdw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=J68CsTFB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3E56606A31D;
	Tue, 27 Oct 2026 10:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=J68CsTFB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0CEA1F01825;
	Tue, 27 Oct 2026 10:37:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793097427;
	bh=F3U/F5SLemlNyKQRB0guqkLTdXKOKLmVioIhX/xtkwM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=J68CsTFBkWyN1agzdN+nrfPes1CZ4milteoIpEp8Bb5V+VXF59oxL23sMUdi5Dnj5
	 bT0YNVKGsS8K37g5lz5vIhRc+qhWM/6L3RhU7nMFzhVCCa0zWjx9njPbagaqNl7GY0
	 w+HQpZpei1BrEGnGc4foNLANY6oHMAVAWOGUYD1kpIml3/THFBMnkpvGvIhvirzdX8
	 e6uJW6CusdKpbP1aNBb17bTgVD1LFuTK/H1ggiuqFZBMZlgxk8l3AkInFaVJp/7hkQ
	 HzN1EIJ8ARytEDmsQJKealQrWwuMxkZvsUuuxJg8gfaYG8QrAwenANzq4HD57iiKFw
	 3KONlh1yBz6Gg==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Thomas Bogendoerfer <tbogendoerfer@suse.de>,
	Stanislaw Skowronek <skylark@unaligned.org>,
	Joshua Kinard <linux@kumba.dev>,
	Brent Casavant <bcasavan@sgi.com>,
	Pat Gefre <pfg@sgi.com>,
	Paul Burton <paulburton@kernel.org>,
	mfd@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH v2 09/27] mfd: ioc3: Request parent IRQ via request_irq() and free before domain removal
Date: Tue, 27 Oct 2026 09:30:38 +0000
Message-ID: <20261027093306.2812695-10-lee@kernel.org>
X-Mailer: git-send-email 2.56.0.307.g5fe7bd680c-goog
In-Reply-To: <20261027093306.2812695-1-lee@kernel.org>
References: <20261027093306.2812695-1-lee@kernel.org>
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

ioc3_irq_domain_setup() registers ioc3_irq_handler() as a chained
interrupt handler using irq_set_chained_handler_and_data(), whilst
ioc3_mfd_remove() and the ioc3_mfd_probe() error path attempt to tear it
down with free_irq(ipd->domain_irq, (void *)ipd) after removing the IRQ
domain.  Because chained handlers bypass the standard irqaction list,
free_irq() warns and fails to detach ioc3_irq_handler(), leaving a
dangling handler referencing the freed IRQ domain and driver private
data.

Register ioc3_irq_handler() with request_irq() to match free_irq(),
dispatch child interrupts via generic_handle_domain_irq_safe(), and free
the IRQ prior to removing the IRQ domain on teardown.

Fixes: 0ce5ebd24d25 ("mfd: ioc3: Add driver for SGI IOC3 chip")
Closes: https://sashiko.dev/#/bug/linux-81f02420-548c-47cf-bd46-0bdcfb5c1738
Cc: stable@vger.kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/mfd/ioc3.c | 32 ++++++++++++++++++++------------
 1 file changed, 20 insertions(+), 12 deletions(-)

diff --git a/drivers/mfd/ioc3.c b/drivers/mfd/ioc3.c
index 5f8ac364b610..885f19154e02 100644
--- a/drivers/mfd/ioc3.c
+++ b/drivers/mfd/ioc3.c
@@ -99,10 +99,9 @@ static const struct irq_domain_ops ioc3_irq_domain_ops = {
 	.unmap = ioc3_irq_domain_unmap,
 };
 
-static void ioc3_irq_handler(struct irq_desc *desc)
+static irqreturn_t ioc3_irq_handler(int irq, void *data)
 {
-	struct irq_domain *domain = irq_desc_get_handler_data(desc);
-	struct ioc3_priv_data *ipd = domain->host_data;
+	struct ioc3_priv_data *ipd = data;
 	struct ioc3 __iomem *regs = ipd->regs;
 	u32 pending, mask;
 
@@ -110,10 +109,12 @@ static void ioc3_irq_handler(struct irq_desc *desc)
 	mask = readl(&regs->sio_ies);
 	pending &= mask; /* Mask off not enabled interrupts */
 
-	if (pending)
-		generic_handle_domain_irq(domain, __ffs(pending));
-	else
-		spurious_interrupt();
+	if (pending) {
+		generic_handle_domain_irq_safe(ipd->domain, __ffs(pending));
+		return IRQ_HANDLED;
+	}
+
+	return IRQ_NONE;
 }
 
 /*
@@ -133,6 +134,7 @@ static int ioc3_irq_domain_setup(struct ioc3_priv_data *ipd, int irq)
 {
 	struct irq_domain *domain;
 	struct fwnode_handle *fn;
+	int ret = -ENOMEM;
 
 	fn = irq_domain_alloc_named_fwnode("IOC3");
 	if (!fn)
@@ -146,13 +148,19 @@ static int ioc3_irq_domain_setup(struct ioc3_priv_data *ipd, int irq)
 
 	ipd->domain = domain;
 
-	irq_set_chained_handler_and_data(irq, ioc3_irq_handler, domain);
+	ret = request_irq(irq, ioc3_irq_handler, IRQF_SHARED, "IOC3", ipd);
+	if (ret) {
+		irq_domain_remove(domain);
+		irq_domain_free_fwnode(fn);
+		ipd->domain = NULL;
+		goto err;
+	}
 	ipd->domain_irq = irq;
 	return 0;
 
 err:
 	dev_err(&ipd->pdev->dev, "irq domain setup failed\n");
-	return -ENOMEM;
+	return ret;
 }
 
 static const struct resource ioc3_uarta_resources[] = {
@@ -615,9 +623,9 @@ static int ioc3_mfd_probe(struct pci_dev *pdev,
 		if (ipd->domain) {
 			struct fwnode_handle *fn = ipd->domain->fwnode;
 
+			free_irq(ipd->domain_irq, (void *)ipd);
 			irq_domain_remove(ipd->domain);
 			irq_domain_free_fwnode(fn);
-			free_irq(ipd->domain_irq, (void *)ipd);
 		}
 		pci_iounmap(pdev, regs);
 		goto out_disable_device;
@@ -645,9 +653,9 @@ static void ioc3_mfd_remove(struct pci_dev *pdev)
 	if (ipd->domain) {
 		struct fwnode_handle *fn = ipd->domain->fwnode;
 
-		irq_domain_remove(ipd->domain);
-		irq_domain_free_fwnode(fn);
 		free_irq(ipd->domain_irq, (void *)ipd);
+		irq_domain_remove(ipd->domain);
+		irq_domain_free_fwnode(fn);
 	}
 	pci_iounmap(pdev, ipd->regs);
 	pci_disable_device(pdev);
-- 
2.56.0.307.g5fe7bd680c-goog

