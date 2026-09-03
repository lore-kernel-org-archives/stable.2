Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3F944BB5CE
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 14:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788445942; cv=none; b=QnfBXQdCiNJ26J+5d93xjRJn9U/flyK+V4bNiuCKvPu+f/c+wbf8XSZhWYqFAYuLDtL5pdEZQ3tWq1wDdsUBhYeNLnJMKJDBpq57fjDdaLxc9fvZUz1yLCgcRkcCzMYEUSZ9kP8AvsA33hlLrQXiR/eLJt0sePf/b5NzlRQQdP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788445942; c=relaxed/simple;
	bh=ob6swEXxJ9WaY4ynk/14SdPBjrqI+bjrjUZBrshrVkI=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=dH8kt4rHAD3tzmMqvi7rPXaSMkLUmi+Dgg/moI20Zn40OuZq/++FCQU9QHFoBm+W6K89YPzvMbSVK2nBnjkCnIlCbKWdEEH46aEr0V+HPn+UPIpdOAxBEXcOuDsAU3/HwMliDsQ0e3zQYGqdfenwaKM9KzuvBAKYUKyDL80r0AI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=AK5yct7Q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="AK5yct7Q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D21991F00A3A;
	Thu,  3 Sep 2026 14:32:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788445937;
	bh=oYGBbdYqWMBGbEGRLcddXXA6jaHs3FS9z5qeFCE8DF4=;
	h=Subject:To:Cc:From:Date;
	b=AK5yct7QwKm9+HFDzq8CdBOPn0FAoaaW/nax9OniuM8N3VLLMhHQn7dtCj3HQB+fL
	 VzDIwiHyqvMhCWuxugCYSvKWHRrURSj0nluwUOq7WOjpiT1XPqzbZr1xR7RvIzHIZ3
	 QVwrgGYGoKLoVn8GEBSbCbMjIOXytW1ujPU6XxvI=
Subject: FAILED: patch "[PATCH] svcrdma: Validate Read chunk positions before reconstruction" failed to apply to 6.1-stable tree
To: cel@kernel.org,chuck.lever@oracle.com,jlayton@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 03 Sep 2026 16:11:10 +0200
Message-ID: <2026090310-onto-impotence-7944@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 3779b7b9e7d1c8ba4738f9d327de3b0288cefe9b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090310-onto-impotence-7944@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 3779b7b9e7d1c8ba4738f9d327de3b0288cefe9b Mon Sep 17 00:00:00 2001
From: Chuck Lever <cel@kernel.org>
Date: Tue, 26 May 2026 09:35:55 -0400
Subject: [PATCH] svcrdma: Validate Read chunk positions before reconstruction

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

diff --git a/net/sunrpc/xprtrdma/svc_rdma_rw.c b/net/sunrpc/xprtrdma/svc_rdma_rw.c
index f7fd22cc4a59..8dae418d15b4 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_rw.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_rw.c
@@ -847,7 +847,7 @@ static int svc_rdma_build_read_chunk(struct svc_rqst *rqstp,
  * svc_rdma_copy_inline_range - Copy part of the inline content into pages
  * @rqstp: RPC transaction context
  * @head: context for ongoing I/O
- * @offset: offset into the Receive buffer of region to copy
+ * @offset: offset into the inline content of region to copy
  * @remaining: length of region to copy
  *
  * Take a page at a time from rqstp->rq_pages and copy the inline
@@ -864,9 +864,13 @@ static int svc_rdma_copy_inline_range(struct svc_rqst *rqstp,
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
@@ -917,9 +921,10 @@ svc_rdma_read_multiple_chunks(struct svc_rqst *rqstp,
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
@@ -937,6 +942,8 @@ svc_rdma_read_multiple_chunks(struct svc_rqst *rqstp,
 			break;
 
 		start += length;
+		if (head->rc_readbytes > next->ch_position)
+			return -EINVAL;
 		length = next->ch_position - head->rc_readbytes;
 		ret = svc_rdma_copy_inline_range(rqstp, head, start, length);
 		if (ret < 0)
@@ -944,7 +951,9 @@ svc_rdma_read_multiple_chunks(struct svc_rqst *rqstp,
 	}
 
 	start += length;
-	length = head->rc_byte_len - start;
+	if (start > inline_len)
+		return -EINVAL;
+	length = inline_len - start;
 	return svc_rdma_copy_inline_range(rqstp, head, start, length);
 }
 
@@ -969,8 +978,12 @@ svc_rdma_read_multiple_chunks(struct svc_rqst *rqstp,
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
@@ -1039,14 +1052,17 @@ static int svc_rdma_read_call_chunk(struct svc_rqst *rqstp,
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
@@ -1063,6 +1079,10 @@ static int svc_rdma_read_call_chunk(struct svc_rqst *rqstp,
 			break;
 
 		start += length;
+		if (next->ch_position > call_len)
+			return -EINVAL;
+		if (head->rc_readbytes > next->ch_position)
+			return -EINVAL;
 		length = next->ch_position - head->rc_readbytes;
 		ret = svc_rdma_read_chunk_range(rqstp, head, call_chunk,
 						start, length);
@@ -1071,7 +1091,9 @@ static int svc_rdma_read_call_chunk(struct svc_rqst *rqstp,
 	}
 
 	start += length;
-	length = call_chunk->ch_length - start;
+	if (start > call_len)
+		return -EINVAL;
+	length = call_len - start;
 	return svc_rdma_read_chunk_range(rqstp, head, call_chunk,
 					 start, length);
 }

