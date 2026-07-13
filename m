Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFE6321146C
	for <stable@vger.kernel.org>; Mon, 13 Jul 2026 13:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783949205; cv=none; b=GDiWSZSVn+DlQfY6r3g0ly66oTRcsNYUNTXHkt3yRDSNmnaUu7DA2Z5PEHuR1EIiI5x/5YzLjPTCwZmWQdooeOFSEZd80fUvLGz/4td9FPZNlAgkb8A41lGeONlt+j9tlvMl8oRl2FK6+WVdmJcWNbEPz8oHO/v6c6HrdOZhPxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783949205; c=relaxed/simple;
	bh=wJ02PUtrm2tqvnsKbk5izCyKVi4jElqK5VwB2RZ5Tdc=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=MaJd4nLsX2TvxFn1Pw8EirDH6PiUJhCfR+P/CSrt6LPzkzLbi7QpMLwJofhOuUlJhhIZMK+DrR01NBdI5fgkU7QnKfJxxQ1BMY+bq4lXc3TgtAAghz8OVjnR90uQMn1a6mVEYarjHlo8b8dFTIpqHroGSz95t+wpn4anhm7H8cQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rVHMNRyL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rVHMNRyL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41EA41F000E9;
	Mon, 13 Jul 2026 13:26:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783949203;
	bh=geXtQBDXmGUH1T04uxYEecKvc7LcErlnMF1lKwVZ01M=;
	h=Subject:To:Cc:From:Date;
	b=rVHMNRyL9JTKRiy6vFSpNxQTwIrcUEbgUc+mqf8STCXHISVXrO1ctFnm7g95W7caP
	 VniEK6bqW/WvC51G7IPu1rwUmKCkRwe01Lt4MAQbN8Avp124o823yEnUFlDCEfTJVn
	 SOvPKoLxQK9fJ/IXaoXU/krz5sZzMUjHg+CcHt7o=
Subject: FAILED: patch "[PATCH] PCI: Skip Resizable BAR restore on read error" failed to apply to 6.12-stable tree
To: mnencia@kcore.it,bhelgaas@google.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 13 Jul 2026 15:23:58 +0200
Message-ID: <2026071358-dominoes-employee-70eb@gregkh>
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
git cherry-pick -x ee7471fe968d210939be9046089a924cd23c8c3b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026071358-dominoes-employee-70eb@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From ee7471fe968d210939be9046089a924cd23c8c3b Mon Sep 17 00:00:00 2001
From: Marco Nenciarini <mnencia@kcore.it>
Date: Fri, 17 Apr 2026 15:24:36 +0200
Subject: [PATCH] PCI: Skip Resizable BAR restore on read error

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

diff --git a/drivers/pci/rebar.c b/drivers/pci/rebar.c
index 39f8cf3b70d5..11965947c4cb 100644
--- a/drivers/pci/rebar.c
+++ b/drivers/pci/rebar.c
@@ -231,6 +231,9 @@ void pci_restore_rebar_state(struct pci_dev *pdev)
 		return;
 
 	pci_read_config_dword(pdev, pos + PCI_REBAR_CTRL, &ctrl);
+	if (PCI_POSSIBLE_ERROR(ctrl))
+		return;
+
 	nbars = FIELD_GET(PCI_REBAR_CTRL_NBAR_MASK, ctrl);
 
 	for (i = 0; i < nbars; i++, pos += 8) {
@@ -238,6 +241,9 @@ void pci_restore_rebar_state(struct pci_dev *pdev)
 		int bar_idx, size;
 
 		pci_read_config_dword(pdev, pos + PCI_REBAR_CTRL, &ctrl);
+		if (PCI_POSSIBLE_ERROR(ctrl))
+			return;
+
 		bar_idx = ctrl & PCI_REBAR_CTRL_BAR_IDX;
 		res = pci_resource_n(pdev, bar_idx);
 		size = pci_rebar_bytes_to_size(resource_size(res));

