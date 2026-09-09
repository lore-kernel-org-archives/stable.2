Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EA993D0907
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 09:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788945979; cv=none; b=rr14Dnn99TtJ6Vl8PAsTr/OYYOoBJhAwlhuPpeEBAtui+5U5l3prw+7iJwg1wPxMnOnWv/+cjR0nyRLibWVfqhXewAOiHWty0/twvWh4i5inKiTxH7TLJJr43nlt1u5rvpqPfChlhIAJPbfVbRQxdL8qqqTIPwydBvOwbppXo6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788945979; c=relaxed/simple;
	bh=SVeWFVXhv1AqKjikNRyIikTpAiH1dWQOp3SlcwMvTXo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u6QChqMq4JV/NMOIXn9w6AvDRc4k+WHhaHQZ4JbYc8u7AT82uX1R/LfSPw+5pEGsi/Vv4WC5RaY1cvLcj2QfkbDJcP5XfifOc2ivckAiarYMipdnhlorZtF0nkGyks8fuDVyogYTnjm8V+fEPRVkdDQoBnLBAYzIk1Vo/M+LttA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CRZvVDxB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CRZvVDxB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49F501F00A3A;
	Wed,  9 Sep 2026 09:26:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788945977;
	bh=0542xsLfTwaleanpG9tUC39UQwoJmui8LSYdpoGHSgQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CRZvVDxB2P/ELxFp9+ckNl7w8T34WIAb6zEB5PtfCSVKQ8Z9zWZm2XNwaplgLCZke
	 5276hvbfdE7BuzM2emxyvaM4xghMs4kKwCYea9BfKjkmGJQnJPZNFHbz2ivdpmSetW
	 C8S3km56KTHSBnXJqa3crjYb9X8g55ZtRO5zgaiYN3RtqTykfKio/pL+jGgsSQsQ3d
	 a7tpVfdVIiA61fe9i8BJWvLITLrvuE4A6YvPTWHN3QmZFKDqvfpuUYJBAtjN0yKuhy
	 q9qqlNhP8m6tcwf9ISmOjm6TvvsjBfQV7ByBFMHg6BaF/dPnCrkGBB7VzqrD4AtxpC
	 q9QYvp0sLsklw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chuck Lever <cel@kernel.org>,
	Chris Mason <clm@meta.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] svcrdma: Reject inline replies that overflow the pull-up buffer
Date: Wed,  9 Sep 2026 05:26:15 -0400
Message-ID: <20260909092615.1294635-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090319-encroach-prepaid-8387@gregkh>
References: <2026090319-encroach-prepaid-8387@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Chuck Lever <cel@kernel.org>

[ Upstream commit 0fbe20dfe74b783d255bf389a6ea77aa25dc7860 ]

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
[ adapted the pull-up check to Linux 5.10’s direct segment-counting implementation ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/sunrpc/xprtrdma/svc_rdma_sendto.c | 45 ++++++++++++++++++++-------
 1 file changed, 33 insertions(+), 12 deletions(-)

diff --git a/net/sunrpc/xprtrdma/svc_rdma_sendto.c b/net/sunrpc/xprtrdma/svc_rdma_sendto.c
index d6436c13d5c47..d272ca1b62141 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_sendto.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_sendto.c
@@ -541,27 +541,28 @@ static int svc_rdma_dma_map_buf(struct svcxprt_rdma *rdma,
 }
 
 /**
- * svc_rdma_pull_up_needed - Determine whether to use pull-up
+ * svc_rdma_check_pull_up - Determine whether to use pull-up
  * @rdma: controlling transport
  * @sctxt: send_ctxt for the Send WR
  * @rctxt: Write and Reply chunks provided by client
  * @xdr: xdr_buf containing RPC message to transmit
  *
  * Returns:
- *	%true if pull-up must be used
- *	%false otherwise
+ *	%1 if pull-up must be used
+ *	%0 if pull-up is not needed
+ *	%-E2BIG if the reply is too large to be pulled up
  */
-static bool svc_rdma_pull_up_needed(struct svcxprt_rdma *rdma,
-				    struct svc_rdma_send_ctxt *sctxt,
-				    const struct svc_rdma_recv_ctxt *rctxt,
-				    struct xdr_buf *xdr)
+static int svc_rdma_check_pull_up(struct svcxprt_rdma *rdma,
+				  struct svc_rdma_send_ctxt *sctxt,
+				  const struct svc_rdma_recv_ctxt *rctxt,
+				  struct xdr_buf *xdr)
 {
 	int elements;
 
 	/* For small messages, copying bytes is cheaper than DMA mapping.
 	 */
 	if (sctxt->sc_hdrbuf.len + xdr->len < RPCRDMA_PULLUP_THRESH)
-		return true;
+		return 1;
 
 	/* Check whether the xdr_buf has more elements than can
 	 * fit in a single RDMA Send.
@@ -589,7 +590,18 @@ static bool svc_rdma_pull_up_needed(struct svcxprt_rdma *rdma,
 		++elements;
 
 	/* assume 1 SGE is needed for the transport header */
-	return elements >= rdma->sc_max_send_sges;
+	if (elements < rdma->sc_max_send_sges)
+		return 0;
+
+	/*
+	 * The reply has too many SGEs to Send inline, so it has to be
+	 * linearized into sc_xprt_buf. That buffer holds only
+	 * sc_max_req_size bytes, so a larger reply cannot be pulled up.
+	 * RFC 8166 Section 4.5.3 requires responding with ERR_CHUNK.
+	 */
+	if (sctxt->sc_hdrbuf.len + xdr->len > rdma->sc_max_req_size)
+		return -E2BIG;
+	return 1;
 }
 
 /**
@@ -602,6 +614,9 @@ static bool svc_rdma_pull_up_needed(struct svcxprt_rdma *rdma,
  * The device is not capable of sending the reply directly.
  * Assemble the elements of @xdr into the transport header buffer.
  *
+ * Assumptions:
+ *  check_pull_up has determined that @xdr will fit in the buffer.
+ *
  * Returns zero on success, or a negative errno on failure.
  */
 static int svc_rdma_pull_up_reply_msg(struct svcxprt_rdma *rdma,
@@ -662,7 +677,10 @@ static int svc_rdma_pull_up_reply_msg(struct svcxprt_rdma *rdma,
  * Load the xdr_buf into the ctxt's sge array, and DMA map each
  * element as it is added. The Send WR's num_sge field is set.
  *
- * Returns zero on success, or a negative errno on failure.
+ * Returns:
+ *   %0 if DMA mapping was successful.
+ *   %-E2BIG if the reply is too large to be pulled up
+ *   %-EIO if DMA mapping failed
  */
 int svc_rdma_map_reply_msg(struct svcxprt_rdma *rdma,
 			   struct svc_rdma_send_ctxt *sctxt,
@@ -689,7 +707,10 @@ int svc_rdma_map_reply_msg(struct svcxprt_rdma *rdma,
 	/* For pull-up, svc_rdma_send() will sync the transport header.
 	 * No additional DMA mapping is necessary.
 	 */
-	if (svc_rdma_pull_up_needed(rdma, sctxt, rctxt, xdr))
+	ret = svc_rdma_check_pull_up(rdma, sctxt, rctxt, xdr);
+	if (ret < 0)
+		return ret;
+	if (ret)
 		return svc_rdma_pull_up_reply_msg(rdma, sctxt, rctxt, xdr);
 
 	++sctxt->sc_cur_sge_no;
@@ -946,7 +967,7 @@ int svc_rdma_sendto(struct svc_rqst *rqstp)
 
 	ret = svc_rdma_send_reply_msg(rdma, sctxt, rctxt, rqstp);
 	if (ret < 0)
-		goto err1;
+		goto err2;
 	return 0;
 
  err2:
-- 
2.53.0

