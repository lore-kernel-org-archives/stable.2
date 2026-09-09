Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE934304BB3
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 02:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788919321; cv=none; b=sI23vkMsgFm5OavBlC2qBKsC3lsxW5pfGCuYVyxW02iN7H90ub0+8fItlGwq768gCRHnTVnNxyIkJc5yD2sJW0X8NKMhMHrU3DYuLVD4u3cxvgoHnjm0FdZZTTOgWWwWbqO+3Q3UYK7jLxGBjRsCYB+vAzAi4+5ECa6+3OVfWiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788919321; c=relaxed/simple;
	bh=YZV6TSX7e2RkM1qKSfXSVaYte9sksNFpyoI7+5Eati0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R1Fw3FVJMN/FrJ/ngYeX6cZV9h800WAazqevPl1Hzxkmq7trHeHGAXMWVYYptoz1+lMtkEgOSu0b13ySfR6o2k1HixngWNVsbdp2Xhc+p8l89E7cb4tVcl4qcSfYR6fDYo1GHPX+uYaH0uAi1Rn1C/+jBR/9uBSfgC7roaFfzME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eurrJ5pm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eurrJ5pm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A62B1F00A3F;
	Wed,  9 Sep 2026 02:01:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788919319;
	bh=vA+mKyZpKEC5iCn15S5r4TFC37/sJc4QVOCdbWPMNI0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eurrJ5pmtQDqI2ggOpd9jBab0dz+zJpMU477Gb7dBzMsGQqLapFW4wDxajxKp3Kjv
	 P+H5/sKsqTzTbE45M+UlbgRPn6EwSzYrOMDcCarjmW7s0/uROySNlPUOhOCMwzkpwh
	 tcNzXfAhmLs7pOma+WRe1lXDGxWNViUHqlTen4igEiYdH2GGiCFZRo7e+TqftUyVjR
	 SyNOE8/6CgtYyHe1iaQOX86KM4SQSoDEd1zNGvkPIW8hEhe0PHcFixl+zhaFqZWxKe
	 H2bRDewVjepjFhd2cBePlXVY6xlIDDsN9gmPz7bxpqHEj52inMKOwYIsFLZua0ZyZX
	 yRwnxbKQ6v7hQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chuck Lever <cel@kernel.org>,
	Chris Mason <clm@meta.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 4/4] svcrdma: Reject inline replies that overflow the pull-up buffer
Date: Tue,  8 Sep 2026 22:01:55 -0400
Message-ID: <20260909020155.1007668-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260909020155.1007668-1-sashal@kernel.org>
References: <2026090318-deskbound-cushy-edcc@gregkh>
 <20260909020155.1007668-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/sunrpc/xprtrdma/svc_rdma_sendto.c | 47 ++++++++++++++++++---------
 1 file changed, 32 insertions(+), 15 deletions(-)

diff --git a/net/sunrpc/xprtrdma/svc_rdma_sendto.c b/net/sunrpc/xprtrdma/svc_rdma_sendto.c
index f3b837eedfa30..9d98c4d7253ab 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_sendto.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_sendto.c
@@ -651,20 +651,21 @@ static int svc_rdma_xb_count_sges(const struct xdr_buf *xdr,
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
@@ -676,11 +677,22 @@ static bool svc_rdma_pull_up_needed(const struct svcxprt_rdma *rdma,
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
@@ -736,7 +748,7 @@ static int svc_rdma_xb_linearize(const struct xdr_buf *xdr,
  * Assemble the elements of @xdr into the transport header buffer.
  *
  * Assumptions:
- *  pull_up_needed has determined that @xdr will fit in the buffer.
+ *  check_pull_up has determined that @xdr will fit in the buffer.
  *
  * Returns:
  *   %0 if pull-up was successful
@@ -770,6 +782,7 @@ static int svc_rdma_pull_up_reply_msg(const struct svcxprt_rdma *rdma,
  *
  * Returns:
  *   %0 if DMA mapping was successful.
+ *   %-E2BIG if the reply is too large to be pulled up
  *   %-EMSGSIZE if a buffer manipulation problem occurred
  *   %-EIO if DMA mapping failed
  *
@@ -785,6 +798,7 @@ int svc_rdma_map_reply_msg(struct svcxprt_rdma *rdma,
 		.md_rdma	= rdma,
 		.md_ctxt	= sctxt,
 	};
+	int ret;
 
 	/* Set up the (persistently-mapped) transport header SGE. */
 	sctxt->sc_send_wr.num_sge = 1;
@@ -799,7 +813,10 @@ int svc_rdma_map_reply_msg(struct svcxprt_rdma *rdma,
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
@@ -970,7 +987,7 @@ int svc_rdma_sendto(struct svc_rqst *rqstp)
 	if (!pcl_is_empty(&rctxt->rc_reply_pcl)) {
 		ret = svc_rdma_send_reply_chunk(rdma, rctxt, &rqstp->rq_res);
 		if (ret < 0)
-			goto reply_chunk;
+			goto send_err;
 		rc_size = ret;
 	}
 
@@ -991,10 +1008,10 @@ int svc_rdma_sendto(struct svc_rqst *rqstp)
 
 	ret = svc_rdma_send_reply_msg(rdma, sctxt, rctxt, rqstp);
 	if (ret < 0)
-		goto put_ctxt;
+		goto send_err;
 	return 0;
 
-reply_chunk:
+send_err:
 	if (ret != -E2BIG && ret != -EINVAL)
 		goto put_ctxt;
 
-- 
2.53.0

