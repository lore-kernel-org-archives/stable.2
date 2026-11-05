Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793883710;
	b=O+3skaW8DMiCPMYAYL6Ka86bRhiVbYU0M14WwUB3UqmBXEus8hCnBzc9CvtmWFXz5DiK
	 ErNzZyckBgIWOF5lN2xg2H99yf+exe0h/JvaktKyNrhUCVZN8XHG/0L1MailxLrH+nLlR
	 6AHmye8h2g9H0qolbRy6UAsEga8kstdng29HLJFM1nxdq/lVyCcD3fJAOB5YZ2lwSoi4j
	 e/FeqfXmF2ncrWL5gqp0lK/iZIbDeUg9rlGKfDiDEiPpCVAVczxzHo5ZB8FgWBXa/Dguj
	 9J+KNTvqE6eJjZVTA4M4iKVDdxEjEzmH/kud5i0S9yG925TcT50X1ZFJtgtka96RFDw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793883710;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=V0ISOzCFGVM/Z8KSrp7yV8Lb3Qsmf6Ds56fHv2L5NTQ=;
	b=5Csu+edGeyxLsCPf0hA/jRj1CnjbZnEss1T2ot2MAkCuwWIJp6V6CUvaFJn4dG8zRR7q
	 0e8qVRxG2Bxg0mzBZnSeuMheSgREZ7WSesuzpq2JDGARCRCTc6DO7y6lRqRNFkS6uz7a5
	 aWBot5lEcyO7uSIUC4uMv3G5BfZELjpbjbUfAde/zLw03fOMWRShRwBT3FrQub53anDK4
	 Gz0WZI2WI1PJZXOQ8KDE+ozDoaOztgqXbWILTlOTOs2xwOfnsTq2wWXbooGkqSup6tHc7
	 TAeEv1qkWwozgpZnIulkxO3w2vZvesQuXIM3tKCnZP9PYHTbrUVqsj6wQrHOZG3RscQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UXcfHQDy;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEA9E606A326
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 13:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UXcfHQDy
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC53B1F00919;
	Thu,  5 Nov 2026 13:01:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793883709;
	bh=V0ISOzCFGVM/Z8KSrp7yV8Lb3Qsmf6Ds56fHv2L5NTQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UXcfHQDySOw9HN8KsMbRt2gWvuzxx6ARmZLHikvdQE5qwWtPIWlI8Nl9WPGube5Hj
	 xqA5QiY2NbX10tH0jj0U2oloGBqqHblMkZlLgwz/ohSRGLhCmw5h4KOjU81EBz0cS8
	 kqLDBSgINi9tvZm1V3/iXuDdHQ1k5ex4eIvns/X/GDy3pjGxir+lrcUEv/Zs8CKftP
	 cED+Rh74jS3kT/b0oi4LUW8CuzeVgmNxlTgX/u1bght+twU4MIna8gO8jfAqT++L4r
	 MWsJYQ26hdkdptYh9FVMxHe52IY8yGZ+jj/1iSiq6XlJnhVCJqShBdeF0ASC1BzwgP
	 xPdkvfJ5h0Axg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chris Mason <mason@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>,
	Amir Goldstein <amir73il@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] ovl: check that the parents of volatile/dirty are dirs
Date: Thu,  5 Nov 2026 08:01:47 -0500
Message-ID: <20261105130125.1388978-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110452-detonator-keep-c227@gregkh>
References: <2026110452-detonator-keep-c227@gregkh>
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
[ sashal: adapted upper dentry creation to the older inode-based API with explicit locking and dput() cleanup ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/overlayfs/super.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index 76316d143aaa2..67a54ae3644e6 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -660,16 +660,23 @@ static int ovl_check_rename_whiteout(struct ovl_fs *ofs)
 
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
 
@@ -690,7 +697,7 @@ static int ovl_create_volatile_dirty(struct ovl_fs *ofs)
 	const char *const *name = volatile_path;
 
 	for (ctr = ARRAY_SIZE(volatile_path); ctr; ctr--, name++) {
-		d = ovl_lookup_or_create(ofs, d, *name, ctr > 1 ? S_IFDIR : S_IFREG);
+		d = ovl_lookup_or_create(ofs, d, *name, ctr > 1);
 		if (IS_ERR(d))
 			return PTR_ERR(d);
 	}
-- 
2.53.0

