Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80F1F3128A3
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 11:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788954327; cv=none; b=b9QfBmBbjhdPF2s+QPO4MpIHrw6+Yx/DoBnooctbSKbvBskXiXFoOaVRQ9umi4qsdypsM9/aH263Bd+J5NgzMpFyNC1Y8u1goafoS7BVPCtVDQRxYPSLoHxurAa3ykSseaeHX3VIFXebM8lCbvfGL/PKzTC1tvsi6L0ICchR+2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788954327; c=relaxed/simple;
	bh=TYxY/8mnvjQw9E6zhr9Ab5RuQHECnNa7mv0ZtLKkFUQ=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=eaDNl9Gix5kIKePpEOyJiLkztcjdkn0xcGRw3jTwfk4qhXo68e1HoiiFuITcj8FCqAzjjOxXTsANU022GGnD/qsZ+UcLF5E7KFU5i7s/SdKQtxSsBmIBt9TVeI7hK+OP7Cvuc2J6iIBbLfdQTalpWgx5F2CFvSdVmy7WJMn5XLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zb0lGZkb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zb0lGZkb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D90691F00A3A;
	Wed,  9 Sep 2026 11:45:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788954326;
	bh=tyUVXZK9o9RlvY49dONWHm3DIX8HMx3sQaDpgbrhpB0=;
	h=Subject:To:Cc:From:Date;
	b=zb0lGZkbcQFKYv7xNmEgtZdgwsPL/K2Y5c1a8RMY0tU9/v3nMu6gKT70Z94TZPNNt
	 5lyXLtAnTR7Mlzkp7NV1dfBkJaAupqvLAbsefnZE6xxtNWwrb9o1ufounZ3mMXOjUh
	 oNdDp8couJpyi7/9b0D//UHg/NZg9/e/ARW4bSYU=
Subject: FAILED: patch "[PATCH] f2fs: fix to reset all pinned status during fggc" failed to apply to 6.6-stable tree
To: chao@kernel.org,daehojeong@google.com,jaegeuk@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 09 Sep 2026 13:28:45 +0200
Message-ID: <2026090945-delicacy-nutmeg-a9dc@gregkh>
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
git cherry-pick -x 2b8704b6a8b2896ccad1f5941d9a3e2c5031a470
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090945-delicacy-nutmeg-a9dc@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

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

