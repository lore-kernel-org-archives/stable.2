Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B10EB3CB578
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 10:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788950522; cv=none; b=fJ8ydh9UXuNZNLI20jmUo/JxzsSWp96mGdYKUBQfzlCrNFXpqMKFqGFGfL800wG/T6M2GZkk35o+OuybxHVT8ucI8YIsmZ2PS4IXYrAwDpztzP4XiJkuNcqprWOsVE4zMx8vI3nXrgyHPn8ekGsT1Bwa0v5x8/C4ujryG2VxnTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788950522; c=relaxed/simple;
	bh=Go36hZXQxLa+oUcmd10dC+zzrj3xr68QqBjnywOPaLM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jFsrOUJ1JBmAsEw+rV9Tp+nlhYCj6z5mFKeBCD+1whBZaUssgSGuzvi6B56nrbgPyYygKLwhjdM7yWvemfRujo7xbQ9sDJr6s1h6dJbL4gczhpNLxk395kO/LhzXAfJ7h5xOnfe1GRlgSOWY0HEdbuPIYmRx22emIIITd2GjoVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fjgVa1sT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fjgVa1sT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A7191F00A3D;
	Wed,  9 Sep 2026 10:42:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788950520;
	bh=vMBqJ3rymERsmjRjfu7njfLzzu37MScAoDr6rlHOp80=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fjgVa1sTq40PtnCXUcVyvKeAYiAAD7amLrkEIrJFmrN98eVlzCHwV4GP130jmFM7B
	 V8SPgdvzdHZH8f7ZME0kUzmVDxX+ASfOI+wVGbhpoIGq6Gcd/yxLzCdVNUZrn0TPJ+
	 FojKyqaj3aTIrL9V0Ws70esQFf4NYRESOHvDLQ76gj7dks8qnSYiMRMGxUkgME4nvt
	 CsnnuasAXvRi57POAjG3ae9DHuy/qTkl4Vp3L7JQCJZpr3u95GrphQQrgoJAKLtedZ
	 R6CjlIOw5e5/E9Xp6rQHnqt/ristb5/P6wTlCSJMbJiWONEvZaXI9zeE9SKiVnEcnb
	 LM/dK3eBJ/bdA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chuck Lever <chuck.lever@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/5] svcrdma: Update synopsis of svc_rdma_read_multiple_chunks()
Date: Wed,  9 Sep 2026 06:41:54 -0400
Message-ID: <20260909104158.1554268-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090310-onto-impotence-7944@gregkh>
References: <2026090310-onto-impotence-7944@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

[ Upstream commit 740a3c895d94fc72494f2a4abf1ab31b6be482e8 ]

Since the RDMA Read I/O state is now contained in the recv_ctxt,
svc_rdma_read_multiple_chunks() can use that recv_ctxt to derive the
read_info rather than the other way around. This removes another
usage of the ri_readctxt field, enabling its removal in a
subsequent patch.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>

[Stable 6.1 dependency adaptation]
The stable tree still stores Read I/O state in svc_rdma_read_info and
reconstructs rq_arg inside the Read builders. Fold the necessary context
and synopsis conversions into this dependency so that upstream commit
3779b7b9e7d1 ("svcrdma: Validate Read chunk positions before reconstruction")
can be cherry-picked without editing its patch.

Move the existing chunk context and Read counters into svc_rdma_recv_ctxt,
convert the existing Read helpers to rqstp/head arguments, and remove the
now-unused read_info allocation and free helpers. Preserve the stable
transport pointer, synchronous completion wait, and RDMA context cleanup.

Save the decoded inline rq_arg before constructing Reads. Move the existing
single-chunk and whole-message reconstruction into svc_rdma_process_read_list,
after the builders return successfully, leaving the target's validation
sites in the same form as upstream without adding any functions.

Retain the upstream inline-copy page-offset correction and page-array bound,
using rq_page_end for the latter on 6.1. Set the reconstructed whole-message
length from rc_readbytes, which already includes copied inline bytes, so
that those bytes are not counted twice.

Stable-dep-of: 3779b7b9e7d1 ("svcrdma: Validate Read chunk positions before reconstruction")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/sunrpc/svc_rdma.h   |  22 +++
 net/sunrpc/xprtrdma/svc_rdma_rw.c | 318 ++++++++++++------------------
 2 files changed, 144 insertions(+), 196 deletions(-)

diff --git a/include/linux/sunrpc/svc_rdma.h b/include/linux/sunrpc/svc_rdma.h
index fbc4bd423b355..536b95e28a8e2 100644
--- a/include/linux/sunrpc/svc_rdma.h
+++ b/include/linux/sunrpc/svc_rdma.h
@@ -126,6 +126,21 @@ enum {
 
 #define RPCSVC_MAXPAYLOAD_RDMA	RPCSVC_MAXPAYLOAD
 
+/* A chunk context tracks all I/O for moving one Read or Write
+ * chunk. This is a set of rdma_rw's that handle data movement
+ * for all segments of one chunk.
+ */
+struct svc_rdma_chunk_ctxt {
+	struct rpc_rdma_cid	cc_cid;
+	struct ib_cqe		cc_cqe;
+	struct svcxprt_rdma	*cc_rdma;
+	struct list_head	cc_rwctxts;
+	ktime_t			cc_posttime;
+	int			cc_sqecount;
+	enum ib_wc_status	cc_status;
+	struct completion	cc_done;
+};
+
 struct svc_rdma_recv_ctxt {
 	struct llist_node	rc_node;
 	struct list_head	rc_list;
@@ -141,6 +156,13 @@ struct svc_rdma_recv_ctxt {
 	u32			rc_inv_rkey;
 	__be32			rc_msgtype;
 
+	/* State for pulling Read chunks */
+	unsigned int		rc_pageoff;
+	unsigned int		rc_curpage;
+	unsigned int		rc_readbytes;
+	struct xdr_buf		rc_saved_arg;
+	struct svc_rdma_chunk_ctxt	rc_cc;
+
 	struct svc_rdma_pcl	rc_call_pcl;
 
 	struct svc_rdma_pcl	rc_read_pcl;
diff --git a/net/sunrpc/xprtrdma/svc_rdma_rw.c b/net/sunrpc/xprtrdma/svc_rdma_rw.c
index ed581c183f7c8..f32635d0f5216 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_rw.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_rw.c
@@ -142,25 +142,6 @@ static int svc_rdma_rw_ctx_init(struct svcxprt_rdma *rdma,
 	return ret;
 }
 
-/* A chunk context tracks all I/O for moving one Read or Write
- * chunk. This is a set of rdma_rw's that handle data movement
- * for all segments of one chunk.
- *
- * These are small, acquired with a single allocator call, and
- * no more than one is needed per chunk. They are allocated on
- * demand, and not cached.
- */
-struct svc_rdma_chunk_ctxt {
-	struct rpc_rdma_cid	cc_cid;
-	struct ib_cqe		cc_cqe;
-	struct svcxprt_rdma	*cc_rdma;
-	struct list_head	cc_rwctxts;
-	ktime_t			cc_posttime;
-	int			cc_sqecount;
-	enum ib_wc_status	cc_status;
-	struct completion	cc_done;
-};
-
 static void svc_rdma_cc_cid_init(struct svcxprt_rdma *rdma,
 				 struct rpc_rdma_cid *cid)
 {
@@ -287,38 +268,6 @@ static void svc_rdma_write_done(struct ib_cq *cq, struct ib_wc *wc)
 	svc_rdma_write_info_free(info);
 }
 
-/* State for pulling a Read chunk.
- */
-struct svc_rdma_read_info {
-	struct svc_rqst			*ri_rqst;
-	struct svc_rdma_recv_ctxt	*ri_readctxt;
-	unsigned int			ri_pageno;
-	unsigned int			ri_pageoff;
-	unsigned int			ri_totalbytes;
-
-	struct svc_rdma_chunk_ctxt	ri_cc;
-};
-
-static struct svc_rdma_read_info *
-svc_rdma_read_info_alloc(struct svcxprt_rdma *rdma)
-{
-	struct svc_rdma_read_info *info;
-
-	info = kmalloc(sizeof(*info), GFP_KERNEL);
-	if (!info)
-		return info;
-
-	svc_rdma_cc_init(rdma, &info->ri_cc);
-	info->ri_cc.cc_cqe.done = svc_rdma_wc_read_done;
-	return info;
-}
-
-static void svc_rdma_read_info_free(struct svc_rdma_read_info *info)
-{
-	svc_rdma_cc_release(&info->ri_cc, DMA_FROM_DEVICE);
-	kfree(info);
-}
-
 /**
  * svc_rdma_wc_read_done - Handle completion of an RDMA Read ctx
  * @cq: controlling Completion Queue
@@ -330,12 +279,12 @@ static void svc_rdma_wc_read_done(struct ib_cq *cq, struct ib_wc *wc)
 	struct ib_cqe *cqe = wc->wr_cqe;
 	struct svc_rdma_chunk_ctxt *cc =
 			container_of(cqe, struct svc_rdma_chunk_ctxt, cc_cqe);
-	struct svc_rdma_read_info *info;
+	struct svc_rdma_recv_ctxt *ctxt;
 
 	switch (wc->status) {
 	case IB_WC_SUCCESS:
-		info = container_of(cc, struct svc_rdma_read_info, ri_cc);
-		trace_svcrdma_wc_read(wc, &cc->cc_cid, info->ri_totalbytes,
+		ctxt = container_of(cc, struct svc_rdma_recv_ctxt, rc_cc);
+		trace_svcrdma_wc_read(wc, &cc->cc_cid, ctxt->rc_readbytes,
 				      cc->cc_posttime);
 		break;
 	case IB_WC_WR_FLUSH_ERR:
@@ -689,7 +638,8 @@ int svc_rdma_send_reply_chunk(struct svcxprt_rdma *rdma,
 
 /**
  * svc_rdma_build_read_segment - Build RDMA Read WQEs to pull one RDMA segment
- * @info: context for ongoing I/O
+ * @rqstp: RPC transaction context
+ * @head: context for ongoing I/O
  * @segment: co-ordinates of remote memory to be read
  *
  * Returns:
@@ -698,19 +648,18 @@ int svc_rdma_send_reply_chunk(struct svcxprt_rdma *rdma,
  *   %-ENOMEM: allocating a local resources failed
  *   %-EIO: a DMA mapping error occurred
  */
-static int svc_rdma_build_read_segment(struct svc_rdma_read_info *info,
+static int svc_rdma_build_read_segment(struct svc_rqst *rqstp,
+				       struct svc_rdma_recv_ctxt *head,
 				       const struct svc_rdma_segment *segment)
 {
-	struct svc_rdma_recv_ctxt *head = info->ri_readctxt;
-	struct svc_rdma_chunk_ctxt *cc = &info->ri_cc;
-	struct svc_rqst *rqstp = info->ri_rqst;
+	struct svc_rdma_chunk_ctxt *cc = &head->rc_cc;
 	unsigned int sge_no, seg_len, len;
 	struct svc_rdma_rw_ctxt *ctxt;
 	struct scatterlist *sg;
 	int ret;
 
 	len = segment->rs_length;
-	sge_no = PAGE_ALIGN(info->ri_pageoff + len) >> PAGE_SHIFT;
+	sge_no = PAGE_ALIGN(head->rc_pageoff + len) >> PAGE_SHIFT;
 	ctxt = svc_rdma_get_rw_ctxt(cc->cc_rdma, sge_no);
 	if (!ctxt)
 		return -ENOMEM;
@@ -719,25 +668,25 @@ static int svc_rdma_build_read_segment(struct svc_rdma_read_info *info,
 	sg = ctxt->rw_sg_table.sgl;
 	for (sge_no = 0; sge_no < ctxt->rw_nents; sge_no++) {
 		seg_len = min_t(unsigned int, len,
-				PAGE_SIZE - info->ri_pageoff);
+				PAGE_SIZE - head->rc_pageoff);
 
-		if (!info->ri_pageoff)
+		if (!head->rc_pageoff)
 			head->rc_page_count++;
 
-		sg_set_page(sg, rqstp->rq_pages[info->ri_pageno],
-			    seg_len, info->ri_pageoff);
+		sg_set_page(sg, rqstp->rq_pages[head->rc_curpage],
+			    seg_len, head->rc_pageoff);
 		sg = sg_next(sg);
 
-		info->ri_pageoff += seg_len;
-		if (info->ri_pageoff == PAGE_SIZE) {
-			info->ri_pageno++;
-			info->ri_pageoff = 0;
+		head->rc_pageoff += seg_len;
+		if (head->rc_pageoff == PAGE_SIZE) {
+			head->rc_curpage++;
+			head->rc_pageoff = 0;
 		}
 		len -= seg_len;
 
 		/* Safety check */
 		if (len &&
-		    &rqstp->rq_pages[info->ri_pageno + 1] > rqstp->rq_page_end)
+		    &rqstp->rq_pages[head->rc_curpage + 1] > rqstp->rq_page_end)
 			goto out_overrun;
 	}
 
@@ -752,13 +701,14 @@ static int svc_rdma_build_read_segment(struct svc_rdma_read_info *info,
 	return 0;
 
 out_overrun:
-	trace_svcrdma_page_overrun_err(cc->cc_rdma, rqstp, info->ri_pageno);
+	trace_svcrdma_page_overrun_err(cc->cc_rdma, rqstp, head->rc_curpage);
 	return -EINVAL;
 }
 
 /**
  * svc_rdma_build_read_chunk - Build RDMA Read WQEs to pull one RDMA chunk
- * @info: context for ongoing I/O
+ * @rqstp: RPC transaction context
+ * @head: context for ongoing I/O
  * @chunk: Read chunk to pull
  *
  * Return values:
@@ -767,7 +717,8 @@ static int svc_rdma_build_read_segment(struct svc_rdma_read_info *info,
  *   %-ENOMEM: allocating a local resources failed
  *   %-EIO: a DMA mapping error occurred
  */
-static int svc_rdma_build_read_chunk(struct svc_rdma_read_info *info,
+static int svc_rdma_build_read_chunk(struct svc_rqst *rqstp,
+				     struct svc_rdma_recv_ctxt *head,
 				     const struct svc_rdma_chunk *chunk)
 {
 	const struct svc_rdma_segment *segment;
@@ -775,56 +726,59 @@ static int svc_rdma_build_read_chunk(struct svc_rdma_read_info *info,
 
 	ret = -EINVAL;
 	pcl_for_each_segment(segment, chunk) {
-		ret = svc_rdma_build_read_segment(info, segment);
+		ret = svc_rdma_build_read_segment(rqstp, head, segment);
 		if (ret < 0)
 			break;
-		info->ri_totalbytes += segment->rs_length;
+		head->rc_readbytes += segment->rs_length;
 	}
 	return ret;
 }
 
 /**
  * svc_rdma_copy_inline_range - Copy part of the inline content into pages
- * @info: context for RDMA Reads
+ * @rqstp: RPC transaction context
+ * @head: context for ongoing I/O
  * @offset: offset into the Receive buffer of region to copy
  * @remaining: length of region to copy
  *
  * Take a page at a time from rqstp->rq_pages and copy the inline
  * content from the Receive buffer into that page. Update
- * info->ri_pageno and info->ri_pageoff so that the next RDMA Read
+ * head->rc_curpage and head->rc_pageoff so that the next RDMA Read
  * result will land contiguously with the copied content.
  *
  * Return values:
  *   %0: Inline content was successfully copied
  *   %-EINVAL: offset or length was incorrect
  */
-static int svc_rdma_copy_inline_range(struct svc_rdma_read_info *info,
+static int svc_rdma_copy_inline_range(struct svc_rqst *rqstp,
+				      struct svc_rdma_recv_ctxt *head,
 				      unsigned int offset,
 				      unsigned int remaining)
 {
-	struct svc_rdma_recv_ctxt *head = info->ri_readctxt;
 	unsigned char *dst, *src = head->rc_recv_buf;
-	struct svc_rqst *rqstp = info->ri_rqst;
 	unsigned int page_no, numpages;
 
-	numpages = PAGE_ALIGN(info->ri_pageoff + remaining) >> PAGE_SHIFT;
+	numpages = PAGE_ALIGN(head->rc_pageoff + remaining) >> PAGE_SHIFT;
 	for (page_no = 0; page_no < numpages; page_no++) {
 		unsigned int page_len;
 
+		if (head->rc_curpage >= rqstp->rq_page_end - rqstp->rq_pages)
+			return -EINVAL;
+
 		page_len = min_t(unsigned int, remaining,
-				 PAGE_SIZE - info->ri_pageoff);
+				 PAGE_SIZE - head->rc_pageoff);
 
-		if (!info->ri_pageoff)
+		if (!head->rc_pageoff)
 			head->rc_page_count++;
 
-		dst = page_address(rqstp->rq_pages[info->ri_pageno]);
-		memcpy(dst + info->ri_pageno, src + offset, page_len);
+		dst = page_address(rqstp->rq_pages[head->rc_curpage]);
+		memcpy(dst + head->rc_pageoff, src + offset, page_len);
 
-		info->ri_totalbytes += page_len;
-		info->ri_pageoff += page_len;
-		if (info->ri_pageoff == PAGE_SIZE) {
-			info->ri_pageno++;
-			info->ri_pageoff = 0;
+		head->rc_readbytes += page_len;
+		head->rc_pageoff += page_len;
+		if (head->rc_pageoff == PAGE_SIZE) {
+			head->rc_curpage++;
+			head->rc_pageoff = 0;
 		}
 		remaining -= page_len;
 		offset += page_len;
@@ -835,7 +789,8 @@ static int svc_rdma_copy_inline_range(struct svc_rdma_read_info *info,
 
 /**
  * svc_rdma_read_multiple_chunks - Construct RDMA Reads to pull data item Read chunks
- * @info: context for RDMA Reads
+ * @rqstp: RPC transaction context
+ * @head: context for ongoing I/O
  *
  * The chunk data lands in rqstp->rq_arg as a series of contiguous pages,
  * like an incoming TCP call.
@@ -847,11 +802,11 @@ static int svc_rdma_copy_inline_range(struct svc_rdma_read_info *info,
  *   %-ENOTCONN: posting failed (connection is lost),
  *   %-EIO: rdma_rw initialization failed (DMA mapping, etc).
  */
-static noinline int svc_rdma_read_multiple_chunks(struct svc_rdma_read_info *info)
+static noinline int
+svc_rdma_read_multiple_chunks(struct svc_rqst *rqstp,
+			      struct svc_rdma_recv_ctxt *head)
 {
-	struct svc_rdma_recv_ctxt *head = info->ri_readctxt;
 	const struct svc_rdma_pcl *pcl = &head->rc_read_pcl;
-	struct xdr_buf *buf = &info->ri_rqst->rq_arg;
 	struct svc_rdma_chunk *chunk, *next;
 	unsigned int start, length;
 	int ret;
@@ -859,12 +814,12 @@ static noinline int svc_rdma_read_multiple_chunks(struct svc_rdma_read_info *inf
 	start = 0;
 	chunk = pcl_first_chunk(pcl);
 	length = chunk->ch_position;
-	ret = svc_rdma_copy_inline_range(info, start, length);
+	ret = svc_rdma_copy_inline_range(rqstp, head, start, length);
 	if (ret < 0)
 		return ret;
 
 	pcl_for_each_chunk(chunk, pcl) {
-		ret = svc_rdma_build_read_chunk(info, chunk);
+		ret = svc_rdma_build_read_chunk(rqstp, head, chunk);
 		if (ret < 0)
 			return ret;
 
@@ -873,31 +828,21 @@ static noinline int svc_rdma_read_multiple_chunks(struct svc_rdma_read_info *inf
 			break;
 
 		start += length;
-		length = next->ch_position - info->ri_totalbytes;
-		ret = svc_rdma_copy_inline_range(info, start, length);
+		length = next->ch_position - head->rc_readbytes;
+		ret = svc_rdma_copy_inline_range(rqstp, head, start, length);
 		if (ret < 0)
 			return ret;
 	}
 
 	start += length;
 	length = head->rc_byte_len - start;
-	ret = svc_rdma_copy_inline_range(info, start, length);
-	if (ret < 0)
-		return ret;
-
-	buf->len += info->ri_totalbytes;
-	buf->buflen += info->ri_totalbytes;
-
-	buf->head[0].iov_base = page_address(info->ri_rqst->rq_pages[0]);
-	buf->head[0].iov_len = min_t(size_t, PAGE_SIZE, info->ri_totalbytes);
-	buf->pages = &info->ri_rqst->rq_pages[1];
-	buf->page_len = info->ri_totalbytes - buf->head[0].iov_len;
-	return 0;
+	return svc_rdma_copy_inline_range(rqstp, head, start, length);
 }
 
 /**
  * svc_rdma_read_data_item - Construct RDMA Reads to pull data item Read chunks
- * @info: context for RDMA Reads
+ * @rqstp: RPC transaction context
+ * @head: context for ongoing I/O
  *
  * The chunk data lands in the page list of rqstp->rq_arg.pages.
  *
@@ -912,50 +857,17 @@ static noinline int svc_rdma_read_multiple_chunks(struct svc_rdma_read_info *inf
  *   %-ENOTCONN: posting failed (connection is lost),
  *   %-EIO: rdma_rw initialization failed (DMA mapping, etc).
  */
-static int svc_rdma_read_data_item(struct svc_rdma_read_info *info)
+static int svc_rdma_read_data_item(struct svc_rqst *rqstp,
+				   struct svc_rdma_recv_ctxt *head)
 {
-	struct svc_rdma_recv_ctxt *head = info->ri_readctxt;
-	struct xdr_buf *buf = &info->ri_rqst->rq_arg;
-	struct svc_rdma_chunk *chunk;
-	unsigned int length;
-	int ret;
-
-	chunk = pcl_first_chunk(&head->rc_read_pcl);
-	ret = svc_rdma_build_read_chunk(info, chunk);
-	if (ret < 0)
-		goto out;
-
-	/* Split the Receive buffer between the head and tail
-	 * buffers at Read chunk's position. XDR roundup of the
-	 * chunk is not included in either the pagelist or in
-	 * the tail.
-	 */
-	buf->tail[0].iov_base = buf->head[0].iov_base + chunk->ch_position;
-	buf->tail[0].iov_len = buf->head[0].iov_len - chunk->ch_position;
-	buf->head[0].iov_len = chunk->ch_position;
-
-	/* Read chunk may need XDR roundup (see RFC 8166, s. 3.4.5.2).
-	 *
-	 * If the client already rounded up the chunk length, the
-	 * length does not change. Otherwise, the length of the page
-	 * list is increased to include XDR round-up.
-	 *
-	 * Currently these chunks always start at page offset 0,
-	 * thus the rounded-up length never crosses a page boundary.
-	 */
-	buf->pages = &info->ri_rqst->rq_pages[0];
-	length = xdr_align_size(chunk->ch_length);
-	buf->page_len = length;
-	buf->len += length;
-	buf->buflen += length;
-
-out:
-	return ret;
+	return svc_rdma_build_read_chunk(rqstp, head,
+					 pcl_first_chunk(&head->rc_read_pcl));
 }
 
 /**
- * svc_rdma_read_chunk_range - Build RDMA Read WQEs for portion of a chunk
- * @info: context for RDMA Reads
+ * svc_rdma_read_chunk_range - Build RDMA Read WRs for portion of a chunk
+ * @rqstp: RPC transaction context
+ * @head: context for ongoing I/O
  * @chunk: parsed Call chunk to pull
  * @offset: offset of region to pull
  * @length: length of region to pull
@@ -967,7 +879,8 @@ static int svc_rdma_read_data_item(struct svc_rdma_read_info *info)
  *   %-ENOTCONN: posting failed (connection is lost),
  *   %-EIO: rdma_rw initialization failed (DMA mapping, etc).
  */
-static int svc_rdma_read_chunk_range(struct svc_rdma_read_info *info,
+static int svc_rdma_read_chunk_range(struct svc_rqst *rqstp,
+				     struct svc_rdma_recv_ctxt *head,
 				     const struct svc_rdma_chunk *chunk,
 				     unsigned int offset, unsigned int length)
 {
@@ -987,11 +900,11 @@ static int svc_rdma_read_chunk_range(struct svc_rdma_read_info *info,
 		dummy.rs_length = min_t(u32, length, segment->rs_length) - offset;
 		dummy.rs_offset = segment->rs_offset + offset;
 
-		ret = svc_rdma_build_read_segment(info, &dummy);
+		ret = svc_rdma_build_read_segment(rqstp, head, &dummy);
 		if (ret < 0)
 			break;
 
-		info->ri_totalbytes += dummy.rs_length;
+		head->rc_readbytes += dummy.rs_length;
 		length -= dummy.rs_length;
 		offset = 0;
 	}
@@ -1000,7 +913,8 @@ static int svc_rdma_read_chunk_range(struct svc_rdma_read_info *info,
 
 /**
  * svc_rdma_read_call_chunk - Build RDMA Read WQEs to pull a Long Message
- * @info: context for RDMA Reads
+ * @rqstp: RPC transaction context
+ * @head: context for ongoing I/O
  *
  * Return values:
  *   %0: RDMA Read WQEs were successfully built
@@ -1009,9 +923,9 @@ static int svc_rdma_read_chunk_range(struct svc_rdma_read_info *info,
  *   %-ENOTCONN: posting failed (connection is lost),
  *   %-EIO: rdma_rw initialization failed (DMA mapping, etc).
  */
-static int svc_rdma_read_call_chunk(struct svc_rdma_read_info *info)
+static int svc_rdma_read_call_chunk(struct svc_rqst *rqstp,
+				    struct svc_rdma_recv_ctxt *head)
 {
-	struct svc_rdma_recv_ctxt *head = info->ri_readctxt;
 	const struct svc_rdma_chunk *call_chunk =
 			pcl_first_chunk(&head->rc_call_pcl);
 	const struct svc_rdma_pcl *pcl = &head->rc_read_pcl;
@@ -1020,17 +934,18 @@ static int svc_rdma_read_call_chunk(struct svc_rdma_read_info *info)
 	int ret;
 
 	if (pcl_is_empty(pcl))
-		return svc_rdma_build_read_chunk(info, call_chunk);
+		return svc_rdma_build_read_chunk(rqstp, head, call_chunk);
 
 	start = 0;
 	chunk = pcl_first_chunk(pcl);
 	length = chunk->ch_position;
-	ret = svc_rdma_read_chunk_range(info, call_chunk, start, length);
+	ret = svc_rdma_read_chunk_range(rqstp, head, call_chunk,
+					start, length);
 	if (ret < 0)
 		return ret;
 
 	pcl_for_each_chunk(chunk, pcl) {
-		ret = svc_rdma_build_read_chunk(info, chunk);
+		ret = svc_rdma_build_read_chunk(rqstp, head, chunk);
 		if (ret < 0)
 			return ret;
 
@@ -1039,8 +954,8 @@ static int svc_rdma_read_call_chunk(struct svc_rdma_read_info *info)
 			break;
 
 		start += length;
-		length = next->ch_position - info->ri_totalbytes;
-		ret = svc_rdma_read_chunk_range(info, call_chunk,
+		length = next->ch_position - head->rc_readbytes;
+		ret = svc_rdma_read_chunk_range(rqstp, head, call_chunk,
 						start, length);
 		if (ret < 0)
 			return ret;
@@ -1048,12 +963,14 @@ static int svc_rdma_read_call_chunk(struct svc_rdma_read_info *info)
 
 	start += length;
 	length = call_chunk->ch_length - start;
-	return svc_rdma_read_chunk_range(info, call_chunk, start, length);
+	return svc_rdma_read_chunk_range(rqstp, head, call_chunk,
+					 start, length);
 }
 
 /**
  * svc_rdma_read_special - Build RDMA Read WQEs to pull a Long Message
- * @info: context for RDMA Reads
+ * @rqstp: RPC transaction context
+ * @head: context for ongoing I/O
  *
  * The start of the data lands in the first page just after the
  * Transport header, and the rest lands in rqstp->rq_arg.pages.
@@ -1069,25 +986,10 @@ static int svc_rdma_read_call_chunk(struct svc_rdma_read_info *info)
  *   %-ENOTCONN: posting failed (connection is lost),
  *   %-EIO: rdma_rw initialization failed (DMA mapping, etc).
  */
-static noinline int svc_rdma_read_special(struct svc_rdma_read_info *info)
+static noinline int svc_rdma_read_special(struct svc_rqst *rqstp,
+					  struct svc_rdma_recv_ctxt *head)
 {
-	struct xdr_buf *buf = &info->ri_rqst->rq_arg;
-	int ret;
-
-	ret = svc_rdma_read_call_chunk(info);
-	if (ret < 0)
-		goto out;
-
-	buf->len += info->ri_totalbytes;
-	buf->buflen += info->ri_totalbytes;
-
-	buf->head[0].iov_base = page_address(info->ri_rqst->rq_pages[0]);
-	buf->head[0].iov_len = min_t(size_t, PAGE_SIZE, info->ri_totalbytes);
-	buf->pages = &info->ri_rqst->rq_pages[1];
-	buf->page_len = info->ri_totalbytes - buf->head[0].iov_len;
-
-out:
-	return ret;
+	return svc_rdma_read_call_chunk(rqstp, head);
 }
 
 /**
@@ -1117,30 +1019,54 @@ int svc_rdma_process_read_list(struct svcxprt_rdma *rdma,
 			       struct svc_rqst *rqstp,
 			       struct svc_rdma_recv_ctxt *head)
 {
-	struct svc_rdma_read_info *info;
-	struct svc_rdma_chunk_ctxt *cc;
+	struct svc_rdma_chunk_ctxt *cc = &head->rc_cc;
+	struct xdr_buf *buf = &rqstp->rq_arg;
 	int ret;
 
-	info = svc_rdma_read_info_alloc(rdma);
-	if (!info)
-		return -ENOMEM;
-	cc = &info->ri_cc;
-	info->ri_rqst = rqstp;
-	info->ri_readctxt = head;
-	info->ri_pageno = 0;
-	info->ri_pageoff = 0;
-	info->ri_totalbytes = 0;
+	svc_rdma_cc_init(rdma, cc);
+	cc->cc_cqe.done = svc_rdma_wc_read_done;
+	head->rc_curpage = 0;
+	head->rc_pageoff = 0;
+	head->rc_readbytes = 0;
+	/* Preserve the decoded inline body before reconstructing rq_arg. */
+	head->rc_saved_arg = *buf;
 
 	if (pcl_is_empty(&head->rc_call_pcl)) {
 		if (head->rc_read_pcl.cl_count == 1)
-			ret = svc_rdma_read_data_item(info);
+			ret = svc_rdma_read_data_item(rqstp, head);
 		else
-			ret = svc_rdma_read_multiple_chunks(info);
+			ret = svc_rdma_read_multiple_chunks(rqstp, head);
 	} else
-		ret = svc_rdma_read_special(info);
+		ret = svc_rdma_read_special(rqstp, head);
 	if (ret < 0)
 		goto out_err;
 
+	/* All Read chunks have been constructed; now assemble rq_arg. */
+	if (pcl_is_empty(&head->rc_call_pcl) &&
+	    head->rc_read_pcl.cl_count == 1) {
+		struct svc_rdma_chunk *chunk = pcl_first_chunk(&head->rc_read_pcl);
+		unsigned int length = xdr_align_size(chunk->ch_length);
+
+		/* Split the inline body at the Read chunk's position. */
+		buf->tail[0].iov_base = buf->head[0].iov_base + chunk->ch_position;
+		buf->tail[0].iov_len = buf->head[0].iov_len - chunk->ch_position;
+		buf->head[0].iov_len = chunk->ch_position;
+
+		/* Include XDR roundup of the Read chunk in the page list. */
+		buf->pages = &rqstp->rq_pages[0];
+		buf->page_len = length;
+		buf->len += length;
+		buf->buflen += length;
+	} else {
+		/* rc_readbytes includes both inline content and Read chunks. */
+		buf->len = head->rc_readbytes;
+		buf->buflen = head->rc_readbytes;
+		buf->head[0].iov_base = page_address(rqstp->rq_pages[0]);
+		buf->head[0].iov_len = min_t(size_t, PAGE_SIZE, head->rc_readbytes);
+		buf->pages = &rqstp->rq_pages[1];
+		buf->page_len = head->rc_readbytes - buf->head[0].iov_len;
+	}
+
 	trace_svcrdma_post_read_chunk(&cc->cc_cid, cc->cc_sqecount);
 	init_completion(&cc->cc_done);
 	ret = svc_rdma_post_chunk_ctxt(cc);
@@ -1160,6 +1086,6 @@ int svc_rdma_process_read_list(struct svcxprt_rdma *rdma,
 	head->rc_page_count = 0;
 
 out_err:
-	svc_rdma_read_info_free(info);
+	svc_rdma_cc_release(cc, DMA_FROM_DEVICE);
 	return ret;
 }
-- 
2.53.0

