Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3473353A73
	for <stable@vger.kernel.org>; Tue, 14 Jul 2026 14:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784040397; cv=none; b=eH+BalvAtXj+e08ITRoXaSrsTRa/GaRG/CROS1N35rEdr9KeMh3JrB0SZvfXHvazpP4iKJ6kEvPE9A5/eATP6+xOp+JlnD/TaXfguJO4xvdFEXW/9UV/MjL1p1mByNgzHLTWIEHk/FS7IX9mvnI/8IEZvRm+dYUwxR+rm2BFINM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784040397; c=relaxed/simple;
	bh=AvzAfCUfi+inm5lUZ04isjN9ObUvEQsePV+z9fotHwE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hk/omzQcRb9GNdEiyZM3H22QfKG4WN5ee+sYpjkHa8RWbrLr+fYkBafRjwwXxuX9gUDl2Kzr7mTBjwU96adlbltQKRhcDx9hdKPPeHJDn4ljmaT6DuEAdEhvdZuKTLh8upacrTqjrNkeP4OTEP73s5VYOPD3HjQKklO/Syp/y9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EocsvtU1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EocsvtU1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 170C01F000E9;
	Tue, 14 Jul 2026 14:46:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784040387;
	bh=cpMG7qnSoXG/L/7A69y3+meZZh36SgxES34IY0TEecU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EocsvtU1USb0OmyxRFW91cDaSkgEYNs7zHm1aFlHSykJoJcr495e2iV7rBwDCPuMZ
	 /YH1CNOj+3BtF6DV0L8xM6mZ+P5LsxzHtHdDCjwUwfmNTR2ZGAFpogGpuNcXEeIEA8
	 T5wVHGSSgGdRGIKmXeMdwf6FleGJw11XhtEBrH7SZJMZTxG7NgP+OxKlXFyZb8gYfK
	 QNQS2ZJSMhSPUkz2jSEi4S2c0KSzmfQTezaOJ9Zl4trAEmN7zv2ltJ3dCSgrloqP6l
	 fudqBAhv8NSoIz2p+DJZJlh2WOS7Py8RVv/eFproIbpndCPecR9ifM2F9cG7JmhTcB
	 DGJyKco03GhEw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Mahesh Vaidya <mahesh.vaidya@altera.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	"Subhransu S. Prusty" <subhransu.sekhar.prusty@altera.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] PCI: altera: Fix resource leaks on probe failure
Date: Tue, 14 Jul 2026 10:46:24 -0400
Message-ID: <20260714144624.2781507-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026071314-linseed-onslaught-176b@gregkh>
References: <2026071314-linseed-onslaught-176b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mahesh Vaidya <mahesh.vaidya@altera.com>

[ Upstream commit 7a94138caeb27f3c49c1dbd93bf422098925bb28 ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/controller/pcie-altera.c | 28 ++++++++++++++++++++++++++--
 1 file changed, 26 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/pcie-altera.c b/drivers/pci/controller/pcie-altera.c
index a9536dc4bf96bc..af6bab5cdc297f 100644
--- a/drivers/pci/controller/pcie-altera.c
+++ b/drivers/pci/controller/pcie-altera.c
@@ -680,8 +680,18 @@ static int altera_pcie_init_irq_domain(struct altera_pcie *pcie)
 	return 0;
 }
 
+static void altera_pcie_disable_irq(struct altera_pcie *pcie)
+{
+	if (pcie->pcie_data->version == ALTERA_PCIE_V1 ||
+	    pcie->pcie_data->version == ALTERA_PCIE_V2) {
+		/* Disable all P2A interrupts */
+		cra_writel(pcie, 0, P2A_INT_ENABLE);
+	}
+}
+
 static void altera_pcie_irq_teardown(struct altera_pcie *pcie)
 {
+	altera_pcie_disable_irq(pcie);
 	irq_set_chained_handler_and_data(pcie->irq, NULL, NULL);
 	irq_domain_remove(pcie->irq_domain);
 	irq_dispose_mapping(pcie->irq);
@@ -707,7 +717,6 @@ static int altera_pcie_parse_dt(struct altera_pcie *pcie)
 	if (pcie->irq < 0)
 		return pcie->irq;
 
-	irq_set_chained_handler_and_data(pcie->irq, altera_pcie_isr, pcie);
 	return 0;
 }
 
@@ -792,6 +801,12 @@ static int altera_pcie_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	/*
+	 * The chained handler uses pcie->irq_domain, so set it only after the
+	 * INTx domain has been created.
+	 */
+	irq_set_chained_handler_and_data(pcie->irq, altera_pcie_isr, pcie);
+
 	/* clear all interrupts */
 	cra_writel(pcie, P2A_INT_STS_ALL, P2A_INT_STATUS);
 	/* enable all interrupts */
@@ -802,7 +817,16 @@ static int altera_pcie_probe(struct platform_device *pdev)
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
-- 
2.53.0

