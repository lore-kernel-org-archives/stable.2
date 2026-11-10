Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794320675;
	b=j0Q9U8FjsVCf8OIw5JAXNsnPxXrTz3JIOyhx6BLwk54iHYtEsvED50HkiiFmq8eDp+8u
	 acN4/RMdkQ/p7VU3hadHFPyfoG5apvv+k4JwOAkZpdR4jqESpklohCXDdTFOgdLkEJbNq
	 ysHwTtqq4sDhJCSnBb5EMhAkY232dCf6H+0fR52TtdrXqHRAS1mRHv/9fawsR+na/snTF
	 4rCoGO2nfUITMfUfnjznxw6FZYzssa68rTqSn9MldVzMGsWZX1VROAxs8psVs3600zVrk
	 bQ4IpKz+ZCvUDz8Fekt7enlXeM3CqwEfvuwK9OE+2jZ6S3nTo1ttPGEQO4IdLowPhTw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794320675;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=TkfsXMIbYBQZuuPALvI+msP9vEHkm3nontZa+CETtxc=;
	b=lIHcXRpqcKlsvz8SBzMaRxQ+Phdq8WavgMGCaluZbRrVBXdRtQUeIu7bDqmTSgYI/12t
	 2umOjnhTl4KLoQ6JP94lodciA+heCZ8yg1LxwhOv/n7lJv/22IA9/XKVOhFIrBQWL2NLD
	 xlBgRxEk41tf9QOMIN9QKARAK8E2Kywf1UaDmEta9FA8gMMuhY69b3FLG9r9oz0m5KHu8
	 BbUPIgpooHKS7Yxc+JLGf15NERLYfIsLNtHwy7JDoeJX+Z2bfaIUmllJ2eMAUqPecO7Gd
	 StM9lbtIPgmr3RoSdhTCZGZrNfgv2iNxzlKdBWgT2ttlngGXd5CUjqc43kZ0utj1EkA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YY9KI5Fr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A209606A32E
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 14:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YY9KI5Fr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9570B1F008A1;
	Tue, 10 Nov 2026 14:24:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794320675;
	bh=TkfsXMIbYBQZuuPALvI+msP9vEHkm3nontZa+CETtxc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YY9KI5FriSTnDEaNYPoc5ZGXMzfgrkXK0u8DAte1IaKW5EUqXbPTe3MAggOnPBR8r
	 zYNiT2CtkdEJvADoY8j3EgbUl6I37dWhW/eW6KuE7IcO1Ogm8w+gCYISrBaZXH4Np+
	 vGbWorEbW3/c8KGEgsb+ZecT+6Bp+43DCmBpj3mh/EM79cDu3iGMMyUmtbUTcVdug0
	 wxoJKyUjnAhOkVZEkuPq79EpJrsvJf3NgtMqfjv0S5/X3gdCaenI4IYvkZMePoS7UN
	 lW1lu3kafXSX2XzRREWgCX+Ax2WItRA3tcrTD9BHnls4L1kLALeszfZrTCQqjw4BoR
	 wHO3FoWkRknUg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Niklas Cassel <cassel@kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/2] ata: libahci: Free the IRQs when activating a multi-IRQ host fails
Date: Tue, 10 Nov 2026 09:24:32 -0500
Message-ID: <20261110142342.1878224-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110142342.1878224-1-sashal@kernel.org>
References: <20261107054205-failed-6.1-34a4a34431ed@kernel.org>
 <20261110142342.1878224-1-sashal@kernel.org>
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
index 1211d46d2475b..2bfd82f3fee18 100644
--- a/drivers/ata/libahci.c
+++ b/drivers/ata/libahci.c
@@ -2636,11 +2636,33 @@ static int ahci_host_activate_multi_irqs(struct ata_host *host,
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

