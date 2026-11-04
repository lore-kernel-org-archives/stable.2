Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793818500;
	b=vBXQ+D+I/q+/0qjeD4I6xB37x8Wonv9wKVNQSbocOhwaKFouwqyB6fWqck4NsZxhTqLT
	 JWyoyhSlloSq/pZzKaOHE88SyNwBjk1Sd47AXy1oMFc15g9debwU1+dSlizpVvrNuSI/y
	 ZR2fJ/xCqCyFPnJq0eg0ImBBRvLPkAJbw+RaWx7/ciolFqHFxaQB5vmZJbyC77YHCtY2S
	 XXsX8X1pg7+4Fl6iaA+YY7xn3vGV327cZCw5g733cJzb3UFnYNAkZ6B8U4q+fHWnzk6cS
	 sk2clay4FZv38SChmxMCCIx8eq38JTwFWsULb7AgWZg5xpXd33UPng8r4whRTNbL52Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793818500;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=caxoY3H4Kl4uMOmsCep8iCz3VP5lNQye4rUNwGHOUDk=;
	b=ttmZwb1Zing+AYOCGAKMwOZEiDWcmGzpPDjWQMUeJAiUW08lQaRLMCGh595hqpIrTL9L
	 CahPnfjFIMwJb5oUDv4flxr2aasSm32A8kxfaBKrcTDjo2EPV3YVj0daQuDbl5awAR380
	 du/fNkkVS1IWXgcMLTsZw/1rJp0wE+BDUHicPJ/u6FfTz2ritbU2Njvbn4CiZ3kl/XUBk
	 a13lYelmgDweDbN3m25WM7OIT+tTAXc6AzaLCRJF+7EDTStsE9exExCAOJTgcK2NKiTDz
	 FsJoBMllh8f8sB//ap1w+vxpSB4SnRdIF+MegSEoeGXhaHmi8E+6VI1LkbxvfONVN+A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=ONXPNdFG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75471606A33D
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 18:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=ONXPNdFG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D51B11F000C1;
	Wed,  4 Nov 2026 18:54:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793818500;
	bh=caxoY3H4Kl4uMOmsCep8iCz3VP5lNQye4rUNwGHOUDk=;
	h=Subject:To:Cc:From:Date;
	b=ONXPNdFG5+wmiU8Hdz5Hr1KGNFmc1y1X1Q0O2Sj/WG+CpzZ4hpLDnwUn0Ozb9EmRi
	 ghJJj4REaTy9rYVBeN+wZkzqjx3sLDLYfs5Yeu7/+IAqofojla9nV5Lg5j3YHTRhnL
	 kCwaxZoAVMmciNgdxU/wBoUYFnps+KmkZfeVIX5A=
Subject: FAILED: patch "[PATCH] SUNRPC: Copy the deferred RPC Call from the head buffer" failed to apply to 5.10-stable tree
To: cel@kernel.org,bug-report@moonshot.ai,yilinzhang@moonshot.ai
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 04 Nov 2026 13:54:58 -0500
Message-ID: <2026110458-walnut-distant-f403@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 2192a56b0686599358909c3e12e9a366f5b5d452
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026110458-walnut-distant-f403@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 2192a56b0686599358909c3e12e9a366f5b5d452 Mon Sep 17 00:00:00 2001
From: Chuck Lever <cel@kernel.org>
Date: Wed, 2 Sep 2026 09:31:01 -0400
Subject: [PATCH] SUNRPC: Copy the deferred RPC Call from the head buffer

svc_defer() snapshots the RPC Call for replay once a pending cache
upcall resolves. It copies the Call starting (rq_arg.len -
head[0].iov_len) bytes before head[0].iov_base, a back-up that once
covered a transport header. No transport has had one since commit
983084b2672c ("SUNRPC: Remove svc_rqst::rq_xprt_hlen"), so the two
lengths are meant to be equal.

An RPCSEC_GSS Call breaks that assumption. Unwrapping the integrity
service truncates rq_arg.len by the length of the trailing checksum,
and unwrapping the privacy service leaves rq_arg.len short by an
amount the client sets with trailing bytes after the wrap token.
Neither adjusts head[0].iov_len. Both lengths are size_t, so the
subtraction underflows and the copy starts past head[0].iov_base.
Every deferred integrity Call replays a shifted snapshot.

A deferred replay skips GSS verification, so a shifted snapshot runs
as an authenticated Call. With the privacy service the offset is
client-chosen. A forged Call placed in that window, naming another
user's GSS context handle, runs under that identity.

Copy the Call from head[0].iov_base. Refuse to defer a Call whose
length runs past the head buffer, so the copy cannot read out of
bounds.

Fixes: 260c1d1298f6 ("svc: Add transport hdr size for defer/revisit")
Cc: stable@vger.kernel.org
Reported-by: Kimi Security Team <bug-report@moonshot.ai>
Reported-by: Yilin Zhang <yilinzhang@moonshot.ai>
Link: https://patch.msgid.link/20260902133101.48914-1-cel@kernel.org
Signed-off-by: Chuck Lever <cel@kernel.org>

diff --git a/net/sunrpc/svc_xprt.c b/net/sunrpc/svc_xprt.c
index 68310521ddb9..d5634dd6d6cc 100644
--- a/net/sunrpc/svc_xprt.c
+++ b/net/sunrpc/svc_xprt.c
@@ -1299,13 +1299,8 @@ static void svc_revisit(struct cache_deferred_req *dreq, int too_many)
 }
 
 /*
- * Save the request off for later processing. The request buffer looks
- * like this:
- *
- * <xprt-header><rpc-header><rpc-pagelist><rpc-tail>
- *
- * This code can only handle requests that consist of an xprt-header
- * and rpc-header.
+ * Save the request off for later processing. Only a Call that fits
+ * entirely in rq_arg.head[0] can be deferred.
  */
 static struct cache_deferred_req *svc_defer(struct cache_req *req)
 {
@@ -1318,8 +1313,11 @@ static struct cache_deferred_req *svc_defer(struct cache_req *req)
 		dr = rqstp->rq_deferred;
 		rqstp->rq_deferred = NULL;
 	} else {
-		size_t skip;
 		size_t size;
+
+		if (rqstp->rq_arg.len > rqstp->rq_arg.head[0].iov_len)
+			return NULL;
+
 		/* FIXME maybe discard if size too large */
 		size = sizeof(struct svc_deferred_req) + rqstp->rq_arg.len;
 		dr = kmalloc(size, GFP_KERNEL);
@@ -1333,9 +1331,7 @@ static struct cache_deferred_req *svc_defer(struct cache_req *req)
 		dr->daddr = rqstp->rq_daddr;
 		dr->argslen = rqstp->rq_arg.len >> 2;
 
-		/* back up head to the start of the buffer and copy */
-		skip = rqstp->rq_arg.len - rqstp->rq_arg.head[0].iov_len;
-		memcpy(dr->args, rqstp->rq_arg.head[0].iov_base - skip,
+		memcpy(dr->args, rqstp->rq_arg.head[0].iov_base,
 		       dr->argslen << 2);
 	}
 	dr->xprt_ctxt = rqstp->rq_xprt_ctxt;
@@ -1358,17 +1354,13 @@ static noinline int svc_deferred_recv(struct svc_rqst *rqstp)
 
 	trace_svc_defer_recv(dr);
 
-	/* setup iov_base past transport header */
 	rqstp->rq_arg.head[0].iov_base = dr->args;
-	/* The iov_len does not include the transport header bytes */
 	rqstp->rq_arg.head[0].iov_len = dr->argslen << 2;
 	rqstp->rq_arg.page_len = 0;
-	/* The rq_arg.len includes the transport header bytes */
 	rqstp->rq_arg.len     = dr->argslen << 2;
 	rqstp->rq_prot        = dr->prot;
 	memcpy(&rqstp->rq_addr, &dr->addr, dr->addrlen);
 	rqstp->rq_addrlen     = dr->addrlen;
-	/* Save off transport header len in case we get deferred again */
 	rqstp->rq_daddr       = dr->daddr;
 	rqstp->rq_xprt_ctxt   = dr->xprt_ctxt;
 

