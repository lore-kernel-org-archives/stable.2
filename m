Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAAC14B5CA6
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 14:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788445923; cv=none; b=fImEVSGEPFy6ELEwkSNBvYqaci7ZhodrxQYB0iDDc1Ur2KZZzWM8DR73jqcxPBNKkyHQs/Vrc2+a9b1NpWABRMqXnJkLspdlymPCHlzE7jjKsl7lrL5FOwAUk1vd2/jFU+ql+g+Cv5xdgdhiqPiDLiIwBWNZJI2Nqi3TUuUaBXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788445923; c=relaxed/simple;
	bh=l1rB1xk0DW5z+iH+Et++RBKhZQmPQbmAN7jMrR06R8M=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Wiqx6Uh2LlZN4ZHwzZOl8T+dk62v38E3rGNZBvggZCvFJNpfsXrLN5mB3euNwQpnnr7JaBXGbt4rVYN1CDgeBYIfDXmGh860emipILxHA1JkozWs90zSzbNQt5ucBsCcfXFS8NnTyTZCIuQvzy9ywXDunsYBZcC3XbMRASH3Yb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TdqskCjg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TdqskCjg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 475F81F00A3E;
	Thu,  3 Sep 2026 14:31:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788445911;
	bh=mZAPlDX07dfhTzuksDI+nWrNM9vHjUqnuTv92g4QyhM=;
	h=Subject:To:Cc:From:Date;
	b=TdqskCjg+/gbQmDAu0t2Em76HG7AyhumeomsDYkUdT3MUT0l4UyWImE6uHVkaVyjB
	 eYk6EKHwHnPGVjfuUN8UA1hpUDHlnjwV6ExlnmFJGNkeRw4iCtcYoQwboB4DYrliZr
	 1qQ6xFM4I7ZM8xwesOvxMwlf1KUThADRpvAhpM0Q=
Subject: FAILED: patch "[PATCH] svcrdma: Reject Write/Reply chunks with segcount 0" failed to apply to 6.1-stable tree
To: clm@meta.com,chuck.lever@oracle.com,jlayton@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 03 Sep 2026 16:10:43 +0200
Message-ID: <2026090343-runway-amaretto-1501@gregkh>
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
git cherry-pick -x 9808eb7656666acc7291bae9ab6b987bd16e47e0
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090343-runway-amaretto-1501@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

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

