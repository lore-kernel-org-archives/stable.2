Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC9FE4B66EA
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 14:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788445903; cv=none; b=YSwXPLGkb4sAa7wQPuezwWdZTMq8v5ksDLcHK+3n1J8JywWM5IxWVmY1FSx+xIUmNDP9FCWMSxr0K4LEbuCKxI2PJDpPorLEBFgErk0BKomB0qd1tuRkExMBjuRYB+kuv2wxL3IdjgqEvt4q1L1sjQRwPvwS9XfswcXjuqgRCpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788445903; c=relaxed/simple;
	bh=CSwAZOpFkbwNZik0d0S+07qXI9rWfvrq1mab+L5EkT0=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Xpmawvp1t95J1hiur2RcEZv68Mj18oVknR4WzWMWxIwHA01hZYXgRdZA6PsiFs6WPnCuiGh4n754IyNr4p3TjtdFDWUktbm5qM29+zEXX2C/wY7+6YdYiQ5RWzMMkLHQNKvYy/5qmlQJjqKowmrRafLRaG2ddGdT0mhVR4pdlL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HWBInF4q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HWBInF4q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDE7C1F00A3D;
	Thu,  3 Sep 2026 14:31:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788445886;
	bh=XNjfZ/KLa9q7jU++Z6N6dMzhVqi8oPLPcu8LqzZgMJ4=;
	h=Subject:To:Cc:From:Date;
	b=HWBInF4qfwfUr30hatlIOy2JFN5/NQXppgMst4lhXo5bRdCWycfHF5dIXv/Asemlk
	 rh/1nxBc/QNKRTpi2itLgJtalsiEOyg3JmbGQCFIhq9E5Hd3w1QPH/KnPYBDoxXi7P
	 zgyxU7knaS47EHuPf3Pj37ofRobmJnJ0zayJMOrM=
Subject: FAILED: patch "[PATCH] svcrdma: Reject inline replies that overflow the pull-up" failed to apply to 6.1-stable tree
To: cel@kernel.org,clm@meta.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 03 Sep 2026 16:10:18 +0200
Message-ID: <2026090318-deskbound-cushy-edcc@gregkh>
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
git cherry-pick -x 0fbe20dfe74b783d255bf389a6ea77aa25dc7860
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090318-deskbound-cushy-edcc@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

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
 

