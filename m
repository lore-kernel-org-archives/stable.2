Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7723A352014;
	Fri, 14 Aug 2026 14:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786716828; cv=none; b=MYtquxslfsyvzsd08AE/5BpYdf7XivyjV8deoENGkadUGGi5KISJ7LbaHdddLjZN6fAdfRba7nHObhVaM89ZXUJpqbnfMgD/MXocnEZSQbXYLoJZpBWEaLruoBoX/CDLuDrDDDnCIhlsCpSRQ+QSYaOABlPhwp9quL8fdX8Uc54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786716828; c=relaxed/simple;
	bh=FCPHczQbcgTaFsYO8Zqk9s0VrESK4kQBnDc9NTlt6Uw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bUH5bZEbBsoAOHx85LU0fIXRzt/UXeReqg6kYdWzFT3Do40TyIuhakgVECjNeSsya/GbmnSVpYYfzzYhpMytLwKwDwA5Gpu2s1m3vb2LKqEXYQgz5unOUXBmUWE7tkNlCZRB0kxQycjEtH3jDq2smcluLteDtwVk/0XZl70D+Mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC47C1F00A3A;
	Fri, 14 Aug 2026 14:13:24 +0000 (UTC)
From: Claudiu Beznea <claudiu.beznea+renesas@tuxon.dev>
To: lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	robh@kernel.org,
	bhelgaas@google.com,
	p.zabel@pengutronix.de
Cc: claudiu.beznea@tuxon.dev,
	linux-pci@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	stable@vger.kernel.org
Subject: [PATCH v3 1/7] PCI: rzg3s-host: Follow hardware manual clock/reset initialization order
Date: Fri, 14 Aug 2026 17:13:06 +0300
Message-ID: <20260814141312.2947972-2-claudiu.beznea+renesas@tuxon.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260814141312.2947972-1-claudiu.beznea+renesas@tuxon.dev>
References: <20260814141312.2947972-1-claudiu.beznea+renesas@tuxon.dev>
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
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v3:
- none, this patch is new

 drivers/pci/controller/pcie-rzg3s-host.c | 40 +++++++++++++-----------
 1 file changed, 21 insertions(+), 19 deletions(-)

diff --git a/drivers/pci/controller/pcie-rzg3s-host.c b/drivers/pci/controller/pcie-rzg3s-host.c
index 3f7393c49a08..830cd7c76699 100644
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

