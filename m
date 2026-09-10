Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 764254BFE68
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 16:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789057899; cv=none; b=UTVvZsICGmBs+7NWw3B5iMpPwiW38xf3pJH4bf4lFYVk8HdjuS2OGEdVX6E25yvz2yd6LcUjcEahNQImfzRQbIiigr5EAjOuoC53aW/iSgoYrk1H3MtsXGzegQD1RYfGbBH96W7Y7qDKgs0FnXNoxV/jQ2NJLufdA8zENKZyqaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789057899; c=relaxed/simple;
	bh=YglPPiUKTrSRi6UdPq1JS/60Wx0zAtpczOLIEJ8i4dY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EaJ67g076qbpFu3wREFPDltbaXkuAcyo2MVAkQkFFnqENflqLjSn4Kd9RHGKmzOX/zHjtsEjmZnR7EMyvkuegaoX8mnksCxjA+vkwE95DV3Z88kjz7KMDh28ny3MiVF4rYd8+ufvYqetFIMomir+RCBtKd2EqV4CoHPPvi/Pwgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BG9rZSBF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BG9rZSBF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBE091F00898;
	Thu, 10 Sep 2026 16:31:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789057891;
	bh=pD2e3ZdQi8VqMbDxMtg3JSB9gpnej0rVN52Vm6/daEM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BG9rZSBFiUe5g2g9bSATqFQpdUuFerbAP8j5BeKVJHhfcnGHJEjAj+V+5XSFkbT85
	 mJQpyiN0ILyHE+M/ai35gz4c60u2Aa8kq4sRjAyXABH0aLMFzaMl/+rmqXdzqjVMEm
	 +xJS9o8cutkbH5z7ItZvGzF8ipnKhskI4+x0+J9/AFXmMPOHzBT2576IeMAvWOR2QU
	 e/Aqm4nkv4k7XjoByqP+9tdFogF/8vTjKFAyf5bi7k5nSB2ztrhZvhiojVeqpGfy6E
	 CDo5Keyoh8upI3ojMVG1fSUI2upGVAIluqnAG1VflgCoExH1ybXp8IBHqPBwyHtpZJ
	 JUxQclJtuHGXA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>,
	Michael Kelley <mhklinux@outlook.com>,
	Mostafa Saleh <smostafa@google.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 2/2] dma-direct: return struct page from dma_direct_alloc_from_pool()
Date: Thu, 10 Sep 2026 12:31:28 -0400
Message-ID: <20260910163128.1220623-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260910163128.1220623-1-sashal@kernel.org>
References: <2026090812-sway-tubular-8b4a@gregkh>
 <20260910163128.1220623-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>

[ Upstream commit 94a04ad732c9f8b9554270fc4038a06737de5c22 ]

Commit 5b138c534fda ("dma-direct: factor out a dma_direct_alloc_from_pool
helper") changed dma_direct_alloc_from_pool() to return the CPU address
from dma_alloc_from_pool(). That fits dma_direct_alloc(), but
dma_direct_alloc_pages() also uses the helper and expects a struct page *.

Fix this by making dma_direct_alloc_from_pool() return the struct page *
again, and pass the CPU address back through an out-parameter for the
dma_direct_alloc() caller.

Fixes: 5b138c534fda ("dma-direct: factor out a dma_direct_alloc_from_pool helper")
Cc: stable@vger.kernel.org
Tested-by: Michael Kelley <mhklinux@outlook.com>
Tested-by: Mostafa Saleh <smostafa@google.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
Reviewed-by: Mostafa Saleh <smostafa@google.com>
Link: https://lore.kernel.org/r/20260717180442.110954-2-aneesh.kumar@kernel.org
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/dma/direct.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index 24fe791b4c06c..1cb2777132dd9 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -118,19 +118,18 @@ static struct page *__dma_direct_alloc_pages(struct device *dev, size_t size,
 #define dma_direct_use_pool(dev, gfp) \
 	(IS_ENABLED(CONFIG_DMA_COHERENT_POOL) && !gfpflags_allow_blocking(gfp))
 
-static void *dma_direct_alloc_from_pool(struct device *dev, size_t size,
-		dma_addr_t *dma_handle, gfp_t gfp)
+static struct page *dma_direct_alloc_from_pool(struct device *dev, size_t size,
+		dma_addr_t *dma_handle, void **cpu_addr, gfp_t gfp)
 {
 	struct page *page;
 	u64 phys_limit;
-	void *ret;
 
 	gfp |= dma_direct_optimal_gfp_mask(dev, &phys_limit);
-	page = dma_alloc_from_pool(dev, size, &ret, gfp, dma_coherent_ok);
+	page = dma_alloc_from_pool(dev, size, cpu_addr, gfp, dma_coherent_ok);
 	if (!page)
 		return NULL;
 	*dma_handle = phys_to_dma_direct(dev, page_to_phys(page));
-	return ret;
+	return page;
 }
 
 void *dma_direct_alloc(struct device *dev, size_t size,
@@ -169,8 +168,11 @@ void *dma_direct_alloc(struct device *dev, size_t size,
 	 * we can't block, allocate the memory from the atomic pools.
 	 */
 	if ((remap || force_dma_unencrypted(dev)) &&
-	    dma_direct_use_pool(dev, gfp))
-		return dma_direct_alloc_from_pool(dev, size, dma_handle, gfp);
+	    dma_direct_use_pool(dev, gfp)) {
+		page = dma_direct_alloc_from_pool(dev, size, dma_handle,
+						  &ret, gfp);
+		return page ? ret : NULL;
+	}
 
 	/* we always manually zero the memory once we are done */
 	page = __dma_direct_alloc_pages(dev, size, gfp & ~__GFP_ZERO);
@@ -282,7 +284,7 @@ struct page *dma_direct_alloc_pages(struct device *dev, size_t size,
 	void *ret;
 
 	if (force_dma_unencrypted(dev) && dma_direct_use_pool(dev, gfp))
-		return dma_direct_alloc_from_pool(dev, size, dma_handle, gfp);
+		return dma_direct_alloc_from_pool(dev, size, dma_handle, &ret, gfp);
 
 	page = __dma_direct_alloc_pages(dev, size, gfp);
 	if (!page)
-- 
2.53.0

