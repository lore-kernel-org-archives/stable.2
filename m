Received: from mail-pz2-f38.google.com (mail-pz2-f38.google.com [74.125.228.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C77633ADBA
	for <stable@vger.kernel.org>; Wed, 23 Sep 2026 14:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790174491; cv=none; b=Xn7Sopp4AnZnyb4ALrA6h5Pdw/H3bMMPqZYRWmsMSmgHgrMTnMinh8T/bD6UcJDd/EkYTG+xL5xEGzcyKng9R5RnO8CXbWemGjpANqjiWCYwMQw+X5B7d/cnYcDew9GWvgd0g3uVlhRVicTGgi4JXvCVXbcH8vAwTAX+TI1qK4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790174491; c=relaxed/simple;
	bh=+otIrsLnvG63x+JWVf3rTo9vMNO9yRb6KUn2LVEtsEg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=W6LLtrQULG09OD3KLpZmpYYybB5eAl4xqP/5Q3m/9rAuw3/jLSMS+tzyuBRpJanIxjTwXF1XkpqundFm3Rb+JGeptDRpfeHyu9U1hM+9cLR8k4j8+XS/ARYOCzI5mQUr90IDy1sj1jEyBLp0IatiAUIKYzIcbIU8mXilLv4Buyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N1lxs8yU; arc=none smtp.client-ip=74.125.228.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N1lxs8yU"
Received: by mail-pz2-f38.google.com with SMTP id 41be03b00d2f7-cc1cea4c7a0so630329a12.1
        for <stable@vger.kernel.org>; Wed, 23 Sep 2026 07:41:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790174488; x=1790779288; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=6VbNCrUtC6XhrJdqpuUyW50kKcrIjN7yFV7NZTjlcAE=;
        b=N1lxs8yUK/BdDMTD0oKKt7ODrXJQMzvHFjYT2V1V1PJX3DdRWS/2KuYChvyMQPVxH5
         CKaNUgdaRlOYfDg/f7CszEPI9cphIzPEqmJ5UbT6B8Abd/c3mQv22x6djCrcD22uYYPd
         UEDD1sjcufD5HLr+yR02T4LcqfM7z3U9FkB1ZXMChyAcqGvuQkzAN0i7+SjFsfZNwqTn
         IWp/ssNYjM0WSLs/kLvgyC30OSfDIil4+df8ou5oI7L4F3MFrOug7U/IanrGff9nYMy6
         H+5/cFdiD0fH5e/xs68W+IT8wKw88uDvy6881Mfb5eTCZyVn7Ivfee4uE55Df/OeK6DE
         pmIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790174488; x=1790779288;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6VbNCrUtC6XhrJdqpuUyW50kKcrIjN7yFV7NZTjlcAE=;
        b=M0rzAA0Hhp3hbr0lcYFCcscJfIH2YIuLg5LOw/NPz8vDfbV4Zu17TvmXLmmda4DTJJ
         oAxQoh+2xFhJu6zm38p4dDz8FMFE0aDum5qsOvkoBZokFhwvfEgYIjfWScQevv8t5i9n
         Cz+oHIaGW9xp3SdlJVp+6vXP+EohTRWlZYODWvxoI/VAkqqNCvuaWLEXiY5j6gpNaYfB
         DbrOxbUAFu+jlPIJaZ2vyA3ab0dQqgQ6CxYAnLJII1gU+a81Sd2aC0CvBYh8JKcDSziA
         mrQf9LzI90jZcibRlo9JFHf9umA5tx0ipBhTijAYi8bM8fhakjHgeQwBJtd5sQKOgSzk
         /hlQ==
X-Forwarded-Encrypted: i=1; AKwUvByEoyhEzihMOm8i7aQhC9gc+6ZWkkGRNNb3aWClrldgiTBGHkoBPNquwTuwGLdw/pCea61UXrw=@vger.kernel.org
X-Gm-Message-State: AFuF++liX2MS2rvoxa7SPF1D3JBlxssx8FwF5ll6vot3W7ujr3r9h7aP
	2pdbDMaafRSwQMdCF8kKoZnZV68a3idcLxWR0FWqZZPqEKJXZT7hFDiyif2LUQ==
X-Gm-Gg: AYBFou1YKB0pX9EcUlxT3E0Kkj/fyWwwLmRSWvHPyUqlaymLsz5fb7ELk0MqzN6/NPa
	pz6eJKdiiVyhxM5s+2IeQg0UElY249t0VtyNo/Hp+ZIq7P+0pPPgmhBNzDvYEA1w4NNf/OhqSz/
	S5ymiU04r926KjnGrthQkkB0xMyBrnheS1knceUXrLaTBlNeacQSzvS5mllzs8No/+2idmAUbEh
	nMkamfD2fuOv7zbsMxCkb9UtGHrjAoeX7m+2Uzqvbi8z50gDe3jpm5JcCDEyYuWEtoypW0PUMt0
	03u5re7F2Kf4nquU6ztKifdKTafMwytYuhVnH5y5os9HAvAq0H/INxKXD2nMXnUxsum2QmyadIU
	kf94YG9wnQaxXWvW/8U0peGy9vzhhDpGZ3eLb1hC5MSbK9hWc1Xp7VyZooee3i+5fQq4lZ349WR
	77aM11lLqtuWIBDcgJwbEpKHknDzsfz7U/osvKRp0105luoQyHOMTBg+JtwCwKiLhKL4lc6H39v
	xLdVK6WcwjHv6Bmld0TOfc2fm8=
X-Received: by 2002:a05:6300:6bcf:10b0:3d1:39e9:b267 with SMTP id adf61e73a8af0-3ddf7cca4dcmr1648693637.3.1790174488224;
        Wed, 23 Sep 2026 07:41:28 -0700 (PDT)
Received: from thangnn-ASUS.. ([2405:4802:1d4a:e90:f072:2258:ced5:5d8c])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc75f406238sm1239936a12.26.2026.09.23.07.41.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 07:41:27 -0700 (PDT)
From: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
To: shaggy@kernel.org
Cc: jfs-discussion@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	ngocthang2710.1999@gmail.com,
	syzbot+5570e0eb2edddd308514@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: [PATCH] jfs: fix self-deadlock on discarded metapage in __get_metapage()
Date: Wed, 23 Sep 2026 21:41:22 +0700
Message-ID: <20260923144122.25792-1-ngocthang2710.1999@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

__get_metapage() holds the folio lock when it finds a cached metapage
flagged META_discard on a non-new lookup.  It reports the corruption
and calls discard_metapage(), which goes through release_metapage() and
tries to take the same folio lock again:

  release_metapage+0x103/0xab0 fs/jfs/jfs_metapage.c:868
  __get_metapage+0x9a0/0xde0 fs/jfs/jfs_metapage.c:751
  jfs_readdir+0x1e01/0x3ae0 fs/jfs/jfs_dtree.c:3041

The task then sleeps forever in D state with i_rwsem held, which
syzbot reports as a hung task.

Split release_metapage() into a locked variant and use it here.  The
locked variant also unlocks and puts the folio, so return NULL directly
instead of going through the unlock label.

Reported-by: syzbot+5570e0eb2edddd308514@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=5570e0eb2edddd308514
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
---
 fs/jfs/jfs_metapage.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/fs/jfs/jfs_metapage.c b/fs/jfs/jfs_metapage.c
index 41fe12e641ce..b3585df259cd 100644
--- a/fs/jfs/jfs_metapage.c
+++ b/fs/jfs/jfs_metapage.c
@@ -681,6 +681,8 @@ const struct address_space_operations jfs_metapage_aops = {
 	.migrate_folio	= metapage_migrate_folio,
 };
 
+static void release_metapage_locked(struct metapage *mp);
+
 struct metapage *__get_metapage(struct inode *inode, unsigned long lblock,
 				unsigned int size, int absolute,
 				unsigned long new)
@@ -751,8 +753,9 @@ struct metapage *__get_metapage(struct inode *inode, unsigned long lblock,
 			if (!new) {
 				jfs_error(inode->i_sb,
 					  "using a discarded metapage\n");
-				discard_metapage(mp);
-				goto unlock;
+				clear_bit(META_dirty, &mp->flag);
+				release_metapage_locked(mp);
+				return NULL;
 			}
 			clear_bit(META_discard, &mp->flag);
 		}
@@ -863,12 +866,11 @@ void put_metapage(struct metapage *mp)
 	release_metapage(mp);
 }
 
-void release_metapage(struct metapage * mp)
+/* Caller holds the folio lock; it is dropped along with the folio ref. */
+static void release_metapage_locked(struct metapage *mp)
 {
 	struct folio *folio = mp->folio;
-	jfs_info("release_metapage: mp = 0x%p, flag = 0x%lx", mp, mp->flag);
 
-	folio_lock(folio);
 	unlock_metapage(mp);
 
 	assert(mp->count);
@@ -896,6 +898,14 @@ void release_metapage(struct metapage * mp)
 	folio_put(folio);
 }
 
+void release_metapage(struct metapage *mp)
+{
+	jfs_info("release_metapage: mp = 0x%p, flag = 0x%lx", mp, mp->flag);
+
+	folio_lock(mp->folio);
+	release_metapage_locked(mp);
+}
+
 void __invalidate_metapages(struct inode *ip, s64 addr, int len)
 {
 	sector_t lblock;
-- 
2.43.0

