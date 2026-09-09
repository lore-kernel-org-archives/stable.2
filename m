Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 863FE524AEB
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 10:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788950525; cv=none; b=d0giQhcC9oYwbQIxdreHGFvLCTZMxBsjSbWEQsLeOxro4u5hCIPLh4hyYQKeRVajFsf9M1H36yXrL53ZRDxZ2MoeL1r5wGI4SbHsS4gS1PeZY5j3igmqUQdDA3BAn1PMd0N8WSaV2rKKwzjsDnLrKqdt2SftJT5UJ+5pLNjGQdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788950525; c=relaxed/simple;
	bh=plUPMxFIeymdZkH4JMxFR0+ZG30HphEZZvZiQCIooQE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sQ55xeb7nic400O5dbbOz1I3WRGJW8pF0XwWW7ZHAcK9FgygARqfkbXds+X2OanUTHXj9lJ9FUHAA54oVXbS3AaQLUamr4n+xqKyVmirmhOLAwoNJ4U9QYjU9ltYrn8d9kwPP7e2Uh8moHTrH05Ih1LgLn3yL8CdkfsYJyFWBns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YR7WiGNz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YR7WiGNz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEFA21F00ACA;
	Wed,  9 Sep 2026 10:42:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788950523;
	bh=MuJWn34KuNuXD5m/pTE86qKIBo9LCQt5iJmGLwxcqVI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YR7WiGNzZHrWwxEmeKYwvHYwMGO8Jw2AlAQr6IJs8b2gT/Puk6RryOMbdFD2srjZA
	 adyq0hamTyQHp6W5Q2LLG+niHIRJWFQ8GAJNhuyLBec5AQRJ/9Xop/Im5Bm5+wsM/+
	 7KXhtRKZGy2DOWWzZMzPVD7qjZBAI/ABXGMlpem+RESIsen4k5u5HLFhL0Bcv300Lc
	 QWd1X57l6nv6KkoPmzIzngnJsWeXTBDxRtDyaVjBbsoaS+WlJHQRobqTJON/ZVfSnl
	 jvmreHXX+NbhlHuUi8JK65Mlw6jgnsfIliAfZW83d/P8zfPjExfXsHszSf2bxbvb6n
	 BZ970YjhU8sCw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 5/5] svcrdma: Validate Read chunk positions before reconstruction
Date: Wed,  9 Sep 2026 06:41:58 -0400
Message-ID: <20260909104158.1554268-5-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260909104158.1554268-1-sashal@kernel.org>
References: <2026090310-onto-impotence-7944@gregkh>
 <20260909104158.1554268-1-sashal@kernel.org>
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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/sunrpc/xprtrdma/svc_rdma_rw.c | 38 ++++++++++++++++++++++++-------
 1 file changed, 30 insertions(+), 8 deletions(-)

diff --git a/net/sunrpc/xprtrdma/svc_rdma_rw.c b/net/sunrpc/xprtrdma/svc_rdma_rw.c
index 6586dc7ddc5df..c871990c3a921 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_rw.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_rw.c
@@ -743,7 +743,7 @@ static int svc_rdma_build_read_chunk(struct svc_rqst *rqstp,
  * svc_rdma_copy_inline_range - Copy part of the inline content into pages
  * @rqstp: RPC transaction context
  * @head: context for ongoing I/O
- * @offset: offset into the Receive buffer of region to copy
+ * @offset: offset into the inline content of region to copy
  * @remaining: length of region to copy
  *
  * Take a page at a time from rqstp->rq_pages and copy the inline
@@ -760,9 +760,13 @@ static int svc_rdma_copy_inline_range(struct svc_rqst *rqstp,
 				      unsigned int offset,
 				      unsigned int remaining)
 {
-	unsigned char *dst, *src = head->rc_recv_buf;
+	unsigned char *dst, *src = head->rc_saved_arg.head[0].iov_base;
+	unsigned int inline_len = head->rc_saved_arg.head[0].iov_len;
 	unsigned int page_no, numpages;
 
+	if (offset > inline_len || remaining > inline_len - offset)
+		return -EINVAL;
+
 	numpages = PAGE_ALIGN(head->rc_pageoff + remaining) >> PAGE_SHIFT;
 	for (page_no = 0; page_no < numpages; page_no++) {
 		unsigned int page_len;
@@ -813,9 +817,10 @@ svc_rdma_read_multiple_chunks(struct svc_rqst *rqstp,
 {
 	const struct svc_rdma_pcl *pcl = &head->rc_read_pcl;
 	struct svc_rdma_chunk *chunk, *next;
-	unsigned int start, length;
+	unsigned int inline_len, start, length;
 	int ret;
 
+	inline_len = head->rc_saved_arg.head[0].iov_len;
 	start = 0;
 	chunk = pcl_first_chunk(pcl);
 	length = chunk->ch_position;
@@ -833,6 +838,8 @@ svc_rdma_read_multiple_chunks(struct svc_rqst *rqstp,
 			break;
 
 		start += length;
+		if (head->rc_readbytes > next->ch_position)
+			return -EINVAL;
 		length = next->ch_position - head->rc_readbytes;
 		ret = svc_rdma_copy_inline_range(rqstp, head, start, length);
 		if (ret < 0)
@@ -840,7 +847,9 @@ svc_rdma_read_multiple_chunks(struct svc_rqst *rqstp,
 	}
 
 	start += length;
-	length = head->rc_byte_len - start;
+	if (start > inline_len)
+		return -EINVAL;
+	length = inline_len - start;
 	return svc_rdma_copy_inline_range(rqstp, head, start, length);
 }
 
@@ -865,8 +874,12 @@ svc_rdma_read_multiple_chunks(struct svc_rqst *rqstp,
 static int svc_rdma_read_data_item(struct svc_rqst *rqstp,
 				   struct svc_rdma_recv_ctxt *head)
 {
-	return svc_rdma_build_read_chunk(rqstp, head,
-					 pcl_first_chunk(&head->rc_read_pcl));
+	struct svc_rdma_chunk *chunk = pcl_first_chunk(&head->rc_read_pcl);
+
+	if (chunk->ch_position > head->rc_saved_arg.head[0].iov_len)
+		return -EINVAL;
+
+	return svc_rdma_build_read_chunk(rqstp, head, chunk);
 }
 
 /**
@@ -935,14 +948,17 @@ static int svc_rdma_read_call_chunk(struct svc_rqst *rqstp,
 			pcl_first_chunk(&head->rc_call_pcl);
 	const struct svc_rdma_pcl *pcl = &head->rc_read_pcl;
 	struct svc_rdma_chunk *chunk, *next;
-	unsigned int start, length;
+	unsigned int call_len, start, length;
 	int ret;
 
 	if (pcl_is_empty(pcl))
 		return svc_rdma_build_read_chunk(rqstp, head, call_chunk);
 
+	call_len = call_chunk->ch_length;
 	start = 0;
 	chunk = pcl_first_chunk(pcl);
+	if (chunk->ch_position > call_len)
+		return -EINVAL;
 	length = chunk->ch_position;
 	ret = svc_rdma_read_chunk_range(rqstp, head, call_chunk,
 					start, length);
@@ -959,6 +975,10 @@ static int svc_rdma_read_call_chunk(struct svc_rqst *rqstp,
 			break;
 
 		start += length;
+		if (next->ch_position > call_len)
+			return -EINVAL;
+		if (head->rc_readbytes > next->ch_position)
+			return -EINVAL;
 		length = next->ch_position - head->rc_readbytes;
 		ret = svc_rdma_read_chunk_range(rqstp, head, call_chunk,
 						start, length);
@@ -967,7 +987,9 @@ static int svc_rdma_read_call_chunk(struct svc_rqst *rqstp,
 	}
 
 	start += length;
-	length = call_chunk->ch_length - start;
+	if (start > call_len)
+		return -EINVAL;
+	length = call_len - start;
 	return svc_rdma_read_chunk_range(rqstp, head, call_chunk,
 					 start, length);
 }
-- 
2.53.0

