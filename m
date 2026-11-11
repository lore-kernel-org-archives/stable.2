Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794375929;
	b=W7COUEbn1RkN8XfQXRGgnJ2OAGGFL+NZa604m/UtMrJx1cUnpnEbrowHlaDMh7iHf9o8
	 FhK5O/o3wbW8V0jRVAj4nPXCxbHVmJiIN6kWQC6LUOsNAOnc6M5EhHs+2H7sMZn9U4+nE
	 /bn0v2IGAU/cenwQ0fJIHY/LvqUYUjNy8PIisFWQdu87Bg+kponAXXHes5x1LHVCGZKsB
	 5dui7MM8TR0QZatYhgUAnADvH2QVTD6YagSe6AvdyDBVZ+Vv2YjAZbzy9xQRm2XLmqCIM
	 jMs7q+n7diASQIjY0Xo7qb7rNtwv3Ysr+73wki5eoSoZEV15KkWeD1B+5kLuncdEHUg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794375929;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=fJwwCmK5jj3XJsNVDMDVALevhvdY6xopX3N/NVe3WO0=;
	b=YwbmIT66x+2uQM7gmaGP0l4RhtWUdCB/mfWne6xMrbgzdUdhFH7eIc5yS241Au7KaLIf
	 2Dc0Llxs4Rf3yGlAUbOE1KXZTEqKUWccSJUFnQ5nK8X1dKCg/zhyr5HdToOkYgnZhvQl2
	 K5H6GG1i6Q0BFpxzUY03vmyLCCAGTtwlc1AnCXVfI6WdlfrsslNfoZSE7Zc7GyFLG8HCo
	 nbzxgXO7wEVjSj6aHp7kBQp+F9wSHzt+K4isfldayQ0IM8B7e6br34c0F6RCAI3M2aF3P
	 gx2PVxIBgk/aVY6tSIu1ilktVN6pvrK3ZBYXBNz3h88yMq1uZh4+nJd40l/eMsIE3Zw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=l0zby5sk;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34190606A320
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 05:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=l0zby5sk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E7141F0089F;
	Wed, 11 Nov 2026 05:45:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794375928;
	bh=fJwwCmK5jj3XJsNVDMDVALevhvdY6xopX3N/NVe3WO0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=l0zby5skcBMVNzimADIWygVaG0DaqRyTRiH4esYmJG5i2D2mA7vHqH/fKS96czVSO
	 Z6ltzg33FItCvemmdaVnQNYUTV+MDPQRgRVA6zzu2rlmDUM7p6FWOe4dNhiZ9QDSrN
	 FOCsqjkpIEhMu7+Hkzrrma+MzEY4YZdDAop4omHNsqbIsKELTAw0rXXqsX0ykTZzDs
	 wqdqCmlS/fwURA9Z124tS0ohda8xsn9oqwxVa0bbXEgmPrReTmGb+fonulpAMqeb7C
	 YkBiQtWbpmYfjvwFSSWtw3lp8vP6OXA9qOiB3Uiu+h0kHLr92QDytOV9Evr/yBf/8g
	 laz5yA4ChWRlA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Nikolaos Karaolidis <nick@karaolidis.com>,
	Zhihao Cheng <chengzhihao1@huawei.com>,
	Jan Kara <jack@suse.cz>,
	"Christian Brauner (Amutable)" <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] fs: don't lose inodes that another LRU walker is isolating
Date: Wed, 11 Nov 2026 00:45:26 -0500
Message-ID: <20261111054505.1291702-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107055337-failed-6.1-8dc4116041e2@kernel.org>
References: <20261107055337-failed-6.1-8dc4116041e2@kernel.org>
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
[ sashal: Replaced inode_state_read(inode) with direct inode->i_state access because the accessor is unavailable. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/inode.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/inode.c b/fs/inode.c
index 99e980ddbdceb..bb754c1ae02f8 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -868,6 +868,12 @@ static enum lru_status inode_lru_isolate(struct list_head *item,
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

