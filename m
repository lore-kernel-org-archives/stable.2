Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C34715867D0
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 18:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788890679; cv=none; b=Cx8sWVjkoe7VQyCbu5APWfl4u0fpAZDvItUGuHeBoNmyu91uSVBTA1WSuSNUYsZdzjhqji0S+3G9PFqBhY7CiO/5lSIBOMcJSFZmmeRO8KeeSvss+GgGBdr3ZiXv+ONYfrAdgdzV14NnAJfhhYSj0fyCV66yQBc8UlQmb+D8zkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788890679; c=relaxed/simple;
	bh=WhK7PDhS1yJ07yuJezX/NRTMEY0rFtCu8AOgrXK4nSo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZMITPIuPUNL2FiDzBzfZi9k9Z6u7mRbD6WGBCOAUNRjRpLQ5oVaK+8wOja2SFesv0e2qaRmJrpLN2mffIafbkfjQl8zMOFTKNc1bmV3nb9KCS3tCVvht3KNxcCT1THWExpZFcSLajAAPfXNNPakh6Ecf0mJMw+3dS2nZcT5etao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LXNVeZ6I; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LXNVeZ6I"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13C111F00A3E;
	Tue,  8 Sep 2026 18:04:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788890676;
	bh=F4iyfWRp0tcYltfMuInKSZTHoGMABx86rZHNzrZeyWk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LXNVeZ6I+yPdDh0ICGo921e4604WBAPC4Fi27BM1RHOv1rJsv1drlyAp8e4TUEQTV
	 +ta4XmOkaA6q4ncZcqaN8jqc9UUzfwLkUY9++pyjaebYmFlFc5/RkQv9KG/d1vQV7P
	 JkaOYCeM/K0WYuhOO0Zmq73Nx7DGhbHg4Uo+0Uf/d2RA58YTkRpCZAViivgP3tgau9
	 e0fbP989ehKMWPTp63BvCCMrUDtuwgi9mIjSPGWI9AT8iEC6R6o9eOQq15zQJyDINo
	 tOYBgFFtvjc+IZ3sRQfbs7ja39w7J2pGJW5fN2vG6LjhJgHho9E2vmEsWhT46eNDdC
	 03+1neezcsOsg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chris Mason <clm@meta.com>,
	Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 4/4] SUNRPC: svcauth_gss: enforce krb5 token minimum length
Date: Tue,  8 Sep 2026 14:04:32 -0400
Message-ID: <20260908180432.174786-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260908180432.174786-1-sashal@kernel.org>
References: <2026090352-bamboo-relic-6231@gregkh>
 <20260908180432.174786-1-sashal@kernel.org>
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
index afcfdb2f84b6c..77a61bdd1d5ed 100644
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

