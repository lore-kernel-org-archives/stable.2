Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795659703;
	b=Jnr66rR/RDrDmKrFu4COz2ueCHXcaKB0wgqGvzTz+EMAk9qk7GTVf/giVV4+yHHPPXMG
	 9JyAJFchlDqbyPVbqHZCLkLKGSaNvxxTLMry/Eppmr182GdL1l5JGtSKlBEynirUEM6lG
	 FN1bvHZCBaY3rmqXGj+sO6/YIb8hvSxjbfKHZu1g1YNU5Wu2J0mVHFn2aWZevGuW5GU/x
	 Wb2u8iyU3aWgYSF/OBE5yYMuzozPILp626ovLpOj899lgXRweOzba2vUJDE0M8JQWLt4T
	 YWYygOOU+3xVee31zYBoVm3JQaI2nEXqtn2z1FN/RB5FxoxdiNkW3/o8PJ5egujhfSg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795659703;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=g393nK9hi6tlYtusgcPYZyhAztW4leyw/vbTjbaiwtk=;
	b=KXljB9O4MwH4NfMxPiOCJUK3ZcWbfEFDXU8DlZrDK7AqJYKQVWWsAYPPirpVgC6gBWcq
	 2b6nhl8xul21XXq4CKQL5P5M5qespkzg2wCtGDog2R+oke64wo5i17nTjhV7MexB5TfmC
	 navcl+ihkeob+jQ54fjgVjikLUJcyNr8gjX+7/cOxAkCUF4V3DKuLAyNpCkuFAvdiBAVc
	 0rvJEdhlzDQyed0psW/F0hSXp3FrtL5EMhdDstWSr67O27K4sXR+ZPsCUfM+fpVBa/p41
	 644ce2jbxN6IYZ5lI7FVDKO8iCWm5FHMt5oaFW36yQyC7tfHphJ8US240/cVKR7sdhA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CIpwBGan;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D1A7606A31E
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 02:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CIpwBGan
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BEF41F000C4;
	Thu, 26 Nov 2026 02:21:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795659703;
	bh=g393nK9hi6tlYtusgcPYZyhAztW4leyw/vbTjbaiwtk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CIpwBGan9on3sDkK/driRtdcGzVyc0qXcL1Xw7ZGkqR/Nx3N9/VRlTJRaZ6pU+YYa
	 L9IiGdD/jMP83JoAZ+WrSVQeZp4bimkx3QSwVWXHU5kTA6G5KFaqFzoujd2400pg5i
	 AaPOvUHDkzEc6EvYmbVO0dtcD7Gm9eTQtrNBaGCRVQAmGa7Cg22ujkFCjx9CDjMgL0
	 ng7bYipn18z74BrE40pW/aMbICG3kz1vjDwyBnqoP1GdQZAQF/z3xCcjCR0u4m0gRu
	 eFiTjvsZzZWKObEAuB7G3idWVH5eSudVel0LgX0CdhcyKrg2geGoKqkYsemu2kOpAM
	 I8mptaehvoO8g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Amir Goldstein <amir73il@gmail.com>,
	Sashiko <sashiko-bot@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] ovl: do not read the flags of a put upper dentry in lookup
Date: Wed, 25 Nov 2026 21:21:41 -0500
Message-ID: <20261126022118.1793963-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112531-appetizer-unclaimed-d653@gregkh>
References: <2026112531-appetizer-unclaimed-d653@gregkh>
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
[ sashal: adapted to the older ovl_lookup() code, using local upperdentry/inode variables and the two-argument ovl_dentry_init_reval() instead of the ctx-based three-argument form. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/overlayfs/namei.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/fs/overlayfs/namei.c b/fs/overlayfs/namei.c
index ee4e37646e85c..b1c4a62030441 100644
--- a/fs/overlayfs/namei.c
+++ b/fs/overlayfs/namei.c
@@ -1119,9 +1119,16 @@ struct dentry *ovl_lookup(struct inode *dir, struct dentry *dentry,
 			goto out_free_oe;
 		if (upperdentry && !uppermetacopy)
 			ovl_set_flag(OVL_UPPERDATA, inode);
-	}
 
-	ovl_dentry_init_reval(dentry, upperdentry);
+		/*
+		 * ovl_get_inode() puts upperdentry if it finds a cached
+		 * inode, e.g. for another hard link, so use the upper dentry
+		 * of the inode.
+		 */
+		ovl_dentry_init_reval(dentry, ovl_i_dentry_upper(inode));
+	} else {
+		ovl_dentry_init_reval(dentry, NULL);
+	}
 
 	revert_creds(old_cred);
 	if (origin_path) {
-- 
2.53.0

