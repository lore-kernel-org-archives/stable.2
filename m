Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C114E1448E0
	for <stable@vger.kernel.org>; Sat,  4 Jul 2026 00:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783126022; cv=none; b=WpNk6kMAvGO+gey5ImUgkirM9s0baCzVVP/nvIGcPNvSV6UfhYoi4T3sAEf66Ihrrgf1WFouYvVtrg6ER2E5vYDosZl60brBBwV+TmHgeBGosg0ydmSQmgOkX4xfIKfR6h7C2or/qLOieo4HZ49JDUP0piS052emOtzC608s83Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783126022; c=relaxed/simple;
	bh=4KZoKYGYOWkkWgTTqzH3clCmQ99PLLGlNg12DWX5nII=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jm+drg+hClx5lAKUhgn1SDDplCmT9SBBXcTRf1+VfodW85U5UvREzn1HibVkcPz/lggrNWteWekwTP1XupaAln7fLj67I2JjEfrLiaJln2aWcAWC4zQTO10pzSZTFEjLZih7CDANH+fO6MgA2zGE9jyF3OWlKFMdVanAKyfYogg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=getIqHu+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="getIqHu+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B481E1F00A3D;
	Sat,  4 Jul 2026 00:47:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783126021;
	bh=UprPzbp72wmifsQWVOc7khgoi2hcEbq3aEOJ9X6Flfw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=getIqHu+M60yNy22Fr9wYY8TOUbeL1GItQkzbEInzpkHqQgvgrYWA8i3Nm/+AWOWd
	 TeORpmzcesq4E9Bf1L1QylXarmy97BJZLYj4A//ym8ndMutDagpFIqL8YDm3onHGhE
	 OtxKTRelNjm8ffmwfSyowWKOGRJQR+k3Cpq6A8EGDi4l/9WJgzonQbduk+b15/tYQn
	 vdfcW3NXJD01AQ067EwTzT+7gB9p0baMqS+psNBc9joJjhOsOAXgUsvScKBRmgcsDG
	 XH7SI++wS3xbHznakUjwrwI7A9J/PnUPDpGD+Re+GwMs861nyF+2W7rXb7D8gBUzIr
	 MtAR0rFX/jMTg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chao Yu <chao@kernel.org>,
	stable@kernel.org,
	Ruipeng Qi <ruipengqi3@gmail.com>,
	Chao Yu <chaseyu@google.com>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/2] f2fs: fix potential deadlock in gc_merge path of f2fs_balance_fs()
Date: Fri,  3 Jul 2026 20:46:57 -0400
Message-ID: <20260704004657.433173-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260704004657.433173-1-sashal@kernel.org>
References: <2026070242-embassy-abdominal-7557@gregkh>
 <20260704004657.433173-1-sashal@kernel.org>
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
index 2e05e899097a91..31b3ff1fa9ba5e 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -515,6 +515,13 @@ void f2fs_balance_fs(struct f2fs_sb_info *sbi, bool need)
 	 * dir/node pages without enough free segments.
 	 */
 	if (has_not_enough_free_secs(sbi, 0, 0)) {
+		/*
+		 * Submit all cached OPU/IPU DATA bios before triggering
+		 * foreground GC to avoid potential deadlocks.
+		 */
+		f2fs_submit_merged_write(sbi, DATA);
+		f2fs_submit_all_merged_ipu_writes(sbi);
+
 		if (test_opt(sbi, GC_MERGE) && sbi->gc_thread &&
 					sbi->gc_thread->f2fs_gc_task) {
 			DEFINE_WAIT(wait);
@@ -525,13 +532,6 @@ void f2fs_balance_fs(struct f2fs_sb_info *sbi, bool need)
 			io_schedule();
 			finish_wait(&sbi->gc_thread->fggc_wq, &wait);
 		} else {
-			/*
-			 * Submit all cached OPU/IPU DATA bios before triggering
-			 * foreground GC to avoid potential deadlocks.
-			 */
-			f2fs_submit_merged_write(sbi, DATA);
-			f2fs_submit_all_merged_ipu_writes(sbi);
-
 			down_write(&sbi->gc_lock);
 			f2fs_gc(sbi, false, false, false, NULL_SEGNO);
 		}
-- 
2.53.0

