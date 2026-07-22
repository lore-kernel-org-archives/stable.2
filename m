Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A171C38422F
	for <stable@vger.kernel.org>; Wed, 22 Jul 2026 23:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784764026; cv=none; b=AZKnsWACWNsK+o2xJy+IKw/AZow3j285MlXSjCYsogL8b6PfI8gqaA9gW5x73zn9nBEUR1zPpPUNtjN/tgiE9TH4SVUeHdtccunYd1bXj0AJw6BvK8jyLog0XuPFIupCkVuTafUu03nkcO/UHYaLJYx+BT/VyEWawBWFmGnrwak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784764026; c=relaxed/simple;
	bh=DyK/F+tbXqiupEhVmpl0GDQKzaHhVDv66UH/xiJNCOg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SeR/A+9Ub/GJV0avljQ/45CL5CWLSJR3oleqJ9dTjQPcx1XDR/EWFHVrJu3srAy4DtwGEat7cM7RnMgXVxoDwLS/Ac1YEfuklA3/OAnpmaO7ZS2emVYA/yMyYBjAHpHCeUKFEa18wVGSH1R4guHV33w+hevth3tUUPH/vVg+EU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q/kwJMOa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q/kwJMOa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8E9B1F00A3E;
	Wed, 22 Jul 2026 23:47:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784764025;
	bh=/cwNkxI1AoIOn13PsgrFBK9Ll8MHpS9uzlk/ThYW2f0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Q/kwJMOaxi1Sa2p4p6c0SgeuwiWq3fcPeczmme6y9flXhJA6Gz8AEFCzLRE0O4l2B
	 aw/mMlYyh6xKwZbi7DD5hTD3M4iWcHkT9Lqf2+2PPkUBzjDKegAJik594ry9hhe//n
	 0H07LmNkBuVjA/GBvV6ZIm5SqLMFok8WWitlidzVxw8ehoHXXc/g3hZdxl4nyugM5m
	 9sILAoB/SneR4GLB+/yxTJh4OmF9h7dNYzcg+FZktHFiSlUK7CxF5OxcJE3NUEQcNW
	 MQgxyK2AkU2BSb58OTUa97gMr3UIDhFH2+PqxlkS0v/cqxu4TGgDjmA0hYKPnhHEM/
	 FP772rQLTKZ2Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Runyu Xiao <runyu.xiao@seu.edu.cn>,
	Simon Horman <horms@kernel.org>,
	Ratheesh Kannoth <rkannoth@marvell.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/2] octeontx2-pf: clear stale mailbox IRQ state before request_irq()
Date: Wed, 22 Jul 2026 19:47:02 -0400
Message-ID: <20260722234702.2612616-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260722234702.2612616-1-sashal@kernel.org>
References: <2026072013-groom-shrine-8b5d@gregkh>
 <20260722234702.2612616-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Runyu Xiao <runyu.xiao@seu.edu.cn>

[ Upstream commit f918554fb7246e89b98ef90abe80801f038258b3 ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
index 7cdb108e3d8c48..6c46091338e2c3 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
@@ -1026,6 +1026,9 @@ static int otx2_register_mbox_intr(struct otx2_nic *pf, bool probe_af)
 	char *irq_name;
 	int err;
 
+	/* Clear stale mailbox interrupt state before installing the handler. */
+	otx2_write64(pf, RVU_PF_INT, BIT_ULL(0));
+
 	/* Register mailbox interrupt handler */
 	irq_name = &hw->irq_name[RVU_PF_INT_VEC_AFPF_MBOX * NAME_SIZE];
 	snprintf(irq_name, NAME_SIZE, "RVUPFAF Mbox");
@@ -1037,10 +1040,7 @@ static int otx2_register_mbox_intr(struct otx2_nic *pf, bool probe_af)
 		return err;
 	}
 
-	/* Enable mailbox interrupt for msgs coming from AF.
-	 * First clear to avoid spurious interrupts, if any.
-	 */
-	otx2_write64(pf, RVU_PF_INT, BIT_ULL(0));
+	/* Enable mailbox interrupt for msgs coming from AF. */
 	otx2_write64(pf, RVU_PF_INT_ENA_W1S, BIT_ULL(0));
 
 	if (!probe_af)
-- 
2.53.0

