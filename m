Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09D205328DE
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 11:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788954271; cv=none; b=V1fWzi2jiimulBjRnAQtb3QqcX5rJVFi4jjx0nugsYmlRyKWkcIKqdz7uyYnZGkCVVQR5RB5jDfUaVjpACylJTZnIbpm/imtEctULxFTeF0t+Ipu9jHCW7EDRGRWT5KqEEWnZWswODUin6iW8rntz9IJ2bdy4VTKjwSVAd1n2jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788954271; c=relaxed/simple;
	bh=vZt83ybn/9jVe+1W4Bixfyskgv2oHovuUp67lSdackI=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=pR/nYtxpo5SlDj3itTIEV3uMckYCHGdNR8dkvv+/rC8EokxPt2g6AqaQNj+CTX4bWTRq8iU2kNbPTqEjeqloTNsQgigJGSvIro16mf2B+Ieyz9kcERq3bFh/bYMCAoyjHBhmjrGYh8D/QgVysyXSJYbLX0rZ1TqPrNxfwQu4IsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vol9jr4Z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vol9jr4Z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64CE11F00A3D;
	Wed,  9 Sep 2026 11:44:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788954269;
	bh=pgwobBPWYU8ocLZsXvpfWrT48sO/Q8RbQC+Lsr/P6V8=;
	h=Subject:To:Cc:From:Date;
	b=vol9jr4ZDBfjQPc+ayDj+VXEBPf2HEH/h5eqDIZzcwlzd1nucHYX3LvjUdi4yjjHK
	 bGuvQu3lbOpYkNSPX7x9aBrEtYAqMzG1hVOWGzVqgXh1XRjUagGDYhn5aTeln8JCoD
	 bUePOmQPVZj4/rJ2venTf79wKe9HdyVU7OZKfqGI=
Subject: FAILED: patch "[PATCH] f2fs: fix to avoid potential deadloop in" failed to apply to 5.10-stable tree
To: chao@kernel.org,jaegeuk@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 09 Sep 2026 13:26:58 +0200
Message-ID: <2026090958-easing-frolic-badd@gregkh>
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
git cherry-pick -x ce366bfa821ec81dd45bde547ee31e659306cc61
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090958-easing-frolic-badd@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

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

