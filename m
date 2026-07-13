Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBD02376481
	for <stable@vger.kernel.org>; Mon, 13 Jul 2026 22:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783981591; cv=none; b=QI0iVdBwn3K/mF3151m7MSTxzuY41stEiM17JUISUNHmAZchis+GtihpvgzTPEhHlPlJ9wFVJziwK8MF4ZefILy0SaPv17uRCuYkuh5ryfucSaU5PrAAFDDC213nnkinBOV6CH2QjTFNwYBjFTfEpfnlnjnKOpRk+KeIgptzeis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783981591; c=relaxed/simple;
	bh=tpFHPCOrbm+C7CmObi1NIljMQC4evdgd8G+mppZW/Zo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cu3nPJ2X1wOq32Sozq0BjIRvJREZt/elqH5y0eijT0LpbINropt6DuzFvas6fb+Lj57sbg3HhGL4w9frpNVQnJIEVpXGWQT5XBW7ZYnHeKA1QgaTXnxfsQ49pzaGuyyxx9jFA4hl+w/iaQXeUYNm4CQ/Jp12XcavNZrWohDfZLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id C670C92009C; Tue, 14 Jul 2026 00:26:19 +0200 (CEST)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: stable@vger.kernel.org
Cc: "Maciej W. Rozycki" <macro@orcam.me.uk>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Alok Tiwari <alok.a.tiwari@oracle.com>
Subject: [PATCH 6.12.y] PCI: Always lift 2.5GT/s restriction in PCIe failed link retraining
Date: Mon, 13 Jul 2026 23:25:49 +0100
Message-Id: <20260713222549.28006-1-macro@orcam.me.uk>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <2026071351-deport-apply-58df@gregkh>
References: <2026071351-deport-apply-58df@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

commit 72780f7964684939d7d2f69c348876213b184484 upstream.

Discard Vendor:Device ID matching in the PCIe failed link retraining quirk
and ignore the link status for the removal of the 2.5GT/s speed clamp,
whether applied by the quirk itself or the firmware earlier on.  Revert to
the original target link speed if this final link retraining has failed.

This is so that link training noise in hot-plug scenarios does not make a
link remain clamped to the 2.5GT/s speed where an event race has led the
quirk to apply the speed clamp for one device, only to leave it in place
for a subsequent device to be plugged in.

Refer to the Link Capabilities register directly for the maximum link speed
determination so as to streamline backporting.

Fixes: a89c82249c37 ("PCI: Work around PCIe link training failures")
Signed-off-by: Maciej W. Rozycki <macro@orcam.me.uk>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Tested-by: Alok Tiwari <alok.a.tiwari@oracle.com>
Cc: stable@vger.kernel.org # v6.5+
Link: https://patch.msgid.link/alpine.DEB.2.21.2512080331530.49654@angie.orcam.me.uk
[ Update for missing PCIe link speed helpers for 6.12.y. ]
Signed-off-by: Maciej W. Rozycki <macro@orcam.me.uk>
---
 drivers/pci/quirks.c | 51 +++++++++++++++++---------------------------
 1 file changed, 20 insertions(+), 31 deletions(-)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 3d05ea35c536..9b2acf388f8a 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -68,11 +68,10 @@
  * Restrict the speed to 2.5GT/s then with the Target Link Speed field,
  * request a retrain and check the result.
  *
- * If this turns out successful and we know by the Vendor:Device ID it is
- * safe to do so, then lift the restriction, letting the devices negotiate
- * a higher speed.  Also check for a similar 2.5GT/s speed restriction the
- * firmware may have already arranged and lift it with ports that already
- * report their data link being up.
+ * If this turns out successful, or where a 2.5GT/s speed restriction has
+ * been previously arranged by the firmware and the port reports its link
+ * already being up, lift the restriction, in a hope it is safe to do so,
+ * letting the devices negotiate a higher speed.
  *
  * Otherwise revert the speed to the original setting and request a retrain
  * again to remove any residual state, ignoring the result as it's supposed
@@ -83,12 +82,9 @@
  */
 int pcie_failed_link_retrain(struct pci_dev *dev)
 {
-	static const struct pci_device_id ids[] = {
-		{ PCI_VDEVICE(ASMEDIA, 0x2824) }, /* ASMedia ASM2824 */
-		{}
-	};
-	u16 lnksta, lnkctl2;
+	u16 lnksta, lnkctl2, oldlnkctl2;
 	int ret = -ENOTTY;
+	u32 lnkcap;
 
 	if (!pci_is_pcie(dev) || !pcie_downstream_port(dev) ||
 	    !pcie_cap_has_lnkctl2(dev) || !dev->link_active_reporting)
@@ -96,10 +92,9 @@ int pcie_failed_link_retrain(struct pci_dev *dev)
 
 	pcie_capability_read_word(dev, PCI_EXP_LNKCTL2, &lnkctl2);
 	pcie_capability_read_word(dev, PCI_EXP_LNKSTA, &lnksta);
+	oldlnkctl2 = lnkctl2;
 	if ((lnksta & (PCI_EXP_LNKSTA_LBMS | PCI_EXP_LNKSTA_DLLLA)) ==
 	    PCI_EXP_LNKSTA_LBMS) {
-		u16 oldlnkctl2 = lnkctl2;
-
 		pci_info(dev, "broken device, retraining non-functional downstream link at 2.5GT/s\n");
 
 		lnkctl2 &= ~PCI_EXP_LNKCTL2_TLS;
@@ -107,35 +102,29 @@ int pcie_failed_link_retrain(struct pci_dev *dev)
 		pcie_capability_write_word(dev, PCI_EXP_LNKCTL2, lnkctl2);
 
 		ret = pcie_retrain_link(dev, false);
-		if (ret) {
-			pci_info(dev, "retraining failed\n");
-			pcie_capability_write_word(dev, PCI_EXP_LNKCTL2,
-						   oldlnkctl2);
-			pcie_retrain_link(dev, true);
-			return ret;
-		}
-
-		pcie_capability_read_word(dev, PCI_EXP_LNKSTA, &lnksta);
+		if (ret)
+			goto err;
 	}
 
-	if ((lnksta & PCI_EXP_LNKSTA_DLLLA) &&
-	    (lnkctl2 & PCI_EXP_LNKCTL2_TLS) == PCI_EXP_LNKCTL2_TLS_2_5GT &&
-	    pci_match_id(ids, dev)) {
-		u32 lnkcap;
-
+	pcie_capability_read_dword(dev, PCI_EXP_LNKCAP, &lnkcap);
+	if ((lnkctl2 & PCI_EXP_LNKCTL2_TLS) == PCI_EXP_LNKCTL2_TLS_2_5GT &&
+	    (lnkcap & PCI_EXP_LNKCAP_SLS) != PCI_EXP_LNKCAP_SLS_2_5GB) {
 		pci_info(dev, "removing 2.5GT/s downstream link speed restriction\n");
-		pcie_capability_read_dword(dev, PCI_EXP_LNKCAP, &lnkcap);
 		lnkctl2 &= ~PCI_EXP_LNKCTL2_TLS;
 		lnkctl2 |= lnkcap & PCI_EXP_LNKCAP_SLS;
 		pcie_capability_write_word(dev, PCI_EXP_LNKCTL2, lnkctl2);
 
 		ret = pcie_retrain_link(dev, false);
-		if (ret) {
-			pci_info(dev, "retraining failed\n");
-			return ret;
-		}
+		if (ret)
+			goto err;
 	}
 
+	return ret;
+err:
+	pci_info(dev, "retraining failed\n");
+	pcie_capability_write_word(dev, PCI_EXP_LNKCTL2, oldlnkctl2);
+
+	pcie_retrain_link(dev, true);
 	return ret;
 }
 
-- 
2.20.1

