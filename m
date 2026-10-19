Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA81D486E46;
	Mon, 19 Oct 2026 06:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792392704; cv=none; b=rvmlVggYqgwEhLL5So/n4etAA4hDw4P1O21ope+6dmZg9MwCOeloalE0QocX6zv7L89xbW/93XP3+NlbQzLGzYtBl9hq/dhNKrzOJr7J5SXE9r1FlxTQ0xu9LvcBo3myrQq66fUnmp9ebILCwYxVarPORbOYO8aMji/wKZmDX0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792392704; c=relaxed/simple;
	bh=myxbxwxj52O/yWNTLjMzSe62DZ/Xd48iVkV+KbdJ+tI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JUEONC8WXOd44fpKc1/d5Ogh2GzfG2o9isDocKy5xcysYintHu+EU0aOj/8828gjhLlaCDIj2NPI7P9ACwrI1AvDhbCOYtRDLnM21J/OZ7LUKbNSA5S/Lkx82rmhxkuPOK8PvLi1ALfoX2/C8XZxo6CxVjE2Fy/gdtNYVqo6uR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kkwMknA6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kkwMknA6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D963F1F000C5;
	Mon, 19 Oct 2026 06:51:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792392702;
	bh=uTUDJfD3FelybIS6c6icXMirsUtwnlPuRPTt2e3uzuc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kkwMknA6PPVzdp4b/LkZhtLORS6q8JkRqlTZPIOyvWqVC1Za5w0QZBbPKQata2s3R
	 wfF+kUiT6bdVeQJES/iuXy6QvGj+h92uzT6zT9ni6qtq/qsYN5nK+/qm5xhj9aY9Rt
	 Zo+D4zdQX2ANy4OhQslbSMUbod87WewmcdjOXJC6KL8IfBqDTpTw25fjKRnGlBHllZ
	 ykdOLMgT3lZYqY4LJ3C4pUdsZ3RN1fd+8MRgdvYruhcyiqub7bVJh9LHU3/Z7bH5c/
	 z8AyEDpMzJB0i2yIr6kBwhoosXnemflHSSgc5eDiuhO45CVgypW/c8rIerEq3yA8wC
	 OVBemlN7STGew==
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
Subject: [PATCH v7 05/14] PCI: rzg3s-host: Initialize the IRQ domains after the IRQs are masked
Date: Mon, 19 Oct 2026 09:50:16 +0300
Message-ID: <20261019065025.2146539-6-claudiu.beznea@kernel.org>
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

The IRQ domain initialization requests the interrupts and installs the
chained handlers before rzg3s_pcie_irq_init() masks the controller
interrupt sources. An interrupt left enabled (e.g. by the bootloader,
or latched from a previous controller state) could therefore fire
before the controller initialization is complete and be handled on
half-initialized state.

Move the IRQ domain initialization after rzg3s_pcie_irq_init(), so that
all the interrupt sources are masked by the time the handlers are
installed.

Fixes: 7ef502fb35b2 ("PCI: Add Renesas RZ/G3S host controller driver")
Cc: stable@vger.kernel.org
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v7:
- none, this patch is new

 drivers/pci/controller/pcie-rzg3s-host.c | 31 ++++++++++++------------
 1 file changed, 15 insertions(+), 16 deletions(-)

diff --git a/drivers/pci/controller/pcie-rzg3s-host.c b/drivers/pci/controller/pcie-rzg3s-host.c
index cc985020d962..94345d6f0bee 100644
--- a/drivers/pci/controller/pcie-rzg3s-host.c
+++ b/drivers/pci/controller/pcie-rzg3s-host.c
@@ -1418,7 +1418,10 @@ static int rzg3s_pcie_host_init_port(struct rzg3s_pcie_host *host)
 	return ret;
 }
 
-static int rzg3s_pcie_host_init(struct rzg3s_pcie_host *host)
+static int
+rzg3s_pcie_host_init(struct rzg3s_pcie_host *host,
+		     int (*init_irqdomain)(struct rzg3s_pcie_host *host),
+		     void (*teardown_irqdomain)(struct rzg3s_pcie_host *host))
 {
 	u32 val;
 	int ret;
@@ -1445,10 +1448,14 @@ static int rzg3s_pcie_host_init(struct rzg3s_pcie_host *host)
 	/* Initialize the interrupts */
 	rzg3s_pcie_irq_init(host);
 
+	ret = init_irqdomain(host);
+	if (ret)
+		goto config_deinit_and_refclk;
+
 	/* SoC-specific post-configuration */
 	ret = host->data->config_post_init(host);
 	if (ret)
-		goto config_deinit_and_refclk;
+		goto teardown_irqdomain;
 
 	/* Wait for link up */
 	ret = readl_poll_timeout(host->axi + RZG3S_PCI_PCSTAT1, val,
@@ -1466,6 +1473,8 @@ static int rzg3s_pcie_host_init(struct rzg3s_pcie_host *host)
 
 config_deinit_post:
 	host->data->config_deinit(host);
+teardown_irqdomain:
+	teardown_irqdomain(host);
 config_deinit_and_refclk:
 	clk_disable_unprepare(host->port.refclk);
 config_deinit:
@@ -1721,15 +1730,10 @@ rzg3s_pcie_host_setup(struct rzg3s_pcie_host *host,
 		return dev_err_probe(dev, ret,
 				     "Failed to set outbound windows!\n");
 
-	ret = init_irqdomain(host);
+	ret = rzg3s_pcie_host_init(host, init_irqdomain, teardown_irqdomain);
 	if (ret)
-		return dev_err_probe(dev, ret, "Failed to init IRQ domain\n");
-
-	ret = rzg3s_pcie_host_init(host);
-	if (ret) {
-		dev_err_probe(dev, ret, "Failed to initialize the HW!\n");
-		goto teardown_irqdomain;
-	}
+		return dev_err_probe(dev, ret,
+				     "Failed to initialize the HW!\n");
 
 	ret = rzg3s_pcie_set_max_link_speed(host);
 	if (ret)
@@ -1738,11 +1742,6 @@ rzg3s_pcie_host_setup(struct rzg3s_pcie_host *host,
 	pci_host_common_link_train_delay(host->max_link_speed);
 
 	return 0;
-
-teardown_irqdomain:
-	teardown_irqdomain(host);
-
-	return ret;
 }
 
 static int rzg3s_pcie_get_controller_id(struct rzg3s_pcie_host *host)
@@ -1923,8 +1922,8 @@ static int rzg3s_pcie_probe(struct platform_device *pdev)
 	return 0;
 
 host_probe_teardown:
-	clk_disable_unprepare(host->port.refclk);
 	rzg3s_pcie_teardown_irqdomain(host);
+	clk_disable_unprepare(host->port.refclk);
 	host->data->config_deinit(host);
 power_resets_assert:
 	reset_control_bulk_assert(host->data->num_power_resets,
-- 
2.43.0

