Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C01FD51991E
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 14:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789569576; cv=none; b=nySrH3QK2ISA5acRp+VJkNIjtMbj694ne8drGk0FQQiEMWROcaoYunR3Xw/2ntoGwAsSNjfUDWXD3L/2yfi1WivYZNWsIADb2i7U4QhkrC53kwLaeGuQXcxHIK1XuWejoJi8aGp7poytE0TzclhgTlwp0Inl5wAjZdie3cQOmZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789569576; c=relaxed/simple;
	bh=/WhVugQKzh4InElXkfFP1+K0vcBOYsl86Q9Bj8i24hU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DTH3/0jYCnqT1UBvD5Sh+B+BWjd4/oxs1t9KdtCQJXFSKkC+0X+x2AqBaU0KJ8hUoDhGoCY5vUxUm/XJaZ/32wraqbdNeb2Ao1MCUFA/eKzz18eWxD81MEbZyjIRpvFRNOCG54Mcd+KtavCcMxE5SXgnB+3ms1qFZ8id6/MxsCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KG/H4lJa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KG/H4lJa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D63491F000FF;
	Wed, 16 Sep 2026 14:39:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789569574;
	bh=PJZohl60zYZe9/g8t0WAKBeogPff7xZPLl9OJ9ZF+fE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KG/H4lJaBNIcBgMcfRiUcOD79/LfPysNHIiLW/QEI9b+eOmIHgBh6Ilak7rczeMZD
	 ZKhR1qZteuQeBCm1nt0jzcUWxGLN5DjC76IoTggQoEXRPgExDV5b+mrsXzcFzHUZDR
	 Xze0x30FBQywsZ6E+C2glYF+Dh55uPgN1qM3taJRGH8sEyRTyI9SZBnBV//LBvHyAi
	 ZiW7aHpwg3R36ZV956++A6QqqQ4OZWMzQZq4DiD3+alH2anV8hYcwSV5j7HFq/Z74/
	 v9Teg/Ld/0/ZvJe77v3PU+9A4H+YXo3WklnyduTbShEzNvFP3gAiCKBshQCABWQLfK
	 xUG5Zm5Fr6Fag==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Vasileios Almpanis <vasilisalmpanis@gmail.com>,
	syzbot+6b16e3d085833cbf3e25@syzkaller.appspotmail.com,
	Breno Leitao <leitao@debian.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] configfs: unhash the dentry before dropping the item in rmdir
Date: Wed, 16 Sep 2026 10:39:32 -0400
Message-ID: <20260916143932.3493496-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026091656-showman-zit-60ac@gregkh>
References: <2026091656-showman-zit-60ac@gregkh>
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
index 68203952766e6..181de3ba835a5 100644
--- a/fs/configfs/dir.c
+++ b/fs/configfs/dir.c
@@ -401,8 +401,17 @@ static void remove_dir(struct dentry * d)
 
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

