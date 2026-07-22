Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DDAC339360
	for <stable@vger.kernel.org>; Wed, 22 Jul 2026 23:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784762484; cv=none; b=uEJ1pbyI/WL7cLzYeK29L5RMw6+2dzavFg0cJbGW5gIUsVrYiJ/wq7dV2Dk2oC9iIQIgbboRnxEzrdz4Wuei7UwJ/YXtpXpVLDEsZpG0W6sq27zdjzchg4uAox4lHs//9xEyadV5B6Y8t1xC0UqgzBTaLnIIxrn+3e5PFqnVLpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784762484; c=relaxed/simple;
	bh=gsEVS38JQwx1FFceEI/dL0E9LNXpj2ZfKsk/4AzsJHw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L9QUTUeban0Yq1cGwI55y/FZeDBiOXA2D+puj5fKjEYQP9zi0Nh4qyOzvguZBOX32lDiN3HOzTHUADqkZvsdBC+hu1ZUgcH5Ao3A4kGgpvF7T6YYu5WTsaRTgeXRT5RtARyCe1vY6FK8nECncEReoAjly2idBHyRqdwoS5rko4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YBJOAdNx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YBJOAdNx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71CC91F00A3D;
	Wed, 22 Jul 2026 23:21:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784762482;
	bh=hzDm+nlNNOrsrDvbTGWQKd5DgliWjVnAfYVZagGgIww=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YBJOAdNxs3DasOpumDpfror1sQvVfcDhW9gfu1ts50APzjnHF+J0chm8OXG0fL2tZ
	 6rqrlbxJQNo8KnmGv6yXzUHx9tYNRhZlEFt4G6YoHmChuJsBG3Gdx4qUGD8ggH0lVu
	 hp1F5Lkev61rfYI2aSVPVlAGe5YVScbaIv5y42m+vsv6sLzv5R74CpHTt/STnjXoeo
	 ENL6azgxbBH9REUDA/jxN+ChoS/mycWMWnrtcxZDhP70BeuA3quRRGscgtXwi0FYrI
	 asVKyDb9IyeEkYXN79f5Ss9C0t0poPuuln+eqyDxDMYreUrAs7Fp0JBZUwTXBQXsk7
	 QuySk5gioNVUg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Runyu Xiao <runyu.xiao@seu.edu.cn>,
	Simon Horman <horms@kernel.org>,
	Ratheesh Kannoth <rkannoth@marvell.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/2] octeontx2-pf: clear stale mailbox IRQ state before request_irq()
Date: Wed, 22 Jul 2026 19:21:19 -0400
Message-ID: <20260722232119.2551122-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260722232119.2551122-1-sashal@kernel.org>
References: <2026072013-calamity-cruelness-377d@gregkh>
 <20260722232119.2551122-1-sashal@kernel.org>
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
index 4a48ff725603f4..d09c944c8dba2e 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
@@ -1027,6 +1027,9 @@ static int otx2_register_mbox_intr(struct otx2_nic *pf, bool probe_af)
 	char *irq_name;
 	int err;
 
+	/* Clear stale mailbox interrupt state before installing the handler. */
+	otx2_write64(pf, RVU_PF_INT, BIT_ULL(0));
+
 	/* Register mailbox interrupt handler */
 	irq_name = &hw->irq_name[RVU_PF_INT_VEC_AFPF_MBOX * NAME_SIZE];
 	snprintf(irq_name, NAME_SIZE, "RVUPFAF Mbox");
@@ -1038,10 +1041,7 @@ static int otx2_register_mbox_intr(struct otx2_nic *pf, bool probe_af)
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

