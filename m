Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794374017;
	b=BXq4r5uTNvy8uiUerjFOxfcrLLVd5hfeHA3Ds6iKjVpSP2Lan2LbwwpmMhVlHBy0OVde
	 6O++EbZ6W13qO0quLXorbPq5rd35IzlSJAIRzKZV1l1Vgyp/uFLcZCs6OyTJkd+eMgVU0
	 qfeuy5pZKjd4Du6knD0lSOaIdGcPZkJoj8nDZqD88X26+wfFg883/K5sG5Eo/5efWVOmT
	 V5VWtkfjMY1hTMpTOr/dfyjJiNFKb3GElZf7QDF0fE0YxO119L4qjpFpKLQcGMMosUKWe
	 LTdDYBhps6POdfXTnNB3cpAkZClm/Kcru6qW6T1hULUr99/T40KFy5JyaZBaGdir5Uw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794374017;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Tz60rnu8/d6D1fxFfCqmL32GEeu30q+mDXSPRRzgMB4=;
	b=hezLCm5j/WnfHCaSKZ5HsxR1+3ogPT8KQ+i6SEtGszRTirZYKUzeqmQtSAAbNr+a4jhG
	 QueWpG48ZVmd8BHa0we0XE5M813B868SISGIbyKXzs1v0pLNsrlaD2DPVJYzhj/Bq/Cf9
	 eUwlDIlMbKS72F4BgunTI8SjlNcXLQVtBT0zNp72lZ/TLY+CfjduePHwE0T8QaX6+BYwv
	 QWiO0XnuTXT5Bs3i4aKqCxnW3vXYW3uAFd5entZ4EmuKAa1eZzt4LRbQz657i2TYF9fXn
	 KYG0XgPF8EaF22W5C1ZfZzH7Vq8GpocsbTRl2HV/nNocLCeJ6kyWEDQ2grEThUcxjPA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Bep+fOcg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5591A606A320
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 05:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Bep+fOcg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 361A61F0089F;
	Wed, 11 Nov 2026 05:13:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794374016;
	bh=Tz60rnu8/d6D1fxFfCqmL32GEeu30q+mDXSPRRzgMB4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Bep+fOcg2LGRcJIFxQWu4EWH3f3V29YTH68do4FiP9d54h9U0rLfWNMB8aVR7k5WW
	 3I3481bimK21TW1WDZHaN3Yl+y8js/7jowSpyHN6cbyznt9nfPlh0RIN/chfra5p86
	 DfgPCZKN0lr6cDNtiaqKJg/gy8uELRggMPEMA6ObLfx8+LQTqi37FhEDYBQwYn399H
	 +rLD0UKlDnVI6GtpWKWJzxwbYNuTq3VHIca4MlK8YuOBzKNXHAtfdoEMqUo+4N3w5l
	 qKFyvI6uLT5eEW2faRwC6NrJndxj4AIDqIFIZ8XsIW9EOHeSCywr+1HDAnzXacjyy1
	 cid8kENYVFcBA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Nikolaos Karaolidis <nick@karaolidis.com>,
	Zhihao Cheng <chengzhihao1@huawei.com>,
	Jan Kara <jack@suse.cz>,
	"Christian Brauner (Amutable)" <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] fs: don't lose inodes that another LRU walker is isolating
Date: Wed, 11 Nov 2026 00:13:34 -0500
Message-ID: <20261111051305.1231635-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107051343-failed-6.18-8dc4116041e2@kernel.org>
References: <20261107051343-failed-6.18-8dc4116041e2@kernel.org>
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
[ sashal: Replaced inode_state_read(inode) with direct inode->i_state access under the existing i_lock. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/inode.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/inode.c b/fs/inode.c
index 24762fd1f2f77..9c59a4b571822 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -927,6 +927,12 @@ static enum lru_status inode_lru_isolate(struct list_head *item,
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

