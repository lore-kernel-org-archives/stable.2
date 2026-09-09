Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDFE0239068
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 11:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788954322; cv=none; b=jXnKZdCbvwUeftqcVCyXZHohxNpluq+IRKaJqZBgG+EcPJpRNXMmFtHbbpy4u4UhmIkg1TBY3ZpewDvWCf3P9WzUHL86t3Pqw4umpUsboXetoP2P+hQrJZ5CNZmkTDvFopVynqFXH58LwqhUQf2cxsOU4c2I1OM3BTqZb0LY4X4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788954322; c=relaxed/simple;
	bh=P80neaN9zwvblg88BDiuWCc8EHJ01R/IXfRRsw1FyjI=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=VUoBuQH/guA95DgHwkuZv1m7KVe5ss1rwmsVXYffCJwdVtu4PIAVfmtSuMKA+7JSORwr1OmmTmhUxvWLFrn4Xggn2irM/nepIxqVNJMAyiYMg5s0E54xszCiXOUBElbLoulw8c2GlMSnngIq+CvMxIw4OazFDimEu94tRZuGUmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BrNTVJXJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BrNTVJXJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46DAE1F00A3A;
	Wed,  9 Sep 2026 11:45:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788954320;
	bh=cAKIXuP3ZIKeMNsYthAate9V5DjbUyhxXGEZMPwXRFM=;
	h=Subject:To:Cc:From:Date;
	b=BrNTVJXJDj5+cuTtHYhgYVGZpPC9Vak1yPehnNx7aftXrGQYkWU9FzCmmneF5hb6w
	 iRqE4M59l+7eGpLK62ce8nSElss9YMcvidDsXumSFcehx4iaXzLbW6PMTzHtdW4DpV
	 TWKaT0VKeklfsQiySKPXNB/yfUWmf7xwEXP05x+8=
Subject: FAILED: patch "[PATCH] f2fs: fix to reset all pinned status during fggc" failed to apply to 6.12-stable tree
To: chao@kernel.org,daehojeong@google.com,jaegeuk@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 09 Sep 2026 13:28:44 +0200
Message-ID: <2026090944-celtic-lavender-8b43@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 2b8704b6a8b2896ccad1f5941d9a3e2c5031a470
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090944-celtic-lavender-8b43@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 2b8704b6a8b2896ccad1f5941d9a3e2c5031a470 Mon Sep 17 00:00:00 2001
From: Chao Yu <chao@kernel.org>
Date: Mon, 17 Aug 2026 02:39:27 +0000
Subject: [PATCH] f2fs: fix to reset all pinned status during fggc

Otherwise, the pinned status may affect latter flow of fggc.

Cc: stable@kernel.org
Fixes: 9703d69d9d15 ("f2fs: support file pinning for zoned devices")
Cc: Daeho Jeong <daehojeong@google.com>
Signed-off-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 5917ee917d87..0c17038fcfd7 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -2183,6 +2183,9 @@ int f2fs_gc_range(struct f2fs_sb_info *sbi,
 		do_garbage_collect(sbi, segno, &gc_list, FG_GC, true, false);
 		put_gc_inode(&gc_list);
 
+		/* reset all pinned status during fggc */
+		f2fs_unpin_all_sections(sbi, true);
+
 		if (!dry_run && get_valid_blocks(sbi, segno, true)) {
 			err = -EAGAIN;
 			goto next;

