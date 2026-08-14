Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03F2E3B8BC4;
	Fri, 14 Aug 2026 14:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786716835; cv=none; b=dBzurAMqpXX8oUWqLqsm3lpdPOddKOTr0OipRs5GEE11zZ1Qsl9MSbMAXNutMGMALpve3te1mLKbzZaGrMvuVyFwgqaWR/kT2JTxytoL46lZxswWSaAiNcNmU57YVkqy5EKKbsXrylCKZCb0vOpP7xugTMzpBU1yP54auXjjV/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786716835; c=relaxed/simple;
	bh=tTK0WkjM0azrpUPFckScHarj7Z3ghWaETGNv5srMzRk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QeEOfeskIl1/529iJYDsFFumVSz96B2hVj/NEeHvMIdU+eoKhm53GCQnPfje46uOwiv19+xspB41D/SCZOrdzuO1Y0d5lhSA9wR2cBeuAsWzycVPyumnTpv40szRcTVCbrV1WZV3MhM2hK9TAi2pkrrQ+vKTKb8OFtzZZUVCGEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14C1E1F00A3D;
	Fri, 14 Aug 2026 14:13:27 +0000 (UTC)
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
Subject: [PATCH v3 2/7] PCI: rzg3s-host: Fix runtime PM handling in the NOIRQ suspend/resume phase
Date: Fri, 14 Aug 2026 17:13:07 +0300
Message-ID: <20260814141312.2947972-3-claudiu.beznea+renesas@tuxon.dev>
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

The runtime PM documentation states the following:
- During system suspend, pm_runtime_get_noresume() is called for every
  device right before executing the subsystem-level .prepare() callback
  (in device_prepare()). In addition, the PM core disables runtime PM for
  every device right before executing the subsystem-level .suspend_late()
  callback (in device_suspend_late()).
- During system resume, pm_runtime_enable() is called for every device
  right after executing the subsystem-level .resume_early() callback (in
  device_resume_early()), and pm_runtime_put() is called right after
  executing the subsystem-level .complete() callback (in
  device_complete()).

The driver's .suspend_noirq() callback is invoked after .suspend_late(),
while .resume_noirq() is invoked before .resume_early().

If:
- the device is not part of the wake-up path, and
- its runtime PM status is not RPM_SUSPENDED,
the generic power domain .suspend_noirq()/.resume_noirq() callbacks
(genpd_suspend_noirq()/genpd_resume_noirq()) invoke the driver's
.suspend_noirq()/.resume_noirq() callbacks and call
genpd_stop_dev()/genpd_start_dev() before and after them, respectively.

Calling genpd_stop_dev()/genpd_start_dev() allows devices whose power is
controlled by generic power domains to be powered off and on during
system suspend and resume, even though their runtime PM usage count does
not reach zero.

Since the runtime PM usage count is incremented in device_prepare() and
decremented in device_complete(), runtime PM operations performed from
the driver's .suspend_noirq()/.resume_noirq() callbacks are no-ops. The
actual power transitions are handled by the generic power domain
.suspend_noirq()/.resume_noirq() callbacks.

Moreover, attempting to runtime resume a device while runtime PM is
disabled may return -EACCES. This may cause system resume to fail when
resuming after a failed Root Port reset, as described in a subsequent
patch adding hot-plug support.

Remove the runtime PM calls from the driver's
.suspend_noirq()/.resume_noirq() callbacks and rely on the generic power
domain callbacks to power the device off and on.

Fixes: 7ef502fb35b2 ("PCI: Add Renesas RZ/G3S host controller driver")
Cc: stable@vger.kernel.org
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v3:
- none, this patch is new

 drivers/pci/controller/pcie-rzg3s-host.c | 50 ++++++++++++++++++------
 1 file changed, 38 insertions(+), 12 deletions(-)

diff --git a/drivers/pci/controller/pcie-rzg3s-host.c b/drivers/pci/controller/pcie-rzg3s-host.c
index 830cd7c76699..bbc5bcec03f1 100644
--- a/drivers/pci/controller/pcie-rzg3s-host.c
+++ b/drivers/pci/controller/pcie-rzg3s-host.c
@@ -1961,19 +1961,32 @@ static int rzg3s_pcie_suspend_noirq(struct device *dev)
 	if (ret)
 		goto config_reinit;
 
-	ret = pm_runtime_put_sync(dev);
-	if (ret)
-		goto power_resets_restore;
+	/*
+	 * Since:
+	 * - the runtime PM usage count was incremented by
+	 *   pm_runtime_get_noresume() in the system suspend/resume code before
+	 *   executing the subsystem-level .prepare() callback
+	 *   (in device_prepare()),
+	 * - runtime PM has been disabled by the system suspend/resume code
+	 *   before executing the subsystem-level .suspend_late() callback
+	 *   (in device_suspend_late()), and
+	 * - the PCIe driver's runtime PM state remains RPM_ACTIVE (it was
+	 *   runtime resumed in probe()),
+	 *
+	 * any runtime PM operation becomes a no-op and may lead to unexpected
+	 * failures.
+	 *
+	 * Let the power domain's genpd_suspend_noirq() callback disable the
+	 * clocks, as it already does.
+	 */
 
 	ret = rzg3s_sysc_config_func(sysc, RZG3S_SYSC_FUNC_ID_RST_RSM_B, 0);
 	if (ret)
-		goto rpm_resume;
+		goto power_resets_restore;
 
 	return 0;
 
 	/* Restore the previous state if any error happens */
-rpm_resume:
-	pm_runtime_resume_and_get(dev);
 power_resets_restore:
 	reset_control_bulk_deassert(data->num_power_resets,
 				    host->power_resets);
@@ -2011,13 +2024,28 @@ static int rzg3s_pcie_resume_noirq(struct device *dev)
 			goto assert_rst_rsm_b;
 	}
 
-	ret = pm_runtime_resume_and_get(dev);
-	if (ret)
-		goto assert_rst_rsm_b;
+	/*
+	 * Since:
+	 * - the runtime PM usage count was incremented by
+	 *   pm_runtime_get_noresume() in the system suspend/resume code before
+	 *   executing the subsystem-level .prepare() callback
+	 *   (in device_prepare()),
+	 * - runtime PM has been disabled by the system suspend/resume code
+	 *   before executing the subsystem-level .suspend_late() callback
+	 *   (in device_suspend_late()),
+	 * - on resume pm_runtime_enable() is called after executing the
+	 *   subsystem-level .resume_early() (in device_resume_early())
+	 *
+	 * any runtime PM operation becomes a no-op and may lead to unexpected
+	 * failures.
+	 *
+	 * Let the power domain's genpd_resume_noirq() callback enable the
+	 * clocks, as it already does.
+	 */
 
 	ret = rzg3s_pcie_power_resets_deassert(host);
 	if (ret)
-		goto rpm_put;
+		goto assert_rst_rsm_b;
 
 	ret = rzg3s_pcie_host_setup(host, rzg3s_pcie_msi_hw_setup,
 				    rzg3s_pcie_msi_hw_teardown);
@@ -2033,8 +2061,6 @@ static int rzg3s_pcie_resume_noirq(struct device *dev)
 assert_power_resets:
 	reset_control_bulk_assert(data->num_power_resets,
 				  host->power_resets);
-rpm_put:
-	pm_runtime_put_sync(dev);
 assert_rst_rsm_b:
 	rzg3s_sysc_config_func(sysc, RZG3S_SYSC_FUNC_ID_RST_RSM_B, 0);
 	return ret;
-- 
2.43.0

