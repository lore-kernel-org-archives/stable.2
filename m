Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795659257;
	b=klUdGalMlJtKQGCyv1sG85fYJAbTswsL6e3jNaGbqfS5+nfSq+7r7XvmL/HQ+d+LRnSE
	 n0TcxbCF0aesSTYFcV4G6U7EkKREZ/v5hwfPoWz01Jy02egkF674llZ0uNlPlZpWvPESO
	 DRx/V2fLfdu5iFCleyBfY4BRbaMbnAsnvr7dLRIGGWdrna4RUcsAEjL87Z9SP7cD7KV5G
	 l2gM/ZkOOnbNUo99Hg+DkWGABzvxB/MUu8GNDkcfnMnx0aDBOSca5tHLSay6yZ8bMKXZS
	 KTjtPuwq1vc47Kr+jS8yBHS+k+VwcCcpFFV0HhLTLGpaBR475yb2VN2Smo0kpaEqHww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795659257;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=d3bVOz1zGlY7vd+TgeAfVtmhPThU+TaUoeTNnsx41Q4=;
	b=sxJS5/9YTVsrqo+xjKQWu009EQX5Ro5G9on6A3KN3bkd1pBIbsTRTBEUC7tIoX7Myc0Q
	 Szy/KZyXWJEixPp/KmXcqu/WYTyjV0SOytBTLqFMrt3Cq0KSpo9JaOCvxISfCjEUhu38n
	 K7LvSj8yuPhl3AlShgPzNN7A77EeFnhDDnXL+STGIZSD2QYa+I1lmgq6SCb49K+Z/Czh0
	 W3vWaeet9PXRelDjFM6wdqyAT4Fdg5Bn8PLzdOuW2vj2ffLXddOdyDLZbCn5XeDfJSx1C
	 3MhKJQChQmKfQTItot8Vd3Jc1/o059OO6EjlsoorWlgQOhd5QqioSVdUagB7f1lA4PQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PfkNaRQw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25006606A31E
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 02:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PfkNaRQw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 375011F000C0;
	Thu, 26 Nov 2026 02:14:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795659256;
	bh=d3bVOz1zGlY7vd+TgeAfVtmhPThU+TaUoeTNnsx41Q4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PfkNaRQwdC+Cwcvcf4qFL2Rrudm8n3dhBS0DiEJeibZeKtACaMvg+9NUbV0tXCIcW
	 /n4rCdtTqUNKxiaCIrOJca2dxHkPXZGKo24l5iTD0rcWOlKGMxlQMa81klF8XhUxff
	 q89pm3gAH1rcIOgbOgtQCb3i5XLe02F5q+zFwtWONn8CuUdt+uQjcPTvrg14DxTssH
	 4ws8C3ZxrRnZ7j+xtN7+0bqYDaJlxHVK16Ntf0Pz62bNWrO1MYBF7CkKy/lzmDuEE6
	 l4per4JH3MLGEO9rWbLlt4Wl8WzQUFtBhFp/PFFy7W7DmMMkSa18JR4QguC3KrdW4r
	 +L/pX8gZA5XFQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Amir Goldstein <amir73il@gmail.com>,
	Sashiko <sashiko-bot@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] ovl: do not read the flags of a put upper dentry in lookup
Date: Wed, 25 Nov 2026 21:14:14 -0500
Message-ID: <20261126021358.1779586-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112530-unflawed-limes-7ee6@gregkh>
References: <2026112530-unflawed-limes-7ee6@gregkh>
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
[ sashal: Moved the ovl_dentry_init_reval() call inside the if (upperdentry || ctr) block, taking flags from ovl_i_dentry_upper(inode) with an else branch for negative dentries, and dropped upstream's third argument since this tree's helper takes two. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/overlayfs/namei.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/fs/overlayfs/namei.c b/fs/overlayfs/namei.c
index 124c437e65e6a..a255102adc624 100644
--- a/fs/overlayfs/namei.c
+++ b/fs/overlayfs/namei.c
@@ -1123,9 +1123,16 @@ struct dentry *ovl_lookup(struct inode *dir, struct dentry *dentry,
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

