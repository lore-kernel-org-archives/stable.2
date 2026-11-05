Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793881227;
	b=i6U/UOeUDXTNcOq/K7f0Sj00j8a4VBG06Gj+NS0sKzLUwH3UbIQxUN+q3I8gFJH4tjF7
	 +4p/oemxCjddmIx9A0WjpvwXDLKsU2MDunjOXDg2Lfvzj4UfX/p7BQFH/O+I/pIEXxsUW
	 5yRv0NvILlMIEiuOJ+PQjpa3mpYB123Cn8oetkWkyK3ZHhO5z45Rr7puYBXFmEnh45AeK
	 UiL1oeGWLbwJJS6OhcQflOl3l4LbM9xsTJ1xc0ddhA4mHjNDMsVTQIfOLPGvHondNDMnJ
	 a+TlWcy3ofkA8FBvyUVbn0K1BBZjuDgnloX2ynb+xXHgn+rj+IVT7y9HIYqgogF/2/g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793881227;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=PWz+v+4dSNABat0urnVkkVWKS/ACyVC0ecxa1NHykVk=;
	b=sjqEJdztINzK+mA8aAYqC0O8cCpStnNnKxK2UlG8djg9McGIaDqbR0+zvW3tw3FaR24x
	 54uFXBf6KOVhVbBLqGeg0eggRt97A1OCM7I0RBkogSt66BLXz9kU+bhv6zQCpZ9rReHPy
	 a69ASOeT6I8AwUf8bzhOlibkh0RkgBQ0/6LNbfwQs9kr1ondsR4Pp5mh2EIcIBssSAruH
	 US7pLosulwhj419nMPx2A+ktIhE4esLdk4e7agRT6feaknneWyhewPlKGWYe4EcVW6nAC
	 rtx9PMkEVDR64ZzFmqdYjvdnvYZ2HNgKvKBKhH2VGUhkJOqO6JElX31BINpIYTF+y3g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=am4CQ8Lz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41E18606A328
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 12:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=am4CQ8Lz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 438B21F00919;
	Thu,  5 Nov 2026 12:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793881226;
	bh=PWz+v+4dSNABat0urnVkkVWKS/ACyVC0ecxa1NHykVk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=am4CQ8LzmRwiofzKmPtNnMN2eOEfsDRaostx5q9aKVZ/VvoEIOEGKWa5K3l7lIpoO
	 QhOo4DN2j4CqzyxcoOCwXW5Xo39cb9OcspMUYWMx3IKU0J+Fz7DQoBu2X6qcfRJ0Ma
	 GoWOsLoSfirDRWPA2xClxT3vs1NVIYeFtc2QLhhfZY1KgOD/AaxoVl7ene2lcMO8cF
	 J4l2KRK0TIFwv5abOs7FIvxv8yc94wvehMZNVNUdjVsIUSJB8AYqUuCsmAR42H99VJ
	 XXwDq5NBc0y7uXDy4VLKQNdR9BSU885yupx3XKwlHOWtTC5Yg0QcHp+gqIHm3rXuy9
	 yi7Jhn29bFF3A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chris Mason <mason@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>,
	Amir Goldstein <amir73il@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] ovl: take a snapshot of the name for copy up
Date: Thu,  5 Nov 2026 07:20:25 -0500
Message-ID: <20261105121919.1277439-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110415-paragraph-reproach-c827@gregkh>
References: <2026110415-paragraph-reproach-c827@gregkh>
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
[ sashal: adapted name snapshot handling to copy-up code with earlier destname initialization and no file-handle cleanup ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/overlayfs/copy_up.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/fs/overlayfs/copy_up.c b/fs/overlayfs/copy_up.c
index 4c7ef60dbaac0..71df585385f1e 100644
--- a/fs/overlayfs/copy_up.c
+++ b/fs/overlayfs/copy_up.c
@@ -791,6 +791,7 @@ static int ovl_do_copy_up(struct ovl_copy_up_ctx *c)
 {
 	int err;
 	struct ovl_fs *ofs = OVL_FS(c->dentry->d_sb);
+	struct name_snapshot name;
 	bool to_index = false;
 
 	/*
@@ -819,13 +820,23 @@ static int ovl_do_copy_up(struct ovl_copy_up_ctx *c)
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
@@ -857,6 +868,8 @@ static int ovl_do_copy_up(struct ovl_copy_up_ctx *c)
 out:
 	if (to_index)
 		kfree(c->destname.name);
+	else
+		release_dentry_name_snapshot(&name);
 	return err;
 }
 
@@ -982,7 +995,6 @@ static int ovl_copy_up_one(struct dentry *parent, struct dentry *dentry,
 	if (parent) {
 		ovl_path_upper(parent, &parentpath);
 		ctx.destdir = parentpath.dentry;
-		ctx.destname = dentry->d_name;
 
 		err = vfs_getattr(&parentpath, &ctx.pstat,
 				  STATX_ATIME | STATX_MTIME,
-- 
2.53.0

