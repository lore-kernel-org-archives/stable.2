Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DB484086A
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 00:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788915126; cv=none; b=qF8EH1jeD/rx1jDWSdY9yLFQ73SRLIpf0irACsVM40+7ZEr/+Zm0WZUDKELHSPokGSfQmxx1AAg47Lq30B1y2QePlnpg7QDQRHLCOaFnxBxVP5CS6fEXlgTKNdlYDGXRNSqDAsaNzNYIIar9A+iMwZo/KB2grSPjUChvYV/Or9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788915126; c=relaxed/simple;
	bh=5oagRwx/FZ6uKM96vHm+/O16L8jheTYeXiqXM/ZZWgI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bNtLn+M1X8ut8ZLmpap6BRkaTGQrRiioEnPZ7iWz3zf715UfzwZa/TL/rfrwJhbOraMnAuFag0aKQ5e9NEU13th+J3pcDkkfPEdR7GtfT9RQYgnJTQMdYGN49JNzDOvtx6LqEPaXr8wBPlh2tzPC9q4z/0Wy7Ci29beYhkA/2Ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QNpGhUjJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QNpGhUjJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D4F61F00A3D;
	Wed,  9 Sep 2026 00:52:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788915123;
	bh=6zK2ThAjOMxu4OBo0FXEm5LLuzr5FF88U5UQakBFh3M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QNpGhUjJIjZ1U5R/r8ta5k1DSOuzxtXRRbOozHTZ17ycxHKyLSgjsckYo7JKhbu41
	 jU3A40ggDoOQDCGbdfPUHq8TegLsWWWdyZ6forxg7wYNt6N0WUJAwUDdLxb1ccXBsX
	 HwXUK/JX3ISnwNyGqnSamRUygEHrywGQVGtkwZYm5ynESFMff7uQTcg2Ta4T1xh9ib
	 ReJRVW5jK/zobagsPhlQYzNQARbTJHywisF5qnTwxWN6BXq2NNluapJXN8voXepLfZ
	 w/JKBPEo8RQz9P/S0VXAxGSeiQa8LTLsgdmc34BJpDRwohPW/ET+rKa8ETmJhJ/hC1
	 hwPLHrv80RfBA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/2] svcrdma: Reject oversized Read segments at decode time
Date: Tue,  8 Sep 2026 20:52:00 -0400
Message-ID: <20260909005201.804311-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090330-audacity-nutcase-5491@gregkh>
References: <2026090330-audacity-nutcase-5491@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

[ Upstream commit af6f0e06bed818ee7fc8b869915964410020a1c5 ]

The RPC/RDMA Read list decoder stores wire-supplied segment
lengths without validation. xdr_count_read_segments() checks
4-byte alignment for non-zero position values but does not
cap the segment length.

An oversized rs_length reaches svc_rdma_build_read_segment(),
which derives nr_bvec from it and can drive a large dynamic
bvec allocation before verifying that enough rq_pages remain.
If the post-allocation page-overrun guard fires, the freshly
acquired rw context is not returned, leaking the resource.

Reject any segment whose length exceeds the receive context's
page budget during Read list decoding, consistent with how
xdr_check_write_chunk() bounds Write segment counts against
rc_maxpages. Also return the rw context on the existing
post-allocation overrun path in svc_rdma_build_read_segment(),
keeping that defensive guard balanced.

Fixes: 5ee62b4a9113 ("svcrdma: use bvec-based RDMA read/write API")
Cc: stable@vger.kernel.org
Acked-by: Jeff Layton <jlayton@kernel.org>
Link: https://patch.msgid.link/20260526-rpc-kernel-bugs-v1-3-e251306ccca9@oracle.com
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Stable-dep-of: 0ca487abb3bd ("svcrdma: Reject Read lists that exceed the page budget")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/sunrpc/xprtrdma/svc_rdma_recvfrom.c | 2 ++
 net/sunrpc/xprtrdma/svc_rdma_rw.c       | 5 +++--
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c b/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
index 68a0aa627455d..30157636288eb 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
@@ -448,6 +448,8 @@ static bool xdr_count_read_segments(struct svc_rdma_recv_ctxt *rctxt, __be32 *p)
 
 		xdr_decode_read_segment(p, &position, &handle,
 					    &length, &offset);
+		if (length > rctxt->rc_maxpages << PAGE_SHIFT)
+			return false;
 		if (position) {
 			if (position & 3)
 				return false;
diff --git a/net/sunrpc/xprtrdma/svc_rdma_rw.c b/net/sunrpc/xprtrdma/svc_rdma_rw.c
index b3700c1478ea8..626e79a317678 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_rw.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_rw.c
@@ -766,7 +766,7 @@ static int svc_rdma_build_read_segment(struct svc_rqst *rqstp,
 		len -= seg_len;
 
 		if (len && ((head->rc_curpage + 1) > rqstp->rq_maxpages))
-			goto out_overrun;
+			goto out_put;
 	}
 
 	ret = svc_rdma_rw_ctx_init(rdma, ctxt, segment->rs_offset,
@@ -779,7 +779,8 @@ static int svc_rdma_build_read_segment(struct svc_rqst *rqstp,
 	cc->cc_sqecount += ret;
 	return 0;
 
-out_overrun:
+out_put:
+	svc_rdma_put_rw_ctxt(rdma, ctxt);
 	trace_svcrdma_page_overrun_err(&cc->cc_cid, head->rc_curpage);
 	return -EINVAL;
 }
-- 
2.53.0

