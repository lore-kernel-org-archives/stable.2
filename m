Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37584492E4F
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 14:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789051180; cv=none; b=Hf60RUIPPSyHDYoQLymbz6WS0jcnbaK4VoUw4GzDIQ+Vs/ONC18Wi+bSj7jzqHjA94vc6ZJZzFOnWAkJLvE0TmJx9WckWZ/5bEVSqtPrXzlQaqw+5J0qKcxP/wsCU3hEY8/h3Skq7PeRtbs83567Cp1B423/2fMM7WeFw6lF2Es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789051180; c=relaxed/simple;
	bh=8BFhYFSmghnL2BacXnmPPIU3CFdvp85oHoMvsq6ekrM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=in/A0H2UTf6yCZwWdN2Wizkx+lihWiJg7WPIHmQ5Tw4z8qVeWwauNBwuxN1izg8C4bn/hCzJ6Z7ApDXpngHF44SCkaioCNrIGWlp8hVz3XpGXki605q00MEeMx4aK1iDeeonZLHjgoiVVED3H8hUaw4uZC/JR3yrBEgPM8z/zeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e8rcVMEA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e8rcVMEA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FAE71F00893;
	Thu, 10 Sep 2026 14:39:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789051179;
	bh=hUmCpYPBX8H+jXLdUSRIZvL3uuNNbfQqHVcd1T5yxr4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=e8rcVMEAdbZgWdGgspSdaWVLtJvlq8EssBUCtXAdI/fhptfQjBfDDGl2x6oBj4HS1
	 uNH6chOiIZag6ngOA5azD9pgBGTeQnnyouMKTqRaVBjeSS0CJMChYT8ESi0V5qpYEZ
	 QSaxMEfNwsLaz6FNbi1jzPyFhLH7C+HChpCUIBuC0PNnhiJ2a3Q9iwA2Rw5DncsJO3
	 Y+y5eQ6eVYtdlIHN9xC7HypdAJM43foumlfsUu33mjn9RuDVIowzurLpsQaL+4RzHl
	 AtDouCiMNAARFQM1pqJHQ61zXXnShwE3R99PJcjq+EA3RLY3pQd4ZO8VFSQddNnsna
	 YKXX+yjPn3PFA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>,
	Robin Murphy <robin.murphy@arm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 07/10] dma-direct: add a dma_direct_use_pool helper
Date: Thu, 10 Sep 2026 10:39:28 -0400
Message-ID: <20260910143932.771351-7-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260910143932.771351-1-sashal@kernel.org>
References: <2026090811-unwound-smuggler-adf1@gregkh>
 <20260910143932.771351-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Christoph Hellwig <hch@lst.de>

[ Upstream commit 28e4576d556bca543b0996e9edd4b767397e24c6 ]

Add a helper to check if a potentially blocking operation should
dip into the atomic pools.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Robin Murphy <robin.murphy@arm.com>
Stable-dep-of: 94a04ad732c9 ("dma-direct: return struct page from dma_direct_alloc_from_pool()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/dma/direct.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index 0f9b9a52b274c..97bd785560239 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -159,6 +159,15 @@ static struct page *__dma_direct_alloc_pages(struct device *dev, size_t size,
 	return page;
 }
 
+/*
+ * Check if a potentially blocking operations needs to dip into the atomic
+ * pools for the given device/gfp.
+ */
+static bool dma_direct_use_pool(struct device *dev, gfp_t gfp)
+{
+	return !gfpflags_allow_blocking(gfp) && !is_swiotlb_for_alloc(dev);
+}
+
 static void *dma_direct_alloc_from_pool(struct device *dev, size_t size,
 		dma_addr_t *dma_handle, gfp_t gfp)
 {
@@ -238,8 +247,7 @@ void *dma_direct_alloc(struct device *dev, size_t size,
 		 */
 		remap = IS_ENABLED(CONFIG_DMA_DIRECT_REMAP);
 		if (remap) {
-			if (!gfpflags_allow_blocking(gfp) &&
-			    !is_swiotlb_for_alloc(dev))
+			if (dma_direct_use_pool(dev, gfp))
 				return dma_direct_alloc_from_pool(dev, size,
 						dma_handle, gfp);
 		} else {
@@ -253,8 +261,7 @@ void *dma_direct_alloc(struct device *dev, size_t size,
 	 * Decrypting memory may block, so allocate the memory from the atomic
 	 * pools if we can't block.
 	 */
-	if (force_dma_unencrypted(dev) && !gfpflags_allow_blocking(gfp) &&
-	    !is_swiotlb_for_alloc(dev))
+	if (force_dma_unencrypted(dev) && dma_direct_use_pool(dev, gfp))
 		return dma_direct_alloc_from_pool(dev, size, dma_handle, gfp);
 
 	/* we always manually zero the memory once we are done */
@@ -363,8 +370,7 @@ struct page *dma_direct_alloc_pages(struct device *dev, size_t size,
 	struct page *page;
 	void *ret;
 
-	if (force_dma_unencrypted(dev) && !gfpflags_allow_blocking(gfp) &&
-	    !is_swiotlb_for_alloc(dev))
+	if (force_dma_unencrypted(dev) && dma_direct_use_pool(dev, gfp))
 		return dma_direct_alloc_from_pool(dev, size, dma_handle, gfp);
 
 	page = __dma_direct_alloc_pages(dev, size, gfp, false);
-- 
2.53.0

