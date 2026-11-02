Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793612703;
	b=ZaQl5psC0FvWXLoQaBKqSMgEjX4WmBrg5tFfDZvQZc4HybGZYkc7RFsk+Iyp+G2p2K0f
	 5Jwz6oo1EAwV/8kGnd30G1HB7DXQNMcDK4Du0PooTig/4xSYKziqYm3ah9dCxtZBYObhx
	 uv+Lg2F1pMv3M6au1Lv0o7rYKJawpswu7r2hFRuZZuQK9IN0nfPHu0dwMiiJxI/hsN2Lp
	 rwdN/JjHmaTtaQqwCbnu+mvgTU8mrJtwuJ+pdnorvBMgbhCUTLCv2yniUCdirgFmo8G0z
	 60Fx/L9DvNhjhswou0EBDFgTDmoUzpcvJY3MO4JnYAcnG8SXGR4XDh/+g7g6HVABpDQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793612703;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=CKiEFEvoAV37kTlieYx5EENYcbPCljmecF7v8qsd2AM=;
	b=bBpd9EjtkvQQZMlBk4QoQQgq63U1V1EmRKugw8p22ob0SUKYFLZgvML2QKhDILxw66Bi
	 JSLetdQQl0ucRftnG1zMO5cTnmZ4zqH/C9a0zAv37QCGaaqMzNeczvBN7q/TDSJw199co
	 7nKwHM/XVA0f3djdYB3wJQARnwi3lZ5S0TW3X1OKc+wlmHte2b7y9tJ57hkD9cHVSYRJF
	 +viX4Xl/nkKW73/rfAZK7Uln1G5OuprWNhVQnLl/Umk0EXyi7GxCws+qbCUK1hGmJXhg5
	 +Q5IaSswpdTgzVH6jQnrQWymZpWMp17CSoq1k9PlF7s1HSDXSeeSpWHmPhriBWuLyJA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=D2JYbBDI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51BB9606A324;
	Mon,  2 Nov 2026 09:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=D2JYbBDI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 640A31F000C1;
	Mon,  2 Nov 2026 09:45:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793612702;
	bh=CKiEFEvoAV37kTlieYx5EENYcbPCljmecF7v8qsd2AM=;
	h=From:To:Cc:Subject:Date;
	b=D2JYbBDIdO/Vdy4SxYK6DcLo3KVd5oZv+YavK5I4rGIwcbmLz3SCaeAnROUfb7brF
	 taiMMZUf5dJS3UptE4we8mJt+VUNYdHsrzQYFdoWBRrQXDTAJm/rcujMBB7irKRk3e
	 eYrnkgb2bt46Yg/d71Ue6Qpldj6q8nYqw3UYNPstB8lJnW2mtOdfJFutYP8rAJ5gfb
	 5me1GGNqyMCv9G1gowyqj/ejWGe/8ozok6LxKjkpEptoOCyn2N3rOffNgzI4zHdfrd
	 Fyz/nJiub2InQrH5LaXI15raQkqMVvcuBw4t9ovHv8b1ot32+PND+OfTqQcJgVLxvb
	 gn27Z37fYbxGA==
From: Imre Kaloz <kaloz@kernel.org>
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	linux-mips@vger.kernel.org
Cc: Ethan Nelson-Moore <enelsonmoore@gmail.com>,
	"Maciej W. Rozycki" <macro@orcam.me.uk>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v3] MIPS: c-r4k: Flush the cache error vector before writing it uncached
Date: Mon,  2 Nov 2026 10:43:45 +0100
Message-ID: <20261102094345.27840-1-kaloz@kernel.org>
X-Mailer: git-send-email 2.47.3
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On R10000-class CPUs, a store prefetch while copying the preceding
vector can leave a dirty line whose write-back overwrites the uncached
cache error handler.

Write back and invalidate that line in set_uncached_handler() before
the copy, through a new flush_dcache_size() hook. c-r4k and c-r3k
provide it with r4k_dma_cache_wback_inv() and r3k_dma_cache_wback_inv(),
renamed as they are no longer DMA-only.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Imre Kaloz <kaloz@kernel.org>
---
Changes in v3:
- Renamed the hook to flush_dcache_size() and the c-r4k implementation
  to r4k_flush_dcache_size().
- r3k_dma_cache_wback_inv() becomes r3k_flush_dcache_size() and is
  installed as the hook as well.

Changes in v2:
- Fixes: 1da177e4c3f4 instead of e01402b115cc.
- Moved the write-back into set_uncached_handler(), for every caller.
- Renamed r4k_dma_cache_wback_inv() to r4k_cache_wback_inv().

v2: https://lore.kernel.org/r/20261026120430.13238-1-kaloz@kernel.org

 arch/mips/include/asm/cacheflush.h |  1 +
 arch/mips/kernel/traps.c           |  6 ++++++
 arch/mips/mm/c-r3k.c               |  9 +++++----
 arch/mips/mm/c-r4k.c               | 11 ++++++-----
 arch/mips/mm/cache.c               |  1 +
 5 files changed, 19 insertions(+), 9 deletions(-)

diff --git a/arch/mips/include/asm/cacheflush.h b/arch/mips/include/asm/cacheflush.h
index 5099c1b65a58..fb8eeb205897 100644
--- a/arch/mips/include/asm/cacheflush.h
+++ b/arch/mips/include/asm/cacheflush.h
@@ -120,6 +120,7 @@ extern void copy_from_user_page(struct vm_area_struct *vma,
 
 extern void (*flush_icache_all)(void);
 extern void (*flush_data_cache_page)(unsigned long addr);
+extern void (*flush_dcache_size)(unsigned long start, unsigned long size);
 
 /* Run kernel code uncached, useful for cache probing functions. */
 unsigned long run_uncached(void *func);
diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
index 8ec1e185b35c..19a8946e14ae 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -2305,6 +2305,12 @@ void set_uncached_handler(unsigned long offset, void *addr,
 	if (!addr)
 		panic(panic_null_cerr);
 
+	/*
+	 * A store prefetch or speculative store may have left a dirty line of
+	 * the cached view; write it back and invalidate it first, or its later
+	 * write-back overwrites the handler.
+	 */
+	flush_dcache_size(ebase + offset, size);
 	memcpy((void *)(uncached_ebase + offset), addr, size);
 }
 
diff --git a/arch/mips/mm/c-r3k.c b/arch/mips/mm/c-r3k.c
index 5869df848fab..a1be13775d2c 100644
--- a/arch/mips/mm/c-r3k.c
+++ b/arch/mips/mm/c-r3k.c
@@ -270,7 +270,7 @@ static void r3k_flush_kernel_vmap_range(unsigned long vaddr, int size)
 	BUG();
 }
 
-static void r3k_dma_cache_wback_inv(unsigned long start, unsigned long size)
+static void r3k_flush_dcache_size(unsigned long start, unsigned long size)
 {
 	/* Catch bad driver code */
 	BUG_ON(size == 0);
@@ -299,10 +299,11 @@ void r3k_cache_init(void)
 	__flush_kernel_vmap_range = r3k_flush_kernel_vmap_range;
 
 	flush_data_cache_page = r3k_flush_data_cache_page;
+	flush_dcache_size = r3k_flush_dcache_size;
 
-	_dma_cache_wback_inv = r3k_dma_cache_wback_inv;
-	_dma_cache_wback = r3k_dma_cache_wback_inv;
-	_dma_cache_inv = r3k_dma_cache_wback_inv;
+	_dma_cache_wback_inv = r3k_flush_dcache_size;
+	_dma_cache_wback = r3k_flush_dcache_size;
+	_dma_cache_inv = r3k_flush_dcache_size;
 
 	pr_info("Primary instruction cache %ldkB, linesize %ld bytes.\n",
 		icache_size >> 10, icache_lsize);
diff --git a/arch/mips/mm/c-r4k.c b/arch/mips/mm/c-r4k.c
index d8aadd3dc057..8b600de64dff 100644
--- a/arch/mips/mm/c-r4k.c
+++ b/arch/mips/mm/c-r4k.c
@@ -743,9 +743,7 @@ static void r4k_flush_icache_user_range(unsigned long start, unsigned long end)
 	return __r4k_flush_icache_range(start, end, true);
 }
 
-#ifdef CONFIG_DMA_NONCOHERENT
-
-static void r4k_dma_cache_wback_inv(unsigned long addr, unsigned long size)
+static void r4k_flush_dcache_size(unsigned long addr, unsigned long size)
 {
 	/* Catch bad driver code */
 	if (WARN_ON(size == 0))
@@ -786,6 +784,8 @@ static void r4k_dma_cache_wback_inv(unsigned long addr, unsigned long size)
 	__sync();
 }
 
+#ifdef CONFIG_DMA_NONCOHERENT
+
 static void prefetch_cache_inv(unsigned long addr, unsigned long size)
 {
 	unsigned int linesz = cpu_scache_line_size();
@@ -1743,14 +1743,15 @@ void r4k_cache_init(void)
 
 	flush_icache_all	= r4k_flush_icache_all;
 	flush_data_cache_page	= r4k_flush_data_cache_page;
+	flush_dcache_size	= r4k_flush_dcache_size;
 	flush_icache_range	= r4k_flush_icache_range;
 	local_flush_icache_range	= local_r4k_flush_icache_range;
 	__flush_icache_user_range	= r4k_flush_icache_user_range;
 	__local_flush_icache_user_range	= local_r4k_flush_icache_user_range;
 
 #ifdef CONFIG_DMA_NONCOHERENT
-	_dma_cache_wback_inv	= r4k_dma_cache_wback_inv;
-	_dma_cache_wback	= r4k_dma_cache_wback_inv;
+	_dma_cache_wback_inv	= r4k_flush_dcache_size;
+	_dma_cache_wback	= r4k_flush_dcache_size;
 	_dma_cache_inv		= r4k_dma_cache_inv;
 #endif /* CONFIG_DMA_NONCOHERENT */
 
diff --git a/arch/mips/mm/cache.c b/arch/mips/mm/cache.c
index ad9b0430a28e..b69b87c6c0cb 100644
--- a/arch/mips/mm/cache.c
+++ b/arch/mips/mm/cache.c
@@ -51,6 +51,7 @@ EXPORT_SYMBOL_GPL(__flush_kernel_vmap_range);
 /* MIPS specific cache operations */
 void (*flush_data_cache_page)(unsigned long addr);
 void (*flush_icache_all)(void);
+void (*flush_dcache_size)(unsigned long start, unsigned long size);
 
 EXPORT_SYMBOL(flush_data_cache_page);
 EXPORT_SYMBOL(flush_icache_all);

base-commit: 24a19b953e2a3d0ea5a8c4951a0ab8f32720c907
-- 
2.47.3

