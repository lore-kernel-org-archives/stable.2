Received: from mail-106111.protonmail.ch (mail-106111.protonmail.ch [79.135.106.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4E8931A045;
	Fri,  9 Oct 2026 14:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791555920; cv=none; b=B9Ehdg4+5ozG5cWdqb4TnPtym40ntphwZLifSKOTg7hGBd7XJXMx9Kd3bzGD+0XiGiK7czZgZM4qOJ4XKhWVi2N1WrRS4yN/b94PUTv9J5xQpFs2V+4vSqTrCCo7DuoNTEFsVuderAaqz7KRZD1cwa++bruYhBAg7qwee5F+TY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791555920; c=relaxed/simple;
	bh=aNRTNYpGfo4uHEBNRnktsZ6z26AOTtU29zqpNIgIEgU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Tk3kgmA5oiNB3+mbWpu3WKfsUCs0REj4pmYTLw2swG0uK3lh6nKht5Ccen5sQy+OvIhPbDqEJwkN8nK+7IPNLz56bVjcWGV9t+auyRKHCW+baFwIobG0xA+/vbuzSFmvMD9sW4Xa0ScGI+6RHYKEaFAnYLdBMImdaGyedx3JF2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=karaolidis.com; spf=pass smtp.mailfrom=karaolidis.com; dkim=pass (2048-bit key) header.d=karaolidis.com header.i=@karaolidis.com header.b=fi35R3+t; arc=none smtp.client-ip=79.135.106.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=karaolidis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=karaolidis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=karaolidis.com header.i=@karaolidis.com header.b="fi35R3+t"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=karaolidis.com;
	s=protonmail3; t=1791555909; x=1791815109;
	bh=0ry/qEt4RcAqTFIzYK3t8eJQNo0m/0+YmGFQ1p2ujng=;
	h=From:To:Cc:Subject:Date:Message-ID:From:To:Cc:Date:Subject:
	 Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=fi35R3+teJ1yCUX4Dbv3ad1OWvzyqTT73ihrUmXQewn40TRhfezIhW1OhzCpipLj3
	 5KtC6dNbbLpoiTLtPCehZp09NBIPvhoRPAaL+tpOEL9W0IEsD6Vjqjes/Mv/CrWkAh
	 znMUR1iSjqwKCJxzreVY75b9DXAZqXbrWwHNLF8ztgVG7hyhExCIwsMQszmePZ3J5h
	 eiWdwa1xtDc6yIJGVmLn3w0N8hXewm/qLKjU9JSjY/JvseZtzYX+q2rT3lJb7ZtEES
	 vhfwlxJqcwKZmPDP3akkWGilZW2ketrY7frK+Sr3+8pWn6fwAl6y76LGWJquW26wB+
	 FSoyhUpCStcBg==
X-Pm-Submission-Id: 4j1Tf961fLz2SdVd
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
Subject: [PATCH] fs: don't lose inodes that another LRU walker is isolating
Date: Fri,  9 Oct 2026 14:24:31 +0000
Message-ID: <20261009142431.713875-1-nick@karaolidis.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When inode_lru_isolate() finds an unused inode that still has page
cache, it sets I_LRU_ISOLATING, drops i_lock and the list_lru lock,
invalidates the page cache, clears the flag again and returns
LRU_RETRY so that the restarted walk can free the inode.

Another walker of the same list can reach the inode in that window.
It sees a non-zero i_state and takes the inode off the LRU, as it
would an inode that is in use. Page cache deletion requeues the inode
once the mapping is shrinkable, so this is harmless if it happens
before the last deletion. If it happens after, nothing puts the inode
back: it stays in memory, unused, clean and without page cache, out
of reach of the shrinker and of drop_caches, until it is looked up
again or the filesystem is unmounted.

Before commit 2a0629834cd8 ("vfs: Don't evict inode under the inode
lru traversing context") the pin was an i_count reference, and the
final iput() put the inode back on the LRU.

Skip inodes that are being isolated and leave them to the walker that
pinned them, which restarts its walk once it has unpinned them.

The window is reached by any unused inode with page cache on
CONFIG_HIGHMEM kernels, and otherwise by inodes whose page cache is a
single shadow entry at index 0. On an i386 HIGHMEM guest, eight
concurrent "echo 2 > /proc/sys/vm/drop_caches" over 2000 freshly read
one-page ext4 files leave roughly 400 of the inodes off the LRU per
round; on x86_64, with the files' pages first evicted through
memory.reclaim, 3 to 4 per round. With this patch, none in either case.

Fixes: 2a0629834cd8 ("vfs: Don't evict inode under the inode lru traversing context")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Nikolaos Karaolidis <nick@karaolidis.com>
---

Found while working on reclaim of inodes pinned by page cache in
ZONE_MOVABLE.

Tested on master af32da41b032 (v7.3-rc6-232) in QEMU/KVM with a small
stress program: mount an ext4 image, read 2000 one-page files, run 8
concurrent "echo 2 > /proc/sys/vm/drop_caches", drop caches again
single-threaded (2, then 1, then 2), and count the filesystem's inodes
still in memory via how many the umount frees:

  i386 HIGHMEM:      ~390 of 2000 lost per round without the patch
                     (3 runs x 20 rounds), 0 with it
  x86_64, pages evicted through memory.reclaim first (single shadow
  entry left):       ~4 per round without, 0 with
  x86_64 with KASAN, PROVE_LOCKING, DEBUG_VM, DEBUG_LIST:
                     6109 lost in 50 rounds without, 0 with, no splats

The reproducer is a single C file run as init; I can post it if useful.

I went with skipping the inode rather than requeueing it on unpin
(which would be closer to what the final iput() did before
2a0629834cd8) because it avoids the remove/re-add and leaves the inode
where the pinning walker finds it again. Happy to switch if preferred.

Jan, this applies cleanly before or after "fs: Basic infrastructure for
offloading inode reclaim" (v2 3/5); happy to rebase onto that series if
you'd rather take it there.

For stable: 6.18 and older need inode->i_state instead of
inode_state_read(). I have only tested master.

An LLM was used to check the analysis against the code, write the
reproducer and draft the changelog; I have reviewed all of it.

 fs/inode.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/inode.c b/fs/inode.c
index a9d37be390a1..74dfc379b377 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -942,6 +942,12 @@ static enum lru_status inode_lru_isolate(struct list_head *item,
 	if (!spin_trylock(&inode->i_lock))
 		return LRU_SKIP;

+	/* Another walker is dropping its page cache, leave it to that one */
+	if (inode_state_read(inode) & I_LRU_ISOLATING) {
+		spin_unlock(&inode->i_lock);
+		return LRU_SKIP;
+	}
+
 	/*
 	 * Inodes can get referenced, redirtied, or repopulated while
 	 * they're already on the LRU, and this can make them

base-commit: af32da41b0327b9c6a37856ba82b6760d6c8d10e
--
2.55.0
