Received: from mail-pl1-f228.google.com (mail-pl1-f228.google.com [209.85.214.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87A834B4867
	for <stable@vger.kernel.org>; Mon, 12 Oct 2026 17:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791824815; cv=none; b=HFBbkvYs3KvUJMmYCiKx+kCUDEmTIYNZIeCnI5OE+3WDKtPU4475oFf3SlfvS1Twxcgwd8WRC3khSdDRlCtCMOqOBclBgHNkN2tvbaICLrGC0g+yuiAJ9rs3yDSrIf2rCRbXklk6Je8UEsYDnQZ3ckqstbWkn6xah5TPpzzD81I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791824815; c=relaxed/simple;
	bh=EPixIYeaDTJUzgTZXc83KThsa5b/N5bbS7SL6I8CDGo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FKR6E8D9o27bITmLvKlYhwhwSpG5tSWdnScdPEANWz0FOod51/HgHBlt1FHw9jNebUBXGPWEQ261MqDzjL1bbfgKfSP6WSmvg1U4ZqwrIUChM6aph6VV315aMvH/KyFbptsvcKt2OWgMm71SWG4Ixp1rxSRn7fqqP+KroX0KpdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=everpuredata.com; spf=pass smtp.mailfrom=everpuredata.com; dkim=pass (2048-bit key) header.d=everpuredata.com header.i=@everpuredata.com header.b=ZVB9pv6T; arc=none smtp.client-ip=209.85.214.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=everpuredata.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=everpuredata.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=everpuredata.com header.i=@everpuredata.com header.b="ZVB9pv6T"
Received: by mail-pl1-f228.google.com with SMTP id d9443c01a7336-2e8d2574fd9so7985695ad.1
        for <stable@vger.kernel.org>; Mon, 12 Oct 2026 10:06:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=everpuredata.com; s=google; t=1791824813; x=1792429613; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/IgjKzde4XgZsr2/+7wKteu5cKKJitZwVLtvCdMyAM8=;
        b=ZVB9pv6TtL96WOhg8GFvYG0We++INA6sqtp0vrhDbcrJqoGUCddS/IyfSBcRa2st67
         E/v9NyB+ucP3DLLePDkTNeC01m/D5/Pq4hz+v+mu+xeeynxN9uvKkCIkUd5xYqizCe9H
         ii4ScO9qZZl/4W4AN5lolK9wOSaPq+IpFyyXp/MgxciHnlza6fLo/JmQQxZ51aEZloUt
         a4Dd2rb5f2reyKBgf9FZRp5BrKkaU5NRD9QP9DmLL14I/EVhC6sFqUjeCa9FV4jMaOyB
         WOu1JvYQaH0CgSVlLCFB5n7/yt3v199pQCAI0cCbLw/NX43jzfqk4sO1/2VqTmStFTWM
         wQPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791824813; x=1792429613;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/IgjKzde4XgZsr2/+7wKteu5cKKJitZwVLtvCdMyAM8=;
        b=xOuc05f/4g2NtUDxvJjJWwoFEAtbw/EzB46ZXje5cbyzyJTYyuQMuC41lNN7qGz++H
         gYCLKbXVphBoBe2vkkoOZxIT1E5EoTsJgYN7PgMz0jtPPxT48dn8KTcNszPJ/5WS+TMB
         2QEDw8RgCZ0uSZ53VUhWSE1HfoP9QkggFZwVK+QNFApBjHihFXPUuTg0UuNDW5iPpoiq
         x3tuUGtFh/pnVGEECGOFOzcd56j2TGpEC0yOdqBUhV6j2sngO2IN81+39LRw9o7JljiH
         Tyg6s922aU7c62MKQ0ZtU+ua5Fg0S19eRDRDRjtarApq6CjRlXFCy/od4whz3elEaudw
         nNHw==
X-Forwarded-Encrypted: i=1; AKwUvBwBmuMf0VxPmnIZEaNmOydwOp0R1h2nx/j2vJ+C6TTdobhqOd0PjQFqOaxd8eZKPA/x9iBd/iM=@vger.kernel.org
X-Gm-Message-State: AFq9FYK6wvWBpUeLoCiQJl2vtbtEhBprsDQqcPJwIKKaj5rlLn1U4KxX
	tM8FouEdu1KRWrLOeM7kz60/Ga2TTkTxzWbuccVLFr1TuJHP0PNmIhanUvDUOk6eFxAy9RWeTVC
	A0MhK2b6CSjydpNgTERgoxmXUcxJH1Prg2V50
X-Gm-Gg: AYBFou1CtQv+pC9Wjc/BTUtrha5eEsAjFCz64Aw4emGepiV7LP2OahyZ3iMmkST0B/2
	2QiocmsiuB7iZ+vgh4WQzfKwZxbomT7R3scBonDJhy6tNNtpncIgvdRv4cUse2B3iUA2uKfLEqO
	lJzfexB0aENoC+ksUjrGVj1/eBQavkl2f+ZrA8P9/C8H2iYlddr7HknMs/FjGqepB60LPiFfASB
	5zXdWLQeEIZTiBHWuz2O5462tRhB9G3ysghhQa6hhrI1kxU95IaN6fCN1N0sv/uO0UAxk0FF3jL
	Ihk2iHniUeX8TIWGr7bRHUoKajozWe5y5HDtsATfy25QC3llYFLaJA4NiLyd6GgflkvDm3FOLyd
	Y9cIwQz0+pD3qcr+qYtxAxM4LY1Mfcvam5RRlrdY=
X-Received: by 2002:a17:903:1b6d:b0:2db:39da:90f2 with SMTP id d9443c01a7336-2e84280aed6mr90652355ad.8.1791824812656;
        Mon, 12 Oct 2026 10:06:52 -0700 (PDT)
Received: from c14-smtp-2023.dev.purestorage.com ([208.88.158.129])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2e841f6aa74sm4097515ad.10.2026.10.12.10.06.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 10:06:52 -0700 (PDT)
X-Relaying-Domain: everpuredata.com
Received: from irdv-tmenninger.dev.purestorage.com (irdv-tmenninger.dev.purestorage.com [10.32.149.15])
	by c14-smtp-2023.dev.purestorage.com (Postfix) with ESMTPS id 841C43404CA;
	Mon, 12 Oct 2026 10:06:49 -0700 (PDT)
From: Tim Menninger <tmenninger@everpuredata.com>
To: linux-nfs@vger.kernel.org
Cc: Chuck Lever <cel@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	Trond Myklebust <trondmy@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Tom Talpey <tom@talpey.com>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	stable@vger.kernel.org,
	Yongjian Mu <ymu@everpuredata.com>,
	Jon Curley <jcurley@everpuredata.com>,
	Eric Badger <ebadger@everpuredata.com>,
	Shiva Lingappa <slingappa@everpuredata.com>
Subject: [PATCH v2] xprtrdma: trim head iovec when the payload arrives via a Write chunk
Date: Mon, 12 Oct 2026 17:06:19 +0000
Message-Id: <20261012170619.674785-1-tmenninger@everpuredata.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <e62ff502-be18-454e-8a64-80b366d477f4@app.fastmail.com>
References: <e62ff502-be18-454e-8a64-80b366d477f4@app.fastmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yongjian Mu <ymu@everpuredata.com>

The upper layer sets rq_rcv_buf.head[0].iov_len from its estimate of the
reply header size. For RPCSEC_GSS that estimate includes
auth->au_ralign, which gss_create_new() initializes to GSS_VERF_SLACK >>
2 (25 XDR words, or 100 bytes) and which is corrected to the real
verifier size only after the first reply on that rpc_auth has been
unwrapped. In this case, the krb5 MIC verifier is 36 bytes, so every
request encoded before the first reply completes has a head that is 64
bytes too long.

On TCP this is harmless: xdr_realign_pages() moves the excess head
bytes, which are genuine reply data, into the page list. With
RPC-over-RDMA and a Write chunk (sec=krb5, i.e. RPC_GSS_SVC_NONE, where
DDP is allowed), the payload has already been placed directly into the
page list, and the receive buffer holds only the inline part of the
reply. rpcrdma_inline_fixup() clamps its local copy of the head length
to the inline length but leaves head.iov_len untouched, so
xdr_realign_pages() still sees iov_len > cur and shifts whatever lies
past the inline reply in the receive buffer into the front of the
directly-placed payload:

  rpc_xdr_recvfrom:  head=[...,196] page=524288 tail=[...,64]
  rpc_xdr_alignment: nfsv4 READ offset=132 copied=64

The first 64 bytes returned by each such READ are incorrect (zeroed, or
shifted right by 64 bytes depending on the kernel's xdr_shrink_bufhead()
implementation). This is readily hit with pNFS flexfiles over RDMA and
sec=krb5: the per-DS rpc_clnt gets a fresh rpc_auth whose first RPC is a
large READ. Reads following the first completed reply return the
expected data.

Commit cb0ae1fbb2f5 ("xprtrdma: Do not update {head, tail}.iov_len in
rpcrdma_inline_fixup()") removed the head-length correction while fixing
the handling of pure-inline krb5p replies.

When a Write chunk conveyed the payload, trim head.iov_len (in both
rq_rcv_buf and rq_private_buf, which call_decode() expects to match) to
the inline length actually received so that the XDR layer does not
realign the page list. These READ replies have no trailing inline
fields, and the payload is already in the page list, so the upper
layer's head estimate can be safely reduced. Reduce buflen by the same
amount to avoid treating unused head capacity as additional tail
capacity. Pure inline replies and Reply chunk replies are unchanged.

Tested on Linux 6.8.0 and 7.3-rc4 with NFSv4.1 pNFS flexfiles over
RPC/RDMA and sec=krb5.

Fixes: cb0ae1fbb2f5 ("xprtrdma: Do not update {head, tail}.iov_len in rpcrdma_inline_fixup()")
Cc: stable@vger.kernel.org
Signed-off-by: Yongjian Mu <ymu@everpuredata.com>
Reviewed-by: Chuck Lever <cel@kernel.org>
Signed-off-by: Tim Menninger <tmenninger@everpuredata.com>
---
v2:
- Clarify why adjusting receive-buffer lengths is safe for Write chunks.
- Add testing note.
- Add Chuck's Reviewed-by.

Outstanding question from Chuck on v1:
> Anna/Trond, does the NFS client or XDR code rely on the reply-side kvec
> lengths staying as set during send preparation, or might there be an
> in-tree reader of head[0].iov_len on the post-receive path that I missed?

v1: https://lore.kernel.org/r/20261009181554.2280374-1-tmenninger@everpuredata.com/

 net/sunrpc/xprtrdma/rpc_rdma.c | 27 +++++++++++++++++++++++----
 1 file changed, 23 insertions(+), 4 deletions(-)

diff --git a/net/sunrpc/xprtrdma/rpc_rdma.c b/net/sunrpc/xprtrdma/rpc_rdma.c
index 1285f04cdac14..7e5713367291e 100644
--- a/net/sunrpc/xprtrdma/rpc_rdma.c
+++ b/net/sunrpc/xprtrdma/rpc_rdma.c
@@ -984,12 +984,16 @@ void rpcrdma_reset_cwnd(struct rpcrdma_xprt *r_xprt)
  * @rqst: controlling RPC request
  * @srcp: points to RPC message payload in receive buffer
  * @copy_len: remaining length of receive buffer content
- * @pad: Write chunk pad bytes needed (zero for pure inline)
+ * @writelist: bytes conveyed by the Write chunk (zero for pure inline)
  *
  * The upper layer has set the maximum number of bytes it can
  * receive in each component of rq_rcv_buf. These values are set in
  * the head.iov_len, page_len, tail.iov_len, and buflen fields.
  *
+ * For READ replies with a Write chunk, the payload is already in
+ * the page list. An overestimated head length and buflen can be
+ * reduced without moving reply data.
+ *
  * Unlike the TCP equivalent (xdr_partial_copy_from_skb), in
  * many cases this function simply updates iov_base pointers in
  * rq_rcv_buf to point directly to the received reply data, to
@@ -998,13 +1002,16 @@ void rpcrdma_reset_cwnd(struct rpcrdma_xprt *r_xprt)
  * Returns the count of bytes which had to be memcopied.
  */
 static unsigned long
-rpcrdma_inline_fixup(struct rpc_rqst *rqst, char *srcp, int copy_len, int pad)
+rpcrdma_inline_fixup(struct rpc_rqst *rqst, char *srcp, int copy_len,
+		     u32 writelist)
 {
 	unsigned long fixup_copy_count;
 	int i, npages, curlen;
 	char *destp;
 	struct page **ppages;
 	int page_base;
+	int pad = writelist & 3;
+	unsigned int delta;
 
 	/* The head iovec is redirected to the RPC reply message
 	 * in the receive buffer, to avoid a memcopy.
@@ -1016,8 +1023,20 @@ rpcrdma_inline_fixup(struct rpc_rqst *rqst, char *srcp, int copy_len, int pad)
 	 * head.iov_len bytes are copied into the page list.
 	 */
 	curlen = rqst->rq_rcv_buf.head[0].iov_len;
-	if (curlen > copy_len)
+	if (curlen > copy_len) {
+		/* These READ replies have no inline fields after the payload.
+		 * Trim the head without moving the directly-placed data.
+		 */
+		if (writelist) {
+			delta = curlen - copy_len;
+
+			rqst->rq_rcv_buf.head[0].iov_len = copy_len;
+			rqst->rq_private_buf.head[0].iov_len = copy_len;
+			rqst->rq_rcv_buf.buflen -= delta;
+			rqst->rq_private_buf.buflen -= delta;
+		}
 		curlen = copy_len;
+	}
 	srcp += curlen;
 	copy_len -= curlen;
 
@@ -1245,7 +1264,7 @@ rpcrdma_decode_msg(struct rpcrdma_xprt *r_xprt, struct rpcrdma_rep *rep,
 	base = (char *)xdr_inline_decode(xdr, 0);
 	rpclen = xdr_stream_remaining(xdr);
 	r_xprt->rx_stats.fixup_copy_count +=
-		rpcrdma_inline_fixup(rqst, base, rpclen, writelist & 3);
+		rpcrdma_inline_fixup(rqst, base, rpclen, writelist);
 
 	r_xprt->rx_stats.total_rdma_reply += writelist;
 	return rpclen + xdr_align_size(writelist);
-- 
2.34.1

