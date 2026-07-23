Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98DC11DA62E
	for <stable@vger.kernel.org>; Thu, 23 Jul 2026 01:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784769418; cv=none; b=kdyzJ6d33G3zCAgfgv8YzCe7U1Z8q62NNiSTIP9spSJZHSfMPv3amVASprG3hIIacplfrRCMW7s1Xw1wIkg5k3TDwLu2tjuh83udgyIAOWWOxZSRF9B2OCcuHqo+bxxiHADqL6wuZ9JiXDnUhVRpKAdYfI+pzo8sICwWcJQFiKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784769418; c=relaxed/simple;
	bh=XBXzvxjS5SZ26ScVgj36kZXkiliK1Y51nFJk2UxLh1o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kkhK0PXpwClUH5cD3Pd5+Vg7rheY1VbYNOIJCb0rukHPMz5mu1CBrfNWrYRKTTOMkVYxG0w2qfY5Q0u+rbT8Y+CTa7VQU2lB05+2yepAshSnFBZ4LlcWU2ZqL/W4IA+AP1KVfXLnx4G1GL9XxeEYteXxNzi9wE2JNIFg8w0YdwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P4yBd7T1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P4yBd7T1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0D3E1F00A3A;
	Thu, 23 Jul 2026 01:16:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784769417;
	bh=Trs89ZnsflthFxRy50KESNw/UIDNvZiyRLm/4sfJ+dc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=P4yBd7T17o7vvK4CTFpdpainU+ruzK9ULHGXcKbD1memgz0xNCTu4wiz88Ga7SkCn
	 sfHbLsxPkzPAM/RQ2TSeISWfwiAJLdvKV6xVAkGjtFt52QN8TBZI+YUG+gA15H4tVo
	 xrkZI9hkqP1t47xwo/Y8brI46mirAGDpXlueK/IBXq++xUQgx7CtGrwp7H7bc2Ohq6
	 2YGY0MhgmLSEkwQldSEqPHWuqvOte8kz4C2zRIMwybA8AJb+ggjA9i/Jo3iNrmhWwj
	 VEIeQItvTsaCFyQQG9F9uX2ZdSUSRsR+DBW9HmfObpHU01glPLd2fSbBVmf7Vk4kpk
	 EDinc7IOHES+w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Subbaraya Sundeep <sbhatta@marvell.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/3] octeontx2: Annotate mmio regions as __iomem
Date: Wed, 22 Jul 2026 21:16:53 -0400
Message-ID: <20260723011654.2779504-2-sashal@kernel.org>
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
index 187c66fb2458c2..5d94f7069f23df 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
@@ -2237,7 +2237,7 @@ static inline void rvu_afvf_mbox_up_handler(struct work_struct *work)
 	__rvu_mbox_up_handler(mwork, TYPE_AFVF);
 }
 
-static int rvu_get_mbox_regions(struct rvu *rvu, void **mbox_addr,
+static int rvu_get_mbox_regions(struct rvu *rvu, void __iomem **mbox_addr,
 				int num, int type, unsigned long *pf_bmap)
 {
 	struct rvu_hwinfo *hw = rvu->hw;
@@ -2262,7 +2262,7 @@ static int rvu_get_mbox_regions(struct rvu *rvu, void **mbox_addr,
 				bar4 = rvupf_read64(rvu, RVU_PF_VF_BAR4_ADDR);
 				bar4 += region * MBOX_SIZE;
 			}
-			mbox_addr[region] = (void *)ioremap_wc(bar4, MBOX_SIZE);
+			mbox_addr[region] = ioremap_wc(bar4, MBOX_SIZE);
 			if (!mbox_addr[region])
 				goto error;
 		}
@@ -2285,7 +2285,7 @@ static int rvu_get_mbox_regions(struct rvu *rvu, void **mbox_addr,
 					  RVU_AF_PF_BAR4_ADDR);
 			bar4 += region * MBOX_SIZE;
 		}
-		mbox_addr[region] = (void *)ioremap_wc(bar4, MBOX_SIZE);
+		mbox_addr[region] = ioremap_wc(bar4, MBOX_SIZE);
 		if (!mbox_addr[region])
 			goto error;
 	}
@@ -2293,7 +2293,7 @@ static int rvu_get_mbox_regions(struct rvu *rvu, void **mbox_addr,
 
 error:
 	while (region--)
-		iounmap((void __iomem *)mbox_addr[region]);
+		iounmap(mbox_addr[region]);
 	return -ENOMEM;
 }
 
@@ -2303,10 +2303,10 @@ static int rvu_mbox_init(struct rvu *rvu, struct mbox_wq_info *mw,
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
 
@@ -2327,7 +2327,7 @@ static int rvu_mbox_init(struct rvu *rvu, struct mbox_wq_info *mw,
 		}
 	}
 
-	mbox_regions = kcalloc(num, sizeof(void *), GFP_KERNEL);
+	mbox_regions = kcalloc(num, sizeof(void __iomem *), GFP_KERNEL);
 	if (!mbox_regions) {
 		err = -ENOMEM;
 		goto free_bitmap;
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
index 803f40a2bdc19b..3a57fdac7698bf 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
@@ -601,8 +601,7 @@ static int otx2_pfvf_mbox_init(struct otx2_nic *pf, int numvfs)
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

