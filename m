Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F124E44AB7E
	for <stable@vger.kernel.org>; Thu, 23 Jul 2026 11:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784806599; cv=none; b=GH7K2trb8DSGAKbmXhYVXSMUmHLxYEg0JAvwGJp707HtD9pxFu38N+lU3wz8k64LMZYC4U/9hjpXOe8OJLni1pMJT9H/ZbftnDBgAYsJKMKb+3X1iKlPQ3xcEAVNHUZ2z8bqtxy9BBn3VpgxPDyvmSaRk+jRJavjPijTRxApK6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784806599; c=relaxed/simple;
	bh=p+D/2+yIn1gnboL0y2ON7u+BiKUnJlyas3BIFM6W6As=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q8MLxL773WseuBbFV0yQowN5BJvPOTLN9NVZ4skIbaiJReaBETM2D5aolYCBVVNapPtDSKFt9cZ5Q6Dojroa3YZneLCiYdiluwU4g0LHNmKNtRS8cYbPfg7msa3VwYs38E3bNFlQT/BY9JE7lHSA3Nz3siOdtaMAmEYD7V/nKrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 645BA1F000E9;
	Thu, 23 Jul 2026 11:36:37 +0000 (UTC)
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Subbaraya Sundeep <sbhatta@marvell.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 1/2] octeontx2: Annotate mmio regions as __iomem
Date: Thu, 23 Jul 2026 07:36:34 -0400
Message-ID: <20260723113635.3034593-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072014-quake-amber-fee6@gregkh>
References: <2026072014-quake-amber-fee6@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Subbaraya Sundeep <sbhatta@marvell.com>

[ Upstream commit d0976b43956ee8c8bd093223df9115bfcf63dfe5 ]

This patch removes unnecessary typecasts by marking the
mbox_regions array as __iomem since it is used to store
pointers to memory-mapped I/O (MMIO) regions. Also simplified
the call to readq() in PF driver by removing redundant type casts.

Signed-off-by: Subbaraya Sundeep <sbhatta@marvell.com>
Link: https://patch.msgid.link/1749484309-3434-1-git-send-email-sbhatta@marvell.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Stable-dep-of: f918554fb724 ("octeontx2-pf: clear stale mailbox IRQ state before request_irq()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
index 1516f248377549..747dfa4ee68748 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
@@ -593,7 +593,7 @@ static int otx2_pfvf_mbox_init(struct otx2_nic *pf, int numvfs)
 	if (!pf->mbox_pfvf_wq)
 		return -ENOMEM;
 
-	base = readq((void __iomem *)((u64)pf->reg_base + RVU_PF_VF_BAR4_ADDR));
+	base = readq(pf->reg_base + RVU_PF_VF_BAR4_ADDR);
 	hwbase = ioremap_wc(base, MBOX_SIZE * pf->total_vfs);
 
 	if (!hwbase) {
-- 
2.53.0

