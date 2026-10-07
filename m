Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CD6F420E7C
	for <stable@vger.kernel.org>; Wed,  7 Oct 2026 07:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791359166; cv=none; b=FX0LbCCTa6FVjbYMOxO3Ivd/6GB79ll2XxDP+3SLjj2cqG1sf6mge5sJszWY1DzLy0I1ltccsqDsznGf54VytBvBsY7TlBMWGKWKgRe9JVI9AfnixAaidtAVHxO3OrqEAzhASo3za2SCFEbdw1NXPIXEm3qmPn6UltiaU7+VLrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791359166; c=relaxed/simple;
	bh=mMdVVbhmrkiSObb/OkzxISg++94AWJOUWOnKPpoBXWE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OGGglxfPsaufh9ntOM8KKg+JuGnWVHeLBUBDirsSIyLfVO9/ytOc/Lhbe13w7Jz+pVsb+S4QSjzzoL0Hc2fm/ZcorMVgLSrGfZZxfJCn61he88UAnSGKk7h+9jyLxNMuTxGvU82K+vkTTieqR5hfn2MRTeP42ilNJnQ6rfbtp7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wa6ZDdxs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wa6ZDdxs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95E091F0089B;
	Wed,  7 Oct 2026 07:46:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791359161;
	bh=UtF6a6opSfvxNGw16lulS/ef9v1OHQDskhv+JtDbX00=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Wa6ZDdxs/xg7GQZezxjCENmOZQkzVPnjFtI1siAylDlMTtmSZDCSwQZK2A5XTfNiF
	 ln0f6yXFfs0PXF/xR86J+p4zPqrOhFWZgnivWJ8BVKmL8lMthWLrNVi+Zu4ThO3HAW
	 Dzr+KTHoNodkWm13qO2UhUzgkFuZbkgVIfdkF4QVzRglhTRKxlI/1nTld408bPICjD
	 2uUF62kiozbijDbXoW/cny5jjX33EcDKuYmCPeB6/UCt3H4t6rYYLsYgvVA2mP2HxJ
	 YrZvIeIeKv9g67GOURekHN5UiYq/GV2gYqeTmzouvP2qFiVih4euxQVZ2dnFFqvH1f
	 z1DERbIYA3RfQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Michael Hennerich <michael.hennerich@analog.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.2.y] iio: buffer-dmaengine: fix sg entry iteration when building dma_vecs
Date: Wed,  7 Oct 2026 03:45:58 -0400
Message-ID: <20261007073731.1722749-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026100620-obtrusive-generous-b3aa@gregkh>
References: <2026100620-obtrusive-generous-b3aa@gregkh>
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
[ sashal: Adjusted context for the missing IIO DMAengine cyclic-transfer implementation. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../iio/buffer/industrialio-buffer-dmaengine.c   | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/buffer/industrialio-buffer-dmaengine.c b/drivers/iio/buffer/industrialio-buffer-dmaengine.c
index 98acce9098547..6bd0ce1836350 100644
--- a/drivers/iio/buffer/industrialio-buffer-dmaengine.c
+++ b/drivers/iio/buffer/industrialio-buffer-dmaengine.c
@@ -80,10 +80,13 @@ static int iio_dmaengine_buffer_submit_block(struct iio_dma_buffer_queue *queue,
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
@@ -91,7 +94,8 @@ static int iio_dmaengine_buffer_submit_block(struct iio_dma_buffer_queue *queue,
 
 		len_total = block->bytes_used;
 
-		for (i = 0; i < nents; i++) {
+		sgl = block->sg_table->sgl;
+		for (i = 0; i < nents && len_total; i++) {
 			vecs[i].addr = sg_dma_address(sgl);
 			vecs[i].len = min(sg_dma_len(sgl), len_total);
 			len_total -= vecs[i].len;
@@ -99,6 +103,8 @@ static int iio_dmaengine_buffer_submit_block(struct iio_dma_buffer_queue *queue,
 			sgl = sg_next(sgl);
 		}
 
+		nents = i;
+
 		desc = dmaengine_prep_peripheral_dma_vec(dmaengine_buffer->chan,
 							 vecs, nents, dma_dir,
 							 DMA_PREP_INTERRUPT);
-- 
2.53.0

