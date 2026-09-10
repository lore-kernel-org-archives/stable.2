Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2F7F54280B;
	Thu, 10 Sep 2026 17:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789060511; cv=none; b=URoVdcODFjcmodtHzYGBacASf3WZzP2CEdDhI8EB2I94BVwPd/reF3uEpg/4a1fAl1KoCg+UJ9MLGLYsO6BNAYJZQwuGe8s1VZNCUYgLJhSxGxQrSaie90KPt9jkbaJa41ggFSPEAihzAkBqldKyHpnBW8KR3H3Y4tiKfq514+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789060511; c=relaxed/simple;
	bh=TUEfuTl1g0UV6IuUG/p8QoejpaKi84l08yD/J4AXsd4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S9v1m1mvn+LWvBNlTlV1D/LgbWAZKSgeetENGBvM96fVBEoQ5oeQ+4PEtnTMGOKFJtnZCaIJPrpaTtGvpymhvt+K2jde7sM54AzOjk0n2DX8xaHc5jLP5OhQdHMKuEJGizOLB2kDVs0k9r5EL5veox/YqV96/bpHnqxeofYKKA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pl0CuDP7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pl0CuDP7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E79211F00898;
	Thu, 10 Sep 2026 17:14:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789060494;
	bh=Q+VY7yR6m/8VMLTd9swKQuJ++x0c6mEKk3L3sk1Sbyg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Pl0CuDP77/CN88mHxSi/z0cb9WPaIEmbS4kUPqey+MOj1A3g4qKqPXwKszJF2ft+p
	 +PBdHCq7miCp9TGmFMWXEOQQYHULwepgC2YaKU0DgNRVboMhEjURRfTp3yPHr1EiOW
	 jHjIpvUO1rYwSOJ1I1GMQlUtaMb1wEjOIGCOHPzBlJ2cLMEUpHam+KWwwic1mdIHxX
	 fuMSPNHSotPgNd/OnSgrr6syguUllbIH6+91NzmNTwSf6MogbResAgoFUBCo9pv096
	 TQ8jCAc2HU/bWwpkERuUAlMgNGvg3ptSqmcaDy5gq2MIuZorCKBYKqN0/aOQQSssq9
	 1Kk+G4nUDEGwQ==
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	Dan Williams <djbw@kernel.org>
Cc: Brian Norris <computersforpeace@gmail.com>,
	stable@vger.kernel.org,
	linux-ide@vger.kernel.org
Subject: [PATCH v4 3/5] ata: libahci: Free the IRQs when activating a multi-IRQ host fails
Date: Thu, 10 Sep 2026 19:14:09 +0200
Message-ID: <20260910171406.131211-10-cassel@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260910171406.131211-7-cassel@kernel.org>
References: <20260910171406.131211-7-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2674; i=cassel@kernel.org; h=from:subject; bh=TUEfuTl1g0UV6IuUG/p8QoejpaKi84l08yD/J4AXsd4=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGLIWPc3UkuG4eyru05sqjo0mvtW3r0bLc/L2eyU8fR31a qpWCIdNRykLgxgXg6yYIovvD5f9xd3uU44r3rGBmcPKBDKEgYtTACYi8I2RYafg1LRZ3BsDMw49 un7e01s8YUPfOfbWaiaVqPV73pzlnMrI8PzP2T/y83j5GDrO3Hbie1D7Ve697d3KvTqb1v+Ye2q ZIBsA
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

ahci_host_activate_multi_irqs() requests one IRQ per port, but it does
not free them when requesting one of them, or when registering the host,
fails. The IRQs are only freed by the driver core, when it releases the
devres of the device after probe() has returned, while the caller of
ahci_host_activate() releases the resources of the host in its probe()
error path, e.g. ahci_probe() disables the clocks, regulators, resets and
PHYs of the host. An IRQ handler running in that window would access the
MMIO of a host which is no longer clocked.

ahci_host_activate_multi_irqs() did free the IRQs until commit
0a142b26921c ("ahci: cleanup ahci_host_activate_multi_irqs"), which
removed the explicit free because devm makes it unnecessary. That is true
for freeing the IRQs as such, but not for the window described above:
devres is only released after probe() has returned, i.e. after the error
path of the caller has released the resources of the host.

Note that this window cannot be hit with the current users: the only user
of AHCI_HFLAG_MULTI_MSI is the AHCI PCI driver, which does not release
any resource in its probe() error path, and the ports of the host are
still frozen, i.e. their interrupts are masked, when ata_host_register()
fails.

Free the IRQs explicitly again, like ata_host_activate() does, so that
the IRQ handlers cannot run once ahci_host_activate() has failed.

Fixes: 0a142b26921c ("ahci: cleanup ahci_host_activate_multi_irqs")
Cc: stable@vger.kernel.org
Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/ata/libahci.c | 26 ++++++++++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
index 6d72eb017b49..9f479daa89b0 100644
--- a/drivers/ata/libahci.c
+++ b/drivers/ata/libahci.c
@@ -2723,11 +2723,33 @@ static int ahci_host_activate_multi_irqs(struct ata_host *host,
 				0, pp->irq_desc, host->ports[i]);
 
 		if (rc)
-			return rc;
+			goto free_irqs;
 		ata_port_desc_misc(host->ports[i], irq);
 	}
 
-	return ata_host_register(host, sht);
+	rc = ata_host_register(host, sht);
+	if (rc)
+		goto free_irqs;
+
+	return 0;
+
+free_irqs:
+	/*
+	 * Free the IRQs which have been requested, so that the handlers can no
+	 * longer access the MMIO of the host once we return, e.g. after the
+	 * caller has disabled the clocks of the host.
+	 */
+	while (--i >= 0) {
+		struct ahci_port_priv *pp = host->ports[i]->private_data;
+
+		if (!pp)
+			continue;
+
+		devm_free_irq(host->dev, hpriv->get_irq_vector(host, i),
+			      host->ports[i]);
+	}
+
+	return rc;
 }
 
 /**
-- 
2.55.0

