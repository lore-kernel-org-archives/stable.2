Received: from mail-43170.protonmail.ch (mail-43170.protonmail.ch [185.70.43.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A233400DFC
	for <stable@vger.kernel.org>; Fri, 16 Oct 2026 10:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792146328; cv=none; b=f369i1U8Zgbl4Ubt15xsn+Qzb81onCti8NKtwDxnyecim6gRJNEtrGkmizGLiZhN2yplywNYGIQYYTyanrhO6Okz1jCzaW51x2VTRv9aRkpSnTFIkYjRJOVzdgZWqua+dZZM68pUNojxb9mvkbS/EKN4Vvxg2A4dplF26YaMeeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792146328; c=relaxed/simple;
	bh=+y5F4sNDPjHftsUFjQz9re9KbKNpidBYCZ04/lZzvlM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Vu9RYrMUcmHiBWOjnF8f2U6OPHML4FpGdNVhO/S26uUZgverOfi6hGetJSDx7JS/pB1z6wmuCYFbUJ21iEW5Xe2jYm80MQDRrCCtQ/Sz/Ba4jckVqnEEoVsfo/wD6bTnEaXDG9PikreNZOARf7Ph1w74k+Lc+zTPKq9Q797WuxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=karaolidis.com; spf=pass smtp.mailfrom=karaolidis.com; dkim=pass (2048-bit key) header.d=karaolidis.com header.i=@karaolidis.com header.b=T7r9Bx03; arc=none smtp.client-ip=185.70.43.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=karaolidis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=karaolidis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=karaolidis.com header.i=@karaolidis.com header.b="T7r9Bx03"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=karaolidis.com;
	s=protonmail3; t=1792146321; x=1792405521;
	bh=b04DOe8vmbq+QEfUbmjT3IlS1rtxforJbJCVtR4UErk=;
	h=From:To:Cc:Subject:Date:Message-ID:From:To:Cc:Date:Subject:
	 Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=T7r9Bx03kZ1obL008QSpYAKFDmkSk37XBbQHx4AvZCIaA9xbTeoEXhc/cB3SMlI57
	 MezU9GsTh0X2puV8/EOcBKYReV9Q0Si//bRYSnPbL1TcjaRYoTjnNgeVCaWCY1cVuK
	 i0NDQkC539QboKy9GsknWUco5yAc/uayQ+OUsRMiUt4AiZlP5C9ARhF+WYL/nmv81S
	 ZxQB5w17SwmyKQ1rAO3+8EVTWuE8LSrLytrXUjkwV3tKsFbCUSs8BIla7JbG1YM4+R
	 d4C2VMC8QarJWifr87HQrFiLP5Coy2SvrrGakMNysf0RdIurfMPUjvoU/kLVO04JQM
	 6rwEEXp/bHUpQ==
X-Pm-Submission-Id: 4j5h0F5p8Zz1DDKp
From: Nikolaos Karaolidis <nick@karaolidis.com>
To: Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Jan Kara <jack@suse.cz>,
	Zhihao Cheng <chengzhihao1@huawei.com>,
	Mateusz Guzik <mjguzik@gmail.com>,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Nikolaos Karaolidis <nick@karaolidis.com>,
	stable@vger.kernel.org
Subject: [PATCH] fs: rotate inodes whose page cache could not be dropped
Date: Fri, 16 Oct 2026 10:25:15 +0000
Message-ID: <20261016102515.111285-1-nick@karaolidis.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When inode_lru_isolate() drops the page cache of an unused inode, it
has to unlock the list, so it returns LRU_RETRY and the walk restarts
at the head of the list, where the inode still is. If
invalidate_mapping_pages() could not empty the mapping, the restarted
walk strips the same inode again, and so on until nr_to_walk runs out.
Every walk of that list then ends on this inode, and nothing behind it
is reclaimed for as long as its cache stays.

Before commit 2a0629834cd8 ("vfs: Don't evict inode under the inode lru
traversing context") the walker pinned the inode with a reference, and
dropping it in iput_final() set I_REFERENCED, so the restarted walk
rotated the inode to the tail. Set I_REFERENCED again when the mapping
is still populated after the invalidation, in the same i_lock section
that clears I_LRU_ISOLATING. inode_unpin_lru_isolating() now expects
i_lock to be held, like inode_pin_lru_isolating().

On CONFIG_HIGHMEM kernels this can happen to any unused inode: a folio
is left behind if it is locked, under writeback, spliced into a pipe,
or still in another CPU's LRU-add batch after being read. Without
HIGHMEM it happens to DAX inodes whose only entry is at index 0, which
mapping_shrinkable() lets onto the LRU and invalidate_mapping_pages()
never removes.

Fixes: 2a0629834cd8 ("vfs: Don't evict inode under the inode lru traversing context")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Nikolaos Karaolidis <nick@karaolidis.com>
---

Found while working on reclaim of inodes pinned by page cache in
ZONE_MOVABLE.

Tested in QEMU/KVM on master af32da41b032 (v7.3-rc6-232), with lockdep
and KASAN enabled. A small init program makes one unused inode whose
page can't be invalidated, lets it reach the head of the inode LRU,
opens 2000 other files, does one "echo 2 > /proc/sys/vm/drop_caches"
and counts the inodes left via umount; kprobes count the
invalidate_mapping_pages() calls:

                              without patch           with patch
  i386 HIGHMEM, file read     2000 of 2000 left,      none left,
  on another CPU              10300 strips, 1 inode   4 strips
  i386 HIGHMEM, page          same                    same
  spliced into a pipe
  x86_64, ext4 -o dax,        same                    same
  file mmap()ed
  controls (no leftover,      none left               none left
  shadow entry at index 0)

2a0629834cd8^ behaves like the patched kernel, 2a0629834cd8 like
master. On 5.15.y x86_64, where every unused inode with page cache is
on the LRU, the read-on-another-CPU case blocks the walk as well.

With "echo 64M > /sys/fs/cgroup/memory.reclaim" instead of
drop_caches, the i386 pipe case does 262450 strips and frees nothing
without the patch, 40 strips and frees everything with it. In the DAX
case that write takes ~400ms with the patch instead of ~4ms:
invalidate_mapping_pages() counts the DAX entry it leaves behind as
reclaimed, so unpatched, the 64M are "reclaimed" by re-stripping one
inode in a tight loop while nothing is freed.

The reproducer is a single C file; I can post it.

An LLM was used to check the analysis against the code, write the
reproducer and draft the changelog; I have reviewed all of it.

 fs/inode.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/fs/inode.c b/fs/inode.c
index a9d37be390a1..1614a97ce953 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -593,12 +593,11 @@ static void inode_pin_lru_isolating(struct inode *inode)
 
 static void inode_unpin_lru_isolating(struct inode *inode)
 {
-	spin_lock(&inode->i_lock);
+	lockdep_assert_held(&inode->i_lock);
 	WARN_ON(!(inode_state_read(inode) & I_LRU_ISOLATING));
 	inode_state_clear(inode, I_LRU_ISOLATING);
 	/* Called with inode->i_lock which ensures memory ordering. */
 	inode_wake_up_bit(inode, __I_LRU_ISOLATING);
-	spin_unlock(&inode->i_lock);
 }
 
 static void inode_wait_for_lru_isolating(struct inode *inode)
@@ -981,7 +980,13 @@ static enum lru_status inode_lru_isolate(struct list_head *item,
 		else
 			__count_vm_events(PGINODESTEAL, reap);
 		mm_account_reclaimed_pages(reap);
+
+		spin_lock(&inode->i_lock);
+		/* The walk restarts here: don't retry leftovers right away */
+		if (!mapping_empty(&inode->i_data))
+			inode_state_set(inode, I_REFERENCED);
 		inode_unpin_lru_isolating(inode);
+		spin_unlock(&inode->i_lock);
 		return LRU_RETRY;
 	}
 

base-commit: af32da41b0327b9c6a37856ba82b6760d6c8d10e
-- 
2.55.0

