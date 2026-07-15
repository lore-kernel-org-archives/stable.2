Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AF683B2D04
	for <stable@vger.kernel.org>; Wed, 15 Jul 2026 16:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784133151; cv=none; b=p78rs89AubvuZ+LqGugON3WCc9CJA+7OO7sEN5RwVEnn6+Z/SRqJirju9J6Va1wliFsRpng57KCjd6Yej06S1R9lRQCnGwPSNkf4tmqybCUg/1eA/YCUtdL/lNksXPynlE6y+aQctewMlGqkRp2vHRqh9bbF4Jg2X2ZEXrhdBfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784133151; c=relaxed/simple;
	bh=qTXwCLEqv/IQ5hFQ+ddwAvb3/4aF1OqpZeppw0vcnV4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ru4PtLTq1R8cuq2HFcIjhZHC0tuApsqH1B6FjgPVyWuhTXfTl1uTZfcGN4/7tbaaFACoGRfsOFPfEHA+YL58HvTaPR1mUPbxDEmLY/NWXGEjwg99iEItIiOq9vYDepkJv+YhCLbQw9Xtx5YfnkFKsrIHCx3yxQ6rEf4b7U7spAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KEgDE58R; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KEgDE58R"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E29BC1F00A3E;
	Wed, 15 Jul 2026 16:32:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784133150;
	bh=Gi5yX5BkgxDAu8wqQA3uIgWMaOdkDsiJ24p1mBwTl1w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KEgDE58Rngg0d6EXq+bEo244gXS9BF2DGlNsT9Uf9kvRGfHkyxNuqdPe9e8KXGdXE
	 dOYM8gYo8qxafbE+xJChdqLQBkz8voqCOErSC8WXLSq2fXW8xTdxN7ZcdcTG+/zSmX
	 UsyZzBve3ZwOKxpgzBnVdW+0yWW7As3Nb3Y9nel+EPXfEWrOCufhMz6K7/Ukq+QV3L
	 G3kAKUpXT0yOHvPcpIfu4j8l5vO6qDx/dXrgBjFdAJ75/n0D2uslCC2uprw823JlW3
	 Vtx0kJNpoHTJYecPoUt1D747zcXh9PESXvR8x8+Zd4FsY3lnalEUNmuj3p/ml0SI1q
	 88Ki5WvKazbWg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Marco Nenciarini <mnencia@kcore.it>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 6/6] PCI: Skip Resizable BAR restore on read error
Date: Wed, 15 Jul 2026 12:32:23 -0400
Message-ID: <20260715163223.952417-6-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260715163223.952417-1-sashal@kernel.org>
References: <2026071318-kettle-cringe-5d1a@gregkh>
 <20260715163223.952417-1-sashal@kernel.org>
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
index ec449374291020..f0d3217841c0cf 100644
--- a/drivers/pci/rebar.c
+++ b/drivers/pci/rebar.c
@@ -130,6 +130,9 @@ void pci_restore_rebar_state(struct pci_dev *pdev)
 		return;
 
 	pci_read_config_dword(pdev, pos + PCI_REBAR_CTRL, &ctrl);
+	if (PCI_POSSIBLE_ERROR(ctrl))
+		return;
+
 	nbars = FIELD_GET(PCI_REBAR_CTRL_NBAR_MASK, ctrl);
 
 	for (i = 0; i < nbars; i++, pos += 8) {
@@ -137,6 +140,9 @@ void pci_restore_rebar_state(struct pci_dev *pdev)
 		int bar_idx, size;
 
 		pci_read_config_dword(pdev, pos + PCI_REBAR_CTRL, &ctrl);
+		if (PCI_POSSIBLE_ERROR(ctrl))
+			return;
+
 		bar_idx = ctrl & PCI_REBAR_CTRL_BAR_IDX;
 		res = pdev->resource + bar_idx;
 		size = ilog2(resource_size(res)) - 20;
-- 
2.53.0

