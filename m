Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94C463D170C
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 11:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788954262; cv=none; b=i7EFBGUeUjuYMp94vu9OeZX1fwi2Tqp5R/fwmrrKqg2bojikYlkPZF+tAql3lhvGvGvgRaM5gS4ZgMYpG7xT+PzgMpOkWZ5YgA5b/XBgTpRFiE+o4OzaVyYOENH+7T2NHr468dWgHU3c4LXpMolZWXoG2SM2q/F9U/OxW4Mwa80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788954262; c=relaxed/simple;
	bh=cCzdcv6snDsCM/kUWjL4uP2LLNLgF7QIoY2O9MDqZKE=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=HX7yZRqIA27TkqRk5ef1M3paSRR5tN1Stt9a8j0DpJxMJoH14sT6qsp7Jf9MQ21+kVdxr38ukgka5vIeqIWkm3dFncVr9kDvR2xYU7MFC8q8keQR+nME1T9jH6/zbBaktOswkTKeXKSEaQFiOzDxgiGP50xNSkWTLqNAwlTY8mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Y1mER92a; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Y1mER92a"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0A9C1F00A3A;
	Wed,  9 Sep 2026 11:44:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788954261;
	bh=9XXZpT+6hj345qF5OKPY44jN2cvn6j9CtO46hpriGuY=;
	h=Subject:To:Cc:From:Date;
	b=Y1mER92a/pOS0mvV5CnWE9b3DDtXMT4jDW1rVWJYhuNKrdIASn4q8vK0mmox12W5S
	 UT1va9tn1VM+ezOHGuwPf/28L3jP5y/wI8T+/ODQCUpoIRmJOHvtCrgaPXC+gzCGyh
	 g0xX80DUTCBriNSK0j0u8ouY1ewyuNlb7jsGBFNk=
Subject: FAILED: patch "[PATCH] f2fs: fix to avoid potential deadloop in" failed to apply to 6.6-stable tree
To: chao@kernel.org,jaegeuk@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 09 Sep 2026 13:26:57 +0200
Message-ID: <2026090957-spectacle-juniper-fbdf@gregkh>
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
git cherry-pick -x ce366bfa821ec81dd45bde547ee31e659306cc61
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090957-spectacle-juniper-fbdf@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

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

