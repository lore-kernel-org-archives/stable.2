Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FF2E53A89D
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 11:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788954274; cv=none; b=Jvj91eGFv/OXn7w+cXo8RfFmMqu9noIi9rNwHu8W/I0isnvO/miyr/x2pOPo8071Pj5qBMZi0lp3QW6tC8ogq3+3vk7mRG9jNzWldAMUl3DsbMrDub+NrP32WMW+DbQHhCBoBsIjwLuNfpxfL4V/ROJCJAxf0k7RNLF3tjT7Vkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788954274; c=relaxed/simple;
	bh=uAbBynRh13fjO/W03gg7tGZU70K7l9fm5KRGRJEioyk=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=TpDYRRezlIbyxBap69kZyr/MULGuqefon/nsuNcvHrAnTllseNLRxu5eQ/ToW8fTSDK9fMp+T5c9t6grEicrUnCSOlwCEadU0p0nhhOKZ4ZuwNCc1vbTf2FmDKV6jrTGS+wCO4i92JeWpA/oyqMrVgl1HNN7sy7kOFg4229YEbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=sZtRgdcE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="sZtRgdcE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 361DD1F00A3A;
	Wed,  9 Sep 2026 11:44:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788954272;
	bh=iRO005Va22txkdWDA0zb6TSBt5sgLdhEi5hXdqvTuto=;
	h=Subject:To:Cc:From:Date;
	b=sZtRgdcEnYi+aMnrNT1bcF+qLooVLFznOeaW7uDE+oVqsvgq4L0Ubvrp+2amK0QYC
	 luF08B/0MeCE8eF3N8G/Zj2m9ILo2iVbZwS2WpMXgIvg7SrCrwvdl1e3s27mZyYUPS
	 na/XKWKTvmOFHRy3Xu/lTAdbutJ+NyNNZ2nc5sXg=
Subject: FAILED: patch "[PATCH] f2fs: fix to avoid potential deadloop in" failed to apply to 6.1-stable tree
To: chao@kernel.org,jaegeuk@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 09 Sep 2026 13:26:58 +0200
Message-ID: <2026090958-headband-sturdy-0f93@gregkh>
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
git cherry-pick -x ce366bfa821ec81dd45bde547ee31e659306cc61
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090958-headband-sturdy-0f93@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From ce366bfa821ec81dd45bde547ee31e659306cc61 Mon Sep 17 00:00:00 2001
From: Chao Yu <chao@kernel.org>
Date: Mon, 24 Aug 2026 21:17:29 +0800
Subject: [PATCH] f2fs: fix to avoid potential deadloop in
 f2fs_fsync_node_pages()

There is potential deadloop in race condition:

Thread A				Thread B
- fsync
 - f2fs_do_sync_file
  - f2fs_fsync_node_pages
   - last_fsync_dnode
    - folio_get(last_folio)
					- f2fs_setattr
					 - f2fs_truncate
					  - f2fs_truncate_blocks
					   - f2fs_do_truncate_blocks
					    - f2fs_truncate_inode_blocks
					     - truncate_dnode
					      - truncate_node
					       - invalidate_mapping_pages
					        - folio->mapping = NULL
   - is_node_folio alwasy return false
   - atomic && !marked is always true,
     then goto retry

Cc: stable@kernel.org
Fixes: 608514deba38 ("f2fs: set fsync mark only for the last dnode")
Signed-off-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 968e5ed38816..86c2e67e43b6 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -2016,6 +2016,11 @@ int f2fs_fsync_node_pages(struct f2fs_sb_info *sbi, struct inode *inode,
 		f2fs_debug(sbi, "Retry to write fsync mark: ino=%u, idx=%lx",
 			   ino, last_folio->index);
 		folio_lock(last_folio);
+		if (unlikely(!is_node_folio(last_folio))) {
+			f2fs_folio_put(last_folio, true);
+			ret = -EAGAIN;
+			goto out;
+		}
 		f2fs_folio_wait_writeback(last_folio, NODE, true, true);
 		folio_mark_dirty(last_folio);
 		folio_unlock(last_folio);

