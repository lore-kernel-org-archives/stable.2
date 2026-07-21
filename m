Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F1C53F2101
	for <stable@vger.kernel.org>; Tue, 21 Jul 2026 18:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784659753; cv=none; b=YwI859/OsPkpSFXXH5CwI2SyjzVZ9l2vHGTwGTLc6iiV3tr0zCinbO/3agam2/4VSm5MEKSBg53dJ6G+xwDY3FzuLTUOf0wN67zVwtLzeOA8BDRC93EDkJK+Som98KgOjOfZQU4wEgIqxGyjRZsoCZWs/hVKrNrJ7hczJHvRJCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784659753; c=relaxed/simple;
	bh=TTvDHqNDV+OiZELBNeoVs2waeR4gVXK4iHXTXqscZeE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ieTf1L+tVmlnsAXGyzo8T2FK+c/KotLA3QrP37tVu/75qqacAzNvBDf5yRQCx1lsf0FdyILi17mEd3Qw5mtvK3OPY+fqcPof0v0a984nFY/9C0rhS8Miyhixc3gujXdN8xoVaZgByUD4BkSkxHjB9N+8BgKMQfYV0/vKf5dablM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nr/L4aOs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nr/L4aOs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FAD31F000E9;
	Tue, 21 Jul 2026 18:49:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784659752;
	bh=nwN2cP92MvFJzn7fnICsdNgpVEq2qoDciCuN9IUefzs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nr/L4aOs8CkIapM6fTDSMe4deJvajSUUmAjtmyRO/VDsvOlyvt5td8fOCIRi2VEup
	 5uRjVAwMwZzs6+PF0WnDP0TcVvt5AWYp3qqI9ala2N/R6AMEVZM5B8W/IPxR55Zm34
	 8WRGgSFMthuLWJOJqPhEZvfQDzE1Hq99KpFIxxgepbzIFCYsdmkXAMrlzg6L/979ks
	 arnys4xgjLJbmsF55c4zT3ewnNK8/wfdxhVv0dFbBlimVW3uFG5HQJlBLmqXBvtOAg
	 lXnC4YDwgSmlpO9HipmwFciz2NwtU/JIIMnklv1bFAri0RkRid0F9rM5/K1CXgGB2M
	 6dhOOfRLw2MCg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jason Gunthorpe <jgg@nvidia.com>,
	Julian Orth <ju.orth@gmail.com>,
	Vivek Kasireddy <vivek.kasireddy@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/2] udmabuf: Do not create malformed scatterlists
Date: Tue, 21 Jul 2026 14:49:08 -0400
Message-ID: <20260721184909.383278-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026071651-ditzy-durably-4f3e@gregkh>
References: <2026071651-ditzy-durably-4f3e@gregkh>
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
index 97e0ea90e7de90..d871157e2cced1 100644
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

