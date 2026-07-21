Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B965131AF1B
	for <stable@vger.kernel.org>; Tue, 21 Jul 2026 18:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784660353; cv=none; b=dFhz0TJ5pnI+fiGhxF6c3qajFWS9uLd8U0To4tvgxoNay12QXnsgP/bVML0/qV9xR4GV9SNFytYzFXAA6UObRvNJ+Wt1w8v3uag+p3Mp4FI+w2yJbaL0ETWiE49Z/9cGZF7AxZk935Ezi4bq3VEBXm+hhpmOLLbUAKYRZJ3hz2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784660353; c=relaxed/simple;
	bh=lSOOxKGzrq1VutdQwmJVghaypdY6ROCoRWZlZvPejv8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=By5as6+X/Y1NSreMmpU4jkF/CiugsqCuQ9BhVOM2zwHhvrv2HwypvtOCalCyvB4P2newg4QMFGuDzHpI2eiCcrfgug9mSJwVC+oRlzVAq9XTgVGhxG4BaAlXvcb3Y6C3BnuZerqG/NNELIqXzoO0nVpVp042gVRKeWcS+znqZkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jBrbtJP0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jBrbtJP0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 030F21F00A3D;
	Tue, 21 Jul 2026 18:59:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784660348;
	bh=Oa/Tv7pJkE60aPcvgGulwSeZ9mXLSn9M81mftEvIwhU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jBrbtJP0wvEKL221FcWsy2ZoVk0SMOytei9MmOsm3II0ueZ4j0FPNf+v89eC/CCI8
	 h71kTU/tD8qRdwnOybqrqA8kWap80efZYStHOfKKxUNhw6dBcZdcdHnhZ6j5W4+ddT
	 +iXStWKSVFV8awsitOOH3oBHpn2gbkZJMMgxtOMDj/664uDhqPezE0MKYXA3wfSGeK
	 LfPrZ8eP8yrvzsQYMD2PxyykH27UrAzHTRyEiBIIVLpARSoD0zM4m4YXjGxpxCdL4O
	 vZmkKWhkbgwAwj9vdfKCizwe8oBqPPXzFSm/WdusKr6rmhzCZ3h4YALwk3g2wlF+JI
	 0FDS9IhOcZCkA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jason Gunthorpe <jgg@nvidia.com>,
	Julian Orth <ju.orth@gmail.com>,
	Vivek Kasireddy <vivek.kasireddy@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/2] udmabuf: Do not create malformed scatterlists
Date: Tue, 21 Jul 2026 14:59:05 -0400
Message-ID: <20260721185906.397615-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026071652-dandelion-handbook-8d52@gregkh>
References: <2026071652-dandelion-handbook-8d52@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Gunthorpe <jgg@nvidia.com>

[ Upstream commit 5bf888673e0dda5a53220fa0c4956271a46c353c ]

Using a sg_set_folio() loop for every 4K results in a malformed scatterlist
because sg_set_folio() has an issue with offsets > PAGE_SIZE and because
scatterlist expects the creator to build a list which consolidates any
physical contiguity.

sg_alloc_table_from_pages() creates a valid scatterlist directly from a
struct page array, so go back to that.

Remove the offsets allocation and just store an array of tail pages as it
did before the below commit. Everything wants that anyhow.

Fixes: 0c8b91ef5100 ("udmabuf: add back support for mapping hugetlb pages")
Reported-by: Julian Orth <ju.orth@gmail.com>
Closes: https://lore.kernel.org/all/20260308-scatterlist-v1-1-39c4566b0bba@gmail.com/
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Vivek Kasireddy <vivek.kasireddy@intel.com>
Signed-off-by: Vivek Kasireddy <vivek.kasireddy@intel.com>
Link: https://patch.msgid.link/0-v1-42779f29381a+4b9-udmabuf_sg_jgg@nvidia.com
Stable-dep-of: 504e2b4ab97a ("dma-buf/udmabuf: skip redundant cpu sync to fix cacheline EEXIST warning")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/dma-buf/udmabuf.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/dma-buf/udmabuf.c b/drivers/dma-buf/udmabuf.c
index f1b2197ebc6d0f..3cd9c4a84e76fb 100644
--- a/drivers/dma-buf/udmabuf.c
+++ b/drivers/dma-buf/udmabuf.c
@@ -71,14 +71,16 @@ static struct sg_table *get_sg_table(struct device *dev, struct dma_buf *buf,
 					0, ubuf->pagecount << PAGE_SHIFT,
 					GFP_KERNEL);
 	if (ret < 0)
-		goto err;
+		goto err_alloc;
+
 	ret = dma_map_sgtable(dev, sg, direction, 0);
 	if (ret < 0)
-		goto err;
+		goto err_map;
 	return sg;
 
-err:
+err_map:
 	sg_free_table(sg);
+err_alloc:
 	kfree(sg);
 	return ERR_PTR(ret);
 }
-- 
2.53.0

