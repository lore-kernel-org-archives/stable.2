Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B73A93D566F
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 09:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788945970; cv=none; b=LSUCVfxuMv1uJOCnh/iVntmYVS/tnwi5fFQ9HhLIG7wq2GPK0epWt8hL8XrAt07A3YoS4VpDQ1vTXM4F0wZlxokH4lW+MH+p3UtKBsQ4Y4FL1Cb4EcC334tVEH2Kg6Kwh7y2AxZz/4Eb8yQdSGgQUj3tBEmsbrOlVOkwTU0j84E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788945970; c=relaxed/simple;
	bh=d80kfFMAQ352SZUzLNamJyOJXvJLuRd0xDgp3SRDvQE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JYLQd8auHT/K6WLhm65O2Alwfw4aAoTFBQOFQU7az0Vn537HtrFTMqEUYlYNmJ0Cl0zOoIkYXWAMi5lAMFBJ59QuTI4OLw8FRSSmFkKv2naXHJsPvl3V1TCpIxvyveJvaZBeB0opagdDYItyhm+kKlLZwlHj6vv/eEVDBKimojk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aAgWpjI7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aAgWpjI7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB9C01F00A3A;
	Wed,  9 Sep 2026 09:26:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788945968;
	bh=V7WPvxcTiXx+y/gvxr7Ki8q9UJbmWdqrIxrCTKutDho=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=aAgWpjI7ZGbSjI5xY6R09yxB3Ps8EjZCVDJ4L/j7VmAuWOGC+osuvW0DiFG1TrREo
	 tX35TodOtJe5KvyYcgJj2CgMJW/czvevyE/ratHCufuzNAFo9cRmO6h7J2OqnrFL3R
	 GnoZY/VEmZ9yQRceX6DBeSbYa2+3zJvCPH5saKuqWGL8Yi+VEH9Abv6cLScLEQjNAg
	 Km4JnPRwA0Mrtya6Rp6+BoevUih5ruITpPGTLBQbsSzj62GVsM2N7ouHrxchO4Wy9D
	 f424rd8V+z+78+Q3gAWoeGAQcsZIpwsytJMSxuruSzo3qHHZJVwsRfRPD/A2am3cqW
	 7iqK7Ec9vqQ9A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chuck Lever <chuck.lever@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/4] svcrdma: Update synopsis of svc_rdma_read_multiple_chunks()
Date: Wed,  9 Sep 2026 05:26:03 -0400
Message-ID: <20260909092606.1293505-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090309-wooing-reassign-9ecf@gregkh>
References: <2026090309-wooing-reassign-9ecf@gregkh>
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

Stable dependency adaptation for 3779b7b9e7d1 (6.6):

The original synopsis change assumes earlier Read-state and helper API
refactors that are absent here. Move the page cursor, byte offset and
accumulated byte count into the receive context, and give the existing
Read helpers the request/receive-context interfaces used by the target.
Keep the allocated read_info and synchronous completion path, using a
receive-context pointer that is cleared before read_info is freed.

Save the decoded rq_arg before reconstruction so rc_saved_arg identifies
the inline RPC body for the target's bounds checks. Move the existing
single- and multi-chunk rq_arg reconstruction into process_read_list(),
after successful WR construction, without adding any functions or the
upstream asynchronous completion machinery. Use the current page byte
offset for inline memcpy, as in the upstream helper.

This supplies the target's unchanged patch context and required state;
the position/overlap validation remains in the target commit.

Stable-dep-of: 3779b7b9e7d1 ("svcrdma: Validate Read chunk positions before reconstruction")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/sunrpc/svc_rdma.h   |   7 +
 net/sunrpc/xprtrdma/svc_rdma_rw.c | 242 ++++++++++++++----------------
 2 files changed, 116 insertions(+), 133 deletions(-)

diff --git a/include/linux/sunrpc/svc_rdma.h b/include/linux/sunrpc/svc_rdma.h
index a5ee0af2a3103..f8754f77e8d8e 100644
--- a/include/linux/sunrpc/svc_rdma.h
+++ b/include/linux/sunrpc/svc_rdma.h
@@ -140,6 +140,13 @@ struct svc_rdma_recv_ctxt {
 	u32			rc_inv_rkey;
 	__be32			rc_msgtype;
 
+	/* Read state; rc_read_info lives until synchronous I/O completes. */
+	struct svc_rdma_read_info *rc_read_info;
+	struct xdr_buf		rc_saved_arg;
+	unsigned int		rc_curpage;
+	unsigned int		rc_pageoff;
+	unsigned int		rc_readbytes;
+
 	struct svc_rdma_pcl	rc_call_pcl;
 
 	struct svc_rdma_pcl	rc_read_pcl;
diff --git a/net/sunrpc/xprtrdma/svc_rdma_rw.c b/net/sunrpc/xprtrdma/svc_rdma_rw.c
index 82c4202fa3c15..07904944d70be 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_rw.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_rw.c
@@ -294,9 +294,6 @@ static void svc_rdma_write_done(struct ib_cq *cq, struct ib_wc *wc)
 struct svc_rdma_read_info {
 	struct svc_rqst			*ri_rqst;
 	struct svc_rdma_recv_ctxt	*ri_readctxt;
-	unsigned int			ri_pageno;
-	unsigned int			ri_pageoff;
-	unsigned int			ri_totalbytes;
 
 	struct svc_rdma_chunk_ctxt	ri_cc;
 };
@@ -338,7 +335,8 @@ static void svc_rdma_wc_read_done(struct ib_cq *cq, struct ib_wc *wc)
 	switch (wc->status) {
 	case IB_WC_SUCCESS:
 		info = container_of(cc, struct svc_rdma_read_info, ri_cc);
-		trace_svcrdma_wc_read(wc, &cc->cc_cid, info->ri_totalbytes,
+		trace_svcrdma_wc_read(wc, &cc->cc_cid,
+				      info->ri_readctxt->rc_readbytes,
 				      cc->cc_posttime);
 		break;
 	case IB_WC_WR_FLUSH_ERR:
@@ -693,7 +691,8 @@ int svc_rdma_send_reply_chunk(struct svcxprt_rdma *rdma,
 
 /**
  * svc_rdma_build_read_segment - Build RDMA Read WQEs to pull one RDMA segment
- * @info: context for ongoing I/O
+ * @rqstp: RPC transaction context
+ * @head: context for ongoing I/O
  * @segment: co-ordinates of remote memory to be read
  *
  * Returns:
@@ -702,19 +701,19 @@ int svc_rdma_send_reply_chunk(struct svcxprt_rdma *rdma,
  *   %-ENOMEM: allocating a local resources failed
  *   %-EIO: a DMA mapping error occurred
  */
-static int svc_rdma_build_read_segment(struct svc_rdma_read_info *info,
+static int svc_rdma_build_read_segment(struct svc_rqst *rqstp,
+				       struct svc_rdma_recv_ctxt *head,
 				       const struct svc_rdma_segment *segment)
 {
-	struct svc_rdma_recv_ctxt *head = info->ri_readctxt;
+	struct svc_rdma_read_info *info = head->rc_read_info;
 	struct svc_rdma_chunk_ctxt *cc = &info->ri_cc;
-	struct svc_rqst *rqstp = info->ri_rqst;
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
@@ -723,25 +722,25 @@ static int svc_rdma_build_read_segment(struct svc_rdma_read_info *info,
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
 
@@ -756,13 +755,14 @@ static int svc_rdma_build_read_segment(struct svc_rdma_read_info *info,
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
@@ -771,7 +771,8 @@ static int svc_rdma_build_read_segment(struct svc_rdma_read_info *info,
  *   %-ENOMEM: allocating a local resources failed
  *   %-EIO: a DMA mapping error occurred
  */
-static int svc_rdma_build_read_chunk(struct svc_rdma_read_info *info,
+static int svc_rdma_build_read_chunk(struct svc_rqst *rqstp,
+				     struct svc_rdma_recv_ctxt *head,
 				     const struct svc_rdma_chunk *chunk)
 {
 	const struct svc_rdma_segment *segment;
@@ -779,59 +780,59 @@ static int svc_rdma_build_read_chunk(struct svc_rdma_read_info *info,
 
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
 
-		if (info->ri_pageno >= RPCSVC_MAXPAGES)
+		if (head->rc_curpage >= RPCSVC_MAXPAGES)
 			return -EINVAL;
 
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
@@ -842,7 +843,8 @@ static int svc_rdma_copy_inline_range(struct svc_rdma_read_info *info,
 
 /**
  * svc_rdma_read_multiple_chunks - Construct RDMA Reads to pull data item Read chunks
- * @info: context for RDMA Reads
+ * @rqstp: RPC transaction context
+ * @head: context for ongoing I/O
  *
  * The chunk data lands in rqstp->rq_arg as a series of contiguous pages,
  * like an incoming TCP call.
@@ -854,11 +856,11 @@ static int svc_rdma_copy_inline_range(struct svc_rdma_read_info *info,
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
@@ -866,12 +868,12 @@ static noinline int svc_rdma_read_multiple_chunks(struct svc_rdma_read_info *inf
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
 
@@ -880,31 +882,21 @@ static noinline int svc_rdma_read_multiple_chunks(struct svc_rdma_read_info *inf
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
@@ -919,50 +911,17 @@ static noinline int svc_rdma_read_multiple_chunks(struct svc_rdma_read_info *inf
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
  * svc_rdma_read_chunk_range - Build RDMA Read WQEs for portion of a chunk
- * @info: context for RDMA Reads
+ * @rqstp: RPC transaction context
+ * @head: context for ongoing I/O
  * @chunk: parsed Call chunk to pull
  * @offset: offset of region to pull
  * @length: length of region to pull
@@ -974,7 +933,8 @@ static int svc_rdma_read_data_item(struct svc_rdma_read_info *info)
  *   %-ENOTCONN: posting failed (connection is lost),
  *   %-EIO: rdma_rw initialization failed (DMA mapping, etc).
  */
-static int svc_rdma_read_chunk_range(struct svc_rdma_read_info *info,
+static int svc_rdma_read_chunk_range(struct svc_rqst *rqstp,
+				     struct svc_rdma_recv_ctxt *head,
 				     const struct svc_rdma_chunk *chunk,
 				     unsigned int offset, unsigned int length)
 {
@@ -994,11 +954,11 @@ static int svc_rdma_read_chunk_range(struct svc_rdma_read_info *info,
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
@@ -1007,7 +967,8 @@ static int svc_rdma_read_chunk_range(struct svc_rdma_read_info *info,
 
 /**
  * svc_rdma_read_call_chunk - Build RDMA Read WQEs to pull a Long Message
- * @info: context for RDMA Reads
+ * @rqstp: RPC transaction context
+ * @head: context for ongoing I/O
  *
  * Return values:
  *   %0: RDMA Read WQEs were successfully built
@@ -1016,9 +977,9 @@ static int svc_rdma_read_chunk_range(struct svc_rdma_read_info *info,
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
@@ -1027,17 +988,18 @@ static int svc_rdma_read_call_chunk(struct svc_rdma_read_info *info)
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
 
@@ -1046,8 +1008,8 @@ static int svc_rdma_read_call_chunk(struct svc_rdma_read_info *info)
 			break;
 
 		start += length;
-		length = next->ch_position - info->ri_totalbytes;
-		ret = svc_rdma_read_chunk_range(info, call_chunk,
+		length = next->ch_position - head->rc_readbytes;
+		ret = svc_rdma_read_chunk_range(rqstp, head, call_chunk,
 						start, length);
 		if (ret < 0)
 			return ret;
@@ -1055,7 +1017,8 @@ static int svc_rdma_read_call_chunk(struct svc_rdma_read_info *info)
 
 	start += length;
 	length = call_chunk->ch_length - start;
-	return svc_rdma_read_chunk_range(info, call_chunk, start, length);
+	return svc_rdma_read_chunk_range(rqstp, head, call_chunk,
+					 start, length);
 }
 
 /**
@@ -1078,23 +1041,7 @@ static int svc_rdma_read_call_chunk(struct svc_rdma_read_info *info)
  */
 static noinline int svc_rdma_read_special(struct svc_rdma_read_info *info)
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
+	return svc_rdma_read_call_chunk(info->ri_rqst, info->ri_readctxt);
 }
 
 /**
@@ -1124,6 +1071,7 @@ int svc_rdma_process_read_list(struct svcxprt_rdma *rdma,
 			       struct svc_rqst *rqstp,
 			       struct svc_rdma_recv_ctxt *head)
 {
+	struct xdr_buf *buf = &rqstp->rq_arg;
 	struct svc_rdma_read_info *info;
 	struct svc_rdma_chunk_ctxt *cc;
 	int ret;
@@ -1134,20 +1082,47 @@ int svc_rdma_process_read_list(struct svcxprt_rdma *rdma,
 	cc = &info->ri_cc;
 	info->ri_rqst = rqstp;
 	info->ri_readctxt = head;
-	info->ri_pageno = 0;
-	info->ri_pageoff = 0;
-	info->ri_totalbytes = 0;
+	head->rc_read_info = info;
+	head->rc_saved_arg = *buf;
+	head->rc_curpage = 0;
+	head->rc_pageoff = 0;
+	head->rc_readbytes = 0;
 
 	if (pcl_is_empty(&head->rc_call_pcl)) {
 		if (head->rc_read_pcl.cl_count == 1)
-			ret = svc_rdma_read_data_item(info);
+			ret = svc_rdma_read_data_item(rqstp, head);
 		else
-			ret = svc_rdma_read_multiple_chunks(info);
+			ret = svc_rdma_read_multiple_chunks(rqstp, head);
 	} else
 		ret = svc_rdma_read_special(info);
 	if (ret < 0)
 		goto out_err;
 
+	/* Reconstruct the RPC message after all Read WRs are built. */
+	if (pcl_is_empty(&head->rc_call_pcl) &&
+	    head->rc_read_pcl.cl_count == 1) {
+		struct svc_rdma_chunk *chunk = pcl_first_chunk(&head->rc_read_pcl);
+		unsigned int length = xdr_align_size(chunk->ch_length);
+
+		/* Split inline content at the Read chunk's position. */
+		buf->tail[0].iov_base = buf->head[0].iov_base + chunk->ch_position;
+		buf->tail[0].iov_len = buf->head[0].iov_len - chunk->ch_position;
+		buf->head[0].iov_len = chunk->ch_position;
+
+		/* Include the Read chunk's XDR roundup in the page list. */
+		buf->pages = &rqstp->rq_pages[0];
+		buf->page_len = length;
+		buf->len += length;
+		buf->buflen += length;
+	} else {
+		buf->len += head->rc_readbytes;
+		buf->buflen += head->rc_readbytes;
+		buf->head[0].iov_base = page_address(rqstp->rq_pages[0]);
+		buf->head[0].iov_len = min_t(size_t, PAGE_SIZE, head->rc_readbytes);
+		buf->pages = &rqstp->rq_pages[1];
+		buf->page_len = head->rc_readbytes - buf->head[0].iov_len;
+	}
+
 	trace_svcrdma_post_read_chunk(&cc->cc_cid, cc->cc_sqecount);
 	init_completion(&cc->cc_done);
 	ret = svc_rdma_post_chunk_ctxt(cc);
@@ -1167,6 +1142,7 @@ int svc_rdma_process_read_list(struct svcxprt_rdma *rdma,
 	head->rc_page_count = 0;
 
 out_err:
+	head->rc_read_info = NULL;
 	svc_rdma_read_info_free(info);
 	return ret;
 }
-- 
2.53.0

