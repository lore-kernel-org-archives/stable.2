Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C684854CF7D
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 11:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788955091; cv=none; b=pPJtLNjeM6TEqJrTlfYTL7zWugDD83wIA8P+n9UGhoXsKRym3r61xWhMfn0Za1rk6X68+T+YFUdw61lK/WzhF81zOxycmSO6RIBkKcE8n1XqV9egf6NpMxXufBXpGs5X58bhX9MI1Jefa1GPT8NmlWEDfIvhGPks0gvsy+yKJyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788955091; c=relaxed/simple;
	bh=GXoiFN/BTq3TDwgopOnO3CzAf5xOH9k5PpytRHc5q10=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OXCuUI0bCSFaQZfpFXXJWajmS1zXRIX1HksnHitYmZtmjZABU7DGX2f7S7rX6+UKaIpcFLsf3Waa98Zt1G3MMG0y8XV1/KI/02kJKK8tnSAetFjFex7JZuTn6ZYLDQmbHKSZogX/woY1H1+og/8dKIo6ibjQF3x2sNfhRcwZbts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JI7ONdDz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JI7ONdDz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB3BD1F00A3E;
	Wed,  9 Sep 2026 11:58:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788955089;
	bh=eTSGwHsdn6ZJrQzdHCpIl5aWia//FmBucpAVPpwdPcU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JI7ONdDz6HP/wuaDTiUg58wJYMuhxUNKPZhnrkqcBrBurPjqDCWnkzOJXDOsNBUdG
	 BuIdL+Ftf3lLnOYTbD1iOjnGKbOL9iLgWtIAwCPnkRMrv3hVxPFCqFwzPdJAMp+R3c
	 s8DUIDD/8BFtukykz8ThmiX2rnIYXQBc/qQavzT7CXe+vEuTs0VEW73m1qOqaft+q5
	 GWha308r4zTDw16G1CjHdwI4AGs8VQz/jgXUK01btXltzWfrAuLdahF2vqt2H+QP1V
	 zbWAhV1BpM9fCftos9DgCskYH1YNoSgixlkQkqC4RMZArzkscREqRCOzLAGuusStVX
	 Imnv0DsGOBhkw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] svcrdma: Validate Read chunk positions before reconstruction
Date: Wed,  9 Sep 2026 07:58:07 -0400
Message-ID: <20260909115807.2180995-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090310-smell-askew-3d0b@gregkh>
References: <2026090310-smell-askew-3d0b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

[ Upstream commit 3779b7b9e7d1c8ba4738f9d327de3b0288cefe9b ]

The RPC/RDMA Read chunk position field is supplied by the remote
client and stored verbatim in the parsed chunk list.
xdr_count_read_segments() checks only 4-byte alignment; it never
compares the position against the received inline body length.

In the single-chunk path, svc_rdma_read_complete_one() splits the
head and tail kvecs at ch_position. A position past the inline
body underflows the tail length, exposing adjacent slab memory to
the upper XDR decoder.

In the multi-chunk path, svc_rdma_read_multiple_chunks() computes
gap lengths between chunks as unsigned subtractions from
ch_position. Overlapping Read chunks cause these subtractions to
underflow. A final position past the inline body likewise
underflows the trailing gap length. svc_rdma_copy_inline_range()
then copies past the receive buffer into request pages that are
returned to the client through the Reply channel.

Bound inline-range copies in svc_rdma_copy_inline_range() against
the decoded inline RPC body saved in rc_saved_arg. Reject a
single Read chunk positioned beyond that body, and reject
multi-chunk lists where accumulated read bytes exceed the next
chunk's position. Apply the same position and overlap checks in
the call-chunk interleaving path.

Fixes: d96962e6d0e2 ("svcrdma: Use the new parsed chunk list when pulling Read chunks")
Cc: stable@vger.kernel.org
Acked-by: Jeff Layton <jlayton@kernel.org>
Link: https://patch.msgid.link/20260526-rpc-kernel-bugs-v1-1-e251306ccca9@oracle.com
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
[ Adapted head->rc_saved_arg and head->rc_readbytes accesses to rqstp->rq_arg and info->ri_totalbytes. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/sunrpc/xprtrdma/svc_rdma_rw.c | 33 +++++++++++++++++++++++++------
 1 file changed, 27 insertions(+), 6 deletions(-)

diff --git a/net/sunrpc/xprtrdma/svc_rdma_rw.c b/net/sunrpc/xprtrdma/svc_rdma_rw.c
index 5791c26cd916b..68116eeceedcb 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_rw.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_rw.c
@@ -764,7 +764,7 @@ static int svc_rdma_build_read_chunk(struct svc_rdma_read_info *info,
 /**
  * svc_rdma_copy_inline_range - Copy part of the inline content into pages
  * @info: context for RDMA Reads
- * @offset: offset into the Receive buffer of region to copy
+ * @offset: offset into the inline content of region to copy
  * @remaining: length of region to copy
  *
  * Take a page at a time from rqstp->rq_pages and copy the inline
@@ -781,10 +781,14 @@ static int svc_rdma_copy_inline_range(struct svc_rdma_read_info *info,
 				      unsigned int remaining)
 {
 	struct svc_rdma_recv_ctxt *head = info->ri_readctxt;
-	unsigned char *dst, *src = head->rc_recv_buf;
 	struct svc_rqst *rqstp = info->ri_rqst;
+	unsigned char *dst, *src = rqstp->rq_arg.head[0].iov_base;
+	unsigned int inline_len = rqstp->rq_arg.head[0].iov_len;
 	unsigned int page_no, numpages;
 
+	if (offset > inline_len || remaining > inline_len - offset)
+		return -EINVAL;
+
 	numpages = PAGE_ALIGN(info->ri_pageoff + remaining) >> PAGE_SHIFT;
 	for (page_no = 0; page_no < numpages; page_no++) {
 		unsigned int page_len;
@@ -834,9 +838,10 @@ static noinline int svc_rdma_read_multiple_chunks(struct svc_rdma_read_info *inf
 	const struct svc_rdma_pcl *pcl = &head->rc_read_pcl;
 	struct xdr_buf *buf = &info->ri_rqst->rq_arg;
 	struct svc_rdma_chunk *chunk, *next;
-	unsigned int start, length;
+	unsigned int inline_len, start, length;
 	int ret;
 
+	inline_len = buf->head[0].iov_len;
 	start = 0;
 	chunk = pcl_first_chunk(pcl);
 	length = chunk->ch_position;
@@ -854,6 +859,8 @@ static noinline int svc_rdma_read_multiple_chunks(struct svc_rdma_read_info *inf
 			break;
 
 		start += length;
+		if (info->ri_totalbytes > next->ch_position)
+			return -EINVAL;
 		length = next->ch_position - info->ri_totalbytes;
 		ret = svc_rdma_copy_inline_range(info, start, length);
 		if (ret < 0)
@@ -861,7 +868,9 @@ static noinline int svc_rdma_read_multiple_chunks(struct svc_rdma_read_info *inf
 	}
 
 	start += length;
-	length = head->rc_byte_len - start;
+	if (start > inline_len)
+		return -EINVAL;
+	length = inline_len - start;
 	ret = svc_rdma_copy_inline_range(info, start, length);
 	if (ret < 0)
 		return ret;
@@ -902,6 +911,9 @@ static int svc_rdma_read_data_item(struct svc_rdma_read_info *info)
 	int ret;
 
 	chunk = pcl_first_chunk(&head->rc_read_pcl);
+	if (chunk->ch_position > buf->head[0].iov_len)
+		return -EINVAL;
+
 	ret = svc_rdma_build_read_chunk(info, chunk);
 	if (ret < 0)
 		goto out;
@@ -997,14 +1009,17 @@ static int svc_rdma_read_call_chunk(struct svc_rdma_read_info *info)
 			pcl_first_chunk(&head->rc_call_pcl);
 	const struct svc_rdma_pcl *pcl = &head->rc_read_pcl;
 	struct svc_rdma_chunk *chunk, *next;
-	unsigned int start, length;
+	unsigned int call_len, start, length;
 	int ret;
 
 	if (pcl_is_empty(pcl))
 		return svc_rdma_build_read_chunk(info, call_chunk);
 
+	call_len = call_chunk->ch_length;
 	start = 0;
 	chunk = pcl_first_chunk(pcl);
+	if (chunk->ch_position > call_len)
+		return -EINVAL;
 	length = chunk->ch_position;
 	ret = svc_rdma_read_chunk_range(info, call_chunk, start, length);
 	if (ret < 0)
@@ -1020,6 +1035,10 @@ static int svc_rdma_read_call_chunk(struct svc_rdma_read_info *info)
 			break;
 
 		start += length;
+		if (next->ch_position > call_len)
+			return -EINVAL;
+		if (info->ri_totalbytes > next->ch_position)
+			return -EINVAL;
 		length = next->ch_position - info->ri_totalbytes;
 		ret = svc_rdma_read_chunk_range(info, call_chunk,
 						start, length);
@@ -1028,7 +1047,9 @@ static int svc_rdma_read_call_chunk(struct svc_rdma_read_info *info)
 	}
 
 	start += length;
-	length = call_chunk->ch_length - start;
+	if (start > call_len)
+		return -EINVAL;
+	length = call_len - start;
 	return svc_rdma_read_chunk_range(info, call_chunk, start, length);
 }
 
-- 
2.53.0

