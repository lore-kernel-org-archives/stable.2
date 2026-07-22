Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEB5F33ADA3
	for <stable@vger.kernel.org>; Wed, 22 Jul 2026 23:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784762487; cv=none; b=feuoZfzQqUtfsAht/GqqG+Y9p6KasjW3SksDQRuhcFtyridnvuK+y45Jkm/mMEef5yVhyVM5Gnr2ur7LvhlTB0aiQw1K/tefc23fCnAR9Y/sAjoMno4EP+TnR3wUZIklT+k+h/My/x1z5YyLNFs3L56ZlyxxhGN+n++5ro/wxYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784762487; c=relaxed/simple;
	bh=U+Bq1a0GmFPIj1iWWrWJgWKY7D7xvW3/rWwf+cfDYD8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=plb+pSOKW6ApIW0Syvi88MnAIRnoWP0vBmG9d6GWR2X0M/l7jLebUOI8/WvqXrtcZqeyPJ+VN1ZGEneWr5/NBD83n9ElElYNN3cxqx2DmVstS0qpx8ceWathgi/3dW1tt24H1fJ+laNag46IMnxIDaiVxQighX2kpI8rwhu5KAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VWvKl9Ht; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VWvKl9Ht"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E533F1F00A3D;
	Wed, 22 Jul 2026 23:21:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784762485;
	bh=N1jeofZ8whCGMtXfeUHEhgUEliTY1fgNqqpGSNc22LU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VWvKl9HtIDCWMYlwPbj0jg9yGwdxsXQ0ii+1jV4lM9ftvAEw74tbIIhTFp/h+34PG
	 NrKWf34yFps5jYbfQzbNTB8BwdnCgop3oALBbKocmGmClVvr35omehzGrx2RihaCcz
	 Oz1l6ggFTljfCwsY2kWylqWcewhFMw4IxKUWt+p527SV96D0yEvN0v+ovLaAE8txXf
	 NaLIErCknRNSaPkRCrz0PPLTa06iG0kpSrjbd7SuE8OPQlJJbpqbb7YfNfk6ZYOLac
	 Ci4HLvnb4mDwLfSEvmiX2JG+s05phW4oZhBqB2qCjKzMr9LAwpNItZV5Gwc2hdz3Ps
	 1OLsgv4WZYSSg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Runyu Xiao <runyu.xiao@seu.edu.cn>,
	Simon Horman <horms@kernel.org>,
	Ratheesh Kannoth <rkannoth@marvell.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/2] octeontx2-vf: clear stale mailbox IRQ state before request_irq()
Date: Wed, 22 Jul 2026 19:21:22 -0400
Message-ID: <20260722232122.2551218-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260722232122.2551218-1-sashal@kernel.org>
References: <2026072023-cornea-making-1928@gregkh>
 <20260722232122.2551218-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Runyu Xiao <runyu.xiao@seu.edu.cn>

[ Upstream commit 0b352f04b9be2c83c0240aa6dae7257fefa90464 ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../net/ethernet/marvell/octeontx2/nic/otx2_vf.c    | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c
index cf0aa16d754070..d93b4109a144fb 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c
@@ -245,9 +245,15 @@ static int otx2vf_register_mbox_intr(struct otx2_nic *vf, bool probe_pf)
 {
 	struct otx2_hw *hw = &vf->hw;
 	struct msg_req *req;
+	u64 mbox_int_mask;
 	char *irq_name;
 	int err;
 
+	mbox_int_mask = BIT_ULL(0);
+
+	/* Clear stale mailbox interrupt state before installing the handler. */
+	otx2_write64(vf, RVU_VF_INT, mbox_int_mask);
+
 	/* Register mailbox interrupt handler */
 	irq_name = &hw->irq_name[RVU_VF_INT_VEC_MBOX * NAME_SIZE];
 	snprintf(irq_name, NAME_SIZE, "RVUVFAF Mbox");
@@ -259,11 +265,8 @@ static int otx2vf_register_mbox_intr(struct otx2_nic *vf, bool probe_pf)
 		return err;
 	}
 
-	/* Enable mailbox interrupt for msgs coming from PF.
-	 * First clear to avoid spurious interrupts, if any.
-	 */
-	otx2_write64(vf, RVU_VF_INT, BIT_ULL(0));
-	otx2_write64(vf, RVU_VF_INT_ENA_W1S, BIT_ULL(0));
+	/* Enable mailbox interrupt for msgs coming from PF. */
+	otx2_write64(vf, RVU_VF_INT_ENA_W1S, mbox_int_mask);
 
 	if (!probe_pf)
 		return 0;
-- 
2.53.0

