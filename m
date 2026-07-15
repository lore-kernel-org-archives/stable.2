Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28D9D41A903
	for <stable@vger.kernel.org>; Wed, 15 Jul 2026 11:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784114186; cv=none; b=J8PWfGLEvehO04N0uRkf7mXn3Fgj5KjDz0tzd6WiLjF11b277rhV21q8dgYRIgWg2ZKmc6hqpD2YCWHTTCWcCFNod14o+FZCzlxvPn8Etae0m//VKv3yjidHaFp9qebZg9cRmzHmr7uq4JNnCSeSzymyh3jWo/+LkjniCWhKl9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784114186; c=relaxed/simple;
	bh=8au4cYz3SjqaNkdSFgEgRmD7D8xS1kQVhbYS0wI2adA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DsMqQh3RHfdyKeW+ghF6Rs7ODXEB60fBkBkrTqwGquigVYnLcP82DB12vwqjxhYbBIbuYZU/fAN+7XmNmCaaiBYF551Z6CfRHW7nLkXECO9h1PqAP8TskQGAASfVyy/Y50xx37bNG0UW2fjItLDJtCS5sGU6EXaLAwqMhv33P4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bvvI90HZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bvvI90HZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90A031F000E9;
	Wed, 15 Jul 2026 11:16:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784114185;
	bh=AXA9EnA2jvPUUM7HKiFzOIAT6uUlV/mN6uJt3mHalnM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bvvI90HZHS8AsBVxwLx/FPsCX8OPigWUWPGroiJsDZkHlGnFggAfabj9Yr6Un6Ycd
	 JWHl2IHFJfxfTIeN4eUbK9U9okzJ/SOe5JwTS10PrWz1D78OwR25UY6I1y8/v4YTAs
	 UlRiyaZz4Ctd3fgO7iOhWrQk5wRCq2hyQQ1LhuoQojA/M8qCHrLiEbA9s8JjbW2bcK
	 gTcPjlZL9x1+kkemBU/eXO8bWaSkW3GsRrD5fAMSU4RuTXBsjHvFm7nwujwNLJP3zX
	 PhEu8yXHpT+55TRlp1OnVBYSVVBi2aC0di/vD6zhUkk7IKlHO0uquv0YA7AN4aCzdB
	 9hTI9jThg0wew==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Marco Nenciarini <mnencia@kcore.it>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 6/6] PCI: Skip Resizable BAR restore on read error
Date: Wed, 15 Jul 2026 07:16:18 -0400
Message-ID: <20260715111618.647249-6-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260715111618.647249-1-sashal@kernel.org>
References: <2026071314-tableware-flashback-79cc@gregkh>
 <20260715111618.647249-1-sashal@kernel.org>
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
index a10d264a7c77ea..02ad0ed8311c4a 100644
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
 		res = pdev->resource + bar_idx;
 		size = pci_rebar_bytes_to_size(resource_size(res));
-- 
2.53.0

