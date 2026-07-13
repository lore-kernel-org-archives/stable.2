Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 367DB42669A
	for <stable@vger.kernel.org>; Mon, 13 Jul 2026 13:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783949173; cv=none; b=mn+t0UMjEzupnFItzyO3j8d7/y1Yi2GfCBpkw4vKGLB2gUZULqXNrsOULKEuSAr6KyLdhGu8iH2Z4aSa1wQGMBlbQKccmbdh0B8GxAT5rv9dWF08ZhyijeY7vCovlaVEZBNmYMiweZVGVS0aGouMa/4BJ8yZxYLkSnRnMIDhtjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783949173; c=relaxed/simple;
	bh=DWiklWQHLpvN2oJe340MiituklyrmQrEz4VLQ039maM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=rF3IIIsfvvQ5VqRvNM7ogEYvtGjNXxXNeNHOeMvNL7CsO4Pb0Me1kE/lcqHPyMe94ciB0n6TYSCMVY20Rz2lHD3SGA6VBAuggvnYxR4RDtYqU3DRdBFKWBXrh5GP5oowfIMNr1Ii/xiVdgt9siitaEsbjzvnOuuP10IxGP2Lu8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=upJHmKfL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="upJHmKfL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90F861F000E9;
	Mon, 13 Jul 2026 13:26:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783949172;
	bh=VgdnINSIY75m3CS0qoob348Fgop/7sWIB4Neh+gLYEo=;
	h=Subject:To:Cc:From:Date;
	b=upJHmKfLp82w3Wnbl7lOX9YEfx+m1ElsEF51ilHHX1+tsYrgOnTMYkYnbU/LKhvli
	 tTHoXcYKY0Ammh/gA1NweeDMoNd+MFQZBAnkd9i3pXGI08ptWWby+3SK3Bqjr+RBJB
	 7/1+MySiF54hlNeb8+zuT697TdnU2+Jkiu87gxZ0=
Subject: FAILED: patch "[PATCH] PCI: Always lift 2.5GT/s restriction in PCIe failed link" failed to apply to 6.12-stable tree
To: macro@orcam.me.uk,alok.a.tiwari@oracle.com,bhelgaas@google.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 13 Jul 2026 15:20:51 +0200
Message-ID: <2026071351-deport-apply-58df@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 72780f7964684939d7d2f69c348876213b184484
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026071351-deport-apply-58df@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 72780f7964684939d7d2f69c348876213b184484 Mon Sep 17 00:00:00 2001
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
Date: Mon, 8 Dec 2025 19:24:29 +0000
Subject: [PATCH] PCI: Always lift 2.5GT/s restriction in PCIe failed link
 retraining

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

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index caaed1a01dc0..dd0025d3914e 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -80,11 +80,10 @@ static bool pcie_lbms_seen(struct pci_dev *dev, u16 lnksta)
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
@@ -95,51 +94,37 @@ static bool pcie_lbms_seen(struct pci_dev *dev, u16 lnksta)
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
 		return ret;
 
 	pcie_capability_read_word(dev, PCI_EXP_LNKSTA, &lnksta);
+	pcie_capability_read_word(dev, PCI_EXP_LNKCTL2, &oldlnkctl2);
 	if (!(lnksta & PCI_EXP_LNKSTA_DLLLA) && pcie_lbms_seen(dev, lnksta)) {
-		u16 oldlnkctl2;
-
 		pci_info(dev, "broken device, retraining non-functional downstream link at 2.5GT/s\n");
-
-		pcie_capability_read_word(dev, PCI_EXP_LNKCTL2, &oldlnkctl2);
 		ret = pcie_set_target_speed(dev, PCIE_SPEED_2_5GT, false);
-		if (ret) {
-			pci_info(dev, "retraining failed\n");
-			pcie_set_target_speed(dev, PCIE_LNKCTL2_TLS2SPEED(oldlnkctl2),
-					      true);
-			return ret;
-		}
-
-		pcie_capability_read_word(dev, PCI_EXP_LNKSTA, &lnksta);
+		if (ret)
+			goto err;
 	}
 
 	pcie_capability_read_word(dev, PCI_EXP_LNKCTL2, &lnkctl2);
-
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
 		ret = pcie_set_target_speed(dev, PCIE_LNKCAP_SLS2SPEED(lnkcap), false);
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
+	pcie_set_target_speed(dev, PCIE_LNKCTL2_TLS2SPEED(oldlnkctl2), true);
 	return ret;
 }
 

