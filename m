Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5971746C4B9
	for <stable@vger.kernel.org>; Tue, 21 Jul 2026 19:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784661239; cv=none; b=sDAJ0JSfN6+BX2C/686sQq14nUDOvoDapl1PFx08hmVZ8IOG7K8yXvRUocm/OE7KgJdrosEaLQuoKLYmCyGNcdZTvbn483jRv7zjc1rm7qD6vC4WsIdCN8Gxi7HdKFX28VzjAAtG77d556dXZmtle/c8bO7KQbFeJQGqLTgV6h8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784661239; c=relaxed/simple;
	bh=U1aoH4D6k8rB300V+8dAgY0Vhw2ILmfLjm1mA25og74=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kRsfs46s/f/GOgsuY6IGhtIJjCiF88THR/NWBG9BPf/9pKK8pst3pJMRSf/OWd9sRIqhkjGFYLexunFr5MgyP14fba7bFyfHmOeq0Q+0BvDdB+xT6khGxkl0wCXD5UoPBv9+VMg+5QELzkQWb7DAWtHtsq+U/JMf3Yo4FgWhPcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H45q4asS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H45q4asS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99F711F00A3A;
	Tue, 21 Jul 2026 19:13:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784661238;
	bh=hDcU64/gQac9duEk8vto8gUJtjU17hElbOtW2c+pW6E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=H45q4asSwSr5tbzeMzYaeNS5Y3ug8ypEwHD1h2zCDStPo6QjVtDhUEHHj0pxcHUB+
	 7CD8DIeb/mymkCGp9VUzVgyoCz0Z+9t6dUh58afoeAoRI57fKAxLt/OJbfdkvAVYat
	 OzIAvE+XCoceGjKvL0uYRjXeJEXpJIrNB4qiQB0ECScJSAKGhosRpePm75Q9+hZ3gH
	 hA4CTotG3nUil+M1xpXQkSzFXr64FhDWzdQb/DI+xLnYW90X/V3/Iv644JZKAkg2vu
	 mwSbL6SQJO/b7Fx/7Cuzv/GV9EEm/VUhaxnLVWHsRhO3LqYZVYc2tAq7SzWvb34evE
	 3+8ejB/rnbOsA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jason Gunthorpe <jgg@nvidia.com>,
	Julian Orth <ju.orth@gmail.com>,
	Vivek Kasireddy <vivek.kasireddy@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 1/2] udmabuf: Do not create malformed scatterlists
Date: Tue, 21 Jul 2026 15:13:55 -0400
Message-ID: <20260721191356.403244-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026071652-riveter-energy-4da7@gregkh>
References: <2026071652-riveter-energy-4da7@gregkh>
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
index 4264d88a5e6b4d..15b8656abb9f84 100644
--- a/drivers/dma-buf/udmabuf.c
+++ b/drivers/dma-buf/udmabuf.c
@@ -65,14 +65,16 @@ static struct sg_table *get_sg_table(struct device *dev, struct dma_buf *buf,
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

