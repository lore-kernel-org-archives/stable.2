Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1BC748A2AB
	for <stable@vger.kernel.org>; Thu,  2 Jul 2026 13:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782997918; cv=none; b=ReYseEFPdiFqFASlH0qkZcbaT2+4acDXKvUR4GfJ67IZv97Zlt1jtH5w3nBpm2oxTcMVKCI8kwbwLEyJzL0KxBdyh/nL56UPH2FFl/azyUXuPDMxbYxSuxGf1bemrctYbJvKkz86aZSPVLRhweXnZSprZmOzhrup7vv9zi795yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782997918; c=relaxed/simple;
	bh=w8CtDcjxsg9sQkNek4E3hrYGryZfCDb5QOhNabBV/bw=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=jRgO7ot4zZnvsr45rrF16kDSyUZrwqkzB77zGd95VqbUgQQB8hBvfUJz++GFv/kMCoHHawbGzxLxDGK+YKyCaBtJ1QUwmQc5WXJhSvBHgra7YBE/wMWEWSSn8+kVouqTV6xqzVc+4xKC+DxTWtKdmnmRFNHP4OW5Jzmmbv6iYfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ShClKOMD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ShClKOMD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0721B1F000E9;
	Thu,  2 Jul 2026 13:11:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1782997917;
	bh=NrofDYgu44W/bHPmr8hf8d8IhKQDAKSY+NhVsGZV3SU=;
	h=Subject:To:Cc:From:Date;
	b=ShClKOMDPBF4T98H6vkY7NVvQFaKFayiLuAkXd44q1m0JuQ6Bm9N5tlISKB0R7DXn
	 L2Ksz8BVivRSRT7PY/TC/Rk+tuCTFF2SFlWFL+zWMZKT3qVcNYuwKGJFa3WR3S0RIZ
	 T7dQYAUNr7W59CE8lGgMGa9aWmpclZihp6nMFH1M=
Subject: FAILED: patch "[PATCH] f2fs: avoid false shutdown fserror reports" failed to apply to 7.1-stable tree
To: qwjhust@gmail.com,chao@kernel.org,jaegeuk@kernel.org,qiwenjie@xiaomi.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 02 Jul 2026 15:11:53 +0200
Message-ID: <2026070253-matador-attention-9312@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 7.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-7.1.y
git checkout FETCH_HEAD
git cherry-pick -x 484c84ecc1a497d09239ca3a12dff3cc832830ce
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026070253-matador-attention-9312@gregkh' --subject-prefix 'PATCH 7.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 484c84ecc1a497d09239ca3a12dff3cc832830ce Mon Sep 17 00:00:00 2001
From: Wenjie Qi <qwjhust@gmail.com>
Date: Thu, 21 May 2026 18:37:48 +0800
Subject: [PATCH] f2fs: avoid false shutdown fserror reports

F2FS records image errors and checkpoint-stop reasons through the same
s_error_work worker.  The ordinary f2fs_handle_error() path only updates
s_errors, but the worker still calls fserror_report_shutdown()
unconditionally after committing the superblock.

As a result, a metadata corruption report can be followed by a synthetic
FAN_FS_ERROR event with ESHUTDOWN and an invalid superblock file handle,
even though no stop reason was recorded.

Track whether save_stop_reason() actually changed the stop_reason array
and only report the shutdown fserror for that case.  Pure s_errors updates
still commit the superblock, but no longer generate a false shutdown event.

Fixes: 50faed607d32 ("f2fs: support to report fserror")
Cc: stable@kernel.org
Reviewed-by: Chao Yu <chao@kernel.org>
Signed-off-by: Wenjie Qi <qiwenjie@xiaomi.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index b83ff4bd96ec..9f24287de4c3 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1989,6 +1989,7 @@ struct f2fs_sb_info {
 	unsigned char stop_reason[MAX_STOP_REASON];	/* stop reason */
 	spinlock_t error_lock;			/* protect errors/stop_reason array */
 	bool error_dirty;			/* errors of sb is dirty */
+	bool stop_reason_dirty;			/* stop reason of sb is dirty */
 
 	/* For reclaimed segs statistics per each GC mode */
 	unsigned int gc_segment_mode;		/* GC state for reclaimed segments */
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 629548d78db0..b277807c8185 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -4626,6 +4626,7 @@ static void save_stop_reason(struct f2fs_sb_info *sbi, unsigned char reason)
 	spin_lock_irqsave(&sbi->error_lock, flags);
 	if (sbi->stop_reason[reason] < GENMASK(BITS_PER_BYTE - 1, 0))
 		sbi->stop_reason[reason]++;
+	sbi->stop_reason_dirty = true;
 	spin_unlock_irqrestore(&sbi->error_lock, flags);
 }
 
@@ -4633,6 +4634,7 @@ static void f2fs_record_stop_reason(struct f2fs_sb_info *sbi)
 {
 	struct f2fs_super_block *raw_super = F2FS_RAW_SUPER(sbi);
 	unsigned long flags;
+	bool report_shutdown = false;
 	int err;
 
 	f2fs_down_write(&sbi->sb_lock);
@@ -4644,6 +4646,10 @@ static void f2fs_record_stop_reason(struct f2fs_sb_info *sbi)
 		sbi->error_dirty = false;
 	}
 	memcpy(raw_super->s_stop_reason, sbi->stop_reason, MAX_STOP_REASON);
+	if (sbi->stop_reason_dirty) {
+		report_shutdown = true;
+		sbi->stop_reason_dirty = false;
+	}
 	spin_unlock_irqrestore(&sbi->error_lock, flags);
 
 	err = f2fs_commit_super(sbi, false);
@@ -4654,7 +4660,8 @@ static void f2fs_record_stop_reason(struct f2fs_sb_info *sbi)
 			"f2fs_commit_super fails to record stop_reason, err:%d",
 			err);
 
-	fserror_report_shutdown(sbi->sb, GFP_NOFS);
+	if (report_shutdown)
+		fserror_report_shutdown(sbi->sb, GFP_NOFS);
 }
 
 void f2fs_save_errors(struct f2fs_sb_info *sbi, unsigned char flag)

