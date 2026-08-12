Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C7373911C7
	for <stable@vger.kernel.org>; Wed, 12 Aug 2026 04:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786509843; cv=none; b=Ps1boduNMuB1Kp5TgGA+iWm9d0ZrWUcxkjvgAfleiYo3lInZZlnflBhlrt4QqrywVSroRzg22feDeuKZcuBslJEKBfo9yOJVJ6i9RombAFpaDKYrX2ONvvNtW0Ow5zyBsLAYi5C8Tpn9n0OFgTEeDua91KxnmXzgv4cN/lt8d5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786509843; c=relaxed/simple;
	bh=Geen8rRi9DYSEeIAFJv4tuQyYu6xQCEWIEOmRHPkpYE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DmDAl9+6sAXkf5nm3RT8CxTd+lI2Sg3hXWwN0vjCMH3/olERX90uX4b+n9tNGaDvwyITYtluohH5OmcMCd1oE44MF9yvVa4zUdkoRj+pSHJxN0iHJveQSe4xo095X1h4RAu4/0sufrxDphpYBtYnwF7nYacjZ9lW5WaODSyZIME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LLuQZnzA; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LLuQZnzA"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2caed617615so8215885ad.3
        for <stable@vger.kernel.org>; Tue, 11 Aug 2026 21:44:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786509841; x=1787114641; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Z09gGCJzZ8Oqr2QOAqOOmcBjVqdoajQ3RwQNJtoTNM0=;
        b=LLuQZnzA411Sgd9r+cj7XCqdwMkDlYLSyzE+jQNhBxP1UTzkwU9MixzM6oUWzBGK3X
         Q4ShdAAoK1sQwtulXo+FZb6fRO0klCvhGRN8AprBTEJ+n3yR3bhCdzlO+ZZkpaW5QdKJ
         xqTWJhkfqVDXvujUOtz4ckSMvjSRRWc53BKhA8QwYlsdgUiP43hNDkSkP5qBKVUkx7YX
         vJj/edmDHYoTkAGZndC2UwBsBduD7Zp4f8CsZMHAoL18NUTMHsemFA21nzUTPpOpQWUZ
         i13tawS4JPLkHd9dg0HbTI7SyhFoDKzo5zVZJfzJn/eWCGJn2Fq40kG9HWKo4so6XbVd
         HCig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786509841; x=1787114641;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Z09gGCJzZ8Oqr2QOAqOOmcBjVqdoajQ3RwQNJtoTNM0=;
        b=ear2BzJodml3DBfcxowpGCu5buzVY1StO5JG4dHaFfaAUJmGwvQM3Ao8mR20SyxQB2
         qMJEYMPSzl2uTsnLcjLWsKLaNhlohVKnwyS3yREwnS4qBPODiXwoMRwEh8qa4LkrDZGc
         A8Zzzc1nnPalUlwg3kFPYvH7cU83N6oguNGDgFAZN0o2Fv0iBR5WH6v83zI87mg90BTt
         ZcrkTw2PAtkhPYWs1b/cY85kb2jKq4sHzS7l0Wj1C6SZyOsDwOQsYhcd90oZs2F0Xi3B
         IAJaLfKGBhM2ue4KElaojih1pVddrOOVOZiCvfQuItwVhIX8ZjmcxVXayjV9ufnOzuqf
         P5uw==
X-Forwarded-Encrypted: i=1; AHgh+RoK3vI4gY91lflnwDUZ9xQ5U70J4tZEygSPuZUpSphJluP9BoFdrgCWTo+f3Vx/QQkOiaMA6FU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjfAqNGB5Fd65p/zpnCAgYAzU+7YfuZTup0kF8OJMcrHbql8EX
	vfhy6gGzoB+2xJnJAOnBOaceEuwHFILTgdLe6eevuKGKO9KPasY6SAFW
X-Gm-Gg: AR+sD10x18MIi3k1lLSg2qq3bOmP8as0rnH1I+T2fT+bc5X+di5TJIvyh7MJ21DwTSS
	NkrZY+AnExyhizMrBL7sDGhjGorlkwGM6QR6lM1KShoxevi3f3dwuFsKzi+kk/CnJsOEHZo6tjt
	9RARNIJINTbMCVLW3Npbg8lLEbChpF75n+h7kDVoIz4Lhm0HEb/zSiRp43z3BLkBpR1kJ3+mSGu
	8ql5Aw2EkbLViGsneEniqET0cIeIXJzA7AHw51dnGdzxst4GnLmXaBWfAiTz1iGyWP7QGHV2kp4
	GaOO6WMBGOdc53cmh9ocQaWuqr5aOg3mtnQX7KUdpVPxyj9+FCXohk5Pn0taIIpr639fZyzK9xr
	jgukg0Nd3Mzj6YBrZYFLzM1gulfwv0zVdbSm60R0IWSxgJmKnTYcTv6i3jvgrp9twfnJJJ9IDmx
	dLVYF9wbvZoMvBx/XENB8XoqbRKOtl1kt8qqkNkyyzy2b55fz7qlEOBH8R8/wReBzWXs+myzj0H
	INfGGxXcX/KPp6lp8A=
X-Received: by 2002:a17:903:230b:b0:2ca:d975:5bbd with SMTP id d9443c01a7336-2d3455ffabcmr25703105ad.20.1786509840697;
        Tue, 11 Aug 2026 21:44:00 -0700 (PDT)
Received: from jubuntu-dev.. (211-23-39-77.hinet-ip.hinet.net. [211.23.39.77])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d350fb0cd0sm1177695ad.4.2026.08.11.21.43.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 21:44:00 -0700 (PDT)
From: Hsiu-Hsien Lee <swinds24@gmail.com>
To: tytso@mit.edu
Cc: adilger.kernel@dilger.ca,
	jack@suse.cz,
	libaokun@linux.alibaba.com,
	ojaswin@linux.ibm.com,
	ritesh.list@gmail.com,
	yi.zhang@huawei.com,
	harshadshirwadkar@gmail.com,
	linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hsiu-Hsien Lee <swinds24@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] ext4: fix fast commit replay failing on a read-only mount
Date: Wed, 12 Aug 2026 12:43:53 +0800
Message-ID: <20260812044353.1018268-1-swinds24@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A filesystem with fast_commit that needs recovery cannot be mounted
read-only:

  EXT4-fs (dm-0): INFO: recovery required on readonly filesystem
  EXT4-fs (dm-0): write access will be enabled during recovery
  WARNING: CPU: 22 PID: 5544 at fs/ext4/ext4_jbd2.c:73
   ext4_journal_check_start
   __ext4_journal_start_sb
   __ext4_unlink
   ext4_fc_replay
   do_one_pass
   jbd2_journal_recover
   jbd2_journal_load
   __ext4_fill_super
  JBD2: journal recovery failed
  EXT4-fs (dm-0): error loading journal

Fast commit replay runs ext4 metadata operations instead of writing
blocks through the buffer cache: ext4_fc_replay_{unlink,link,create}()
reach __ext4_unlink() and __ext4_link(), which start a handle.
ext4_journal_check_start() returns -EROFS on a read-only sb, and as
that is not -ENOENT it propagates out of jbd2_journal_recover() and
kills the whole recovery.  The EXT4_FC_REPLAY check that would hand
out a no-journal handle sits after the sb_rdonly() test, so replay can
never complete read-only.

ext4_load_journal() has already promised that write access will be
enabled during recovery, so make that true for the superblock as well:
clear SB_RDONLY across jbd2_journal_load() when recovery is needed on a
read-only mount and the devices are writable, as ext4_orphan_cleanup()
does.  Unlike ext4_handle_error(), which avoids SB_RDONLY because it
would need s_umount, the sb here is still inside ext4_fill_super() and
not published, so nothing can observe it.

The failure is not clean either: the replay handlers passing a NULL
handle (ext4_fc_replay_inode(), _add_range(), _del_range()) never hit
ext4_journal_check_start() and do write, leaving a partially applied
fast commit behind.

Reproducer, where the unlink only ever reaches the fast commit area:

  mke2fs -q -F -t ext4 -O fast_commit -b 4096 /dev/sdb3 262144
  mount /dev/sdb3 /mnt
  dd if=/dev/zero of=/mnt/victim bs=4k count=1 conv=fsync
  sync                          # victim now in a full commit
  rm /mnt/victim
  dd if=/dev/zero of=/mnt/trigger bs=4k count=1 conv=fsync
  <crash, or snapshot the device while mounted and write it back>
  mount -o ro /dev/sdb3 /mnt

Without this patch that mount fails; with it recovery completes and
victim is gone, i.e. the UNLINK record was really replayed.

Fixes: 8016e29f4362 ("ext4: fast commit recovery path")
Cc: stable@vger.kernel.org
Signed-off-by: Hsiu-Hsien Lee <swinds24@gmail.com>
---
 fs/ext4/super.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 245f67d10ded..6c2b275a9cf3 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -6096,6 +6096,7 @@ static int ext4_load_journal(struct super_block *sb,
 	int err = 0;
 	int really_read_only;
 	int journal_dev_ro;
+	bool enable_write = false;
 
 	if (WARN_ON_ONCE(!ext4_has_feature_journal(sb)))
 		return -EFSCORRUPTED;
@@ -6152,6 +6153,7 @@ static int ext4_load_journal(struct super_block *sb,
 			}
 			ext4_msg(sb, KERN_INFO, "write access will "
 			       "be enabled during recovery");
+			enable_write = true;
 		}
 	}
 
@@ -6168,7 +6170,19 @@ static int ext4_load_journal(struct super_block *sb,
 		if (save)
 			memcpy(save, ((char *) es) +
 			       EXT4_S_ERR_START, EXT4_S_ERR_LEN);
+		/*
+		 * Fast commit replay performs regular ext4 metadata updates
+		 * (see ext4_fc_replay()) which refuse to run on a read-only
+		 * superblock.  We promised write access above, so make that
+		 * true for the duration of the recovery, the same way
+		 * ext4_orphan_cleanup() does.  The superblock is not published
+		 * yet, so nothing can observe the transient state.
+		 */
+		if (enable_write)
+			sb->s_flags &= ~SB_RDONLY;
 		err = jbd2_journal_load(journal);
+		if (enable_write)
+			sb->s_flags |= SB_RDONLY;
 		if (save && memcmp(((char *) es) + EXT4_S_ERR_START,
 				   save, EXT4_S_ERR_LEN)) {
 			memcpy(((char *) es) + EXT4_S_ERR_START,
-- 
2.43.0

