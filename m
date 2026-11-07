Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794049832;
	b=SW76W3I17kfwCr50CWHbApGeD9WqY3K7GodPHp4J1mUstsvbOlyaldlTzylnNLmjN87I
	 wM7GWnCKUvE5/qU3KAIJgrE3OjQLyqdzzGWKh/4HHblJbMnfgnYc7VOumX0REhdoOpMt5
	 0cXxZec1v0tEOoD6kJl+SMbxeCbq+6eu3O8JnESt5d/1Eb+mEDPJa28hwnPIJX940Y/gy
	 r3jdPtYuRS37dDtf3izKYdzlXurAjvCwO7+ISbZHH2lKEkShfLWEhXowYhK85wJpZ52It
	 15UJbe9BlbZWXU5Aug/CNPsxUvAVxVbDyzQ0KV5YBR2X/ishhKe9YrpuTypRDikzPYg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794049832;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=7J0reLjR48Ix1PnJ4xM4OMitrPsoDrqfR4OrKwBk/bM=;
	b=ZM9jDHfpZuMeeuIHmBXUzwX0lgsBKkwMTspibChififofzdS+p9PGRxm6ijiqMyBkvwN
	 CvDsnevMEfCuSi3JG2Wif/NpU1lGAQKN+qA/aCwDaNa67udVsUB4vfFsXbhtzQ1fJXOs4
	 ZIyziM5oKgTAwogvfjhea83V36tGD4ZVJ2PJ7DK7QTr82f+masm38fiMQlf8G1whY+UZA
	 xxARUb5YETmU9qiS24dY/b5tfX2Rg1ciQqHZFzvEumaz9y76Uv8O7H3rSw2pT2X0hsDZ0
	 j+nxWZ6JGACXlnQFAWPxeLu83tyDLs4+tZn+jjtTYUfS1I6jeHRFdNNvwuAbM4EWhhw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Z+5YCiYq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36D51606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Z+5YCiYq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AA961F008A1;
	Sat,  7 Nov 2026 11:10:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794049832;
	bh=7J0reLjR48Ix1PnJ4xM4OMitrPsoDrqfR4OrKwBk/bM=;
	h=From:To:Cc:Subject:Date;
	b=Z+5YCiYqd790ySAndt7Tlx/KNef6AET6i9Sv3XZPoRfZXYMlmLeC/OPWA8kzJ+Jw+
	 TSsHe7VvRKSPpHXHSx9TXtA4Ulxbf3KpgbI23NTw9gavX8ysiylhGQQLj9Zkinptbs
	 40P3g1cqwLs3ApvkJcy4rnhotJGrK84pYkf0/t6nVjV79qICqQxf5bdvztg00plS1n
	 6okMOzYzohuM3dFjY+NoezuiuTcqnPvbkRkoxRa69CqOf93IVZJ5PtmCU2yH/9RUDM
	 9l8k/OjTil1tmGTIpDHIKdhzFCVg3/abIk727OeqiHL1IrJGmTTbfECaxPU58ZHmxw
	 7+IcrfSWtj0rA==
From: Sasha Levin <sashal@kernel.org>
To: nick@karaolidis.com,
	jack@suse.cz,
	chengzhihao1@huawei.com,
	brauner@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] fs: rotate inodes whose page cache could not be dropped" failed to apply to 5.15-stable tree
Date: Sat,  7 Nov 2026 06:10:30 -0500
Message-ID: <20261107061029-failed-5.15-8ee09f597763@kernel.org>
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
git cherry-pick -x 8ee09f597763acfd31c62a578ba88b792fc41b24
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107061029-failed-5.15-8ee09f597763@kernel.org' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 8ee09f597763acfd31c62a578ba88b792fc41b24 Mon Sep 17 00:00:00 2001
From: Nikolaos Karaolidis <nick@karaolidis.com>
Date: Fri, 16 Oct 2026 10:25:15 +0000
Subject: [PATCH] fs: rotate inodes whose page cache could not be dropped

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
Signed-off-by: Nikolaos Karaolidis <nick@karaolidis.com>
Link: https://patch.msgid.link/20261016102515.111285-1-nick@karaolidis.com
Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: Zhihao Cheng <chengzhihao1@huawei.com>
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/inode.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/fs/inode.c b/fs/inode.c
index 1cb6293b237a3..d6353b8d1e634 100644
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
 
-- 
2.53.0




