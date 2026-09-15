Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C3BD4825BD;
	Tue, 15 Sep 2026 08:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789461743; cv=none; b=RBwDKp1zTWwKvbJvNMnh8u4xqpr8Juq9d9lYNsxknxuPl8dnxtkLZ+bKF0sQhT1j0GgnZwa69hzPJlHCjVTYTaIqaUKmK04MRH8AKIDLKzUqEZhrABPyBylVyz2EzXwq0mWjlSJ7hKRb/TvIHhsVH/d9AMEZ0s52p7Zw/iCgAZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789461743; c=relaxed/simple;
	bh=/p6nqis/yT87ggT5a29DCidGjMeHdZXri/7vNueZdCw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nK1lUyZjecp/In2i4lM8wrZKL64+YPb5pVYQVObcUGHtyqiJWDezduWHTBCR6V3iOBj/x2s0L/AHIrv87okdLJXZoS0/ckyWK1mCRHp8tt0BwAsuHb1NUTHxUGcnCUx4saxmGv8pMj8At9Bk36zTkYRDAdvoWYMWnsU5uAj1eJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nxv+yxsa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nxv+yxsa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 418F81F008BF;
	Tue, 15 Sep 2026 08:42:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789461740;
	bh=nOJ9I0NPYql3ZuPXM/ZFNaEp/YGYo1vqCGkpGV+SUy0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Nxv+yxsa/y63gdVh2vbZxM4NN+rXeYyxQDw9ClNyiB+EV7d2E3jPPCAENNWeTadO9
	 SASrnjLW4aH9pLzZ2tzteGvaGZqYdmQemFMzCNP4PPhr/wM1hexNPxHvOoETa4iARc
	 VCypjjesSgr8paqMsO4wAa7oTfy1Cc+Xowap44FhuxrMgMwIuj7px8ZBUTEaThm8EM
	 gvaFWjdbqGHIV+d+o2cM19EX/X+r+Jrk3dS3ykK7nhyKCH1xR+nwEDm00NINTW9hVS
	 scI5q1LBeTIAptnL0Rowrg4+Lh29ICWUt/TAtbXUBqy/wntEvbG277jfEFTiyMLDDe
	 lSnzvsj79N2jg==
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	Dan Williams <djbw@kernel.org>
Cc: Brian Norris <computersforpeace@gmail.com>,
	stable@vger.kernel.org,
	linux-ide@vger.kernel.org
Subject: [PATCH v5 4/6] ata: libahci: Free the IRQs when activating a multi-IRQ host fails
Date: Tue, 15 Sep 2026 10:41:30 +0200
Message-ID: <20260915084127.692494-12-cassel@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260915084127.692494-8-cassel@kernel.org>
References: <20260915084127.692494-8-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2724; i=cassel@kernel.org; h=from:subject; bh=/p6nqis/yT87ggT5a29DCidGjMeHdZXri/7vNueZdCw=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGLJWsuy1/pdy2+wLR9d/7/qFqSJcnhcKlxp938C8K+Gwq KZGTuWljlIWBjEuBlkxRRbfHy77i7vdpxxXvGMDM4eVCWQIAxenAExkSQnD/+jn37eErby2Pujt wUcf1h56HeKddM9PfcGi2qlr++9drz/LyLCldG/4t3DPa5N6HVgO6922/yNlc0ut8yhznDqnJBf LYn4A
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
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
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

