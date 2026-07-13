Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B229428475
	for <stable@vger.kernel.org>; Mon, 13 Jul 2026 13:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783949120; cv=none; b=LUWVGhJVIrzhGqRBN1LwH0gSrmf81XpOzik2/NbOoLrfHY7DJjxYaaRkiUWQo8LxFhDdFRCR3Q/CDEdmFkDcIw6+jP+qBoU2+BfGtT2NCOp4HsB/Z3lk2ik0iZZSBOweuzw8IxMmbzQXP/O0VXmBt29c+4c0i2+4cojrjKM9WHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783949120; c=relaxed/simple;
	bh=rCmNeJ3fKntfJYDAR1kUjXhn7U6wV7/uFEyA7+ArHIU=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=lrtUA5phxkk4CTdkuDrqyOtIxK4aJrFoOnngHmJXMDloMYqso6KaRUyTshWkk43QFBkpaHUZFgJjQBb74OzW/ko69c1pJEIc7jZa6wXWyJb1lTNZTNLNa1y52tM/k+xifX15DioXFVsvlztlBHhjFBUBab6+inQARHhMjunjh9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QBoQymBb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QBoQymBb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CFAD1F000E9;
	Mon, 13 Jul 2026 13:25:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783949119;
	bh=Szs3F1GHF8PwnsDdkYqIKlaNL2tBiqt/GmElz9lesjM=;
	h=Subject:To:Cc:From:Date;
	b=QBoQymBbY41y+8wcj82O1bJb4vUaEQsehpCOADGNHuJw1DgdeaTssVWWW94V6JC8H
	 Tb7CZ/7LrLjSwR8HJGQb368fYd/DMipf+2Wye98OcoS0ASHUZGXFp74oI+z3aNQKrN
	 BGbxMphifwCqG3ooVt+I8kSd6kQLsclOa0MQal68=
Subject: FAILED: patch "[PATCH] PCI: altera: Fix resource leaks on probe failure" failed to apply to 6.12-stable tree
To: mahesh.vaidya@altera.com,mani@kernel.org,subhransu.sekhar.prusty@altera.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 13 Jul 2026 15:16:01 +0200
Message-ID: <2026071301-yummy-panhandle-afe6@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 7a94138caeb27f3c49c1dbd93bf422098925bb28
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026071301-yummy-panhandle-afe6@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 7a94138caeb27f3c49c1dbd93bf422098925bb28 Mon Sep 17 00:00:00 2001
From: Mahesh Vaidya <mahesh.vaidya@altera.com>
Date: Thu, 30 Apr 2026 13:43:30 -0700
Subject: [PATCH] PCI: altera: Fix resource leaks on probe failure

The chained IRQ handler is set during probe, but is only removed during the
driver remove(). If pci_host_probe() fails, the handler and INTx IRQ
domain remain set even though the devm-managed host bridge storage
containing struct altera_pcie will be released, leaving the handler with
a stale data pointer.

Interrupts are also enabled before pci_host_probe() is called. If probe
fails after that point, the controller interrupt source should be disabled
before the chained handler and INTx domain are removed.

So set the chained handler only after the INTx domain has been created.
Disable controller interrupts during IRQ teardown, and tear the IRQ setup
down if pci_host_probe() fails.

Fixes: c63aed7334c2 ("PCI: altera: Use pci_host_probe() to register host")
Signed-off-by: Mahesh Vaidya <mahesh.vaidya@altera.com>
[mani: commit log]
Signed-off-by: Manivannan Sadhasivam <mani@kernel.org>
Reviewed-by: Subhransu S. Prusty <subhransu.sekhar.prusty@altera.com>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20260430204330.3121003-3-mahesh.vaidya@altera.com

diff --git a/drivers/pci/controller/pcie-altera.c b/drivers/pci/controller/pcie-altera.c
index 3d3519b8d88f..76f3823d9613 100644
--- a/drivers/pci/controller/pcie-altera.c
+++ b/drivers/pci/controller/pcie-altera.c
@@ -864,8 +864,23 @@ static int altera_pcie_init_irq_domain(struct altera_pcie *pcie)
 	return 0;
 }
 
+static void altera_pcie_disable_irq(struct altera_pcie *pcie)
+{
+	if (pcie->pcie_data->version == ALTERA_PCIE_V1 ||
+	    pcie->pcie_data->version == ALTERA_PCIE_V2) {
+		/* Disable all P2A interrupts */
+		cra_writel(pcie, 0, P2A_INT_ENABLE);
+	} else if (pcie->pcie_data->version == ALTERA_PCIE_V3) {
+		/* Disable port-level interrupts (CFG_AER, etc.) */
+		writel(0, pcie->hip_base +
+			  pcie->pcie_data->port_conf_offset +
+			  pcie->pcie_data->port_irq_enable_offset);
+	}
+}
+
 static void altera_pcie_irq_teardown(struct altera_pcie *pcie)
 {
+	altera_pcie_disable_irq(pcie);
 	irq_set_chained_handler_and_data(pcie->irq, NULL, NULL);
 	irq_domain_remove(pcie->irq_domain);
 }
@@ -890,7 +905,6 @@ static int altera_pcie_parse_dt(struct altera_pcie *pcie)
 	if (pcie->irq < 0)
 		return pcie->irq;
 
-	irq_set_chained_handler_and_data(pcie->irq, pcie->pcie_data->ops->rp_isr, pcie);
 	return 0;
 }
 
@@ -1019,6 +1033,14 @@ static int altera_pcie_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	/*
+	 * The chained handler uses pcie->irq_domain, so set it only after the
+	 * INTx domain has been created.
+	 */
+	irq_set_chained_handler_and_data(pcie->irq,
+					 pcie->pcie_data->ops->rp_isr,
+					 pcie);
+
 	if (pcie->pcie_data->version == ALTERA_PCIE_V1 ||
 	    pcie->pcie_data->version == ALTERA_PCIE_V2) {
 		/* clear all interrupts */
@@ -1036,7 +1058,16 @@ static int altera_pcie_probe(struct platform_device *pdev)
 	bridge->busnr = pcie->root_bus_nr;
 	bridge->ops = &altera_pcie_ops;
 
-	return pci_host_probe(bridge);
+	ret = pci_host_probe(bridge);
+	if (ret)
+		goto err_teardown_irq;
+
+	return 0;
+
+err_teardown_irq:
+	altera_pcie_irq_teardown(pcie);
+
+	return ret;
 }
 
 static void altera_pcie_remove(struct platform_device *pdev)

