Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6C6648E0C5
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 14:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789049726; cv=none; b=SFGM7Hrm0A2/P6AVvjiroLRz9IGTC3oVV9KklHxNGf8lxDYQibEh6tAJHMiu+0hWNxWOJqYhCAJehtplZrONM/NzWfPYDXuMslw34sIJwLyipjwpRkEqkBDwXdn1yHrNnZMD0wzZnP6xm1//v4M7KzwWfyn8mTEFhDwWOC6Yjos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789049726; c=relaxed/simple;
	bh=Hs80GmNywDOXkwSmj1bpgmmUas7vlINihGoAxJmHSig=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rPoY3cidc4PgBxFQX62Zd8lPd0x73xlaOPsV6Vn5I5TP3LVUm5GThXfwhqyYsy60+OYb3AoN96Sbcx7TvCxgiNHPczP3mHkKpBsotWxPbefHkuBYVRKaAfzrguKF83qBYckRVoDfw+YAxKbF/gdCXjDbHiN+FEmsCyubpRcZn9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ggox/V75; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ggox/V75"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14A1D1F00893;
	Thu, 10 Sep 2026 14:15:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789049724;
	bh=y2qn0H1MDNPuVQpcETQdYdMPl3NwGWMMitIvAlzJhUE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Ggox/V75orjkOiQdCiyRtoMwlzY4AXIBfBXm2WeQQJ9GQfhQgBL5eg6vaFseQQD1t
	 yDkrsmKfHSwJf6oQ6BJG7J1eC3O2/V7OKGgMl8tPGcqn2G1XVOXSiNmzNptPb1eWCr
	 EsXG31t7b8LfeoIALB9oqGxD+QbuVWPegJvJ8ZoJRwQ8XwTNwFmZUtfnN8+sBoY7aj
	 KqJibiESWmEQ7AQImdJxHsLDyZ48AzSgNNNadvxp3z5Vmuv1D5h0OGrmmGtwtJJ3m1
	 5SffqzJdiPMhG2z3fr1AU/bha091+36UOPFWOUD3iATtvMTV8wKyrmzJXLsQCHiAqK
	 iLYKIP1RLqsmg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>,
	Robin Murphy <robin.murphy@arm.com>,
	Greg Ungerer <gerg@linux-m68k.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/3] dma-direct: simplify the use atomic pool logic in dma_direct_alloc
Date: Thu, 10 Sep 2026 10:15:20 -0400
Message-ID: <20260910141521.649048-2-sashal@kernel.org>
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
index d6871a3fe5f6a..621a711224574 100644
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

