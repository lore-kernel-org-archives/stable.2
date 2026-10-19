Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F5AF488231;
	Mon, 19 Oct 2026 06:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792392710; cv=none; b=tPTF3Ib92TfwxxsbY+haHc/7LDTTMHa0OCQVmsFzcSgdN2JtwC2XoSE45LMyxm1u3osmOlkBkvGMu+UCQhCcNC8LVr30BxEmwF2X18DxyrGfaPDGgXHnkWfrYeWnpFDLwASgmTVtoFo9GWqxcCOVLsUNuO9ueqHpSpV1wiVAhH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792392710; c=relaxed/simple;
	bh=G58MKv4/AnMNW0AVvLb+wuNT9iB/lRdfy7QM1KBmz1Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aIHntH98QhdzNLvxak0narym1YWBOqfLw+2rR06Aqx1xRok5BrcVdiVp0cSN34yOTCD3RYzm/CWCA1flHfKjD84GWBKh6P5Ew/kLLNXlLZBPp7KCKfmttdo2QEYC8bfulq/lydVsRJNCTuBOvvH2ShjoNLV0SlFEMEiH0Ppq1ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RX7B9rQo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RX7B9rQo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D5581F000C4;
	Mon, 19 Oct 2026 06:51:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792392706;
	bh=k7excfwmi7i9h9fFvl0AyYpiwZEOtSL+UXmcBaJ2EE8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RX7B9rQortpyGcem6MmOyhSoL1gz8F5NFm3uE6Kj//6MszPt7mclaz0pHuU5Znqod
	 fNfGq/cQtxtHEsQ39KVhp9A6Jq1QLTnFGrJ/KXHARZQSckHD47t7ucwj98iNvOReHH
	 vHiiug/l8cZgXI0RaKZaTH9LnYZFLIE3tnqzuAYzSckBwjHuSBdTMqj2P+TSIjFr28
	 KdwyeSCvg4WI0Dn30h589ZkUBtn4SPv1N9hJcsa81uWhcmDw18rRtAMWE4O4v9wTAM
	 qfbW0A4CBj466ManuW55N0ILlGmo649XRB3fCJ2W01qXCOnU9HJcBddsJ05pzHGbJP
	 ZB9A1FRLA66lQ==
From: Claudiu Beznea <claudiu.beznea@kernel.org>
To: lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	robh@kernel.org,
	bhelgaas@google.com,
	p.zabel@pengutronix.de,
	geert+renesas@glider.be,
	magnus.damm@gmail.com
Cc: claudiu.beznea@tuxon.dev,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	stable@vger.kernel.org
Subject: [PATCH v7 06/14] PCI: rzg3s-host: Drop read-modify-write approach for the R/W1C registers
Date: Mon, 19 Oct 2026 09:50:17 +0300
Message-ID: <20261019065025.2146539-7-claudiu.beznea@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261019065025.2146539-1-claudiu.beznea@kernel.org>
References: <20261019065025.2146539-1-claudiu.beznea@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

The AXI registers PCI_PINTRCVIS and PCI_PINTRCVIS_MSI are R/W1C. According
to the RZ/G3S HW manual, Rev. 1.30, R/W1C means "it can be cleared to 0b by
writing 1b. Writing 0b does not change anything."

Drop the read-modify-write approach and make use of this hardware
capability. This avoids clearing unwanted interrupts.

Fixes: 7ef502fb35b2 ("PCI: Add Renesas RZ/G3S host controller driver")
Cc: stable@vger.kernel.org
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v7:
- none, this patch is new

 drivers/pci/controller/pcie-rzg3s-host.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/controller/pcie-rzg3s-host.c b/drivers/pci/controller/pcie-rzg3s-host.c
index 94345d6f0bee..b0a150262959 100644
--- a/drivers/pci/controller/pcie-rzg3s-host.c
+++ b/drivers/pci/controller/pcie-rzg3s-host.c
@@ -82,6 +82,7 @@
 #define RZG3S_PCI_MSGRCVIE			0x120
 #define RZG3S_PCI_MSGRCVIE_MSG_RCV		BIT(24)
 
+/* Register is R/W1C, it doesn't require locking. */
 #define RZG3S_PCI_MSGRCVIS			0x124
 #define RZG3S_PCI_MSGRCVIS_MRI			BIT(24)
 
@@ -591,11 +592,10 @@ static irqreturn_t rzg3s_pcie_msi_irq(int irq, void *data)
 		return IRQ_NONE;
 
 	/* Clear the MSI */
-	rzg3s_pcie_update_bits(host->axi, RZG3S_PCI_PINTRCVIS,
-			       RZG3S_PCI_PINTRCVIS_MSI,
-			       RZG3S_PCI_PINTRCVIS_MSI);
-	rzg3s_pcie_update_bits(host->axi, RZG3S_PCI_MSGRCVIS,
-			       RZG3S_PCI_MSGRCVIS_MRI, RZG3S_PCI_MSGRCVIS_MRI);
+	writel_relaxed(RZG3S_PCI_PINTRCVIS_MSI,
+		       host->axi + RZG3S_PCI_PINTRCVIS);
+	writel_relaxed(RZG3S_PCI_MSGRCVIS_MRI,
+		       host->axi + RZG3S_PCI_MSGRCVIS);
 
 	for (u8 reg_id = 0; reg_id < regs; reg_id++) {
 		status = readl_relaxed(host->axi + RZG3S_PCI_MSIRS(reg_id));
@@ -958,9 +958,8 @@ static void rzg3s_pcie_intx_irq_ack(struct irq_data *d)
 {
 	struct rzg3s_pcie_host *host = irq_data_get_irq_chip_data(d);
 
-	rzg3s_pcie_update_bits(host->axi, RZG3S_PCI_PINTRCVIS,
-			       RZG3S_PCI_PINTRCVIS_INTX(d->hwirq),
-			       RZG3S_PCI_PINTRCVIS_INTX(d->hwirq));
+	writel_relaxed(RZG3S_PCI_PINTRCVIS_INTX(d->hwirq),
+		       host->axi + RZG3S_PCI_PINTRCVIS);
 }
 
 static void rzg3s_pcie_intx_irq_mask(struct irq_data *d)
-- 
2.43.0

