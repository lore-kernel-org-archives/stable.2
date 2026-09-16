Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A54DA34DCCD
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 08:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789546107; cv=none; b=DLvelUhusxfDqnmAM5abv8he6WosXI8C0svx7VKbJed91IkvCyGCaRkwugc00FCFaFvbjsmyJP/yBHoDRwr3KxoUUAm707W5R55nlUBn5vDN2DD1cDcpp70K/DjPIlCC+cKSTZ/Zkudwy0W70CXnRfJCURuVTJ6wx5HPq568jmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789546107; c=relaxed/simple;
	bh=+laGGrc3H/Uibqmn8g6O6zTt962mrPIpgJ/Q180EGDE=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=TwtzXBunvfhU+tug+QC/Eu1I1nvi8Qc8YuHyG6M6SLYLHPL0BQoCyVQbPFSZcBeAf+3WW8ooVaQh/WpGjTzvR5HvSRsvlZR/diH5I31Y+jTN/ZProRzOpVfQxXHu/wKpQ7mTLDEEzvWau7B0ylfZm/62Zsw58P8uS1TfEFW9CBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=I9/ulAgd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="I9/ulAgd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE1DD1F00898;
	Wed, 16 Sep 2026 08:08:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1789546100;
	bh=x2iBxx/GiyMuzNPlO4XdFfc9BE+57bJZ69tyLCk7YRo=;
	h=Subject:To:Cc:From:Date;
	b=I9/ulAgdGc2xIpv4WtXsnp91LfYm3ceRJfgzJ8lpNnfYLSvDft1xuJNyF8DRR2APN
	 xmeND1ix3Mw3WZRL55gzxhr5vb5EGd1jK0YmtFbgUEpkxwackKAk33IBFGAbUH1OqQ
	 rQaR/0LVu9wUOJTmdnRO/bNP7/ibgkv4B8J8KRKA=
Subject: FAILED: patch "[PATCH] configfs: unhash the dentry before dropping the item in rmdir" failed to apply to 6.6-stable tree
To: vasilisalmpanis@gmail.com,leitao@debian.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 16 Sep 2026 09:05:58 +0100
Message-ID: <2026091658-maximize-simply-3f6f@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x f06c2d26d1999d37e93299db0ecead04ca7d0b9f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026091658-maximize-simply-3f6f@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

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

