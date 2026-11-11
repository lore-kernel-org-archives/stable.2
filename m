Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794374723;
	b=VKHB6ERCsBVI9Oa6S1SzQaFS3RWPSHI3i1EfawBtM1G12cgvkfVigA2mHBC9sFYD6LxZ
	 J0IpFtab4VYT+HWYdxXEotZhs3YY63lOIg0IqgyYR87lMJysACDwIgFle7A6q07C5WdR8
	 u/XUdyPSzFPLEaE/mXJ7AhY2+t+Mde0ihEx4rniTdynSqrDfLe+If+v1tpk9kySIrL/Ij
	 YeLkjDaUG1s604Fhq/YKZj59rmVRZAxH09SE5tFPIXiMTXIYCxPM6GUsFbfPYOCM7rJ0E
	 rQBxjh0VKtbvqspMsITdU5p/eponBCiXnMP9AavybLEnLsMBFcYPumJsgQxyr2RXB1w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794374723;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=vwoB68/lfWDUEiLUBfsJBMM9jZdkfvTVUYChgmolXdQ=;
	b=ZR+3LgF/KBp6oTYgYdQiQkN+lnoB4ai0k1k5yTTcFMaJ1Rgp3xTkc3/KcnacCKgj4PSp
	 g3g5/JIUz2Ex7eXt16RFRz8sHnyLZX7YKP3vmH1TdXYfSogOeGKH6D0xz43p2uHOSXlDm
	 mDsg27AyLtwrqqDXYIY8MPXyYgp+tmne7MvKwXIHYGXafBHEUsEMGOfc8n/+OWXak//9A
	 SSb+nS1zoMD/XVVdoatYHjr/jxSeRgFZcTwU1WJ73T1mUr3z1jqV9gArVhJZwFTVaE2cN
	 0xibWBjiB7D01ZWtbhSbP9zGIQUe36mdq1gVS0ybgJ4yxyL9XvcYaBJSoWTaAS66+oQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SSI0E8DW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 894E5606A31C
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 05:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SSI0E8DW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E2BB1F0089F;
	Wed, 11 Nov 2026 05:25:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794374723;
	bh=vwoB68/lfWDUEiLUBfsJBMM9jZdkfvTVUYChgmolXdQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SSI0E8DWWVnfWNxKDKL1VA2MRAtSKdlgwVkBNdw5Ap7SlR9hNnpVKO6JVv1LU6aFa
	 1oSxhtQJnUoUm84s7Oyu9pRaof6sNA6CC6QWgoC1YYRdtknpM5gRqpIfjxP1SbLdyG
	 vNsd5/4/mI+CCBZ6qOjqWcxOkIQdyjP80NnbnusWlDVwsSzrsKgZ5SjNcWteI/YrNh
	 ZCIDd8pE8sTSRZ4O7eKGLm8yZJyzDnj0r5b1/EFBV55Uaf4AGt7a49oZ9hDFLPtz0f
	 C6RKZ05Kn+ba9g0wgq2qxeqoeg5DC/M3lhhVZohgybi1HMJfQQEAbhlCY3DW33kKOV
	 nnDMAW2bWCDWA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Nikolaos Karaolidis <nick@karaolidis.com>,
	Zhihao Cheng <chengzhihao1@huawei.com>,
	Jan Kara <jack@suse.cz>,
	"Christian Brauner (Amutable)" <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] fs: don't lose inodes that another LRU walker is isolating
Date: Wed, 11 Nov 2026 00:25:21 -0500
Message-ID: <20261111052452.1261706-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107052525-failed-6.12-8dc4116041e2@kernel.org>
References: <20261107052525-failed-6.12-8dc4116041e2@kernel.org>
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
[ sashal: Replaced unavailable inode_state_read(inode) with direct inode->i_state access. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/inode.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/inode.c b/fs/inode.c
index 7942673f686fd..0941b7e15ccd7 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -890,6 +890,12 @@ static enum lru_status inode_lru_isolate(struct list_head *item,
 	if (!spin_trylock(&inode->i_lock))
 		return LRU_SKIP;
 
+	/* Another walker is dropping its page cache, leave it to that one */
+	if (inode->i_state & I_LRU_ISOLATING) {
+		spin_unlock(&inode->i_lock);
+		return LRU_SKIP;
+	}
+
 	/*
 	 * Inodes can get referenced, redirtied, or repopulated while
 	 * they're already on the LRU, and this can make them
-- 
2.53.0

