Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 373CB3242D4
	for <stable@vger.kernel.org>; Wed, 15 Jul 2026 02:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784083567; cv=none; b=h9lP6pACc0soH8IDLsgK5ux6jQHq8CV/+hahaSgtPl30LN3EbqYVssl5PTz0o60qO4nXi1NJJ4E/qk4nD6jBNBRqRqw8DPIra/UEbW/NyGe8ThSbKiyYPhW6ySeqQszzevD+B5Jm8sG8npaLzmSWvKG5Z/zyiEN/swizEpX38PU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784083567; c=relaxed/simple;
	bh=lAlKAZPaU/kgZP97rXAB7lqeqfWIPIRXZ0tIu96uRbw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WF3o5DmYX1gcfcT5gEqB3qboF/XaUahgB+FodRN+DKxkEqBxb4fmpShx43m8VOtH5vv4Wn7ThUzlWnhok3swoa2O6xoZI4OrFSduV0WrjSluAPlAANo2W82pOcB2KbIp0YwueKTmhc85G2gQodzt+dfetxIZ8dI1fa25dtHEJ14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C8vIa5p2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C8vIa5p2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E0841F00A3A;
	Wed, 15 Jul 2026 02:46:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784083566;
	bh=rwFCscdxx1zTtymWK4XKX49skULgpl7IMt5Wxc3tnNI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=C8vIa5p2NtTM3B389f7h2m0XD3deEAZxWgiQkwIbhP4X7lq09whK0qze8pFP763bh
	 HqNvKF9Dv0nDPJ9O8GGFDqx9Ig6ct5I5vHGUquEnoeA/T+W1zwQ9Qw7Z4vFnJ6kXYN
	 wt71YH2mHPmrvGHX3e7pLghAdOOuiks/2ShomAoZM+iaXM9MoFV+8E76GAuqJYD43L
	 EAKwyxRrMm6wquEnVu0PBfCMZ07BscR8x1ncE9GN3lx7YG1d90z9mbgL9fbrzF2Vi2
	 VAIWlmq1e2ZD4nkLw2YSqDuvKwvFQYrPpS3EdCJCKfoVUdsKm+liNhlzu5DEbXsQ2X
	 LixiMgNPix2Og==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Marco Nenciarini <mnencia@kcore.it>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 6/6] PCI: Skip Resizable BAR restore on read error
Date: Tue, 14 Jul 2026 22:45:59 -0400
Message-ID: <20260715024559.106836-6-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260715024559.106836-1-sashal@kernel.org>
References: <2026071309-opal-shaking-a4ea@gregkh>
 <20260715024559.106836-1-sashal@kernel.org>
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

