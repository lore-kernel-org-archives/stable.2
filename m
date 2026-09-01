Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEEE93BFE4A
	for <stable@vger.kernel.org>; Tue,  1 Sep 2026 19:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788291833; cv=none; b=YrPC/X8B47+wHVTglQWFaZhK1+WLI4mr4x/ADdfsYRutJSnu4hJLXExUCeoYc4XfZvt+I4vbxWKYWRVNJXZP8UWzaMVc/g0m81EX3PnD+3EZX5VcNautfHsf9DDGUeKa7aFF4OW9tteA9Jv50eIMk88jFe47pFC9roEQAIPSYzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788291833; c=relaxed/simple;
	bh=39Ol050RXocpnd8DRWH5El9Kb8aK19SNdbmUiXhtTUk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IaUrFHWjMMtqVTB+khJnWoaon1FfQhR3s4ldVODRIKDv7ERMz5p8J9+iApYDdAUWk6dpCRfn8862XyDR6ka2PqnbzbDcsgAFLVJ3VGL08xofNtAKY5fffnh5yA4fBy//CuqTb87RYHy87osGxFFG/tXidPxgRU6Bzc1I6/uQhqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i+1O8U5B; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i+1O8U5B"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C06EC1F000E9;
	Tue,  1 Sep 2026 19:43:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788291831;
	bh=DZd1Qsl1exZnhHZInb7Rzcbj5yXysf+UzzqT0bQum2Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=i+1O8U5BKWlDhcv+bmGJd5DwHPNIc5zJCYKWw1cfSGcsVx6jNbMqQ5sCkg5Pgbfkr
	 16xN4stCctl8as/8cJ8ke2FQxycQG3hbgb+pzRk1v75Y4WSIkCJ9367CBiY7zzI1d+
	 EeHE9xHcbMZ9EMpGbucINraXOg57z7f6/lcUExJLom/3e3fTj5pASAxVngXvSHKWCX
	 iTQL05o+ypJ3gpSkkBt6xMi3FyBb1GfyGo6u9AZGG7nYrnj4ss9pRINfkBC5AGA77Z
	 FkDfxIwnoaInAInW3FacWS1ZyFOq5hxX8YvBQppRYBxRoteU0/nvZlyNW3lGLUx+d9
	 TnBdZ0QBgPQgQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/2] crypto: iaa - fall back to software for multi-entry scatterlists
Date: Tue,  1 Sep 2026 15:43:48 -0400
Message-ID: <20260901194349.1447018-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026083134-tightwad-trilogy-bdee@gregkh>
References: <2026083134-tightwad-trilogy-bdee@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Giovanni Cabiddu <giovanni.cabiddu@intel.com>

[ Upstream commit c7fdfd2bee1cf1448e5244da1a734e680f634b02 ]

IAA cannot process source or destination scatterlists with more than one
entry directly. Instead of failing these requests, route them through a
separate deflate acomp transform and keep the request alive in software.

The IAA driver has never handled multi-entry scatterlists, but the
limitation was latent until commit e2c3b6b21c77 ("mm: zswap: use SG list
decompression APIs from zsmalloc") made zswap pass the raw zsmalloc SG
list directly to crypto drivers, so objects spanning multiple pages now
reach IAA as multi-entry sources and would otherwise fail decompression.

Fallback to the generic DEFLATE implementation for scatterlists with
more than one entry. After the multi-entry cases fall back early,
simplify the DMA mapping path to a single scatterlist entry and fall
back on mapping failure as well.

Add counters to track the number of requests processed by the software
implementation on the compression direction.

Fixes: 2ec6761df889 ("crypto: iaa - Add support for deflate-iaa compression algorithm")
Fixes: e2c3b6b21c77 ("mm: zswap: use SG list decompression APIs from zsmalloc")
Cc: stable@vger.kernel.org
Signed-off-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Stable-dep-of: 94a259304771 ("crypto: iaa - unmap dst before software fallback on decompress")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/crypto/intel/iaa/iaa_crypto_main.c  | 111 +++++++++++---------
 drivers/crypto/intel/iaa/iaa_crypto_stats.c |   9 ++
 drivers/crypto/intel/iaa/iaa_crypto_stats.h |   2 +
 3 files changed, 71 insertions(+), 51 deletions(-)

diff --git a/drivers/crypto/intel/iaa/iaa_crypto_main.c b/drivers/crypto/intel/iaa/iaa_crypto_main.c
index 78218f3a3cd06..ca0790ed4a122 100644
--- a/drivers/crypto/intel/iaa/iaa_crypto_main.c
+++ b/drivers/crypto/intel/iaa/iaa_crypto_main.c
@@ -2,6 +2,7 @@
 /* Copyright(c) 2021 Intel Corporation. All rights rsvd. */
 
 #include <linux/init.h>
+#include <linux/crypto.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/pci.h>
@@ -1001,6 +1002,19 @@ static int deflate_generic_decompress(struct acomp_req *req)
 	return ret;
 }
 
+static int deflate_generic_compress(struct acomp_req *req)
+{
+	ACOMP_FBREQ_ON_STACK(fbreq, req);
+	int ret;
+
+	ret = crypto_acomp_compress(fbreq);
+	req->dlen = fbreq->dlen;
+
+	update_total_sw_comp_calls();
+
+	return ret;
+}
+
 static int iaa_remap_for_verify(struct device *dev, struct iaa_wq *iaa_wq,
 				struct acomp_req *req,
 				dma_addr_t *src_addr, dma_addr_t *dst_addr);
@@ -1477,7 +1491,7 @@ static int iaa_comp_acompress(struct acomp_req *req)
 	struct iaa_compression_ctx *compression_ctx;
 	struct crypto_tfm *tfm = req->base.tfm;
 	dma_addr_t src_addr, dst_addr;
-	int nr_sgs, cpu, ret = 0;
+	int cpu, ret = 0;
 	struct iaa_wq *iaa_wq;
 	struct idxd_wq *wq;
 	struct device *dev;
@@ -1489,11 +1503,15 @@ static int iaa_comp_acompress(struct acomp_req *req)
 		return -ENODEV;
 	}
 
-	if (!req->src || !req->slen) {
-		pr_debug("invalid src, not compressing\n");
+	if (!req->src || !req->slen || !req->dst) {
+		pr_debug("invalid req, not compressing\n");
 		return -EINVAL;
 	}
 
+	/* Fall back to software if src or dst has multiple sg entries */
+	if (sg_nents(req->src) > 1 || sg_nents(req->dst) > 1)
+		return deflate_generic_compress(req);
+
 	cpu = get_cpu();
 	wq = wq_table_next_wq(cpu);
 	put_cpu();
@@ -1512,30 +1530,25 @@ static int iaa_comp_acompress(struct acomp_req *req)
 
 	dev = &wq->idxd->pdev->dev;
 
-	nr_sgs = dma_map_sg(dev, req->src, sg_nents(req->src), DMA_TO_DEVICE);
-	if (nr_sgs <= 0 || nr_sgs > 1) {
-		dev_dbg(dev, "couldn't map src sg for iaa device %d,"
-			" wq %d: ret=%d\n", iaa_wq->iaa_device->idxd->id,
-			iaa_wq->wq->id, ret);
-		ret = -EIO;
-		goto out;
+	if (!dma_map_sg(dev, req->src, 1, DMA_TO_DEVICE)) {
+		dev_dbg(dev, "couldn't map src sg for iaa device %d, wq %d\n",
+			iaa_wq->iaa_device->idxd->id, iaa_wq->wq->id);
+		iaa_wq_put(wq);
+		return deflate_generic_compress(req);
 	}
 	src_addr = sg_dma_address(req->src);
-	dev_dbg(dev, "dma_map_sg, src_addr %llx, nr_sgs %d, req->src %p,"
-		" req->slen %d, sg_dma_len(sg) %d\n", src_addr, nr_sgs,
+	dev_dbg(dev, "map src %llx req->src %p slen %d sg_len %d\n", src_addr,
 		req->src, req->slen, sg_dma_len(req->src));
 
-	nr_sgs = dma_map_sg(dev, req->dst, sg_nents(req->dst), DMA_FROM_DEVICE);
-	if (nr_sgs <= 0 || nr_sgs > 1) {
-		dev_dbg(dev, "couldn't map dst sg for iaa device %d,"
-			" wq %d: ret=%d\n", iaa_wq->iaa_device->idxd->id,
-			iaa_wq->wq->id, ret);
-		ret = -EIO;
-		goto err_map_dst;
+	if (!dma_map_sg(dev, req->dst, 1, DMA_FROM_DEVICE)) {
+		dev_dbg(dev, "couldn't map dst sg for iaa device %d, wq %d\n",
+			iaa_wq->iaa_device->idxd->id, iaa_wq->wq->id);
+		dma_unmap_sg(dev, req->src, 1, DMA_TO_DEVICE);
+		iaa_wq_put(wq);
+		return deflate_generic_compress(req);
 	}
 	dst_addr = sg_dma_address(req->dst);
-	dev_dbg(dev, "dma_map_sg, dst_addr %llx, nr_sgs %d, req->dst %p,"
-		" req->dlen %d, sg_dma_len(sg) %d\n", dst_addr, nr_sgs,
+	dev_dbg(dev, "map dst %llx req->dst %p dlen %d sg_len %d\n", dst_addr,
 		req->dst, req->dlen, sg_dma_len(req->dst));
 
 	ret = iaa_compress(tfm, req, wq, src_addr, req->slen, dst_addr,
@@ -1555,8 +1568,8 @@ static int iaa_comp_acompress(struct acomp_req *req)
 		if (ret)
 			dev_dbg(dev, "asynchronous compress verification failed ret=%d\n", ret);
 
-		dma_unmap_sg(dev, req->dst, sg_nents(req->dst), DMA_TO_DEVICE);
-		dma_unmap_sg(dev, req->src, sg_nents(req->src), DMA_FROM_DEVICE);
+		dma_unmap_sg(dev, req->dst, 1, DMA_TO_DEVICE);
+		dma_unmap_sg(dev, req->src, 1, DMA_FROM_DEVICE);
 
 		goto out;
 	}
@@ -1564,9 +1577,8 @@ static int iaa_comp_acompress(struct acomp_req *req)
 	if (ret)
 		dev_dbg(dev, "asynchronous compress failed ret=%d\n", ret);
 
-	dma_unmap_sg(dev, req->dst, sg_nents(req->dst), DMA_FROM_DEVICE);
-err_map_dst:
-	dma_unmap_sg(dev, req->src, sg_nents(req->src), DMA_TO_DEVICE);
+	dma_unmap_sg(dev, req->dst, 1, DMA_FROM_DEVICE);
+	dma_unmap_sg(dev, req->src, 1, DMA_TO_DEVICE);
 out:
 	iaa_wq_put(wq);
 
@@ -1577,7 +1589,7 @@ static int iaa_comp_adecompress(struct acomp_req *req)
 {
 	struct crypto_tfm *tfm = req->base.tfm;
 	dma_addr_t src_addr, dst_addr;
-	int nr_sgs, cpu, ret = 0;
+	int cpu, ret = 0;
 	struct iaa_wq *iaa_wq;
 	struct device *dev;
 	struct idxd_wq *wq;
@@ -1587,11 +1599,15 @@ static int iaa_comp_adecompress(struct acomp_req *req)
 		return -ENODEV;
 	}
 
-	if (!req->src || !req->slen) {
-		pr_debug("invalid src, not decompressing\n");
+	if (!req->src || !req->slen || !req->dst) {
+		pr_debug("invalid req, not decompressing\n");
 		return -EINVAL;
 	}
 
+	/* Fall back to software if src or dst has multiple sg entries */
+	if (sg_nents(req->src) > 1 || sg_nents(req->dst) > 1)
+		return deflate_generic_decompress(req);
+
 	cpu = get_cpu();
 	wq = wq_table_next_wq(cpu);
 	put_cpu();
@@ -1610,30 +1626,25 @@ static int iaa_comp_adecompress(struct acomp_req *req)
 
 	dev = &wq->idxd->pdev->dev;
 
-	nr_sgs = dma_map_sg(dev, req->src, sg_nents(req->src), DMA_TO_DEVICE);
-	if (nr_sgs <= 0 || nr_sgs > 1) {
-		dev_dbg(dev, "couldn't map src sg for iaa device %d,"
-			" wq %d: ret=%d\n", iaa_wq->iaa_device->idxd->id,
-			iaa_wq->wq->id, ret);
-		ret = -EIO;
-		goto out;
+	if (!dma_map_sg(dev, req->src, 1, DMA_TO_DEVICE)) {
+		dev_dbg(dev, "couldn't map src sg for iaa device %d, wq %d\n",
+			iaa_wq->iaa_device->idxd->id, iaa_wq->wq->id);
+		iaa_wq_put(wq);
+		return deflate_generic_decompress(req);
 	}
 	src_addr = sg_dma_address(req->src);
-	dev_dbg(dev, "dma_map_sg, src_addr %llx, nr_sgs %d, req->src %p,"
-		" req->slen %d, sg_dma_len(sg) %d\n", src_addr, nr_sgs,
+	dev_dbg(dev, "map src %llx req->src %p slen %d sg_len %d\n", src_addr,
 		req->src, req->slen, sg_dma_len(req->src));
 
-	nr_sgs = dma_map_sg(dev, req->dst, sg_nents(req->dst), DMA_FROM_DEVICE);
-	if (nr_sgs <= 0 || nr_sgs > 1) {
-		dev_dbg(dev, "couldn't map dst sg for iaa device %d,"
-			" wq %d: ret=%d\n", iaa_wq->iaa_device->idxd->id,
-			iaa_wq->wq->id, ret);
-		ret = -EIO;
-		goto err_map_dst;
+	if (!dma_map_sg(dev, req->dst, 1, DMA_FROM_DEVICE)) {
+		dev_dbg(dev, "couldn't map dst sg for iaa device %d, wq %d\n",
+			iaa_wq->iaa_device->idxd->id, iaa_wq->wq->id);
+		dma_unmap_sg(dev, req->src, 1, DMA_TO_DEVICE);
+		iaa_wq_put(wq);
+		return deflate_generic_decompress(req);
 	}
 	dst_addr = sg_dma_address(req->dst);
-	dev_dbg(dev, "dma_map_sg, dst_addr %llx, nr_sgs %d, req->dst %p,"
-		" req->dlen %d, sg_dma_len(sg) %d\n", dst_addr, nr_sgs,
+	dev_dbg(dev, "map dst %llx req->dst %p dlen %d sg_len %d\n", dst_addr,
 		req->dst, req->dlen, sg_dma_len(req->dst));
 
 	ret = iaa_decompress(tfm, req, wq, src_addr, req->slen,
@@ -1644,10 +1655,8 @@ static int iaa_comp_adecompress(struct acomp_req *req)
 	if (ret != 0)
 		dev_dbg(dev, "asynchronous decompress failed ret=%d\n", ret);
 
-	dma_unmap_sg(dev, req->dst, sg_nents(req->dst), DMA_FROM_DEVICE);
-err_map_dst:
-	dma_unmap_sg(dev, req->src, sg_nents(req->src), DMA_TO_DEVICE);
-out:
+	dma_unmap_sg(dev, req->dst, 1, DMA_FROM_DEVICE);
+	dma_unmap_sg(dev, req->src, 1, DMA_TO_DEVICE);
 	iaa_wq_put(wq);
 
 	return ret;
diff --git a/drivers/crypto/intel/iaa/iaa_crypto_stats.c b/drivers/crypto/intel/iaa/iaa_crypto_stats.c
index f5cc3d29ca19e..2f2ed88c88120 100644
--- a/drivers/crypto/intel/iaa/iaa_crypto_stats.c
+++ b/drivers/crypto/intel/iaa/iaa_crypto_stats.c
@@ -19,6 +19,7 @@
 
 static atomic64_t total_comp_calls;
 static atomic64_t total_decomp_calls;
+static atomic64_t total_sw_comp_calls;
 static atomic64_t total_sw_decomp_calls;
 static atomic64_t total_comp_bytes_out;
 static atomic64_t total_decomp_bytes_in;
@@ -43,6 +44,11 @@ void update_total_decomp_calls(void)
 	atomic64_inc(&total_decomp_calls);
 }
 
+void update_total_sw_comp_calls(void)
+{
+	atomic64_inc(&total_sw_comp_calls);
+}
+
 void update_total_sw_decomp_calls(void)
 {
 	atomic64_inc(&total_sw_decomp_calls);
@@ -104,6 +110,7 @@ static void reset_iaa_crypto_stats(void)
 {
 	atomic64_set(&total_comp_calls, 0);
 	atomic64_set(&total_decomp_calls, 0);
+	atomic64_set(&total_sw_comp_calls, 0);
 	atomic64_set(&total_sw_decomp_calls, 0);
 	atomic64_set(&total_comp_bytes_out, 0);
 	atomic64_set(&total_decomp_bytes_in, 0);
@@ -174,6 +181,8 @@ static int global_stats_show(struct seq_file *m, void *v)
 		   atomic64_read(&total_comp_calls));
 	seq_printf(m, "  total_decomp_calls: %llu\n",
 		   atomic64_read(&total_decomp_calls));
+	seq_printf(m, "  total_sw_comp_calls: %llu\n",
+		   atomic64_read(&total_sw_comp_calls));
 	seq_printf(m, "  total_sw_decomp_calls: %llu\n",
 		   atomic64_read(&total_sw_decomp_calls));
 	seq_printf(m, "  total_comp_bytes_out: %llu\n",
diff --git a/drivers/crypto/intel/iaa/iaa_crypto_stats.h b/drivers/crypto/intel/iaa/iaa_crypto_stats.h
index 3787a5f507eb2..6e0c6f9939bfa 100644
--- a/drivers/crypto/intel/iaa/iaa_crypto_stats.h
+++ b/drivers/crypto/intel/iaa/iaa_crypto_stats.h
@@ -11,6 +11,7 @@ void	iaa_crypto_debugfs_cleanup(void);
 void	update_total_comp_calls(void);
 void	update_total_comp_bytes_out(int n);
 void	update_total_decomp_calls(void);
+void	update_total_sw_comp_calls(void);
 void	update_total_sw_decomp_calls(void);
 void	update_total_decomp_bytes_in(int n);
 void	update_completion_einval_errs(void);
@@ -29,6 +30,7 @@ static inline void	iaa_crypto_debugfs_cleanup(void) {}
 static inline void	update_total_comp_calls(void) {}
 static inline void	update_total_comp_bytes_out(int n) {}
 static inline void	update_total_decomp_calls(void) {}
+static inline void	update_total_sw_comp_calls(void) {}
 static inline void	update_total_sw_decomp_calls(void) {}
 static inline void	update_total_decomp_bytes_in(int n) {}
 static inline void	update_completion_einval_errs(void) {}
-- 
2.53.0

