Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A18A13AA1A1
	for <stable@vger.kernel.org>; Tue, 16 Jun 2026 03:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781579862; cv=none; b=LWwSLsKUQ5GawjgtmK6FUi0Ch26+YlhsdDEEyZ8jwC1AO7DmkEayW+6er9QsVj55BFSjYznBPjaHUfQOqokbQgR0UPldigetdPe+rSOvDgebFkIOk2Jt6MtDvQzXjDU3DlBlSyH9V7YkVTSYH23bjxvS/bge9VmzaNEvx14VTOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781579862; c=relaxed/simple;
	bh=XX9NREEVL4LcB2J0tgseR8DPRAVA2lLy4m5DDY7AohU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gcN5pQwwSERb6r7tMuYJ+Wby6vucLCA/8Ifw43E3HzWiX642kRB3WtHbcuWrvU+XyPhuM0ya+yv4HlLBBz5qD1ub/+z9MVe3L2ZnIAi+igWXPZkJ+j1SAxBCZaRhOrKwY1PVbk5iIr9eeg0QsV3tV12BRdMdvZvcV4YzHhrkspk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OfZu/+m0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OfZu/+m0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAB9A1F00ACA;
	Tue, 16 Jun 2026 03:17:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781579860;
	bh=KFjx4yAs8YVVPzl3rDzoomN4IkY3u5v7ji1eWL/E2ZQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OfZu/+m0ohKVS4P+xvaa1mW3xl3d1FxFQkYdlWCtUjkNkWgTHQpStwMcwdy9K1ntM
	 unMoUBBEjA55frR7XEgdcS3iJiU0Mf8IXlWIFwgExcou3C26AwzFawfxJw8fmiK0dP
	 ar+Q3X/IacKgZ+zqiAfil3MoztwOVm4II8e94QgiYmQWgg6Vq41No6SCSMw8pc6n/T
	 zLc7/EkVME89WfwB8PxZJjlW1DEoPu0+CVyOIbNtkMor2SCtU76fGcjDkPikSDRfLN
	 DN5KvLP+hMophe/P2McaI12wGGVaI3TDqND6tzLP2NSVwmjKtiJlNqIvM8cfb3VyRf
	 rF+CdGIiU5luQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jason Gunthorpe <jgg@nvidia.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 3/3] RDMA/umem: Fix truncation for block sizes >= 4G
Date: Mon, 15 Jun 2026 23:17:37 -0400
Message-ID: <20260616031737.2781524-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260616031737.2781524-1-sashal@kernel.org>
References: <2026061513-rimless-afoot-0214@gregkh>
 <20260616031737.2781524-1-sashal@kernel.org>
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

