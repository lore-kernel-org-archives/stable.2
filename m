Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55084598C08
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 18:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788892927; cv=none; b=YquGh6hCQ+Wh+fMrHtZvBrfHwA5sbJXlgOGvYe3B+lDlC9UJb7iqdpul3Vuv5uHg9EvtvNo/MVuOQ/oj9oCrCQ3DgBVDv56ckKs40tUeXkPF9SrOuoZpqIwQaEgccf+eXrjhMpBvkOBEq/Th5S2k9t8Fl2PEqm1nttUL/qaS1sA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788892927; c=relaxed/simple;
	bh=1pD7jG6iFl3jR3DgXHSESBL3NdnVeEt56el2UJCvVq8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V84xJjimvTYykrxkt7258jBDvDy56wUUoZrjOso2LN30dDNo79KWUXOCDouwlngeBrvwdPhVs+9fekk1MLuuVsCDTjaYoY0+5fr77bm0Y/of4hu4tyEoFoUO1ahbPdKBVJ9DKvDJrvs+kShNHXNEYIMqKZAF095FPpa434qdml4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RtEcYAJQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RtEcYAJQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 712CA1F00AC4;
	Tue,  8 Sep 2026 18:42:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788892925;
	bh=1MFvz1ayQLR5s55l3F6QMMB6/z75KXzdrGRNkiyRH+Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RtEcYAJQNQtJUTWqbIYtAKuHGGfJomvmlhbO0IUJjEb65o/RkqEgmZZOUxz8Dhpvw
	 6iuZ+6Gf2Wn8idKHDxWnm8e9hcA99qqAXz3sO99Yz6cP2io4bVtR9wALJgR9NEd7c2
	 PMM8gb4wQanhPnCEagjumcVXqHq+eqATdKmKqbWGZL0Gh1eFVOK0lHUpBTWC7622nJ
	 Qqg3QzFj4T0GCe/yN2FSfqZKD9B2wkamwouFst6aOvGXyHGxo2FFzQHYBtHXFNisaW
	 DyHXGBh5hYs5kENkpD6O+v8idCAWcT6bQv+ShnPxXgggqjZadig7l3K1xGjYEZ4/mP
	 bKZdVyU2t11xQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 3/4] SUNRPC: Convert unwrap_priv_data() to use xdr_stream
Date: Tue,  8 Sep 2026 14:42:01 -0400
Message-ID: <20260908184202.249958-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260908184202.249958-1-sashal@kernel.org>
References: <2026090353-ogle-atop-5025@gregkh>
 <20260908184202.249958-1-sashal@kernel.org>
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

[ sashal: Reduced backport -- upstream 42140718ea26c touches 3 file(s), this
  backport carries 1. Not backported here:
  include/linux/sunrpc/xdr.h
  net/sunrpc/xdr.c
  This note is generated from the file lists only; see the resolution record
  for the reasoning. ]

Stable-dep-of: a919c5c88769 ("SUNRPC: svcauth_gss: enforce krb5 token minimum length")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/sunrpc/auth_gss/svcauth_gss.c | 64 ++++++++++---------------------
 1 file changed, 21 insertions(+), 43 deletions(-)

diff --git a/net/sunrpc/auth_gss/svcauth_gss.c b/net/sunrpc/auth_gss/svcauth_gss.c
index b9674a77b048a..78f67a0725579 100644
--- a/net/sunrpc/auth_gss/svcauth_gss.c
+++ b/net/sunrpc/auth_gss/svcauth_gss.c
@@ -970,17 +970,6 @@ total_buf_len(struct xdr_buf *buf)
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
@@ -993,49 +982,37 @@ fix_priv_head(struct xdr_buf *buf, int pad)
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
@@ -1663,8 +1640,9 @@ svcauth_gss_accept(struct svc_rqst *rqstp)
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
-- 
2.53.0

