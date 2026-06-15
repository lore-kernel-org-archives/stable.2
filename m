Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CDAC36E48C
	for <stable@vger.kernel.org>; Mon, 15 Jun 2026 23:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781567933; cv=none; b=N572Uir0MZyi6y6NSRkClWCLWyr2jGalvwcOY2rMy3rYdCHH/u+3Ewsb1zBs0DKsF7ecZmJZZNOz1u1f0MVkmLGA5m/HadtTENuZ0JZUgngBdjyn1xwrMNllIEny9No0zE16evYFolDYh2rBl9QcahhX/niqucrEwOTFknUMZQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781567933; c=relaxed/simple;
	bh=XX9NREEVL4LcB2J0tgseR8DPRAVA2lLy4m5DDY7AohU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MObW05v68NW/D9Qt5nl059aTAN/PZgnIAogqO5UXIMO7/BxfSNL18MgSV5fAYGtACVyhFr39SlDxVtvUKbbOoQN9cyim7BAxbCLCEkGvstA6N8kNR3WuBvNl8s1QSsxrmZydiU5EykIEARhLc/If+73ikrbSOBxJhOosDpmhUpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TIKd9O/3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TIKd9O/3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA2E41F00A3E;
	Mon, 15 Jun 2026 23:58:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781567932;
	bh=KFjx4yAs8YVVPzl3rDzoomN4IkY3u5v7ji1eWL/E2ZQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TIKd9O/3OA3lNwbXYG/djmPO4oLnwm8r7l8+PQwzGUs+akPUn/BkbplOTb1oGYJ2f
	 wU//YUo7n8fHJ4yv4Bdh+GiFdOwtK5nGd468QiMqIX1nV0DyNcw8JmI/q63CgPH3DR
	 CmucdjqoRXTtoZHOYCYztSQQWayROcgNJ3hnP9HlpvhYDIk6Zn2yANEi3vA9GZEvYr
	 PvL0YHHpvd2V7eCqNAePR7pTZncROv8EV0ZtDQSbRM6R/ufwIGHeko1nQO/sUIYi0G
	 T+Rc0ma5ed7JdIh/Q95ULYL2kL8M4vZRTbBTAtzWr+NlE8+O/MUg7QYWEoY2bXLtM+
	 NOR/xszg7P9Pg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jason Gunthorpe <jgg@nvidia.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 3/3] RDMA/umem: Fix truncation for block sizes >= 4G
Date: Mon, 15 Jun 2026 19:58:48 -0400
Message-ID: <20260615235848.2562462-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260615235848.2562462-1-sashal@kernel.org>
References: <2026061508-amuck-winner-adaf@gregkh>
 <20260615235848.2562462-1-sashal@kernel.org>
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

