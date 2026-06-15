Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5AAF33A6E2
	for <stable@vger.kernel.org>; Mon, 15 Jun 2026 22:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781563939; cv=none; b=C9MGPsdPDLFJ0PpHrVhmZkGdGK1e3Tn0KXijAiXqBTf+alOD9MlysARK5mx5a+qWtMYN32690JO5E3YlzIs/b1VsKVDiyj217/I2kVoM4WPk1ZYFsxoGqxsHVatQzGdNrev3ikjM6yP2m1hJECnKAAsR66Mdl0gx2AZQmpe3dVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781563939; c=relaxed/simple;
	bh=XX9NREEVL4LcB2J0tgseR8DPRAVA2lLy4m5DDY7AohU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nhe20YeGOEHup4DaVXq9g+8PKO0uk6qvXnFSzYRBO99G/7GbrGFE5y+bwMlpN5ka5h2IGfyV1y2M/Mix/B12ObN3rUz3udBDg+B5QQoLPSriNeq+JP5CPFptQ2doyGEFC6FFSVNWar+GsfalKcqNm8FyB66EGqRNPxXY4/tw+F0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ltbg51BO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ltbg51BO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 302261F00A3D;
	Mon, 15 Jun 2026 22:52:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781563938;
	bh=KFjx4yAs8YVVPzl3rDzoomN4IkY3u5v7ji1eWL/E2ZQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Ltbg51BOS2Lbp7K/OURU1wNjcaJJzves0hecFj6rbFKvuja+ExH285KHsf077VNmw
	 zp0UBYH6NBxbah2yiIGLCcIOO5uyfwWPfaqxdCvPTJZk0QoJ+4Yua09y3Yo4c+y8KW
	 XNJmC1TT2++kGwPbdJxUEa/f2sPf1ADGCIcRmTLnVFxfGeW6SKkfgjeVW/qSMYccr+
	 JkP8Vo6xOo3gSUSQXV+9Zc2zrURt6E0dZGZp4hCsETi+EunED9jGZvS2BcoJGfg/02
	 CmFVD6Fjz0fN3U+Uu8YWWKOPbuMSwfkJhdzYSTeH36TwQ+ENGCGfTKnX9mn29YDlQ2
	 1AIS9UtCKmc2g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jason Gunthorpe <jgg@nvidia.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 3/3] RDMA/umem: Fix truncation for block sizes >= 4G
Date: Mon, 15 Jun 2026 18:52:15 -0400
Message-ID: <20260615225215.2520173-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260615225215.2520173-1-sashal@kernel.org>
References: <2026061506-unfiled-breeder-73e4@gregkh>
 <20260615225215.2520173-1-sashal@kernel.org>
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

