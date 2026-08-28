Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDD24443E47
	for <stable@vger.kernel.org>; Fri, 28 Aug 2026 11:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787917307; cv=none; b=skFkpkK3HrA6GCIGcUp1+fcLgqTaXmyZUG1OT2rz9/XFmXp4jQs+DlqPAPp4dIB7SOrCNHevWfsGvfubYBAAaeGloVbu8PHyLTJMGKR0c1rOm3cE9Xpsj6E+iE/QGLMkJoCAm+xf7ZGQOUTEY7pyzot4It0QdBdN6nLjX5uvlvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787917307; c=relaxed/simple;
	bh=ZP6xotN5uZtQbHX3m25BhnIUixzq566HNZAVTOsxM3g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=inEwXU/cntywWLepM/a4vbgXitzjRXn/BjFVF3Ueg+geglY2OnabdIuNtnI2FQRwOskmQbAkaYo/32RJWUGKwohaUeKsYKRiZUsQmAmY0QNtr4G3FONNGdL+gsw1D+w3zntyiEwA7AksL4mItf3mxGCJEe9OvLMBaphuLtv+dSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TcdRDsQv; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TcdRDsQv"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2d72ae08fa1so7868265ad.2
        for <stable@vger.kernel.org>; Fri, 28 Aug 2026 04:41:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787917292; x=1788522092; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=zYlvfP1aWzjYvT/xolEYx3UQdxCu1UNNLVMYIqVN0H0=;
        b=TcdRDsQvF21WbY8MHHN5JdW2pTh+h3AKpqoshxDLvGnjaXbriSI+yJ+mLO7zGv5AKY
         Kjv97BaZvi5o7yhInkc/2DCl2XnjdEnwuTHyw+9BdPOIyvZPm39scb/EnWJrZ5HoFa9M
         gip2Rj1eDyNcso+MHrPfowo+QcZBgUDfemed6DOY95+ZQHtWiK/R/UedNZDs6x9BAZiK
         j1F/TLbSLY/prRIkyHzynRD1oAsVzDJiE7TT2PYvU8/UTGT8IOwKidPG8Z74A4AzTciN
         BkW2DWbZr3U4FeoDsduBT75reZrr8nvYwPbxicn3BilTSJn4vAZ43cPld5iCRQxo4Q4Z
         ypPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787917292; x=1788522092;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zYlvfP1aWzjYvT/xolEYx3UQdxCu1UNNLVMYIqVN0H0=;
        b=krj5c8sdWSZyTA8yRWCiNuy9wIqY0OMTRENhSzhLk4wVSXXr00ExGApXOBPtUcocrd
         sq3m8ml/e9rpRgFCVyG9ZlVBxwOJ276PQ9iT6cU1A9llI8gXqKLE8Wks1JAlSb/hVM+1
         aurydUCIYM5g+fh0AaYeFEbDBr218tAsAQCtJQ+UyfFb/mLjhvzE8VBeS1tXhI9VQDIo
         dKTSxuIi10IISBRbyuRrkgUJbn3Lt/Nx4W6EFXN+4y/xnImvDLnW15uFzQaJUCjXQrVJ
         uZ9tBObkK76xN1I3Xz/j5qvuRswebWP8kuhHq+Gy+X4UgtTGAvmQ8VOMg8cykKF3mGCK
         EwJA==
X-Forwarded-Encrypted: i=1; AHgh+RrRgiZvrULPsH2ve/X5Cxt8EVpXhmC7SqskCUXelge5aJS/q2yeqi+c21Hfe8MZa5e7r+3gAFc=@vger.kernel.org
X-Gm-Message-State: AFuF++kPzaBuuXQhcQFiKxFeCMhB3cPCCG/8dkJskb93QMXEzxkmabMN
	GqoyzgLK8jcDxRf7j/bEEc/Zwxf+hYuqbKFAO3qAwiFbku6iULNDnSYS
X-Gm-Gg: AR+sD11BVV2ZUUbyOGVp0pkagT/ZRsFvwjKAfp7Q8cV4uh17R+V2JHVV0qP5hZbE3KF
	e3fU9+hLWFLJNSgpKf+rNZlZJYdMnNnWAT0BJWFojzqTggMXVAKKuh3bLeYL1GW7KBGWiGxU+Xi
	vMS2F1d4VpsER1ry3nozCiIItFm8dFI09PpqY3R1L7bcq1wKuSL+zy32CCGPVBIJ3jr2SFpKUSu
	jSnhPgLvCjYkzEsvd2KBPpnSsfuhgsLfDgdB8jTTydxMLOke1Ek05nPrlKSQqISf5PK8CJur/s8
	xcdeswxePlawi8SBAex+HkTc4h92bDfbYpTKQ/O85qGKqMMlPBSp0CRIt7G5v7cSRBo6g80k/l9
	HgjEOoOuth9MJEhXatygy5midSYkt/54oir1QNil0A+o6N3Yo6g8kx6u4se2ckVAWlIZ3GlzVBu
	1gxeg5uyjbHngDJYjmxgk+nWWYYxJwRqhsiE4bNH1zEukYZlNmkFP1WmGv6Y9xPdjsqYMMDb7iD
	BbB/u/8g1CPQd1Gca8mxgG1
X-Received: by 2002:a17:90b:4fc7:b0:395:bbfe:fc6f with SMTP id 98e67ed59e1d1-396d0e26cb3mr13722493a91.3.1787917292018;
        Fri, 28 Aug 2026 04:41:32 -0700 (PDT)
Received: from qiwenjie-ThinkCentre-M760t.mioffice.cn ([43.224.245.241])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-396b0fcfa3asm6888747a91.6.2026.08.28.04.41.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2026 04:41:31 -0700 (PDT)
From: Wenjie Qi <qwjhust@gmail.com>
X-Google-Original-From: Wenjie Qi <qiwenjie@xiaomi.com>
To: jaegeuk@kernel.org,
	chao@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	stable@kernel.org,
	qiwenjie@xiaomi.com,
	qwjhust@gmail.com,
	daehojeong@google.com,
	stable@vger.kernel.org
Subject: [PATCH] f2fs: sync pending discards before reserving device alias
Date: Fri, 28 Aug 2026 19:41:25 +0800
Message-ID: <20260828114125.637513-1-qiwenjie@xiaomi.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A released device-alias range can accumulate pending discard
commands. The reserve path then marks the same range valid again
through f2fs_reserve_device_alias() without first synchronizing
those discards.

If the discard thread later submits one of the stale commands,
__check_sit_bitmap() can still see valid blocks in that range and
trigger a BUG.

Synchronize pending discard commands in the alias range before
making it valid again.

Fixes: eae3faf210bd ("f2fs: support dynamic reserve/release for device aliasing")
Cc: stable@vger.kernel.org
Signed-off-by: Wenjie Qi <qiwenjie@xiaomi.com>
---
  kernel BUG at fs/f2fs/segment.c:1228!
  Oops: invalid opcode: 0000 [#1] SMP DEBUG_PAGEALLOC KASAN PTI
  CPU: 1 UID: 0 PID: 79 Comm: f2fs_discard-25
  RIP: 0010:__check_sit_bitmap+0x2e1/0x4e0
  Call Trace:
   __submit_discard_cmd+0x921/0x1140
   __issue_discard_cmd+0x524/0x12f0
   issue_discard_thread+0x686/0xe20

 fs/f2fs/f2fs.h    | 2 ++
 fs/f2fs/file.c    | 1 +
 fs/f2fs/segment.c | 9 +++++++++
 3 files changed, 12 insertions(+)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 16720f1f0a9..2b9c6bf310b 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -4067,6 +4067,8 @@ int f2fs_start_discard_thread(struct f2fs_sb_info *sbi);
 void f2fs_drop_discard_cmd(struct f2fs_sb_info *sbi);
 void f2fs_stop_discard_thread(struct f2fs_sb_info *sbi);
 bool f2fs_issue_discard_timeout(struct f2fs_sb_info *sbi, bool need_check);
+void f2fs_wait_discard_bios(struct f2fs_sb_info *sbi,
+			    block_t blkaddr, unsigned int len);
 void f2fs_clear_prefree_segments(struct f2fs_sb_info *sbi,
 					struct cp_control *cpc);
 void f2fs_dirty_to_prefree(struct f2fs_sb_info *sbi);
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index d440231b8cb..58cea2aa314 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -3847,6 +3847,7 @@ static int f2fs_ioc_reserve_dev_alias(struct file *filp)
 	write_unlock(&et->lock);
 	clear_inode_flag(inode, FI_NO_EXTENT);
 
+	f2fs_wait_discard_bios(sbi, ei.blk, ei.len);
 	f2fs_reserve_device_alias(sbi, ei.blk, ei.len);
 
 	i_size_write(inode, (loff_t)ei.len << sbi->log_blocksize);
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 1e7e745be71..7f4fe8c34c2 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -1916,6 +1916,15 @@ static void f2fs_wait_discard_bio(struct f2fs_sb_info *sbi, block_t blkaddr)
 		__wait_one_discard_bio(sbi, dc);
 }
 
+void f2fs_wait_discard_bios(struct f2fs_sb_info *sbi,
+			    block_t blkaddr, unsigned int len)
+{
+	block_t end = blkaddr + len;
+
+	while (blkaddr < end)
+		f2fs_wait_discard_bio(sbi, blkaddr++);
+}
+
 void f2fs_stop_discard_thread(struct f2fs_sb_info *sbi)
 {
 	struct discard_cmd_control *dcc = SM_I(sbi)->dcc_info;
-- 
2.43.0
