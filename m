Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794320260;
	b=KbuE7xWkx7D7LAqsskTTSc/BK63w4zWnSy80vDgLReKFRw2QFEezkU7DL+AbZmBhAg4u
	 1M5CbNuQTcqWnac/l8dBfemgM/Z+tPhu1wLgmfotx/iOJtFHVV/w9kOESw+VJmADi6lgG
	 FN/dcCjxlG2ct9fUcPcNe1rinXigECE4GcwUy+hjgpl30jmc2WgnoOQbH6s7pjToLaaih
	 F8qDiX5Wmmoskw+IX2rXFLYUJlb1aozWuEPHhcOqR3ELFZizqDXeaSB/0stiJbg71IZHk
	 DdTQ93sYRHc6K0Kuost1kO3zI+dNEmU4y0dZ50gtAemDb7AACkMCe7Ch4XvhO6/WdAA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794320260;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=zjohss4dmKQNPXpkF4Z4Ho3vmDlmPt9m2VLucd84OtE=;
	b=nZehIqtoFXh+QNgXKx+PqbwvH7maBukXUpGHRQaxYzIW9t7aC6RPlsQGA/tP4D/U/DSD
	 bk7on5gVyCv92bAkpG981OVvzDcvPWqPa6YZLrHrkHsFe+ObkCJw3ce4+6p28UxXfycnS
	 gIjPmZlSedrnbHNCCdh2/bSnBJbmiODmTMoubOK6dVqMA81ngPyuEOLLJ/pzlZmgEcOD8
	 luC6ngkszzWz/VYSMJ3O99Ibzo4pECSjKClRMHsQSTYF69Fv+NAsCZM22wmDvJ6gK6ubD
	 Swz+XsBq0UDSO2hws1KI0TA8dXeIWKCxuhvQlH0QgTk6Cbk9Zm9gMNv/dVI3swLNirA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PkF5dV31;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C490606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 14:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PkF5dV31
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F6831F008A3;
	Tue, 10 Nov 2026 14:17:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794320259;
	bh=zjohss4dmKQNPXpkF4Z4Ho3vmDlmPt9m2VLucd84OtE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PkF5dV31Mqyw2aMBaikFwpXz7IsCia7iR0vXDReJMTnvsBgQrxJwCopZxM/8K5Ez0
	 aP/LwcAHMxHDYi/KblgaaPGJSeT5RuYF9m/K9ghUpYOcRdIhQAFzCT1uUqm+aCo624
	 dAdK1zetWdwrlcZz59PcufwNjzOFR1gnoMAvEdaVa8cbHBggsAYYmbDX+Qw+kB3JdH
	 bycboE9RKaIMP6YEGRLgHipFJ1ujNnNDKwPQNsu0Wi+HyZRr1MSUEy3aDOhacVhQwA
	 lnrmThBXcNt+JGXSbgihf7GTBe3YoiykL1AV4LCKNrtJ0jn1yDALteoCNPHW7lpum3
	 YfLURpMKKdUTg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Niklas Cassel <cassel@kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/2] ata: libahci: Free the IRQs when activating a multi-IRQ host fails
Date: Tue, 10 Nov 2026 09:17:36 -0500
Message-ID: <20261110141601.1834083-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110141601.1834083-1-sashal@kernel.org>
References: <20261107052924-failed-6.6-34a4a34431ed@kernel.org>
 <20261110141601.1834083-1-sashal@kernel.org>
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
index 1056d536a60cb..d18876c6052ae 100644
--- a/drivers/ata/libahci.c
+++ b/drivers/ata/libahci.c
@@ -2735,11 +2735,33 @@ static int ahci_host_activate_multi_irqs(struct ata_host *host,
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

