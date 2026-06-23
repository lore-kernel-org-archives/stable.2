Received: from mail-qt1-f202.google.com (mail-qt1-f202.google.com [209.85.160.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4AAB385D8D
	for <stable@vger.kernel.org>; Tue, 23 Jun 2026 01:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782179705; cv=none; b=R3BxOiNGkVQIo/8mXZhwueX5Q9U3S8Tr1JBRQl7D5wH2DwYBcMZ64CTMG2erhlav0NCWgdUZta6cREackNZ8YnU6xrPeeKpb68XVFi5kZbBgHG+iUuJ2NqmuIQE4Gi3xDq/X6tAOziQVXJ5lsxskhFG7QrV6HNzJ7scUeEPBFM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782179705; c=relaxed/simple;
	bh=bBWRORv7RUc8uRHv6zCGgvNd/JG4DiLB/oASlXLOQPs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=L7DK3rX4sWWu+nKEBqVOjo55feVDlQjvjRZweleQgCoIf6VrtKxHssSLAR1/cl5l50x7Xtwxvj4SoK1lFqbiM8WSfD9ysE5OgVSjC4knuIhDLzU/DtpHVrlJzAaXpW1lARCp/8+JNvRWcZ4TrCOuRyJUaZqrB8MgB1gE2J4LEYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--xuehaohu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TVgsc0sT; arc=none smtp.client-ip=209.85.160.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--xuehaohu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TVgsc0sT"
Received: by mail-qt1-f202.google.com with SMTP id d75a77b69052e-517ac42d958so97978921cf.0
        for <stable@vger.kernel.org>; Mon, 22 Jun 2026 18:55:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782179702; x=1782784502; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=lkITz2dGNs54nij5ccY4KCvNRYJG4BpFQmrxgUXzmOc=;
        b=TVgsc0sTIDf3LSHX/MsKLkwwjnd2LZOOlBd0U8+/Z52q1GSIBRwWzmJiQFJA+HC+DP
         NwpBus+1F/xW819J8IgPepSE2YQUUSNM1wxtmbCFCVLrRU7Ei6aaQl9HlqDAN+Cpro4f
         Bx1/SNsm/nIYpqkGwgTH7lRZKXh55ilepG3RDnRXBP6DgpaS6YCd5+r68rp6qxC5j+4d
         4GaiC8f7Inyssj3LZTsgVaN6CnZ9VLfuM5dt4DaojjIbQ7E6rdivfH5FVVKFjGTM2LeX
         5ZVB0Yxf4c3tyqZ+glK+SJI4VLo2CUJZdW6PbJYscq2lYkKFR7VAqxE5pdOiHYNg7G29
         uEdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782179702; x=1782784502;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lkITz2dGNs54nij5ccY4KCvNRYJG4BpFQmrxgUXzmOc=;
        b=mNpsfjl7vhRfqDxpyR9UBBdL0rih0y21JjUp/sPsrBQKVUskr70wkSqzz9+0DbBn41
         86yH8HeTxG4AA7hdtFiOoZ/BGbXpRbAfRhQRPY8Abv+o4RWZVj8JJ/bMgKc8d/hieXNs
         NmBSd7L+i5ZOpaXyLqXgdh3t/YMvnCsJuoeIpFwHdG1TS6taZk6xaD3wCx75Z0VQIIVh
         CFHHWtxcb2pJBnbDwla4QADGS4khb7ofBGWwolmnlarArHga9MfbX6Q082LM4K0Ayc4I
         7UUFUX6b7gyGOuo9ZwsDL7P72FvTAPVwgLbfUg2u9WfhyQzhYHS3L+Lv4uGjdbJ///16
         ERBA==
X-Forwarded-Encrypted: i=1; AFNElJ/DP85YI6MW7fzKRNhkJutDCqtfZfNUpSspQBYRBHDYVKF41RNg8gEXYn7Wb2qFIfn+q2CV2+o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9viwFkLaBKKiNDd0SG/oLI0OMAcBNc8OVbccqcDCAEC6hGFcR
	7q5dZqJCBkUuqsKyei0hEG9C5QBr3pGYxzd6cTvt1IElkHX06g3icoiPQZsGiU3nu7JnHQ6V92Y
	ykzjaVFRhi3UC
X-Received: from qtxx9-n2.prod.google.com ([2002:a05:622a:aac9:20b0:517:96a4:99ea])
 (user=xuehaohu job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:2609:b0:519:89f6:6ed4 with SMTP id d75a77b69052e-51a548b6418mr13414611cf.47.1782179701475;
 Mon, 22 Jun 2026 18:55:01 -0700 (PDT)
Date: Tue, 23 Jun 2026 01:54:59 +0000
In-Reply-To: <20260621222130.1667453-1-xuehaohu@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260621222130.1667453-1-xuehaohu@google.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260623015459.1153884-1-xuehaohu@google.com>
Subject: [PATCH v2] dma-buf: Split sgl into page-aligned 2G chunks
From: David Hu <xuehaohu@google.com>
To: Sumit Semwal <sumit.semwal@linaro.org>, 
	"=?UTF-8?q?Christian=20K=C3=B6nig?=" <christian.koenig@amd.com>
Cc: David Laight <david.laight.linux@gmail.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Nicolin Chen <nicolinc@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Kevin Tian <kevin.tian@intel.com>, 
	Ankit Agrawal <ankita@nvidia.com>, Alex Williamson <alex@shazbot.org>, linux-media@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, 
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev, jmoroni@google.com, 
	praan@google.com, kpberry@google.com, chriscli@google.com, 
	sashiko-bot@kernel.org, stable@vger.kernel.org, 
	David Hu <xuehaohu@google.com>
Content-Type: text/plain; charset="UTF-8"

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

Fix this by splitting the scatterlist into 2G chunks. An alternative
previously considered was to use the largest page aligned chunk within
`UINT_MAX` (`ALIGN_DOWN(UINT_MAX, PAGE_SIZE)`) to satisfy page
alignment. A 2G chunk is better as it naturally aligns with most known
hardware boundaries, while also allowing compiler optimizations with
simple bit shifts. This ensures all scatterlist DMA addresses and
lengths remain page aligned and satisfy hardware constraints.

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

 drivers/dma-buf/dma-buf-mapping.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/dma-buf/dma-buf-mapping.c b/drivers/dma-buf/dma-buf-mapping.c
index 794acff2546a..2d88e08c5ebf 100644
--- a/drivers/dma-buf/dma-buf-mapping.c
+++ b/drivers/dma-buf/dma-buf-mapping.c
@@ -5,16 +5,17 @@
  */
 #include <linux/dma-buf-mapping.h>
 #include <linux/dma-resv.h>
+#include <linux/sizes.h>
+
+#define MAX_SG_ENT_SZ ((size_t)SZ_2G)
 
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
@@ -24,11 +25,12 @@ static struct scatterlist *fill_sg_entry(struct scatterlist *sgl, size_t length,
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
-
 	return sgl;
 }
 
@@ -41,14 +43,14 @@ static unsigned int calc_sg_nents(struct dma_iova_state *state,
 
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
2.55.0.rc0.799.gd6f94ed593-goog

