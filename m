Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5988D43990A
	for <stable@vger.kernel.org>; Wed,  7 Oct 2026 08:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791362268; cv=none; b=CcD9yczYuYHp5Hm1QQAMKAGKJgh38fbV4BHQrLK5OLh1UZTxfZa3bkC6n4B0uMicK1fNBIp6gJKba21FbjhH8WsMqMQzqRvv4QSvD7Fd+V1tkW0E25Vd7VeeRFxcKXhSI67EnffBVLshhbxGFRWqVSfrNceoG9505HHKnB606bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791362268; c=relaxed/simple;
	bh=TSWphP1s26zcsAKPf1XEQBXdnsBsI8uITyNsuPo927U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QESBrwzIGQ+s74ce88d5xZSJMnWIL+8oxD4PdNyH3/zlLm9tQWynWJfosFfJraj5HQ+8VoKLqZOyxvSy/c+mtFL3EFziTOMlhJ+Gb8Jn/SDzmXBD0qIILCSLWGJR5Voe3dISvAt/TfWQuzxBHBHoGlP/It6tXvlKwBDZO/XnY2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g0UR0YUt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g0UR0YUt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3D581F0089B;
	Wed,  7 Oct 2026 08:37:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791362266;
	bh=GAITyfneXxr6yQKdLfAEhoxz87X58VmyT8LSqqTP7tI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=g0UR0YUtnIbyGXAeHb5NZh/J2XuXyDmaQ7b2/bKcbcKbJZwMUEEVJkIwbWs6OWu26
	 m9m7xqfljkcjyOquQ1JSRy9YIL+FMf6Q+1Xc/zgMiQ0sjM/FTsA/5MDymyzRZKJxyv
	 uHhEWONJXNhMXW3TwA/GAlvGQ8G2W+ER0PAfEWTt2RcJf92WUAD5euWoLErt+Zgw1h
	 l7ARgdPtDLftTaNv5c6Vc40+VeMt5ZeR4XU2qLTXO0AZFDzwhQpBmZ51zL85dmwDRY
	 ka5AqywFEe2SdoeaGHflkaCMOPxnLvbWsVc2NLY4KwPUdQWDYZuCK2wagWEJ2lEoWO
	 0RksuH8s8+EAg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Michael Hennerich <michael.hennerich@analog.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] iio: buffer-dmaengine: fix sg entry iteration when building dma_vecs
Date: Wed,  7 Oct 2026 04:37:42 -0400
Message-ID: <20261007083721.1953324-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026100621-tanning-oxidizing-ed84@gregkh>
References: <2026100621-tanning-oxidizing-ed84@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Michael Hennerich <michael.hennerich@analog.com>

[ Upstream commit 0d0ffbcc92e30a8d656ad76a6e278fa3400fed85 ]

iio_dmaengine_buffer_submit_block() counts scatterlist entries with
sg_nents_for_len(), which walks the CPU-side lengths (sg->length), but
then consumes the DMA-side fields (sg_dma_address()/sg_dma_len()).
After dma_map_sgtable() the two views may differ: an IOMMU can coalesce
the mapping so that only the first sgt->nents entries carry valid DMA
addresses, with nents < orig_nents.

On x86 with an IOMMU enabled, a DMABUF block backed by two 1 MiB
system-heap chunks maps to a single 2 MiB IOVA range. The CPU-side
count is 2, so the loop reads one entry past the mapped set and emits a
garbage vec ({addr = ~0, len = 0}). The DMA engine driver rejects the
vec array (prep returns NULL), the fence is signalled with -ENOMEM,
which a userspace poller cannot observe, and the block is left in
ACTIVE state so every further enqueue of it fails with -EBUSY. The
visible symptom is a stream of zero-filled blocks followed by a wedged
buffer.

Platforms without an IOMMU never hit this because nents == orig_nents.

Size the vec array with sgt->nents, i.e. the DMA-mapped view, and stop
the fill loop once bytes_used is covered - which is allowed to be
smaller than the block size - passing the number of vecs actually
filled to dmaengine_prep_peripheral_dma_vec().

One vec per mapped entry is enough since coalescing can only ever
reduce the number of entries. A single mapped entry longer than the
device's maximum segment size would need more than one, but the DMA API
already assumes no single segment exceeds it [1], and splitting a vec
down to the hardware descriptor size is the DMA engine driver's job -
which both current .device_prep_peripheral_dma_vec() implementations
do.

[1]: commit ab2cbeb0ed30 ("iommu/dma: Handle SG length overflow better")

Assisted-by: Claude:claude-fable-5
Fixes: 7a86d469983a ("iio: buffer-dmaengine: Support new DMABUF based userspace API")
Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
Signed-off-by: Nuno Sá <nuno.sa@analog.com>
Cc: stable@vger.kernel.org
Signed-off-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
[ sashal: Adjusted context for DMA preparation using DMA_PREP_INTERRUPT directly instead of cyclic transfer flags. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../iio/buffer/industrialio-buffer-dmaengine.c   | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/buffer/industrialio-buffer-dmaengine.c b/drivers/iio/buffer/industrialio-buffer-dmaengine.c
index 27dd563343451..9af6171a96fb7 100644
--- a/drivers/iio/buffer/industrialio-buffer-dmaengine.c
+++ b/drivers/iio/buffer/industrialio-buffer-dmaengine.c
@@ -82,10 +82,13 @@ static int iio_dmaengine_buffer_submit_block(struct iio_dma_buffer_queue *queue,
 		dma_dir = DMA_MEM_TO_DEV;
 
 	if (block->sg_table) {
-		sgl = block->sg_table->sgl;
-		nents = sg_nents_for_len(sgl, block->bytes_used);
-		if (nents < 0)
-			return nents;
+		/*
+		 * Only the first sgt->nents entries carry a valid
+		 * sg_dma_address()/sg_dma_len() pair as mapping the table may
+		 * have coalesced entries, in which case nents is smaller than
+		 * orig_nents.
+		 */
+		nents = block->sg_table->nents;
 
 		vecs = kmalloc_array(nents, sizeof(*vecs), GFP_ATOMIC);
 		if (!vecs)
@@ -93,7 +96,8 @@ static int iio_dmaengine_buffer_submit_block(struct iio_dma_buffer_queue *queue,
 
 		len_total = block->bytes_used;
 
-		for (i = 0; i < nents; i++) {
+		sgl = block->sg_table->sgl;
+		for (i = 0; i < nents && len_total; i++) {
 			vecs[i].addr = sg_dma_address(sgl);
 			vecs[i].len = min(sg_dma_len(sgl), len_total);
 			len_total -= vecs[i].len;
@@ -101,6 +105,8 @@ static int iio_dmaengine_buffer_submit_block(struct iio_dma_buffer_queue *queue,
 			sgl = sg_next(sgl);
 		}
 
+		nents = i;
+
 		desc = dmaengine_prep_peripheral_dma_vec(dmaengine_buffer->chan,
 							 vecs, nents, dma_dir,
 							 DMA_PREP_INTERRUPT);
-- 
2.53.0

