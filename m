Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793978410;
	b=xAOkN4+EuHtuN2NTT5a7wl/jpGfSM68XEB7VVy4fDdmnH4/uMxX22qH7yt8Z7NR9jhQH
	 nxKE4pRUBqMEErMBBJ4upFp1k/C0veNAGCu+oZrTZJnK+rFimRTBk3XG7ASY7hzPlGpZQ
	 xtStjYGY5m38bY+PkVkQiDu1a3Le8HoYoBUobHmL//j7pbiH/jBFz66xPxFeFnO1yxiAL
	 4xILoFfwc7COl4+kmfZuevGOgHtIc5ZxlL5ahpJtfa0eF0tVLVZ/3nro073UVkHHUU+QX
	 N5pG5TQZd1JKamB9jmSCfsMTZwTby3kw0L1fAMVgFaiisLu4WOwnU93VBhJLxYHmnQQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793978410;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=hWvvwbVBkfBpwPvgXHJxgIDb1kCg6ovHB+hmvjf4nYI=;
	b=OLkHS5glha0HkcQK6S57w7Bbh4u8Zvq+Gh2f9g0fUHt6fo2m9tZo2+sd2aE78zSY4Z5s
	 Fn2ok9qtaHoe0qZJxaK3rrbiB8hG1qjBj1rQchuGIE+W3QrbxZSNfYFrWZdR2HkYdOIe6
	 VNIWuBWS0k55WdBhT0EDvoK2WIYgHaHcrPL2mIkmGs2VJlOWVKtm77TKr+Q45q/iotipf
	 DqYdDWvG3i7YBO6c2YNRPApCojU5iOcNGEjeupvqUfOfoqvTQcwZH6F2Fc84xtw4JczEz
	 eUr2HWcqkU4OaYI4SJRH6Z5Q2yA3gYYX8X7/PFiGfrN1ZLFGI9BmzJDNaQmFkowttgQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="QTXbN/Jl";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0116606D816
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 15:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QTXbN/Jl
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEE901F008BD;
	Fri,  6 Nov 2026 15:20:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793978409;
	bh=hWvvwbVBkfBpwPvgXHJxgIDb1kCg6ovHB+hmvjf4nYI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QTXbN/JlV9SP/hPBuUcd7/DEmr2qhqubcYa4GoeLgA497sLQLx+mAYcU0ylbp5PpZ
	 LBamMOzK0nijBIDOSYriyMtp6GmYORnlfGxMW+3mkOck7TjRMY1dOpIT8N6/0PGi57
	 YrFXH9lTy7SX9aP6CMOVgvZVsosNf22LmWO3pFY/FfHMBrT2JMwCvb/1qadjENPZvP
	 Rb/FBYk25qRoVY1d1KK8Yf9QsTd5Wut0DQ363sf59XqoAaDFGtK4ouD4NUVPXq/BID
	 9ZbHw+GOSXcx7bLhP92J2eowCkFsnQGaPvOAN95ZANT1USJYOgHjbjIq6jyXDh4Wes
	 rT2RUrPEEmY2g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Benji Wiebe <itsme@benjiwiebe.com>,
	Chuck Lever <cel@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] nfsd: don't offer flexfiles layouts when NFSv3 isn't being served
Date: Fri,  6 Nov 2026 10:20:07 -0500
Message-ID: <20261106151922.367419-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110412-deodorize-departed-4d37@gregkh>
References: <2026110412-deodorize-departed-4d37@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jeff Layton <jlayton@kernel.org>

[ Upstream commit 5d28b2c920d9d9d3c45b41769342ad785eb372a7 ]

The flexfiles layout driver hands out a deviceinfo that names this server
as an NFSv3 DS (flexfilelayout.c hardcodes da->version = 3). With v3
disabled, the client can't talk to the DS: it loops on v3 NULL calls that
the server answers with PROG_MISMATCH, and I/O hangs in D state.

Skip LAYOUT_FLEX_FILES in nfsd4_setup_layout_type() unless v3 is enabled.

Reported-by: Benji Wiebe <itsme@benjiwiebe.com>
Closes: https://lore.kernel.org/linux-nfs/c734eeb8-8486-4491-bb4d-b9656cbaffbe@app.fastmail.com/
Fixes: 9b9960a0ca47 ("nfsd: Add a super simple flex file server")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Jeff Layton <jlayton@kernel.org>
Link: https://patch.msgid.link/20260904-pnfs-ff-v1-1-5f502cf25401@kernel.org
Signed-off-by: Chuck Lever <cel@kernel.org>
[ sashal: adapted the flexfiles condition to replace an #ifdef guard instead of extending an existing IS_ENABLED() check ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfsd/nfs4layouts.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/nfsd/nfs4layouts.c b/fs/nfsd/nfs4layouts.c
index bcf16dd07d488..f55092c66f42b 100644
--- a/fs/nfsd/nfs4layouts.c
+++ b/fs/nfsd/nfs4layouts.c
@@ -125,6 +125,7 @@ nfsd4_set_deviceid(struct nfsd4_deviceid *id, const struct svc_fh *fhp,
 
 void nfsd4_setup_layout_type(struct svc_export *exp)
 {
+	struct nfsd_net *nn = net_generic(exp->cd->net, nfsd_net_id);
 #if defined(CONFIG_NFSD_BLOCKLAYOUT) || defined(CONFIG_NFSD_SCSILAYOUT)
 	struct super_block *sb = exp->ex_path.mnt->mnt_sb;
 #endif
@@ -132,9 +133,9 @@ void nfsd4_setup_layout_type(struct svc_export *exp)
 	if (!(exp->ex_flags & NFSEXP_PNFS))
 		return;
 
-#ifdef CONFIG_NFSD_FLEXFILELAYOUT
-	exp->ex_layout_types |= 1 << LAYOUT_FLEX_FILES;
-#endif
+	if (IS_ENABLED(CONFIG_NFSD_FLEXFILELAYOUT) &&
+	    nfsd_vers(nn, 3, NFSD_TEST))
+		exp->ex_layout_types |= 1 << LAYOUT_FLEX_FILES;
 #ifdef CONFIG_NFSD_BLOCKLAYOUT
 	if (sb->s_export_op->get_uuid &&
 	    sb->s_export_op->map_blocks &&
-- 
2.53.0

