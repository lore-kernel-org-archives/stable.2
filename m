Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D4104B66FC
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 14:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788445821; cv=none; b=tpHb9TjogOUcqNyCk47HShQmgD+0xXX52QAPObQqatYSvCJE0UT1fSlX35ZSdSG0bHS5W23yhItxuLRnks/icr1etqPZCnTRdop1UzmuKXIixY0BW+XTV0eTgXJt7WjwpEivm4zPGK8xbE9eBh/vXXuhH5fBj/gSG8uO//gcwWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788445821; c=relaxed/simple;
	bh=JJYv3tmVLMOtA+1Am7QJ0uyaPutKCkXeQjL8uwm31zA=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Iz4/vuscyi9NAyhP+Qi1EYP78TrdN91W8QDaRQZJ+RrSHaR5frLmC3wgyQT+65086nsOphFP98cznLazvp92zIN+fSEHGdY/VYIfIIfNN2UA+xG0XOa6Z3bQ5K9Wl9JJ/u4zHJBkeXUfC5zeyP8X3O2vH8FZIpZjnX4PLabp/p4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=deD3+apj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="deD3+apj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A8581F00ACF;
	Thu,  3 Sep 2026 14:30:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788445801;
	bh=NwIMoS5qxA8paXaeGMn1UoBctoIHYgwzA2HDXUyOLRc=;
	h=Subject:To:Cc:From:Date;
	b=deD3+apj/7q5Sk/gduzYlhPROAJ73lG5Z9hUHm8agOPy7ohTvJLOIuLkPKLfHvSMl
	 7y9PaUNPK6TGTNld4V+m2vleVcwEmSAo+ruv3zVn6JOTLZ5kHaMW4vBaJvPeBYutuD
	 joDKqVsr9MUntrPuWx7EocsDFy0SXzD3pubVmR7U=
Subject: FAILED: patch "[PATCH] SUNRPC: svcauth_gss: enforce krb5 token minimum length" failed to apply to 5.10-stable tree
To: clm@meta.com,chuck.lever@oracle.com,jlayton@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 03 Sep 2026 16:05:53 +0200
Message-ID: <2026090353-ogle-atop-5025@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
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
git cherry-pick -x a919c5c88769cf8fb3ec071e6078d830bf512489
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090353-ogle-atop-5025@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From a919c5c88769cf8fb3ec071e6078d830bf512489 Mon Sep 17 00:00:00 2001
From: Chris Mason <clm@meta.com>
Date: Sat, 23 May 2026 21:02:10 -0400
Subject: [PATCH] SUNRPC: svcauth_gss: enforce krb5 token minimum length

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

diff --git a/net/sunrpc/auth_gss/svcauth_gss.c b/net/sunrpc/auth_gss/svcauth_gss.c
index d14209031e18..8e8aceb31270 100644
--- a/net/sunrpc/auth_gss/svcauth_gss.c
+++ b/net/sunrpc/auth_gss/svcauth_gss.c
@@ -949,6 +949,8 @@ svcauth_gss_unwrap_priv(struct svc_rqst *rqstp, u32 seq, struct gss_ctx *ctx)
 	}
 	if (len > xdr_stream_remaining(xdr))
 		goto unwrap_failed;
+	if (len <= GSS_KRB5_TOK_HDR_LEN)
+		goto unwrap_failed;
 	offset = xdr_stream_pos(xdr);
 
 	saved_len = buf->len;

