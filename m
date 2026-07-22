Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57D6E3C8716
	for <stable@vger.kernel.org>; Wed, 22 Jul 2026 23:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784764029; cv=none; b=KCv+1AwVzWkGuaHRjNjDdcHEdxyabKEdoTx1Ehf6uKAHKP8O9j4vBLEJc75hlRCnj8+F8C+l1ATiGt2pz9dLKjSP4+mO619ccjI4rnjoPHNA92zumfjROEbKzGEZRSH6zfTmmdDCuFSAXOF+n0Mf3yl2TCioT0FNAlmax06DOoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784764029; c=relaxed/simple;
	bh=KJK6Uf3F79umg1iywm3CYwboSYXmijuuPX9xjTSQ4LQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HgGsbcLyjcVhBqvjFCLG8t3hRPIae9FgphX5MB2E0SMiu0iT+jLRLD1kHJnoq3QcwcR/DSPRSe7xa6KD7u6ki8BcTbBD5LeUX34266EH3cd2lppxgi+u8gR6UZJ1mEc78VtS+b8S4f4JdJgUXT0uz/CGKhZQbcSinMgkfd72ukg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gZ5ZSiCd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gZ5ZSiCd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 481CE1F00A3A;
	Wed, 22 Jul 2026 23:47:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784764028;
	bh=+j0P4YWiFqGIuKQD6EtoIW5W472xwzOM1HQofQPnXH0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gZ5ZSiCdvqFz/vPzp/2uVzq02Sl2/bmUEg3fBSk9x06tSFSXl0t1VaeCQxyclmdmJ
	 fzvjxynT2s/Uk+wODxQdTwI5eTzD2h+T1iM9hgwGVFo8Kg0Oqz9uZvo27mssz2EPyO
	 gHftMGKVieg9+7y36VXyMY/Yemz0volWqm481ach2DkToA74SbnONUAmCEcj7nHoMQ
	 JAypn7DMc/NDxGOg9dfzgeS1nI4URTVLDf1fXi79pQ8IXsNiKwDe5KL4Krw9dB2wb7
	 7auNVLdftN5jogyiShiJmr2z9+HMVG+VrtuxO95p6eYx5IAoh/KCHLcdThbuQX2ATo
	 o9ODjhVpEnF3Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Runyu Xiao <runyu.xiao@seu.edu.cn>,
	Simon Horman <horms@kernel.org>,
	Ratheesh Kannoth <rkannoth@marvell.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/2] octeontx2-vf: clear stale mailbox IRQ state before request_irq()
Date: Wed, 22 Jul 2026 19:47:04 -0400
Message-ID: <20260722234705.2612855-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260722234705.2612855-1-sashal@kernel.org>
References: <2026072023-obstinate-salutary-5c67@gregkh>
 <20260722234705.2612855-1-sashal@kernel.org>
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
index dcb8190de24073..af5d69e6d267a2 100644
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

