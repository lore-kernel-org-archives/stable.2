Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793971626;
	b=3/jhImvlW3BH0h0tE5kV6X5hKDPqqg0yWmSgsRC0o3P9aLby19eR+mUCJzELBFut4K1t
	 yeuuqrBrVceTu4mmLKOWQ3CzocpK72kc/eVmSTHc3v1zWlxDYCHRFJ9yhlhoMe+hoMs2s
	 9Omt4f5Ee9Ptr2bvjK7IQw9sAXskFQ9wc5jqALYCsie81au2kuYwjdYX79KxSJj9Ctv6T
	 +kjOtJTD1ren/FcSkAhXIukiy9K1OF8IP7CPmS31pvk+2CMyWEl6MNkD9yr+2iWyIGt8V
	 zE+wHj8YrCm8pB6dy51JZxRbBoflb2aEr/htIsdoh7k1tuKtkSYJScAEtaBdZdLQBvA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793971626;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=OhWpIhS6debfOWOV4SOsz97OTmkfoZwtd8CFM+Vsbn4=;
	b=gmT9jcYOoZN+J34o0eekZTiVTojmrSL4G0nKnPXtOO4GrbGq064T0bUIJ0FqZEnYlcsb
	 gcsLh+b798XEPjFjuGsc7Cmhy0nX9OOLZ0ioNTLB9315snd+HPWhmzz+IxsYvcQFdIHgY
	 WdoHmZyDc0HQwKT/OrKz/P15GasqPNW5I8YUegd9CyIMAG45ZVBu9RTl8yzeg2wBN0PbZ
	 f/HGlH7Zd0n/qF8dBv5NknK/UOSnZxbNCd8TQDRQccysuHWTelqaS/7vACcUNlVLXMtgH
	 LBPCnbQqLe/ZI4quuMRbEmL6bIMfCJdoR2av5IStpsG4j9IIke069PMM+4OFZeZGLrA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="J/V29XH4";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEE4C606A32F
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 13:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=J/V29XH4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8E9D1F008A1;
	Fri,  6 Nov 2026 13:27:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793971625;
	bh=OhWpIhS6debfOWOV4SOsz97OTmkfoZwtd8CFM+Vsbn4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=J/V29XH4NddaTBCAcFKKyKi4WpaWJ9/ADGl31qtZT1CSzAYi94t9ixmaPNcSU+IR3
	 yN7+wY2/5+ENwumMkmcgwKF3N8gA9DLdfIogR3qnqm0WOMzbDvHsKfCY9pmiugvGGn
	 bdMhAFwL4pUPdnt0ibrGcSjryuE7U1mtdNvTRFCLp7LO7yBRN0ksoQKLQVV8CA0ZXO
	 XgVCzzfF6vM8naI6RSD9xcxv3X8B2ck9/yoiQ6SPlenGIwHKbijvGs60BJ7f1Tpoe5
	 mn7Lzrxh4N3KMS+Wh9NtmITXakuIChStpVXZHuWi7w5FITMmxqx4vXdTnedSKzA5tm
	 tfERpx8v7v7Og==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Benji Wiebe <itsme@benjiwiebe.com>,
	Chuck Lever <cel@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] nfsd: don't offer flexfiles layouts when NFSv3 isn't being served
Date: Fri,  6 Nov 2026 08:27:03 -0500
Message-ID: <20261106132629.17942-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110411-frequency-agency-61c8@gregkh>
References: <2026110411-frequency-agency-61c8@gregkh>
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
[ sashal: adapted the flexfiles condition to replace an existing preprocessor guard instead of an IS_ENABLED() check ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfsd/nfs4layouts.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/nfsd/nfs4layouts.c b/fs/nfsd/nfs4layouts.c
index 03c8e71d1974a..747f28deb80c4 100644
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

