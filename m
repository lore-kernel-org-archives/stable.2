Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794321276;
	b=pICjsXvFlB+19ARgYxrt3pIvzwlQRIDte3Vf9XE/O3eniC3cDI3RN4mImyt/8VlVn3e9
	 wt7XzaFcoTHv8rw5OS674zuephjQhVbv1oQXK/soaU5Yv6qIGOr9Z8kRvwBNkhegme+1Z
	 8HN5gSt7S+KOqb1eqlUuOZlIkQ3GQ8s43q+MX6mC8QAhF5qFgeyEzTUWCkY53jEU/4AiQ
	 qc76sFpeIy6jAkF6RSd2Id9V9JI7zIzcURHwUD/GNfocQU8m60mBmkSmmdKliuHIQl0JX
	 yYtb80+YrE+HVpA+PrLtavt44BQFTel1QcUKP4IdmP7aAeKSKDNeHM/9VCM6l31DP2Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794321276;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=KPSeGVzxp5KxZ1sAH46+6kU30fspga9Hakg5cc7doYA=;
	b=04iY3bQpov7ndsrkM5XH5hyVStoN3sMPam96PEBuC2QIKXFkHqejC97yj1+75DzOkh3+
	 J4d7i8GY6/djrG0UKdM3V7ee2uc1EiAqvOGOBhZfUl4tscgCAp6HfO1c/8p5JEf3H7Sd2
	 DgBbQbBaZU24ZsDaKEklaaEVO/qkv+MmCSUsdNg7EnVrbJBcQlWKJg5OZFjwz2ekWAcp1
	 Nn8mSSFw1ZPPD9Pbzj71qkml19P4V+VZ/a+pN15ftelr4Ba5jpJGhFsx7uJcPvJTPBuPx
	 hK5wQuzzbVGV+XzYKKaeE4dRvHvHPNVIEIz4YwkUgw+Pc+DsnZxuY16IurM6lXuwsiA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="SFt5LL/1";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0A47606A337
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 14:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SFt5LL/1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47E1C1F008A4;
	Tue, 10 Nov 2026 14:34:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794321275;
	bh=KPSeGVzxp5KxZ1sAH46+6kU30fspga9Hakg5cc7doYA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SFt5LL/1SVZTc7uTRB8Dp6zMRsXFvpCranNjfBh6QGzTjnQGxF1qQTkYgufqUiGLc
	 UbR8Nk9p7RsiO5a8sNQtYRZEwJuImTrbHETbIr8lJIStaO+wud6r1JV/CnPZQP0DgF
	 4DOR+tOw5+uHrRj6v1oHXAF2fs2hFbj+UB52pwE30a0JOstDL4M/YhP/zFiTeeiuF5
	 cAiSo5x1Zro1gA89/UcPpI4sczUeUqzR2V0+/toZhhP0tmRX8G213UvKZ++Ws86d7o
	 YJctwQWaEH9dnHhcOzSdQ4EY/uJhVR/xNNlnoyKZ6twEOazv+kbXEK4Y3nEkx8BYgX
	 +7nrO/fPxkVBw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Niklas Cassel <cassel@kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/2] ata: libahci: Free the IRQs when activating a multi-IRQ host fails
Date: Tue, 10 Nov 2026 09:34:33 -0500
Message-ID: <20261110143342.1911123-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110143342.1911123-1-sashal@kernel.org>
References: <20261107055900-failed-5.15-34a4a34431ed@kernel.org>
 <20261110143342.1911123-1-sashal@kernel.org>
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
index a30e17265e873..29ae34dd428d7 100644
--- a/drivers/ata/libahci.c
+++ b/drivers/ata/libahci.c
@@ -2593,11 +2593,33 @@ static int ahci_host_activate_multi_irqs(struct ata_host *host,
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

