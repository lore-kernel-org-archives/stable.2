Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793784101;
	b=xKx7L7mCvFnflqBC4tp/n3HxCs41QqMXl6l6YrAPVE6MK+70BfUVKtBD980ASKTtp/Ym
	 kg5PLvJ1dJvX/mOtSR3jPqNVF0RmGLLAGwF3g80Ox6kC1uiKpiCiFtj3IEeBhdHmh2z3R
	 ADGgIXf9AHFBfVfaPCi6KQPmqJwldxD5NvdN4HODNovldqJgO8jBNPk5q1zKgDmhq+Cg7
	 riafU2RpMq8Bs5B4nnwyw3NrZ2/EacUw7tILwippFKK6tFReODP7JtiCGIfoXMWJIS0y9
	 mwanpwPThdaS7lho4yb/ZY1fjaCJMrKvykUr84nAchrP1RcmjF+7YWpV3oUzGoQU8fw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793784101;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=9CBa+fk3/kbt44GXuKWA+WI61VvuFZ1X813XyE7+/Vw=;
	b=mfh5vGHXsB0ff4sqfGrheMZfleb+/L45TpZrya40cADOfleuJcJk9sMpiFqKg7sRj3mx
	 xHIq18Zt29KD8nWO+wPjJmTPap0Zp0PB4QLG2XeMQqqjWgU4a6iVjouFDHgKrokqzd85h
	 AwFvFFKRxjGPLtuNMnrEefpHJ9u8t0ZW/7N8pcOajTtY7fJEE7GxSf4Gs6H0rBoV9b8OD
	 pPwqpRnpjs8jk+eFhJovvgltQY+K0yeh//AWew2lJwA/QQAeyjtBzf+iT1IqNrooFzzef
	 5HD5W7ndQ+5/uR2/sFXsje+J7yUn7muaaT10ss5d7nUtloFpDwyxiboyFez9CapBQkw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UTmXrgKI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60C53606D821;
	Wed,  4 Nov 2026 09:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UTmXrgKI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87AD41F000C1;
	Wed,  4 Nov 2026 09:21:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793784101;
	bh=9CBa+fk3/kbt44GXuKWA+WI61VvuFZ1X813XyE7+/Vw=;
	h=From:To:Cc:Subject:Date;
	b=UTmXrgKImETXIEXLhuBFnXWDp4j/L6cjYUCzMrVtiGLdAqlPntbX6u5i23jsRDVGP
	 Deoa+3QtgyMVMulU5OHtgW1B7/dDgsHWwBEVOgdE+d94pADe1StR4pz0/wscipePyP
	 FB9quHAV0mv9IFfg80INOaPxftkaExgoq3K5MQK0pVQZj+yt+FWvFQ9/FjgwN2Ycpz
	 4Zs+cBE0heBYYRJb8spiZ5db0Grzt7/+bg0i5SKSyRZ3EQqHgM3HX+Zkx0GewV2u0Z
	 PBJUUd3p9u08VSNhWkVA2vWol/x+Cl+806K3iAc2aYJLQKnsczi7EV6Tz/Owhl+tor
	 Eiooa+OBUhTZw==
From: Imre Kaloz <kaloz@kernel.org>
To: Andreas Larsson <andreas@gaisler.com>,
	sparclinux@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Magnus Lindholm <linmag7@gmail.com>,
	Sang-Heon Jeon <ekffu200098@gmail.com>
Subject: [PATCH v2] sparc32: don't clear the nocache pool through the PROM mappings
Date: Wed,  4 Nov 2026 10:20:22 +0100
Message-ID: <20261104092022.5837-1-kaloz@kernel.org>
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

srmmu_nocache_init() runs before the switch to srmmu_swapper_pg_dir, so
lowmem is reached through the PROM mappings inherited for KERNBASE,
which end at 10MB on a SPARCstation 20. The pool, up to 5MB and
allocated right above the kernel, was cleared there by
memblock_alloc_or_panic(). Once the kernel image ends above 5MB the
clear runs past the window, faults, and the boot CPU enters error mode.

Every user of the pool clears what it allocates, so allocate the pool
with memblock_alloc_raw(), after the bitmap so the bitmap lands below it.

This has been broken since 2.4.0-test2pre2.

Cc: stable@vger.kernel.org
Signed-off-by: Imre Kaloz <kaloz@kernel.org>
---
Changes in v2:
- Rebased onto sparc for-next, where "sparc32: remove redundant memset
  in srmmu_nocache_init()" already dropped the memset(); the pool is
  still cleared once by memblock_alloc_or_panic().
- v1: https://lore.kernel.org/sparclinux/20260927005801.8338-1-kaloz@kernel.org/

No Fixes: tag: this has been broken since 2.4.0-test2pre2, before the
git history.

 arch/sparc/mm/srmmu.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/arch/sparc/mm/srmmu.c b/arch/sparc/mm/srmmu.c
index 337987e021d4..f0fb7b33c3e3 100644
--- a/arch/sparc/mm/srmmu.c
+++ b/arch/sparc/mm/srmmu.c
@@ -263,14 +263,24 @@ static void __init srmmu_nocache_init(void)
 
 	bitmap_bits = srmmu_nocache_size >> SRMMU_NOCACHE_BITMAP_SHIFT;
 
-	srmmu_nocache_pool = memblock_alloc_or_panic(srmmu_nocache_size,
-					    SRMMU_NOCACHE_ALIGN_MAX);
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

base-commit: c95443b98771a74c6689f5e7bbc56794fe95f550
-- 
2.47.3

