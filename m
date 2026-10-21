Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792584900;
	b=wvatSrEAmZ3bu2dnJtUgi9a4svyRSLsXzzwmHXmIh0rUmSnpSzqL6H7OdW1HO7972d5H
	 9l7Nf1HBt7qUoYxZsp3dRDNNKYb5G5nqeHpb+QVDCPRPQS6P2o9O8hLs6RjU494MR2aTt
	 bvc97LiNP95O3/X3YARjrk5+kZlKMHUwxPoFUl31EE5TtiiZkoZK77IXHtk4M+lyxdxir
	 ZcGIN6xkQlvwRprHgktEVGoDBY9KYPwiPIFaV2RO9oaVQVEajvm1/l/Ax6bqflIy7NPph
	 flSfgaWjjKulFhprJqDIMf9OY+DKACug585P1DmxDMFV0+AcPA0TTgDUFVr1bIFO48w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792584900;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=VXicDNQw3SiZXpwsk60aBvEiEDzrSWqBfijjFiqUhJI=;
	b=3Zst7IrRKGEPK4m1hLvXu4GAIvUf8hVWnSxrf3/Z6NtVHHSQBkXIpCgWOuZc9QWD83PB
	 lOrzrTC85BBbaimleS4eV/u8hjYod7YfgpY/ClP5Nkus7pESio5lDeMxjNI9CsdQQayA/
	 Ppe0M73cqMHFy6kCFzYRzmW/iBUIbcLzV5ZI31SRjrpeS9tH0axGwIzrEJVImnA06RIF4
	 UvS9fgcaxr4IFkBGthM64MHiaNrF3g5IvibvHyZBYN6M4fuO0iBH8fghs0uKFID2AZOHo
	 j4OuQaKddNXUgkb/wVpeYAlEu/U+3c57kK/ztGv37SqRGA1apzS4y6pLYwf2NxbGvUQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HPPWNtIP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 014F660A3809;
	Wed, 21 Oct 2026 12:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HPPWNtIP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3C211F000C5;
	Wed, 21 Oct 2026 12:14:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792584899;
	bh=VXicDNQw3SiZXpwsk60aBvEiEDzrSWqBfijjFiqUhJI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HPPWNtIPPZ2F6xltoq0oBtGVkWfJ4TsS7EGriNQZJ1CsVU0f6ItnjYup3p1ZphvV+
	 C9ehUDYQJruoljedGRGeSmCDfIFKeFkY1PYPCw3hhY2IIig2DyVtrSOJcSX9ThtqVC
	 2n0iYwReLQ1Ml/a1hvRL+/lW7k5CWdQdsJ4YSGa7g3fVH1RonEYSb0VMr0rCdxfG1L
	 uySo/FBHGPxMzMGtJVkRWHo/bEjjoYT/q75xfCarubu3LGwrGhS+rG680r6CHWDBcO
	 AGnN0R2OK4Qc7oHVS7qISaZ+ZeJD9Re5oFwvxDVqpK7rcOvtP40ERArrbF+/oZq0gW
	 SHEnKZ+9Ifzaw==
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
Subject: [PATCH 10/28] mfd: ioc3: Request parent IRQ via request_irq() and free before domain removal
Date: Wed, 21 Oct 2026 12:09:32 +0000
Message-ID: <20261021121245.3111563-10-lee@kernel.org>
X-Mailer: git-send-email 2.56.0.218.g1ec904b173-goog
In-Reply-To: <20261021121245.3111563-1-lee@kernel.org>
References: <20261021121245.3111563-1-lee@kernel.org>
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
2.56.0.218.g1ec904b173-goog

