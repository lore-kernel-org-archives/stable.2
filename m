Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795659936;
	b=Ouy+cj2qIAvFmIunqM6tzj4bIFJuALDaCjLHs3slm8iViUKrwC+yIABGhrJmHprPgVp+
	 3cUfE8MJ67kqYJBHJHGZzwDLU4rcCCoZFpR2LmH0FlcrR2kTMQ32wM/rDBANvaFrhhAGo
	 ao/uDipF41u3KSQr2mhEK08859h6b2mzUy5gSKlweMlTxq/7cMnKcq3YRny6okd/Nx0Nw
	 0C+u+XkT0oRjbeZxNpCPFoyP2nC5Rv9XLKrHQv/73zbZ01DZAhI/3hXVnrn/OgAxQRDq5
	 +Vfo0cKRFsm2kjBGIN+JT2PvMWFcLgwlVt4PWsB//0vDPElefcm7hjk/I29yXFY5fJw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795659936;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=GiUQh0PNr5ezelcSTAGGwPQACBhUwA84niAJHi53K3E=;
	b=j3njb/gYL9HY64959gv3+oqKVktWOzDpUPhriwp6DJRuHD5qKYDqGSF1ZS1L2be8aLZq
	 6KcKx8N3YrKHuXH1uLZoiH6zhOaHPxxA3nk6v77WAXK6MKdNOtT55BB5BJBSlXi0N/z4Z
	 3+D3V1BGMJB9VZHq6vzpJ+bZ/jAbAWzbN4ztKJYqWpDuZppf+hXZFhiL1VEGAcm/j6WAx
	 1rolkCPLaDcEgNRsGreWWVe3EtvQrRPpOU/6GKDEFOcBIQ/rol1KfDzzMmbN6/UTaKA9r
	 Nqeu0FazkKwsXm87MrbuW7DTIEzFBgO5jq8Pw0k06eWx/B1uOWANBhzqx8/RbOSbw8w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LDwHPQ3u;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B898F606A323
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 02:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LDwHPQ3u
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8D351F000D3;
	Thu, 26 Nov 2026 02:25:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795659936;
	bh=GiUQh0PNr5ezelcSTAGGwPQACBhUwA84niAJHi53K3E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LDwHPQ3ucAcMbUcFYXHukNTZC7xF+pBsE5S4gsMZCjEsD08Mlu/RmqbwH0IztIN7R
	 cY2XfBN6bLn0BgQJO4NRi7u0fqWYAbzRQC8pY/HnyPfR93t3g52MGhp7TnXB7m/PPi
	 7QoVH+37CG4+DTHrmaaPAj9PGZjbYfUWG68ZKwDIyunc/Kd2VhCLHLurgP1NN62pA6
	 kjBTjBHoMz5etvMLqRk2+2yeq6GJfZHlEa4MEJ5RboJszp5g7siUbo9PM07TlzDclk
	 501KijLg2//YMVRWUbiAHC0pkkVS7cJNgxBkIgCHqYegfcqBTpaCSpBnXFAL+wNQFd
	 f86mIMsLB8Zew==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Amir Goldstein <amir73il@gmail.com>,
	Sashiko <sashiko-bot@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] ovl: do not read the flags of a put upper dentry in lookup
Date: Wed, 25 Nov 2026 21:25:34 -0500
Message-ID: <20261126022518.1800049-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112531-plod-groggily-1277@gregkh>
References: <2026112531-plod-groggily-1277@gregkh>
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
[ sashal: adapted the hunk to the older ovl_lookup() structure and the older ovl_dentry_init_reval() signature, which takes no inode argument. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/overlayfs/namei.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/fs/overlayfs/namei.c b/fs/overlayfs/namei.c
index 9b09697754f75..479f5013a91e9 100644
--- a/fs/overlayfs/namei.c
+++ b/fs/overlayfs/namei.c
@@ -1100,9 +1100,16 @@ struct dentry *ovl_lookup(struct inode *dir, struct dentry *dentry,
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

