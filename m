Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2573342E8F9
	for <stable@vger.kernel.org>; Mon, 20 Jul 2026 14:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784558694; cv=none; b=MTAjCH6OxynjHzQAroSA7TE6oA7NV0M/ETA09JAQDmHTFr1F3IboQ3YqRWyd5y9T/rsXKw6LP9Arrb6PGSG0C7ZkOzx1O1latzCEmivQbpBFyx6+DDjp8cS/usHUQFsDXYCPCyGRCsT8Bo0Kr03aaUcmq31/mGYAEnA3R5RnlKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784558694; c=relaxed/simple;
	bh=5+PMZOkIv//FkqfeSfXlwpbffc4eax7kZkI6K2BXUks=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=aw1xIuZafOjWQTUsOwI1wQWpu4Sx0PjwrA2DHsrlZuBaJC07GvvF5b2/4FgC2CcEO2T8Dp07jafsoKHaH5IWu1A97SLa9sm9ldnEHo1QiyeQA43WcFdC48ho9Tz1pllXE5exr+7ApAS5S8PxZ2I/ejnauh7lxdtWJphB8kGcJR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ppTHzwgv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ppTHzwgv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 891DB1F000E9;
	Mon, 20 Jul 2026 14:44:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784558693;
	bh=PM5j9E6Qq8fb5PdBjDw3LCTJMsUgd7pzVx5D2jQ6dGk=;
	h=Subject:To:Cc:From:Date;
	b=ppTHzwgvbR2UL4D9DnJGuIucj/DKS3cWouynnvEGov6yJ0WDDq2DkGzSfHi0ncOC8
	 8Br1cEAyNFG2EC6SU9VFWwI7pLZnccjWCwmIPf5gcB+zPM6+Swhl6zVzql3MEgCwU1
	 P5L801/XuTE21EvHYHMA1zBRwuIZwZk0xD47gm8E=
Subject: FAILED: patch "[PATCH] 9p: skip nlink update in cacheless mode to fix WARN_ON" failed to apply to 5.15-stable tree
To: leitao@debian.org,asmadeus@codewreck.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 20 Jul 2026 16:44:33 +0200
Message-ID: <2026072033-zesty-lustily-01bf@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 574aa0b4799470ac814479f1138d19efe6262255
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072033-zesty-lustily-01bf@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

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

