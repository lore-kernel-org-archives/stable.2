Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAAD118CBE1
	for <stable@vger.kernel.org>; Thu, 23 Jul 2026 01:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784769432; cv=none; b=Yp3DpxNkYEgH/GUoQqSprx16qf98tnhF89sQkZh8zo3WrG6JuEN/JEeG/lGWX0pmdTRLpAABRj/EFo7zl6nmS71gwyrz736ZEIJlfQmPC3BuOzdvDT8VLTBVEiP+j9BM2081Qd4/Wq+9aVz73cPDAQr+jI1tmLBVNJ2/KDAOzfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784769432; c=relaxed/simple;
	bh=FaZi7HyhkcxuD+ZU/MkVCfmZ93wgxmH9GkDWVADWSpo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fQ0DwGmXJP6ir+hRx4T7KEkld1UWDRUqL8T+lUsD/eT7FbvKSjhl0pAlQjCFqtTwM7nPqJowaK0VqI0vdAqzZMX2PlxG5bMqLNFQL1nfA0ZfB+1YF/WB8RSQJHyye9M+TyyrU/NqDKKDQx+sc2nExR3ZaHY1RR8nm7/jwTpkhTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kpocDRjY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kpocDRjY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8C1C1F000E9;
	Thu, 23 Jul 2026 01:17:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784769427;
	bh=PN6/U3NTa2UwyddkIDi399MZlIwexeTj0bGh+e/ytWw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kpocDRjYmYG9J0rpG/7BYhJOQUUCw+ClexsaNzKH+XVP4ss8JyjL4tzUq1GYdo5C5
	 tbvso60L+fbWQiJnhcx6FtehWYb1xn9v6jL1p0yEBhB2PBbu/L0Ag5PQWxg+t7HkoV
	 2zjQAHjsKYSAyyi1AZKsQmOtZpPf2WrNgsV7iF+3Du+pPNkU4sDp3O0VFrlLaWR1md
	 owKxBqD1Ux8MG0ANs5Ht1olUCuAjbzlClZhHfiur3Wg/NhS4aBFdV/bXDY7j/E5GiJ
	 kLZKSrOX0KX0hVWwHD65HjyUkQmeIX4ZcivxluShK/WOFHjNXZbpn9KZBAo4R9FdYf
	 YsBjX52HksbNQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Subbaraya Sundeep <sbhatta@marvell.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/3] octeontx2: Annotate mmio regions as __iomem
Date: Wed, 22 Jul 2026 21:16:56 -0400
Message-ID: <20260723011657.2779635-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260723011657.2779635-1-sashal@kernel.org>
References: <2026072024-facing-mammary-40dd@gregkh>
 <20260723011657.2779635-1-sashal@kernel.org>
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

