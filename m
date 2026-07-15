Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75DAD1E5B68
	for <stable@vger.kernel.org>; Wed, 15 Jul 2026 00:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784074683; cv=none; b=C+njU2eD6i0dyRnnZ0c4tRLi4yjeZgyUvoJUkUGt7e/ps5i8+Ozwwhk4kFlFey+FgUHXyhZwkUzLrS+L8Le1RpMjbtU3j5f9E7MM8UcAziFfZjNdfn9Uk/a7ukIxHlYIrPnI0KV33KoSwFYzzsTQZDrOXX//PbfWJlPVZDPKtMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784074683; c=relaxed/simple;
	bh=lAlKAZPaU/kgZP97rXAB7lqeqfWIPIRXZ0tIu96uRbw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tPkYTiAC7qno3N3Y05/lF/hztdu9f4Bnr2+c0PrBDjcEvaA2zHXDnoNWOyaIcNyKA+QQmobkPezRB2FjK85I5AFuYRIQ78Olv7mJg45XAOHhJamhxXJGr5Y+tNCLTgpG+fxefQNr5awTftwt5DxHgt8oOB4+31QFjsvAb1iXjJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H0Dsw2Dl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H0Dsw2Dl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E33031F00A3E;
	Wed, 15 Jul 2026 00:18:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784074682;
	bh=rwFCscdxx1zTtymWK4XKX49skULgpl7IMt5Wxc3tnNI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=H0Dsw2Dll0G10t7fwKnp+CKhqd2tIXw0RXsXZOYtOEgUsoDFFi/wrWP3s8xO5yX9O
	 blFyA4z4RAY8MFhqd2zlKRr0kpKAsbIFjeGJ+A74mtDtK/TtYjxvzY6TcmYBGtwffz
	 g5B+XAru+J+iMlHRDXY7lRxZuuJ/DfN7kGUZX/3k4y7FrabHwvLc/QSYhE1UYvDR1U
	 LM+JFlCQlP4/ohaqeb6MmPM72FEdp4ms9wlLKVKthhNp4PZdqXB7mYkAZvH76aHUbQ
	 acJ8zlidfpCaGaSZtgwZ4Hp2hZhtwX+WNHJzNcZxnYui+4rFq6Ddp+5DMHdyU6v41A
	 kxg38Obhx20hQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Marco Nenciarini <mnencia@kcore.it>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 6/6] PCI: Skip Resizable BAR restore on read error
Date: Tue, 14 Jul 2026 20:17:56 -0400
Message-ID: <20260715001756.3783927-6-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260715001756.3783927-1-sashal@kernel.org>
References: <2026071305-gulp-reenter-fa22@gregkh>
 <20260715001756.3783927-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Marco Nenciarini <mnencia@kcore.it>

[ Upstream commit ee7471fe968d210939be9046089a924cd23c8c3b ]

pci_restore_rebar_state() uses the Resizable BAR Control register to decide
how many BARs to restore (nbars) and which BAR each iteration addresses
(bar_idx).

When a device does not respond, config reads typically return
PCI_ERROR_RESPONSE (~0).  Both fields are 3 bits wide, so nbars and bar_idx
both evaluate to 7, past the spec's valid ranges for both fields.
pci_resource_n() then returns an unrelated resource slot, whose size is
used to derive a nonsensical value written back to the Resizable BAR
Control register.

Bail out if any Resizable BAR Control read returns PCI_ERROR_RESPONSE. No
further BARs are touched, which is safe because a config read that returns
PCI_ERROR_RESPONSE indicates the device is unreachable and restoration is
pointless.

Fixes: d3252ace0bc6 ("PCI: Restore resized BAR state on resume")
Signed-off-by: Marco Nenciarini <mnencia@kcore.it>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/666cac19b5daa0ab0e0ab64454e76b4d24465dbd.1776429882.git.mnencia@kcore.it
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/rebar.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/pci/rebar.c b/drivers/pci/rebar.c
index 4373cd796ae99b..920ef3ab4bda35 100644
--- a/drivers/pci/rebar.c
+++ b/drivers/pci/rebar.c
@@ -131,6 +131,9 @@ void pci_restore_rebar_state(struct pci_dev *pdev)
 		return;
 
 	pci_read_config_dword(pdev, pos + PCI_REBAR_CTRL, &ctrl);
+	if (PCI_POSSIBLE_ERROR(ctrl))
+		return;
+
 	nbars = FIELD_GET(PCI_REBAR_CTRL_NBAR_MASK, ctrl);
 
 	for (i = 0; i < nbars; i++, pos += 8) {
@@ -138,6 +141,9 @@ void pci_restore_rebar_state(struct pci_dev *pdev)
 		int bar_idx, size;
 
 		pci_read_config_dword(pdev, pos + PCI_REBAR_CTRL, &ctrl);
+		if (PCI_POSSIBLE_ERROR(ctrl))
+			return;
+
 		bar_idx = ctrl & PCI_REBAR_CTRL_BAR_IDX;
 		res = pci_resource_n(pdev, bar_idx);
 		size = pci_rebar_bytes_to_size(resource_size(res));
-- 
2.53.0

