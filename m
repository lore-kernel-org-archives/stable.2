Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794047365;
	b=yR7W/Zre66SVyTazBeOl6zIGEvTB9t6uZ0BE1upzoesaE7wkjNrP0W3W0KuEqeUeeLNl
	 N7bL18FtLXxpsXIr1u+WBpSoA7qjCDRw2kiV+8Ec7ZaaenPwXpiMTGu+yqrbzGQmE1m5f
	 voGP8hDq49RTUG5QTDrUJx00G2Cs4A23apNDE7XzlW7LiFx2hE4Df3GPCVSXAzM2tt1VJ
	 BWrbCXxxGNBj4WiQajrMNmnxfx7Ggne4VixzPXe8ev+yDXHUR41jnEbMqQpAfxUzlIty9
	 x0OEMreW0ee+gi4GTSOs1IVzTxYfIPasdqkQHdwQ1zaiDgAZZ0dcjAML2GKtCLZzshg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794047365;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=qXllremxHxmutz+prWCVP5e6LVUWqX779cmnY7TxPvg=;
	b=ouLm5KUs9BuxZQQWHWq25hc7lA9iVNokVsgAbLYiJK6rKkzMwfvuEQiK7kfIVXGYXNy9
	 Xe1hFUjoB51Eivd38uwUyqMrqEtOOqi/SzOH26hItQHXoIBwokwRL945K9jWQgHf8nLbP
	 BjdSzN94aa2dQriJQEjX9cM1/0YQ3NhHO+KtC0kNI+VdLeQJM+ofICnTNPEWIoYVf7wAs
	 lBVJLJsgDrZO6y5yylRBkUttCKrZX5owBcbTnRBfAx4VsVWLmhlzPMHiQ+/MqyUvCH79G
	 W8COlx8lKxbwbYMrf2S5bHEGMUNAOkVCSopbLfERWL/UmkkNlYw4eFDeg1HppF32W9A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MUoAYOhl;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1512606A33E
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MUoAYOhl
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C2121F0089F;
	Sat,  7 Nov 2026 10:29:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794047365;
	bh=qXllremxHxmutz+prWCVP5e6LVUWqX779cmnY7TxPvg=;
	h=From:To:Cc:Subject:Date;
	b=MUoAYOhliW0YN1hRsG6Uaf5EXdjfiVtTTDT2jS9e2cByIqtTytouyytupWEmOItLs
	 ctQQVZ4UesfveTlmIORSQ4EXl8V6TxPXLR6CjgDKACidjHGhf5iRdx+SXEadYZsGQh
	 GtZN+shGfAOvsY8s1k+DePxX7UQuX+t6rEZfsXtnoBXis2STgWJYEuXX/Rn9fLaW4u
	 U70+EvtfAbwxZVZgxMrzIIetlDWUut2xhQcIL9NtsMw3jwYPzxFP33WU0N/qgW9CE3
	 9sPkXA4FBve3T5kKktFhE0JJTOAlEinDMnI6Fzyjq3u8yI8Uhg8wR9lo92+4EpRmzO
	 OmVcRTEPWxOVQ==
From: Sasha Levin <sashal@kernel.org>
To: cassel@kernel.org,
	dlemoal@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] ata: libahci: Free the IRQs when activating a multi-IRQ host fails" failed to apply to 6.6-stable tree
Date: Sat,  7 Nov 2026 05:29:24 -0500
Message-ID: <20261107052924-failed-6.6-34a4a34431ed@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 34a4a34431ed81d85d14f8fb8035e5a25214ad39
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107052924-failed-6.6-34a4a34431ed@kernel.org' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 34a4a34431ed81d85d14f8fb8035e5a25214ad39 Mon Sep 17 00:00:00 2001
From: Niklas Cassel <cassel@kernel.org>
Date: Tue, 15 Sep 2026 10:41:30 +0200
Subject: [PATCH] ata: libahci: Free the IRQs when activating a multi-IRQ host
 fails

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
---
 drivers/ata/libahci.c | 26 ++++++++++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
index bea9a39dacedf..1290dd5401011 100644
--- a/drivers/ata/libahci.c
+++ b/drivers/ata/libahci.c
@@ -2724,11 +2724,33 @@ static int ahci_host_activate_multi_irqs(struct ata_host *host,
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




