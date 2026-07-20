Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62740412BE9
	for <stable@vger.kernel.org>; Mon, 20 Jul 2026 12:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784549758; cv=none; b=fd5yWtiUZjsmgF5bltFjGVUZpFzY9U+6VMLnEws/sKKEdihtPCwyramIlmCu21+ChUnBZsSvTFs80NcvPCZ7+0Z6J91X8IEC602XGp2Bd9aW3b9PyIMLiHhWc/zREmZdSWVvnTlS41Ho3v4FTvKsjdW8JdFA1DOhcLpycUClFy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784549758; c=relaxed/simple;
	bh=AEDtf4c65OSKKggb1t006ZXNKl5yI7KqqL9PMPa5UVY=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=C2BYqtvYi0sGSNl3uOZBEhbsS4rXWx7ADq1nj/JZVgedODdZKJhNLrRget89a0oY4gWLrit73mMS2Zci3c4F8U/Dc8OgDfu9wI3CD9jTFxulbkQhaZKYwN8nZehLWs/hjna+zKcvw4RgpF15nqAzTLxdNzZ5Ub9/H1Gt+3NAu2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dbr4B+K1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dbr4B+K1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4A441F00ADB;
	Mon, 20 Jul 2026 12:15:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784549738;
	bh=oBijYIJDAoEiH34hoYaEhzIM49TdP9tw+NgIpb92Yd0=;
	h=Subject:To:Cc:From:Date;
	b=dbr4B+K1i83cjAZyIukFI5UP7TjET4ou9XQMTzUhkD+iYOMvRzcO+ZPUorjB93b9y
	 8xabb1btLzTym7fXkNBbJDdFOFtCPhL3Ll4+kG6OBBFQIcM7t6ENwWHe/3SOGyBPw4
	 rhC78JMzC5ZW5gybCYnTt8lF+t/AMcncrD8xX3IQ=
Subject: FAILED: patch "[PATCH] octeontx2-vf: clear stale mailbox IRQ state before" failed to apply to 6.12-stable tree
To: runyu.xiao@seu.edu.cn,horms@kernel.org,kuba@kernel.org,rkannoth@marvell.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 20 Jul 2026 14:15:22 +0200
Message-ID: <2026072022-stupor-recount-8e77@gregkh>
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
git cherry-pick -x 0b352f04b9be2c83c0240aa6dae7257fefa90464
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072022-stupor-recount-8e77@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 0b352f04b9be2c83c0240aa6dae7257fefa90464 Mon Sep 17 00:00:00 2001
From: Runyu Xiao <runyu.xiao@seu.edu.cn>
Date: Fri, 12 Jun 2026 00:00:14 +0800
Subject: [PATCH] octeontx2-vf: clear stale mailbox IRQ state before
 request_irq()

otx2vf_register_mbox_intr() currently installs the VF mailbox IRQ
handler before clearing stale mailbox interrupt state. The code then says
that local interrupt bits should be cleared first to avoid spurious
interrupts, but that clear still happens only after request_irq() has
already made the handler reachable.

A running system can reach this during VF mailbox interrupt registration
while stale or latched RVU_VF_INT state is still present. If delivery
happens in the request_irq()-to-clear window,
otx2vf_vfaf_mbox_intr_handler() can run before local quiesce and touch
the same vf->mbox and vf->mbox_wq carrier that probe and teardown later
reuse or destroy.

Move the stale mailbox interrupt clear ahead of request_irq(), but keep
interrupt enabling after the handler is installed. This closes the
pre-clear early-IRQ window without creating a new enable-before-handler
window.

Fixes: 3184fb5ba96e ("octeontx2-vf: Virtual function driver support")
Cc: stable@vger.kernel.org
Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
Reviewed-by: Simon Horman <horms@kernel.org>
Reviewed-by: Ratheesh Kannoth <rkannoth@marvell.com>
Link: https://patch.msgid.link/20260611160014.3202224-3-runyu.xiao@seu.edu.cn
Signed-off-by: Jakub Kicinski <kuba@kernel.org>

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c
index f4fdbfba8667..b022f52c6845 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c
@@ -251,9 +251,17 @@ static int otx2vf_register_mbox_intr(struct otx2_nic *vf, bool probe_pf)
 {
 	struct otx2_hw *hw = &vf->hw;
 	struct msg_req *req;
+	u64 mbox_int_mask;
 	char *irq_name;
 	int err;
 
+	mbox_int_mask = !is_cn20k(vf->pdev) ? BIT_ULL(0) :
+				BIT_ULL(0) | BIT_ULL(1) |
+				BIT_ULL(2) | BIT_ULL(3);
+
+	/* Clear stale mailbox interrupt state before installing the handler. */
+	otx2_write64(vf, RVU_VF_INT, mbox_int_mask);
+
 	/* Register mailbox interrupt handler */
 	irq_name = &hw->irq_name[RVU_VF_INT_VEC_MBOX * NAME_SIZE];
 	snprintf(irq_name, NAME_SIZE, "RVUVF%d AFVF Mbox", ((vf->pcifunc &
@@ -274,18 +282,8 @@ static int otx2vf_register_mbox_intr(struct otx2_nic *vf, bool probe_pf)
 		return err;
 	}
 
-	/* Enable mailbox interrupt for msgs coming from PF.
-	 * First clear to avoid spurious interrupts, if any.
-	 */
-	if (!is_cn20k(vf->pdev)) {
-		otx2_write64(vf, RVU_VF_INT, BIT_ULL(0));
-		otx2_write64(vf, RVU_VF_INT_ENA_W1S, BIT_ULL(0));
-	} else {
-		otx2_write64(vf, RVU_VF_INT, BIT_ULL(0) | BIT_ULL(1) |
-			     BIT_ULL(2) | BIT_ULL(3));
-		otx2_write64(vf, RVU_VF_INT_ENA_W1S, BIT_ULL(0) |
-			     BIT_ULL(1) | BIT_ULL(2) | BIT_ULL(3));
-	}
+	/* Enable mailbox interrupt for msgs coming from PF. */
+	otx2_write64(vf, RVU_VF_INT_ENA_W1S, mbox_int_mask);
 
 	if (!probe_pf)
 		return 0;

