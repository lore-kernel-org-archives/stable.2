Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10EC047DD6B
	for <stable@vger.kernel.org>; Tue, 14 Jul 2026 14:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784037969; cv=none; b=SP+do+hdBEu6DfleWULPnikjWEsqOPh3O5nRUZfbYWvteEDIG+lJ466XVetKpjeG2vz+DmtlBhhByVpuU6oAN+oTm/eQtuLvmg08zII0I3H8uLJKWnAxDCBSMv+HoPi2mcf3fNNTHWYdILSu49e7lrazkfpGYvwFm1hZCvfm8fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784037969; c=relaxed/simple;
	bh=ceWdEpcsvCg5vy46gJ7RSjzLYpdCmVf/a8jE3XKdFdk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BicY0fKhp8QKJbuKINgQNhWEBTNMO/mOxsNuF26NIc75cGcBltzIir3EpIbWW81i/WScMc2/5WHcfBx0AwLxEQsirx+y0nDSSPEAEcYZVz2RRMsHyOqPJL0vP8AU4a+mWG7sukekRn8nYq1/NtSwoWQx9p6NOhqr5l/YqDmcJWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K+MAbq1L; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K+MAbq1L"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60B7C1F00A3A;
	Tue, 14 Jul 2026 14:06:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784037968;
	bh=IBtB3Jl3WH6cteuZ0e28j8yYFaYszHcmlU172dsCDOs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=K+MAbq1L4dkzTuWang2oqHXTRbhf9DFKlHfN48NSFP0SSlEMtvhYjoiqomaN1YpJy
	 nMdvnAdNqOnRtMdPnyrWAeVoxY9QVGySHzga8WNs4KHwrp4w0i1Ps1/cGlqw+ooGkt
	 56jDZqhknMVe2p6S0TDPpbOlFnKLsHVn6nxvU0mtVdGl3JDctsL7pCkQ+8E1iilYJg
	 Cq8trMCxtfgnOOMRFgz4dC5TbxJEXkI0vv8CdMt50Nuyv8GsRwX8ONQr5ZZ3e4o0AV
	 tMTuwL93DIcmz++35mo+/7hTVAK5BrF1br1MawJxiE3/x4NNNA1rnhaPsJcEOMDU/g
	 CMz0FGJ/RPh3w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Mahesh Vaidya <mahesh.vaidya@altera.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	"Subhransu S. Prusty" <subhransu.sekhar.prusty@altera.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] PCI: altera: Fix resource leaks on probe failure
Date: Tue, 14 Jul 2026 10:06:05 -0400
Message-ID: <20260714140605.2729466-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026071301-yummy-panhandle-afe6@gregkh>
References: <2026071301-yummy-panhandle-afe6@gregkh>
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
index 650b2dd81c4822..177a8ebd1d1e1d 100644
--- a/drivers/pci/controller/pcie-altera.c
+++ b/drivers/pci/controller/pcie-altera.c
@@ -679,8 +679,18 @@ static int altera_pcie_init_irq_domain(struct altera_pcie *pcie)
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
@@ -706,7 +716,6 @@ static int altera_pcie_parse_dt(struct altera_pcie *pcie)
 	if (pcie->irq < 0)
 		return pcie->irq;
 
-	irq_set_chained_handler_and_data(pcie->irq, altera_pcie_isr, pcie);
 	return 0;
 }
 
@@ -791,6 +800,12 @@ static int altera_pcie_probe(struct platform_device *pdev)
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
@@ -801,7 +816,16 @@ static int altera_pcie_probe(struct platform_device *pdev)
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

