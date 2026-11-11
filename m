Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794369883;
	b=di1ElsrtrBfV1HutWLDvXLU5mOfxMjU4/uvgqsKybBF23ofSkVd1icR4YCP/QPHGT76v
	 q2cphrHxPiyKd4N5T0L71CSm0pFBxqKKAEOSEEv3jtn49NzKdrnB60RV9kGZQtcv4gKKN
	 8CjOsqy0XYWY6z8LBif6GDCCwMGONxh4Hx7EZBFI+W3wwEyvL75CcMsfaS1HQdTEBNsJQ
	 nWrKqoNe9KvPc90UBGXEeCAsRm1jqaepI52ihsnP9uPtrjMuLTLQJ6wvbv1GLaqr0iK8Q
	 I0HZbe4+Qdqh1MfSNSvartQESvgm0Nsh/lEohkd+Q6kBanX4QWyWBGxSS7KiyY2jvrg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794369883;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=PJ5urPgP/AJ0cI6q7APEyXHY5fcxEsUH4tMgRiK/Tbg=;
	b=af/qioWyhWCvw63ftG9crxKlWDJnaDIFLbyAEqwGFAuKRUZi193/oq2bMjUX023X6kEU
	 URuPjdmf603sZ9vNMqIjYN4gqknuRAdLqUZ8P5s/GW7JnGdwwi3xzP2jU1EQo/1bpfbWW
	 sza46uL1MwQoASMJkSKouXmFmWqWWo5M1YdyM6WDdDsAtPebD7cqHBHgohJLc/7nP6Ta0
	 6wB3Rw5LpkWa85C96Of0Y5l65y0x07Dvacn6sMCpW6aVrABjBu4bvo4uAuAg0unWBkSPS
	 o6jwAdf2mZ/RdAZXj0n59Y9qCWiGZ6OUZVXg+fKVByydFZv1ItqBLkIFgvdQvIJxZig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=H0Aex57O;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD69C606A31C
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 04:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=H0Aex57O
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1AFD1F00A00;
	Wed, 11 Nov 2026 04:04:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794369883;
	bh=PJ5urPgP/AJ0cI6q7APEyXHY5fcxEsUH4tMgRiK/Tbg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=H0Aex57Oq8moN4tynpEqDR01ThKrx9gPpfTAUgw6qHKxKp0JjEAITIOfzStyX8JkJ
	 1bF3uMvQynInlfcUB6o11reAcAwtlYUKODWnnunyozjlyuhJ3kUfSf5lqzH/8bzhGk
	 jV0H19MHrq7W7Kzm+1fdd6qn2aHm/u5obAOE2bZ8+2KPjbHU2WLaOTCkH4+3ho8FdU
	 7QefF4EwTaJCoRvXutp10OYl0VpQM/a+18TrEnd4C0kzhndR61ieJ215WWb7ITTnoG
	 90ehmHb6XeCsNr4t54kzqd2eGpl2cONdX7kX1Q3QCe9EL0Yt7ZvlcLOLF38uCvpl/d
	 sIhr7weaodweQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Nikolaos Karaolidis <nick@karaolidis.com>,
	Jan Kara <jack@suse.cz>,
	Zhihao Cheng <chengzhihao1@huawei.com>,
	"Christian Brauner (Amutable)" <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] fs: rotate inodes whose page cache could not be dropped
Date: Tue, 10 Nov 2026 23:04:41 -0500
Message-ID: <20261111040218.874998-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107061029-failed-5.15-8ee09f597763@kernel.org>
References: <20261107061029-failed-5.15-8ee09f597763@kernel.org>
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
[ sashal: replaced inode_state_set() with a direct inode->i_state bit update ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/inode.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/fs/inode.c b/fs/inode.c
index bfeec2830fb0d..2e03403ed50c0 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -490,12 +490,11 @@ static void inode_pin_lru_isolating(struct inode *inode)
 
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
@@ -846,7 +845,13 @@ static enum lru_status inode_lru_isolate(struct list_head *item,
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

