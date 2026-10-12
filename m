Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2331A33A70A
	for <stable@vger.kernel.org>; Mon, 12 Oct 2026 10:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791801398; cv=none; b=YUzlZ7cs7uV6wUM8GnLjBZCoIrY3TS3soHWDBlaZp897lbiHKcnMhJs9aYFv76B9rYkddfX+8D5UKjmKGLg58H60YwCHhTrBP2M6z//s/MFglSMqa9OezY5UKoayEoXJZwASrhbOu0MR7hK3yQ0c1CVfCXRyKttAlkmPWN17O7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791801398; c=relaxed/simple;
	bh=vo0Hl07Qqko7mQZRjYiWFQP4SZWCCuH0QSkXVILJeyg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Kexvwa07gW+XxV3XffHjmvbl0SgLH58GB/8bT5qwgli37f1yCYgGOa9qBmf/qed95p/wp4UmJHgatu9uxOnsego0kfOK4KoFsz40but5xi+HSLI49sQhm03ZKA6V81HXwmo+ncCS2s5GDW/newQW+9bA7H4rFQOEd02+T2n1QUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MqipxnQy; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MqipxnQy"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-88bd2b44f3aso733870b3a.0
        for <stable@vger.kernel.org>; Mon, 12 Oct 2026 03:36:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791801396; x=1792406196; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=TYAbLfcSF4SvwtGMEqZtL/vm+XSKpgh03MXVN46JE/A=;
        b=MqipxnQy1+m2axV8MIzADNTBxfHw4UnA2F+roj3C6z2QBLM+RixPvxGHPGBDkik+dA
         vJm9whXqRJTfcFEPXwOTEpFEv9lqOtqpZ0WAL0IOeiJ8SeLLI6ScLyl8HTbnVHJKZL1c
         xnjLhIsrO6yiOcmBSKw9mNC3uiZG049TOIRBazEYnmK2JQh0SZjceHAweFYOVN3Rlf8j
         oTPjkJIR6+A+19JSas7XvLBpGKwXpZ1JQsj5bh08LYRMvqGLRkVvVunSkcFQ+7xaU7S5
         xFBmW80NL5XBCHAPowhl/u0w9mfhBL2qJd2ivospesr3kZADilAch6nfNdCtFfI5uxuE
         8PFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791801396; x=1792406196;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TYAbLfcSF4SvwtGMEqZtL/vm+XSKpgh03MXVN46JE/A=;
        b=f8w8G4iCK5ZtKKUYF/fC0rfrJSVVDUiJfSLBrQGvcjcLeGJa41cQPdmx/waGQNrMjb
         ONpH1FvJ5E/3mMIC7Vc+x4Jkf92SCgzs0cP/IRG9+uhOYmHYywmdPDI8JxsfuWx63Pe8
         3IhX+rW+lkh/23hnbkZxYW8N1AZ/+wsOZFUJPFd4PUd+PTqOBkJCW+YMfKYmj9SxiI5H
         XdfTAnysBnbjD1/rI9E+zxtkfMz+SNa+eLFvrzdgE9M5AP3EFQ8x+fZ0bSFb6HBx4lyV
         gaFNWosKJutUjqfBd1XW3QhxQZ1YgHtreWTwdtsvFRYegruvRRnLdlnE2Ckdmtf69dvT
         cN4w==
X-Forwarded-Encrypted: i=1; AKwUvBx3WCQapIydnQo79K/ScBEmXVMZ0ibIwvaXBGv7ymF5qrTvNJBPeX1PrU6Q/RoEtkX4aP7xlA4=@vger.kernel.org
X-Gm-Message-State: AFq9FYL5913GsXroEXj+zhhox7PVjvtbABJPIlADTz8sfmwCBUhsn9/p
	xv/P90m9RspMc4fpAcCBGRTQwdOiAcFq6Q4o3ws3loWf5avjkhOIZGV8
X-Gm-Gg: AYBFou2VZ5KvbBaa08LChOJfBW595EGLHBKhSG7yy0WQ/WcKs4iSTYS0yVd5mdH4FKo
	xB5y68/exsZjG/IOvbD/+J6sLf3fgQI3/1gcFMx7Uio6Yg/ybgEH4K6D6VQyGwqOsDJcKck0mt4
	mM7Bm2jdElyZxFPohTMrs4iOT5jM8u8+qhyec5uujYXqYgaCMVN8Rn54G8RpStEYO66e+dDeDao
	721+JWcpAx4TEh9+jks0XOpqQtnhm3zeJ+VPH5ylNdL1x2cCtGaqX4EHdbdlk+3W/Y3OdMIitrI
	Sy5sKWeobMKuanmhKFI1BSNvmotVigUjOlWY7c51YhIMJ7vJEdVqsPIFeRNt5aX0OgSCgZXt8RV
	2St+H2zujEC7y1g4sVZvvGBx7tqH7YXQJJLlWIbjDouuFaF8g4EnhABHZnqcLQe/nn64mLfSd8z
	JaLN+6y60ZwmZeoqMUCFYFlFhK8qdhOs3nsBd4Ua5AONrXjpG5vgvW9uk+R4e6FSi5fPlS1p5Lq
	WeH5RXRLjC0wBo88GoaWjFwL3gEilUPygc=
X-Received: by 2002:a05:6a00:856:b0:886:b762:8bfd with SMTP id d2e1a72fcca58-897c7cd10efmr7613646b3a.51.1791801396300;
        Mon, 12 Oct 2026 03:36:36 -0700 (PDT)
Received: from qiwenjie-ThinkCentre-M760t.mioffice.cn ([43.224.245.241])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-896c4996be6sm4019639b3a.58.2026.10.12.03.36.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 03:36:35 -0700 (PDT)
From: Wenjie Qi <qwjhust@gmail.com>
X-Google-Original-From: Wenjie Qi <qiwenjie@xiaomi.com>
To: Chao Yu <chao@kernel.org>
Cc: Jaegeuk Kim <jaegeuk@kernel.org>,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	qiwenjie@xiaomi.com,
	qwjhust@gmail.com
Subject: [PATCH] f2fs: wake up foreground GC waiters when the GC thread skips a round
Date: Mon, 12 Oct 2026 18:36:29 +0800
Message-ID: <20261012103629.1763003-1-qiwenjie@xiaomi.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With GC_MERGE, f2fs_balance_fs() queues a foreground caller on fggc_wq,
wakes the GC thread, and sleeps without a timeout or condition recheck.

The root cause is that a foreground writer, the GC thread, and fsfreeze
can race as follows:

foreground writer                  GC thread                  fsfreeze
- f2fs_create
 - f2fs_balance_fs
  - prepare_to_wait(&fggc_wq)
  - wake_up(&gc_wait_queue_head)
  - io_schedule()
    waits on fggc_wq                                    - freeze_super()
                                                         - frozen =
                                                           SB_FREEZE_WRITE
                                                         - sb_wait_write()
                                                           waits for writer
                                  - gc_thread_func()
                                   - waitqueue_active(fggc_wq)
                                     returns true
                                   - foreground = true
                                   - frozen >= SB_FREEZE_WRITE
                                   - continue
                                     no wake_up_all(&fggc_wq)

The writer keeps its superblock write reference while sleeping. fsfreeze
waits for that writer, while the GC thread loops because the queued waiter
keeps waitqueue_active(fggc_wq) true.

Wake foreground waiters on each early skip. A skipped foreground-GC round
must not leave its caller blocked.

Fixes: 5911d2d1d1a3 ("f2fs: introduce gc_merge mount option")
Signed-off-by: Wenjie Qi <qiwenjie@xiaomi.com>
---
Reproduced on a 512 MiB F2FS image mounted with gc_merge, filled and
fragmented under concurrent inode creation. The kernel reported:

  INFO: task sh:1381 blocked in I/O wait for more than 20 seconds
  Call Trace:
    io_schedule
    f2fs_balance_fs
    f2fs_create

The SysRq task dump showed fsfreeze in freeze_super.part.0. An NMI
backtrace reported:

  CPU: 2 PID: 229 Comm: f2fs_gc-254:0
  Call Trace:
    gc_thread_func

The f2fs_gc kthread also consumed 301 ticks in three seconds at
USER_HZ=100.
---
 fs/f2fs/gc.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 926e6976bc2..086670f9df2 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -66,6 +66,8 @@ static int gc_thread_func(void *data)
 
 		if (f2fs_readonly(sbi->sb)) {
 			stat_other_skip_bggc_count(sbi);
+			if (foreground)
+				wake_up_all(&gc_th->fggc_wq);
 			continue;
 		}
 		if (kthread_should_stop())
@@ -74,6 +76,8 @@ static int gc_thread_func(void *data)
 		if (sbi->sb->s_writers.frozen >= SB_FREEZE_WRITE) {
 			increase_sleep_time(gc_th, &wait_ms);
 			stat_other_skip_bggc_count(sbi);
+			if (foreground)
+				wake_up_all(&gc_th->fggc_wq);
 			continue;
 		}
 
@@ -83,6 +87,8 @@ static int gc_thread_func(void *data)
 
 		if (!sb_start_write_trylock(sbi->sb)) {
 			stat_other_skip_bggc_count(sbi);
+			if (foreground)
+				wake_up_all(&gc_th->fggc_wq);
 			continue;
 		}
 
-- 
2.43.0

