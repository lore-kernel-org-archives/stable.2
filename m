Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AEFA18CBE1
	for <stable@vger.kernel.org>; Thu, 23 Jul 2026 01:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784769418; cv=none; b=THFxqLKHok3ooOzGYaajYLiWrLkfLmIMHDbQ22Hg8dE+H1vYTy7HAx+55iGv6gJ2NpFvDpftaO1RC/75xVzVPv+NNRuY8MEZpWXVCnoDe2oVxKiMIk5iry1IYgN0jRynmXWSEnYFR5ZhXjtJB+eZ7gZE/rnk6nADa1+BvdTmMdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784769418; c=relaxed/simple;
	bh=CmqBGV3/z8ozO2Rr6EP2fr5UMMQWX+XEjyzXwcLnBE8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LWR4GKHhbbldCZ4bhwbzlJOXUl5ISTTRewOCOkIiXLhMzSqL1Sd8ecTQRnxxSKeXA/SWWA4Zhp9VSY8UvtY+zFZVQAkyn2+EIUA+cr9FjUb7yWTW2yPBILMXd5KWUcDWuz1SBuV08OegV5/tESuLmZ+fOEWqQLMv6ppfhRb/jmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cnBfYQut; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cnBfYQut"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B53D1F000E9;
	Thu, 23 Jul 2026 01:16:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784769416;
	bh=9xAMGpLNQL9AuoO4dN7oS0ABHqbfyrXHVUZuNrTmjH8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cnBfYQutkEJ1bVCPt385Ub2li55EfSQu8WymMKM8N3yI4wtwlfHAwHRAcNUDDUcpB
	 9iZfiVzr5PlPfagPrOiDOYRSEo+ddJLqz6lrPgYfN72Fzl+fh8/8dQB12a7UT6PsOF
	 8OymdpoBIC7sU2pdzURO79yh8v4H1/qrDCFNtpaIYBmyZBaXljiar4rfZOrTygSuDd
	 yX6URSPCHvrsTuLu42lS6KYCD3wOERifBDAjf7KOQvTrZfrzUCjY4JfsS9uCl8eOVA
	 qKsG2MKiy+VeNLjWUXnL2+Hwxza3Cp8lrucuuVwL5+o+b4vLDxd2ObVRldCb5SsLyu
	 CbrlUyftrtLYQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Geetha sowjanya <gakula@marvell.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/3] octeontx2-af: Fix APR entry mapping based on APR_LMT_CFG
Date: Wed, 22 Jul 2026 21:16:52 -0400
Message-ID: <20260723011654.2779504-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072014-obscure-tattoo-f4b2@gregkh>
References: <2026072014-obscure-tattoo-f4b2@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geetha sowjanya <gakula@marvell.com>

[ Upstream commit a6ae7129819ad20788e610261246e71736543b8b ]

The current implementation maps the APR table using a fixed size,
which can lead to incorrect mapping when the number of PFs and VFs
varies.
This patch corrects the mapping by calculating the APR table
size dynamically based on the values configured in the
APR_LMT_CFG register, ensuring accurate representation
of APR entries in debugfs.

Fixes: 0daa55d033b0 ("octeontx2-af: cn10k: debugfs for dumping LMTST map table").
Signed-off-by: Geetha sowjanya <gakula@marvell.com>
Link: https://patch.msgid.link/20250521060834.19780-3-gakula@marvell.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Stable-dep-of: f918554fb724 ("octeontx2-pf: clear stale mailbox IRQ state before request_irq()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/marvell/octeontx2/af/rvu_cn10k.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_cn10k.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_cn10k.c
index 39870e419ccb04..49cb5b03e8f369 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_cn10k.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_cn10k.c
@@ -13,7 +13,6 @@
 /* RVU LMTST */
 #define LMT_TBL_OP_READ		0
 #define LMT_TBL_OP_WRITE	1
-#define LMT_MAP_TABLE_SIZE	(128 * 1024)
 #define LMT_MAPTBL_ENTRY_SIZE	16
 #define LMT_MAX_VFS		256
 
@@ -26,10 +25,14 @@ static int lmtst_map_table_ops(struct rvu *rvu, u32 index, u64 *val,
 {
 	void __iomem *lmt_map_base;
 	u64 tbl_base, cfg;
+	int pfs, vfs;
 
 	tbl_base = rvu_read64(rvu, BLKADDR_APR, APR_AF_LMT_MAP_BASE);
+	cfg  = rvu_read64(rvu, BLKADDR_APR, APR_AF_LMT_CFG);
+	vfs = 1 << (cfg & 0xF);
+	pfs = 1 << ((cfg >> 4) & 0x7);
 
-	lmt_map_base = ioremap_wc(tbl_base, LMT_MAP_TABLE_SIZE);
+	lmt_map_base = ioremap_wc(tbl_base, pfs * vfs * LMT_MAPTBL_ENTRY_SIZE);
 	if (!lmt_map_base) {
 		dev_err(rvu->dev, "Failed to setup lmt map table mapping!!\n");
 		return -ENOMEM;
@@ -80,7 +83,7 @@ static int rvu_get_lmtaddr(struct rvu *rvu, u16 pcifunc,
 
 	mutex_lock(&rvu->rsrc_lock);
 	rvu_write64(rvu, BLKADDR_RVUM, RVU_AF_SMMU_ADDR_REQ, iova);
-	pf = rvu_get_pf(pcifunc) & 0x1F;
+	pf = rvu_get_pf(pcifunc) & RVU_PFVF_PF_MASK;
 	val = BIT_ULL(63) | BIT_ULL(14) | BIT_ULL(13) | pf << 8 |
 	      ((pcifunc & RVU_PFVF_FUNC_MASK) & 0xFF);
 	rvu_write64(rvu, BLKADDR_RVUM, RVU_AF_SMMU_TXN_REQ, val);
-- 
2.53.0

