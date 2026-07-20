Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A90F412BE1
	for <stable@vger.kernel.org>; Mon, 20 Jul 2026 12:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784549756; cv=none; b=NoIA7L9yanC680K4OupdPtk0N9Ir+b79TagyJ1eQIKBkbCi28zlKAwJHg6SKG+Z+XWcBazleXebc1eHTOpFpzWzU2DNXHbPmco2I3xptMpeIc1qLTZHmU6ETyohsojlW30zM6DC4IoIXf5rZliLWtAkiMFykZAnnsUYLCa69jGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784549756; c=relaxed/simple;
	bh=S+vtaZt/GJ36ClwERtoj98Cc3y9Pm4kAWWEETg4ZRpU=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=laH9eVHDrkBO5mKLOYQaLk5ZUv10y2iVp5eIK77UfWUgjMN1pr5MthC6eidZOODn+j2dP4f2LN+3QwRR1P+2T52lJpYHqkLoVKtmQRwW7PYNAspxkl5BxCR9y2lvs7sCs6cbNR8M5+zormD+kxoQKuhL+R/lTp9APy41uFay0aU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=O+HPfuac; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="O+HPfuac"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AF941F01558;
	Mon, 20 Jul 2026 12:15:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784549732;
	bh=d/TA1txd/i474xtH2IO0gLT3a849DD4+VJJ5Jhmjwas=;
	h=Subject:To:Cc:From:Date;
	b=O+HPfuacvPy/QZYRzSruPpSefNbV63ulVXDuJw5/nvBZIx3TyhVBOndo/xsyS+a8b
	 Vgx4RzWIsutKbJUMwVLwz4PfzFY6YTlQYlWtI1DGsCkm4rPFFN5ltA9aaurrRP/mlB
	 i83Z5A1PV9xodJHVWekR1Sla6caouVwP2BIG4F88=
Subject: FAILED: patch "[PATCH] octeontx2-pf: clear stale mailbox IRQ state before" failed to apply to 5.15-stable tree
To: runyu.xiao@seu.edu.cn,horms@kernel.org,kuba@kernel.org,rkannoth@marvell.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 20 Jul 2026 14:15:14 +0200
Message-ID: <2026072014-obscure-tattoo-f4b2@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x f918554fb7246e89b98ef90abe80801f038258b3
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072014-obscure-tattoo-f4b2@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From f918554fb7246e89b98ef90abe80801f038258b3 Mon Sep 17 00:00:00 2001
From: Runyu Xiao <runyu.xiao@seu.edu.cn>
Date: Fri, 12 Jun 2026 00:00:13 +0800
Subject: [PATCH] octeontx2-pf: clear stale mailbox IRQ state before
 request_irq()

otx2_register_mbox_intr() currently installs the PF mailbox IRQ handler
before clearing stale mailbox interrupt state. The function itself then
comments that the local interrupt bits must be cleared first to avoid
spurious interrupts, but that clear happens only after request_irq() has
already exposed the handler to irq delivery.

A running system can reach this during PF mailbox interrupt registration
while stale or latched RVU_PF_INT state is still present. If delivery
happens in the request_irq()-to-clear window,
otx2_pfaf_mbox_intr_handler() can run before local quiesce and touch
the same pf->mbox and pf->mbox_wq carrier that probe and teardown later
reuse or destroy.

Move the stale mailbox interrupt clear ahead of request_irq(), but keep
interrupt enabling after the handler is installed. This closes the
pre-clear early-IRQ window without creating a new enable-before-handler
window.

Fixes: 5a6d7c9daef3 ("octeontx2-pf: Mailbox communication with AF")
Cc: stable@vger.kernel.org
Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
Reviewed-by: Simon Horman <horms@kernel.org>
Reviewed-by: Ratheesh Kannoth <rkannoth@marvell.com>
Link: https://patch.msgid.link/20260611160014.3202224-2-runyu.xiao@seu.edu.cn
Signed-off-by: Jakub Kicinski <kuba@kernel.org>

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
index f9fbf0c17648..0311357dd05b 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
@@ -1119,9 +1119,16 @@ int otx2_register_mbox_intr(struct otx2_nic *pf, bool probe_af)
 {
 	struct otx2_hw *hw = &pf->hw;
 	struct msg_req *req;
+	u64 mbox_int_mask;
 	char *irq_name;
 	int err;
 
+	mbox_int_mask = !is_cn20k(pf->pdev) ? BIT_ULL(0) :
+				BIT_ULL(0) | BIT_ULL(1);
+
+	/* Clear stale mailbox interrupt state before installing the handler. */
+	otx2_write64(pf, RVU_PF_INT, mbox_int_mask);
+
 	/* Register mailbox interrupt handler */
 	if (!is_cn20k(pf->pdev)) {
 		irq_name = &hw->irq_name[RVU_PF_INT_VEC_AFPF_MBOX * NAME_SIZE];
@@ -1147,17 +1154,8 @@ int otx2_register_mbox_intr(struct otx2_nic *pf, bool probe_af)
 		return err;
 	}
 
-	/* Enable mailbox interrupt for msgs coming from AF.
-	 * First clear to avoid spurious interrupts, if any.
-	 */
-	if (!is_cn20k(pf->pdev)) {
-		otx2_write64(pf, RVU_PF_INT, BIT_ULL(0));
-		otx2_write64(pf, RVU_PF_INT_ENA_W1S, BIT_ULL(0));
-	} else {
-		otx2_write64(pf, RVU_PF_INT, BIT_ULL(0) | BIT_ULL(1));
-		otx2_write64(pf, RVU_PF_INT_ENA_W1S, BIT_ULL(0) |
-			     BIT_ULL(1));
-	}
+	/* Enable mailbox interrupt for msgs coming from AF. */
+	otx2_write64(pf, RVU_PF_INT_ENA_W1S, mbox_int_mask);
 
 	if (!probe_af)
 		return 0;

