Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CA79513576
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 18:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788892926; cv=none; b=QnQCSnenSEXtaKgHmo7r80s02RsyQ/uHh1fzxngOL/g3NN1QSh+863dquLZ3uoN89J5eitZWPVYNueu8JOjq+ZMSF7uMHm/xTG9kszwDodBDvCLmHq5ifSxO6aaCU+MjPUfxiQtwcaykeUAW6DWobd0/iaCoDPTh8u8Y7pAnaTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788892926; c=relaxed/simple;
	bh=960R3On5DPcf747SeQDSE3ks33vBLLNxv5hWLUIheE0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H8tusqiv3p9dlLt9X/LVr9NXvDexfpvMLTpMS0G9cylla/7E6g2lfNVaMnR27d0YqwTXRIcyjWD1F3yRcWRWwBcWOLytFd2EcxQ/kyxKdAPlLjmPawpzpp3BSg9bs5Qjz1U/Grrolsk/pfmbI+F4n5qpERhY8kGZKxJKjVkI0DU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kuLPkkz5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kuLPkkz5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEF1A1F00A3F;
	Tue,  8 Sep 2026 18:42:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788892925;
	bh=bi+czyzazEk8XQiMm4mtRp4sSep8uo3KUT8qrdVL0N8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kuLPkkz5LREyknZBpi6TfJf1t0HFIFrP5qyLv6MgUKQx/B8icZiEGC517TEmxNUmK
	 /0F9FgD0ir2V/9wmVSSmJ10bHp/Wc/M11Ng8g/+XNiS9Ao/P7iKBJStcbZ0RSpbqxY
	 sE2h4+9bJNL6K+9F/qYOLjNjXuGb1K6xc5RvvMywMRUu4WbW/oa/fzNeIO9I1QYmdN
	 nMCIc91e7ta70acAsxorNbNuMkNszVnRIov5PIlXPsNCzwl0loSWr8wEvm2K323XZ5
	 1BjS5o0Mn9UlRq+sqjAakP0PBxru+MnVetfRwMwTdgsMbySz2DOYpjA7vOS7JcJKH5
	 qIc2qmtm/Lssg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 2/4] SUNRPC: Rename automatic variables in unwrap_priv_data()
Date: Tue,  8 Sep 2026 14:42:00 -0400
Message-ID: <20260908184202.249958-2-sashal@kernel.org>
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

[ Upstream commit f4a59e822f8116baf51a9fc86590e4391bd542d2 ]

Clean up: To help orient readers, name the stack variables to match
the XDR field names.

Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Stable-dep-of: a919c5c88769 ("SUNRPC: svcauth_gss: enforce krb5 token minimum length")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/sunrpc/auth_gss/svcauth_gss.c | 38 ++++++++++++++++++++-----------
 1 file changed, 25 insertions(+), 13 deletions(-)

diff --git a/net/sunrpc/auth_gss/svcauth_gss.c b/net/sunrpc/auth_gss/svcauth_gss.c
index 5b3a75f1b3816..b9674a77b048a 100644
--- a/net/sunrpc/auth_gss/svcauth_gss.c
+++ b/net/sunrpc/auth_gss/svcauth_gss.c
@@ -981,16 +981,28 @@ fix_priv_head(struct xdr_buf *buf, int pad)
 	}
 }
 
+/*
+ * RFC 2203, Section 5.3.2.3
+ *
+ *	struct rpc_gss_priv_data {
+ *		opaque databody_priv<>
+ *	};
+ *
+ *	struct rpc_gss_data_t {
+ *		unsigned int seq_num;
+ *		proc_req_arg_t arg;
+ *	};
+ */
 static int
-unwrap_priv_data(struct svc_rqst *rqstp, struct xdr_buf *buf, u32 seq, struct gss_ctx *ctx)
+svcauth_gss_unwrap_priv(struct svc_rqst *rqstp, struct xdr_buf *buf, u32 seq,
+			struct gss_ctx *ctx)
 {
-	u32 priv_len, maj_stat;
+	u32 len, seq_num, maj_stat;
 	int pad, remaining_len, offset;
-	u32 rseqno;
 
 	clear_bit(RQ_SPLICE_OK, &rqstp->rq_flags);
 
-	priv_len = svc_getnl(&buf->head[0]);
+	len = svc_getnl(&buf->head[0]);
 	if (rqstp->rq_deferred) {
 		/* Already decrypted last time through! The sequence number
 		 * check at out_seq is unnecessary but harmless: */
@@ -1000,14 +1012,14 @@ unwrap_priv_data(struct svc_rqst *rqstp, struct xdr_buf *buf, u32 seq, struct gs
 	 * request to the end, where head[0].iov_len is just the bytes
 	 * not yet read from the head, so these two values are different: */
 	remaining_len = total_buf_len(buf);
-	if (priv_len > remaining_len)
+	if (len > remaining_len)
 		goto unwrap_failed;
-	pad = remaining_len - priv_len;
+	pad = remaining_len - len;
 	buf->len -= pad;
 	fix_priv_head(buf, pad);
 
-	maj_stat = gss_unwrap(ctx, 0, priv_len, buf);
-	pad = priv_len - buf->len;
+	maj_stat = gss_unwrap(ctx, 0, len, buf);
+	pad = len - buf->len;
 	/* The upper layers assume the buffer is aligned on 4-byte boundaries.
 	 * In the krb5p case, at least, the data ends up offset, so we need to
 	 * move it around. */
@@ -1023,8 +1035,8 @@ unwrap_priv_data(struct svc_rqst *rqstp, struct xdr_buf *buf, u32 seq, struct gs
 	if (maj_stat != GSS_S_COMPLETE)
 		goto bad_unwrap;
 out_seq:
-	rseqno = svc_getnl(&buf->head[0]);
-	if (rseqno != seq)
+	seq_num = svc_getnl(&buf->head[0]);
+	if (seq_num != seq)
 		goto bad_seqno;
 	return 0;
 
@@ -1032,7 +1044,7 @@ unwrap_priv_data(struct svc_rqst *rqstp, struct xdr_buf *buf, u32 seq, struct gs
 	trace_rpcgss_svc_unwrap_failed(rqstp);
 	return -EINVAL;
 bad_seqno:
-	trace_rpcgss_svc_seqno_bad(rqstp, seq, rseqno);
+	trace_rpcgss_svc_seqno_bad(rqstp, seq, seq_num);
 	return -EINVAL;
 bad_unwrap:
 	trace_rpcgss_svc_unwrap(rqstp, maj_stat);
@@ -1651,8 +1663,8 @@ svcauth_gss_accept(struct svc_rqst *rqstp)
 			/* placeholders for length and seq. number: */
 			svc_putnl(resv, 0);
 			svc_putnl(resv, 0);
-			if (unwrap_priv_data(rqstp, &rqstp->rq_arg,
-					gc->gc_seq, rsci->mechctx))
+			if (svcauth_gss_unwrap_priv(rqstp, &rqstp->rq_arg,
+						    gc->gc_seq, rsci->mechctx))
 				goto garbage_args;
 			rqstp->rq_auth_slack = RPC_MAX_AUTH_SIZE * 2;
 			break;
-- 
2.53.0

