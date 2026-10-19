Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC45247C0FD;
	Mon, 19 Oct 2026 06:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792392700; cv=none; b=AgNM1GCmah7uxGSO3a0XvyZU1jiDFQc+XLPPKZfQKX6n9960zmZ+wvFoEp0rMywd99X/CA7rNXr18lHUndHUQ1p3BdtGC3Lq62WX7ptJADlqjdv+bYyQ+MwF0Mokr3nDF4Z4cGevb0zQgO0JRu23HzQhuYN5cNREPxnPcoNQv78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792392700; c=relaxed/simple;
	bh=E/sqaxZ81jFhMJlJD563vuWAS3uoWWrqdyfcxpaZmSw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GFH3u7w6eI2KLKsEUTu2sHlGq+ivWM8HSet3BgMxzo6LrY8TDdXTCGBARXBkvimHodWzMWCdmzBVFJcTDu/jrlTStcUBWW7XePa+OEH10AOkHJvvfQNDbUKS3ax7OgIOPbEZeWrqS+ztirg344DE5leiw6pJtRE+P6wBnxp2sdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OmYGWiof; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OmYGWiof"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B2D91F000C4;
	Mon, 19 Oct 2026 06:51:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792392699;
	bh=Uowh+AcD/kXI8NgNXZj91Lbsa0sKwDYfl2a7Qf1AGUY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OmYGWiof+zxEEaDdmcSDpn24I3UTeIjR8EFUN0ZAz/YzHFQL/yHZ4pXv2f8hoXFQq
	 oD/M3rpol3FjPRLkogYfxtFi42zWVYSLCO8Y/N1rc8iEYNaobrLoijkfljCnPRF7n6
	 OQZdF5LFOZk7Je/Qf0KrmJVyqnbhUjW2IQaWDTOyTYaSf9RF1zvt+u/OrCT6ci918I
	 /liTOF7hsn2bAQVMqGRnsTggqvLittOkRL0tEJGZoYPzGsbM7gYtA7RQKoVxgbgGMA
	 2gq4vaBb2qhxtGomj6r2WQHO2rYBGb9pjkSzL2SRObtHd9WDiUFAH3by9DqW4gcG++
	 p94buTs5s7b4w==
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
Subject: [PATCH v7 04/14] PCI: rzg3s-host: Create the INTx IRQ domain before setting the chained handlers
Date: Mon, 19 Oct 2026 09:50:15 +0300
Message-ID: <20261019065025.2146539-5-claudiu.beznea@kernel.org>
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

rzg3s_pcie_init_irqdomain() installs the chained INTx handlers before
creating the INTx IRQ domain. irq_set_chained_handler_and_data() also
enables the interrupt, so an INTx interrupt arriving in between is
handled by rzg3s_pcie_intx_irq_handler() while host->intx_domain is
still NULL, leading to a NULL pointer dereference.

Move the IRQ domain creation before the loop that installs the chained
handlers.

Fixes: 7ef502fb35b2 ("PCI: Add Renesas RZ/G3S host controller driver")
Cc: stable@vger.kernel.org
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v7:
- none, this patch is new

 drivers/pci/controller/pcie-rzg3s-host.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/drivers/pci/controller/pcie-rzg3s-host.c b/drivers/pci/controller/pcie-rzg3s-host.c
index bee3e46d025f..cc985020d962 100644
--- a/drivers/pci/controller/pcie-rzg3s-host.c
+++ b/drivers/pci/controller/pcie-rzg3s-host.c
@@ -1024,6 +1024,16 @@ static int rzg3s_pcie_init_irqdomain(struct rzg3s_pcie_host *host)
 	struct platform_device *pdev = to_platform_device(dev);
 	int i, ret;
 
+	host->intx_domain = irq_domain_create_linear(dev_fwnode(dev),
+						     PCI_NUM_INTX,
+						     &rzg3s_pcie_intx_domain_ops,
+						     host);
+	if (!host->intx_domain) {
+		return dev_err_probe(dev, -EINVAL,
+				     "Failed to add irq domain for INTx IRQs\n");
+	}
+	irq_domain_update_bus_token(host->intx_domain, DOMAIN_BUS_WIRED);
+
 	for (i = 0; i < PCI_NUM_INTX; i++) {
 		char irq_name[5] = {0};
 		int irq;
@@ -1045,18 +1055,6 @@ static int rzg3s_pcie_init_irqdomain(struct rzg3s_pcie_host *host)
 						 host);
 	}
 
-	host->intx_domain = irq_domain_create_linear(dev_fwnode(dev),
-						     PCI_NUM_INTX,
-						     &rzg3s_pcie_intx_domain_ops,
-						     host);
-	if (!host->intx_domain) {
-		ret = -EINVAL;
-		dev_err_probe(dev, ret,
-			      "Failed to add irq domain for INTx IRQs\n");
-		goto teardown_intx;
-	}
-	irq_domain_update_bus_token(host->intx_domain, DOMAIN_BUS_WIRED);
-
 	if (IS_ENABLED(CONFIG_PCI_MSI)) {
 		ret = rzg3s_pcie_init_msi(host);
 
-- 
2.43.0

