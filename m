Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AB384399EE
	for <stable@vger.kernel.org>; Wed, 22 Jul 2026 18:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784743682; cv=none; b=jmm8J2BSiayGHiq1MvVueys+uuvjsYNX3KQ4aAthHvFfiyP70Jr2t3vH0KCQLGiY3u/VHv5WZ0cOGQA3u/bTZxHvzMI4aLxoGircXIHa/+o9E0lNzcFb2Z6Fi1Dkw6YtXLNElBgZVQ0XkLg2HeJRGo3jxfkoWmxh6r1Lx+fjaQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784743682; c=relaxed/simple;
	bh=lTWm+61S6XxN4kSceDayayQrGTloILGxRK87/1AwWao=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ir176xhiE70hZYEmJvPsVLeLNzSOThiVKrGtzWE8/iYjSSujMXPRl/UfftwHK1gXLjQndfeUY534iUN5vd5hM+DrPmeLmORMzJFYE2AauyURJBMCC9DTCpwJKTF7Xy13/T5YgjbaP42HqQkyvBMuxsiiHcwbPkChN8pye+cDJI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m8fw66tO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m8fw66tO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25CF21F000E9;
	Wed, 22 Jul 2026 18:08:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784743680;
	bh=AlWaOPrZTjF9MtMkvgtMbi1LaO8gUE0XgE0fz3zp/2I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=m8fw66tOaW7FdzVi2mRq0z9w1jj1m1Ri9LneZ06y8pdlLH4Wld/oP2+4kWtoYGVAB
	 0nB/6a0QwG3sIhr0mvS9FuqwEW+YgEUN9C1apgKvdtBwPbIgyi9P/eX0/6XatbszIn
	 S8r396MrhnUTTItOe1ZkATq3xPIk/aJ5w1Kx9uc/HlYzgK+q7wBImOhQOamrZFzKLI
	 kfCOfEBj0SNms3xdNnPYWmd6wlqhusE0VZ61WsVWmYH7L/aEAlLX+1w1ltLJEDdcKG
	 IAjPI4ObBbJ5TNkKxQ+1wTsy/FEdCHvbdRPn3kMQX01cHdbTEKHFJrvqeQnVO7GyUF
	 i+If+LBviauDQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Runyu Xiao <runyu.xiao@seu.edu.cn>,
	Simon Horman <horms@kernel.org>,
	Ratheesh Kannoth <rkannoth@marvell.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/2] octeontx2-pf: clear stale mailbox IRQ state before request_irq()
Date: Wed, 22 Jul 2026 14:07:57 -0400
Message-ID: <20260722180757.2202348-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260722180757.2202348-1-sashal@kernel.org>
References: <2026072013-trivial-overlaid-d42a@gregkh>
 <20260722180757.2202348-1-sashal@kernel.org>
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
index 9274c60ddeedb8..942a18d4619d0f 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
@@ -1023,6 +1023,9 @@ static int otx2_register_mbox_intr(struct otx2_nic *pf, bool probe_af)
 	char *irq_name;
 	int err;
 
+	/* Clear stale mailbox interrupt state before installing the handler. */
+	otx2_write64(pf, RVU_PF_INT, BIT_ULL(0));
+
 	/* Register mailbox interrupt handler */
 	irq_name = &hw->irq_name[RVU_PF_INT_VEC_AFPF_MBOX * NAME_SIZE];
 	snprintf(irq_name, NAME_SIZE, "RVUPFAF Mbox");
@@ -1034,10 +1037,7 @@ static int otx2_register_mbox_intr(struct otx2_nic *pf, bool probe_af)
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

