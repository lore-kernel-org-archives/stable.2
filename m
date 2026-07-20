Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8670C42EED9
	for <stable@vger.kernel.org>; Mon, 20 Jul 2026 14:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784558691; cv=none; b=CPSkWhYoHamOxRPO6LwgYU57prwMrA7ocrJYCiW3Omu8vL9bmalLfEiA73ADKTqg8gsPilAxLriy3WbYFDC5lwlBED8wC72PnGjLR4ehH2AX5GLBqWfNjoZZlko90QK1fZbs8VMLzKw/5sXaMgxB9PIOpmVKNtmu6WbxFXNldRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784558691; c=relaxed/simple;
	bh=blw+ezvebnUevylf5G0NeuMKPvXBk8VQupK7kxTWS1c=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=qoSM1af4M/pKmG/2dCtP43LCVXQfwQ1uQ8Ol+1dBkDpKPCRiQRAYMLC2upeCyH/mEkgkvaoZToDdvybeD2tHlcttb7eJNNkHr5vEENVT5lhA9/HLu8QuweH7SLGDvqTGegcueBl+HcyrmwGWjVgVY9Kr0vuPziFvmHhI2wBbsYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=EwQEJlQY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="EwQEJlQY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E03AA1F00A3F;
	Mon, 20 Jul 2026 14:44:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784558690;
	bh=d4SUuDEkjCW+47Bh20g7oiQIY4sl6Bh56XOgA8k9bNI=;
	h=Subject:To:Cc:From:Date;
	b=EwQEJlQYpp0JxnEtbpkxbuY9QSJthizHEMNxiESs0TRM7Z0ttvWr3usx4H1JbX7b9
	 4/0fw3+HxfBhI8vGnL4hv0qJ/c0wXWbIip0fQX7E82LiyJ7yfCT5b9a4vQxjIp9KoX
	 aVp30KhdGnJOVuf8vIA74RD9jmKTcZ+SyIHSzb2o=
Subject: FAILED: patch "[PATCH] 9p: skip nlink update in cacheless mode to fix WARN_ON" failed to apply to 5.10-stable tree
To: leitao@debian.org,asmadeus@codewreck.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 20 Jul 2026 16:44:33 +0200
Message-ID: <2026072033-jubilant-cannot-6e20@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 574aa0b4799470ac814479f1138d19efe6262255
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072033-jubilant-cannot-6e20@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 574aa0b4799470ac814479f1138d19efe6262255 Mon Sep 17 00:00:00 2001
From: Breno Leitao <leitao@debian.org>
Date: Tue, 21 Apr 2026 02:41:09 -0700
Subject: [PATCH] 9p: skip nlink update in cacheless mode to fix WARN_ON

v9fs_dec_count() unconditionally calls drop_nlink() on regular files,
even when the inode's nlink is already zero. In cacheless mode the
client refetches inode metadata from the server (the source of truth)
on every operation, so by the time v9fs_remove() returns, the locally
cached nlink may already reflect the post-unlink value:

  1. Client initiates unlink, server processes it and sets nlink to 0
  2. Client refetches inode metadata (nlink=0) before unlink returns
  3. Client's v9fs_remove() completes successfully
  4. Client calls v9fs_dec_count() which calls drop_nlink() on nlink=0

This race is easily triggered under heavy unlink workloads, such as
stress-ng's unlink stressor, producing the following warning:

  WARNING: fs/inode.c:417 at drop_nlink+0x4c/0xc8
  Call trace:
   drop_nlink+0x4c/0xc8
   v9fs_remove+0x1e0/0x250 [9p]
   v9fs_vfs_unlink+0x20/0x38 [9p]
   vfs_unlink+0x13c/0x258
   ...

In cacheless mode the server is authoritative and the inode is on its
way out, so locally adjusting nlink buys nothing. Skip v9fs_dec_count()
entirely when neither CACHE_META nor CACHE_LOOSE is set, which both
avoids the warning and removes a class of nlink races (two concurrent
unlinkers observing nlink > 0 and both calling drop_nlink()) that an
nlink == 0 guard alone would only narrow rather than close.

Fixes: ac89b2ef9b55 ("9p: don't maintain dir i_nlink if the exported fs doesn't either")
Cc: stable@vger.kernel.org
Suggested-by: Dominique Martinet <asmadeus@codewreck.org>
Signed-off-by: Breno Leitao <leitao@debian.org>
Message-ID: <20260421-9p-v2-1-48762d294fad@debian.org>
Signed-off-by: Dominique Martinet <asmadeus@codewreck.org>

diff --git a/fs/9p/vfs_inode.c b/fs/9p/vfs_inode.c
index cdaa5034cbef..3a811db2dc19 100644
--- a/fs/9p/vfs_inode.c
+++ b/fs/9p/vfs_inode.c
@@ -490,10 +490,19 @@ static int v9fs_at_to_dotl_flags(int flags)
  * - ext4 (with dir_nlink feature enabled) sets nlink to 1 if a dir has more
  *   than EXT4_LINK_MAX (65000) links.
  *
+ * In cacheless mode the server is the source of truth for nlink and the
+ * inode is going away immediately, so locally adjusting i_nlink buys
+ * nothing and races with concurrent metadata fetches that may already
+ * have observed the post-unlink value (nlink == 0).
+ *
  * @inode: inode whose nlink is being dropped
  */
 static void v9fs_dec_count(struct inode *inode)
 {
+	struct v9fs_session_info *v9ses = v9fs_inode2v9ses(inode);
+
+	if (!(v9ses->cache & (CACHE_META | CACHE_LOOSE)))
+		return;
 	if (!S_ISDIR(inode->i_mode) || inode->i_nlink > 2)
 		drop_nlink(inode);
 }

