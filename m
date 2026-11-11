Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794365519;
	b=OZ/NQPBlLgbrQcrkF/Zvg+DOaSq/dHWj9L42ZAdkqB/ott+HyJ6b07JBCxLnavhlD4cK
	 qR02IPMmi78gJRM07h3J3aRv/bGy0ANHTg+nJa1OeYACY8AfjeLDUpPdbCgHhGGFPpzBh
	 3MqLo2yS40iKJOcEuA+oTK6+9JVZ9qsS6x39DAp27h1/JRbShbxSGdoDzoKb/kMmW9xtI
	 9kls729nGoJlHZnN9m1okYU/z9fxKBuxNmm9AMda0cmm2nWn+vWti6sFv1CbJMY/nnao2
	 4QmFGtbcizWiFsG/7xymuPSpbDVHVdeAfX8AlEEIkFpvrFNG/fFMtFXVb9NdUA8/OAw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794365519;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=g9lZLfqs5cpufeGYD1996tXxqSDFcYwmBKjIPUI0a4I=;
	b=iFQTJv3FqFWefMEO7OpQYsrwjWpYJqXBrJ67B1z75lrnR0qtr4Dul4C5og+gjx5c/ru1
	 291JEurUszhKsAs700+ME8gYpEvg7Nm5S38Le/DsQquepkRLdEBB4COMpJ5NlOveibl0A
	 tmXzkxasz7908gPTCjVczHCAO6+T4uZYGLF0qVc+zois+WrRDUXOj7/i8uf0XMRTGJZax
	 M0jsfyR8/pk0IiGCcT2TOw0KwDmpx7HNKcvC31kp/5iaVwdFzh8/uqWZzKXVgQAjcduPa
	 ptL1ePxUNEe0ay6CCV5ZEYP4TmXMNqs5H89oKZrob96xcUP8kTBpxphXq5aoQ2iKgHw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OBal+eGR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FF5D606A31C
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 02:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OBal+eGR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7170B1F0089F;
	Wed, 11 Nov 2026 02:51:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794365519;
	bh=g9lZLfqs5cpufeGYD1996tXxqSDFcYwmBKjIPUI0a4I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OBal+eGRy+vv4c00sxYw+63Ry8pl79lJYMaEhT2tZDcI+pt45w8DLfvE2tXdVcTUJ
	 S7XxRCRXdyzmSdNeATsjagn3h/QhA7AeE8QsK3aFiS7dJwNWdU+HKUT/Ip60n/h9GR
	 ZW71VgFxQV4MOyv1WmUteFiMXPSPwyEGzXkGimXA2yVgAEVftqBqdCZLCemRL74ph6
	 61JYIXFeLOPVnw5QFsNSFxQfq4yUIJmle7X9OWLQ11VNFZi1+MSvWFBDlhNv09Bbyr
	 IUmYwz56PU4M9djOZcBw9OHF991BoONImFozU+aCvXMFeMpwhBlUWAUT/UVnQdGJFK
	 bXf0tZJcR9VDQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Nikolaos Karaolidis <nick@karaolidis.com>,
	Jan Kara <jack@suse.cz>,
	Zhihao Cheng <chengzhihao1@huawei.com>,
	"Christian Brauner (Amutable)" <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] fs: rotate inodes whose page cache could not be dropped
Date: Tue, 10 Nov 2026 21:51:57 -0500
Message-ID: <20261111025120.769747-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107052516-failed-6.12-8ee09f597763@kernel.org>
References: <20261107052516-failed-6.12-8ee09f597763@kernel.org>
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
[ sashal: replaced inode_state_set(inode, I_REFERENCED) with inode->i_state |= I_REFERENCED ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/inode.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/fs/inode.c b/fs/inode.c
index 7942673f686fd..50f0a5d756bdc 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -502,12 +502,11 @@ static void inode_pin_lru_isolating(struct inode *inode)
 
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
@@ -930,7 +929,13 @@ static enum lru_status inode_lru_isolate(struct list_head *item,
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

