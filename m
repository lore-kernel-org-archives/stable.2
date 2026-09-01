Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4920E392807
	for <stable@vger.kernel.org>; Tue,  1 Sep 2026 03:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788232209; cv=none; b=udletO1l9UZ5lyVPSIngJz5wLw9CKr+ZjPjabP8gFYeqMy6iusaJLP/Ql40sn2wcgUVAj864YfEiqMxiPQ3V0x0YjKrk04qJzGVt3jkAF0zlZ6mDeoTZE5DUfdFEu5ZDkeEkEdcJurg5ifOp7f4ewVgj7oKDbIwQYsvrRNJL9UE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788232209; c=relaxed/simple;
	bh=qy5FZin1DQnIKkAgcLzW0Ff2Z/55M3DZWx56LqvQYuQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PMIu+Uc4Sj+U2Xs2BACcv1SHlCtkaDr2czsdJFdZuSqWCXqFaAA87o6UN8M/z2KTdw/S3uE+k1frGEkBxrFHploq1sjZyPlXnaSMN4ggqRd1NMc1QwkOuO3GSOU9INT6QARr74voIepbpRgyo9y/c3G7sGCuR1cQeo8nPsmMxrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TvoqvNRQ; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TvoqvNRQ"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-cc1cf287ef8so4022927a12.3
        for <stable@vger.kernel.org>; Mon, 31 Aug 2026 20:10:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788232205; x=1788837005; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=S2rSlvlJ6/XqKt2WEd0a/Wwq0kiDGRS7GpjIC1W/pmU=;
        b=TvoqvNRQkXqNmm5PLQr6PsnabbdfRcJINuiEFZc4X2ft/d6eWGWvTAeknLOJ5yjjlM
         aFJ+Ry2EMUmiOikva2+McyXghbhY9cRfhjqGPOU9hukOHk86AC4hMPQJGSx3J0ZEeaCe
         0DYNh/AU2byTBuHdZ+Rkf+4YsMLSGExidqgcJ6kfg5x8W6dUy/U+oGC4L4scjtrUJZfT
         DOug+hmokvxFEIqHXYEYyBC+oeV102lGTBrRvl6AlsTytapdr+wri0qKBXzdkBF19x/Y
         HkWvZpZwVIt+aeyi8WX6pnEVdt0qqLyILgEk3oEXzmDAS5OiVqibaT6M+q+VlWfZ5KJf
         YMqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788232205; x=1788837005;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=S2rSlvlJ6/XqKt2WEd0a/Wwq0kiDGRS7GpjIC1W/pmU=;
        b=PvD9MZ6wnqiC7mks0hA231XW8fMdXQy6BsMFzJbX1ciu7YTBGjM5BxTz2KCwBKs29e
         3SGJGdaOxA7q91VlRpSN0jFtN7F6W+NoPXn6IAsQnfaQcOeFihD096j+3LhDhg8TL54T
         ugQGwr6bWPYoG2/dy8wJv5tnreTusTWNVTIN97DiQ/7kGxzAWKqQh1SIOVONb731KZLq
         RFhmswcQVWHxg7U55Og/AF98t6DxthMf6KiSvZchRsfTX80xEcqm8XRUmUS4O1PN1qao
         cWYU2I2fxL2m0G6D2LbOC0my5BbDZz2cSVjO7uM+I3vEMxT+2Cbn9KgbAplmGbRXOH/B
         XKUg==
X-Forwarded-Encrypted: i=1; AKwUvBwkx6NMnXLi1RvaEGHvvMPNXBfGGwiZhP2RfMrz8lxSfGU1PRXkRRjZQSYYzCMnP6q0x5T5j58=@vger.kernel.org
X-Gm-Message-State: AFuF++lVVwB/DuLAMp24RYNX0u3ZZwhqOyDEg2UniBl+TGTPBI4aCIdx
	2P1VWvDfpvA+w5e9h1kocc90RpR73jFNgOq1RMf3Ik+3sDx2GP+fpahE
X-Gm-Gg: AYBFou1KikgJ4010TVo4c2ekMFdUubcDK+sK3zAzwEK6xDqJI5IXTOSkETg+yhnf3s7
	I0BbHexDhkdr/NGZ4oJWkCPLptNCuwqsIw1WZTaGwjvSJsgbrYfN3ciHX/vVkDksqSLaFms+O27
	c7Q1/CzLTNOWQ/VliSuT+v33Lj2XhDdybEv1OqpRH5GMK5aa59rFF/1ppo79LnFlhxjlM8ZZfNx
	tXBvZQGnueqd++nKelGfIY+VLpaSGov2x7hYx9agtNlGqFBnIy9WF7c8hDza4aY6EPcF68Z7ZGP
	fmyYO3ejPYlM/bkAw42dNwY9uKIUqmFcdRk256cKKEEiKX3ibLSiqGAe4i1zszLY1ZV9qSbeOQE
	FaDq1wa6tmvgnHZFqSe8QD4UbzD0SRbV7myUvvq6OGm40zwg+jJ7j/G1skavJxlTB+gJ8hbLhEa
	/btvBSJ9AkGSKaIxoohyTJz2usnLL/uCY7GW5WowHOZXU2a9dvSZD2PRPAGauXBBldT9uxRx+pF
	d8rT2A1faewAyn9JR+8V9Ah8E1G6qI1LAvpXE40M22zCMGcK7T4bYyB91N/9Wk4SZFW7OT05dqs
	XjPnotrDlryf
X-Received: by 2002:a17:90b:1d05:b0:396:65dd:4093 with SMTP id 98e67ed59e1d1-396d0ff519cmr47226275a91.14.1788232205233;
        Mon, 31 Aug 2026 20:10:05 -0700 (PDT)
Received: from daehojeong-desktop.mtv.corp.google.com ([2a00:79e0:2e7c:8:94f2:e160:f659:7f83])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-142e0df264csm55297430c88.14.2026.08.31.20.10.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 20:10:04 -0700 (PDT)
From: Daeho Jeong <daeho43@gmail.com>
To: linux-kernel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	kernel-team@android.com
Cc: Daeho Jeong <daehojeong@google.com>,
	Wenjie Qi <qiwenjie@xiaomi.com>,
	stable@vger.kernel.org
Subject: [PATCH] f2fs: drop pending discard commands before reserving device alias
Date: Mon, 31 Aug 2026 20:10:00 -0700
Message-ID: <20260901031000.786214-1-daeho43@gmail.com>
X-Mailer: git-send-email 2.55.0.897.gb25b4bd76c-goog
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Daeho Jeong <daehojeong@google.com>

When reserving a device alias via f2fs_ioc_reserve_dev_alias(),
f2fs_reserve_device_alias() bulk-marks all blocks in the target device
range as valid in SIT.

However, if the device was previously in the released state, stale
pending discard commands covering that range may still exist in dcc->root.
When f2fs_issue_discard_thread later processes those commands,
__check_sit_bitmap() detects valid blocks in the discard range and
triggers a kernel BUG().

To fix this:
1. Introduce f2fs_drop_discard_cmd_range() to traverse the discard rbtree,
   drop all pending D_PREP discard commands in the range,
   and wait for any in-flight discard bios under dcc->cmd_lock.
2. Call f2fs_drop_discard_cmd_range() in f2fs_ioc_reserve_dev_alias()
   before f2fs_reserve_device_alias().

Reported-by: Wenjie Qi <qiwenjie@xiaomi.com>
Fixes: eae3faf210bd ("f2fs: support dynamic reserve/release for device aliasing")
Cc: stable@vger.kernel.org
Signed-off-by: Daeho Jeong <daehojeong@google.com>
---
 fs/f2fs/f2fs.h    |  2 ++
 fs/f2fs/file.c    |  1 +
 fs/f2fs/segment.c | 45 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 48 insertions(+)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 511286432483..ae109d3ae571 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -4122,6 +4122,8 @@ void f2fs_reserve_device_alias(struct f2fs_sb_info *sbi, block_t addr,
 bool f2fs_is_checkpointed_data(struct f2fs_sb_info *sbi, block_t blkaddr);
 int f2fs_start_discard_thread(struct f2fs_sb_info *sbi);
 void f2fs_drop_discard_cmd(struct f2fs_sb_info *sbi);
+void f2fs_drop_discard_cmd_range(struct f2fs_sb_info *sbi,
+					block_t start, block_t len);
 void f2fs_stop_discard_thread(struct f2fs_sb_info *sbi);
 bool f2fs_issue_discard_timeout(struct f2fs_sb_info *sbi, bool need_check);
 void f2fs_clear_prefree_segments(struct f2fs_sb_info *sbi,
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 29cf82d02c77..0b2d173d9597 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -3855,6 +3855,7 @@ static int f2fs_ioc_reserve_dev_alias(struct file *filp)
 	write_unlock(&et->lock);
 	clear_inode_flag(inode, FI_NO_EXTENT);
 
+	f2fs_drop_discard_cmd_range(sbi, ei.blk, ei.len);
 	f2fs_reserve_device_alias(sbi, ei.blk, ei.len);
 
 	i_size_write(inode, (loff_t)ei.len << sbi->log_blocksize);
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index ac0ed8609c1f..bc36af1a4247 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -1873,6 +1873,51 @@ static unsigned int __wait_all_discard_cmd(struct f2fs_sb_info *sbi,
 	return discard_blks;
 }
 
+void f2fs_drop_discard_cmd_range(struct f2fs_sb_info *sbi,
+					block_t start, block_t len)
+{
+	struct discard_cmd_control *dcc = SM_I(sbi)->dcc_info;
+	struct discard_cmd *prev_dc = NULL, *next_dc = NULL;
+	struct rb_node **insert_p = NULL, *insert_parent = NULL;
+	struct discard_cmd *dc;
+	block_t end = start + len;
+
+	if (!f2fs_realtime_discard_enable(sbi))
+		return;
+
+next:
+	dc = NULL;
+
+	mutex_lock(&dcc->cmd_lock);
+	while (start < end) {
+		dc = __lookup_discard_cmd_ret(&dcc->root, start,
+				&prev_dc, &next_dc, &insert_p, &insert_parent);
+		if (!dc)
+			dc = next_dc;
+
+		if (!dc || dc->di.lstart >= end) {
+			dc = NULL;
+			break;
+		}
+
+		if (dc->state == D_PREP) {
+			start = dc->di.lstart + dc->di.len;
+			__remove_discard_cmd(sbi, dc);
+			continue;
+		}
+
+		dc->ref++;
+		start = dc->di.lstart + dc->di.len;
+		break;
+	}
+	mutex_unlock(&dcc->cmd_lock);
+
+	if (dc) {
+		__wait_one_discard_bio(sbi, dc);
+		goto next;
+	}
+}
+
 /* This should be covered by global mutex, &sit_i->sentry_lock */
 static void f2fs_wait_discard_bio(struct f2fs_sb_info *sbi, block_t blkaddr)
 {
-- 
2.55.0.897.gb25b4bd76c-goog

