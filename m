Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6729C413245
	for <stable@vger.kernel.org>; Mon, 20 Jul 2026 12:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784549782; cv=none; b=j56U/a8rsxtY7L+dNm6OmSvz4izxHzCKTqMUufETclZGJL7lMDdx0kpSo5FHVQWxM8TC9X+hxP2w86VwguxJJ6TORHVDOYcptOGoy1GL4EksTIuDev6Sfg/TCrqYAS5W0p9lKLqwzNIk3+esbhLBa1flYXM4heYC4rfDkCizUoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784549782; c=relaxed/simple;
	bh=j8VLuzWjjo3+g8zts+HMd86UaTIqhnZwH9Iv85+jTis=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=sOXCTPPBmQTN625b1BSHcWF+oappOcfvOz18uEqcJNYc1HKyktwxGoWLinFV8pjL65w1j8I5PZqblcOmJlEKBRLA0JrFY9XuZ8ihCtZ6IyCJFL0dmz+n0LtTy9TkYldUe+qXNLWUdnYTVA90WahqRZZGzhafk5gmaApnMCSyklk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=E/K1HeUT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="E/K1HeUT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7743A1F00ACF;
	Mon, 20 Jul 2026 12:15:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784549749;
	bh=ptEFHMe27AnuuE+z4aJO/AUQsd2mBZ9/vdwsxom3itU=;
	h=Subject:To:Cc:From:Date;
	b=E/K1HeUTKAzorUwqIMl0+rHg4C7sjBhuGdahsuM0ftT8+n9Glrw24uqvis6Hq21vQ
	 AIlXjazSlpb3u1b2QNGa3Xw6+7rBmPox7wBr240snxEbbTmUfXJ1vcFpIkK7s801FR
	 cyO+C5DaJsbQTbelc7i/IFbmoLOHKRDlZQiOfNPE=
Subject: FAILED: patch "[PATCH] octeontx2-vf: clear stale mailbox IRQ state before" failed to apply to 5.15-stable tree
To: runyu.xiao@seu.edu.cn,horms@kernel.org,kuba@kernel.org,rkannoth@marvell.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 20 Jul 2026 14:15:24 +0200
Message-ID: <2026072024-facing-mammary-40dd@gregkh>
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
git cherry-pick -x 0b352f04b9be2c83c0240aa6dae7257fefa90464
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072024-facing-mammary-40dd@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

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

