Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793818213;
	b=FF9gnHnnJ2wL4cmvF+5U9lixZMo5ueTsTaWu/2ebzal+G6mH0PTOOKZ1Ft48YgXHj6ZZ
	 nt44Adm+DxjS5uRPXzfqY9Dm/XLJ/u6NP6CueyjEoZW9QyOUtRAZrea+6HliY2BhC6brO
	 Aqf5lnW5XCSaYu5asFCtLXMO4KgLiMAs2mXdbs4Ybnw2emHDXRXy3CxUCFkDV/lmu3Bke
	 zU/+27PXEvfWorqKZodsD9SvNqQPuUdukk4m4ogQ+rf8JZZiPohj4jlqXY5z0p6yIqHsL
	 wAIL2jD7ZKCAExUS2wmwqFYt4otqBjCWxgpjg0TyaDf/xBf6TOsdfJ7+BYZxn9bF9lA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793818213;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=Xd9ZZ9MeRXFYa6PA/99k1PSgnESbHrdC1xYxEQiBRZA=;
	b=oL0mliQN8RfH6Bm9DEzqAn/JuHFbkNo5pqE37QFH1FgBP2jxFtKIUq6VxJe7nZniZ7yh
	 FlU3OqamFrqWGMOC4we0TyrZ8q023Cpg+O+PWQd54X+VH4X0l5YnXIEounqrevllKqclv
	 XB0CcxaCdt0o4Rq2AhPGlEyV+EbVbQkla5AuKzNtYcAZuPmgqAMgIqefTsEteLrHre1Vq
	 R2r8kOac3b4++P74b9Zlj6dEPey9llGJQIR95KPU0/z57geaw4qH3OEhTD2CQvH5w9R4n
	 QcRtgw8b1P8/+f+szgXpk+H28ygH6U/0JahBPn79DApeWd7oVoeQc0xJoq0vcEvSIfQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=kmCIphPG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49A8C606A32E
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 18:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=kmCIphPG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8FD61F0093A;
	Wed,  4 Nov 2026 18:50:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793818213;
	bh=Xd9ZZ9MeRXFYa6PA/99k1PSgnESbHrdC1xYxEQiBRZA=;
	h=Subject:To:Cc:From:Date;
	b=kmCIphPGkoFVYDKDTpf+xomqf2WbsU+MSnx333YbJKBxthFtRKmbZq4/UwSqbgZe1
	 LP7JamczTEb2wyi65DvpmL4i4Epuv9ko+nhUz56MSvzz2DogyBYlNDL93mcjSvEqu6
	 Pdm64GsNN+2B3aMVRXmy921hwXP9rFq/XxuskQ04=
Subject: FAILED: patch "[PATCH] nfsd: don't offer flexfiles layouts when NFSv3 isn't being" failed to apply to 6.6-stable tree
To: jlayton@kernel.org,cel@kernel.org,itsme@benjiwiebe.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 04 Nov 2026 13:50:10 -0500
Message-ID: <2026110410-chive-obtuse-db0b@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 5d28b2c920d9d9d3c45b41769342ad785eb372a7
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026110410-chive-obtuse-db0b@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 5d28b2c920d9d9d3c45b41769342ad785eb372a7 Mon Sep 17 00:00:00 2001
From: Jeff Layton <jlayton@kernel.org>
Date: Fri, 4 Sep 2026 12:11:37 -0400
Subject: [PATCH] nfsd: don't offer flexfiles layouts when NFSv3 isn't being
 served

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

diff --git a/fs/nfsd/nfs4layouts.c b/fs/nfsd/nfs4layouts.c
index 4187202f9acc..12acb68cbc3b 100644
--- a/fs/nfsd/nfs4layouts.c
+++ b/fs/nfsd/nfs4layouts.c
@@ -128,10 +128,12 @@ nfsd4_set_deviceid(struct nfsd4_deviceid *id, const struct svc_fh *fhp,
 
 void nfsd4_setup_layout_type(struct svc_export *exp)
 {
+	struct nfsd_net *nn = net_generic(exp->cd->net, nfsd_net_id);
 	struct super_block *sb = exp->ex_path.mnt->mnt_sb;
 	expfs_block_layouts_t block_supported = exportfs_layouts_supported(sb);
 
-	if (IS_ENABLED(CONFIG_NFSD_FLEXFILELAYOUT))
+	if (IS_ENABLED(CONFIG_NFSD_FLEXFILELAYOUT) &&
+	    nfsd_vers(nn, 3, NFSD_TEST))
 		exp->ex_layout_types |= 1 << LAYOUT_FLEX_FILES;
 	if (IS_ENABLED(CONFIG_NFSD_BLOCKLAYOUT) &&
 	    (block_supported & EXPFS_BLOCK_IN_BAND_ID))

