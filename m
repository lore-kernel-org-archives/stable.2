Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794375291;
	b=sxjhbpuiOTRgWdr0l89u/Gu5Wtd7eFhPLpog1RMymrovzz9BkTG5birRww7m4eoLjrfI
	 JXdZ7KrtOaHCjP1rt/RhljuCc25ejFd2Q5H0PkCaArdPlHmnK/9Ff3D2kG5DePVTN7O0j
	 dDGgpqP950AqZo4Hx7ZZxdF6A0aviCQiXh7b9VdK3a4rXdIOjUa3NtnDeVgqbcCpDJLIb
	 OCuXjulZ7aELRna6BIjWLnn24qar3m+moClVc7QijB39yDgG6t3YKWRHnd+9aVHO9qgYF
	 tqSyb5wJIqQ5dczgCDaCc7L5NA9ajfbQdVnldx7POcbSPh2c7jrAmU9B2GGdIc9gUhw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794375291;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=hlpQhhKGKk7F2CBSSt3Ng9guGWL3vmIoPv0E8M4yfLY=;
	b=y8lFhHY0X9U9Tg3LX8zgj5U7dA5t+xHhik7oyxxHqUndRwjtWZYpW5v82dixKUZL+kZr
	 jJxMeVPBS68AO+gT5RpjJXbUV/gKxfTkzJJUShgb+ieja3+sYb8ZiaNxbRoy2y4VayORo
	 ziEG47QKQKxE9vg387ahOr0O6dVYYcBI2pvYhY1u9CYFo9DQw+5wfyPIu0gKgTGB/MTlN
	 mjPMR6zFYLHyTxGbaZ7CTRFLCbRGprtY7uaSPH9S3yAOGPSY63I5ciwFicB8qya4Tamc+
	 I02P2+GAYw5agptAY7IBgN3CzJn0tt/2XD5SdCej293fPy3k0UUb1T9gp324iYxo0xw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="VZuS/KAd";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0BB9606A31C
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 05:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VZuS/KAd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5FD01F0089F;
	Wed, 11 Nov 2026 05:34:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794375291;
	bh=hlpQhhKGKk7F2CBSSt3Ng9guGWL3vmIoPv0E8M4yfLY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VZuS/KAdPpWFiEvFXVwn1EeVvToqQCCK1dErJVe7+aWzyqDqfMDEG6eyhlfwsueL/
	 URlD4aLPsyuR9GCwNLW0KCUrFYuHStgaWgW5Pu3aLjH2WKTtJmvC+kCc20Zy9AJH78
	 XEUt1F/9EoPRR2hqKIup+nhi1cfoL5mnrZDtUdxPJtlSUj4Dto32fB+MuwLITsJdtv
	 HXNs5qMoTGc0tF/tDHPxgiXoliIPab0XIzMQy1XcnPOAicVFJIMGYf9ZucWwJgp11s
	 0/wNsyCIorknIBbsEyxtrApzQYM+7LAp6e+2MuGh0cksqFCo+tjcXK8djkahU5h6nI
	 D0ha+AEIR9KsQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Nikolaos Karaolidis <nick@karaolidis.com>,
	Zhihao Cheng <chengzhihao1@huawei.com>,
	Jan Kara <jack@suse.cz>,
	"Christian Brauner (Amutable)" <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] fs: don't lose inodes that another LRU walker is isolating
Date: Wed, 11 Nov 2026 00:34:49 -0500
Message-ID: <20261111053418.1281568-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107053816-failed-6.6-8dc4116041e2@kernel.org>
References: <20261107053816-failed-6.6-8dc4116041e2@kernel.org>
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
[ sashal: Replaced inode_state_read(inode) with direct inode->i_state access because the helper is unavailable. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/inode.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/inode.c b/fs/inode.c
index 5ebe791381096..67c328a6cdae0 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -854,6 +854,12 @@ static enum lru_status inode_lru_isolate(struct list_head *item,
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

