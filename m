Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1FBD3AC0DE
	for <stable@vger.kernel.org>; Mon, 15 Jun 2026 21:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781558953; cv=none; b=IcBxiMktx9uNzfoqh9SSFy2RG84Vn8WQ5xajqufFrOUaA1epIp6VqDbbIufwS1LuN4xvmR10+9Ymro3IIpHo2pDc8xnvk6Y+DIVlHGP6DWHf0+aPRCCKhG7YI67Cb5SBmVDW2raFzoeklrG0EKAuwkBeYv/QizoblK9gMVCwTOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781558953; c=relaxed/simple;
	bh=XX9NREEVL4LcB2J0tgseR8DPRAVA2lLy4m5DDY7AohU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Cgez/wCE9LdB6EU2biklZtHAax0cVmGMbN/Z2HXAvav2c7TUdk2pI7OaG7nx+agYep+D5Vk89aV4euOgjRdoQfZGs0D5bf864kuxwna8MkU/j0O9y1p6Q/2Z9AKat0KVqIg0GJLZbu+sdwDPjR3WXF8fFRgMJCEjBkkf1Ftmwvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dteQVuTx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dteQVuTx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18DF31F00A3E;
	Mon, 15 Jun 2026 21:29:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781558951;
	bh=KFjx4yAs8YVVPzl3rDzoomN4IkY3u5v7ji1eWL/E2ZQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dteQVuTxSPvp3WNwjeB0ahR3SEeDvN9fG5jgFgbPsFP16T8YT+crav5koxSAib0QZ
	 +eRFditDocYW8Kko5+vIixPkBfbEg3Vlp94/GZlVO/vlfvg0Aq+3lIV2Blie4vxYCs
	 XEPyQtvGBH7DPuaXS9O+cVZwhHk4XQ5BxDkucaGFwvYlQvOteQXIbFen8RyD0XfvxO
	 tkCA/qyKz525zXMXJuZtkZX6ESLe7qw5P+mQGZ4MDQjWmLvu9SN/CrjrTBiB5R3JyB
	 RjeUgqswUN/gY8kWz0ciKFqUphKWK4YGRBcGd0wfalC+h76gS/xGZX0pgcCT6RqZE3
	 V43TIvLehVDow==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jason Gunthorpe <jgg@nvidia.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 3/3] RDMA/umem: Fix truncation for block sizes >= 4G
Date: Mon, 15 Jun 2026 17:29:08 -0400
Message-ID: <20260615212908.2473687-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260615212908.2473687-1-sashal@kernel.org>
References: <2026061505-frayed-clergyman-65f9@gregkh>
 <20260615212908.2473687-1-sashal@kernel.org>
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

