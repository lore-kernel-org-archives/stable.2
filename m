Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B105134678E
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 14:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789049727; cv=none; b=fhsVgeUFLrrc0YIbHeqpJhmvz9/e2Zz7UPDbzypstimbGvd/V2j0qVV+0OLgwYywAUhgbdkIjHE271CHR2iDpNek68yyQ5g5pgdmaBqim/R6OeanrI90b237foniDAPAccebGej7A+NE6kl8XYR5PwxXiMNUoMIFGqv7mTEO5lE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789049727; c=relaxed/simple;
	bh=o7BAyLpFVz5ly0ttp4OCoYEEysgQ8ehGNnLkAka24TY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S43tfGD0Yav7liqWT2Q1NiMl7wjHZ4ton4FzDB6urOOIFPulBVFu4o8nExsTSptp3X3woV/3mdb6ZA1V4d8ACZxxOUi/XuIWkQU6h3ByWZ+YBE1s1pL2gvexnYgmsBQ4mIaJju9k49rQ21TXka0+iIHjFdW3o8WqKHVlGIuApUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sil1wpz9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sil1wpz9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC89C1F00899;
	Thu, 10 Sep 2026 14:15:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789049725;
	bh=PyxvPw8bkzD/r9VZYGnlutSXojDAz0W+y9GrWEnBnzI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Sil1wpz9CIB7X1annwuoZALzRbSHyFoJ+jfMXnK46/69IMD/rT8PdZg/Ph26KHrZO
	 1UnUx5TjWBK8tc3axa70v2Y3K1GgONKJyaqWZyd9s1huJBbnYFKP+qADOn7OQYps2U
	 RdHNQaUv6gmeCadEfcV6iHiswDNMPwuN0aWvQCsi5pkaT12kued99irh2aD3mJGDNx
	 5TZpB1btLVVosBKsYEnS2kPkAH5fhyELUJGwxx12V6uOZL3X9nbO005nlYdIWSDmEL
	 T2C4V6oYnP+HAVnoXc3EgafXnQQFvTP0kfmNpfNSSfcAHiaskww7UhUqzdRS7omEvx
	 naJBYD4T01aPQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>,
	Michael Kelley <mhklinux@outlook.com>,
	Mostafa Saleh <smostafa@google.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 3/3] dma-direct: return struct page from dma_direct_alloc_from_pool()
Date: Thu, 10 Sep 2026 10:15:21 -0400
Message-ID: <20260910141521.649048-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260910141521.649048-1-sashal@kernel.org>
References: <2026090811-upwind-reseller-c91c@gregkh>
 <20260910141521.649048-1-sashal@kernel.org>
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
index 621a711224574..88ec1b5cb5060 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -168,22 +168,21 @@ static bool dma_direct_use_pool(struct device *dev, gfp_t gfp)
 	return !gfpflags_allow_blocking(gfp) && !is_swiotlb_for_alloc(dev);
 }
 
-static void *dma_direct_alloc_from_pool(struct device *dev, size_t size,
-		dma_addr_t *dma_handle, gfp_t gfp)
+static struct page *dma_direct_alloc_from_pool(struct device *dev, size_t size,
+		dma_addr_t *dma_handle, void **cpu_addr, gfp_t gfp)
 {
 	struct page *page;
 	u64 phys_limit;
-	void *ret;
 
 	if (WARN_ON_ONCE(!IS_ENABLED(CONFIG_DMA_COHERENT_POOL)))
 		return NULL;
 
 	gfp |= dma_direct_optimal_gfp_mask(dev, &phys_limit);
-	page = dma_alloc_from_pool(dev, size, &ret, gfp, dma_coherent_ok);
+	page = dma_alloc_from_pool(dev, size, cpu_addr, gfp, dma_coherent_ok);
 	if (!page)
 		return NULL;
 	*dma_handle = phys_to_dma_direct(dev, page_to_phys(page));
-	return ret;
+	return page;
 }
 
 static void *dma_direct_alloc_no_mapping(struct device *dev, size_t size,
@@ -255,8 +254,11 @@ void *dma_direct_alloc(struct device *dev, size_t size,
 	 * the atomic pools instead if we aren't allowed block.
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
 	page = __dma_direct_alloc_pages(dev, size, gfp & ~__GFP_ZERO, true);
@@ -367,7 +369,7 @@ struct page *dma_direct_alloc_pages(struct device *dev, size_t size,
 	void *ret;
 
 	if (force_dma_unencrypted(dev) && dma_direct_use_pool(dev, gfp))
-		return dma_direct_alloc_from_pool(dev, size, dma_handle, gfp);
+		return dma_direct_alloc_from_pool(dev, size, dma_handle, &ret, gfp);
 
 	page = __dma_direct_alloc_pages(dev, size, gfp, false);
 	if (!page)
-- 
2.53.0

