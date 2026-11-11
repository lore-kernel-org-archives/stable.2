Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794373472;
	b=jt5ozqHYutAP1xA8JBp7qnPpk7X3ALIfDIaIR0GdxCQyfV1nhj1T7xgxJHcv2x2yH2aC
	 TzNfzZU16Ga13WxXBVp+rvtxNY9u27QumKC/+szTXtpfWPoUkoh/B0J6IWBDdgrrBpoz7
	 gCir/xXbeJrVLEr/D7lYQ9NIzAa71pc1uh1F7/wzayK7lD2G2KIseSp9hpnyekiQdNAl8
	 5xbbCIaRT4S6ZquvMqrCAMemoxd/eJXgflgUQ8UrszPh2rJE7eCMABojDV+tBsQp8jTY4
	 VOdpZoqTr6u0yD9MDXRe+pDiKxHsqV86f2oqzs4Ka1TJfzEQh7DTQZrB4RuKxkzyWFw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794373472;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=YFz9tisMFOrPzOv2dauRdBxyF/40BzvAbbRNhQvJTuM=;
	b=BE45Hk0pbUQQsQLNvHcYESiZgUQkd3LJhuphJ2/f964FqbC0jQ1Enog8+YbU0GaaY2Wx
	 gs/Qc7rd/0N4Vm6boyKPtEvPkIc81WF5AxeVflUvBM+74q4nWeIylI5+4b8Y4Rm4XrIow
	 UG84zwcvj+vP6+KeEDBUs+YjN89Gxo5Vmmu2a6qH6CZgUV2iqGVz4/NutHTCa54XaVhdl
	 KX5FuUPYkwIgZRWOS60UkJy99VmDMC11X7qr1xi2zzlyGDndsnSOHTzeQ3PwpYnkdoBWj
	 oHjCHs2eN6HmzR81/LAumL7vh+7Hb6IPHkNq0mZPfZAtorJC8SzuKboTAadmK7idAow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RLr2aakW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3504606A31C
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 05:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RLr2aakW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 048D81F0089F;
	Wed, 11 Nov 2026 05:04:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794373472;
	bh=YFz9tisMFOrPzOv2dauRdBxyF/40BzvAbbRNhQvJTuM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RLr2aakW3SdLRPmjiy1gLmPh+bHMui+bFEKqAR73CJSTjnL2VTZPKWJqHYiStXS6B
	 l2XyFwCg97EX85MqDM4byv0DJWAcwWfoakP6MFLWnBE0sBqwxEs5vSxCCAoeVeax8g
	 7yIxCkYMVb1ntf5Xfs6Kns5lXdoE3OX9OimVNlszJY+4WTPCEXjLUl47f7sHIFwTWk
	 xf06anGHmE2Ob5Ilxa091h6j9u5gO73fskYQsVjhkDTfPWmYu6arQzWtUWXr41nJrR
	 ub0Eje9y+H3bKG5se3aXODM+RF/ZpAUr9D38dern6WMPPuxypgSffy1iVra7mrZDKD
	 KulEUicJq2v3A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Nikolaos Karaolidis <nick@karaolidis.com>,
	Jan Kara <jack@suse.cz>,
	Zhihao Cheng <chengzhihao1@huawei.com>,
	"Christian Brauner (Amutable)" <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] fs: rotate inodes whose page cache could not be dropped
Date: Wed, 11 Nov 2026 00:04:30 -0500
Message-ID: <20261111050341.1063880-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107062743-failed-5.10-8ee09f597763@kernel.org>
References: <20261107062743-failed-5.10-8ee09f597763@kernel.org>
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
[ sashal: adapted inode APIs to use xa_empty() and direct i_state bit updates ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/inode.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/fs/inode.c b/fs/inode.c
index 40cc72fe37f99..9f246531ae9cb 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -462,12 +462,11 @@ static void inode_pin_lru_isolating(struct inode *inode)
 
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
@@ -821,7 +820,13 @@ static enum lru_status inode_lru_isolate(struct list_head *item,
 			if (current->reclaim_state)
 				current->reclaim_state->reclaimed_slab += reap;
 		}
+
+		spin_lock(&inode->i_lock);
+		/* The walk restarts here: don't retry leftovers right away */
+		if (!xa_empty(&inode->i_data.i_pages))
+			inode->i_state |= I_REFERENCED;
 		inode_unpin_lru_isolating(inode);
+		spin_unlock(&inode->i_lock);
 		spin_lock(lru_lock);
 		return LRU_RETRY;
 	}
-- 
2.53.0

