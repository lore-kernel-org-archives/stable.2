Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794050865;
	b=pTmE+nm3R7ABJe05HDL5xm2fPJ1eTK7w1c0IiTc8CLIcg9kaW98z6OFNVK8RNZwTzxUg
	 /yRpn6z56MgmbWeiRB2evY4EtiWeEQV/3yuPow31J/Rx48mAz9ZjA4y/zlqh6GortuAgx
	 bKs/GY4OGFmtucsp8Fz1VuSohAmX5gU3Vsd3cNYhk1vBASi7ImKyRDYs/YG22vdJ21q55
	 3HWSFODh34exLo54XVp624s4NZW2elKwNSR6hd5JkiTekIkEMI0Banj6S/ekHa6lkhvvS
	 mon421td+K3tFRCVSQwATX1lVra0zyo7fh1Q+DQCqhaKh/FZ3Cmt2MwmQsLAfDy0UAA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794050865;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=pc1i1vD3j8OypHrLuj+k8JbsoejswIwz3na36XjCp08=;
	b=NqPEHkuVZ8yYpsIwiXtVPUzH87UODg2q+Zm+1GyZEHln/PAJrW/Uf22r6jsuM4kgjQyd
	 Ku21ZDAVPfQ9B1afdtbRGPBN7HB6kH3Aj/Da3iFQDyN/MoIAlpHmuT/zVkr8vOtJJ97cT
	 MozdK2iOVvFyR5d362hTI8+JpzmNW9OXTxnCst9IFMpOjQ7W0BEDc+VsV2Pm+9uYNJt6/
	 W1g4KMtnIU6C/Q7vMT/bdEdApQbyg4aaP/LOU9XbhyVg1sjjVGNYEXMfyvQc412UEDDsD
	 CgmrWCjPUkvrPhrUqh5QVZWkkmkNS/y42eBAGS4Hngw13ZnFxQfbUG571xk9qzDW+hw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jRSAZnn7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 976DF606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jRSAZnn7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CC911F0089F;
	Sat,  7 Nov 2026 11:27:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794050865;
	bh=pc1i1vD3j8OypHrLuj+k8JbsoejswIwz3na36XjCp08=;
	h=From:To:Cc:Subject:Date;
	b=jRSAZnn7iXWAkrb+RxUoXKLzpetp2dIiYSWtPE4YO//YnqQNwEXG2a7UkGxvWoJY9
	 pekK5ifdpQhqrCbzZNpLySSf/7zaZv2ZTTmOkzJt0NU9gSVr3ynNY4eyPXqyog/QDp
	 o79XmdFDhsSdbkjSYtoYCVyiAB5OvW7LyWrGAa8Pf/oRJLBfU2Xw+D2j9PeBB1qSQ6
	 ACfPXrp/58Bzg9S37gJlB3ZDr9SfI8JUTDZmzuxaqc+5C+M7AwiQSXpFwZRtj/UR0T
	 tmybGja+bUPs0RxM2fi2xiyYLxn6+bowX7MMu+o2X1vUpIooeiLp08XH/wih/C1E2H
	 lDThx+EtNUIvQ==
From: Sasha Levin <sashal@kernel.org>
To: nick@karaolidis.com,
	jack@suse.cz,
	chengzhihao1@huawei.com,
	brauner@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] fs: rotate inodes whose page cache could not be dropped" failed to apply to 5.10-stable tree
Date: Sat,  7 Nov 2026 06:27:43 -0500
Message-ID: <20261107062743-failed-5.10-8ee09f597763@kernel.org>
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

The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 8ee09f597763acfd31c62a578ba88b792fc41b24
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107062743-failed-5.10-8ee09f597763@kernel.org' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

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




