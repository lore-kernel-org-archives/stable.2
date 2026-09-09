Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB7DB2E7F39
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 01:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788917482; cv=none; b=FwvRIOHZ0cSZRSDt8At8dmHAWRD9jT6p9cRN/ueJryOzACvvftuwlzij1xg5Ildsf38iwKukEp93bdNv3vgR8z/PHpffiouK5Qlv1SS5FwjEwd3aCJ3CT6JNSsUMjzjyJO0mNfIr8jW3AfU+zpeYVovfbH5EzQX4W1p6AzyZwAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788917482; c=relaxed/simple;
	bh=p6I/chCTruzzPD+X6JooA2jYoTcUV906LNP/+wB/HMY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UOqh3M1ksEOP2f7Yqa7/MvB3XX/LyR6+8uo3Fq1JoI/94K/lmerzLPLbmiOKAMY5li81Qo0sw6qkXurd13xlZOeH5diov20Vc3Wn6FUlx6FDDjqe3zknd3o0PWeQFPyKz1OkeuyrJHWFV45J0hjqztWU82JquHQ4dLOcX/qwyoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NClad9rX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NClad9rX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23D211F00AC4;
	Wed,  9 Sep 2026 01:31:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788917480;
	bh=sL/nhLJQBzfp1HBDn6QI/yF1qOBPDRPvfzb9A0xbnO0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NClad9rX3IFC+bHmVYGYwolXMzz5AFB/oudp1y9QF6K4Ba0K1M381wmTOft2gesNm
	 fp+kDbOJ1Bf+fCBoHRCBFQi3914PMwi2aGO2Lc4qCj6zn6oec8AivfIgUOvYZ5THxZ
	 k/p+1rRwlVLXhC/J8Xn6wZSQEwBbAgaxYDwx7LAF2rgLY4lJ2WkAiSaJfcccHPKggi
	 qgzFSIrc3fWq0HEumaUDJMD+CqgmkZQ7HpcrpCOkrU6TLiepKYwkeCJ8k5bC9scHH4
	 PyZ7BCS3pV6vAk89K9bfffqc5ukN2juNA65f3S/HLnXCZ+GQiJboF94fyenihLgEU2
	 7po+ZzQ8//+uQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chris Mason <clm@meta.com>,
	Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 4/4] svcrdma: Reject Write/Reply chunks with segcount 0
Date: Tue,  8 Sep 2026 21:31:16 -0400
Message-ID: <20260909013116.888180-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260909013116.888180-1-sashal@kernel.org>
References: <2026090343-customize-gorgeous-909c@gregkh>
 <20260909013116.888180-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chris Mason <clm@meta.com>

[ Upstream commit 9808eb7656666acc7291bae9ab6b987bd16e47e0 ]

A peer can send a Write or Reply chunk whose segcount field is zero.
xdr_check_write_chunk() only rejects segcount > rc_maxpages, so zero
passes the range check, and xdr_inline_decode(stream, 0) returns the
current (non-NULL) cursor without advancing. The function returns
true and pcl_alloc_write() then links a struct svc_rdma_chunk with
ch_segcount == 0 onto rc_write_pcl or rc_reply_pcl.

An earlier patch in this series made pcl_for_each_segment() safe for
ch_segcount == 0, so this no longer drives the memory walk it used
to. Rejecting the malformed frame at the decode boundary is still
worthwhile as defense in depth: it keeps degenerate zero-segment
chunks off the parsed chunk lists entirely, so any future consumer
that walks ch_segments directly cannot observe one, and it makes the
zero-floor easy to backport to trees where the macro change is more
intrusive. RFC 8166 has no meaning for a Write/Reply chunk that
describes no remote buffer, so no legitimate client is affected.

xdr_check_reply_chunk() funnels Reply chunks through
xdr_check_write_chunk() and inherits the same rejection.

pcl_alloc_write() also links each chunk onto the parsed chunk list
before filling its segment array. If a future change weakens the
segcount-0 rejection, an incomplete chunk is visible to consumers
during the fill loop. Reorder so that list_add_tail() follows the
segment fill loop, ensuring only fully-populated chunks appear on
the list.

Fixes: 78147ca8b4a9 ("svcrdma: Add a "parsed chunk list" data structure")
Cc: stable@vger.kernel.org
Assisted-by: kres (claude-opus-4-7)
Signed-off-by: Chris Mason <clm@meta.com>
Acked-by: Jeff Layton <jlayton@kernel.org>
Link: https://patch.msgid.link/20260526-rpc-kernel-bugs-v1-5-e251306ccca9@oracle.com
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/sunrpc/xprtrdma/svc_rdma_pcl.c      | 2 +-
 net/sunrpc/xprtrdma/svc_rdma_recvfrom.c | 9 ++++++---
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/net/sunrpc/xprtrdma/svc_rdma_pcl.c b/net/sunrpc/xprtrdma/svc_rdma_pcl.c
index b63cfeaa29234..a1c61311714da 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_pcl.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_pcl.c
@@ -213,7 +213,6 @@ bool pcl_alloc_write(struct svc_rdma_recv_ctxt *rctxt,
 		chunk = pcl_alloc_chunk(segcount, 0);
 		if (!chunk)
 			return false;
-		list_add_tail(&chunk->ch_list, &pcl->cl_chunks);
 
 		for (j = 0; j < segcount; j++) {
 			segment = &chunk->ch_segments[j];
@@ -225,6 +224,7 @@ bool pcl_alloc_write(struct svc_rdma_recv_ctxt *rctxt,
 			chunk->ch_length += segment->rs_length;
 			chunk->ch_segcount++;
 		}
+		list_add_tail(&chunk->ch_list, &pcl->cl_chunks);
 	}
 	return true;
 }
diff --git a/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c b/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
index 7214a3a7e1b83..f2a21bc1701ce 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
@@ -488,10 +488,13 @@ static bool xdr_check_write_chunk(struct svc_rdma_recv_ctxt *rctxt)
 		return false;
 
 	/* Before trusting the segcount value enough to use it in
-	 * a computation, perform a simple range check. This is an
-	 * arbitrary but sensible limit (ie, not architectural).
+	 * a computation, perform a simple range check. A zero
+	 * segcount describes no remote buffer and is rejected so
+	 * downstream consumers never see a degenerate ch_segcount==0
+	 * chunk. The upper bound is an arbitrary but sensible limit
+	 * (ie, not architectural).
 	 */
-	if (unlikely(segcount > rctxt->rc_maxpages))
+	if (segcount == 0 || unlikely(segcount > rctxt->rc_maxpages))
 		return false;
 
 	p = xdr_inline_decode(&rctxt->rc_stream,
-- 
2.53.0

