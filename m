Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3230433711D
	for <stable@vger.kernel.org>; Mon, 15 Jun 2026 14:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781534708; cv=none; b=TOnqmsfJ464Ru77AbTRyJvZQNBtaTAm7LdVeBoWnwE4HbTDwSDZUxLGLzQ0qic6XfENfAtM0Lcwwr++ZDaF2HS9lg3tWr4Md6yBHiwr3KFliR3qa8+Jdrh0ekC+LrcV4Lcox1qTYWO0w+6IhazEjKuIATRcIIxlO8oK46S6EESc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781534708; c=relaxed/simple;
	bh=Hb+1aM1QgQOAf/rAwtbvoZAkfuB3J8c1OCRmCO3z3wg=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Wwrryk23v3KsIppaN0x+fiLeftzSYjbCGBaVnvJUGDPUbrwuh+G/p9V4YEou6AG+epSJS1i+C8y000Vwa70E9MqfOzKJugUP/tlJ/t4ZwBcX7JfDDykKOOgh+TSNppF2jW7gu8DZF3/x98GITLk7/d55N/VufcpYLLEm+Xvht+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=aTwGM1E2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="aTwGM1E2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03CDB1F000E9;
	Mon, 15 Jun 2026 14:45:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781534706;
	bh=+oqflPb66iireci+kyNdWzR2ITmO87xPgyejKxWBawE=;
	h=Subject:To:Cc:From:Date;
	b=aTwGM1E2j2Y497WlIwLZSd2fhJjIYcgpzj9mQudhi8VlrqroqO2uShqvyXoOKfpEo
	 sGdesxOVwgK0rPcgCCIOSZfrve258HJK6ryb8upxz8ozlnjSkX9ZOSGoTdnIxwpD1c
	 F3htSjvJdSnFPNvoUqvHS4OZSNzP/tTSnLxeOuiI=
Subject: FAILED: patch "[PATCH] bnxt_en: Fix NULL pointer dereference" failed to apply to 5.10-stable tree
To: kyle.meyer@hpe.com,kuba@kernel.org,pavan.chebbi@broadcom.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 15 Jun 2026 16:31:44 +0200
Message-ID: <2026061544-stony-launder-1952@gregkh>
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
git cherry-pick -x d930276f2cddd0b7294cac7a8fe7b877f6d9e08d
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026061544-stony-launder-1952@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From d930276f2cddd0b7294cac7a8fe7b877f6d9e08d Mon Sep 17 00:00:00 2001
From: Kyle Meyer <kyle.meyer@hpe.com>
Date: Fri, 5 Jun 2026 17:25:24 -0500
Subject: [PATCH] bnxt_en: Fix NULL pointer dereference

PCIe errors detected by a Root Port or Downstream Port cause error
recovery services to run on all subordinate devices regardless of
administrative state.

The .error_detected() callback, bnxt_io_error_detected(), disables
and synchronizes IRQs via bnxt_disable_int_sync(), which calls
bnxt_cp_num_to_irq_num() to map completion rings to IRQs using
bp->bnapi.

Since bp->bnapi is allocated on NIC open and freed on NIC close, PCIe
error recovery on a closed NIC can dereference a NULL pointer.

Check if bp->bnapi is NULL before disabling and synchronizing IRQs.

Fixes: e5811b8c09df ("bnxt_en: Add IRQ remapping logic.")
Cc: stable@vger.kernel.org
Signed-off-by: Kyle Meyer <kyle.meyer@hpe.com>
Reviewed-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
Link: https://patch.msgid.link/aiNM1CY2-StPilxW@hpe.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 35e1f8f663c7..c999f9733326 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -5748,7 +5748,7 @@ static void bnxt_disable_int_sync(struct bnxt *bp)
 {
 	int i;
 
-	if (!bp->irq_tbl)
+	if (!bp->irq_tbl || !bp->bnapi)
 		return;
 
 	atomic_inc(&bp->intr_sem);

