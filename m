Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0ED0486B8F
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 14:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789051181; cv=none; b=TUIYLTJKLby285p/vD8LpeRxlb+/Z/fgZfcGr0Vk/g3iwPVERFkkl+M4Nem+tA7POVmuFHbeYNWRfTS8nYUnVxKU3hJijo6CNTaCWwuUl/UEtxWqVKfX5/60a4S5tUEZDihr6sn+t4VO/W4yHLzgCex4FN/9nZIfksgSFXiEhXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789051181; c=relaxed/simple;
	bh=bDvhOiD4SzPMrqeVe47DMOxne/YpcymUZtknWloJtqE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F7oGjMZvQkXXV6FNrHI/JL8sCUWu81hznR4ZiEdjwX6yQW8JGD1N70x2fUJWbnFpkjV8PsGZk5LLaRCOXG4cz8nI1xNmFX/HrHJwNO/GvhbbDHeMfMJcfq/cIQNdY7m+cjpMAq4u1mmfEkXNZHW3MpxzoUy94qhQ8v/rXHkrT4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a32Dk/Am; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a32Dk/Am"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 019E31F000FF;
	Thu, 10 Sep 2026 14:39:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789051180;
	bh=SVCWHjb/Ct88juV4A2W4khR26lZGSOwsobSOqGrBlyE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=a32Dk/AmrdG/rs27SpuqyQoKGzqMmTSUXribLx8nB/hzgzAZKBD4JjEYsoawUadmA
	 eJ2svicE3BTkzAyj/PYgsKdix6kK1vBS6YgGimLltuYw2nmuicKnlfRg0RGuLx2aok
	 Bp9H9pl3ykfg8ALc3/iQYVOdEtjpSb1a9HcA5aNOJvG9q1RJhmX+9IZ4pzKCg5ro8M
	 wOKZqjTzotYBYoivLBOrgEVYK+VP1caSPKlYJ3VJZOn2d5ObOc8lGj1B9XATAaVqps
	 BFQYz1To3bLewVj1fXS7D+oTwOUoUgyA87N38YCakrjt9XAwXHSKwXWJ7QbmMQTr2z
	 ofWrf5Ry7nJcw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>,
	Robin Murphy <robin.murphy@arm.com>,
	Greg Ungerer <gerg@linux-m68k.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 09/10] dma-direct: simplify the use atomic pool logic in dma_direct_alloc
Date: Thu, 10 Sep 2026 10:39:30 -0400
Message-ID: <20260910143932.771351-9-sashal@kernel.org>
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

[ Upstream commit b1da46d70e5427a9ba5eae28bcca29a20e68a442 ]

The logic in dma_direct_alloc when to use the atomic pool vs remapping
grew a bit unreadable.  Consolidate it into a single check, and clean
up the set_uncached vs remap logic a bit as well.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Robin Murphy <robin.murphy@arm.com>
Reviewed-by: Greg Ungerer <gerg@linux-m68k.org>
Tested-by: Greg Ungerer <gerg@linux-m68k.org>
Stable-dep-of: 94a04ad732c9 ("dma-direct: return struct page from dma_direct_alloc_from_pool()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/dma/direct.c | 25 ++++++++++---------------
 1 file changed, 10 insertions(+), 15 deletions(-)

diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index 5c4c0c9f1c6d6..30848d158d0a4 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -240,27 +240,22 @@ void *dma_direct_alloc(struct device *dev, size_t size,
 					dma_handle);
 
 		/*
-		 * Otherwise remap if the architecture is asking for it.  But
-		 * given that remapping memory is a blocking operation we'll
-		 * instead have to dip into the atomic pools.
+		 * Otherwise we require the architecture to either be able to
+		 * mark arbitrary parts of the kernel direct mapping uncached,
+		 * or remapped it uncached.
 		 */
+		set_uncached = IS_ENABLED(CONFIG_ARCH_HAS_DMA_SET_UNCACHED);
 		remap = IS_ENABLED(CONFIG_DMA_DIRECT_REMAP);
-		if (remap) {
-			if (dma_direct_use_pool(dev, gfp))
-				return dma_direct_alloc_from_pool(dev, size,
-						dma_handle, gfp);
-		} else {
-			if (!IS_ENABLED(CONFIG_ARCH_HAS_DMA_SET_UNCACHED))
-				return NULL;
-			set_uncached = true;
-		}
+		if (!set_uncached && !remap)
+			return NULL;
 	}
 
 	/*
-	 * Decrypting memory may block, so allocate the memory from the atomic
-	 * pools if we can't block.
+	 * Remapping or decrypting memory may block, allocate the memory from
+	 * the atomic pools instead if we aren't allowed block.
 	 */
-	if (force_dma_unencrypted(dev) && dma_direct_use_pool(dev, gfp))
+	if ((remap || force_dma_unencrypted(dev)) &&
+	    dma_direct_use_pool(dev, gfp))
 		return dma_direct_alloc_from_pool(dev, size, dma_handle, gfp);
 
 	/* we always manually zero the memory once we are done */
-- 
2.53.0

