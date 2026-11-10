Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794321679;
	b=E2CSqISS6dKoQpkPsdE9lU++jIWkIRiAC8mCO8ZJ4WpzLfeUcX9x8W5UBO58t95UXAMO
	 tISwZ2cq0wsKVBv2xdeQBfmR4fO1Bl5JxvzgvmWbt1RQxjp0Vv57FXGUbPHPIpGIdioq/
	 ZM4U0OFLOG8jpapyk7V5tviapIMH9VLqCL15xezfJqs7qdW0TwfvLSbtN/o7TvSneH8P+
	 s/wZNTzda19KJdzjjX57O61q+XMp/9Ltv1Xp3p9IfvweO181Ac+SYmlw+91Xrr2mmC3rH
	 eeRVsZrZl0+5DNpYQHpCZQWKEq+/ChTJevckFYem8HHgP9kcSg2KBd5H4nXE71EbG0w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794321679;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=aV49Z5+/fHT7jbiqqh6EVvIeQYgBrkuIjN0HnDzLDD4=;
	b=PGsh1WZP/AIv/yryLeyufNsfPHcYym3IKwJxLBBWVBSujXriXxEfpsHZgEigrHUSs09q
	 zSwgNS96tpYoOdmN1RSW04uZY6mR/pjibUWL8ILsqb8wwhAJOkaw3FG803oYDPE4LzYoa
	 E/hCkIKKPpnvR4RQ2+WBWiS5YXTXuiuV2T35nrDhMdm7f2zMNjZ4s3hAaquSkG0gQcZh3
	 V/Xmyr0C2lLZ3d7UpT2Yr5Hwu18d60sLRwo+3MP1fcJN+Di6mG2DJtfImeaWHOMvTHvvG
	 serU32SS6FX82JU6Isnmk5Ddh+mkNLT2FQW+kUc3l9xHoEEcWkG4nOEZz0YSwQZCKdg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZzBZdsCz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5999D60A262B
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 14:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZzBZdsCz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A10281F0089F;
	Tue, 10 Nov 2026 14:41:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794321679;
	bh=aV49Z5+/fHT7jbiqqh6EVvIeQYgBrkuIjN0HnDzLDD4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZzBZdsCzyELCMbMl6kZ6gpJQbgGWw+2LVitjPR9kdbeEFa3mxvIeckE/Ex5578fC5
	 n/V5nHNtgN9+wXQOUfBRM1WHXodY12Fhmk8/hgOB+iubWgDiIQ5gg1gKKV1O9oVNlS
	 GExey0xLVsqB3ECAR//84PI9RzKG9sGvRPL49Mnm/7hzk1dr9c3e8RWLJi0vC4kTsb
	 LELzen4/QM9fX87DEl6zB1FsLUvwNW3VRQgl0sVlBD51mrISK+BPwietZeVDAz3fWd
	 ymBMesM2jXN1TFEfOIGnbQCkMhsdVocP2mCSZn05FjB1wXrLeVmb9UhPj46AGFWtPR
	 MCSMnGlkpC9Zw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Niklas Cassel <cassel@kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 2/2] ata: libahci: Free the IRQs when activating a multi-IRQ host fails
Date: Tue, 10 Nov 2026 09:41:15 -0500
Message-ID: <20261110144034.1942502-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110144034.1942502-1-sashal@kernel.org>
References: <20261107061554-failed-5.10-34a4a34431ed@kernel.org>
 <20261110144034.1942502-1-sashal@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Niklas Cassel <cassel@kernel.org>

[ Upstream commit 34a4a34431ed81d85d14f8fb8035e5a25214ad39 ]

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
Link: https://lore.kernel.org/r/20260915084127.692494-12-cassel@kernel.org
Signed-off-by: Niklas Cassel <cassel@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/ata/libahci.c | 26 ++++++++++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
index 32ebcfcb7914c..83f82b3ffe7d4 100644
--- a/drivers/ata/libahci.c
+++ b/drivers/ata/libahci.c
@@ -2577,11 +2577,33 @@ static int ahci_host_activate_multi_irqs(struct ata_host *host,
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
2.53.0

