Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A4D1217F27
	for <stable@vger.kernel.org>; Tue, 16 Jun 2026 00:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781569195; cv=none; b=oEhSrzCIg4M/xveMm1dZGTgBFRBpA0SanQ927UZhRZnLrxkL80iLjCD4tYggXgAsXVStRBi3cIcoi3EgDZ3UpVXiHhpGOYqg1RQex1Qz2emDC2rNXDsUyLV68FKkNdZkGbERl1Y4cI260p3SQ+q8CsK5mfbDh66EUmKGLingmGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781569195; c=relaxed/simple;
	bh=XX9NREEVL4LcB2J0tgseR8DPRAVA2lLy4m5DDY7AohU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BHEbpcAAKtNcgI5iBqmkPT+tjetitrzzFMwciv0x8MwVkU6fzSx9Qwp6VqVq01+jTIMKpA02756lmHAUaZ/tD/MgUdBNH1r6tAFF6wTtcGfxmkAbFKJxkdiWNb3gtO/X4WZVjVdowXHHstNiP8uMc9aood99nPysnVrsNFMXPaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l8XajbFJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l8XajbFJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7F3D1F00A3A;
	Tue, 16 Jun 2026 00:19:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781569194;
	bh=KFjx4yAs8YVVPzl3rDzoomN4IkY3u5v7ji1eWL/E2ZQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=l8XajbFJsPL0pYBJt8V37b1k/hjgFgNZG4DsuxB3q1C8jDpR/Wg/7DpLvlFuHP4Hx
	 JNJzT0W/bJ5oStKSaAMfzsZljjVxAuAbxaX+cuEo+8cgw3VXoCcrAHKPqSyW9x3Zw9
	 z3Qk02Ow/0yFoF9llMAglC+vVYSNjZq7Ip2Rw+7gNGEUtrVt5RGovNFRPkkGJcK9og
	 nJRTgTrJsiiYwpBHYOT8S646wKucFKDn4UuR0kCb4s7zLrCwmOkHfJCB7iYRIRbDQm
	 9g/HDe2MgXpLX1H+ihvHZFGDLq31hcOC+9Qklr+wGcO8BqukNy2zaHAsWvOGbOZMDv
	 wOCTP5MaruWXw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jason Gunthorpe <jgg@nvidia.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 3/3] RDMA/umem: Fix truncation for block sizes >= 4G
Date: Mon, 15 Jun 2026 20:19:50 -0400
Message-ID: <20260616001950.2587230-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260616001950.2587230-1-sashal@kernel.org>
References: <2026061510-undamaged-opulently-daf3@gregkh>
 <20260616001950.2587230-1-sashal@kernel.org>
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

