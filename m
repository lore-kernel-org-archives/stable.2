Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CDE9379C32
	for <stable@vger.kernel.org>; Tue, 21 Jul 2026 18:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784658488; cv=none; b=A7ewOY3by4uzRaWly4j0YGKES7hiVslZCtrRq7pyrf2QtgWzh2iFSyL/EWvGTxFHdneeJTWTA0oD55d4Q3tJ557JOuKZd73Dw/iWJcLm8WrX5+SqD5yGezbhKEKK3phVPBgmFMt1/whdxteeBzLrO0vXk/i1wLboSg21MyBh9WM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784658488; c=relaxed/simple;
	bh=hMyd4TwoQYnt6PIlB0SS+P6iAVH31UAeedJhZNun3/o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Cj0sWpQpCIW0e8YmFZb6Z7SCuLah6QkWGpjGllozsTpJKc41s0A/2JInTfUd1WbWwNLkdNozaKOe13dj5rJjawY7nG1yT5MSP9o+kv8JiTfdLvBvRlVEltZrOW46Cx/VqnhpQ2WyvPoVk8bG9ECQJYT9KAcNwWJdqDitCmk2tUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KCDBvHDv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KCDBvHDv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E6871F000E9;
	Tue, 21 Jul 2026 18:28:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784658485;
	bh=FOafenVLKKgaS3ibrV2AdrTuCx4RCxk2AiCBcsLFp+k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KCDBvHDv16E1uRQyH8/vy2w/ZTWBs0IMxvjekD+tRPfbDTIPDzFMngXn1Dq0rOi1i
	 qsA5Jzw+Z2GQ2vDUKgv5vzViGY/qCDIV8kStWaMqG14/1Yas54xY68ScJ1X/4vmiUE
	 JuSzV8av0kjwbESUpz0beAumOT/M+1X6Hob6Xf3xXF/lViciuXsxCdKeU9FAD0lM1G
	 bH9+aV7Ej6HK7CIMcrSYo6aUy4eK0adksDtwTT1236aLsdQTZ5DJgWlYu1+hBH3Fdj
	 JfWSzH79xh4MNCv5lGYDTOS5CwJqSD3M7DYrYnz+mi+LxJhMksOBbcvNdgG0RdZqp6
	 iSIW7T9Of3KBw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jason Gunthorpe <jgg@nvidia.com>,
	Julian Orth <ju.orth@gmail.com>,
	Vivek Kasireddy <vivek.kasireddy@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/2] udmabuf: Do not create malformed scatterlists
Date: Tue, 21 Jul 2026 14:28:02 -0400
Message-ID: <20260721182803.332607-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026071651-preorder-shawl-7dbc@gregkh>
References: <2026071651-preorder-shawl-7dbc@gregkh>
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
index 980975ffc55d3c..de3a7e395a6d99 100644
--- a/drivers/dma-buf/udmabuf.c
+++ b/drivers/dma-buf/udmabuf.c
@@ -99,14 +99,16 @@ static struct sg_table *get_sg_table(struct device *dev, struct dma_buf *buf,
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

