Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 074F538F931
	for <stable@vger.kernel.org>; Mon, 15 Jun 2026 21:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781558022; cv=none; b=pvjvAp6p1uwHnwJWtGjgCPNQS2TTQycnAOCqyZfCT6eSARBOzZtE3WRwQlfdTeRuwCRgnp1IvyJ7+TJNkpgWW9vO/8OvYt7har8V7PFfGZVN9qiaHogMejt+NJOukp0xpwImric6X5s/WUxfVX/S8nu3P3jsUoWq2q2hN+1+n7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781558022; c=relaxed/simple;
	bh=XX9NREEVL4LcB2J0tgseR8DPRAVA2lLy4m5DDY7AohU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VII0PDYgpjAQYDZnlr9bFMG33XTpUctx9s5YkkgYgxIRRK29N1ocKKegns4dI4YKT8SIw/VvlRIL7q/ZbkApx2oCF78uwNMeErWzr/PbCFORvRToW6RJX3PBSgMIw//7RZ4X72oMdETaUNfwX6myqGm8MHgwtMJQUMMlSpSDC+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oyd6G1rq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oyd6G1rq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BF141F00A3E;
	Mon, 15 Jun 2026 21:13:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781558019;
	bh=KFjx4yAs8YVVPzl3rDzoomN4IkY3u5v7ji1eWL/E2ZQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=oyd6G1rq51edjUTfm4KPDZw8usYRCdZwVupwqGlCBpLXtT/IBHi5pDaJ7tel1CNRe
	 KjevasrWobAuHuMox0AVWYa40STRKVz3P9+qzpz0tCaskkIqWvbe7ga0/8FHTEtbYQ
	 3JmWYo9yllGnFrT47A2fQeyS3pXPcvtfvXNES948NMm31gW12iZ/aFDOyGZt4fbmVh
	 3qCdZlqcXuxZJxcrVlX3+AsWATqhxICQ/kyxxHDa6tZjcNsQ8kVJxLtoEnV+GMU4ZO
	 qaNkn5DlVuPCs3gvfM5HduBFmry53a73q7kBKZLP20wrPgotyZ8PgNcuAsslIpdodQ
	 Ox+0H7Z0hP4KA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jason Gunthorpe <jgg@nvidia.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.0.y 3/3] RDMA/umem: Fix truncation for block sizes >= 4G
Date: Mon, 15 Jun 2026 17:13:36 -0400
Message-ID: <20260615211336.2459359-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260615211336.2459359-1-sashal@kernel.org>
References: <2026061503-brunette-twelve-6cba@gregkh>
 <20260615211336.2459359-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Gunthorpe <jgg@nvidia.com>

[ Upstream commit 15fe76e23615f502d051ef0768f86babaf08746c ]

When the iommu is used the linearization of the mapping can give a single
block that is very large split across multiple SG entries.

When __rdma_block_iter_next() reassembles the split SG entries it is
overflowing the 32 bit stack values and computed the wrong DMA addresses
for blocks after the truncation.

Use the right types to hold DMA addresses.

Link: https://patch.msgid.link/r/1-v1-88303e9e509f+f7-ib_umem_types_jgg@nvidia.com
Cc: stable@vger.kernel.org
Fixes: a808273a495c ("RDMA/verbs: Add a DMA iterator to return aligned contiguous memory blocks")
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/core/iter.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/core/iter.c b/drivers/infiniband/core/iter.c
index 8e543d100657ee..3ed351e8fcf6c9 100644
--- a/drivers/infiniband/core/iter.c
+++ b/drivers/infiniband/core/iter.c
@@ -19,8 +19,8 @@ EXPORT_SYMBOL(__rdma_block_iter_start);
 
 bool __rdma_block_iter_next(struct ib_block_iter *biter)
 {
-	unsigned int block_offset;
-	unsigned int delta;
+	dma_addr_t block_offset;
+	dma_addr_t delta;
 
 	if (!biter->__sg_nents || !biter->__sg)
 		return false;
-- 
2.53.0

