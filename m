Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C32F34752F
	for <stable@vger.kernel.org>; Tue,  6 Oct 2026 07:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791272793; cv=none; b=jnbWjoh31YKM9HymSAEAbMvD/ZgepzIPd5XSie91maZyKw+0xmXC8zGky5ras3/Tk3pxx+eqpQsa0sSUKWZM+EkPVtUqQwPtuWnCGpWylBYv1u70syMHzX3Cj98ZJIe1uY8hTuJOC3leN2dV4QvzqV7wopUWqD40te/0o0y8tig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791272793; c=relaxed/simple;
	bh=XXuqSE60oLigF6PxjHQJDNrirR+m21t7Mra/ZDSRmqo=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=K0c10ZQtjzeFIExKrtOEbSr+yAJCyDWBA81rQTy1jTd5gZbdb/HBkuoTS0Vh5srPoxGDLlmcQEQJ3nTaxskYWRSSrZmYidwo0vWBgDMDVtik6jXv9hF839hViePiZo5Sdht7MIqfu7W0/+zfzr70UXCAZ2XNvu8tTQtVz9qQqsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ftj4nbqC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ftj4nbqC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5070D1F000FF;
	Tue,  6 Oct 2026 07:46:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1791272791;
	bh=aLcNm0iow8AgZz3gMSKBRM5ESbMwpdgS/7SQjBoJCNs=;
	h=Subject:To:Cc:From:Date;
	b=ftj4nbqCKAX4YdiQARkFCePEqzJF1nJ7SAcXF7Gk4HJS7vd3iodYEPiGFGNdrALd/
	 JjTo0bBrQ2Zn+U15ffzwyu0AEJZJ0B8WhrfDiJvfFgaus17s9k2h/spdvs5xMJR/Ir
	 XaNJ+4KfoeHhuRJLGgLPSDCR37M27lWiWjFbfCCU=
Subject: FAILED: patch "[PATCH] iio: buffer-dmaengine: fix sg entry iteration when building" failed to apply to 6.12-stable tree
To: michael.hennerich@analog.com,jonathan.cameron@oss.qualcomm.com,nuno.sa@analog.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 06 Oct 2026 09:46:21 +0200
Message-ID: <2026100621-baritone-yapping-1e8d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 0d0ffbcc92e30a8d656ad76a6e278fa3400fed85
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026100621-baritone-yapping-1e8d@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 0d0ffbcc92e30a8d656ad76a6e278fa3400fed85 Mon Sep 17 00:00:00 2001
From: Michael Hennerich <michael.hennerich@analog.com>
Date: Fri, 28 Aug 2026 11:46:55 +0100
Subject: [PATCH] iio: buffer-dmaengine: fix sg entry iteration when building
 dma_vecs
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

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

diff --git a/drivers/iio/buffer/industrialio-buffer-dmaengine.c b/drivers/iio/buffer/industrialio-buffer-dmaengine.c
index ecc02a427b92..376486be3f55 100644
--- a/drivers/iio/buffer/industrialio-buffer-dmaengine.c
+++ b/drivers/iio/buffer/industrialio-buffer-dmaengine.c
@@ -104,10 +104,13 @@ static int iio_dmaengine_buffer_submit_block(struct iio_dma_buffer_queue *queue,
 	if (block->sg_table) {
 		unsigned long flags;
 
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
@@ -115,7 +118,8 @@ static int iio_dmaengine_buffer_submit_block(struct iio_dma_buffer_queue *queue,
 
 		len_total = block->bytes_used;
 
-		for (i = 0; i < nents; i++) {
+		sgl = block->sg_table->sgl;
+		for (i = 0; i < nents && len_total; i++) {
 			vecs[i].addr = sg_dma_address(sgl);
 			vecs[i].len = min(sg_dma_len(sgl), len_total);
 			len_total -= vecs[i].len;
@@ -123,6 +127,8 @@ static int iio_dmaengine_buffer_submit_block(struct iio_dma_buffer_queue *queue,
 			sgl = sg_next(sgl);
 		}
 
+		nents = i;
+
 		if (block->cyclic)
 			flags = DMA_PREP_REPEAT;
 		else

