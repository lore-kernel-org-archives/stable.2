Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52654489FAA;
	Fri,  2 Oct 2026 11:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790939400; cv=none; b=cHVN8JR+ReN4bQDDgSSlurO3r80HH34SDyl/nfONb+TPG5uzmLs8amMkG689rVJ8wOozuxVk5KUWaIpUDJAnQRt176PW2JzGxG7wVM+Tq960BZN174duO0t8G0nd2Hr6lhSOYfg5htcPx/VwTdKjZxTu7gfp4GaCXZtvEk8M4h8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790939400; c=relaxed/simple;
	bh=2Ye0k/fMhA8sGXWiT6C167fD6+fjCgRwOSywcm4S5So=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BI4O0mLexgZA3Ef/unzsBR11H0hjxJC3Oq+V/zGmCc+tbmbMm08GauepKhFVVryQaeSlYaGUgF50+xONK0FgA9FNdZE+5mKvp/CvRyyaDzn64aWUmcu/D01njaoKonexdy+n+vM60MUHkCHolcfwe2ptq2l/GPfg9RDRXrR5x5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eJH2awXq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eJH2awXq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97CB71F00899;
	Fri,  2 Oct 2026 11:09:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790939394;
	bh=Lq494l7k0PYr4jhdwg0brPjiodVedpmKQWhUq4sS3Ns=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eJH2awXqh5iPgFosyZgJMsqgQH08OlvFImEGDOYBxyYHhM4Xk09eDjMqr4EkGd075
	 kCJTmM2aw80DgCMJOvl+KmCV6rY9Rvs9HyTihFtKCruwvgqS3TiKXvL6K51jq8/4bO
	 jO3QmPq9Ebx/S9/3u/QgAafdbacbH5HdHBzH8HJm9RMUS0pBSFTXui7W5vAVzkcJR1
	 S7S58K/+VEgmEZNmgXaDInmM7Jwwd3FidelI08X66xN9AkOfkyks/UQpE+KGjVvYt8
	 dTUl87NRKEVfy3BRu7xUqt1AHDsagxxWIt0Q4yAdaiFr/JeYxwKbL/PQ3P/G4GPnem
	 SswZX6zrxwZkA==
From: Claudiu Beznea <claudiu.beznea@kernel.org>
To: lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	robh@kernel.org,
	bhelgaas@google.com,
	p.zabel@pengutronix.de,
	18255117159@163.com
Cc: claudiu.beznea@tuxon.dev,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	stable@vger.kernel.org,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v5 2/9] PCI: rzg3s-host: Fix runtime PM handling in the NOIRQ suspend/resume phase
Date: Fri,  2 Oct 2026 14:09:28 +0300
Message-ID: <20261002110935.2004349-3-claudiu.beznea@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261002110935.2004349-1-claudiu.beznea@kernel.org>
References: <20261002110935.2004349-1-claudiu.beznea@kernel.org>
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
Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Tested-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v5:
- collected tags

Changes in v4:
- simplified the comments in rzg3s_pcie_suspend_noirq()/rzg3s_pcie_resume_noirq()

Changes in v3:
- none, this patch is new

 drivers/pci/controller/pcie-rzg3s-host.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/drivers/pci/controller/pcie-rzg3s-host.c b/drivers/pci/controller/pcie-rzg3s-host.c
index e1105b1f2652..0ef49bb5ab1a 100644
--- a/drivers/pci/controller/pcie-rzg3s-host.c
+++ b/drivers/pci/controller/pcie-rzg3s-host.c
@@ -1961,19 +1961,18 @@ static int rzg3s_pcie_suspend_noirq(struct device *dev)
 	if (ret)
 		goto config_reinit;
 
-	ret = pm_runtime_put_sync(dev);
-	if (ret)
-		goto power_resets_restore;
+	/*
+	 * Since the power domain's genpd_suspend_noirq() will disable clocks,
+	 * there is no need to manually invoke runtime PM API here.
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
@@ -2011,13 +2010,14 @@ static int rzg3s_pcie_resume_noirq(struct device *dev)
 			goto assert_rst_rsm_b;
 	}
 
-	ret = pm_runtime_resume_and_get(dev);
-	if (ret)
-		goto assert_rst_rsm_b;
+	/*
+	 * Since the power domain's genpd_resume_noirq() will enable clocks,
+	 * there is no need to manually invoke runtime PM API here.
+	 */
 
 	ret = rzg3s_pcie_power_resets_deassert(host);
 	if (ret)
-		goto rpm_put;
+		goto assert_rst_rsm_b;
 
 	ret = rzg3s_pcie_host_setup(host, rzg3s_pcie_msi_hw_setup,
 				    rzg3s_pcie_msi_hw_teardown);
@@ -2033,8 +2033,6 @@ static int rzg3s_pcie_resume_noirq(struct device *dev)
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

