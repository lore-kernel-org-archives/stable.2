Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793881211;
	b=h11/s+KSuHmtHnwSA0XvhXbJff+fgC+VKpEVK+9ANhfp3em7+VjgZlfSXHVf4fOyXoun
	 3D1bFVkgXVJiWsGltw/mr7I6oDlMdVcJRl2srlJybPHD5coc4mPR0KCUty+QyH5eedwt5
	 ErtYIK3xCu9C0JtfLZPHHA1dyq3LyrZHgb19zWfhVSjwvE58487yIYjeG8x1a0r3tZPfY
	 qHElSEAIQ4YQGLbWKcYxb93ChL7v6hCpL7PRl95j4XGjPT7Ykjnl01m22DssaLFF4cNvy
	 Y1QT+a9fLtG7p4eJ0KOYIualfsoRsPkQ2IPFR5+3m3fy5UZ1Oo62nAodMAOv8tLdmUw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793881211;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=bo03mai6CfRU0HLhlJjvopiVvmWux2djuiPc9AX2enw=;
	b=PgA5cxrTwK5mV+5kRdnwlZ/mZ3hs1GQxPhZCKEVAABE7e5SkXSjCOkFYl0JkukNqZgSw
	 8HPOH+EktKTF3+hczlr2ocMP80kGhzDGnOj3JScMUwE6LVY5e+lsNaFD3iCiOvywqXgge
	 IoA1fE1NMXp9k2t1gAU+ehHh8yZnqCJjSz/ogB9ZxBwKQCDMgvXZVXglynV9rb9pXB1B5
	 JcO5fIkBWJkYkly43kzNGeua32R5I0eggASEy6wKhTEtrLGVX7KcdH5uVSVEKpY3R8JHC
	 sXr95L+Ymyy1mQSG7WaomCPEc7qdZUdgTPobf0L0bWp1VXoHeDkjaG6YwNlpgAICQMg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OeLGcuAp;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 468F9606A33D
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 12:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OeLGcuAp
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 581BE1F00A16;
	Thu,  5 Nov 2026 12:20:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793881210;
	bh=bo03mai6CfRU0HLhlJjvopiVvmWux2djuiPc9AX2enw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OeLGcuApR+gRGB6Q/L/68mq/pzr/DYGhmrGU2zNEjxHHGm2wjkJo53EbITCRwkWGv
	 HjsBQozOpdE9X+kwRGzC8I/6uj6/zRbmTitJdTJamK0qIuH4LlEzNLjKnL1CXXIgU2
	 Yam5nze6U9T8gmSJU+ZwRUzUZa81Q1OjvMm1inNHeqNf0bEEhNHWbRMZKtPXrosp+9
	 e7mqvhpPMeMd3EhaJj7pzid7v7wz/Y1swKYHIkbTngCeE9N2fRJxZwhNPTKuHEsl44
	 IDQ8nMYpnp7DZmBZ7CKJ/FDR+VMioMA2b6+4TdgUU0HRRIdYsnjSyG30H/eaSOfZAL
	 egtm/NDT3ohhg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chris Mason <mason@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>,
	Amir Goldstein <amir73il@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] ovl: check that the parents of volatile/dirty are dirs
Date: Thu,  5 Nov 2026 07:20:09 -0500
Message-ID: <20261105121914.1259746-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110452-attic-confusion-b886@gregkh>
References: <2026110452-attic-confusion-b886@gregkh>
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
[ sashal: adapted newer VFS creation helpers to older lookup and creation APIs with explicit inode locking and dentry cleanup ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/overlayfs/super.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index bd0c548cf1eeb..b0cf671b4200d 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -594,16 +594,23 @@ static int ovl_check_rename_whiteout(struct ovl_fs *ofs)
 
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
 
@@ -624,7 +631,7 @@ static int ovl_create_volatile_dirty(struct ovl_fs *ofs)
 	const char *const *name = volatile_path;
 
 	for (ctr = ARRAY_SIZE(volatile_path); ctr; ctr--, name++) {
-		d = ovl_lookup_or_create(ofs, d, *name, ctr > 1 ? S_IFDIR : S_IFREG);
+		d = ovl_lookup_or_create(ofs, d, *name, ctr > 1);
 		if (IS_ERR(d))
 			return PTR_ERR(d);
 	}
-- 
2.53.0

