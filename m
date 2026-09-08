Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 497524A0157
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 17:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788890151; cv=none; b=brwqoDemNLyMoDqDQHVFn7bnhrVhX1pSYXl51mQ77WH33VCBQbXv4R9QaYL/zqnd065upZ0z5e0dAPIRbojFbl+roidY48vfTe1ZbXe9or0C/Vi9k6ivF7c7dfIHtUlvlGSFdDYFJY1HEhfvNlkdka8QNO/Sz0dcRsODuxcjFcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788890151; c=relaxed/simple;
	bh=HGfwBkxP4n+2PLVf5k4QgXmPyCHAbXQX5AupK1DU0a4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xkc1YRz40N5QjXe6rQ4GCYKzy487D3KCQcOHozDuK0Z+WNfhN7/YhEM7xYVcTprKXg+aH/hoPr6b5tqze4wFL20J2ziisvZHXZFZvhOtUEsxno7RtT3aJ0CWswHn05GO7cQD+88/mp0cyp8vOFUfnfw7U4s6FhenK9Uqqqiq2zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jo+ND/nm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jo+ND/nm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A3EC1F00A3E;
	Tue,  8 Sep 2026 17:55:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788890150;
	bh=hGcR4GswoFaVKnQRUoWVg3mtuMzrAi7O7z32u1gmVGA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Jo+ND/nmIPR6msdAKn3f/oOEjQFWuKHrTFfI2ADgTexjBqiXxasNsMBxE0EgJDgVZ
	 1qvTQ73KJTHLr9IoHX/Pj0m7tFQTipFrP8nJx2GbImoTEqViWzA1geIqvDASUAV7vM
	 +ENzkXK6/LfC06mFhrGKUdNnhyolF3zd4rIIglnMf0GZ1hjK3gM+J1fFpcbUG+4CWG
	 XJoe/QUALN6PqGG7Syl6x/B0sD0B1ZWaXSmsLhrGxk6LawAJxlzXybFoIIfAPDtBpR
	 zbyWHGNwHkECYMiDtDZZYtCvV0ewfV3aE9L+moj8DUp5rnTpUVn00vOpGp1fc2P/e0
	 4Ahrwsed2zNZw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chris Mason <clm@meta.com>,
	Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 4/4] SUNRPC: svcauth_gss: enforce krb5 token minimum length
Date: Tue,  8 Sep 2026 13:55:45 -0400
Message-ID: <20260908175545.152676-4-sashal@kernel.org>
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
index 74c1c17c7984f..c8c33f02a7ede 100644
--- a/net/sunrpc/auth_gss/svcauth_gss.c
+++ b/net/sunrpc/auth_gss/svcauth_gss.c
@@ -1003,6 +1003,8 @@ svcauth_gss_unwrap_priv(struct svc_rqst *rqstp, u32 seq, struct gss_ctx *ctx)
 	}
 	if (len > xdr_stream_remaining(xdr))
 		goto unwrap_failed;
+	if (len <= GSS_KRB5_TOK_HDR_LEN)
+		goto unwrap_failed;
 	offset = xdr_stream_pos(xdr);
 
 	saved_len = buf->len;
-- 
2.53.0

