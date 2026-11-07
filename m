Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794048813;
	b=3f0WfvAbfSwqWLMhxMiMj4qtIgrPm5/u8tWZLY+4F2e7LGZ2+Lo/6uhHzl8TUoivuRX6
	 1BBZp4YeLMDdBq3/7RNJ4Grf77ILjACaZ6N2pkUAtnmGK28xGj5OccgdmDuJv3riOqI1b
	 vzQwDh3Vfhfc9UqEdmWFnhQx/qWDYzkWhzmOJIwzkQ/7x7dXtht/neHdCBX5pozxlQlDD
	 NKJi04MMOhpsZLLYRpAKVIktkistxEZKQ2GxGS30l4bj8sy9rdRHkfH0ko21mymOJ8jY7
	 3j6PnkiE7TiKCZ3UOgebzAhsYUL1Ved+wMSvw1gSGbgpFFvHWnIk7obBFu8w0EE3qBg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794048813;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=8uUA0JISytSh/HJdhT9gdDawddyGCkFZOKoRNee8EaE=;
	b=Zk0vCGeqdDe5OQEDTPEHeT3JUZ9DM2g9udwSXLpEfrrCgbyckxi/mk2KFirDjAlWxtxv
	 zN9OKiwpclzLfVlucdsnakOyx8VlO+cmYXepO28p4xDO45SGpVPan1GSPlNjr10NRfPKb
	 kv5lg2lLwIGaQONgY/IBZoMahlbrWVkeoKE8gdkMBnE2/+pcoJzXT82N5HY3ZxxLC8UzV
	 tgHot1HZU7M76/Nnty9JuBeBNkvsdxE6grm8KlVp7HXrRrd1f1oMzoaq2S6zNPrFBFi4u
	 MSFIZoOcAZk0OfubHSPw9RUkPCj0W4xtFsyG+1LTLU6mGmwMbDj8kov6eN5v3kh4P/Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kYj18WXW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ED30606A32F
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kYj18WXW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C748D1F008A1;
	Sat,  7 Nov 2026 10:53:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794048813;
	bh=8uUA0JISytSh/HJdhT9gdDawddyGCkFZOKoRNee8EaE=;
	h=From:To:Cc:Subject:Date;
	b=kYj18WXW1izpSGq5JA7F0im3eHuM/sNBH5eoILa0q0OoGm/g/JzkyD0iuQdxJ0qze
	 ujbg8dPAlIFwl359zvx02bI3hbQp7DOkXeRhnoLKiK3S8bK1LVYT8zVN1fF+RjTCym
	 X3yLhIIwaVbWZHy+E4H7/uyh3lPJkZmsk4z4xgglA5rjUxvcdfk5nvhsneQkhru7TR
	 lwI4tlvdmnbiZVY09xvyo8lu5vNzuKOW2fyYTV+7trAlJKQDdUyTrWGz7X/4RIo+gL
	 5HwTi7oAJWTnjbPvExBdNTs4tTkZ19CgSY7EEq4BG4Sxv9aIBR3juPKyiQS7XY4+Dd
	 DgmDXqx19bbww==
From: Sasha Levin <sashal@kernel.org>
To: nick@karaolidis.com,
	jack@suse.cz,
	chengzhihao1@huawei.com,
	brauner@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] fs: rotate inodes whose page cache could not be dropped" failed to apply to 6.1-stable tree
Date: Sat,  7 Nov 2026 05:53:31 -0500
Message-ID: <20261107055331-failed-6.1-8ee09f597763@kernel.org>
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

The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 8ee09f597763acfd31c62a578ba88b792fc41b24
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107055331-failed-6.1-8ee09f597763@kernel.org' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

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




