Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C0614B95AF
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 15:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789573755; cv=none; b=QUeWMu/jeKuwgKwHne2qEqKgLsYuIKCWEXm9o00kTvLYoJSICt0klmBQ8LILzul/xPgwLW+rLdqVQBzLhjGU7T82KzNt690FpIDcVsN8WKnmTg4p6I02O1rYMpgTjc0itxg5+ca4Aq/b1Zt8E7POesfvF0WxGnp0+ETxp+0tZ4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789573755; c=relaxed/simple;
	bh=wm28feJX5q2dSgX4DQrLcliwTEhJLEddJeiY3Eg/Q2A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ts0/7vjG5K9WPlBNoTOLuBT/jL8JvfnhSe1xquSOFeU06BGpFLF0IK3TPOI7rxk/C7wIzC5HxUWCHLN8Bjh0hJv6cjdgPPf0MwBCXMVm7VSqng1PDn2IheJNHJ4daNfhtW5NByQiZ54FuDqQoEVkJhMS3SSh3j59yEW8tn0aXZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M5t89+5q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M5t89+5q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81DA31F000FF;
	Wed, 16 Sep 2026 15:49:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789573753;
	bh=XKAVSywIWK4Q1JjiLag9T0m8rL/EbEd6scRE7XsSzVg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=M5t89+5qatAbc7syrmTg/smW9va/5InyzlPK9HP4kojI2RmqWYqb9nvtbDsdT4dWA
	 IPToHzp4B2q9yv7oTbbf1+Gyzg5OXZs6lPtyEjqEjtkXHDY36KfNAjg3NQUZynyPaP
	 K1nuKW8zGzVB9ZUoIQK070FIFjmjeafyjGv/LN7wVigr3/pUciEqbdBzYC6a0bOS3D
	 LUvCcjyVZmdhRgv5MajY1fzLBUFxs1gX5xumnaK/n3Xa/lcdKnmONDcdeKC2i0n5yU
	 gXe+hbmGXXTGD3LnCk7NLjEcb05FtpGWDxrqCq5s1+BRe9+koFdt4quf5CvMnejnIR
	 g9geBi4UWggSw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Vasileios Almpanis <vasilisalmpanis@gmail.com>,
	syzbot+6b16e3d085833cbf3e25@syzkaller.appspotmail.com,
	Breno Leitao <leitao@debian.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] configfs: unhash the dentry before dropping the item in rmdir
Date: Wed, 16 Sep 2026 11:49:11 -0400
Message-ID: <20260916154911.4167454-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026091658-maximize-simply-3f6f@gregkh>
References: <2026091658-maximize-simply-3f6f@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Vasileios Almpanis <vasilisalmpanis@gmail.com>

[ Upstream commit f06c2d26d1999d37e93299db0ecead04ca7d0b9f ]

configfs_get_config_item() treats a hashed dentry as proof that
sd->s_element is a live config_item.  configfs_rmdir() breaks that:
simple_rmdir() leaves the dentry hashed, the last reference to the item is
dropped right after, and the dentry is only unhashed by d_delete() once
->rmdir() has returned.  configfs_symlink() resolves its target holding no
lock on it, so get_target() can land in that window:

  BUG: KASAN: slab-use-after-free in config_item_get+0x26/0x90
   get_target fs/configfs/symlink.c:128 [inline]
   configfs_symlink+0x4ab/0x1030 fs/configfs/symlink.c:185

Unhash in configfs_remove_dir(), while the item is still guaranteed to be
there.  A reference obtained just before that stays harmless, as
create_link() rechecks CONFIGFS_USET_DROPPING, already set by
configfs_detach_prep().  Both configfs_unregister_subsystem() paths
d_drop() after detaching, so this only makes rmdir match them.

Reported-by: syzbot+6b16e3d085833cbf3e25@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=6b16e3d085833cbf3e25
Fixes: 7063fbf22611 ("[PATCH] configfs: User-driven configuration filesystem")
Cc: stable@vger.kernel.org
Signed-off-by: Vasileios Almpanis <vasilisalmpanis@gmail.com>
Tested-by: Breno Leitao <leitao@debian.org>
Reviewed-by: Breno Leitao <leitao@debian.org>
Link: https://patch.msgid.link/20260730093435.195441-3-vasilisalmpanis@gmail.com
Signed-off-by: Breno Leitao <leitao@debian.org>
[ adapted the configfs_remove_dir() change to the older remove_dir() helper. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/configfs/dir.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/fs/configfs/dir.c b/fs/configfs/dir.c
index 972fb89ad2214..5edb85322d924 100644
--- a/fs/configfs/dir.c
+++ b/fs/configfs/dir.c
@@ -395,8 +395,17 @@ static void remove_dir(struct dentry * d)
 
 	configfs_remove_dirent(d);
 
-	if (d_really_is_positive(d))
-		simple_rmdir(d_inode(parent),d);
+	if (d_really_is_positive(d)) {
+		if (!simple_rmdir(d_inode(parent), d))
+			/*
+			 * configfs_get_config_item() takes a hashed dentry as
+			 * proof that ->s_element is still alive.  Our caller
+			 * is about to drop the last reference to the item and
+			 * the VFS will not unhash until after we return, so
+			 * unhash it here.
+			 */
+			d_drop(d);
+	}
 
 	pr_debug(" o %pd removing done (%d)\n", d, d_count(d));
 
-- 
2.53.0

