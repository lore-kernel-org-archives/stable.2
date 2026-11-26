Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795658808;
	b=0WHOmrqnBO7SBLhgFCRwf0HUY6yuNl9WFGcZnA3PmajwSey6+i4St3CFrvUMmvbKR3mG
	 0iDbw2sj3I5mipBqXFKvajQvIui2h6BUqrSHONlLyRzlinku/f8P5eqLsCD9rh3Dkbg+f
	 FUJzR6KSU0mmm4K8Ta+MxX0mYmYDWn1Cy0f+UO/92DlrzukWBAo3r26ZpsglVyX9pGsmZ
	 5wPeL4LmMrXleBrFmK4KlP+qhFnjvg3mE7YIFbE/U6gnBtSFuUS4AGvD8r/gYQuGfIzjF
	 NWOyt5ejN/iHE9VsRuh5x3f950m56daSYe9qho9/nZFaSitDY8ICMxX5ZjmcbRSVcKA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795658808;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=eIOkheZQ8I82w1KZ/FdmCTRTBJwTMqhdDEHbLP9eaMM=;
	b=i6isBMIYaAkbizAbHwaSFAidlHAFI5lXNvO/8id7NwjuYGwQqjWGyQh2ve7OnRHwTb2H
	 Shrux/09Qr7ie+Wyis8dMdmhPN+PXQ6uVlj57hqm9GNaW5sxZUaGJ7IFntlzA85cllLeN
	 hAGwLZ0rSWBsMtZkbQRE6U1idRBLhc+5hlg4sFQG2ZtFASP9AhWnEnbqyeEDn5qg5GNDu
	 bXMWvYfaubnxJQ11aZrCzhmFgQKgiIM7cpdLY6Y9bDxwViTOdb4rB775zDMyIS5vCeVnQ
	 M5ttXCslIZAkuSqrQMSYsOYaXAeDaU0oiONgotQ+G2EkvlCgvHXGdYEMl6exqLWMHGg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LXc+wsxs;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B657606A31E
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 02:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LXc+wsxs
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77FF01F000C6;
	Thu, 26 Nov 2026 02:06:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795658808;
	bh=eIOkheZQ8I82w1KZ/FdmCTRTBJwTMqhdDEHbLP9eaMM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LXc+wsxsPz5POVhhZMKB6oPigAGYxEC17JNE3TdOlD+GLPik22R2wzR4ijpjbSHRp
	 jHGO/IA3qyPledlhAA7tmdeBAbZ+/qYl7Vz0QJEidPM/BSaC2T54h5TXTqjaAQ9q1i
	 WVSsPedmOEAUdhWfTMforEZ9MlFDP5oC7g3aa6HRd0lcLHSgaDsGx5tYNFo1GxT7kv
	 lnbBhhr2dFf89TXmlazoZym+8N/m2mthJsUo3nJH5evPQ/1pytVF28UbA4mEALeg2l
	 +p5R8+aGeAIbXPAfu2/BsEOeEe5tf4L8+0vHfXM8gSiMLVFwbEJRw/OhKk1KPHk6lL
	 9rf5w2pivoXlA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Amir Goldstein <amir73il@gmail.com>,
	Sashiko <sashiko-bot@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] ovl: do not read the flags of a put upper dentry in lookup
Date: Wed, 25 Nov 2026 21:06:46 -0500
Message-ID: <20261126020630.1762697-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112530-magnifier-quake-2b38@gregkh>
References: <2026112530-magnifier-quake-2b38@gregkh>
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

From: Amir Goldstein <amir73il@gmail.com>

[ Upstream commit 7031366be218f291592a7ad38bc34a7cd1459737 ]

ovl_lookup_layers() passes ctx->upperdentry to ovl_get_inode(), which
takes over the reference. If an overlay inode for the upper inode is
already cached, as for a second hard link, ovl_get_inode() puts the
dentry and returns the cached inode. ovl_lookup_layers() then passes
the put dentry to ovl_dentry_init_reval(), which reads its d_flags.

With a local upper fs the put dentry usually stays in the dcache, but
with a FUSE upper whose entry has timed out, dput() kills it, so this
is a use-after-free.

Fix this by taking the revalidate flags from the upper dentry of the
overlay inode, which is the one that ovl_dentry_revalidate_common()
revalidates.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/bug/linux-986db859-840c-479d-944c-b9c43b93377e
Fixes: bccece1ead36 ("ovl: allow remote upper")
Cc: stable@vger.kernel.org
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
[ sashal: Moved ovl_dentry_init_reval() into the upperdentry/ctr block using this tree's inline locals (upperdentry, inode) instead of the later-refactored ctx struct fields. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/overlayfs/namei.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/fs/overlayfs/namei.c b/fs/overlayfs/namei.c
index b932b3b7bcea0..71e9816fdde6b 100644
--- a/fs/overlayfs/namei.c
+++ b/fs/overlayfs/namei.c
@@ -1323,9 +1323,17 @@ struct dentry *ovl_lookup(struct inode *dir, struct dentry *dentry,
 
 		if (metacopy_size > OVL_METACOPY_MIN_SIZE)
 			ovl_set_flag(OVL_HAS_DIGEST, inode);
-	}
 
-	ovl_dentry_init_reval(dentry, upperdentry, OVL_I_E(inode));
+		/*
+		 * ovl_get_inode() puts upperdentry if it finds a cached
+		 * inode, e.g. for another hard link, so use the upper dentry
+		 * of the inode.
+		 */
+		ovl_dentry_init_reval(dentry, ovl_i_dentry_upper(inode),
+				      OVL_I_E(inode));
+	} else {
+		ovl_dentry_init_reval(dentry, NULL, NULL);
+	}
 
 	revert_creds(old_cred);
 	if (origin_path) {
-- 
2.53.0

