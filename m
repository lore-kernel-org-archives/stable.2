Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 586614BB5CA
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 14:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788445929; cv=none; b=K2p1D8mJsDa7IN73DRiPf8WUPxesYAfbW+13It8CA17MQCUuQTdp37oTgjlQ6rmU7XvZV2mS75EIWPn32x820JFIbuL5lIoP/SAqL9iFAI7c1OPk2d/nHATOKbvvejzkdVgw2sd/jLOo2hjziRmoc8RSvuiD0BtjIwST4Z8dzTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788445929; c=relaxed/simple;
	bh=egg7w1EuYi/CtB2cIeVGD74mLn+2pwcJjzPPC28V3e4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=oeFuTrqzNdIN/+qc2xPl+BRlO5WYyyEit335ZS7Ph8uOhcX5A/nQaUde1Q0/qepnSNEu8kM3BHApZjVfzk9yus1LxwT7S6k8BBpRwIL8oJrxDj+Lax2Ln5h+bphF3FpgbxcSV4wVV5jzsSVm2iyvNEecCVlmAr6lLG6/q6oZFX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UhzdgSpo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UhzdgSpo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE4A31F00A3D;
	Thu,  3 Sep 2026 14:31:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788445917;
	bh=4oIyOcGtyXX8WXdpIoL+nak8eUNarkXUkLGTB1qwxDE=;
	h=Subject:To:Cc:From:Date;
	b=UhzdgSpoMXuVdXhXARBlTUdvcexAX7eVnv77egq8cQ9T9p+VRm25aYnSgw9bhShpJ
	 S1NHxTRpX5bVdvRNG6tkuonFMEu9iGMXv3oJGteXIaCzbVdEDSR3XMCGC/ZAlKTGXb
	 YYbx8WyiCO1vI9MCOjU1usX2gHIq0D/DfsGwuKLI=
Subject: FAILED: patch "[PATCH] svcrdma: Reject Write/Reply chunks with segcount 0" failed to apply to 5.15-stable tree
To: clm@meta.com,chuck.lever@oracle.com,jlayton@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 03 Sep 2026 16:10:44 +0200
Message-ID: <2026090344-perfume-python-398c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 9808eb7656666acc7291bae9ab6b987bd16e47e0
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090344-perfume-python-398c@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 9808eb7656666acc7291bae9ab6b987bd16e47e0 Mon Sep 17 00:00:00 2001
From: Chris Mason <clm@meta.com>
Date: Tue, 26 May 2026 09:35:59 -0400
Subject: [PATCH] svcrdma: Reject Write/Reply chunks with segcount 0

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

diff --git a/net/sunrpc/xprtrdma/svc_rdma_pcl.c b/net/sunrpc/xprtrdma/svc_rdma_pcl.c
index 1f8f7dad8b6f..18d1045799ce 100644
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
index 15c1d8ae5301..f6a7533a7555 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
@@ -510,10 +510,13 @@ static bool xdr_check_write_chunk(struct svc_rdma_recv_ctxt *rctxt)
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

