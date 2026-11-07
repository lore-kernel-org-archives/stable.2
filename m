Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794046425;
	b=VzEDNMTKPJvfKwivDfDfjV/L7N9SMPV6brCVPMc5gLdAZ59m5iiMVol2Au5E/EE6NdxB
	 IbwvzfXa6L2gxKOvolGTS3G2QbMMrxsatPW7hKwi0nfGo0EwmvqrfHuzuCF0rF8OvUm7I
	 /bV6yoOgfbZ3cw0oqVZn8G2JRO/vyMqeooyKe4h9ir8a1LCO0lcU4EoeuY1duG3iMaVuZ
	 z3awQflhVUX1rMitsxiN/Q5sdYtmM9yCWLg80nwGTp7AME4J21fh9yqxb8vU3RWPb4gyw
	 mVM4UE4VJTBcpgPF7F/sKeJ/XvWy9FPUb7mnK2UhPJFireK43XQtSImBT88+2yWjojg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794046425;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=uSQ8uEv+3gAgfeUutZsEkiJnov9euBfyqtLxXgRMs34=;
	b=nn/rEf6OqXGC6wLhr+cnz/UcW83FNqRz9VrCiS76BFlkOXUnBKys5//b1ys6L050bSHg
	 kwYM5OGUjO+uW0/6C31H3p//GBxB+ouX3hJoS+/yq7QHFn+yWxmTvccauydDAVDcSrvC6
	 YnVuOsAEzcFKP06brmTQO4kZM86QiMY+uOVhiHah9QRjHcQ61fEacHXhlS1Ptt+/VmbHz
	 xNKKPFUeN7iZTQ8pz/vQKOzhhwBFEjxLeczXg/3jj86FCwDcaOwYIp+06+Rkz6CscZrld
	 fYMAL9DZCibS5RXlBGZSBix0L3pUOu93Oudm/mGi5azqt6TZLkXsn1H0O6EvMtJzZiA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=M3vBk54X;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FDDD606A32E
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=M3vBk54X
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 834741F0089F;
	Sat,  7 Nov 2026 10:13:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794046425;
	bh=uSQ8uEv+3gAgfeUutZsEkiJnov9euBfyqtLxXgRMs34=;
	h=From:To:Cc:Subject:Date;
	b=M3vBk54Xfu3A+lKh5cpYle5ykpY+LsivcJKg5/FxSVTjroW9zXxYI2HzbBA6X9l7H
	 Kpm6tpP50xn9x7D2BevJCno3sYSGz52OB401oTVNOrqAGLsBqDovD8/Khn/gnx71aS
	 97KciSpss0R+tGkI5hIahOgZjKWGdJiGYqc7efdOtv2lxDExFaLHt3ZPrzY2c5Z0lb
	 4q2EFQNKGoaQVfffRuCYgK06CT1k3yk1bTKI1ZA415x+Zjxt4AOk9jXxnkU3x88E3L
	 xyH9n+DRMOFVzjv5O6zemxiSrgH1WYcwYj0lVwVZZZ+939K6xqEtX/6a/w1Zs9+3um
	 ot1ZR4MOpiivg==
From: Sasha Levin <sashal@kernel.org>
To: nick@karaolidis.com,
	chengzhihao1@huawei.com,
	jack@suse.cz,
	brauner@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] fs: don't lose inodes that another LRU walker is isolating" failed to apply to 6.18-stable tree
Date: Sat,  7 Nov 2026 05:13:43 -0500
Message-ID: <20261107051343-failed-6.18-8dc4116041e2@kernel.org>
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

The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 8dc4116041e2b377e5e1b62ba98b37636f9f3968
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107051343-failed-6.18-8dc4116041e2@kernel.org' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

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




