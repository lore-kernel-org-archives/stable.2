Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCD262E7378
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 18:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788892926; cv=none; b=CszWpc8ePXPGtHbuvjIKov7SPnefmyMl9jiU+IwVXDmji2/nqUy/2lcISngOu+GHYRh+Ya5lDDfNVdHi7eEcvWa3punPn++59Y88tgqdZ5H/j4U1nWNuEGV+NUm0G0FCd1kTFTHKw9auOqH3SvVhAQ2JNR2qyWLgRUgVnoMX9Rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788892926; c=relaxed/simple;
	bh=m2R9v0CsywumD4lYr/tZkHqe7bk2jl74ZEfS5QZmyyk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aKaGK1+DMGokgXgc1dfWwDti50bT8BXqCsZhFVEBvYKsS4+Hgqc0pVN49YvVwAUNdOW+qQbMlWuX0qbDsPYBt1f9ppvmswibAn86IBbSFcdLZgj7WJD5izX2G2t3eB5w1wqYvSs8FpJXRhYuDnSW6UCS4tdd6Ca0eQv6stSwYmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HtE429hP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HtE429hP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5BB71F00A3A;
	Tue,  8 Sep 2026 18:42:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788892924;
	bh=dO8+QRPCGc6tsY+dU6oUEnFcwcKrhqxtIVEl9FMWUX0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HtE429hPTuA0kTdhtqiMhNoG2I8AAT6P2oURL6tn559308dlN4taEQCVExVQ0W2z6
	 LxthuZnzxToOS/2EFtFhZ7Fuig+Fr3wmn9WslmKaoSMXrZ7zavWGhytz9CkINcpFkj
	 y7qVIgFezzVGiWTAB+gcIcO7fgM5fjUPUG4ohYdkkWE2fQGKNUdk830tSZI7x4L5GT
	 UpPqffhCODEl/QlUx5FRrmoyggXKQ/D3NKR/R4dxcu/cW38BZ6hQOmIzk0JJB8tKMl
	 gH0Ll2aNMXg4rclLSZRf1fJZedLPRlEe3t/0rH4nnoOhFf+NHigcqKVo3/kPrDsHJg
	 TDrTiyVzYV+IQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 1/4] SUNRPC: Fix crasher in unwrap_integ_data()
Date: Tue,  8 Sep 2026 14:41:59 -0400
Message-ID: <20260908184202.249958-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090353-ogle-atop-5025@gregkh>
References: <2026090353-ogle-atop-5025@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

[ Upstream commit 4dd9daa9124aad3c3d4ceca4f1d417cc62d59156 ]

If a zero length is passed to kmalloc() it returns 0x10, which is
not a valid address. gss_verify_mic() subsequently crashes when it
attempts to dereference that pointer.

Instead of allocating this memory on every call based on an
untrusted size value, use a piece of dynamically-allocated scratch
memory that is always available.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Stable-dep-of: a919c5c88769 ("SUNRPC: svcauth_gss: enforce krb5 token minimum length")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/sunrpc/auth_gss/svcauth_gss.c | 55 ++++++++++++++++++-------------
 1 file changed, 32 insertions(+), 23 deletions(-)

diff --git a/net/sunrpc/auth_gss/svcauth_gss.c b/net/sunrpc/auth_gss/svcauth_gss.c
index fe85762dbd966..5b3a75f1b3816 100644
--- a/net/sunrpc/auth_gss/svcauth_gss.c
+++ b/net/sunrpc/auth_gss/svcauth_gss.c
@@ -49,11 +49,36 @@
 #include <linux/sunrpc/svcauth.h>
 #include <linux/sunrpc/svcauth_gss.h>
 #include <linux/sunrpc/cache.h>
+#include <linux/sunrpc/gss_krb5.h>
 
 #include <trace/events/rpcgss.h>
 
 #include "gss_rpc_upcall.h"
 
+/*
+ * Unfortunately there isn't a maximum checksum size exported via the
+ * GSS API. Manufacture one based on GSS mechanisms supported by this
+ * implementation.
+ */
+#define GSS_MAX_CKSUMSIZE (GSS_KRB5_TOK_HDR_LEN + GSS_KRB5_MAX_CKSUM_LEN)
+
+/*
+ * This value may be increased in the future to accommodate other
+ * usage of the scratch buffer.
+ */
+#define GSS_SCRATCH_SIZE GSS_MAX_CKSUMSIZE
+
+struct gss_svc_data {
+	/* decoded gss client cred: */
+	struct rpc_gss_wire_cred	clcred;
+	/* save a pointer to the beginning of the encoded verifier,
+	 * for use in encryption/checksumming in svcauth_gss_release: */
+	__be32				*verf_start;
+	struct rsc			*rsci;
+
+	/* for temporary results */
+	u8				gsd_scratch[GSS_SCRATCH_SIZE];
+};
 
 /* The rpcsec_init cache is used for mapping RPCSEC_GSS_{,CONT_}INIT requests
  * into replies.
@@ -885,13 +910,11 @@ read_u32_from_xdr_buf(struct xdr_buf *buf, int base, u32 *obj)
 static int
 unwrap_integ_data(struct svc_rqst *rqstp, struct xdr_buf *buf, u32 seq, struct gss_ctx *ctx)
 {
+	struct gss_svc_data *gsd = rqstp->rq_auth_data;
 	u32 integ_len, rseqno, maj_stat;
-	int stat = -EINVAL;
 	struct xdr_netobj mic;
 	struct xdr_buf integ_buf;
 
-	mic.data = NULL;
-
 	/* NFS READ normally uses splice to send data in-place. However
 	 * the data in cache can change after the reply's MIC is computed
 	 * but before the RPC reply is sent. To prevent the client from
@@ -915,11 +938,9 @@ unwrap_integ_data(struct svc_rqst *rqstp, struct xdr_buf *buf, u32 seq, struct g
 	/* copy out mic... */
 	if (read_u32_from_xdr_buf(buf, integ_len, &mic.len))
 		goto unwrap_failed;
-	if (mic.len > RPC_MAX_AUTH_SIZE)
-		goto unwrap_failed;
-	mic.data = kmalloc(mic.len, GFP_KERNEL);
-	if (!mic.data)
+	if (mic.len > sizeof(gsd->gsd_scratch))
 		goto unwrap_failed;
+	mic.data = gsd->gsd_scratch;
 	if (read_bytes_from_xdr_buf(buf, integ_len + 4, mic.data, mic.len))
 		goto unwrap_failed;
 	maj_stat = gss_verify_mic(ctx, &integ_buf, &mic);
@@ -930,20 +951,17 @@ unwrap_integ_data(struct svc_rqst *rqstp, struct xdr_buf *buf, u32 seq, struct g
 		goto bad_seqno;
 	/* trim off the mic and padding at the end before returning */
 	xdr_buf_trim(buf, round_up_to_quad(mic.len) + 4);
-	stat = 0;
-out:
-	kfree(mic.data);
-	return stat;
+	return 0;
 
 unwrap_failed:
 	trace_rpcgss_svc_unwrap_failed(rqstp);
-	goto out;
+	return -EINVAL;
 bad_seqno:
 	trace_rpcgss_svc_seqno_bad(rqstp, seq, rseqno);
-	goto out;
+	return -EINVAL;
 bad_mic:
 	trace_rpcgss_svc_mic(rqstp, maj_stat);
-	goto out;
+	return -EINVAL;
 }
 
 static inline int
@@ -1021,15 +1039,6 @@ unwrap_priv_data(struct svc_rqst *rqstp, struct xdr_buf *buf, u32 seq, struct gs
 	return -EINVAL;
 }
 
-struct gss_svc_data {
-	/* decoded gss client cred: */
-	struct rpc_gss_wire_cred	clcred;
-	/* save a pointer to the beginning of the encoded verifier,
-	 * for use in encryption/checksumming in svcauth_gss_release: */
-	__be32				*verf_start;
-	struct rsc			*rsci;
-};
-
 static int
 svcauth_gss_set_client(struct svc_rqst *rqstp)
 {
-- 
2.53.0

