Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C9EC846A;
	Sun, 27 Sep 2026 00:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790470745; cv=none; b=WNBmdZri5GGZGNVEZYY3BedgihFdiqrO8H6ApTRibDMqiSD4qOaAYK+cZIxVmVqqrVy596SlHUNTNF4zcFHvc1CS9IuT93mveQ6JUDSIT2cT6ssHLwaPyp9dTdbqPshYkXrTHCFkr+v8nktrYbRwIL5BHj5db1Vgt+qmrctNIFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790470745; c=relaxed/simple;
	bh=FSzSI/8G+fkh3A5CkDGLOk1a/eYwWj6oCNoq6cMW60g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=T3u7ft3RQMA0vV19Mj9T1fEmacWQWwXzBy9zqA6LMCzpOC7q9mWJTuIYWqMx+cMDuP1J590x2HBXnECfwi4OsQAMwhPWprKE4Nq34iTOHy+9QLhZBiwj9YX9wmgBvl30f+KyyRcq2e4d4A+KTXlVGAYtHTup6msU1TbkUhHM8tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ccMvoFwh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ccMvoFwh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0437F1F000FF;
	Sun, 27 Sep 2026 00:59:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790470744;
	bh=MufkwV0SkWemfP9jT9XKRhDU173yXKeUnbqChB4aUTI=;
	h=From:To:Cc:Subject:Date;
	b=ccMvoFwhNLQBRKNtieKB5ur71c+UIEXQmSo9K5+kn8vtmCR+OzUgMBVrDcM4JF56B
	 BxjZjGCeTllYN6i1Av+u8EoYqT95UwMhz9EZlGhdm+nZFFFOB+jfQuqWbmeUcne/O9
	 LZjlEeKZYBJ6x0pSYk7gixtf7x9PAUr5OnefKCPy9tE2CKiiXR4JCPTaCK28cuXM7r
	 lNDjhaj6ig0dHp0J4zsmRkT6K/ZqwAT/gBaQIpXlI9uRhxO0yb6D0X/1xK22DXbB+C
	 E8j87gbTgUdX6odxk8SyCE48g5rrBL+v1IXjimRJy9mi6PcXLZ/7BZuLUVlfOASdBg
	 7TIUau7vVdtTQ==
From: Imre Kaloz <kaloz@kernel.org>
To: Andreas Larsson <andreas@gaisler.com>,
	sparclinux@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	stable@vger.kernel.org
Subject: [PATCH] sparc32: don't clear the nocache pool through the PROM mappings
Date: Sun, 27 Sep 2026 02:58:01 +0200
Message-ID: <20260927005801.8338-1-kaloz@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

srmmu_nocache_init() runs before the switch to srmmu_swapper_pg_dir, so
lowmem is still reached through the PROM mappings the head code inherits
for KERNBASE, which end at 10MB on a SPARCstation 20. The pool, up to
5MB and allocated right above the kernel, was cleared there twice, by
memblock_alloc() and by the memset(). Once the kernel image ends above
5MB the clear runs past the PROM's window, faults, and the boot CPU
enters error mode.

Every user of the pool clears what it allocates, so allocate the pool
with memblock_alloc_raw(), after the bitmap so the bitmap lands below it.

This has been broken since 2.4.0-test2pre2.

Cc: stable@vger.kernel.org
Signed-off-by: Imre Kaloz <kaloz@kernel.org>
---

Notes:
    No Fixes: tag: this has been broken since 2.4.0-test2pre2, before the
    git history.

 arch/sparc/mm/srmmu.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/arch/sparc/mm/srmmu.c b/arch/sparc/mm/srmmu.c
index 9a74902ad181..16d5cde4f949 100644
--- a/arch/sparc/mm/srmmu.c
+++ b/arch/sparc/mm/srmmu.c
@@ -277,15 +277,24 @@ static void __init srmmu_nocache_init(void)
 
 	bitmap_bits = srmmu_nocache_size >> SRMMU_NOCACHE_BITMAP_SHIFT;
 
-	srmmu_nocache_pool = memblock_alloc_or_panic(srmmu_nocache_size,
-					    SRMMU_NOCACHE_ALIGN_MAX);
-	memset(srmmu_nocache_pool, 0, srmmu_nocache_size);
-
 	srmmu_nocache_bitmap =
 		memblock_alloc_or_panic(BITS_TO_LONGS(bitmap_bits) * sizeof(long),
 			       SMP_CACHE_BYTES);
 	bit_map_init(&srmmu_nocache_map, srmmu_nocache_bitmap, bitmap_bits);
 
+	/*
+	 * Until the switch to srmmu_swapper_pg_dir, lowmem is only reachable
+	 * through the PROM's mappings, which may end below the top of the pool
+	 * (at 10MB on the SPARCstation 20). Allocate the pool after the bitmap
+	 * so the bitmap stays below it, and leave it uncleared: every user of
+	 * the pool clears what it allocates.
+	 */
+	srmmu_nocache_pool = memblock_alloc_raw(srmmu_nocache_size,
+						SRMMU_NOCACHE_ALIGN_MAX);
+	if (!srmmu_nocache_pool)
+		panic("%s: Failed to allocate %lu bytes\n", __func__,
+		      srmmu_nocache_size);
+
 	srmmu_swapper_pg_dir = __srmmu_get_nocache(SRMMU_PGD_TABLE_SIZE, SRMMU_PGD_TABLE_SIZE);
 	memset(__nocache_fix(srmmu_swapper_pg_dir), 0, SRMMU_PGD_TABLE_SIZE);
 	init_mm.pgd = srmmu_swapper_pg_dir;

base-commit: 62f4c998b297cf233997a2b4cd6fc2d2df0319c9
-- 
2.47.3

