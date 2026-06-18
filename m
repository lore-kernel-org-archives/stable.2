Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EFCC231836
	for <stable@vger.kernel.org>; Thu, 18 Jun 2026 03:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781752226; cv=none; b=k2e+hvdjJ04dwMWXQ30zr5N+ZfmMUmMimj0dAyWS5iUfyytiijVEz+DbyLJZ5RGE3k70ceM1SWM8/8tXXWb7+ij84JLPfyV4GaiNx4Bye8LsUDDo/UL42Jn2aeUq+9ItPet0q7NdZqBFMp7Qi7EPfdPOOuHje3mdRrVOtU20jm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781752226; c=relaxed/simple;
	bh=0GlkVOcKNpcDxo3otc8i5JKT+mGm+pUsw6PpPver9gc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=P5Peiyxnmvj+upvC9FltCw49fPG1h6nekAymY393Pp/8czdX0ax2QeZpbLrml9Nmn9oCImWSRu5PYpr5CGACDgEtiofjuwHJaVSFdOqo5d3C2J2b/O+P+HRm+MQzvUTCh6uF30t1Tz35X5Gnqsb/lKgp04tys6ARtrOnJRihkGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MzDl6eVX; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MzDl6eVX"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-8453a67659fso195559b3a.1
        for <stable@vger.kernel.org>; Wed, 17 Jun 2026 20:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781752224; x=1782357024; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=M8Kg1mc083x8JX2hv995NqUUghKcte7werBgnQTU6Co=;
        b=MzDl6eVX0a2U9mqk45fTKAr34s2ASuwpDmMzCdQGfLS1+LXcIO03HuyZc2RK4Usdp/
         Zaup7OFyAb3MSa6yUJgf8ABFQjcVgPwk4NOKc7pZ4TF1KpEZ6Uf6h+gynfUKo0trwSJ9
         XqClm0qK8mU05R9V1LDIQb7nbXpiz9lcej85ywih9EZAEfziONom/K9p9l0btiUXY3N1
         7cpS0RNXkfiEuGyv3HnJfX4ijXkOZpyOJmTMSUwGFVZaJZW9UYbt7/jhEWaaru4S9KQa
         do4RRt1aFPpErNcpOYp84JHbrVUDR29V9ZjVFs7KFp7TDakBzDjvfJHvvn0IrUABH5h7
         nkbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781752224; x=1782357024;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M8Kg1mc083x8JX2hv995NqUUghKcte7werBgnQTU6Co=;
        b=CCKF4dxLcl5mVsVAshRIegAu88n4jzCBaLDcPTWPZIFDr6x27kQ2w8IxPscOstHXwa
         YsZ2H0+rfjFmhLQQCm4WmCyHGhAViR9SYU5ikRB8Z1fEKG6bcsHAIcHLn0BnGGHkKESe
         0VBMbxKaAnEE2Ly106jCIfUd/WZTnqDZiU7QWfBPeRizBacbdyeFfKXAjnuWjpOrfQO0
         bN2KvI1m8FnMf/4L2dgibAcO21PuvJhAAA+mbZb3ZViqXIqT+ZI+wYuLykJFdmkDU+xv
         iAc8X8DWfEDdEqV9+gYdXDaKkKpkIwADMPg/FksXgsjq1LFpkxy4z7bmDZNIS71BXXcb
         T7hQ==
X-Forwarded-Encrypted: i=1; AFNElJ90j7fzlEDuuvROmuJ1snC2FIBTWa1J+gxUpIRf8FW0eoKDkSIeO1Rt55fCTYkMNTAtk0hchQg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKxiKN3Rov7+e9q0LZlzRNPBE0Ms5ouByAgewvIlMD37C5pr/A
	CIbzNO6UYjojQd2kbuR4Ljus0Gl7SJOJlMfOJZg0k1UmmtjjWGdIquds
X-Gm-Gg: Acq92OE/GM7Wii4Lg6X0YxyxOSw+BoR603hhpmf0TgLYraxIRO0C7K23/sJcWvw/NmD
	/fl66jMkYppSTsfjwMmESCxFzve2tw/wJ6Gf/qgdcr2DVq9AZuOsgaLSyE8bUXyXsHJBekcZEYs
	ubmjGGVcqFHQ5LAj49k2HegNgBRoaXp/QfgU/cUxtOkfEFIn3Jd/0UoDEJlU+XpB+v96admex23
	Nym4oqkFxIKIIWr/bAxfVg2mCDFQr2fu5xdKoCh/8d5oWu5Uq2I50Ve5zZct/Bwiet02U3KaPn4
	uBgTkMFTuCa5z7+WYIL5QM+NgPeqrtkxMcyixUDK+f17av9TjrUZjUYl60ukVN2L+Wdid7JWeSj
	8gitvBqOruwXMwYqvONyZBTDkCy2zCDq5/o5ovEATaqwxaZsmekDG1KpORQvxbvrndsXzRphNtq
	qVBpHS4hOVIgAGxSBEn/revs+SIi2jT4Z4joYFalgZqGwUzeRR
X-Received: by 2002:a05:6a00:3a23:b0:842:678a:a7dc with SMTP id d2e1a72fcca58-8453b0dabf7mr1852187b3a.2.1781752223623;
        Wed, 17 Jun 2026 20:10:23 -0700 (PDT)
Received: from qiwenjie-ThinkCentre-M760t.mioffice.cn ([43.224.245.241])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8434afc8a90sm16936349b3a.28.2026.06.17.20.10.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 20:10:23 -0700 (PDT)
From: Wenjie Qi <qwjhust@gmail.com>
X-Google-Original-From: Wenjie Qi <qiwenjie@xiaomi.com>
To: jaegeuk@kernel.org,
	chao@kernel.org
Cc: yangyongpeng@xiaomi.com,
	geoo115@gmail.com,
	stable@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	qiwenjie@xiaomi.com,
	qwjhust@gmail.com
Subject: [PATCH v6] f2fs: use post-decrement count for cp_wait wakeup
Date: Thu, 18 Jun 2026 11:10:08 +0800
Message-ID: <20260618031008.2447279-1-qiwenjie@xiaomi.com>
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

That second read can race with a new CP-data writeback submission.  If
this completion drops the counter to zero, but another thread increments
it again before get_pages() runs, the zero transition is missed and a
checkpoint waiter can keep sleeping until the timeout.

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

