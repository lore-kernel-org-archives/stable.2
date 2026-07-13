Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0432B3D412C
	for <stable@vger.kernel.org>; Mon, 13 Jul 2026 13:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783949293; cv=none; b=cHC449ggGWr+GZvX9SOn/KBY2Cd7ZZs8dG1PvjP8fOhbTcN4Yx3aKpKp3ID6rYBLZGcER1wV9h038St30/o3rNOrQVIR6ooeZZnZ1XZt2nUqLxYK/5bcI1X0/+UEET/DC07Xk3Nll7KT9ZzsmPoLpq/DLy+Yluk7stSUOidNKQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783949293; c=relaxed/simple;
	bh=z3GXtKvTV7WZJImDTs9i4VZ/KKEo7D2gej+1vAM+i0k=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=fxW8Eaj5VImoUHmBdriLselDMu3ibVwPiI3WNSwVkQlDDnq3KWcoF5bZ4qGglLXCL7WdPLlDZxWCowd56GHGaAtVo1U4jPdFFf/BNBaZA96rBSB+sXGz0ZF0tCtCy2l+H0Q4cJFHYVboOvfpSMfvq9Z3p8xJxV7GN/zsJLl54yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ofT4Yhen; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ofT4Yhen"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BDFF1F000E9;
	Mon, 13 Jul 2026 13:28:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783949291;
	bh=Intam0ISFo/L+gNzdOejwW1/yOAtnH4YOH+K/Ag9T0c=;
	h=Subject:To:Cc:From:Date;
	b=ofT4Yhen8k8+47eaC/at7bAUkH6XBtpC3bjjv0fM1aMwGy0KhJxGlGaGlSMTjrqKu
	 D4UyXlf0xXvUVF1uJ8ugnk8hm4Dzsvb7Nt7nKaIVGyjD5ZzXUiPwm4Y3b05Lv/eK8B
	 iDARVdyqtTrb89nPbHNx6Hfd+KN5nCoHib4/K5D0=
Subject: FAILED: patch "[PATCH] PCI: Skip Resizable BAR restore on read error" failed to apply to 5.10-stable tree
To: mnencia@kcore.it,bhelgaas@google.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 13 Jul 2026 15:24:18 +0200
Message-ID: <2026071318-kettle-cringe-5d1a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x ee7471fe968d210939be9046089a924cd23c8c3b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026071318-kettle-cringe-5d1a@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

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

