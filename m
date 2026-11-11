Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794365009;
	b=TE2fuUFpRkPjxlCyp8K67FbtDX4hIh4dOZM4O2DrD9SnIPtu9ggxui1EMWoERh58fhjS
	 vuOnqK/IdthOYLWRjSYmPo5Ah11BZafuw0mBH+aKehzBg9xIv/kFN2eLl3+oEKY9Mxtl8
	 gfFrHSbmHKrbNrTzHoSrIooOphqP7u27eZpf71l7e2aaXD/KFO/jOyCjOjWXNnhrBhD1x
	 mesZvLrlTgAS5tgIMi1wExHxgtlfAwOgkIc+hZ2BwRVhjjyDLg2ThhHKjUA24IfVOwKrk
	 pPicSDUQDWxPvgIK++L7p6nBdjEaE/Aj0gXGbzsvy8PmwzwgvlXP0o+faCfI0gGmVOQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794365009;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=hNLIgky3BdAkjoqPltXY3XMANUVj9JnxXYEGf89JivI=;
	b=X/Dy2sG/MClvykIHtc+qE9jfEzfkXPrViWR77GVBNrTjLTQoNy48vT1Zn0pPgv304u7l
	 c3bV627QaZlW9UrRxCcFIS0KJu5NC4bOWf/+PSu8S3+tdsmVBcJNfi4+9ojVcIFJcEyAd
	 hMYBv+awLoucTkde99mzWN6EMkSlsTbjt2cY8MBYDZ2vs7mYclyYLpYmWT4Fb3vpjMZVl
	 0ZZz0XsFpq7HZoPm063HloqUDvDdRBPyrRv1BZ5+Fayop+Uh64UHlJLkIax+EekuRIJ+H
	 +3G+iUvGofElLtw9D28Cr4KTe266DJU87r05D8DBFrZDzdEjIoeX9Ih8+I75IeAo+Eg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="CcX4Rg/d";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1177606A321
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 02:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CcX4Rg/d
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 164701F00A06;
	Wed, 11 Nov 2026 02:43:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794365008;
	bh=hNLIgky3BdAkjoqPltXY3XMANUVj9JnxXYEGf89JivI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CcX4Rg/dGN5JHIAeDJ0YRF95ArrE2P5EidyyCT5Md2ZR+QAzyELFZ2s226J0l5f1I
	 HFH3XKLWPsnGPVPFhyt31XmKmQoNtC0fXVF83gqxMBN4bDN3goC/068olpwcWk2p4M
	 ixZGsk9358fsWeRdRciHiJr5qcOAJjf4+k4X8HOxCOP6HIZHdCRpGCrZ9pXSdxVzEs
	 g1mNIQHPxX7eU2HFiNuz72sh6mmuKGguViLTuWv6Ext17WNgEy7sbp4n9C97L8des5
	 NDTxT40xEMi5wkuO3uu8g+36ILGiPk+y6Yddzen7xzXMrqvah19RVPjL1z0VCw3XL/
	 2cDcx0O/ksCVw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Nikolaos Karaolidis <nick@karaolidis.com>,
	Jan Kara <jack@suse.cz>,
	Zhihao Cheng <chengzhihao1@huawei.com>,
	"Christian Brauner (Amutable)" <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 6/6] fs: rotate inodes whose page cache could not be dropped
Date: Tue, 10 Nov 2026 21:43:23 -0500
Message-ID: <20261111024017.675599-6-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261111024017.675599-1-sashal@kernel.org>
References: <20261107051338-failed-6.18-8ee09f597763@kernel.org>
 <20261111024017.675599-1-sashal@kernel.org>
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
[ sashal: Adjusted context for direct i_state accesses in inode_unpin_lru_isolating() where upstream uses inode state accessors. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/inode.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/fs/inode.c b/fs/inode.c
index ec58d248a7ed9..229ac6ff72cb9 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -581,12 +581,11 @@ static void inode_pin_lru_isolating(struct inode *inode)
 
 static void inode_unpin_lru_isolating(struct inode *inode)
 {
-	spin_lock(&inode->i_lock);
+	lockdep_assert_held(&inode->i_lock);
 	WARN_ON(!(inode->i_state & I_LRU_ISOLATING));
 	inode->i_state &= ~I_LRU_ISOLATING;
 	/* Called with inode->i_lock which ensures memory ordering. */
 	inode_wake_up_bit(inode, __I_LRU_ISOLATING);
-	spin_unlock(&inode->i_lock);
 }
 
 static void inode_wait_for_lru_isolating(struct inode *inode)
@@ -964,7 +963,13 @@ static enum lru_status inode_lru_isolate(struct list_head *item,
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

