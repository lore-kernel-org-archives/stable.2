Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C118D3A16AC
	for <stable@vger.kernel.org>; Thu, 18 Jun 2026 10:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781777111; cv=none; b=gnKplmm69wicWRdW8VvTmFsNJ81K/z2DsPNu7f/g9PFCD7iVI3yHJwudhOPlMI9u1YjlkYKcfP/p61dT911Y1tc5Sv0RMIdqKsz+SOIACeyEzVFzgJSrSQR8HTRlm2jEVfQ7vhOum+NrF2M6NRt/PgFR/w+3OcApPghoE6o79ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781777111; c=relaxed/simple;
	bh=tOECJBywebu+saExiqB0YCxA6n676ooEyMoopSIP1u8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TDM2iPZN0GOeROgSj0W04p5q+y9UqrGKC2GLIVWYrslcCDXRNm/dF7I1Fb0hy+oy7s8dsR8np0No/xWE7iYPXh8SP4NAXPpcMDHGBuO0YZjahMLPG6aOHJxtCDG2rf72DTZOK5b7yrlCDSGn/p6TkI/ob0Fy8j8ZGQhLw/ySxnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EsueAo2O; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EsueAo2O"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2bf1f074a12so7688895ad.0
        for <stable@vger.kernel.org>; Thu, 18 Jun 2026 03:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781777110; x=1782381910; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TY/9FT+PDtEpOIfJhnw0JCzsZKJe7D7sP4UeY0Af9zo=;
        b=EsueAo2OPKHjXY5+nc9Pkg6NWOrdNs+WoVmfQkSshwfIlNQ+Fy8v5gaOjXwgEHwrUc
         b5y+xFide8INFVRIt4EMP2zMu8N+/ZyJtCvRz7uS4MY62r9Hgf+bkSKgM4JsNGROpCtk
         o9gS1W+/0ZzBdaYNUOws8MhmmSaXFlm79xp191+RuXkt5d6yyGx8SN8AaV2689JV3zka
         WNJOQz/7iGGzkxv7EIRKb5AsgS2J5f7tmUN2P+dr1KaMLpGUbY8c+yuXkzXYv6k783oI
         hGXTvx0aNDu6gaRRI/As5A1+iA5vGDhxX8TC/iMo/2ZBifX/Av09vbcbGxHsS9hgs9DX
         nrUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781777110; x=1782381910;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TY/9FT+PDtEpOIfJhnw0JCzsZKJe7D7sP4UeY0Af9zo=;
        b=UQY71C5NFNCuxuDVwpPzdZtYyxQD70asVJUT3GomD+8w+6wQNT47wbSs7KkGzpPtXg
         Fe0QRGU/PB48SRxEuSqZvQz8rL1Uf3gMCs0jPUV4XzdB4PxqvIvSR+5naul3sivdn9Vx
         WYIQjG03UVY9ZHLH3Bqi9zmkM+vvfLxRE1alMkxd5pQpJu4++5YvEShtv/38NvvqQngD
         Q6ZORuQpHKYUazedDtoLz1aMKuscx4zgZ6r8s52OoSUAQieNgs3LSZivzdKVi9uu5UkC
         4piteAmcZVY3R93GLlYHCtrg6x7Z2wgydd57qXP38Za+AW+hZnpcF9r57wh0eaNprFz9
         OX6w==
X-Forwarded-Encrypted: i=1; AFNElJ95bkSdIR2ToM2xPkA5WZOcp6b/a8kmO/gZqvdebVUUcg9GWyQQ9DE0G8bnRseGEtSm5iBQDGc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwscqlfGbXTiZvDft4xWcink0qV8HZR0NiJDSFYsorGqEqoWmMk
	47A1sLwehcmp2+wauIeW2GTtmwV+6G0FyRaRJICar9mrEWGV7l1Gof5f
X-Gm-Gg: AfdE7cmuoLmujW+dRndEEiL+YIJwShws4keMJR3WrhaTGBZp/BMjjyy1RQB2Xhp9Y8x
	1rmucFg/XXfWv7ZLTQnQT4p1laBYkXQxX4XzK9HZpQb10dY/kbpFGz7YenUjn+Zj6q48LTHMU2c
	6PzSwMziCmgDtbEpFfy3f45LF44turIsjZfkSIUhUgGxXYsHSKwbd0iPVzT8jfF3QkkMjCXZy7P
	v75ThaRCLoqjbbarrOEEhjnXDgpXBfy9n7Xr+oU+CYP8Sd8T7SGv/KYY53J+1UZTN2TsnGeZn7C
	BLNuBVCCDbwvT7kO7V6vcdE69/UIqDxDYbn0tSnaWJ5dFpmBpFjAeLkaQGxEudtnUbF6ln403Zu
	CiPr8tQDP29IFuVAG7QmcTcgl+xuz90cWiIgrvytiWfdExeBfml8c0g+R9xD7Lz1+fYQtSQCckB
	DX6t3YNk503j46qUXMVqt1b8mtaCBe0SPuSZ3SLN/ic3Ax8/R7
X-Received: by 2002:a17:903:2a83:b0:2c6:9758:9db2 with SMTP id d9443c01a7336-2c6bbf8d3a0mr87843155ad.3.1781777110131;
        Thu, 18 Jun 2026 03:05:10 -0700 (PDT)
Received: from qiwenjie-ThinkCentre-M760t.mioffice.cn ([43.224.245.241])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c42fbb4134sm173786545ad.30.2026.06.18.03.05.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2026 03:05:09 -0700 (PDT)
From: Wenjie Qi <qwjhust@gmail.com>
X-Google-Original-From: Wenjie Qi <qiwenjie@xiaomi.com>
To: jaegeuk@kernel.org,
	chao@kernel.org
Cc: geoo115@gmail.com,
	stable@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	qiwenjie@xiaomi.com,
	qwjhust@gmail.com
Subject: [PATCH v7] f2fs: use post-decrement count for cp_wait wakeup
Date: Thu, 18 Jun 2026 18:05:03 +0800
Message-ID: <20260618100503.2601790-1-qiwenjie@xiaomi.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

f2fs_write_end_io() decrements the writeback page counter and then reads
it again with get_pages() to decide whether the last F2FS_WB_CP_DATA
completion should wake cp_wait.

That second read can miss the zero transition as below:

checkpoint          end_io A              submitter B
- f2fs_wait_on_all_pages
 - get_pages() > 0
 - prepare_to_wait(cp_wait)
 - io_schedule_timeout
                    - f2fs_write_end_io
                     - dec_page_count
                      : count 1 -> 0
                                         - f2fs_submit_page_write
                                          - inc_page_count
                                           : count 0 -> 1
                     - get_pages() > 0
                       : skip wake_up(cp_wait)

The checkpoint thread can then keep sleeping until
DEFAULT_SCHEDULE_TIMEOUT, even though end_io A completed the old last
F2FS_WB_CP_DATA page.

Use the post-decrement value for F2FS_WB_CP_DATA completions so the wakeup
decision is tied to this completion.  Keep the existing dec_page_count()
path for other writeback counters.

Fixes: e234088758fc ("f2fs: avoid wait if IO end up when do_checkpoint for better performance")
Fixes: ce2739e482bc ("f2fs: fix to avoid UAF in f2fs_write_end_io()")
Cc: stable@vger.kernel.org
Signed-off-by: Wenjie Qi <qiwenjie@xiaomi.com>
---
 fs/f2fs/data.c | 12 +++++++-----
 fs/f2fs/f2fs.h |  6 ++++++
 2 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index d83a21998ec2..2afdcd209d54 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -392,15 +392,17 @@ static void f2fs_write_end_io(struct bio *bio)
 		if (f2fs_in_warm_node_list(folio))
 			f2fs_del_fsync_node_entry(sbi, folio);
 
-		dec_page_count(sbi, type);
-
 		/*
 		 * we should access sbi before folio_end_writeback() to
 		 * avoid racing w/ kill_f2fs_super()
 		 */
-		if (type == F2FS_WB_CP_DATA && !get_pages(sbi, type) &&
-				wq_has_sleeper(&sbi->cp_wait))
-			wake_up(&sbi->cp_wait);
+		if (type == F2FS_WB_CP_DATA) {
+			if (!dec_page_count_return(sbi, type) &&
+			    wq_has_sleeper(&sbi->cp_wait))
+				wake_up(&sbi->cp_wait);
+		} else {
+			dec_page_count(sbi, type);
+		}
 
 		folio_clear_f2fs_gcing(folio);
 		folio_end_writeback(folio);
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 9f24287de4c3..db750cef371d 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -2776,6 +2776,12 @@ static inline void dec_page_count(struct f2fs_sb_info *sbi, int count_type)
 	atomic_dec(&sbi->nr_pages[count_type]);
 }
 
+static inline int dec_page_count_return(struct f2fs_sb_info *sbi,
+					int count_type)
+{
+	return atomic_dec_return(&sbi->nr_pages[count_type]);
+}
+
 static inline void inode_dec_dirty_pages(struct inode *inode)
 {
 	if (!S_ISDIR(inode->i_mode) && !S_ISREG(inode->i_mode) &&

base-commit: c0b65f6129c7fbb526e921dd60261650f1b2bef9
-- 
2.43.0

