Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6390C379EFF
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 14:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789051178; cv=none; b=IiH9tvnm11b/Nuj2bw+5686D1N3otw4ZH9clK7jEyxxCHbMGkWrpv60JAq1lepcws+BOzQCZZP7TChgM6woomhLkGgBodpjbXKOhXRETAVFfhrce0qlaU0UgKRNhNFqsOHxIRqJW3G4vLx7s+EQbHU7a92wUJDA26oZFE1DJIxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789051178; c=relaxed/simple;
	bh=nQqD24AcBqX87/qO9vz7xMHPW+yH8JkWx7cQ1A9H9Ns=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IOeDYGalbA5C9T4PyN4mRqqV/LTgFoDYGV/TJr6uTM/zgNn8X5LP3s8LhWut5E9A1XDw/VQNR087bWRNqb0G5xZCnVRfI4VygcUvtoS29r2MWpKa3YH7gkQiioTjlKt2pK38/+tjiwdgSCVkYX6fhvLM8v3E4TTFLZa06PooarM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MfNPYgMW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MfNPYgMW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BCA11F00898;
	Thu, 10 Sep 2026 14:39:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789051176;
	bh=+fqCevs9JI8L0cAkSZhcUZiF/uweXIl1iADi68j65hU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MfNPYgMWSqIbJ9vx5N1g8I2Yua5I4UST8B0c9PlSlklzHGBpE4B6RmiZ5EWCGOS1w
	 /mMQkF2AEl64JY3u+2Jf0zlSGUoxHnQVTMGaW6aHKk3FYeSpEY/GConUSZAEe7o3Qx
	 q2u9HaZJAfSA+QFfd/HzIs/ZiHeNFvtUOqeRpRhgM+kSBJ5/KSUKXxdQspJf+E+f+c
	 0QLZO1vxO+pj1MUZlxtdO81jN+k91NUbBQeC21t2Lka4R9iYc0o7eaI2U/uitGRiRp
	 h5KY5wYsBqiwnaINGjj+A7122QN++F6//u8OEY5UFLfc40yv5HdWC08dnK3N4+A31o
	 zkvslgKQpoL0g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>,
	Robin Murphy <robin.murphy@arm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 04/10] dma-direct: warn if there is no pool for force unencrypted allocations
Date: Thu, 10 Sep 2026 10:39:25 -0400
Message-ID: <20260910143932.771351-4-sashal@kernel.org>
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

[ Upstream commit 78bc72787ab9e638173aeb1f589578105d3a43c9 ]

Instead of blindly running into a blocking operation for a non-blocking gfp,
return NULL and spew an error.  Note that Kconfig prevents this for all
currently relevant platforms, and this is just a debug check.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Robin Murphy <robin.murphy@arm.com>
Stable-dep-of: 94a04ad732c9 ("dma-direct: return struct page from dma_direct_alloc_from_pool()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/dma/direct.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index 0d6467b6553b7..5a71b6edfd1cd 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -162,6 +162,9 @@ static void *dma_direct_alloc_from_pool(struct device *dev, size_t size,
 	u64 phys_mask;
 	void *ret;
 
+	if (WARN_ON_ONCE(!IS_ENABLED(CONFIG_DMA_COHERENT_POOL)))
+		return NULL;
+
 	gfp |= dma_direct_optimal_gfp_mask(dev, dev->coherent_dma_mask,
 					   &phys_mask);
 	page = dma_alloc_from_pool(dev, size, &ret, gfp, dma_coherent_ok);
@@ -246,8 +249,7 @@ void *dma_direct_alloc(struct device *dev, size_t size,
 	 * Decrypting memory may block, so allocate the memory from the atomic
 	 * pools if we can't block.
 	 */
-	if (IS_ENABLED(CONFIG_DMA_COHERENT_POOL) &&
-	    force_dma_unencrypted(dev) && !gfpflags_allow_blocking(gfp) &&
+	if (force_dma_unencrypted(dev) && !gfpflags_allow_blocking(gfp) &&
 	    !is_swiotlb_for_alloc(dev))
 		return dma_direct_alloc_from_pool(dev, size, dma_handle, gfp);
 
@@ -357,8 +359,7 @@ struct page *dma_direct_alloc_pages(struct device *dev, size_t size,
 	struct page *page;
 	void *ret;
 
-	if (IS_ENABLED(CONFIG_DMA_COHERENT_POOL) &&
-	    force_dma_unencrypted(dev) && !gfpflags_allow_blocking(gfp) &&
+	if (force_dma_unencrypted(dev) && !gfpflags_allow_blocking(gfp) &&
 	    !is_swiotlb_for_alloc(dev))
 		return dma_direct_alloc_from_pool(dev, size, dma_handle, gfp);
 
-- 
2.53.0

