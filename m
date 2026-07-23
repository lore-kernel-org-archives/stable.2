Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D14F21ABD7
	for <stable@vger.kernel.org>; Thu, 23 Jul 2026 01:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784769420; cv=none; b=PZP5DHNNPAMOEHCnD+LXGZwTOPK1Zotc5MLcYKVM/XXn2ozBMm/WqwBUepYceixPzVahrV1evCCAhgDQggtr7y84TSjWxzyIik4SQKEEMHbHt4yIiI8Kfa0HsJF0kfLTaXIpBXY0vXjnGA9ypTwicXhN2aWbC61ukMt+drADYOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784769420; c=relaxed/simple;
	bh=eCPoZee0LgRZWDoQIJDLDYJ4LlNbzjZa2FrsvpCP3vI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pxrOr8IeMVfFI82dcQNOKLy4O1URrR5GKA+vukoR/itcqdrgjFxDoWv4EnDm6VO4Nkkp+1JSnAxIwPUGytmwyaE3SqoGu+0B4DyZyygwit/WE2y8a9GUAtPmAGAosySyKkUCQ9SKg6qvVoLXM3m7sz2ECJxwvX2Pn/SqWSc+HzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZQRm52H8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZQRm52H8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2FBB1F00A3D;
	Thu, 23 Jul 2026 01:16:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784769418;
	bh=5Vc9Pq870Rj7k0HaINObWd/tBZpMuPqeoDRuP3m6UlY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZQRm52H8ZGPWJRD+DwDwO1lXdZtZJqQQsnIestN3gHG9SwmkFd8B/kljOycl8Kg1M
	 Hrz8/jvd6Vn0rCYVN8D/BSrsD6glFhoJ09UBfMF5DvbU05hrK5cGwv17kZzUh3rIee
	 ZGceHqAryohrA2SMyOdlQATHs0dyp4+tV7LA4CcSIfp3SosFrZfBRjALpWH6fGeqne
	 nO6RHCCI78bTCLJ7fVHWYGeaLY2EsPK7Tmim7J3ZQa7434gNyYm3vUokZyJbfV773W
	 0rf4vu/gyxZkrikgZSSl0h4HPIT7JyZsJ5YXd/nBZsdJkyim1cIH3mQ4HwkZhMnQ2R
	 PRxksVWbaCCBQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Runyu Xiao <runyu.xiao@seu.edu.cn>,
	Simon Horman <horms@kernel.org>,
	Ratheesh Kannoth <rkannoth@marvell.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 3/3] octeontx2-pf: clear stale mailbox IRQ state before request_irq()
Date: Wed, 22 Jul 2026 21:16:54 -0400
Message-ID: <20260723011654.2779504-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260723011654.2779504-1-sashal@kernel.org>
References: <2026072014-obscure-tattoo-f4b2@gregkh>
 <20260723011654.2779504-1-sashal@kernel.org>
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
index 3a57fdac7698bf..ade3e0781701eb 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
@@ -987,6 +987,9 @@ static int otx2_register_mbox_intr(struct otx2_nic *pf, bool probe_af)
 	char *irq_name;
 	int err;
 
+	/* Clear stale mailbox interrupt state before installing the handler. */
+	otx2_write64(pf, RVU_PF_INT, BIT_ULL(0));
+
 	/* Register mailbox interrupt handler */
 	irq_name = &hw->irq_name[RVU_PF_INT_VEC_AFPF_MBOX * NAME_SIZE];
 	snprintf(irq_name, NAME_SIZE, "RVUPFAF Mbox");
@@ -998,10 +1001,7 @@ static int otx2_register_mbox_intr(struct otx2_nic *pf, bool probe_af)
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

