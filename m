Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3B19552927
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 18:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788892928; cv=none; b=VNQT2uaDAoG9oQ+m9OKV0k8ELPtGWA8abOMsd8Xj/VinCGAB8CsgDI2i9JS5RZNlx3HnM5f8KHHo3jK8b8ZOVTvOaoGW4HboUVnqPppS6OPDQi+Lku9fzUIeLIV/TQ3dB+lvAyjfnkYUzwRBRlO+htMT3RQ8sJ0MLd9rZavNymE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788892928; c=relaxed/simple;
	bh=PUId6ryzReAPv6YxONUuo9syy+GrZscNiIt3b2z4kzE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IJDhO9l+1L/MXrdCuTs0PaAlXqrxN2OVqOOdprdv6ZVE7zKwV9f+yHrP78bhhC5UYMosUq7AzfSpBjGHPNnvFPSDZNgF3E6wSFtrWcd1QM6a+KPY5R6rDScKVOy5vZxyFLWeSi3vyoGvfmlFjb7ZsBFzlXAU+eHLFgRNWRWQBNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fE++YurN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fE++YurN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 354331F00A3E;
	Tue,  8 Sep 2026 18:42:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788892926;
	bh=1Oai4N2lrhQZmNX4yKYXFwfsi38ex/30M7dMB+vfXFE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fE++YurNet9Iw+cvVhghwQfDy6Z8c4yr/i3r/JXyODTkFCvDAfwo5QL7ypvQuUz2V
	 wwTwUIgxo2j8DkzgLFEKJwUnDUv3WKPfIl/7HIf4iiDiyvQkPLTK5cVrAgzTVB9Yz7
	 WrKsnMRndRqU333WyKhCtsT6k3Z9tPh9VnccA3SST5OdLVC7zq7jPeRaw5aY771/cM
	 X496VySxKoNJV2+p5GdS5auiSc1QuVmAXsrn7wtKDW8k1RXNSiswXi1holjNUeFhcy
	 WZk5iQimo2/rH8K1Cvi3c3trwuILAsV1CzMDabnc/S635L/VhGMUJRZ58kQReNESLH
	 mbNLhP47B4zKQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chris Mason <clm@meta.com>,
	Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 4/4] SUNRPC: svcauth_gss: enforce krb5 token minimum length
Date: Tue,  8 Sep 2026 14:42:02 -0400
Message-ID: <20260908184202.249958-4-sashal@kernel.org>
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

From: Chris Mason <clm@meta.com>

[ Upstream commit a919c5c88769cf8fb3ec071e6078d830bf512489 ]

svcauth_gss_unwrap_priv() validates only an upper bound on the
wire-supplied opaque length before handing the buffer to
gss_unwrap():

    if (len > xdr_stream_remaining(xdr))
            goto unwrap_failed;
    offset = xdr_stream_pos(xdr);
    ...
    maj_stat = gss_unwrap(ctx, offset, offset + len, buf);

The wire value `len` flows unchanged as the upper bound into the
krb5 unwrap path, so a len in [0, 16] passes this check and is
handed to gss_unwrap(). For a krb5 v2 context that lands in
gss_krb5_unwrap_v2(), which reads the 16-byte RFC 4121 token
header fields at ptr+4 and ptr+6 and then calls rotate_left()
before any integrity check. With a sub-header length the header
reads run past the token, and _rotate_left()'s `shift %= buf->len`
path can divide by zero when buf->len has been driven to zero by
the truncated token. A header-only token (len == 16) is equally
invalid: with a non-zero RRC field and the opaque blob ending at
the XDR buffer boundary, rotate_left() builds a zero-length
subbuffer, reaching the same division.

Reject the token at the server entry point before it reaches the
krb5 unwrap core. A valid sealed RFC 4121 token must contain
the 16-byte header plus at least some encrypted payload.

Fix by adding a minimum-length check immediately after the
existing upper-bound check:

    if (len <= GSS_KRB5_TOK_HDR_LEN)
            goto unwrap_failed;

Fixes: 7c9fdcfb1b64 ("[PATCH] knfsd: svcrpc: gss: server-side implementation of rpcsec_gss privacy")
Cc: stable@vger.kernel.org
Assisted-by: kres (claude-opus-4-7)
Signed-off-by: Chris Mason <clm@meta.com>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Link: https://patch.msgid.link/20260524010213.557424-2-cel@kernel.org
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/sunrpc/auth_gss/svcauth_gss.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/sunrpc/auth_gss/svcauth_gss.c b/net/sunrpc/auth_gss/svcauth_gss.c
index 78f67a0725579..68504e62138bb 100644
--- a/net/sunrpc/auth_gss/svcauth_gss.c
+++ b/net/sunrpc/auth_gss/svcauth_gss.c
@@ -1001,6 +1001,8 @@ svcauth_gss_unwrap_priv(struct svc_rqst *rqstp, u32 seq, struct gss_ctx *ctx)
 	}
 	if (len > xdr_stream_remaining(xdr))
 		goto unwrap_failed;
+	if (len <= GSS_KRB5_TOK_HDR_LEN)
+		goto unwrap_failed;
 	offset = xdr_stream_pos(xdr);
 
 	saved_len = buf->len;
-- 
2.53.0

