Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 105402E7366
	for <stable@vger.kernel.org>; Wed, 22 Jul 2026 23:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784762486; cv=none; b=s6QmRPxQChT43NepvrYBKva8VIKKKJ2rJoUsZ6XdeLAdFo6IRMB46RlUeTK3rCWZqbfvHI1f07fD41ZbUxae+IlEI324MH17cUjHviXI9+rSD9Ls38guONTcaHingo2x3NY0PosBjapRBRnQmcajTeroMGJW/sj/vKP7QWmomuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784762486; c=relaxed/simple;
	bh=tU/9Vxvugn6tuUyojrl+0ub9m8gjhntsD81OhrA0q9o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jd7S89GrQ6sE5zNJQpahhCwWMHRdulVTQKbRbkRF99COBmdb/u0ghgfC7fEvrT9wOCAnGizaBK2x9fMA5/LkeCTvgNO3blYmq2dQwxtl3omJpsuwnpUub3IkMVK0twqS1nIqTcpuLgEKtDP5UnWuzb3e81rCfABApImZ1PbREzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XlhcgSr/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XlhcgSr/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E1F61F000E9;
	Wed, 22 Jul 2026 23:21:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784762484;
	bh=CwLJuw/76S1QD/DsPWhkBLW5inBwgZvNM7ErnfZUv4s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XlhcgSr/xsYI60f7s39PFEESioMBQDBxVqxSmH930DcsUHJQh70xeo5KtzRrpHcZo
	 FfQyoq3rLdEbauOC6QXpPIAM0Zb+DZjB8LBvnOGOQaKTvsU/hg9RHX6i+KQfY9/NQk
	 kMVnJHeWXrM5PFcTCsoXC4Z9iNEIlnT5xD+sKeW1muCZpimRL/yHQHBOZ6LAOrIov1
	 iWPFHuzpxUU/UORmhcy9lreshRotcXvbYFomxUnmKGfpt4h9xOOHXzeoPo+1te22Vt
	 YAxYJm7YF9pLoYiTKisC24RS6sIV4r9xJux6XuGbdYlAlJhyJ1+RwNDwTuT6zBIJDl
	 bifziCNeJecDw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Subbaraya Sundeep <sbhatta@marvell.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/2] octeontx2: Annotate mmio regions as __iomem
Date: Wed, 22 Jul 2026 19:21:21 -0400
Message-ID: <20260722232122.2551218-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072023-cornea-making-1928@gregkh>
References: <2026072023-cornea-making-1928@gregkh>
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
Stable-dep-of: 0b352f04b9be ("octeontx2-vf: clear stale mailbox IRQ state before request_irq()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/marvell/octeontx2/af/rvu.c      | 12 ++++++------
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c |  3 +--
 2 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
index 760dca4d5bfcb8..0691cc63b34e2c 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
@@ -2330,7 +2330,7 @@ static inline void rvu_afvf_mbox_up_handler(struct work_struct *work)
 	__rvu_mbox_up_handler(mwork, TYPE_AFVF);
 }
 
-static int rvu_get_mbox_regions(struct rvu *rvu, void **mbox_addr,
+static int rvu_get_mbox_regions(struct rvu *rvu, void __iomem **mbox_addr,
 				int num, int type, unsigned long *pf_bmap)
 {
 	struct rvu_hwinfo *hw = rvu->hw;
@@ -2355,7 +2355,7 @@ static int rvu_get_mbox_regions(struct rvu *rvu, void **mbox_addr,
 				bar4 = rvupf_read64(rvu, RVU_PF_VF_BAR4_ADDR);
 				bar4 += region * MBOX_SIZE;
 			}
-			mbox_addr[region] = (void *)ioremap_wc(bar4, MBOX_SIZE);
+			mbox_addr[region] = ioremap_wc(bar4, MBOX_SIZE);
 			if (!mbox_addr[region])
 				goto error;
 		}
@@ -2378,7 +2378,7 @@ static int rvu_get_mbox_regions(struct rvu *rvu, void **mbox_addr,
 					  RVU_AF_PF_BAR4_ADDR);
 			bar4 += region * MBOX_SIZE;
 		}
-		mbox_addr[region] = (void *)ioremap_wc(bar4, MBOX_SIZE);
+		mbox_addr[region] = ioremap_wc(bar4, MBOX_SIZE);
 		if (!mbox_addr[region])
 			goto error;
 	}
@@ -2386,7 +2386,7 @@ static int rvu_get_mbox_regions(struct rvu *rvu, void **mbox_addr,
 
 error:
 	while (region--)
-		iounmap((void __iomem *)mbox_addr[region]);
+		iounmap(mbox_addr[region]);
 	return -ENOMEM;
 }
 
@@ -2396,10 +2396,10 @@ static int rvu_mbox_init(struct rvu *rvu, struct mbox_wq_info *mw,
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
 
@@ -2422,7 +2422,7 @@ static int rvu_mbox_init(struct rvu *rvu, struct mbox_wq_info *mw,
 
 	mutex_init(&rvu->mbox_lock);
 
-	mbox_regions = kcalloc(num, sizeof(void *), GFP_KERNEL);
+	mbox_regions = kcalloc(num, sizeof(void __iomem *), GFP_KERNEL);
 	if (!mbox_regions) {
 		err = -ENOMEM;
 		goto free_bitmap;
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
index 784130b4b08655..4a48ff725603f4 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
@@ -597,8 +597,7 @@ static int otx2_pfvf_mbox_init(struct otx2_nic *pf, int numvfs)
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

