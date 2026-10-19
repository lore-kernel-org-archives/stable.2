Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 785D24848BE;
	Mon, 19 Oct 2026 06:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792392693; cv=none; b=KbwbLEm8UjgCOGTedooQcgNQF6rEYht5iA2Dz+2ADTpcwJ2GL/bRx0cauUxc0BiPeB3XbT3URV9WzZFpA736vOYm3ewHZXJHj0x2aUYczvLVSOwVkaXSpBoNV4iJmK9+taFOn+qmCvRvLFc9bWjnqqIaFHOV7IwsmGHXK3L5ebs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792392693; c=relaxed/simple;
	bh=edfeUupAsniKn4+zfC9SVHVpnDN2F4y2RoYl7LiCOHU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VnVllJ/eKWar7iwMClnGg/PtpWsLVRr7RtgY4srU3q0KglJMlQ+zVr4KP9C/PcbjuzRwsj1dLHnAlXibMFpepzQjsM1o8yDCoQ8KqUMnkSN2I5SedQgJUUwIrWsupBX5l2rYId1ey1hT/0voh+C8+/MKgljyg+tYKExIlRwJyIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HGs/yoAq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HGs/yoAq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF06E1F000C4;
	Mon, 19 Oct 2026 06:51:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792392692;
	bh=Pf37uOojoeoab/+P9BD4uP3j6rp4uQmZR91q4yHMOtY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HGs/yoAqjtOxswKUiP8Bx77/Wc407zZ2N1qCN+y/EK27hbmGqFgzlm1tb9TcaE6ij
	 MBCU3OLfuBfhyhBA9TryCZLXh9+dVtiqWFsD2buvir38CKLsmj6jtQfWTvAozIqEjT
	 UL2KV0AcuRU/MJQlUIWnEzUMJaqSvXwAfSbLOvSl+wzD/ldSXbqNOIqD32vdr7hQId
	 oVqNecEKAqoL9w66yg/S4Vz2ZZLkw8CmAWos9xK9Xnxd3xO0VVkgxpL7kjzi/jSegI
	 z60quAqFbq+z51uQQX4GGosgsGxPJek2LV4+TLPoJ3dGU9M/ng1ydjfRX3mUWkMxow
	 2FYHfD2/9adEw==
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
Subject: [PATCH v7 02/14] PCI: rzg3s-host: Fix runtime PM handling in the NOIRQ suspend/resume phase
Date: Mon, 19 Oct 2026 09:50:13 +0300
Message-ID: <20261019065025.2146539-3-claudiu.beznea@kernel.org>
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

Changes in v7:
- none

Changes in v6:
- none

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

