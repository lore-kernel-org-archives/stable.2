Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE6B13F4829
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 16:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788451840; cv=none; b=DCDHmuU3jrrVgZBI/biU7UwPNWtultMuUfzMDDxytoLybb7THPSmMtHZOF6Yh5TtG1RsCuPWFSooeaAH0zJsUE+EP2WWJOUuRZOuTy5nnTLh2UGiSNwEnKoH1D1piKIqVBIrOvtP8+2Rbbw3KGlK1O992xGxv1eepdXLwBpv8NQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788451840; c=relaxed/simple;
	bh=rCaRKPhaOn99/iag3XMaeLxKT54bETdWgH66PLP9b2o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FhR8uXtXKZTOzvRAdK6cU7E1x1Gm7wq7noBzj9EUNT5Dt3z+d7OezY/hq0xPe95xgdYKvk1+Bp0gTFqHMNvLIAUJ9dFvDVfwG1f+gicCDhc7NBozjog4LY/emHxvBJaMPBiKLc8AAxVnlit7XnX/aEmrQX4shIl1WH2KC9tNEik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=o+/GtrFA; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o+/GtrFA"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-38a0c7e841fso3884816a91.2
        for <stable@vger.kernel.org>; Thu, 03 Sep 2026 09:10:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788451837; x=1789056637; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=6jXanvf9fn64ahqaOzPNe+rDqChzGMSkELygw9RPMno=;
        b=o+/GtrFA5fniRkmtZtD1z8CvosgqwnPO8zkFijWGg8bExGGvtfVm4ctAvQyroanLBQ
         DpMVnRzquKX5FFP28rKoKyypkLCkAzn+uqhEJDpegRW5WYJHW/8VeiJG3YeY/uhShdGK
         Ogk5S0ZA38tMVbbz2R6BAuffXwYAmw42n/8cSDEKvBUdfahbFRFwcI77TJr5NqXv53WG
         NyP+jGGAqu4AtW2atpiDosMxSaYlBf2dr60DDmXwZIEc6B7W8zZzGlj6vWNhQ2T7X0jw
         CZok1ciOWVegjVWdgN+kST1mXPMdsplhRt5Kip1EjePPlpjzwsbqp0obMuaPv/gNmXTT
         hk1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788451837; x=1789056637;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6jXanvf9fn64ahqaOzPNe+rDqChzGMSkELygw9RPMno=;
        b=KAA3NjT28wBsjgQxLxgnpPDIKl96EkzP2vHRR0RhJlDzgOJT8DemX/T2SVkGPObndT
         smw+/xmtpCeRHE1XjpzY9zaKO10+3D9zqMZTQMCwueNEIDwZfzgx73UTgrgxYlQAo5LW
         P27qqo9dmOzQEwNl0Uw/HUuKyX0JAnqt8YG7rFXOhBdPAF3v48zad7SCHXNhiQKwzX51
         zleoDXRIqS0TKbY3PQjQ5IgLDYTkvfffPZ87WWGDjTxMmoy7VGlne9o5osMBEePdSozi
         F2j+2uyxuwvyL+cxsvCQAN5QaXjVJKTNxUoLIcvSOjuFcJT/MSyNRODSmy0UkGOGLCrl
         Is9w==
X-Forwarded-Encrypted: i=1; AKwUvByb/qu757SoZQLf90oVGDmAuOOSrWB24namRWWIMl9TjyPsyl+mtoguxSqeiPIwNPdmZTuB01A=@vger.kernel.org
X-Gm-Message-State: AFuF++ky42fpeyZ3CbQU6n/QeFZ4tmGYeggF+VfG3Dfs7qXGN0d+OBcF
	juVrgK7LjNzr5JvwU8kLYnA5IpG/7ZI0oZMEo/qGmmxgShpZVuDajr+qxY+lzQ==
X-Gm-Gg: AYBFou2HzUKNZD51yqebwBwz+XhWpVhWxz7+kGr5K8IuqR7M0Loz2elRJEkwVmkLkhd
	4FgjlT4MSiAncT9vm2GJuD+sJvikLuiFmvtTekXT8lsjn2aq9sxkeKkbKUNTKtxWItrmZ5HyuAH
	lslsZBw7DxyGUeQANjFuVBfNWosckhlMwLvg8bzrJesD9s+HEX1BDzVoQNWDBLtJOCL6++AajPe
	xjj+jFQqTGj7Tu4Z3NMqUTOxw9V44gCT9mfVXumzMvMXILRdRqYOz1oEkTK5gRalNUrYVw2yRMK
	h2g+uyzfkUs+dzv1wuhsZw7WRNhx91ymALlo9ZUqveI8Jx0A3IZWHUnnnNOoNSmlxeygGzd3Sbg
	OJhYr3O/Uxv1e0npstvSBndeUCprNk13ZZrVgCeux7ESvyvYThqDKqEIOawjcdecSVpLapYhS+P
	tHrrO1iA8NMzG1/mJ3eRKH0YeGoIbQ2dlBRHqYbedwGxm6fBBb9pLyjM39kfEb6NQJzduntYg2H
	pU/NI+/U2OzruklieG5nH/sP/JDUVi4UFbYSfSyooSP2YLWz3H2OnAVBa/vcyk8nedgQvUMCIeY
	yQFk5pcdA+U=
X-Received: by 2002:a17:90b:1c07:b0:398:9be5:b41e with SMTP id 98e67ed59e1d1-39b232e2f86mr997833a91.25.1788451836896;
        Thu, 03 Sep 2026 09:10:36 -0700 (PDT)
Received: from daehojeong-desktop.mtv.corp.google.com ([2a00:79e0:2e7c:8:21b:5fca:ed1b:b798])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39ae9087d3dsm2865695a91.3.2026.09.03.09.10.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 09:10:35 -0700 (PDT)
From: Daeho Jeong <daeho43@gmail.com>
To: linux-kernel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	kernel-team@android.com
Cc: Daeho Jeong <daehojeong@google.com>,
	Wenjie Qi <qiwenjie@xiaomi.com>,
	stable@vger.kernel.org
Subject: [PATCH v4] f2fs: drop pending discard commands before reserving device alias
Date: Thu,  3 Sep 2026 09:10:31 -0700
Message-ID: <20260903161031.1280195-1-daeho43@gmail.com>
X-Mailer: git-send-email 2.55.0.970.g62bdec98f9-goog
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
v4: limit discard commands to drop per lock round and call cond_resched().
v3: introduce cur to prevent 32-bit overflow.
v2: fix use-after-free and 32-bit overflow issues.
---
 fs/f2fs/f2fs.h    |  3 +++
 fs/f2fs/file.c    |  1 +
 fs/f2fs/segment.c | 54 +++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 58 insertions(+)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 511286432483..dda70234bf2d 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -466,6 +466,7 @@ struct discard_entry {
 #define MAX_PLIST_NUM		512
 #define plist_idx(blk_num)	((blk_num) >= MAX_PLIST_NUM ?		\
 					(MAX_PLIST_NUM - 1) : ((blk_num) - 1))
+#define MAX_DISCARD_DROP_COUNT	512
 
 enum {
 	D_PREP,			/* initial */
@@ -4122,6 +4123,8 @@ void f2fs_reserve_device_alias(struct f2fs_sb_info *sbi, block_t addr,
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
index ac0ed8609c1f..50b2f8465595 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -1873,6 +1873,60 @@ static unsigned int __wait_all_discard_cmd(struct f2fs_sb_info *sbi,
 	return discard_blks;
 }
 
+void f2fs_drop_discard_cmd_range(struct f2fs_sb_info *sbi,
+					block_t start, block_t len)
+{
+	struct discard_cmd_control *dcc = SM_I(sbi)->dcc_info;
+	struct discard_cmd *prev_dc = NULL, *next_dc = NULL;
+	struct rb_node **insert_p = NULL, *insert_parent = NULL;
+	struct discard_cmd *dc, *wait_dc;
+	u64 cur = start;
+	u64 end = (u64)start + len;
+	int count;
+
+	if (!f2fs_realtime_discard_enable(sbi))
+		return;
+
+next:
+	count = 0;
+	wait_dc = NULL;
+
+	mutex_lock(&dcc->cmd_lock);
+	while (cur < end) {
+		dc = __lookup_discard_cmd_ret(&dcc->root, cur,
+				&prev_dc, &next_dc, &insert_p, &insert_parent);
+		if (!dc)
+			dc = next_dc;
+
+		if (!dc || (u64)dc->di.lstart >= end)
+			break;
+
+		if (dc->state == D_PREP) {
+			cur = (u64)dc->di.lstart + dc->di.len;
+			__remove_discard_cmd(sbi, dc);
+			if (++count >= MAX_DISCARD_DROP_COUNT)
+				break;
+			continue;
+		}
+
+		dc->ref++;
+		cur = (u64)dc->di.lstart + dc->di.len;
+		wait_dc = dc;
+		break;
+	}
+	mutex_unlock(&dcc->cmd_lock);
+
+	if (wait_dc) {
+		__wait_one_discard_bio(sbi, wait_dc);
+		goto next;
+	}
+
+	if (count >= MAX_DISCARD_DROP_COUNT) {
+		cond_resched();
+		goto next;
+	}
+}
+
 /* This should be covered by global mutex, &sit_i->sentry_lock */
 static void f2fs_wait_discard_bio(struct f2fs_sb_info *sbi, block_t blkaddr)
 {
-- 
2.55.0.970.g62bdec98f9-goog

