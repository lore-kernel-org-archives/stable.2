Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794047894;
	b=Yxb/q853mrjazl1fBsdwOVFHBce3ztItThVGU8yewMVzfte84yRSAfOniJ+gpLj/KgZZ
	 aYFxLLvyiXkeRftCALst5Lrd4RBiie+LSd4w0V6TEqvuCOMdXlEfWxdKUxTRDwh4ZaTrh
	 tIrs0EXXAWk1JFrT7RZBM1ncbJfA4xKZ6sCrnjGMcpjYIPKZYxfQj1b9E1AnewP2poQmI
	 ZSPrD3wchnJdr69PU6kNjUzy213t6J9ZC0r10cmqT8EWv+bERCSTva/0bk5R0sYw2lD1F
	 iVfhEZiTbmrrswjWIU4r16PNCd2nQINWBqmcMmIJ1x/ldBtnlFgn0BN6XnI6dohHXpw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794047894;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=TIJWuwXSig47/Phj0+wuwVDI3h7uBWxOhj2JKnr69SQ=;
	b=LgYoGnGa3PZjlgxb71qmI3OQXlftmw+kFUFevmalY+Q2SSLy0YuyQTj7sfyo37zBurHd
	 ZnUmoZhAT+wxke8acasV88eqq2tQUPe6h/zZh0zgjMyaA6eFqYgvXHvwjhzvdpVBNWvAm
	 AIyix2xV1ElYU3HB8ySs4RTz2pQ5zeTE0vZqEOpSWn1sqdreHF/KaIKWAsXjrbiuexYJb
	 nFAUYYoNMruCeLHx6oO6zk8hbCF63AH3bNfwSLey76KvVXJli2YeuLCL1bQ1+kHAiaUh+
	 yJOC0UjBMlylHGkgDrrUJqNQ/R00Px6hWSTPqhUNOAUVbu385tRbRxuMHwSd87SMQRg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="J/jtDpGb";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E574F606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=J/jtDpGb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 347E51F0089F;
	Sat,  7 Nov 2026 10:38:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794047893;
	bh=TIJWuwXSig47/Phj0+wuwVDI3h7uBWxOhj2JKnr69SQ=;
	h=From:To:Cc:Subject:Date;
	b=J/jtDpGbOj6mLUChX6IqNa7pH7ibs2L7rtcl8LpQ6RKcKWIHTC2S+pL3WVjWJUgN0
	 yS9AUb0xkhS8EKvMX2Ji5bIc+nOIfnpkywV5ripR5TCxYgowdJCKHg78fIdZrFk9By
	 AiiiTwkQuqF99Ci8F7D1XpvYLEtw1rbybvEx8sgLMlovCV9zCxOxwWr/yQAbxU9Jbq
	 hbrhSFTlZrHmEr3N6sVZpr9fcZKSNGOTLfA02cW/0phPkDSV0y1EIDCQP0ajtSe34y
	 tanr/pule2qqgdm98h4tu0Q7Sw3tfmIU9xvhQWtoI/oksRdFYWJaBuvfJRVXOYAmiK
	 nYJ7n+L15ZoVg==
From: Sasha Levin <sashal@kernel.org>
To: nick@karaolidis.com,
	jack@suse.cz,
	chengzhihao1@huawei.com,
	brauner@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] fs: rotate inodes whose page cache could not be dropped" failed to apply to 6.6-stable tree
Date: Sat,  7 Nov 2026 05:38:12 -0500
Message-ID: <20261107053812-failed-6.6-8ee09f597763@kernel.org>
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

The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 8ee09f597763acfd31c62a578ba88b792fc41b24
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107053812-failed-6.6-8ee09f597763@kernel.org' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

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




