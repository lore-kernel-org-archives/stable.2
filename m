Received: from mail-qv1-f73.google.com (mail-qv1-f73.google.com [209.85.219.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D012371D15
	for <stable@vger.kernel.org>; Sun, 21 Jun 2026 22:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782080496; cv=none; b=UEjJ397qRbb12vQj6rgQjy5lAcObpG/DXTs+HS19cd5KhTsJ0l5kHRygi1dRMY+aervA5HmoyzvqvIpHoPVwRUxX1FrlBt/wuN4lk4VvrXYRTgrM6tobjbcS/TAYicinxZYZXHX+KwdXDGT3rWst5aPK9cjSphe4VqoMIMFiawA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782080496; c=relaxed/simple;
	bh=W6+v4i11Ax13kL48F/Y+SlQUTA6m8gwuQWrL0d08Rj4=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=RzwiSdrbhHdYBT2WQmJ77j7OzzANeo8FBAGyYPrgBK2dN3vcH5dAX2DE10fDb0bHT/nC1/tEru8VGT1wcMFCJ+uFx3O+VTuN6Y5R2+Icf9LtrW3hh1FtIQITeZWCMa6G3mB85yRsQt7w3HD4ETxBlPDnxa4V8FBlnBTxhLuGf34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--xuehaohu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TyUZkeV7; arc=none smtp.client-ip=209.85.219.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--xuehaohu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TyUZkeV7"
Received: by mail-qv1-f73.google.com with SMTP id 6a1803df08f44-8db90457124so38756736d6.1
        for <stable@vger.kernel.org>; Sun, 21 Jun 2026 15:21:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782080492; x=1782685292; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=E/rPiB1Qh/2nTPaKmpZPHKT5hQGs3BX51WUl0ayz+VA=;
        b=TyUZkeV7RwmVH2tiEkM1hzshluKBhYTdeavGlJGmC85HVDS9FtHKJzsRxGjo2v5hpk
         6eHrEou9JmfipKF6zyDMHCa/g/ich5I2tgS4rwP5YMzFPeQQ9rH+eZ+PkFw+YnEZkX60
         yinu6vURy/GUz0yaMPjmmpDP6tpRsxDaeJALq62ZKz0n+8VINQwCVbmjA0PNVScRzR/j
         xLcBJIzeH2+jE3FL4du2SYXEjQkTGWZF5auEcgMuIA46zVyYbrPA9TCsSkItFI8KtW0f
         DRBsKErrZf1ieedsOIC6WObeDfYksLf4YSYvPtkYvuaMjs20K95ZZ0OIx8gindxfYkuZ
         vFtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782080492; x=1782685292;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=E/rPiB1Qh/2nTPaKmpZPHKT5hQGs3BX51WUl0ayz+VA=;
        b=os3NqcRZuoeWmStx5b3Iq1HP1x8bN9sx0ps5UJPjCFA18oKyIhzOfzqf5Lf1Es0V4L
         1moTRFq+0CwOfrYkx98mqoJpusXZ49slUc4khpSvbRDcwka9EGc9Jvu4ExKCP/JViw3k
         aYPjqYljmFKx54JpELH/IwHDs3vo6O+kRfdJoAIyypvKK0/jPHnH00815+apNIKRPB0O
         pihEv9kYqoCQcKjrwJOWG5SN1TDnCTA2+BdIQtxLCMPCQx/Dd+xujDwlrXyoGeJ53bZz
         D4e3+Yj0SvF3LIQs1Gz6YfnMqbEYCGh+OgAK6ZgZj0r1VMtsJA9UGhWF1l8zplOG+GYQ
         UaoQ==
X-Forwarded-Encrypted: i=1; AHgh+Ro5B1SkxsTLxIIqQIrzmMVqDfZ2E8JHY2orLsg+MWaUHebScmDxq+1SQkp0OsF1HBf1e2sh984=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeuqxyF0dVds0v39l0+Ubh+lgg7+Q73UcRpjSO7F7VVIFwXaP+
	7Rr/n/Va6W0kld3oik8n8Q/je3zXFCbDvniHqDls1WKzNYVerhDrKUxqG50QCPJLN8gEeu7YrEa
	7ujnNoYpqD+0m
X-Received: from qvbld29.prod.google.com ([2002:a05:6214:419d:b0:8db:f5ff:e5e9])
 (user=xuehaohu job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6214:3f82:b0:8cc:6aa6:7035 with SMTP id 6a1803df08f44-8de4c97e03amr175835356d6.19.1782080492419;
 Sun, 21 Jun 2026 15:21:32 -0700 (PDT)
Date: Sun, 21 Jun 2026 22:21:30 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.rc0.738.g0c8ab3ebcc-goog
Message-ID: <20260621222130.1667453-1-xuehaohu@google.com>
Subject: [PATCH] dma-buf: Split sgl by largest page-aligned chunk
From: David Hu <xuehaohu@google.com>
To: Sumit Semwal <sumit.semwal@linaro.org>, 
	"=?UTF-8?q?Christian=20K=C3=B6nig?=" <christian.koenig@amd.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Nicolin Chen <nicolinc@nvidia.com>, Leon Romanovsky <leon@kernel.org>, 
	Kevin Tian <kevin.tian@intel.com>, Ankit Agrawal <ankita@nvidia.com>, 
	Alex Williamson <alex@shazbot.org>, linux-media@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, 
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev, jmoroni@google.com, 
	praan@google.com, kpberry@google.com, David Hu <xuehaohu@google.com>, 
	sashiko-bot <sashiko-bot@kernel.org>, stable@vger.kernel.org
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

Fix this by splitting the scatterlist by the largest possible page
aligned chunk within `UINT_MAX` (`ALIGN_DOWN(UINT_MAX, PAGE_SIZE)`).
This ensures all scatterlist DMA addresses and lengths remain page
aligned and satisfy hardware constraints.

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
 drivers/dma-buf/dma-buf-mapping.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/dma-buf/dma-buf-mapping.c b/drivers/dma-buf/dma-buf-mapping.c
index 794acff2546a..f2bde38fdb1f 100644
--- a/drivers/dma-buf/dma-buf-mapping.c
+++ b/drivers/dma-buf/dma-buf-mapping.c
@@ -5,6 +5,9 @@
  */
 #include <linux/dma-buf-mapping.h>
 #include <linux/dma-resv.h>
+#include <linux/align.h>
+
+#define MAX_ENT_SZ ALIGN_DOWN(UINT_MAX, PAGE_SIZE)
 
 static struct scatterlist *fill_sg_entry(struct scatterlist *sgl, size_t length,
 					 dma_addr_t addr)
@@ -12,9 +15,9 @@ static struct scatterlist *fill_sg_entry(struct scatterlist *sgl, size_t length,
 	unsigned int len, nents;
 	int i;
 
-	nents = DIV_ROUND_UP(length, UINT_MAX);
+	nents = DIV_ROUND_UP(length, MAX_ENT_SZ);
 	for (i = 0; i < nents; i++) {
-		len = min_t(size_t, length, UINT_MAX);
+		len = min_t(size_t, length, MAX_ENT_SZ);
 		length -= len;
 		/*
 		 * DMABUF abuses scatterlist to create a scatterlist
@@ -24,7 +27,7 @@ static struct scatterlist *fill_sg_entry(struct scatterlist *sgl, size_t length,
 		 * does not require the CPU list for mapping or unmapping.
 		 */
 		sg_set_page(sgl, NULL, 0, 0);
-		sg_dma_address(sgl) = addr + (dma_addr_t)i * UINT_MAX;
+		sg_dma_address(sgl) = addr + (dma_addr_t)i * MAX_ENT_SZ;
 		sg_dma_len(sgl) = len;
 		sgl = sg_next(sgl);
 	}
@@ -41,14 +44,14 @@ static unsigned int calc_sg_nents(struct dma_iova_state *state,
 
 	if (!state || !dma_use_iova(state)) {
 		for (i = 0; i < nr_ranges; i++)
-			nents += DIV_ROUND_UP(phys_vec[i].len, UINT_MAX);
+			nents += DIV_ROUND_UP(phys_vec[i].len, MAX_ENT_SZ);
 	} else {
 		/*
 		 * In IOVA case, there is only one SG entry which spans
 		 * for whole IOVA address space, but we need to make sure
 		 * that it fits sg->length, maybe we need more.
 		 */
-		nents = DIV_ROUND_UP(size, UINT_MAX);
+		nents = DIV_ROUND_UP(size, MAX_ENT_SZ);
 	}
 
 	return nents;
-- 
2.55.0.rc0.738.g0c8ab3ebcc-goog

