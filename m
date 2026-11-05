Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793886351;
	b=34rFUkAhmrULnva+FL231ygtsIPNcfAEqe0IKMxUxVn5zXAf2+sbdg0S+64khyMspWLI
	 eZK06Jw64tWjaERf4zRsOXIl1RXSCM0fLAlrrcsXYdQqaydkSxx3ZoDjA0UcBEuObGHZT
	 MN4Nb8YYrjySlMc6ciM0R5MD6bpHo4rQ8ZVK3v/xwcsmTllZMYq6Sv+Ir2G6Hlg1vYeHJ
	 IhCtg60/fyXW/F/7vprQgBOdDAkLnw6bBikeL3n0PS0WrsUveXTRCGq/1ik3T7ZX213be
	 6QxX0pBaeNJ4nnHv9mfhyN+HLcsEVdZxpGhsUEHVCHlEIW6/qpupDu9DVm6ivz4QpDw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793886351;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=aDxwNnamTB2guzN5LWk6DLnQ/2JczE/NR0RE6NFGj/k=;
	b=vNgtcYIFBLCj5mQ2Ti8DdyV/yoyZVdbALdVTipwlqqiyxR/g/aUQepuyP0Qqe23x4ioW
	 PvkOPC4CmB62B3kwl7QBuRDppxeAw/TaKel/BS/i81B4t14waBvoRwgKP/obBHT08B6hn
	 2y+LyCNzz+zpv3kHZp5FKvYp5tjn8W594SnCHsGxMwfId9SukoxdPbHJS9HP3JUUpKfDL
	 hSm/qjyfLS1yIe5KCwJkYrjiQyMYT9EqtLbSVCxIkwOL2bcUxlV3yENPyMJ/pRcrqEvfe
	 1LJ281FTqwfpUgBhBRiaNXowVRb2IBXWIjt7ofU13xKS+4KAReGdUxGQTty0u2r6rdQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lqie8vnv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE147606A328
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 13:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lqie8vnv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C1991F000C1;
	Thu,  5 Nov 2026 13:45:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793886350;
	bh=aDxwNnamTB2guzN5LWk6DLnQ/2JczE/NR0RE6NFGj/k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lqie8vnv3QeyeSTc5pWJyomobO85DpS9oZjnc6caoTrpPXKFP/OK9CeMbprV7Ek6S
	 tHY9clpwJgh9aDyoe3pMm6l4NBVBKSs215mfXBazou6OdbTHuIkOoWhdxKwwJNsGev
	 djw4RqN8rK6hi29MRYJANuUWW1kKctI5pzT8PKCw9AClI5rS4Qi3rRqC8PzBrV6DKw
	 zLIOXXjF0+NmYEPQRUgo+8p/gLx215HF6cmJD52nPgk64NIPSO0zN7oOv41NTVyqmD
	 Gd59hv/BCqZ1LUN1mdHTXYxsVethZCBr0xCaSaeCucHKYR05KFbkMQbbzpdoDfvqtA
	 O90mO6HN3OoKA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chris Mason <mason@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>,
	Amir Goldstein <amir73il@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] ovl: take a snapshot of the name for copy up
Date: Thu,  5 Nov 2026 08:45:48 -0500
Message-ID: <20261105134357.1389692-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110415-exemplify-juvenile-57b8@gregkh>
References: <2026110415-exemplify-juvenile-57b8@gregkh>
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

[ Upstream commit 65bf000962a33ec9d2488e4e1797b6cf630abcbb ]

The copy up of a directory reads a freed dentry name when a lookup
moves the directory at the same time.

A pointer to the name of a dentry is only valid while something stops
a move of the dentry. ovl_do_copy_up() keeps a plain copy of
c->dentry->d_name in c->destname, and ovl_copy_up_start() only keeps
ovl_rename() away. When a lookup finds the same directory under another
name after a change to the lower layer, d_splice_alias() moves the
dentry and frees its external name.

With a delay in ovl_do_copy_up(), a chmod of a lower-only directory with
a 60 byte name raced with a rename of that directory in the lower layer
and a stat of the new name, and KASAN reported a use-after-free in
lookup_noperm_common().

Fix this by using take_dentry_name_snapshot() for c->destname.

Fixes: 829c28be9bb9 ("ovl: use d_splice_alias() in place of d_add() in lookup")
Cc: stable@vger.kernel.org
Signed-off-by: Chris Mason <mason@kernel.org>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
[ sashal: adapted snapshot handling to caller-side destination-name initialization and direct-return error paths ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/overlayfs/copy_up.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/fs/overlayfs/copy_up.c b/fs/overlayfs/copy_up.c
index 018867303a93a..bd5526904eea6 100644
--- a/fs/overlayfs/copy_up.c
+++ b/fs/overlayfs/copy_up.c
@@ -709,6 +709,7 @@ static int ovl_do_copy_up(struct ovl_copy_up_ctx *c)
 {
 	int err;
 	struct ovl_fs *ofs = c->dentry->d_sb->s_fs_info;
+	struct name_snapshot name;
 	bool to_index = false;
 
 	/*
@@ -737,13 +738,23 @@ static int ovl_do_copy_up(struct ovl_copy_up_ctx *c)
 		/* Disconnected dentry must be copied up to index dir */
 		return -EIO;
 	} else {
+		/*
+		 * ovl_copy_up_start() keeps ovl_rename() away from c->dentry,
+		 * because ovl_rename() calls ovl_copy_up() on source and target
+		 * dentry.  It does not stop d_splice_alias() from moving a
+		 * directory that a lookup found under another name after a
+		 * change to the lower layer.  That move frees an external name,
+		 * so take a snapshot.
+		 */
+		take_dentry_name_snapshot(&name, c->dentry);
+		c->destname = name.name;
 		/*
 		 * Mark parent "impure" because it may now contain non-pure
 		 * upper
 		 */
 		err = ovl_set_impure(c->parent, c->destdir);
 		if (err)
-			return err;
+			goto out;
 	}
 
 	/* Should we copyup with O_TMPFILE or with workdir? */
@@ -775,6 +786,8 @@ static int ovl_do_copy_up(struct ovl_copy_up_ctx *c)
 out:
 	if (to_index)
 		kfree(c->destname.name);
+	else
+		release_dentry_name_snapshot(&name);
 	return err;
 }
 
@@ -895,7 +908,6 @@ static int ovl_copy_up_one(struct dentry *parent, struct dentry *dentry,
 	if (parent) {
 		ovl_path_upper(parent, &parentpath);
 		ctx.destdir = parentpath.dentry;
-		ctx.destname = dentry->d_name;
 
 		err = vfs_getattr(&parentpath, &ctx.pstat,
 				  STATX_ATIME | STATX_MTIME,
-- 
2.53.0

