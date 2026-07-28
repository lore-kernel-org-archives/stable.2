Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70ABB43E4A2
	for <stable@vger.kernel.org>; Tue, 28 Jul 2026 13:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785245448; cv=none; b=k4wWvMVeu6p3EGZlMumBWJmG5/uwtoevDIZnpemaTqlhpPaSkvoDhY0KC3fu8I5MXeUYprVj+Ib//PJ7kAzGKkjmCoWrnmhLZ8szqpGNz/VJ9oaNlQVFE7djG+l3xvfQUykVHcv3DyvVf+TZoOtr4Day7oPucKNa4xXdEwerYkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785245448; c=relaxed/simple;
	bh=SoFINg/ogL/g9p7G76Sgs9brdKmr6HNwjR2EXF0Cfaw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Lz0Dx1KN+Kxn6A6SBegjhkcKTEyiNb6KgVwSiVtLqySnUN/46a6rHsQVno6Rihi4UIPiirOU66/U8LgB+PKuE4NeBHzRxMtfuE56Lil+5SE4/m5oXew7979yVdcZ664ABPbgTPu+KJpdsoseGTTFGVcpj7cQZ5cmGpHANrmPdxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UvebT+yr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UvebT+yr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAB071F00A3A;
	Tue, 28 Jul 2026 13:30:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785245439;
	bh=GMxvmbzYdTf+cb37y9h27RLHSPZivCwQRPWQaqhE4z0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UvebT+yrjgU2LJSWiusiTD9HcUZTZiyYmvs5jUAVhlVEFx+vKtqmSlDi9JO8HaoBa
	 WuYLbosuvc5xfql9cA8D4D6hIB8QauUo5ahLoJEihcdZjRLS3ivDThkOa8v5oGb9Xa
	 E8iEgCpWEH/yDAGKKl74qdUVs1DzcGjK9FUUZrEcGJblykKgye+WAXxOqheVRHchay
	 FXP75mbpUQBdwAY15/y4LpchaWOsKJJiYO8sO4yhkf7EJ6GynVEmemhLe/AIxehyyU
	 d0BChvs3xAKRWkYG09DOY0Lw9Y/jQ517xOARcoWXXaWh72lx0qozE2bfk3ymNQV70X
	 gf3T5NeoPzbFw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Michael Bommarito <michael.bommarito@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/2] octeontx2-af: validate body pcifunc in rvu_mbox_handler_rep_event_notify
Date: Tue, 28 Jul 2026 09:30:36 -0400
Message-ID: <20260728133037.3965153-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072017-removal-sequester-79b2@gregkh>
References: <2026072017-removal-sequester-79b2@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Michael Bommarito <michael.bommarito@gmail.com>

[ Upstream commit 2156a29aecfffa2eb7c558255690084efbe9f3b0 ]

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
Stable-dep-of: 8cdcf3d2caac ("octeontx2-af: cn10k: restrict VF LMTLINE sharing to its own PF")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/marvell/octeontx2/af/rvu.c     | 2 +-
 drivers/net/ethernet/marvell/octeontx2/af/rvu.h     | 1 +
 drivers/net/ethernet/marvell/octeontx2/af/rvu_rep.c | 8 ++++++++
 3 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
index ad733f4da3c185..019bd49015c603 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
@@ -435,7 +435,7 @@ struct rvu_pfvf *rvu_get_pfvf(struct rvu *rvu, int pcifunc)
 		return &rvu->pf[rvu_get_pf(rvu->pdev, pcifunc)];
 }
 
-static bool is_pf_func_valid(struct rvu *rvu, u16 pcifunc)
+bool is_pf_func_valid(struct rvu *rvu, u16 pcifunc)
 {
 	int pf, vf, nvfs;
 	u64 cfg;
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu.h b/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
index 914ba2b691ec80..c9ed5276690d36 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
@@ -900,6 +900,7 @@ u16 rvu_get_rsrc_mapcount(struct rvu_pfvf *pfvf, int blkaddr);
 struct rvu_pfvf *rvu_get_pfvf(struct rvu *rvu, int pcifunc);
 void rvu_get_pf_numvfs(struct rvu *rvu, int pf, int *numvfs, int *hwvf);
 bool is_block_implemented(struct rvu_hwinfo *hw, int blkaddr);
+bool is_pf_func_valid(struct rvu *rvu, u16 pcifunc);
 bool is_pffunc_map_valid(struct rvu *rvu, u16 pcifunc, int blktype);
 int rvu_get_lf(struct rvu *rvu, struct rvu_block *block, u16 pcifunc, u16 slot);
 int rvu_lf_reset(struct rvu *rvu, struct rvu_block *block, int lf);
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_rep.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_rep.c
index 4415d0ce9aef4e..d43c034b0264a6 100644
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
 	qentry = kmalloc(sizeof(*qentry), GFP_ATOMIC);
 	if (!qentry)
 		return -ENOMEM;
-- 
2.53.0

