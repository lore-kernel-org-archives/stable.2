Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E555B201278
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 14:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788445887; cv=none; b=pNuZPxQwsYnYWSkEqMNKVNia67AhY3rrqewmnr6Ff06ylPHKLEhR/YcdguYWazKXfsgswqhgi4KRZuleVD1znI7ShRNqzr1B3nJNTpq3mmV2ZhL06qarSgUAbQUBh466x89/qUGEXj47OvdILwrB3WMO+3NiHgrl10ZbtG1ldtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788445887; c=relaxed/simple;
	bh=CUqEtiTRTZepLiJvyhZCmCS5hQj8G48dt4rJ6kYAABQ=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=ny7frh8ujl7lygI6A2PMGxzWdMVPlwI26o4JlCQgbTEKC9u9UBz2SeFfaDvYcfJs/X+4LM5NETsMQZsUYvH7X6CpOgzHaOe0X5bhqMkAR4JM7xL1wvS2nCgtWfvcrshqQgoUjKE176gN9MDFz+8MuYL7ORgf5mgFph+41wW2Xbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zU+bUawz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zU+bUawz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19B651F00A3A;
	Thu,  3 Sep 2026 14:31:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788445880;
	bh=QOfn3FA0m+oZm8QAtpdPRliuYhdIdoBFaBMCt+xfhrI=;
	h=Subject:To:Cc:From:Date;
	b=zU+bUawzSte5Z2UlnwbgLIXH+fgiu2bGtsx1w866mCqfqb5Zi2Igb0/v5pH+YFW7+
	 B78pTUGsPGoY8zjFiYqhLdEUT9AUEXtbR9zKAnSyomfZpnsv+Dhw9HxyMwxhHq41mp
	 hIZQm0JiKEcwhq2O6H7rTW7lKfoiMlJEyzSBnJCo=
Subject: FAILED: patch "[PATCH] svcrdma: Reject inline replies that overflow the pull-up" failed to apply to 6.6-stable tree
To: cel@kernel.org,clm@meta.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 03 Sep 2026 16:10:17 +0200
Message-ID: <2026090317-dining-snippet-cb36@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 0fbe20dfe74b783d255bf389a6ea77aa25dc7860
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090317-dining-snippet-cb36@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 0fbe20dfe74b783d255bf389a6ea77aa25dc7860 Mon Sep 17 00:00:00 2001
From: Chuck Lever <cel@kernel.org>
Date: Mon, 22 Jun 2026 21:47:28 -0400
Subject: [PATCH] svcrdma: Reject inline replies that overflow the pull-up
 buffer

An RPC-over-RDMA client can request a reply, such as an NFS READ
payload, without providing a Write list or a Reply chunk to carry
it. When such a reply needs more scatter/gather entries than the
device's Send Queue supports, svc_rdma_pull_up_needed() selects
pull-up and svc_rdma_pull_up_reply_msg() linearizes the whole
reply into sctxt->sc_xprt_buf. That buffer is only sc_max_req_size
bytes, while the reply on this path is bounded only by the client's
request, so svc_rdma_xb_linearize() copies past the end of the
buffer and corrupts adjacent slab memory. The oversized length is
then stored in sc_sges[0].length and posted, so the device also
reads beyond the mapped region.

The SGE-exhaustion branch is the only pull-up path that can exceed
the buffer: the threshold branch pulls up only replies smaller
than RPCRDMA_PULLUP_THRESH, and replies that fit the device's SGE
budget are sent directly without linearization. Make
svc_rdma_pull_up_needed() report -E2BIG when the reply it would
pull up cannot fit sc_max_req_size, and fail the request with
ERR_CHUNK as RFC 8166 Section 4.5.3 directs rather than dropping
the connection.

The helper no longer answers a simple yes/no question: it now
reports pull-up, no pull-up, or -E2BIG for a reply too large to
linearize. Rename svc_rdma_pull_up_needed() to
svc_rdma_check_pull_up() so its name no longer implies a boolean
predicate.

Fixes: e248aa7be86e ("svcrdma: Remove max_sge check at connect time")
Cc: stable@vger.kernel.org
Reported-by: Chris Mason <clm@meta.com>
Assisted-by: kres:claude-opus-4-7
Link: https://patch.msgid.link/20260623014728.826032-1-cel@kernel.org
Signed-off-by: Chuck Lever <cel@kernel.org>

diff --git a/net/sunrpc/xprtrdma/svc_rdma_sendto.c b/net/sunrpc/xprtrdma/svc_rdma_sendto.c
index 7f6d17bf8c1f..c09659b17351 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_sendto.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_sendto.c
@@ -825,20 +825,21 @@ static int svc_rdma_xb_count_sges(const struct xdr_buf *xdr,
 }
 
 /**
- * svc_rdma_pull_up_needed - Determine whether to use pull-up
+ * svc_rdma_check_pull_up - Determine whether to use pull-up
  * @rdma: controlling transport
  * @sctxt: send_ctxt for the Send WR
  * @write_pcl: Write chunk list provided by client
  * @xdr: xdr_buf containing RPC message to transmit
  *
  * Returns:
- *   %true if pull-up must be used
- *   %false otherwise
+ *   %1 if pull-up must be used
+ *   %0 if pull-up is not needed
+ *   %-E2BIG if the reply is too large to be pulled up
  */
-static bool svc_rdma_pull_up_needed(const struct svcxprt_rdma *rdma,
-				    const struct svc_rdma_send_ctxt *sctxt,
-				    const struct svc_rdma_pcl *write_pcl,
-				    const struct xdr_buf *xdr)
+static int svc_rdma_check_pull_up(const struct svcxprt_rdma *rdma,
+				   const struct svc_rdma_send_ctxt *sctxt,
+				   const struct svc_rdma_pcl *write_pcl,
+				   const struct xdr_buf *xdr)
 {
 	/* Resources needed for the transport header */
 	struct svc_rdma_pullup_data args = {
@@ -850,11 +851,22 @@ static bool svc_rdma_pull_up_needed(const struct svcxprt_rdma *rdma,
 	ret = pcl_process_nonpayloads(write_pcl, xdr,
 				      svc_rdma_xb_count_sges, &args);
 	if (ret < 0)
-		return false;
+		return 0;
 
 	if (args.pd_length < RPCRDMA_PULLUP_THRESH)
-		return true;
-	return args.pd_num_sges >= rdma->sc_max_send_sges;
+		return 1;
+	if (args.pd_num_sges < rdma->sc_max_send_sges)
+		return 0;
+
+	/*
+	 * The reply has too many SGEs to Send inline, so it has to be
+	 * linearized into sc_xprt_buf. That buffer holds only
+	 * sc_max_req_size bytes, so a larger reply cannot be pulled up.
+	 * RFC 8166 Section 4.5.3 requires responding with ERR_CHUNK.
+	 */
+	if (args.pd_length > rdma->sc_max_req_size)
+		return -E2BIG;
+	return 1;
 }
 
 /**
@@ -910,7 +922,7 @@ static int svc_rdma_xb_linearize(const struct xdr_buf *xdr,
  * Assemble the elements of @xdr into the transport header buffer.
  *
  * Assumptions:
- *  pull_up_needed has determined that @xdr will fit in the buffer.
+ *  check_pull_up has determined that @xdr will fit in the buffer.
  *
  * Returns:
  *   %0 if pull-up was successful
@@ -945,6 +957,7 @@ static int svc_rdma_pull_up_reply_msg(const struct svcxprt_rdma *rdma,
  *
  * Returns:
  *   %0 if DMA mapping was successful.
+ *   %-E2BIG if the reply is too large to be pulled up
  *   %-EMSGSIZE if a buffer manipulation problem occurred
  *   %-EIO if DMA mapping failed
  *
@@ -960,6 +973,7 @@ int svc_rdma_map_reply_msg(struct svcxprt_rdma *rdma,
 		.md_rdma	= rdma,
 		.md_ctxt	= sctxt,
 	};
+	int ret;
 
 	/* Set up the (persistently-mapped) transport header SGE. */
 	sctxt->sc_send_wr.num_sge = 1;
@@ -974,7 +988,10 @@ int svc_rdma_map_reply_msg(struct svcxprt_rdma *rdma,
 	/* For pull-up, svc_rdma_send() will sync the transport header.
 	 * No additional DMA mapping is necessary.
 	 */
-	if (svc_rdma_pull_up_needed(rdma, sctxt, write_pcl, xdr))
+	ret = svc_rdma_check_pull_up(rdma, sctxt, write_pcl, xdr);
+	if (ret < 0)
+		return ret;
+	if (ret)
 		return svc_rdma_pull_up_reply_msg(rdma, sctxt, write_pcl, xdr);
 
 	return pcl_process_nonpayloads(write_pcl, xdr,
@@ -1162,7 +1179,7 @@ int svc_rdma_sendto(struct svc_rqst *rqstp)
 						   &rctxt->rc_reply_pcl, sctxt,
 						   &rqstp->rq_res);
 		if (ret < 0)
-			goto reply_chunk;
+			goto send_err;
 		rc_size = ret;
 	}
 
@@ -1183,10 +1200,10 @@ int svc_rdma_sendto(struct svc_rqst *rqstp)
 
 	ret = svc_rdma_send_reply_msg(rdma, sctxt, rctxt, rqstp);
 	if (ret < 0)
-		goto put_ctxt;
+		goto send_err;
 	return 0;
 
-reply_chunk:
+send_err:
 	if (ret != -E2BIG && ret != -EINVAL)
 		goto put_ctxt;
 

