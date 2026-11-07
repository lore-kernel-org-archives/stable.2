Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794049845;
	b=mT54VKwB+J8WnwHA1uyDmdqJ539pI04rU6HXca6f8wLAeSLpREGGObQ/td3eefeGGDZt
	 T1rz+JXgxaxHCAbad/t4DIgCd8Yi3Zkm6XsIUZWLM9Z7UM8ymAypaXGO1oH8Ca0uNeTdj
	 J7My2vLd+qaJNvVqEK5pK/CITqv2LT4AuSk38Dc2iN69tmrFDWEd/3BqsliSWdXCSVYly
	 aSNdVTi8lRu6Kn2L6l0KLXtmXJn8xlrkHkoeASfPEu5WyOGHjtZFLbe7UHwS+5LCkxtZI
	 uFF8eIj2/d6gyX7Y5zMGZVDyW89xxsz/wJDFXNj5uv/F0NinRAur7Er79Ah82PtoQ1Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794049845;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=Ux9PrsLVTIqOyZErZTLlqPBmr1r8sJm+ywlCMCEg1pE=;
	b=DtoOAuFaGEFQ0INSe+46dPuysUSl6xxVs6ZzCnjXJ2/fziatGVzlrKMxTNECJ6C1peKW
	 nTlDyDb8Pu9ZOQli8nUivDQftgvrH3zV2qn2nMl5U+Rsq0YXzpnZL15l/vTEZDZ7Hwfyn
	 OfIvBtGo4PYJeepVgZeMOd2dDPazijsTbWyDinFs66qHG6p5DmbO5M+M9LiAzsxvRjX/u
	 DIuf8qL8FdqQbFGIT+s7+hNy7d36d98V7HR47RcfNcgjcUeY0src1RiVbYqGUaxGRp+td
	 d2Z5Iu/38TZ2q7TjSmDI1WlWiQCnccqkNNXv4NgeX6lRMBWgEPeA94mdMpeuIV11SJQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="OeuH/PhD";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EBFF606A32D
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OeuH/PhD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4E551F008A1;
	Sat,  7 Nov 2026 11:10:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794049845;
	bh=Ux9PrsLVTIqOyZErZTLlqPBmr1r8sJm+ywlCMCEg1pE=;
	h=From:To:Cc:Subject:Date;
	b=OeuH/PhDHUJD0YG+91ObdZRBTEdoAofhvXjJQmbidbNmFXLKz/naTVOOt3UiQPuHu
	 6Nfe0ryaN1ltZ7D8T3+dCUGze7C7wSkqEfepHExAA8VmFW1PhTkpS4/hTifr3ZAItj
	 uiBpzP37E5AoRY4/MBpdPSrEFtqUHc9LdV+fncKIgmSgKBgqfkhKTmSQTnSBnbIDze
	 LwH9WzjFXH55dHrt6wGQHzWeS4gFO2OBHP7qxcw6yu/AQ9J8eGGb+edysXLxxOCrY5
	 9oTQxe4+UKIF7BU6yX5P3XYsrD9CpCd+SbPIq6/ftlIMZgWbmKIli9SrfzyX0C7jlp
	 mWzC8VsUk88dw==
From: Sasha Levin <sashal@kernel.org>
To: nick@karaolidis.com,
	chengzhihao1@huawei.com,
	jack@suse.cz,
	brauner@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] fs: don't lose inodes that another LRU walker is isolating" failed to apply to 5.15-stable tree
Date: Sat,  7 Nov 2026 06:10:43 -0500
Message-ID: <20261107061043-failed-5.15-8dc4116041e2@kernel.org>
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

The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 8dc4116041e2b377e5e1b62ba98b37636f9f3968
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107061043-failed-5.15-8dc4116041e2@kernel.org' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

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




