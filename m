Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793886313;
	b=M8g/bgh8clK6Ij7UGmkd6TjiLDcQX+2HyOGFYf86Bm5p8JGoE38mVG9kSkfTfMX6GPyf
	 YXiZijEvYpcW8XvHE63OsvNYndn4wlTgLyOkofVACTYXvgCibvuV3JJzUNvSc/KjnMH5z
	 JfDksWmmWJ+RyFnITcTtAqgxQCteRxqRICITsc5DqlkAF2sMmywG49L+Bo3OpyqXB9+py
	 VrM2pqqk/uUlDDdKM+VzNlXO48qkyLspASSR+GyJlhQKyEUqUC1puTilLbJ28VMdiV4ek
	 HNB4Cy0o6XAV7aabH0G12Bekybh3mH8dsmoG/sOXhmHhOEvCFBFob7u/WqYsoYxD5Gw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793886313;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=y5Pe60x6abRiVg28m0M7MU61OolRaQ1cu1W+NtqZjvM=;
	b=xq8hocE1DqJLJ/g6SGOyduassWkS3/SsC4EroZG44tImngkOfioIrKmothDmQhmJt+Vz
	 OQ/gAMmYv3pT5VBkaR7XosTIxcsiGdb7301yCuDMbnVkWZIBbw+L4iCZEr0qv8qJhIvjD
	 5VpFnHDxfvLDjX7NKrkQVQH4QrFsNAiagx1QFnS+rD0p1c0vpgdRZB+Yk3iUMZQfuVOXK
	 2ZeVFxZkP1ZvbP8teh0sha0Ijs1NhpkCblgEjGlziJY42gYuDQrrBC7CSMe+I2SCrwhnn
	 vJ8cjf+HGUEaBLdOzDIhYqKg5DSYvFzL7j/LiZEmsCpT2aDMjr4kZPJK80cv7iHtsLA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VwTxsMqM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 025F2606A31B
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 13:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VwTxsMqM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28DF61F00A15;
	Thu,  5 Nov 2026 13:45:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793886312;
	bh=y5Pe60x6abRiVg28m0M7MU61OolRaQ1cu1W+NtqZjvM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VwTxsMqMIHEDl9ev3393rks7vDjWRVwbJZEyFr/GyIEb3GjyQSsYFglDIRvr2aeoN
	 xcmdQnLw7ZkItPnvYnU6nnfXpwzCCNXLeW1/LlpjeZn1IA0Pjx5ZRkhKLN2YjjsMAX
	 u6BkPTeTapBJBW80Bq09RbKLKt1xaHJR5Kh4NI974dbDCTkIlpj3yCL2Ho6BNJa9SZ
	 +VpAHtVkF2asdLlmoaTIEqEzkm8bj4NpyH7NzNo5JpymZpqQ9RFj8dMrB6l/Gkcc4d
	 o3kiH8sE8LLCa9Kq+0uQp37HL8lEZ2ZDMSctwB3bsyPJyI5xlie9CJn9BRizI9aXbT
	 Evf1eHDj7cDow==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chris Mason <mason@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>,
	Amir Goldstein <amir73il@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] ovl: check that the parents of volatile/dirty are dirs
Date: Thu,  5 Nov 2026 08:45:11 -0500
Message-ID: <20261105134352.1612456-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110453-smokeless-womanless-d50b@gregkh>
References: <2026110453-smokeless-womanless-d50b@gregkh>
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

From: Chris Mason <mason@kernel.org>

[ Upstream commit e34d2ef818e4c7676d8d8e1bf43e6a1ed39efb2a ]

An unprivileged user crashes the kernel by mounting overlayfs with the
volatile option.

A dentry that serves as the parent of a lookup must be a directory.
ovl_create_volatile_dirty() walks work/incompat/volatile/dirty by name,
and ovl_lookup_or_create() returns an existing entry whatever its type.
A file or a symlink that another task creates during the mount becomes
the parent of the next lookup, which calls a NULL ->lookup.

An unprivileged user mounted overlayfs with "volatile" in a user
namespace while a second process created a symlink named work/incompat,
and the mount task oopsed on a NULL ->lookup call.

Fix this by returning -ENOTDIR from ovl_lookup_or_create() when the
caller asked for a directory and the existing entry is a non-dir.

Fixes: c86243b090bc ("ovl: provide a mount option "volatile"")
Cc: stable@vger.kernel.org
Signed-off-by: Chris Mason <mason@kernel.org>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
[ sashal: adapted creation handling to the existing inode-based API with explicit locking and dentry cleanup ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/overlayfs/super.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index 51eec4a8e82b2..e8e7e1c59d95d 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -1333,16 +1333,23 @@ static int ovl_check_rename_whiteout(struct ovl_fs *ofs)
 
 static struct dentry *ovl_lookup_or_create(struct ovl_fs *ofs,
 					   struct dentry *parent,
-					   const char *name, umode_t mode)
+					   const char *name, bool is_dir)
 {
 	size_t len = strlen(name);
 	struct dentry *child;
 
 	inode_lock_nested(parent->d_inode, I_MUTEX_PARENT);
 	child = ovl_lookup_upper(ofs, name, parent, len);
-	if (!IS_ERR(child) && !child->d_inode)
-		child = ovl_create_real(ofs, parent->d_inode, child,
-					OVL_CATTR(mode));
+	if (!IS_ERR(child)) {
+		if (!child->d_inode) {
+			child = ovl_create_real(ofs, parent->d_inode, child,
+						OVL_CATTR(is_dir ? S_IFDIR :
+								   S_IFREG));
+		} else if (is_dir && !d_can_lookup(child)) {
+			dput(child);
+			child = ERR_PTR(-ENOTDIR);
+		}
+	}
 	inode_unlock(parent->d_inode);
 	dput(parent);
 
@@ -1363,7 +1370,7 @@ static int ovl_create_volatile_dirty(struct ovl_fs *ofs)
 	const char *const *name = volatile_path;
 
 	for (ctr = ARRAY_SIZE(volatile_path); ctr; ctr--, name++) {
-		d = ovl_lookup_or_create(ofs, d, *name, ctr > 1 ? S_IFDIR : S_IFREG);
+		d = ovl_lookup_or_create(ofs, d, *name, ctr > 1);
 		if (IS_ERR(d))
 			return PTR_ERR(d);
 	}
-- 
2.53.0

