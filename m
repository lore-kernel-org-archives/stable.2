Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4165A41DDE5
	for <stable@vger.kernel.org>; Thu, 23 Jul 2026 11:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784806629; cv=none; b=XCmiSLOOFyQJxYBN0kEDx7Xyvzph2kdwDYWpCGaob3iau4zmhL7mEfmvrS/EWKv0iMmeVgRYvdDtOAxZ/co9Z0FzvFc3lAzQVpM4Vv0mJF3NB6xH7FfsmvIZHOsbEjoCY04fJMKXSvo6ekaUbWmP28fSLWmCiggNiVreV4aMTP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784806629; c=relaxed/simple;
	bh=hvB6QdamABiyqbG8gOOLKTC0KLwtT3GfUK3JRAvS3qw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=drAWX/Ym/KgcgyKYYvGmQDrui43sJ/N9LsyyrHTxYlo7XWfaO6ndmrdHncs28tbuwZlVwxnSf8gO0np3fO+YTi0KzBJDdkEzzEJCS7/Ud4f6zP8Vne8pxIYp9BJLqfEmTSd1octRjOl5FfRnTd66ASOswqop1A+pHlCQw0rqXiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bYI3sAzW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bYI3sAzW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4232C1F00A3E;
	Thu, 23 Jul 2026 11:37:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784806627;
	bh=E3F2nBCcKLX6ZbjU9v/VhgxMeJj4ZYe1vsGNKBvYCZI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bYI3sAzWghsp55/5Go5CnR4RGNpp6M56LD3mG4VEUmlAnN20YW0KofoQj2xbhiPy3
	 4nCFytPl1LzcMwR49xyg7lNRczRMqrKSStQrk3TFOlo58eA03SAHScZ9AXqz8xsy6B
	 uRiDZpHuGhZkUgZPW9P1zexg5VtcKAV9dT8gO7204BBsQbhcX/3MRJjeE93ca7L/Hh
	 5dPxm2vfVld0iZyoQEiUFZOVTwD74wimoYD/MmEr3ZcKVAuH4Xa/FPt3Zsaf0LyT+d
	 rwGsIBujehwP1fv5O8DFQas2bn1qXwhypNu+K1ed0xFIGZRaAaG4AQyxp8ggUb6zA4
	 Cq9tgl3xZghQA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Runyu Xiao <runyu.xiao@seu.edu.cn>,
	Simon Horman <horms@kernel.org>,
	Ratheesh Kannoth <rkannoth@marvell.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] octeontx2-vf: clear stale mailbox IRQ state before request_irq()
Date: Thu, 23 Jul 2026 07:36:55 -0400
Message-ID: <20260723113655.3034945-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072024-ammonium-uncross-b30b@gregkh>
References: <2026072024-ammonium-uncross-b30b@gregkh>
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
index 5310b71795ecd4..c0d4a8f726285d 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c
@@ -230,6 +230,9 @@ static int otx2vf_register_mbox_intr(struct otx2_nic *vf, bool probe_pf)
 	char *irq_name;
 	int err;
 
+	/* Clear stale mailbox interrupt state before installing the handler. */
+	otx2_write64(vf, RVU_VF_INT, BIT_ULL(0));
+
 	/* Register mailbox interrupt handler */
 	irq_name = &hw->irq_name[RVU_VF_INT_VEC_MBOX * NAME_SIZE];
 	snprintf(irq_name, NAME_SIZE, "RVUVFAF Mbox");
@@ -241,10 +244,7 @@ static int otx2vf_register_mbox_intr(struct otx2_nic *vf, bool probe_pf)
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

