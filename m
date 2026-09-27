Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD153378D8E;
	Sun, 27 Sep 2026 10:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790506634; cv=none; b=GCTxwn3jl2xiaBnJK1o5RM95fKq6s604SrdeEw/Zr/gOTDCubyMTVVk2+HDzsbnaSnYsFju2Ib74qsaGgLD9rjgn1oKcj26CzBHimXR0tFN9WND67Euh1HOCeTzncEgtqf88r6lj+HHnbbH26ipa7vYwoOlNlMjdlqL9TzNnNVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790506634; c=relaxed/simple;
	bh=nQaan9GqXEh5h/EtBJ17HDw07kmieNsdSfNSHHUsLKM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Lr8/X4B2DCNs9vSRw45H32InyeeRgrLDHMRLclS3QtYmuRlOCaXg90crrejGcbpe1Vrj9FMOQFsEElTG/ZHMo9NILVc3w/iP2OO7x/wuPaXOCP0N33mMMi0yOyJn/JSPi+O87LSQ2aLal+yveVH9VyM+ePPn6UAf7EvF48XQwuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ty1OgWa+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ty1OgWa+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 649281F000FF;
	Sun, 27 Sep 2026 10:57:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790506632;
	bh=ih/TnveXuF6N00aChGuP6/N3KCo6u2f/MIgB9ZZ2AVI=;
	h=From:To:Cc:Subject:Date;
	b=Ty1OgWa+Jp2jMU43fIL5mnkGbdTQZ9ByFlykWjQXHCKD9RIvOQZqLbdOSTVNc6+qp
	 27Qr/YxCnHoKaA7joda5LB8Q0MKYVWJ+gQZmZsBugXYntc3+jG+lstEVmXHDeda319
	 dif4sH3s7qSK/ippawQvCuB/Y+ZVQmWyJ5uMAg1KbAalLg9sWI7nERVbGyzosBozzJ
	 cHBtlNORjkZFs/qbbA7mTjP0DgmEIbLR4g98XSjV/MQvl6v//agp8uoG52zTyDZ0k/
	 FhHJoJVVasXojyNU606SlnLxWjTRqa9EC+eW5l4QHn8FR/a+pIn/6NkrlTB9nvGM/B
	 BLB/WYaDNyLNw==
From: Imre Kaloz <kaloz@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org
Cc: Andreas Larsson <andreas@gaisler.com>,
	sparclinux@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] PCI: Avoid D3 on PLX PEX 8532/8533/8548 downstream ports
Date: Sun, 27 Sep 2026 12:56:09 +0200
Message-ID: <20260927105609.8813-1-kaloz@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Runtime PM suspends an idle downstream port of a PLX/Broadcom PEX
8532/8533/8548 switch to D3hot, but that takes the whole switch down
with it: any device behind another port of the same switch then
faults with a fatal bus error on its next access, e.g. mptsas probe
on a Sun Ultra 45.

This surfaced on sparc64 once commit a5fb3ff63287 ("PCI: Allow PCI
bridges to go to D3Hot on all non-x86") let bridges enter D3hot. Keep
these downstream ports out of D3 by setting PCI_DEV_FLAGS_NO_D3.

Fixes: a5fb3ff63287 ("PCI: Allow PCI bridges to go to D3Hot on all non-x86")
Cc: stable@vger.kernel.org
Signed-off-by: Imre Kaloz <kaloz@kernel.org>
---
 drivers/pci/quirks.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index de9bbccda21f..a3c9250182a6 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -2381,6 +2381,24 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_PLX, PCI_DEVICE_ID_PLX_9050,
 DECLARE_PCI_FIXUP_HEADER(0x1402, 0x2000, quirk_plx_pci9050);
 DECLARE_PCI_FIXUP_HEADER(0x1402, 0x2600, quirk_plx_pci9050);
 
+/*
+ * An idle downstream port of a PLX/Broadcom PEX 8532/8533/8548 switch
+ * autosuspends into D3hot, and that takes the whole switch down with
+ * it -- any device behind another port of the same switch then sees a
+ * fatal, non-recoverable bus fault on its next access. Keep these
+ * ports out of D3 entirely.
+ */
+static void quirk_plx_pex_no_d3(struct pci_dev *dev)
+{
+	if (pci_pcie_type(dev) == PCI_EXP_TYPE_DOWNSTREAM) {
+		dev->dev_flags |= PCI_DEV_FLAGS_NO_D3;
+		pci_info(dev, "avoiding D3 on this downstream port\n");
+	}
+}
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_PLX, 0x8532, quirk_plx_pex_no_d3);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_PLX, 0x8533, quirk_plx_pex_no_d3);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_PLX, 0x8548, quirk_plx_pex_no_d3);
+
 static void quirk_netmos(struct pci_dev *dev)
 {
 	unsigned int num_parallel = (dev->subsystem_device & 0xf0) >> 4;

base-commit: fe2ec83746e501645709761605c2464a44fd2929
-- 
2.47.3

