Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 939CF20010A
	for <stable@vger.kernel.org>; Thu,  4 Jun 2026 10:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780568949; cv=none; b=ZxRjO3BUh7slmocsbeZtcecI9LWkIWn3aorqbWjE88Vl28brawE/p/G2Su8YfP0WBXT/DndtDjDN53jY8nf/UOppT7/kMOR+JBAot/Iv1ggIJjNsMWYWVSrZwC4fHE+zS3ddWmQPUT4meqcsPMRCg7vvyG4GnG5aiV2elK3Qfks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780568949; c=relaxed/simple;
	bh=hkNuJ3HQvZKr2AnCVZjxP+YLz6bgJNfGbbFpgRxqvow=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=dy69XFFj/hWIdXlADiwGGkG8jLzht96ksIA8NnCtqUskMXKEadHKAdpFzGpvtdwCAcIC7+ckraAB/14LLKa5pOdQDCiYkfdYkJHitH5+lYGo+O52OLHT6T3AISpnWfVPuy6LHQFOabkZpIpSs0np4gHOAnJiXwSBwakNDXFp1dM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rX5aqQ8T; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rX5aqQ8T"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85AC41F00893;
	Thu,  4 Jun 2026 10:29:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780568948;
	bh=Z6BMihPLXQPq5dgv/0DLTp0hwjpO2+HzAIhf7VmDz5o=;
	h=Subject:To:Cc:From:Date;
	b=rX5aqQ8TNsiE4WH2p5WfliBBw9db60ChDUs3Z+bjiX7xCb0Xz+TMrQ1kHFkTJkrFc
	 /+rCjrAl2GA8Wjqd8cGIWWYrRLGltbBRklthEmax4JjBMRo0+cmdrhG8Sn18Ulsa7K
	 l8h/F+xapu7CqxGaEZ8DrWOMvyeGwnNCWs/sLraU=
Subject: FAILED: patch "[PATCH] octeontx2-af: validate body pcifunc in" failed to apply to 6.18-stable tree
To: michael.bommarito@gmail.com,kuba@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 04 Jun 2026 12:28:11 +0200
Message-ID: <2026060411-target-repeated-e6ae@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 2156a29aecfffa2eb7c558255690084efbe9f3b0
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026060411-target-repeated-e6ae@gregkh' --subject-prefix 'PATCH 6.18.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 2156a29aecfffa2eb7c558255690084efbe9f3b0 Mon Sep 17 00:00:00 2001
From: Michael Bommarito <michael.bommarito@gmail.com>
Date: Wed, 20 May 2026 11:41:57 -0400
Subject: [PATCH] octeontx2-af: validate body pcifunc in
 rvu_mbox_handler_rep_event_notify

rvu_mbox_handler_rep_event_notify() in drivers/net/ethernet/marvell/
octeontx2/af/rvu_rep.c queues a sender-controlled REP_EVENT_NOTIFY
request body verbatim, and rvu_rep_up_notify() then forwards
event->pcifunc (the nested body field, distinct from the
AF-normalised header pcifunc) into rvu_get_pfvf(), rvu_get_pf() and
the AF->PF mailbox device index without any bounds check.

A VF attached to a PF that has been put into switchdev
representor mode reaches this path: the VF mailbox handler
otx2_pfvf_mbox_handler() forwards every message id including
MBOX_MSG_REP_EVENT_NOTIFY to AF without an allowlist, and the AF
dispatcher rewrites only msg->pcifunc, leaving struct
rep_event::pcifunc attacker-controlled.  The sibling
rvu_mbox_handler_esw_cfg() refuses requests whose header pcifunc
is not rvu->rep_pcifunc; this handler has no equivalent gate.

An out-of-range body pcifunc selects an &rvu->pf[]/&rvu->hwvf[]
element past the allocated array and, for RVU_EVENT_MAC_ADDR_CHANGE,
turns into a six-byte attacker-chosen OOB ether_addr_copy() target
inside the queued worker; KASAN reports a slab-out-of-bounds write
in rvu_rep_wq_handler.

Reject malformed requests at the handler entry by gating on
is_pf_func_valid(), which is already the canonical PF/VF range check
in this driver; expose it via rvu.h so callers in rvu_rep.c can use
it instead of open-coding the same range arithmetic.

Fixes: b8fea84a0468 ("octeontx2-pf: Add support to sync link state between representor and VFs")
Cc: stable@vger.kernel.org
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
Link: https://patch.msgid.link/20260520154157.1439319-1-michael.bommarito@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
index e40b79076358..3cf131508ecf 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
@@ -436,7 +436,7 @@ struct rvu_pfvf *rvu_get_pfvf(struct rvu *rvu, int pcifunc)
 		return &rvu->pf[rvu_get_pf(rvu->pdev, pcifunc)];
 }
 
-static bool is_pf_func_valid(struct rvu *rvu, u16 pcifunc)
+bool is_pf_func_valid(struct rvu *rvu, u16 pcifunc)
 {
 	int pf, vf, nvfs;
 	u64 cfg;
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu.h b/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
index a466181cf908..de3fbd3d15d6 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
@@ -917,6 +917,7 @@ u16 rvu_get_rsrc_mapcount(struct rvu_pfvf *pfvf, int blkaddr);
 struct rvu_pfvf *rvu_get_pfvf(struct rvu *rvu, int pcifunc);
 void rvu_get_pf_numvfs(struct rvu *rvu, int pf, int *numvfs, int *hwvf);
 bool is_block_implemented(struct rvu_hwinfo *hw, int blkaddr);
+bool is_pf_func_valid(struct rvu *rvu, u16 pcifunc);
 bool is_pffunc_map_valid(struct rvu *rvu, u16 pcifunc, int blktype);
 int rvu_get_lf(struct rvu *rvu, struct rvu_block *block, u16 pcifunc, u16 slot);
 int rvu_lf_reset(struct rvu *rvu, struct rvu_block *block, int lf);
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_rep.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_rep.c
index 901f6fd40fd4..a2781e0f504e 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_rep.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_rep.c
@@ -97,6 +97,14 @@ int rvu_mbox_handler_rep_event_notify(struct rvu *rvu, struct rep_event *req,
 {
 	struct rep_evtq_ent *qentry;
 
+	/* The mailbox dispatcher normalises only the header pcifunc; the
+	 * nested struct rep_event::pcifunc body field is sender-controlled
+	 * and is later used by rvu_rep_up_notify() to index rvu->pf[] /
+	 * rvu->hwvf[].  Reject out-of-range body selectors before queueing.
+	 */
+	if (!is_pf_func_valid(rvu, req->pcifunc))
+		return -EINVAL;
+
 	qentry = kmalloc_obj(*qentry, GFP_ATOMIC);
 	if (!qentry)
 		return -ENOMEM;

