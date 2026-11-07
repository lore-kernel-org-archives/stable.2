Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794047127;
	b=0vsw4TypsRx2b/Rq7UH5ypDKVQ3O+ktdJNQ7rMW12DFdoxdGdaLOJ9oRKj0ryakpoWp4
	 8WS/ABCCf1Q6M23aW3KFKjxDp+d0VDFJ+f2JeOJ6be6Rp/tQ3zFF7oLkDqw7ODJiAihbE
	 bQJ5QgwmlGtCDw6rn8rg3RNcaBiQkk+eppO9ori7/3ym0CNHccEn0X2pvVoR3d3qwZVxV
	 cfNRoAaN+X7qOIxMwWZkZMM5njraA85fmLlOtg1JYyptg65B/6qKO8Vu+PfF2sEq95gk1
	 q9ZVGHrh+n5GdxSDHKfRYzhwz3y9AyLS4qlKpueBegYGIHXmJgBSYaoFAbJXIT+uxqw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794047127;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=1RXj+vyfGtiSq94Rv4uEeuTqZ533Mdea8y81TlOti4s=;
	b=LVwtz3FnPNprYex/gDMd28Z1wWVeTaHuJh4xlBGrDr2cAbhzMpbLC1hasq+462xp4rEZ
	 PDnzmodubsaWu8hzuNIQ4BZbmoaE7JV2wzLJJCV4xKZY485CVSlTjVei2mpewENsg1tBI
	 n5rXVfqYk2sOd9MfKRFIQXMQmebfo1mYMY/sz/nZgp2nBefaIOSpPrKx3gTuf3y5T4goU
	 qmZ16s2FqtG4xZ473we3Q2v5e8SgYi9gTaz1L2kfuCtTotbV7cD6nM1hshrXmsSYzzfKe
	 RRv5Iuk8k5ZKNxyJNvBXTnwT2/8UyAaNOC46EmGj/BK4oxrntZs/F3fmsV2oBJ2WVng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XRquwI11;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E508606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XRquwI11
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2FCA1F0089F;
	Sat,  7 Nov 2026 10:25:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794047127;
	bh=1RXj+vyfGtiSq94Rv4uEeuTqZ533Mdea8y81TlOti4s=;
	h=From:To:Cc:Subject:Date;
	b=XRquwI11oyhQkmroJEQD3qIqKvxhz6HxuCShlkWlHYKtT2dagrBQ+he5W6EpDL+Fu
	 VsTQ6lzJPKwa+VKwAl2J9ys3doRohgKKbQ+U83ZcUDzaZeI6IcOQkBA9y6C+3NM//9
	 UiQkgbmgMXKLX1bpu71tRA4SB+eapg1pGwxs+ek8c9rwbjdrZ873QxtbFbCeoGa+kQ
	 Mrj4MtPY3KB+QCwcMF8pD/JAmmNI5zJuflyHZh8IM8Yhy/xTqzj8uj/qIgmSFXTnl6
	 vLNFEftPAD9xCINfBLW0QFLjDuTahEBYRBn71HiMoHICN1h6cQIKLs4msQO5oeILbE
	 wBuB1QQHF2BIA==
From: Sasha Levin <sashal@kernel.org>
To: nick@karaolidis.com,
	chengzhihao1@huawei.com,
	jack@suse.cz,
	brauner@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] fs: don't lose inodes that another LRU walker is isolating" failed to apply to 6.12-stable tree
Date: Sat,  7 Nov 2026 05:25:25 -0500
Message-ID: <20261107052525-failed-6.12-8dc4116041e2@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 8dc4116041e2b377e5e1b62ba98b37636f9f3968
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107052525-failed-6.12-8dc4116041e2@kernel.org' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 8dc4116041e2b377e5e1b62ba98b37636f9f3968 Mon Sep 17 00:00:00 2001
From: Nikolaos Karaolidis <nick@karaolidis.com>
Date: Fri, 9 Oct 2026 14:24:31 +0000
Subject: [PATCH] fs: don't lose inodes that another LRU walker is isolating

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
Signed-off-by: Nikolaos Karaolidis <nick@karaolidis.com>
Link: https://patch.msgid.link/20261009142431.713875-1-nick@karaolidis.com
Reviewed-by: Zhihao Cheng <chengzhihao1@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/inode.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/inode.c b/fs/inode.c
index d6353b8d1e634..f63535ee36291 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -941,6 +941,12 @@ static enum lru_status inode_lru_isolate(struct list_head *item,
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
-- 
2.53.0




