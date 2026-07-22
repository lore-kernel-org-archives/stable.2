Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46227459ADC
	for <stable@vger.kernel.org>; Wed, 22 Jul 2026 23:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784763582; cv=none; b=f7gX6gDNZUE7ybSMuuUmphGvUf2ptZNZZKplgM7L4din6mmGyWBqDNkbI+FwUcbTq48gAUXUQL3gwZHGmNCUqB1v9DfkYGEHllVrM11aC/4vBVD2ecd8LE0UIoMj9AC4WEDqFa02Au+mOHNWdOAZkiPmt1lef80UrtqIlhsJmck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784763582; c=relaxed/simple;
	bh=482j/rlGL/MyUIfK5vi1HCJAff/SkFOJEYzr2v72u54=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R5O1t586o+eP2s5Rx/ECk/8VnVpuAmzDwR2jUvkfQUu//OJjZIEJNed86dEYVZwyQM8wnlMdH6FY/gOYSAhKjrOSgi2YybHGUYFsT3r6FSFSqw8+A19JniOAmxcxVfmruitWkn2F8FunEslfbb7x49WO+idUr1krtYmJ2fILknA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=x6u.co; spf=pass smtp.mailfrom=x6u.co; dkim=pass (2048-bit key) header.d=x6u.co header.i=@x6u.co header.b=NHuFYO5t; arc=none smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=x6u.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=x6u.co
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=x6u.co header.i=@x6u.co header.b="NHuFYO5t"
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-6685483aad2so15852d50.0
        for <stable@vger.kernel.org>; Wed, 22 Jul 2026 16:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=x6u.co; s=google; t=1784763578; x=1785368378; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=czUeoqytFwl2f4wSjedp4ua+inBVMuooqHyWYibjU+0=;
        b=NHuFYO5t9QVIFDAK2j2M2SWFNgOG833xmV89KfrwdmjcPiRvUmGoahuI7+0CAZFZFp
         NELGx44Nt0bswc2It390av/3NuXepaatTbyI+p0mzWWvX0IZrva7BLnYYeE2x4J0MsxA
         wp2fBOffL3ZO1dRTUnbAni73wYdHwNS5uu5pyE9eOR7YkyEtxXRDqHYy9rSi7sRxUP2X
         NfGbmVR6HHzT+2w5ueGEaW8hg1Z82IJZDhzT+FtiCF6eDsNcWmceV+AaeD33+L8o71w9
         N7X4iWnD19RhHS241GmR/5WmebRaLvJtqj60rRYUFLjZ2/8JBAlgjscOn4GipEjt4xh+
         sGmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784763578; x=1785368378;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=czUeoqytFwl2f4wSjedp4ua+inBVMuooqHyWYibjU+0=;
        b=sIOsRgXoK2/fHA6cn613MUYvBoa+0BHp45s81t+wKT8r+7q+8X1Fe2qSfJm6r9Vdqf
         yMv/yVZ0kCIBM8yYeiuoCRuMOvCO6hBwUaqAw1DlZ1jdQsb00Z4Q40ICey8t6fA2W3dQ
         puryInpfEfPi0kctaDtybVQgCkpNJ/iqvBpzi6WnklJWgxBFbDqfPzQdAjTk4flGKKJs
         BmxUQW0I4sUm8uOeUPCaLJVBB1IZRb4pIw3aZT0xVA4vOzn3XRYnb7MpCpvKAaGI3rVs
         MYDldtMmJ0eEtc9KXiE/cK0+Ks0CCDIQwuhjkg2wcdqPtCmrnW/qI1n9tLgNsaZS3H1M
         G5GA==
X-Forwarded-Encrypted: i=1; AHgh+RqD/8CqBPOY+E1ZSSOtRiAzu3JXtuEmQFu722MhIYNE2lV2TpuYvOGla4Wjf4Kyu8daD559/gg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzflhl/3+q8LQ96gL+xxi0ITn6CINHXe1mL35l02R1kL1AoqApq
	OIAXy6k0Qp8Usd0HDWdyNp7CuXPnlpfTtQemfZOOgyUnR1oLX+zTvi8sGNfgOwcUkjfn
X-Gm-Gg: AR+sD11JrUZw0O0+RTz4DUbiOqW6lWqBRB+k7PEAxMkg/eYHJ5KhcZ9L0LDkqBybEDt
	hI0BEz7SvZ5/+liesuOv0mfnJyKEZ+ORJntVvktHC1lxPrIQv20eAfxxzzKqB0Z86Dr1KJHqbw2
	zmEc/SasRs4Qpq6t7mbNhemsEkNFx+Xx5iDwgpDC9kijjqo2IMIoxSvLkgKbGlntX4ppFxRHG7O
	ZTNpf97/QEJ7gaoOPULU3YXGjuEwJv6MOZVI3tcg50pVY/ltQkBw8kmH73cald1f1+oR/RbGvaJ
	VxLmdbYmvRd+cpcGRHkJRF03C3HEL7LM7lFTsNuBwfZb8Ki4lTHgMZpXINHnC2JZW34WQTzl03C
	g+7Us2D7GDD6ZHNjKZ/50fRPJXe4lUEkI2d44BBrt8ecLRIjzWBW0NzqoXlbCYvzY4i7BS2WSpJ
	pCn1QuT6aClLrwQcHJ6ypD6ivt6Q/YfK4wT5J/pzAikCibREAHCF4C02Ob/8RMBfwNsmM=
X-Received: by 2002:a05:690c:9a87:b0:7ff:19d6:74ee with SMTP id 00721157ae682-81f4c31fe46mr2273147b3.33.1784763577509;
        Wed, 22 Jul 2026 16:39:37 -0700 (PDT)
Received: from worldpeace10.c.googlers.com.com (234.207.85.34.bc.googleusercontent.com. [34.85.207.234])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-66890794b1asm2152505d50.20.2026.07.22.16.39.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 16:39:37 -0700 (PDT)
From: dhu@x6u.co
To: Sumit Semwal <sumit.semwal@linaro.org>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>,
	David Laight <david.laight.linux@gmail.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Kevin Tian <kevin.tian@intel.com>,
	Ankit Agrawal <ankita@nvidia.com>,
	Alex Williamson <alex@shazbot.org>,
	Pranjal Shrivastava <praan@google.com>,
	linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org,
	linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev,
	stable@vger.kernel.org,
	jmoroni@google.com,
	kpberry@google.com,
	chriscli@google.com,
	viursachi@google.com,
	xuehaohu@google.com,
	sashiko-bot <sashiko-bot@kernel.org>
Subject: [PATCH v3] dma-buf: Split sgl by largest page-aligned chunk
Date: Wed, 22 Jul 2026 23:39:32 +0000
Message-ID: <20260722233932.3997681-1-dhu@x6u.co>
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
In-Reply-To: <20260623015459.1153884-1-xuehaohu@google.com>
References: <20260623015459.1153884-1-xuehaohu@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: David Hu <xuehaohu@google.com>

Currently, `fill_sg_entry()` splits the scatterlist using `UINT_MAX`.
This creates a non-page-aligned DMA length (`0xFFFFFFFF`) for the
first entry, resulting in non-page-aligned DMA addresses for all
subsequent entries.

While the underlying IOMMU mapping may be contiguous, hardware
DMA engines often require explicit address alignment (e.g., page,
cacheline, or storage sector boundaries). Passing unaligned
addresses and lengths can cause explicit failures in DMA descriptor
creation or silent data corruption if lower unaligned bits are
truncated.

In addition, a non-page-aligned sgl length will trigger an edge case
in `ib_umem_find_best_pgsz()`. In case of a discontinuity in later
buffers, we will have a `va` with lowest bit set to 1. That will lead
to `ib_umem_find_best_pgsz()` always return 0, and break the promise
to find best page size for the mapping on the NIC side.

Fix this by splitting the scatterlist by the largest possible page
aligned chunk within `UINT_MAX` (`ALIGN_DOWN(UINT_MAX, PAGE_SIZE)`).
This ensures all scatterlist DMA addresses and lengths remain page
aligned, while minimizing the total number of sgl entries.

Page-aligned entries allow the system to cleanly chunk payloads into
PCIe MaxPayloadSize (MPS) (e.g., 128 bytes, 256 bytes, 512 bytes).
As a result, this may help reduce TLP fragmentation in P2P transfers
and alleviate potential congestion within a logical PCIe switch
partition, especially when Relaxed Ordering is not possible due to
hardware constraints.

Reported-by: sashiko-bot <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/all/20260609165431.778061F00893@smtp.kernel.org/
Fixes: 3aa31a8bb11e ("dma-buf: provide phys_vec to scatter-gather mapping routine")
Cc: stable@vger.kernel.org
Signed-off-by: David Hu <xuehaohu@google.com>
---
 Changes in v3:
 - Removed the type cast for `min` (David Laight)
 - Reverted max ent size to be `ALIGN_DOWN(UINT_MAX, PAGE_SIZE)` and
   updated commit message to reflect that (Jason Gunthorpe)
 - Updated commit message to reflect that this also fixes an edge case
   in `ib_umem_find_best_pgsz()`

 Changes in v2:
 - Updated commit title and message to reflect the switch to 2G chunks
 - Switch to using 2G as the max sg entry size as it naturally aligns
   with most hardware boundaries, while allowing compiler optimizations
   with bit shifts (David Laight)
 - Optimized away division calculation for `nent`, and multiplication
   calculation for sgl address, by dropping the `for` loop in favor of a
   `while (length)` loop (David Laight)
 - Dropped `min_t` in favor of `min()` to maintain a strict type
   checking safety net (David Laight)

 drivers/dma-buf/dma-buf-mapping.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/dma-buf/dma-buf-mapping.c b/drivers/dma-buf/dma-buf-mapping.c
index 794acff2546a..50ded9daf5fb 100644
--- a/drivers/dma-buf/dma-buf-mapping.c
+++ b/drivers/dma-buf/dma-buf-mapping.c
@@ -5,16 +5,17 @@
  */
 #include <linux/dma-buf-mapping.h>
 #include <linux/dma-resv.h>
+#include <linux/align.h>
+
+#define MAX_SG_ENT_SZ ALIGN_DOWN(UINT_MAX, PAGE_SIZE)
 
 static struct scatterlist *fill_sg_entry(struct scatterlist *sgl, size_t length,
 					 dma_addr_t addr)
 {
-	unsigned int len, nents;
-	int i;
+	size_t len;
 
-	nents = DIV_ROUND_UP(length, UINT_MAX);
-	for (i = 0; i < nents; i++) {
-		len = min_t(size_t, length, UINT_MAX);
+	while (length) {
+		len = min(length, MAX_SG_ENT_SZ);
 		length -= len;
 		/*
 		 * DMABUF abuses scatterlist to create a scatterlist
@@ -24,8 +25,10 @@ static struct scatterlist *fill_sg_entry(struct scatterlist *sgl, size_t length,
 		 * does not require the CPU list for mapping or unmapping.
 		 */
 		sg_set_page(sgl, NULL, 0, 0);
-		sg_dma_address(sgl) = addr + (dma_addr_t)i * UINT_MAX;
+		sg_dma_address(sgl) = addr;
 		sg_dma_len(sgl) = len;
+		addr += len;
+		/* Unconditionally advance. On last segment, this becomes NULL */
 		sgl = sg_next(sgl);
 	}
 
@@ -41,14 +44,14 @@ static unsigned int calc_sg_nents(struct dma_iova_state *state,
 
 	if (!state || !dma_use_iova(state)) {
 		for (i = 0; i < nr_ranges; i++)
-			nents += DIV_ROUND_UP(phys_vec[i].len, UINT_MAX);
+			nents += DIV_ROUND_UP(phys_vec[i].len, MAX_SG_ENT_SZ);
 	} else {
 		/*
 		 * In IOVA case, there is only one SG entry which spans
 		 * for whole IOVA address space, but we need to make sure
 		 * that it fits sg->length, maybe we need more.
 		 */
-		nents = DIV_ROUND_UP(size, UINT_MAX);
+		nents = DIV_ROUND_UP(size, MAX_SG_ENT_SZ);
 	}
 
 	return nents;
-- 
2.55.0.229.g6434b31f56-goog

