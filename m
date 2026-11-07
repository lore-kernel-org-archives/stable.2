Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794050156;
	b=jnYm29ebTeIRJa6cbYxU0DS6ND1mZOJkJ8NjZy91FBA5sT0xz/2uf4dIb1uhI+xH409L
	 SCIJv18fBqLC6ScdCAIyWZHpNu3M1xmQnN2LFaUs7snpgpaBY0u8rXVP1wkKHCR1tBfR4
	 fu1ZwGWNyhMKCYE9vef7VtGk52hEEicDkJ7jWC3kBTrDvTaaTMpwyNb4KPGPYCQRF6xmL
	 +OQDSASFl1MWYobha9s8VOX/Cay1Q9/KyVy0928llnHzZ+33HV/Tyue0sEU2id45TCqcs
	 LdDXDIxj5fFxyMatSDw6TxhxR9JGGrRFwa+WO6vI6AuBwrPVnXrFm1MDtD1L/t8rXWA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794050156;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=Q+jPrrWUSEcpIgUXb6MJkTkcQXWloAETqsa3yXYTn3c=;
	b=lU6ua5e8LtGhHond11O6EOGUbqHt1zJWAPw7frAaZ21z+eiwqfZgQkAFPZ35+FxTi2dp
	 viuAEyrH+jE1YgupDDXF9qamFa/Ave3fEkHMbb+QYLb5TT3QSOel7O/kfmjVpDbECXM8D
	 hHZHbhUubrlr/MIsQmyC9QNB63gPbAqgdX+ats64oyItD68SGnmnBF2v0UgOp4lQA+sfE
	 r31KoVDef62rvnp1fsdwZrTphYUCTWq/NM6CXfx+liEDlk8FXV7u56JcMJ98ES5xmiUgW
	 5inDRIox3O6t2Ugl+A9jOyBZoLXaXBEIX1neNZ7PJvvgNGQWzeJSS49rHi8uGJePlBQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SZM6pKss;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90E66606A32F
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SZM6pKss
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5FB11F0089F;
	Sat,  7 Nov 2026 11:15:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794050156;
	bh=Q+jPrrWUSEcpIgUXb6MJkTkcQXWloAETqsa3yXYTn3c=;
	h=From:To:Cc:Subject:Date;
	b=SZM6pKssgYIDnUsy2O84EN9HcTl4qmnpLY2t6C5+znjyksGce/gbvQaV8dt1xUMWY
	 3F+MbIVQQNVzBmp9e5y8shtE7Yi6o69/HB7xvtty45uaX4qMZ8qooJTQQq2ImZkwBa
	 rNom7lI6SDdinkB7+YqMO7cA51aZq22WLsQXvDlH8QYWDWWLnuyiIsUowK4zNqHG0V
	 5zUlYKKIt8+PvEGubLc9EsE7wvNc4nVw3K6qwgnyem6ifBoNkU+peaD6UpUUjg3Zkw
	 rqfKcwEcOT3Nqm5KvwGtMmp/O8pAQOnBYr4EOjmKqrp2Wsh4P97/qswxhIJQrICMRM
	 pPPWdd1Bie59g==
From: Sasha Levin <sashal@kernel.org>
To: cassel@kernel.org,
	dlemoal@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] ata: libahci: Free the IRQs when activating a multi-IRQ host fails" failed to apply to 5.10-stable tree
Date: Sat,  7 Nov 2026 06:15:54 -0500
Message-ID: <20261107061554-failed-5.10-34a4a34431ed@kernel.org>
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

The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 34a4a34431ed81d85d14f8fb8035e5a25214ad39
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107061554-failed-5.10-34a4a34431ed@kernel.org' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

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




