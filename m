Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 407B11C84A2
	for <stable@vger.kernel.org>; Thu, 23 Jul 2026 01:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784769431; cv=none; b=ECaewq9OJQZl0ghgao7Ijt+0KLTgPqiukN9moHEH8jpjhwXTejx13kI0ciTrLyKFaNWSSrVPBKxudmR6VWYd4IWlGB5QA3fguKHgItQOSRVtifipYMUfMCHHrPTfmPozfHx2bu/REC4jcTb7SgD4MIFtz9oN6sezL+55BApl/dE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784769431; c=relaxed/simple;
	bh=MEFJfB5LzXuct1wbZSlRl6rLrNNtSrkdrDlv5030tXw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iOxNpKhF1HRysOAmmAOTVtaZ9ZOtyPRojSbf+ikgqnc2Pa+cv5Prq0t1M8zvpeQjeiU3bNz1SgzA9rIIdHnGWTtUeEH2WyHg0BAw2gvMivITJE0g75qyYCm8JdPkqj4gzzw1hECyMcXtimvbjiTkUpDWkZvb2dtQbfywYR+//p4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gUOX4Cor; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gUOX4Cor"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77EE41F00A3A;
	Thu, 23 Jul 2026 01:17:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784769430;
	bh=3k0mum05wulf1eP+Qbx2zoZ5ERktdyEeWQI3QFTPpnA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gUOX4CorZwP8PrAhgUNfophWLRqDR9AnVQK2TOXgh07MpwO4JBmgMWTgtY2m8EzLw
	 0t1c7uo31+Rn7toVnGy+NPZRtIwiZo1eLF5jOOqxquFxSplqu4K0k7TXzzU//MWXDc
	 ZjreB3NwDhLMKq1Je9T7OA/J+0caunt41F0pz4pAqWEps4bcQsM5gxcNZl4gNX+cle
	 NEK14HFtzk0WW/borHKHAAkTv1Wbecwl7IeGpFQey9xWlV0ZJ4bPioHOG/hmyLZrhZ
	 FCeb6tPJiLAjXJ8vO9ukuiineXKD5Ze7RtxdSG8QJXQe9yxDZIxfNKMm8ANPbKHhlb
	 lx/YqheE/nZ8Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Runyu Xiao <runyu.xiao@seu.edu.cn>,
	Simon Horman <horms@kernel.org>,
	Ratheesh Kannoth <rkannoth@marvell.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 3/3] octeontx2-vf: clear stale mailbox IRQ state before request_irq()
Date: Wed, 22 Jul 2026 21:16:57 -0400
Message-ID: <20260723011657.2779635-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260723011657.2779635-1-sashal@kernel.org>
References: <2026072024-facing-mammary-40dd@gregkh>
 <20260723011657.2779635-1-sashal@kernel.org>
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
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c
index 689e0853ab9cd4..5402f625041ac2 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c
@@ -235,6 +235,9 @@ static int otx2vf_register_mbox_intr(struct otx2_nic *vf, bool probe_pf)
 	char *irq_name;
 	int err;
 
+	/* Clear stale mailbox interrupt state before installing the handler. */
+	otx2_write64(vf, RVU_VF_INT, BIT_ULL(0));
+
 	/* Register mailbox interrupt handler */
 	irq_name = &hw->irq_name[RVU_VF_INT_VEC_MBOX * NAME_SIZE];
 	snprintf(irq_name, NAME_SIZE, "RVUVFAF Mbox");
@@ -246,10 +249,7 @@ static int otx2vf_register_mbox_intr(struct otx2_nic *vf, bool probe_pf)
 		return err;
 	}
 
-	/* Enable mailbox interrupt for msgs coming from PF.
-	 * First clear to avoid spurious interrupts, if any.
-	 */
-	otx2_write64(vf, RVU_VF_INT, BIT_ULL(0));
+	/* Enable mailbox interrupt for msgs coming from PF. */
 	otx2_write64(vf, RVU_VF_INT_ENA_W1S, BIT_ULL(0));
 
 	if (!probe_pf)
-- 
2.53.0

