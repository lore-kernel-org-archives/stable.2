Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB85D41D65C
	for <stable@vger.kernel.org>; Tue, 14 Jul 2026 20:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784059370; cv=none; b=lfLKQLH2J5mAOA3wMFYcPkUiK+qRNRHqhCDEgxL31MTLw6Do5uQDY5B16/tyc/JDx5S0YoUfvt63DaG1H+4I4B03u10Dzvvx9zlnriuVQGhyrhwrPA9Hpi26Vyv0mQeXDnKJWym8Qm7xNuiBzlxxYx5UGwlM/OhmEY5looJhNiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784059370; c=relaxed/simple;
	bh=EF9SS4euiyIL8QdhSyRwqFvLZytctp4tkqFUBfbGE4k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PJuchLWDySZaYJu2DN8WxnY0j1kliZutX3w5Euhk6UPJ3EkKQ6MrvhFjs9onwBe8gqQ3aD0DeMq/aedf7hRGaaIlavbbb5UG0yKKKtj7F3efJt1LPKRx3cr16N4in5EkXGrQS1kJFVJMBgmIC0v9GG5ZS/VgaNYcLmAO+2TF+CY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dby0inz+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dby0inz+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43A1A1F00ADE;
	Tue, 14 Jul 2026 20:02:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784059364;
	bh=kd2+vhDqDPyS7bkbvDgLomhpqVH8WydyWdB3lRFsUr8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dby0inz+QI9uyIzKqDfdWR9lyN7MM6Ijmcpq8STcgQ0QXqVsGDYKRcGyQD0qjYZA0
	 HG7a95CCPOm4BdeSpobz2zMayQausD23lTweeNZhhwSSaSxS3XVrrb1EaTIiFPC99D
	 uioy4iDcqnEnRVZ/QY2plyQdhrNCg9kyfjykKQQpTepcxcYkeRN6UPZabPIWGPw8Q5
	 edoPkm9BO4lL3kJeC+JVEFRlR1qVBXug7ZeVBmbiOb8s1iIfpCqBCJKQ9lztqOllUe
	 X/yojBItLvcTiG5mC1RLmcxAxCc3aAOAtz+Yc2vVJOitdJtuCdNDg2icAaqY+87w1t
	 /U2SMEKzWGIpA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Marco Nenciarini <mnencia@kcore.it>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 8/8] PCI: Skip Resizable BAR restore on read error
Date: Tue, 14 Jul 2026 16:02:36 -0400
Message-ID: <20260714200236.3153778-8-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260714200236.3153778-1-sashal@kernel.org>
References: <2026071350-unfold-lather-d66a@gregkh>
 <20260714200236.3153778-1-sashal@kernel.org>
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
index f6ed7e4893a773..22853cf538fc11 100644
--- a/drivers/pci/rebar.c
+++ b/drivers/pci/rebar.c
@@ -145,6 +145,9 @@ void pci_restore_rebar_state(struct pci_dev *pdev)
 		return;
 
 	pci_read_config_dword(pdev, pos + PCI_REBAR_CTRL, &ctrl);
+	if (PCI_POSSIBLE_ERROR(ctrl))
+		return;
+
 	nbars = FIELD_GET(PCI_REBAR_CTRL_NBAR_MASK, ctrl);
 
 	for (i = 0; i < nbars; i++, pos += 8) {
@@ -152,6 +155,9 @@ void pci_restore_rebar_state(struct pci_dev *pdev)
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

