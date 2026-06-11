Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5B31403E99;
	Thu, 11 Jun 2026 16:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781193945; cv=none; b=CrGM/6vflGtUITVjFKuy7A96XS/UnpNWBDSpSKgHI4zIsSusCAtG5AmgP7r7YvpjYrTYt1FnI0vM7ZtoG904l2ZmQycmyiCsxJ+mZn6jPnHVnXFJ2zVcWKzVka7F28anZwlLUeiYtgBeekF6U/9JpwuX5YCbJmTmvh+As2OW+qI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781193945; c=relaxed/simple;
	bh=4LOOw+JYhoT1ouO2hsiVqURj/STV5xCaDmCONQxzyzo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=q9xuGvIw7v37jomEH4kO4aQaIizlfB5AmKwNr/sCfnWowm5Tp5NbL6P2uGfnzt+EKGTneQssMU1FXakV6XA+SVE/rhI4z2Fy4CWJtaJorPWkJLCuPMOd7Dq1LGapIn2rBixbcq7jRFZKSJ3U7b2B/dVOh+PEl8Y7pmZPJxI4jaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=bxHGhmaE; arc=none smtp.client-ip=45.254.49.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="bxHGhmaE"
Received: from PC-202605011814.localdomain (unknown [222.191.246.242])
	by smtp.qiye.163.com (Hmail) with ESMTP id 420765d90;
	Fri, 12 Jun 2026 00:00:28 +0800 (GMT+08:00)
From: Runyu Xiao <runyu.xiao@seu.edu.cn>
To: netdev@vger.kernel.org
Cc: sgoutham@marvell.com,
	gakula@marvell.com,
	sbhatta@marvell.com,
	hkelam@marvell.com,
	bbhushan2@marvell.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	amakarov@marvell.com,
	tduszynski@marvell.com,
	linux-kernel@vger.kernel.org,
	jianhao.xu@seu.edu.cn,
	runyu.xiao@seu.edu.cn,
	stable@vger.kernel.org
Subject: [PATCH net 1/2] octeontx2-pf: clear stale mailbox IRQ state before request_irq()
Date: Fri, 12 Jun 2026 00:00:13 +0800
Message-Id: <20260611160014.3202224-2-runyu.xiao@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260611160014.3202224-1-runyu.xiao@seu.edu.cn>
References: <20260611160014.3202224-1-runyu.xiao@seu.edu.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9eb769dce103a1kunm0ec2af3116af49
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlCS04ZVk9CQxkYSU0fGUxOHlYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUlVSkJKVUlPTVVJT0lZV1kWGg8SFR0UWUFZT0tIVUpLSE
	pPSExVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=bxHGhmaEimqx6Su8820FEZdf+u0AQuUDxTuJeL/ZQsVn+C789ppJZ7v2IBUKneBZyXnxADMsHtm5gDwi4/2KfJa4bzxn66UNdgVHaXgFFj7U2zW0XyKAzOjPcOyPDCGOGnFL5dE12sooe2FjOdR2rzjBrfnC6ibHyDEV3l/w4pk=; s=default; c=relaxed/relaxed; d=seu.edu.cn; v=1;
	bh=kVl+zXadskkGqGb0v5Vn93cytqR0pdUmPP63H1nkyZo=;
	h=date:mime-version:subject:message-id:from;

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
---
 .../ethernet/marvell/octeontx2/nic/otx2_pf.c  | 20 +++++++++----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
index bbf25769f499..5c3e06897a37 100644
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
-- 
2.34.1
