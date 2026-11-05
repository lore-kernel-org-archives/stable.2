Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793850286;
	b=uvvssLH5wF+pkomokC9CZyOC6RanvGMYXckl0jjN3l4yUEH8LbYskyoCbe7sy+bKMxFN
	 W93nYfqnDvwcjpohXRFoTOWMvlVZA+xt6uO0q0G1WLNWBv9ZcBFbC7IdOgevfswP8z+Bd
	 WpaCLpjeybutsNjv6fgw/K4vvjq7C7Ypyov8WmTEsz9UxFAbjwr5qyc4Bq3xhI2GFpiZE
	 6ItG4DgGCv7zBGkwLgHACVKq0ERjk+PfgmRaxNmTnmYzsC4j8EWzRBO8OM2uaH2WO5eAo
	 vLK/ZhrkXmnwXbzMV6sG/F2Zltod5NTvGaw+SrcJTXOpMudyNtSEhPfTPDO+YvOkCGg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793850286;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=w9qnWUp84l9AxPr5K8lBXsIT5yc9i0NreILUFAdeYFs=;
	b=qlLj6tqZL8VZOYgBbX4vJMGdISM4jMwEXi8y7IiJIidExLgbaROVDTygXWYQWO5TfbTw
	 2QjxuSANagUc8eepcX0GU/jM2uVqxtS5im3PcF/YY8RMrxCnFqeX6CTBPdyLz/BpJk+Us
	 bVupNkCBlQdygp1TtwdymOeCJNoou6wAI6K+inrqiU55bWjLNByfZBCVlJuohezxyXt1C
	 7V1Q/5xzkUg4/QkFI7qzqQOj9nSYsMqCtOxGXP9y3rR3dRIsK82U/OLx8HEz3N40abyIs
	 lP9lYyQ3V65lFNxT/a0v2fOVXMlHE8+m5vr4H8cEOzRBYHIj/ye2k3VM15I39uHXaBw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=evvtRyMO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18586606A331
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 03:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=evvtRyMO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DD3A1F000C1;
	Thu,  5 Nov 2026 03:44:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793850285;
	bh=w9qnWUp84l9AxPr5K8lBXsIT5yc9i0NreILUFAdeYFs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=evvtRyMOyXOctZ+Ta5pId3/zAlx7hAyWwfHbSgUZAp4tn19Rga2MhHq6T6G6dRmPe
	 RYc0D0VgFyb4N8q8ObvPNj1GCyOOGtL6f4fZPZH802DxMhOaSi1WzDBmgaqh2aB1X6
	 OnIzAfi94DwVbdceYSHC2bESgA0bt1JM1LxV+BCK6/eUJ7xCPALMDYcfN2bpSizZyl
	 eTl48h4/WZT5wT6zZbrKkvv8RkLcoTy2QOmGdOInFXeC2zRIsg5n+GvgL6CRdLVdL0
	 uhMai/PcOk+agutM57YubBePvUsOPD3TL6CcWmSm3IjrEq2rUWv1IWl33e8oHFIJ1J
	 QyMLYPjVIMvjg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chris Mason <mason@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>,
	Amir Goldstein <amir73il@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] ovl: take a snapshot of the name for copy up
Date: Wed,  4 Nov 2026 22:44:43 -0500
Message-ID: <20261105034403.1239777-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110415-dragster-unsubtly-6084@gregkh>
References: <2026110415-dragster-unsubtly-6084@gregkh>
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
[ sashal: moved destination-name initialization from ovl_copy_up_one() into ovl_do_copy_up() to accommodate the older code layout ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/overlayfs/copy_up.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/fs/overlayfs/copy_up.c b/fs/overlayfs/copy_up.c
index 0f0c02121936e..a873bf4bac814 100644
--- a/fs/overlayfs/copy_up.c
+++ b/fs/overlayfs/copy_up.c
@@ -804,6 +804,7 @@ static int ovl_do_copy_up(struct ovl_copy_up_ctx *c)
 {
 	int err;
 	struct ovl_fs *ofs = OVL_FS(c->dentry->d_sb);
+	struct name_snapshot name;
 	bool to_index = false;
 
 	/*
@@ -832,13 +833,23 @@ static int ovl_do_copy_up(struct ovl_copy_up_ctx *c)
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
@@ -870,6 +881,8 @@ static int ovl_do_copy_up(struct ovl_copy_up_ctx *c)
 out:
 	if (to_index)
 		kfree(c->destname.name);
+	else
+		release_dentry_name_snapshot(&name);
 	return err;
 }
 
@@ -1005,7 +1018,6 @@ static int ovl_copy_up_one(struct dentry *parent, struct dentry *dentry,
 	if (parent) {
 		ovl_path_upper(parent, &parentpath);
 		ctx.destdir = parentpath.dentry;
-		ctx.destname = dentry->d_name;
 
 		err = vfs_getattr(&parentpath, &ctx.pstat,
 				  STATX_ATIME | STATX_MTIME,
-- 
2.53.0

