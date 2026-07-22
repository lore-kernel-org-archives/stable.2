Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE7243368AE
	for <stable@vger.kernel.org>; Wed, 22 Jul 2026 23:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784764026; cv=none; b=AaVHCDrxbPL6PgyciXAtVa7pn8HhEQQV1xxBQYLGxxpCUZO2E1Fy8Y1uGinLP4B6mHxBN/MYNLzcz4LTYW4Xbm5jX6TQaEWKj3wt4/EQlCiomBRxSW4LTRM4rYUV7LfwNdW4NScA/IAQJAuEHmc9cGJG+3AgFDByfXvwm3YZyiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784764026; c=relaxed/simple;
	bh=UXQu/6ja65iOw0iINXanp/XdQ0cTlTaWb/eLjksbiXA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X4RKvSAKDeX2038X4ohaTM/+/vWp6dAUp+Ly3f2R6pkU4anwHH3jRW5E2vo527a3ZPdXkE2wyb0cpsaDZUo9WGA4eLdMhWyFx1wYeiS+//nkO4lpSJ3/oXHvJYkJ7VaWaUZmOP+a1+4iMUg2nm89aM+Go6pNxQFucGDca8JGtjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nign6vrd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nign6vrd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 242911F00A3D;
	Wed, 22 Jul 2026 23:47:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784764024;
	bh=Gg7/tPU6Y6sKuDLi3W2mbL4NUJ3eaqdthi6WUq0i7eM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nign6vrdPi/7nNBPNNuJ7y3UNoD7I/JrzlL+kSF/jthRgH5My1hwQfSuzRMUMuqT+
	 c1Hd4a6FL3fRJ96254/NUcKEWahylXr64YMzmH5UJtFIdgdcLCrUE2I40swhP+ZKdW
	 mq07jSou7nOsrjAVs9ae5VIiIrxg7781BOF/ZapYsz+mosh0Rb+/TJgn7XgNDikKvs
	 11VUhQ1t+guCibKz5WJJ6ujCE88kVktU5IAKtfIt2k8T3onJ8NjgAi4OBRWuvd5kMz
	 wgTsPeRrVLNTcIon9q163qXkYG/LaNGSZOoIlWUxoeJh/PV+QQFGI+A109fZx6pipr
	 nwlM8AKGOEbUg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Subbaraya Sundeep <sbhatta@marvell.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/2] octeontx2: Annotate mmio regions as __iomem
Date: Wed, 22 Jul 2026 19:47:01 -0400
Message-ID: <20260722234702.2612616-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072013-groom-shrine-8b5d@gregkh>
References: <2026072013-groom-shrine-8b5d@gregkh>
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
 drivers/net/ethernet/marvell/octeontx2/af/rvu.c      | 12 ++++++------
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c |  3 +--
 2 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
index 3bb035c60339b0..22952e5741c10d 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
@@ -2329,7 +2329,7 @@ static inline void rvu_afvf_mbox_up_handler(struct work_struct *work)
 	__rvu_mbox_up_handler(mwork, TYPE_AFVF);
 }
 
-static int rvu_get_mbox_regions(struct rvu *rvu, void **mbox_addr,
+static int rvu_get_mbox_regions(struct rvu *rvu, void __iomem **mbox_addr,
 				int num, int type, unsigned long *pf_bmap)
 {
 	struct rvu_hwinfo *hw = rvu->hw;
@@ -2354,7 +2354,7 @@ static int rvu_get_mbox_regions(struct rvu *rvu, void **mbox_addr,
 				bar4 = rvupf_read64(rvu, RVU_PF_VF_BAR4_ADDR);
 				bar4 += region * MBOX_SIZE;
 			}
-			mbox_addr[region] = (void *)ioremap_wc(bar4, MBOX_SIZE);
+			mbox_addr[region] = ioremap_wc(bar4, MBOX_SIZE);
 			if (!mbox_addr[region])
 				goto error;
 		}
@@ -2377,7 +2377,7 @@ static int rvu_get_mbox_regions(struct rvu *rvu, void **mbox_addr,
 					  RVU_AF_PF_BAR4_ADDR);
 			bar4 += region * MBOX_SIZE;
 		}
-		mbox_addr[region] = (void *)ioremap_wc(bar4, MBOX_SIZE);
+		mbox_addr[region] = ioremap_wc(bar4, MBOX_SIZE);
 		if (!mbox_addr[region])
 			goto error;
 	}
@@ -2385,7 +2385,7 @@ static int rvu_get_mbox_regions(struct rvu *rvu, void **mbox_addr,
 
 error:
 	while (region--)
-		iounmap((void __iomem *)mbox_addr[region]);
+		iounmap(mbox_addr[region]);
 	return -ENOMEM;
 }
 
@@ -2395,10 +2395,10 @@ static int rvu_mbox_init(struct rvu *rvu, struct mbox_wq_info *mw,
 			 void (mbox_up_handler)(struct work_struct *))
 {
 	int err = -EINVAL, i, dir, dir_up;
+	void __iomem **mbox_regions;
 	void __iomem *reg_base;
 	struct rvu_work *mwork;
 	unsigned long *pf_bmap;
-	void **mbox_regions;
 	const char *name;
 	u64 cfg;
 
@@ -2421,7 +2421,7 @@ static int rvu_mbox_init(struct rvu *rvu, struct mbox_wq_info *mw,
 
 	mutex_init(&rvu->mbox_lock);
 
-	mbox_regions = kcalloc(num, sizeof(void *), GFP_KERNEL);
+	mbox_regions = kcalloc(num, sizeof(void __iomem *), GFP_KERNEL);
 	if (!mbox_regions) {
 		err = -ENOMEM;
 		goto free_bitmap;
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
index 6f1da4296ad5ef..7cdb108e3d8c48 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
@@ -596,8 +596,7 @@ static int otx2_pfvf_mbox_init(struct otx2_nic *pf, int numvfs)
 		base = pci_resource_start(pf->pdev, PCI_MBOX_BAR_NUM) +
 		       MBOX_SIZE;
 	else
-		base = readq((void __iomem *)((u64)pf->reg_base +
-					      RVU_PF_VF_BAR4_ADDR));
+		base = readq(pf->reg_base + RVU_PF_VF_BAR4_ADDR);
 
 	hwbase = ioremap_wc(base, MBOX_SIZE * pf->total_vfs);
 	if (!hwbase) {
-- 
2.53.0

