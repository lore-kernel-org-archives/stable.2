Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A8B32E22B5
	for <stable@vger.kernel.org>; Fri,  3 Jul 2026 18:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783101803; cv=none; b=mf0eWqtdS5pUnN9E62cY7hVpLUvfqQ7vZptEtDitYPaFSSbm0tU0U5D0uXF3sJTEKB768bRU9+QgZ1p3MBwtkh0d4YBE1ke3OVCW0WAk5atIksTa+VyFhUhXlaNeLAOW/94UNe2VD+CaZbwsWVxhSgfo49RvK5xY7ZIrdQHqhs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783101803; c=relaxed/simple;
	bh=E/q9xW95gEeGwAKvFtsIwMp1WPwTJvDRNkt3bC0kcJA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VhQeQDn/nUahChdkVIx/ceW6B7cNhW5JDesiXocP/KcOhM2WYO4OslIjPD5kUxY4S7QSYgRuNvErf2P7kUbJR5T88YeVrGSCzGUtfOPFzIXt/tSdb/qTL6NgqyA0xGWscCaLeun3NBFIBv0cDlxqeHtZ2Zcjv9fSCXkjoBRYwB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N2s6fsjR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N2s6fsjR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5207F1F00A3A;
	Fri,  3 Jul 2026 18:03:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783101801;
	bh=Lay32htZlqrllyOYStYXibcI4UNRnS4xy3opZawI3yQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=N2s6fsjRDa2ItCEaC9c+nar6pcelED4QaEQKw95lHUjvYhZcSzvyhfhXdhnvAoEPt
	 TIkyIQ9Ob9Ct1cSBVvm/8pyKVKO+N0SbQpSCgQTuXCoTeWeMGLke9qCyqytBWhzDy+
	 S4vIuLadkenLHTHvDPNJ5qYSb24/jWTVldDB93ZRBUBVDTy7NsTu7OOWkbw6Fh4oP9
	 ZRN4Z7PpEuesWMe+Ckl8BKJoOINAWKtcizRASv6qVjGXjCgl9eaRCb+uFwol6Wi6xj
	 JwqKFZb1eVDrmEdYqAvD6MoEIxXM7LH2MpdOf0DXpgIwhYl1GNRMdoIBRiaCcGAKI1
	 vyfBxvKaChDeg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chao Yu <chao@kernel.org>,
	stable@kernel.org,
	Ruipeng Qi <ruipengqi3@gmail.com>,
	Chao Yu <chaseyu@google.com>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 2/2] f2fs: fix potential deadlock in gc_merge path of f2fs_balance_fs()
Date: Fri,  3 Jul 2026 14:03:17 -0400
Message-ID: <20260703180317.196634-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260703180317.196634-1-sashal@kernel.org>
References: <2026070241-banker-throwback-07c2@gregkh>
 <20260703180317.196634-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chao Yu <chao@kernel.org>

[ Upstream commit 8b4468ec023d0d1b4669dfb867588997cc03a06b ]

When we mount device w/ gc_merge mount option, we may suffer below
potential deadlock:

Kworker					GC trehad			Truncator
- f2fs_write_cache_pages
 - f2fs_write_single_data_page
  - f2fs_do_write_data_page
   - folio_start_writeback  --- set writeback flag on folio
   - f2fs_outplace_write_data
   : cached folio in internal bio cache
  - f2fs_balance_fs
   - wake_up(gc_thread)
   : wake up gc thread to run foreground GC
   - finish_wait(fggc_wq)
   : wait on the waitqueue --- wait on GC thread to finish the work
									- truncate_inode_pages_range
									 - __filemap_get_folio(, FGP_LOCK)  --- lock folio
									 - truncate_inode_partial_folio
									  - folio_wait_writeback            --- wait on writeback being cleared
					- do_garbage_collect
					 - move_data_page
					  - f2fs_get_lock_data_folio
					   - lock on folio  --- blocked on folio's lock

In order to avoid such deadlock, let's call below functions to commit
cached bios in GC_MERGE path of f2fs_balance_fs() as the same as we did
in NOGC_MERGE path.
- f2fs_submit_merged_write(sbi, DATA);
- f2fs_submit_all_merged_ipu_writes(sbi);

Cc: stable@kernel.org
Fixes: 351df4b20115 ("f2fs: add segment operations")
Cc: Ruipeng Qi <ruipengqi3@gmail.com>
Reported: Sandeep Dhavale <dhavale@google.com>
Signed-off-by: Chao Yu <chao@kernel.org>
Signed-off-by: Chao Yu <chaseyu@google.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/segment.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 7acfb52a5fa131..0a080cb55c414b 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -443,6 +443,13 @@ void f2fs_balance_fs(struct f2fs_sb_info *sbi, bool need)
 	if (has_enough_free_secs(sbi, 0, 0))
 		return;
 
+	/*
+	 * Submit all cached OPU/IPU DATA bios before triggering
+	 * foreground GC to avoid potential deadlocks.
+	 */
+	f2fs_submit_merged_write(sbi, DATA);
+	f2fs_submit_all_merged_ipu_writes(sbi);
+
 	if (test_opt(sbi, GC_MERGE) && sbi->gc_thread &&
 				sbi->gc_thread->f2fs_gc_task) {
 		DEFINE_WAIT(wait);
@@ -462,13 +469,6 @@ void f2fs_balance_fs(struct f2fs_sb_info *sbi, bool need)
 			.err_gc_skipped = false,
 			.nr_free_secs = 1 };
 
-		/*
-		 * Submit all cached OPU/IPU DATA bios before triggering
-		 * foreground GC to avoid potential deadlocks.
-		 */
-		f2fs_submit_merged_write(sbi, DATA);
-		f2fs_submit_all_merged_ipu_writes(sbi);
-
 		f2fs_down_write(&sbi->gc_lock);
 		stat_inc_gc_call_count(sbi, FOREGROUND);
 		f2fs_gc(sbi, &gc_control);
-- 
2.53.0

