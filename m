Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 915F15328DE
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 11:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788954269; cv=none; b=ahNxEEg3ALlrpEFBLFADECn3NvKdULm96laUnUOqoeB4al+w7VtFFviriZ84477X/l1gij060w+qk6VtkxDds1FD7WKG+3dRkatVkUsX/5oIJuCguf8OpknY4O9z4riGvfkrHdAMwM9XTrfz/ly/cKq7ij/Z7/R9gZRLdxmle1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788954269; c=relaxed/simple;
	bh=kl6OPSWvTSMaNt1znleZJpAkwocywcD9pJU9FQ2kio0=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=G+pOs1AOpYdfmDADoCMAL5rcfVGPuJ3DbnxqALTs0h5h4w6yqLVtzo/ZWcaCgCWo4OKUJQrkRLmYX3G6NZsNkT2LuLQwz+GrAMLfT4jLLFHWewS/mgUll9mijonqPaSIxdl/sxsSlETGDp7K3QwbHL6w+QGfXK9BnaVTbWD4tAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=f4ZRQXUo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="f4ZRQXUo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 938001F00A3A;
	Wed,  9 Sep 2026 11:44:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788954267;
	bh=3DexF8S5avvmiczDvxbrrdf3uIWlhhNmpHQYwuTpiWM=;
	h=Subject:To:Cc:From:Date;
	b=f4ZRQXUo+Wmz3XCS6+M9rSq4i3GSTTEiusR10rqPFbLtCOmjKfx9c8kdB29l041XM
	 XgxVrlzYq97kyWhNQlu6sPuvNN/aermV496RCMyxvdfvYvVF4KJ89JinY5tyN+oh5K
	 nI2spyrWqsR87fap5Uy/AAVsSH/fpWk+SV+1P2DI=
Subject: FAILED: patch "[PATCH] f2fs: fix to avoid potential deadloop in" failed to apply to 5.15-stable tree
To: chao@kernel.org,jaegeuk@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 09 Sep 2026 13:26:58 +0200
Message-ID: <2026090958-plastic-payee-9f0a@gregkh>
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
git cherry-pick -x ce366bfa821ec81dd45bde547ee31e659306cc61
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090958-plastic-payee-9f0a@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

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

