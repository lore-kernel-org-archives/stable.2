Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794366184;
	b=UX1nizjc7wT5miSBSPLQEmbalZulDoCWWPiJqd/uqCV3HL3GBKt2knnpBOREblaNRUT5
	 UFmfjk5RKhTPRFyXfmaqdl6iPhVorYH+aWwm09BmhFX73JTHPi5rxt+6XhFwne6RhNMGV
	 4+MbwlCxI4dpSJAyJGBu68OUIfaWcd1VGgBlKXthRJoVgMtp8/WqyRrUFSEizrhcHricw
	 /B7EoNlcuZEz+dShJLIknVK903QKXIBYms2nfpciqQgbK/+4U/gGSkerl8Eb7bbe3r8X7
	 Jl7GGM1AJnAyoHxkYMhPnPM2uq4CbXC2ohdAZkdr3zzFe0mfk/AYXQ8VvphJWs12KBw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794366184;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=L9pwqxM2u+le4BMTvedgYttm82bRWYCpRcHnYKJkZ7c=;
	b=nN8nRMNrBr5OO0dfHIU+1awyT0c4nwDR4/yHWgT0V6RehAXxz1x3wxRABOKb05qpVjaj
	 pkonYwFGWhB2R/4NCVT+nG6aJuEF2+k8rmBuMoTMR+YEz+sNqjNAIZQgbjXrwevGQkgEq
	 2CxE/LsamRBNoclq80Kw63AGkhuMouzLs5bIvPSXLsqTUkfJlFk5T/kAFACV/ezkdy+mS
	 /XizJjJzjTm1dsgxvWP4yu4jvX2VCsgdauUnfQ6g/4IBQsrx5p0sgyUvK/lbm3zfQwPlB
	 0QnY4E6qYVvmSlu+/FKdN5vt01Th44SUqpL/ghpSm1mv9K9+xXXR0FJ/3kt0O28kKZg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=f7ziPr9p;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EB50606A31C
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 03:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=f7ziPr9p
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7676A1F0089F;
	Wed, 11 Nov 2026 03:03:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794366184;
	bh=L9pwqxM2u+le4BMTvedgYttm82bRWYCpRcHnYKJkZ7c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=f7ziPr9p3dLQYJSJOK3LFNw4kGc8DM+CoH8BsUdW/3e3rI1uCvDif5GctvGUJHdQd
	 kVPw3ZcKQhsRio1OkuiLt4gWZs/foFTf/NKuiX1X6QtjlJFkW6l8AOPR0JLF0JY7ei
	 KkjRajMpoIprWon/ee9oSk+18BhU//e14U9X7YVRZ6Wytewy3olAXKgYsrT5245TfM
	 Ifqf4Z9gb2RoGKdtgO8SYsGUrWXZvOYLtFkap/mV3n2Iz6Vl5mabwkAekx1RK5+OJL
	 i2s6ybqFZ+HDCq42oTuj3i7OGJpclhjMyDqk0kQSAfaPpiyTOsJnNbDOJDkXqyVz0K
	 8J5dF2PFhZbKw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Nikolaos Karaolidis <nick@karaolidis.com>,
	Jan Kara <jack@suse.cz>,
	Zhihao Cheng <chengzhihao1@huawei.com>,
	"Christian Brauner (Amutable)" <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] fs: rotate inodes whose page cache could not be dropped
Date: Tue, 10 Nov 2026 22:03:02 -0500
Message-ID: <20261111030231.807230-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107053812-failed-6.6-8ee09f597763@kernel.org>
References: <20261107053812-failed-6.6-8ee09f597763@kernel.org>
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
[ sashal: Replaced inode_state_set(inode, I_REFERENCED) with direct inode->i_state |= I_REFERENCED. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/inode.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/fs/inode.c b/fs/inode.c
index 5ebe791381096..9d11428af1f3a 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -495,12 +495,11 @@ static void inode_pin_lru_isolating(struct inode *inode)
 
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
@@ -894,7 +893,13 @@ static enum lru_status inode_lru_isolate(struct list_head *item,
 				__count_vm_events(PGINODESTEAL, reap);
 			mm_account_reclaimed_pages(reap);
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

