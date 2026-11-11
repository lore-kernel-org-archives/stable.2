Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794366707;
	b=n+1fpdS/8UDaD7zZUINwqnyEcA6TVR6Hv3geMi+pYMRoXhasy03WMvWxqx8vfLRhrDlK
	 k4Jk4p9K+LU81m0oLiGhQOEXo0LUOyw2gIzSBRS2b46xxzRypOKe2QXYIVKqwOVrJuBBX
	 OeRy8Nq39/P0ukulMi06wfQGFQBFkpEx8thJRN0ahdzOJ9fZnXbWQkJQVVmdQ6iaN9Kx2
	 nvGB7c6t1ASaPyHOvGwSNxphZy4ViNzvyJvfxHMcoG0vHYR1hnzNsjwAGBkJg0gJ7CBPy
	 cvBAwhn73D+x3VGD45N3DqtqWDajaalUN4DY0THTgpc9SAVwlRTIkFwsl/SbjJAIU+A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794366707;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=W1d4BBTnRMrrq6zRpQrkNMIc+mADUrtFELhXVwQOBIM=;
	b=voQavfXIlBmhpQKdKLeU90MJDtOT+YcHgYQJVja3KCkpQNo7njbEP4nUKmezsYsyfGi2
	 iSieKThIN5kG5aXl5UG2PZtLzxIW7EqiOsrdSH2pw91ipEOrWtH9nYr0CU7iW/gK0jj37
	 XfDpEzZJCH9s/s+Lb6bdV8s+utaFZBOTQQ3jjAPhTFE8TrzwvYErhWKay+sMjiLecp/75
	 qJyY5IcmeHpeq3aRN2Cqf2f6qfS1dw6TgIxtlYa7IgnVRERWQOGswXSHWFrdIR7qTJT1Z
	 tKneXOpXz1+Lry3pI4md86Z8/zFu/3a8D0LZP8KvziSr/Kzx+N+ihJMqwHebhc/XseQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=n7lDU9Ek;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D14A2606A31C
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 03:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=n7lDU9Ek
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B003E1F0089F;
	Wed, 11 Nov 2026 03:11:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794366707;
	bh=W1d4BBTnRMrrq6zRpQrkNMIc+mADUrtFELhXVwQOBIM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=n7lDU9EkdqVbL9gtWr8iKYTjdaLgtHGZKLY+kHS/CU6ATLTj3OiIGaU7dBbL206cM
	 ZwFbG8AqzdjIOuT9b8Sw/I4faK5FwmIF/rd/+WtUXPV/7CBQbwhfop1JYW09uKz9fE
	 bh+R1SCEthkBEm7G8TwmM+TseH11UBgoBMFxlch1mGbFX3Mvlf/CqAqI9nwADrL+tF
	 T/4YsQ5aK+CAZm2WGdaA7C7tsZW5vro6M6Fadn2WcXDkD2lmMPOklD1ygq7EwbZgH0
	 qebYjV3f6updey2d2OlWhzIkjTuq9STMyRXXE2EWnOkHOaY+8LiYcov82Dqf3hJuai
	 d3hrjQ2sHzgfg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Nikolaos Karaolidis <nick@karaolidis.com>,
	Jan Kara <jack@suse.cz>,
	Zhihao Cheng <chengzhihao1@huawei.com>,
	"Christian Brauner (Amutable)" <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] fs: rotate inodes whose page cache could not be dropped
Date: Tue, 10 Nov 2026 22:11:44 -0500
Message-ID: <20261111030947.850494-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107055331-failed-6.1-8ee09f597763@kernel.org>
References: <20261107055331-failed-6.1-8ee09f597763@kernel.org>
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

[ Upstream commit 8ee09f597763acfd31c62a578ba88b792fc41b24 ]

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
[ sashal: replaced inode_state_set() with direct inode->i_state bit manipulation ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/inode.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/fs/inode.c b/fs/inode.c
index 99e980ddbdceb..8e430ccb23c6e 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -496,12 +496,11 @@ static void inode_pin_lru_isolating(struct inode *inode)
 
 static void inode_unpin_lru_isolating(struct inode *inode)
 {
-	spin_lock(&inode->i_lock);
+	lockdep_assert_held(&inode->i_lock);
 	WARN_ON(!(inode->i_state & I_LRU_ISOLATING));
 	inode->i_state &= ~I_LRU_ISOLATING;
 	smp_mb();
 	wake_up_bit(&inode->i_state, __I_LRU_ISOLATING);
-	spin_unlock(&inode->i_lock);
 }
 
 static void inode_wait_for_lru_isolating(struct inode *inode)
@@ -909,7 +908,13 @@ static enum lru_status inode_lru_isolate(struct list_head *item,
 			if (current->reclaim_state)
 				current->reclaim_state->reclaimed_slab += reap;
 		}
+
+		spin_lock(&inode->i_lock);
+		/* The walk restarts here: don't retry leftovers right away */
+		if (!mapping_empty(&inode->i_data))
+			inode->i_state |= I_REFERENCED;
 		inode_unpin_lru_isolating(inode);
+		spin_unlock(&inode->i_lock);
 		spin_lock(lru_lock);
 		return LRU_RETRY;
 	}
-- 
2.53.0

