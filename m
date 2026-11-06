Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793968659;
	b=adJJUFePU/6o2XuUGPlRT9eovJlR0BLZbOBZm0lEssMms/F48jISjajA1tW9r28uitRs
	 4rViZhGq8U3C7lU1fTpLg9BlrH8E4IOSSYDTdxeYAVk3X/4WUz+ODmbrLEczpiepNbtg8
	 sTsaSbEWZhHJvidbcXpasgix634eJ/bWY9thYm7rYbwpEkvkkVuIHKmqrEbAcSmZnGuLg
	 q1Gf5Ec7pXR+5+b7L07HOQ3WE39Ww/V9Q9GLUvqpdMCf8dmtOoWfyXJPkpvtfdKSSkW0b
	 3U+K2OLPc8NecBNV1Y3K8aBUzAXZzTglwFTP/F/YTDKesawua19jgGueH/+qL0qkLYA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793968659;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=qHyxky5NohyRVFO7KavpxPaA5IcKeTiZF/rNJo5Yvt0=;
	b=VWTi2a9R02X7V8TEcjmFRgITJGhir7HsVtqkUvmUaUhxj7vHkz5hFAUhzbmhmBy0XsSF
	 OyKV+51/wd9WWsclQlciQ8kJt49X3zePS/67c2YU1Aepn40Sf1n1g+6sgFBd5I1N6rQsI
	 i2FduAff/69twY1NYnAXkdOCDUQmjq3IFDcWVepyGIPxbvSUD3zt6EVZnlZ84hGCogXMY
	 vWWXXeTuoyr+gj6uzAR9EVyIiXxogYf8zSxjdPRKp7qkniJE7dfIEws76/bmVEkVboIkT
	 FojbSqGSkEO+lR1IHKa1sI2DIL+he7GljvR65T1tJQhc7IQxz3haSWvJy0fqlXT+8Vg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=A6gFdd+v;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21268606A326
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 12:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=A6gFdd+v
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C5A81F0089F;
	Fri,  6 Nov 2026 12:37:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793968658;
	bh=qHyxky5NohyRVFO7KavpxPaA5IcKeTiZF/rNJo5Yvt0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=A6gFdd+vyhj6dCG1/VJCD/XzyyMp/1VB/AOI1owuc2RUwBHZPO4IDXIRbWkQK09ze
	 p71BoBIJdTYGLDkmcnkPX7HzOO+tdbZgdT0S8pYLRpsaA5PFJ13TsWnEBkGpCbeN7L
	 Ap7/K3ELvbgNpDaGM2CapJr37L0MA5PybE0sEOZ4G4T3I+JqSL8xjDhxcIO2CVUcR2
	 7e/HzNYVGCgNuFoT/hWPXg9vRSYGftxIRp/+8IDtV4Y9kewAQXn+3F/1Y9/XiR7ddL
	 lyRmGqe4ZloOA0ZVmwZAt2t/Nnp/7PbygIbFYg8G4wzJIpAF/X0bQ0VX7+E7ivT7zl
	 6apcJckOSFw2Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Benji Wiebe <itsme@benjiwiebe.com>,
	Chuck Lever <cel@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] nfsd: don't offer flexfiles layouts when NFSv3 isn't being served
Date: Fri,  6 Nov 2026 07:37:37 -0500
Message-ID: <20261106123622.3999119-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110410-chive-obtuse-db0b@gregkh>
References: <2026110410-chive-obtuse-db0b@gregkh>
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
[ sashal: replaced the existing CONFIG_NFSD_FLEXFILELAYOUT preprocessor guard instead of extending an IS_ENABLED() check ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfsd/nfs4layouts.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/nfsd/nfs4layouts.c b/fs/nfsd/nfs4layouts.c
index bea7513a0de90..821e7ab13211d 100644
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

