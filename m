Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46339447805;
	Sat, 26 Sep 2026 13:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790430317; cv=none; b=YK0+0Csz7h12XoMJH/HTXN9bgpH2EP3d1m7SGmqGD9xdrtUjezAJkzn3GLfQpZE+HsEotQLAy37EjcVhyKWqRVtuHeSdDHI5urmXDL9GkUsaO87t6jsqQ3vw6vfaoiRsG1686/ccdDJ0N8yhTMI87AbWHkj2C6I/6whc/jauEio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790430317; c=relaxed/simple;
	bh=4q+B3kuKvW5q+KW1fF1+X/2NfmS/gMrDG1Np7+JaDpw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DAbW0S79ZkJVqHhGWBhI8R3QRqVOG4Lzg7fZayyP3jgeWtrU0Xlmb/+jHMDVnSmgTsVPiFpGuATHxBK7lcZsD2jtWDwGeBAUJkF5l3f5LdHxCM8oiEqQsWC2JhqtQBiKPd9foTDjq+BTaD5W0mQ/Papex/5CpJXB2FzHTShZJS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gJA+ZI9b; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gJA+ZI9b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E76901F000FF;
	Sat, 26 Sep 2026 13:45:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790430315;
	bh=B9cSl2CGb0gCf8Om0oOJTR1G/ecEZoTjBDdprlQRelw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=gJA+ZI9bGtOYumBOcyn63r/nLHW49nMshb4iauQjXW7fvnezCUZGcx+0iTXHr6ifr
	 IsIarcQqnjcT4k/rliIUTdY40RWAQFywA4YARJV6FQHqsGj9sUU2WCqujaxhW8tuL/
	 iwaYpL3My2FaNgx5Lz1UfKNtk5+u05YC8H23sDEy/FKz0ZmKiJqxfLoO14xd+HElCo
	 USVZkewibBeZAMVvAqLXskO7yGkZoz0w6dpQ8+mzk3Ow/+D7H2Tif0b2kbzmij2PM+
	 xJ0NwfPTQ2DbuS9smZWNFVrFqFdPQBvLRgQKZymAJPWzMc+xghEZxzDPL/sIiexwgY
	 s/b4qtTOspDXA==
From: Christian Brauner <brauner@kernel.org>
Date: Sat, 26 Sep 2026 15:44:29 +0200
Subject: [PATCH 06/10] fs: refuse fspick() on internal superblocks
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260926-work-mount-fixes-2-v1-6-f357abf3d17b@kernel.org>
References: <20260926-work-mount-fixes-2-v1-0-f357abf3d17b@kernel.org>
In-Reply-To: <20260926-work-mount-fixes-2-v1-0-f357abf3d17b@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Linus Torvalds <torvalds@linux-foundation.org>, 
 Jann Horn <jannh@google.com>, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.17-dev-db0b7
X-Developer-Signature: v=1; a=openpgp-sha256; l=1009; i=brauner@kernel.org;
 h=from:subject:message-id; bh=4q+B3kuKvW5q+KW1fF1+X/2NfmS/gMrDG1Np7+JaDpw=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRtPxOt3edWcfxn+WOxhW0r/Jf0r11/fF74puwr36X2G
 ypYx5k6d5SyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAExkdyMjw8dD+uyT5pxTL1n0
 45Bo+PKYVyUqkfef7pbi4v10YLLvhbOMDNdT4w82/9UWD3nZ9UllzwnO4lWfNELlqlt+Vttm76q
 SYwYA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

There's a few instances where a internal superblock is reachable by
fspick(). Block that. graft_tree() and fsmount() already refuse them.
fanotify refuses mount and superblock marks on them for the same reason.

Fixes: cf3cba4a429b ("vfs: syscall: Add fspick() to select a superblock for reconfiguration")
Cc: stable@vger.kernel.org # v5.2+
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/fsopen.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/fsopen.c b/fs/fsopen.c
index ae19e5136598..9d5a7a22b529 100644
--- a/fs/fsopen.c
+++ b/fs/fsopen.c
@@ -190,6 +190,9 @@ SYSCALL_DEFINE3(fspick, int, dfd, const char __user *, path, unsigned int, flags
 	ret = -EINVAL;
 	if (target.mnt->mnt_root != target.dentry)
 		goto err_path;
+	/* kernel-internal superblocks are nobody's to reconfigure */
+	if (target.dentry->d_sb->s_flags & SB_NOUSER)
+		goto err_path;
 
 	fc = fs_context_for_reconfigure(target.dentry, 0, 0);
 	if (IS_ERR(fc)) {

-- 
2.53.0

