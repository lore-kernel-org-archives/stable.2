Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794383421;
	b=oGLfioVWeX91ZRPyMsms8YHFmvsAaXZLt6Q+lgavoHv5RgESSHIIfsWqbb7oR6NAbwAO
	 zjn+utqYq8KhQbifz1Hte6ZRhmRn/Qg3sMYxFuuw76+ALuq0Mw73qB8nPGEPMO/HwuggV
	 PAiV4vjikWV7ffbnv4Diqp8K0U6Oot7SdkXZXF+kVi0ejfXnfmHWzpe+hsf7reAwvG+Pz
	 S9nf4+3vpIX43dGu1zoU/DEklWI0PgWsIeOvPjkH/hEpD3/OWrpAyCHZWYVz1DvmVovh3
	 7vMS9ecUIvlNJFm/RFEs4EO9cZJ9lspz0l/YyNIGMVJstvfm61ijj+/nW2bOYhM5jaw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794383421;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=W34d6fKc8gslsPNMLR2Tp5UYzF8DphOs1nP0xBxT81o=;
	b=yQv0oxEzivadOjO8coOgNVFdcM7r4roLyTA0oHIGcb66lMelfxJnAMTeM/YYltGQ8AeO
	 yz7OuiZkSRhBi9Hq8ygWW4GEx2TVIodUWBXk5gCeo68def3q2npLqzuNiONVM8xfe5tF5
	 zou7mvXkcHItl5LIUg/KwjX0XAfi8oMau98fPE3ILuvJj1I7vV0mTZskcc4rMI6XETMQq
	 LKAp0TTTvzBLS9m1yY/ge3dTJlp47V+GY6Oup2FRMGOXiWb+rwrXTwIdQ9zTGxXyaATJ+
	 LuP5O+XLFYPmjR/i+g5M2HzrkZEFNyTviEpCNlphhlrVi3PRfgEWGfz1ctq1n9oZmBw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="XD/AUHwi";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25AC8606A31C
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 07:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XD/AUHwi
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 144B91F00A06;
	Wed, 11 Nov 2026 07:50:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794383420;
	bh=W34d6fKc8gslsPNMLR2Tp5UYzF8DphOs1nP0xBxT81o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XD/AUHwiQyBiFcCXGfSwKXqgve6RslbJoci3NLOHyJaF58pjS6TJkNp6U5XP+Iv5o
	 exVowAXtIS17sOJY4gBYOGv3UPy3Vy9PR70VWaYDra3IFuW61dBnaDFbmLWfh7qHYv
	 3rZpUh2JaIAcbqBQIuo56rtpgtBzW0tDm9GjDfHMXB5kn3aadLHEyaVFkuM2YdbLse
	 lhqMxAa22ZFUbGEHYoF7XlKICl6b9jc+oxvFeZJ7eLHKH4S4tToKlvwc7iZ2XL4go6
	 ITgyP3mHsuhm0tMvCOy7ztJ/zyZGQRCWRVpzRFjr/SXXeEW/r9o4GB9CSQA17LTRvq
	 u6dNan2s+/Jig==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Nikolaos Karaolidis <nick@karaolidis.com>,
	Zhihao Cheng <chengzhihao1@huawei.com>,
	Jan Kara <jack@suse.cz>,
	"Christian Brauner (Amutable)" <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] fs: don't lose inodes that another LRU walker is isolating
Date: Wed, 11 Nov 2026 02:50:18 -0500
Message-ID: <20261111074752.1355278-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107062746-failed-5.10-8dc4116041e2@kernel.org>
References: <20261107062746-failed-5.10-8dc4116041e2@kernel.org>
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
[ sashal: Replaced inode_state_read(inode) with direct inode->i_state access under the existing i_lock. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/inode.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/inode.c b/fs/inode.c
index 40cc72fe37f99..4b450ae312204 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -788,6 +788,12 @@ static enum lru_status inode_lru_isolate(struct list_head *item,
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

