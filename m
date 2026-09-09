Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D26AB3D9DDB
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 10:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788948955; cv=none; b=guRl2Koi1hNDtg0/AeMkbQUG/aXIXqGZFat/WXhSoOXBd9fA2+fy0qDY8UBWOtCjU8n4FT1ekAvXR1vAvncmV76Jla9RMBJUILTzDRQIfz3R7SD8u29iDuuwpJjYydyvpke/Ldo/dxYHhpDkAD7B9OnQn7iaVClEGAdxSsY9XiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788948955; c=relaxed/simple;
	bh=nL35mhJuXAbWLnWtkbIK9IXbyFYEo6A8liarO3nAY0o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uWQcpwc9MIBb9ucczdIPMtPdqArqhrmm7TwGhz9QCajWRdSN38F/y8oKs32cQmpRlqdLfBBHvHiFQQQHDw3yXVdXwcl1LhFvY1kXctX/rXM9O6zxqQomd/JhYXcew9/JZn3vSvpoOW7xwqfs9OSLJQdCPkL+7m/JICZMvv9TcEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D+4bFO+S; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D+4bFO+S"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E3741F00ADF;
	Wed,  9 Sep 2026 10:15:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788948939;
	bh=fXXyPSeTWSyIlMSHPjUfnqkpwNji04He5JmziYpqHNg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=D+4bFO+S5GkUbYhABgcy3nOho/h+DXOFVZc0U0fdGUeeFpmfHMjULOxbneT61nWzv
	 2+3RoPO0r5tIscDApP8tyIv9sKmyRSq/fAztyfUiZGf4Z+rbMsl+BX9MRw50tIQxRC
	 DHsoD7UBlTAR6WL+PBTkevND7v3CNBuX7UE7kAFuGuuNH9OkZnBsfzXLH012xDUrbB
	 3mdME3+m/ie3SfGF6Ovy2MdiG8/mT9VHhjYQjo1mA81Q0PqyHx420Nyxn7WAZ8kugC
	 GYZhzm2L/bfUb0QkYqvmVVq1z/NOqFuXQFsEhGZ7cqYgFR9uBCIejP9ZsQKzHHrydc
	 XHfIioS91R/tg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chris Mason <clm@meta.com>,
	Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 3/3] svcrdma: Reject Write/Reply chunks with segcount 0
Date: Wed,  9 Sep 2026 06:15:36 -0400
Message-ID: <20260909101536.1481226-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260909101536.1481226-1-sashal@kernel.org>
References: <2026090344-perfume-python-398c@gregkh>
 <20260909101536.1481226-1-sashal@kernel.org>
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
index 7d3b8fea9c682..e59336a2b4042 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
@@ -487,10 +487,13 @@ static bool xdr_check_write_chunk(struct svc_rdma_recv_ctxt *rctxt)
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

