Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78C6D5921EF
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 17:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788890150; cv=none; b=dVgoLCISpb2CgJywu7dTp/y9PFj/sJHB4MXT+CGoiBvbz/adA7JTh6O9koiaeC8vb8CRan3D4PVCj0bf/Q7P/W196ziifXBSGVQksUe37Wc8Y7ig+TcqkT1uVo0Zy0faxyInieoIQcGFEdiE9EZWqgQdiRCDxgL6rclXARKhCgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788890150; c=relaxed/simple;
	bh=IgM+x0TV7Pn9gGvFH9a+Cr+vrH7sZ68tB1uVWJYng4Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OJ+pl+CL8z4HS0o2QtId8T10AsxnQYd18T/Sp5hSYI7q33IBuv6DyhqzdsGNG6taTgAsAhGwL51YldehalPeDth5NjYdhtX1JlTX+NlVPqxx+75tH2EeD8OYRPUSZ8QMBFW3TyIo/KuDsHSsLiHl/BM+CQuJtu8IO0KOq2GyPxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ld3jS8v6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ld3jS8v6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9D851F00A3D;
	Tue,  8 Sep 2026 17:55:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788890149;
	bh=SgiGRDfr0wmEbzv8ETUCHVuLaCniDcadMn6wmraYtOM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Ld3jS8v6obMFQiqvQnsBpQ4lqRRuU3+g0X80i3WUpQe2YyzNTOMfpyGBHL5NIvCAC
	 NJ07irjxI3ixRoEcfAIBnnStAy58QsjSGcAx+C7/6rGFS8E8wE4xKvxB4vT89N7sGE
	 WJmcPbDLrewBndRPag13ZENFIZP+l2284vL9uZ5Cuyv2QDDO3ynfbbCwR/QfCguiYG
	 DGr+yM7IitoZ/Nl9NaCDkoEsSFuPRilg/+OXzDrFpik7CzMBqJNfCIjda4uc5dwWcP
	 RiUA3x93x/R1aaUUWuFDbA+PvxQ9TMDTXyAFx3ISJQs2SHzyqHvP8BkZlpi+6nEGaf
	 OyVXEWNEDACBg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 3/4] SUNRPC: Convert unwrap_priv_data() to use xdr_stream
Date: Tue,  8 Sep 2026 13:55:44 -0400
Message-ID: <20260908175545.152676-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260908175545.152676-1-sashal@kernel.org>
References: <2026090352-custard-sports-0e17@gregkh>
 <20260908175545.152676-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

[ Upstream commit 42140718ea26c47fb06c679451a6aa6703545136 ]

Done as part of hardening the server-side RPC header decoding path.

Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Stable-dep-of: a919c5c88769 ("SUNRPC: svcauth_gss: enforce krb5 token minimum length")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/sunrpc/xdr.h        |  1 -
 net/sunrpc/auth_gss/svcauth_gss.c | 64 ++++++++++---------------------
 net/sunrpc/xdr.c                  |  7 ----
 3 files changed, 21 insertions(+), 51 deletions(-)

diff --git a/include/linux/sunrpc/xdr.h b/include/linux/sunrpc/xdr.h
index f84e2a1358e17..f7e2850c8638f 100644
--- a/include/linux/sunrpc/xdr.h
+++ b/include/linux/sunrpc/xdr.h
@@ -188,7 +188,6 @@ xdr_adjust_iovec(struct kvec *iov, __be32 *p)
 /*
  * XDR buffer helper functions
  */
-extern void xdr_shift_buf(struct xdr_buf *, size_t);
 extern void xdr_buf_from_iov(const struct kvec *, struct xdr_buf *);
 extern int xdr_buf_subsegment(const struct xdr_buf *, struct xdr_buf *, unsigned int, unsigned int);
 extern void xdr_buf_trim(struct xdr_buf *, unsigned int);
diff --git a/net/sunrpc/auth_gss/svcauth_gss.c b/net/sunrpc/auth_gss/svcauth_gss.c
index 13ca9621588fe..74c1c17c7984f 100644
--- a/net/sunrpc/auth_gss/svcauth_gss.c
+++ b/net/sunrpc/auth_gss/svcauth_gss.c
@@ -972,17 +972,6 @@ total_buf_len(struct xdr_buf *buf)
 	return buf->head[0].iov_len + buf->page_len + buf->tail[0].iov_len;
 }
 
-static void
-fix_priv_head(struct xdr_buf *buf, int pad)
-{
-	if (buf->page_len == 0) {
-		/* We need to adjust head and buf->len in tandem in this
-		 * case to make svc_defer() work--it finds the original
-		 * buffer start using buf->len - buf->head[0].iov_len. */
-		buf->head[0].iov_len -= pad;
-	}
-}
-
 /*
  * RFC 2203, Section 5.3.2.3
  *
@@ -995,49 +984,37 @@ fix_priv_head(struct xdr_buf *buf, int pad)
  *		proc_req_arg_t arg;
  *	};
  */
-static int
-svcauth_gss_unwrap_priv(struct svc_rqst *rqstp, struct xdr_buf *buf, u32 seq,
-			struct gss_ctx *ctx)
+static noinline_for_stack int
+svcauth_gss_unwrap_priv(struct svc_rqst *rqstp, u32 seq, struct gss_ctx *ctx)
 {
-	u32 len, seq_num, maj_stat;
-	int pad, remaining_len, offset;
+	struct xdr_stream *xdr = &rqstp->rq_arg_stream;
+	u32 len, maj_stat, seq_num, offset;
+	struct xdr_buf *buf = xdr->buf;
+	unsigned int saved_len;
 
 	clear_bit(RQ_SPLICE_OK, &rqstp->rq_flags);
 
-	len = svc_getnl(&buf->head[0]);
+	if (xdr_stream_decode_u32(xdr, &len) < 0)
+		goto unwrap_failed;
 	if (rqstp->rq_deferred) {
 		/* Already decrypted last time through! The sequence number
 		 * check at out_seq is unnecessary but harmless: */
 		goto out_seq;
 	}
-	/* buf->len is the number of bytes from the original start of the
-	 * request to the end, where head[0].iov_len is just the bytes
-	 * not yet read from the head, so these two values are different: */
-	remaining_len = total_buf_len(buf);
-	if (len > remaining_len)
+	if (len > xdr_stream_remaining(xdr))
 		goto unwrap_failed;
-	pad = remaining_len - len;
-	buf->len -= pad;
-	fix_priv_head(buf, pad);
-
-	maj_stat = gss_unwrap(ctx, 0, len, buf);
-	pad = len - buf->len;
-	/* The upper layers assume the buffer is aligned on 4-byte boundaries.
-	 * In the krb5p case, at least, the data ends up offset, so we need to
-	 * move it around. */
-	/* XXX: This is very inefficient.  It would be better to either do
-	 * this while we encrypt, or maybe in the receive code, if we can peak
-	 * ahead and work out the service and mechanism there. */
-	offset = xdr_pad_size(buf->head[0].iov_len);
-	if (offset) {
-		buf->buflen = RPCSVC_MAXPAYLOAD;
-		xdr_shift_buf(buf, offset);
-		fix_priv_head(buf, pad);
-	}
+	offset = xdr_stream_pos(xdr);
+
+	saved_len = buf->len;
+	maj_stat = gss_unwrap(ctx, offset, offset + len, buf);
 	if (maj_stat != GSS_S_COMPLETE)
 		goto bad_unwrap;
+	xdr->nwords -= XDR_QUADLEN(saved_len - buf->len);
+
 out_seq:
-	seq_num = svc_getnl(&buf->head[0]);
+	/* gss_unwrap() decrypted the sequence number. */
+	if (xdr_stream_decode_u32(xdr, &seq_num) < 0)
+		goto unwrap_failed;
 	if (seq_num != seq)
 		goto bad_seqno;
 	return 0;
@@ -1665,8 +1642,9 @@ svcauth_gss_accept(struct svc_rqst *rqstp)
 			/* placeholders for length and seq. number: */
 			svc_putnl(resv, 0);
 			svc_putnl(resv, 0);
-			if (svcauth_gss_unwrap_priv(rqstp, &rqstp->rq_arg,
-						    gc->gc_seq, rsci->mechctx))
+			svcxdr_init_decode(rqstp);
+			if (svcauth_gss_unwrap_priv(rqstp, gc->gc_seq,
+						    rsci->mechctx))
 				goto garbage_args;
 			rqstp->rq_auth_slack = RPC_MAX_AUTH_SIZE * 2;
 			break;
diff --git a/net/sunrpc/xdr.c b/net/sunrpc/xdr.c
index 336a7c7833e49..4b21a519fa9bb 100644
--- a/net/sunrpc/xdr.c
+++ b/net/sunrpc/xdr.c
@@ -863,13 +863,6 @@ static unsigned int xdr_shrink_pagelen(struct xdr_buf *buf, unsigned int len)
 	return shift;
 }
 
-void
-xdr_shift_buf(struct xdr_buf *buf, size_t len)
-{
-	xdr_shrink_bufhead(buf, buf->head->iov_len - len);
-}
-EXPORT_SYMBOL_GPL(xdr_shift_buf);
-
 /**
  * xdr_stream_pos - Return the current offset from the start of the xdr_stream
  * @xdr: pointer to struct xdr_stream
-- 
2.53.0

