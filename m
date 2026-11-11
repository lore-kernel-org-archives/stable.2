Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794379840;
	b=Av0UMQWv+Q+xVeozMXoQAHMuqthCji25zSq7/QKAis4D2cYPVbotz2NhUApJ0LRYD006
	 2Ewt/VqPB4dWUCwssI/mnNgHQOOTdo9RhjF2Iiejvw9HQU7D2c/sFwn+KKTdi+udBPiXm
	 9xyDy9yOkydCOjP6EdSo0G3XiF7t76kHuj/hWxFvZueqBczUsA6X5aLXf8GDTqddOSiTX
	 LZ541hFfy7XcKUbbw8OYwvuVrpiUZ/ftX4lTlZmlJjqzhvcsWp5vOcRGhBHSCPD4dAv4P
	 M7Co7sHSEzSyAEV7t9TqzdcWqBBTtXSytKeDuz1jbbNFgzEQawzZK6D2eKUEgdeHX5w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794379840;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=NFQaobiSkCtKhJ9kB75GvMmucAIfglfAIibYpVIP7Zc=;
	b=iqq90t4W6tc2vpNvLS9U36VoG0/oVdzL+cI47TNs/DBAVMymX/p4tBr6jj6oOYa6K25l
	 vjw9T2PPAyphSDsew2aG3eH1Di9PtrL+D4gYTqTrHHul3ICPwWxEz6DZpGNk/LGSpL5qF
	 cnz8JfVzJK/4JYLieTrIAItUv9jp725MSg2xqQ83NbE5C9AQ/mMFLW2M5QUPVrrm2DNxe
	 vKXgQvFS1QjeLvXK2YeDPA7dtETD9krMunXl2roq8otUp0wO0lm0qIhcBfC4hH6UMOD4R
	 +4R8khzjkDtzLE/ogowxi1zN6G0c8oLl+WRrS64QsSYetXACrJRlwH+T0UBv+RcFhFg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VzpYDuZD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92413606A324
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 06:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VzpYDuZD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BCDF1F00A05;
	Wed, 11 Nov 2026 06:50:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794379840;
	bh=NFQaobiSkCtKhJ9kB75GvMmucAIfglfAIibYpVIP7Zc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VzpYDuZD+LIz1QPufvQepWGBmbt3idlcA7ila16HWRDMeyKVmAnYSd3AA9sE0EtUR
	 2LUFxuGgj/6URa2sDXqyrXamnTGjHQ1Gd1zvdwmH9dxF4GsydUtmataCYDMh9sA//o
	 1/xw+ubvU3ktIaTktBS1oj350TpeWfiMShWsF/gSlJNC6aXRUN56J8PO9VeDT+ERF1
	 7i2eZsVn3rgNNNaCdJWdgxB62qCU+Jp7yby24pJcdt4g8sAF0OrKpTnkb78wpOB1lr
	 fw4tX7HGI7VTf1+Ct0vR8o0FxRFJz1AllpT5REixa/a78//7JCM3LZo8NbgjCQS9Zw
	 xWfh9kA2AL8VQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Nikolaos Karaolidis <nick@karaolidis.com>,
	Zhihao Cheng <chengzhihao1@huawei.com>,
	Jan Kara <jack@suse.cz>,
	"Christian Brauner (Amutable)" <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] fs: don't lose inodes that another LRU walker is isolating
Date: Wed, 11 Nov 2026 01:50:38 -0500
Message-ID: <20261111065016.1306038-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107061043-failed-5.15-8dc4116041e2@kernel.org>
References: <20261107061043-failed-5.15-8dc4116041e2@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Nikolaos Karaolidis <nick@karaolidis.com>

[ Upstream commit 8dc4116041e2b377e5e1b62ba98b37636f9f3968 ]

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
[ sashal: Replaced inode_state_read(inode) with direct inode->i_state access. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/inode.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/inode.c b/fs/inode.c
index bfeec2830fb0d..f60beef04c3b7 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -813,6 +813,12 @@ static enum lru_status inode_lru_isolate(struct list_head *item,
 	if (!spin_trylock(&inode->i_lock))
 		return LRU_SKIP;
 
+	/* Another walker is dropping its page cache, leave it to that one */
+	if (inode->i_state & I_LRU_ISOLATING) {
+		spin_unlock(&inode->i_lock);
+		return LRU_SKIP;
+	}
+
 	/*
 	 * Referenced or dirty inodes are still in use. Give them another pass
 	 * through the LRU as we canot reclaim them now.
-- 
2.53.0

