Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 643E1485CFC
	for <stable@vger.kernel.org>; Tue,  1 Sep 2026 17:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788282564; cv=none; b=ViO11kay6Nx3d2bpZphW6ThU/hrmsc01EO5plaCDVYf+6J3waFKYQcrRvew80uCQOwGdqa3QxrQqBP4hdTB0/WxUmMYXt6U6pEEWFzpIMJRt9gHw6cxMCdzvsxEfOYOBUSwSbOmpn/sWdqSGVdPxgkDjSioB3DkdlYmozkq2yTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788282564; c=relaxed/simple;
	bh=zrnOF43taoerZ+b1qJhujsiK8novkLtc50y8hRyQ+78=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gO1Gko8/5T/MhvrEyYtOVDo43+CXbkJbfIWmrKMYRnAIckXsMOeOuTNXp9o/R4ZhnTk4bI0KqqStP3bYo4oGthQn9yWlqlACQGWa07KG0GjDwQ5ZanEGCyA6745Xg2WsblTLyx6LCnmzyj3bhYPCEdTmnEbErQaxKApAGHNdqJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=x6u.co; spf=pass smtp.mailfrom=x6u.co; dkim=pass (2048-bit key) header.d=x6u.co header.i=@x6u.co header.b=XVnErx++; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=x6u.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=x6u.co
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=x6u.co header.i=@x6u.co header.b="XVnErx++"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-861f30636f9so3189017b3.0
        for <stable@vger.kernel.org>; Tue, 01 Sep 2026 10:09:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=x6u.co; s=google; t=1788282561; x=1788887361; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+HsJ7WWSDXGGxM5KQ2N5tTmcNL3Nov2eFWn2UfdJVq4=;
        b=XVnErx++WF+TV6L6C1ayZ3jY3i+BlWRIQ6ynbjaDesJZhjmamagdRryECV5+J66oNQ
         IBeC58CHQjH2DxmcRQBMSpBk0Kirs50LAkZBGoWz6rmrdcTGXZUv04vXHA11N1wyPvhe
         Vch7T0oahlcNnzkDhsp4phqpwsrqHhvPayHyBLxMWLTJFDtJYPtRchMjkYkHKpnbmrhq
         DGMPOJwc2CYfZwy+nS80SBu44iFhXGTtwIRE7LkdD+6XqN/fLFJIMkCB1rcqHJbEDB9l
         5Zv1bP1mBtzLUi5Z0vgkpP43hOmxTUTVts5wz8GtoR+y21MEuuG0rU1Nyb4u/N1kSqK6
         hCSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788282561; x=1788887361;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+HsJ7WWSDXGGxM5KQ2N5tTmcNL3Nov2eFWn2UfdJVq4=;
        b=N0vbDRaWeBmEgiwWiFARm5DUZo3dqqVIK5PgaNeWo8yFweomCCEIO6A6vueS1a3JA+
         lwnQWl49oxTu8Og5+GFZE+Ge2/vLQX6MQlFS/jY2pcCrEgWOkLwdjE+u7gnercYqnagu
         5mnC9IVtRmO2pc/J7kPTI8QyTxXUY90k1aSKhg5p3WpyOravMMEDonQcFpgeZu2843Et
         EcEkzbrl14gI+o89caFnDp3TB1LIOHgDapuelbzpO+zxjc771Z4YV5OVNN+DywZAaBsj
         ksK9oyrhy0AMWRqV74bjfwwbvkaEzvypTJX/1sbybFwg2i3nLUmX/0G79hxjgNkao4/m
         J1lQ==
X-Forwarded-Encrypted: i=1; AKwUvBxkYoR1ur2lBuHB1D6fX3oeeEyOG4CSi4gy+6jsILODfM7hBnvYyfDZYt8fX7SWZU/fvAXRXII=@vger.kernel.org
X-Gm-Message-State: AFuF++nO9ACr5Gppf34HDiZdK1kMJFVW8p235BruY53Cbb9JCqUio19v
	CJjeRmQpylZtVOcuQ6F9qaio8x42LvkHRr513aFadMfkSGiOLY7kh6Wf9YJDAR3j3hqO
X-Gm-Gg: AYBFou1PH8asHviKohc/0/YXSMlBSqVjys9XY8ek+LjNPTB+fv1+24nLk/UccYi7p7R
	dLQO50in/UCfKrMpgLJbL4IlQ63r+aG/jtGwPbTmag6ob59U9ieBoJ6JCfO7I0d8HxMrHyG+/2S
	QypBrtn3b202TcTYnk+Vn8DnYfKsO0Sfi0qgwlXphlYBvY5/PFwIs5HF011cVaC4mZmrng/oaCs
	C+oNk9xR3ELaWQhfpg4AG3m8E33F+xYoLxbw/8vscFTfQEXEzcdm5p3SSSMQmyGDXpPONY+PlYS
	SRZWauTINF+GrhKq7I6DZKjw29Ai5tnpPtXENdlz/D1EWuYh3QXnuOXp17i//mG92rgFchwaAog
	8mU62rQ5hpkYyBqoNaqtz75FnKH6WT5Xxu1BMs47I3UVAW0AKZBi6GYSUjNbvplxKriZb29Zjst
	VM8QZJy85yI0lDMTNVnSKJ44WihnBvuZQfidQP2Bi2VEf95Za5VhDsKwws4v16p/MI166MCtw/H
	wWdYPVZVYEwHGNFW9p65AnLw6XmBk5ZSvO8bFgC7YFzAVG30QMzL/Y5oEOVfx5EVyjC5Fu7hZPK
	9fM=
X-Received: by 2002:a05:690c:6603:b0:81f:e85b:f9f4 with SMTP id 00721157ae682-85d6b8472ebmr126795317b3.27.1788282561098;
        Tue, 01 Sep 2026 10:09:21 -0700 (PDT)
Received: from worldpeace10.c.googlers.com.com (109.243.150.34.bc.googleusercontent.com. [34.150.243.109])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-85e65f146edsm79761867b3.32.2026.09.01.10.09.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 10:09:20 -0700 (PDT)
From: David Hu <dhu@x6u.co>
To: sumit.semwal@linaro.org,
	christian.koenig@amd.com
Cc: alex@shazbot.org,
	ankita@nvidia.com,
	chriscli@google.com,
	david.laight.linux@gmail.com,
	dri-devel@lists.freedesktop.org,
	iommu@lists.linux.dev,
	jgg@ziepe.ca,
	jmoroni@google.com,
	kevin.tian@intel.com,
	kpberry@google.com,
	leon@kernel.org,
	linaro-mm-sig@lists.linaro.org,
	linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org,
	nicolinc@nvidia.com,
	praan@google.com,
	sashiko-bot@kernel.org,
	stable@vger.kernel.org,
	viursachi@google.com,
	xuehaohu@google.com,
	Leon Romanovsky <leonro@nvidia.com>
Subject: [PATCH v8 2/2] dma-buf: Split sgl by largest page-aligned chunk
Date: Tue,  1 Sep 2026 17:08:49 +0000
Message-ID: <20260901170849.4052816-3-dhu@x6u.co>
X-Mailer: git-send-email 2.55.0.966.g6673acef38-goog
In-Reply-To: <20260901170849.4052816-1-dhu@x6u.co>
References: <20260901170849.4052816-1-dhu@x6u.co>
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
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
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
index 80f6ab2f4809..833be519e1e6 100644
--- a/drivers/dma-buf/dma-buf-mapping.c
+++ b/drivers/dma-buf/dma-buf-mapping.c
@@ -6,16 +6,17 @@
 #include <linux/dma-buf-mapping.h>
 #include <linux/dma-resv.h>
 #include <linux/overflow.h>
+#include <linux/align.h>
+
+#define MAX_SG_ENT_SZ ALIGN_DOWN(UINT_MAX, PAGE_SIZE)
 
 static struct scatterlist *fill_sg_entry(struct scatterlist *sgl, size_t length,
 					 dma_addr_t addr)
 {
-	unsigned int len, nents;
-	unsigned int i;
+	size_t len;
 
-	nents = DIV_ROUND_UP(length, UINT_MAX);
-	for (i = 0; i < nents; i++) {
-		len = min_t(size_t, length, UINT_MAX);
+	while (length) {
+		len = min(length, MAX_SG_ENT_SZ);
 		length -= len;
 		/*
 		 * DMABUF abuses scatterlist to create a scatterlist
@@ -25,8 +26,10 @@ static struct scatterlist *fill_sg_entry(struct scatterlist *sgl, size_t length,
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
 
@@ -42,7 +45,7 @@ static unsigned int calc_sg_nents(struct dma_iova_state *state,
 
 	if (!state || !dma_use_iova(state)) {
 		for (i = 0; i < nr_ranges; i++) {
-			unsigned int added = DIV_ROUND_UP(phys_vec[i].len, UINT_MAX);
+			unsigned int added = DIV_ROUND_UP(phys_vec[i].len, MAX_SG_ENT_SZ);
 
 			if (check_add_overflow(nents, added, &nents))
 				return 0;
@@ -53,7 +56,7 @@ static unsigned int calc_sg_nents(struct dma_iova_state *state,
 		 * for whole IOVA address space, but we need to make sure
 		 * that it fits sg->length, maybe we need more.
 		 */
-		nents = DIV_ROUND_UP(size, UINT_MAX);
+		nents = DIV_ROUND_UP(size, MAX_SG_ENT_SZ);
 	}
 
 	return nents;
-- 
2.55.0.897.gb25b4bd76c-goog

