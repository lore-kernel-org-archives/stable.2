Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DAFB3624AB
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 08:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789546104; cv=none; b=ZNW0zsRlBzTMCsnSrCsrOHCvQWt3dk2PNc1xguBO1ksSH6VFrPC4YSv/55uW13ndgDRuRuYkUH+nSDvzzxBzKfGkvRwBUa+YFM+uUqWGHqMYps9cD2MVfe+PIUGIu66RG5GAqPZ69rziMjZfZiLLZsa+34BV3kzGQkxqqX0IBd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789546104; c=relaxed/simple;
	bh=VuI2cdO+uoaQlXX4UNCL24xpDZyQoZ+KMUwQk3x8Loo=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=lzRRKX2WXtcmL0RGv35OCxU0IwFiDz1+MXE1aiDhYeltpX/71jLf1GDZERKqZSsAEJBqGdXgsaOlAj0wUceABLjOzMVTMvL33VLrazvfH9pVyYi5dLjdUr6SA4mFkejoLZWJHz42bkuY7n/eNv4eXH7Wq7C4hoUhgb7lZiJfu2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=J8YKRyqd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="J8YKRyqd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A79691F00893;
	Wed, 16 Sep 2026 08:08:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1789546097;
	bh=113B4y3mhOfGiq7Rpa9QqBnxzfm83FYvKvRfkoCysqQ=;
	h=Subject:To:Cc:From:Date;
	b=J8YKRyqdT36+CFrl93pAIEQ/x/O5t7vq2oK1ggf37N6ReFM3mMqVWZtoaR5mPsT3B
	 xPcWi9q0QKlZpNEU/PHScGBiulE8ELTwxzSpHR2Gr9td3z+B+Ju9VrekDyKBB6eOy1
	 VnAn710MobRc8z20hOnuOrzrhJYnmtaU7IS5K03Y=
Subject: FAILED: patch "[PATCH] configfs: unhash the dentry before dropping the item in rmdir" failed to apply to 6.1-stable tree
To: vasilisalmpanis@gmail.com,leitao@debian.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 16 Sep 2026 09:05:58 +0100
Message-ID: <2026091658-data-urchin-e973@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x f06c2d26d1999d37e93299db0ecead04ca7d0b9f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026091658-data-urchin-e973@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From f06c2d26d1999d37e93299db0ecead04ca7d0b9f Mon Sep 17 00:00:00 2001
From: Vasileios Almpanis <vasilisalmpanis@gmail.com>
Date: Thu, 30 Jul 2026 11:30:25 +0200
Subject: [PATCH] configfs: unhash the dentry before dropping the item in rmdir

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

diff --git a/fs/configfs/dir.c b/fs/configfs/dir.c
index 3c88f13f1ca2..eda80c2a2d38 100644
--- a/fs/configfs/dir.c
+++ b/fs/configfs/dir.c
@@ -416,6 +416,15 @@ static void configfs_remove_dir(struct dentry *d)
 	if (d_really_is_positive(d)) {
 		if (unlikely(simple_rmdir(d_inode(parent), d)))
 			pr_warn("remove_dir (%pd): attributes remain", d);
+		else
+			/*
+			 * configfs_get_config_item() takes a hashed dentry as
+			 * proof that ->s_element is still alive.  Our caller
+			 * is about to drop the last reference to the item and
+			 * the VFS will not unhash until after we return, so
+			 * unhash it here.
+			 */
+			d_drop(d);
 	}
 
 	pr_debug(" o %pd removing done (%d)\n", d, d_count(d));

