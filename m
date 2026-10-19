Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA1954848BE;
	Mon, 19 Oct 2026 06:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792392689; cv=none; b=ORRs5I27m5T7s1tH6buJ5vZE1W3w039lMy38NalYbnB21Ol77prqgl2sS4CTuIxKfBeozRI+F3UPgSKP79Iwa5K+lwG74ZVXu9X49ipFI0kW+uQM1lH458SE0lTl/lAn1lvrdkiUUX/KI2FILyjrTdUyDXH7dEhnURoGxnyVbXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792392689; c=relaxed/simple;
	bh=eeB4SKIb7t7+3YTMsXzEyOw6pwy6g8BpMVMtKXD2W9E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TGHju91pszGi1CRQzLaDkiNuz7eXROpyGaVAXMYLVncbbDDdjxMDOmtRypox80aJqBtdwX/+jv9TnYd8RHX+hxQCcTNEM4o2r6nyxwJySkq7uoVxlwrXGQ0SguChaOuTBIs/p68Zvm/gaqe/7sDOuRBbgBKIk5NTSS8oBRXb4CQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EWy7DbQK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EWy7DbQK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 288211F000C5;
	Mon, 19 Oct 2026 06:51:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792392688;
	bh=IUlIDps8XyWSDb32G4KUhVb0C7gubLKT7PaDbrjp0pQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EWy7DbQK3woK2rZ13NvA7khCYmOaWjb5V8YCvBTEYhz26soYPK2m5oCbd8inFL97m
	 6Qd65TL5BSJQTRbix4DnFicISpf3woDwU0NF+kt6IIE+Bys5CPpjN389BEaHDJi5Zi
	 R30EQgPmuhLgiV9Ka5u6OvWVAzYKFzrlB/zxYUFpNbmc3ZBqR67zi1VPoL2oq4Db6x
	 oTnoPyBct6xcewn9ZC40GjOABUQlDrTew/iyeWxBhLu9s6mkJzmNZbs4m1YdLH46yT
	 kAvkGxcpPX3cvwS2n7XId9O/CEK10W4GJZlOzN3+RshOOAWCKswljvmbhOOz4MLH1e
	 lnhPyc09SjIvg==
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
	stable@vger.kernel.org,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v7 01/14] PCI: rzg3s-host: Follow hardware manual clock/reset initialization order
Date: Mon, 19 Oct 2026 09:50:12 +0300
Message-ID: <20261019065025.2146539-2-claudiu.beznea@kernel.org>
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

The RZ/G3S PCIe hardware manual specifies that the clocks must be enabled
before the reset signals are deasserted during initialization.

Follow this sequence in the probe(), suspend(), and resume() paths to
match the hardware requirements and avoid potential issues.

Fixes: 7ef502fb35b2 ("PCI: Add Renesas RZ/G3S host controller driver")
Cc: stable@vger.kernel.org
Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Tested-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v7:
- none

Changes in v6:
- none

Changes in v5:
- collected tags

Changes in v4:
- none

Changes in v3:
- none, this patch is new

 drivers/pci/controller/pcie-rzg3s-host.c | 40 +++++++++++++-----------
 1 file changed, 21 insertions(+), 19 deletions(-)

diff --git a/drivers/pci/controller/pcie-rzg3s-host.c b/drivers/pci/controller/pcie-rzg3s-host.c
index 077cfb0834b3..e1105b1f2652 100644
--- a/drivers/pci/controller/pcie-rzg3s-host.c
+++ b/drivers/pci/controller/pcie-rzg3s-host.c
@@ -1888,10 +1888,6 @@ static int rzg3s_pcie_probe(struct platform_device *pdev)
 	if (ret)
 		goto sysc_signal_restore;
 
-	ret = rzg3s_pcie_power_resets_deassert(host);
-	if (ret)
-		goto sysc_signal_restore;
-
 	pm_runtime_enable(dev);
 
 	/*
@@ -1902,12 +1898,16 @@ static int rzg3s_pcie_probe(struct platform_device *pdev)
 	if (ret)
 		goto rpm_disable;
 
+	ret = rzg3s_pcie_power_resets_deassert(host);
+	if (ret)
+		goto rpm_put;
+
 	raw_spin_lock_init(&host->hw_lock);
 
 	ret = rzg3s_pcie_host_setup(host, rzg3s_pcie_init_irqdomain,
 				    rzg3s_pcie_teardown_irqdomain);
 	if (ret)
-		goto rpm_put;
+		goto power_resets_assert;
 
 	bridge->sysdata = host;
 	bridge->ops = &rzg3s_pcie_root_ops;
@@ -1922,12 +1922,13 @@ static int rzg3s_pcie_probe(struct platform_device *pdev)
 	clk_disable_unprepare(host->port.refclk);
 	rzg3s_pcie_teardown_irqdomain(host);
 	host->data->config_deinit(host);
+power_resets_assert:
+	reset_control_bulk_assert(host->data->num_power_resets,
+				  host->power_resets);
 rpm_put:
 	pm_runtime_put_sync(dev);
 rpm_disable:
 	pm_runtime_disable(dev);
-	reset_control_bulk_assert(host->data->num_power_resets,
-				  host->power_resets);
 sysc_signal_restore:
 	/*
 	 * SYSC RST_RSM_B signal need to be asserted before turning off the
@@ -1948,10 +1949,6 @@ static int rzg3s_pcie_suspend_noirq(struct device *dev)
 	struct rzg3s_sysc *sysc = host->sysc;
 	int ret;
 
-	ret = pm_runtime_put_sync(dev);
-	if (ret)
-		return ret;
-
 	clk_disable_unprepare(port->refclk);
 
 	/* SoC-specific de-initialization */
@@ -1964,13 +1961,19 @@ static int rzg3s_pcie_suspend_noirq(struct device *dev)
 	if (ret)
 		goto config_reinit;
 
-	ret = rzg3s_sysc_config_func(sysc, RZG3S_SYSC_FUNC_ID_RST_RSM_B, 0);
+	ret = pm_runtime_put_sync(dev);
 	if (ret)
 		goto power_resets_restore;
 
+	ret = rzg3s_sysc_config_func(sysc, RZG3S_SYSC_FUNC_ID_RST_RSM_B, 0);
+	if (ret)
+		goto rpm_resume;
+
 	return 0;
 
 	/* Restore the previous state if any error happens */
+rpm_resume:
+	pm_runtime_resume_and_get(dev);
 power_resets_restore:
 	reset_control_bulk_deassert(data->num_power_resets,
 				    host->power_resets);
@@ -1980,7 +1983,6 @@ static int rzg3s_pcie_suspend_noirq(struct device *dev)
 	data->config_post_init(host);
 refclk_restore:
 	clk_prepare_enable(port->refclk);
-	pm_runtime_resume_and_get(dev);
 	return ret;
 }
 
@@ -2009,18 +2011,18 @@ static int rzg3s_pcie_resume_noirq(struct device *dev)
 			goto assert_rst_rsm_b;
 	}
 
-	ret = rzg3s_pcie_power_resets_deassert(host);
+	ret = pm_runtime_resume_and_get(dev);
 	if (ret)
 		goto assert_rst_rsm_b;
 
-	ret = pm_runtime_resume_and_get(dev);
+	ret = rzg3s_pcie_power_resets_deassert(host);
 	if (ret)
-		goto assert_power_resets;
+		goto rpm_put;
 
 	ret = rzg3s_pcie_host_setup(host, rzg3s_pcie_msi_hw_setup,
 				    rzg3s_pcie_msi_hw_teardown);
 	if (ret)
-		goto rpm_put;
+		goto assert_power_resets;
 
 	return 0;
 
@@ -2028,11 +2030,11 @@ static int rzg3s_pcie_resume_noirq(struct device *dev)
 	 * If any error happens there is no way to recover the IP. Put it in the
 	 * lowest possible power state.
 	 */
-rpm_put:
-	pm_runtime_put_sync(dev);
 assert_power_resets:
 	reset_control_bulk_assert(data->num_power_resets,
 				  host->power_resets);
+rpm_put:
+	pm_runtime_put_sync(dev);
 assert_rst_rsm_b:
 	rzg3s_sysc_config_func(sysc, RZG3S_SYSC_FUNC_ID_RST_RSM_B, 0);
 	return ret;
-- 
2.43.0

