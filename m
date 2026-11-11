Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794365006;
	b=HoOdLUmBwvgtGpX7eDma6mywuNop2ia4b14iPr9jZ5ZzEvOYo4QjRiAffiEK+7QBWe+4
	 pLbKifU8yRGlxJ3AdJVa+lxRDP+70I9B7qJAWi4jJur0mZASKsp96S4clNEI/B9ZsD70a
	 YAvF7+GFX0W2vKwuNBddGn5L6Y+7exAdIoiAwCyW1BNGDhF3PWZkz+p7pyXfe6Re0ca2q
	 wd1J82WtwPMIor1R6lxkXM2RTRrUFBDQxJtRH8KbAinUxsyjfbgWLtMuRfe2Elj+GDINx
	 UzeL8xG2EfXvnwbsId9ch9izZS0ECbWDhtNCdf13lx3nCxK+gIC3L9t/iwxvdOQX99g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794365006;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=WXQr7MEGrHzqTn0ms0KLaoXjV90RIBFHgSummQMhxUs=;
	b=kO0b9RHG10e/edQHX7PTKhToDp4KE1UMGDPx8M1wLasuP4tIpvsNPn1+eHXv5l8DOV5e
	 oiULWOlg8LAM/44jnKlGlCn4/BkKiUKTQLOo2bigF6HNqSaMx4J4pVgUJE4aawIT0ez9K
	 3ClKs2jlhZeZSkgNo5aDJGjTuF1BPOCZqtd/xLsdYxaVRQd/ZkiDnp42Qpcs+gu/9XnSS
	 2K1IK2mHXMraUoYBk7Hwaif38OU+xnqbLqoHomuH1uaj2OEh9iiIODCMtPiHnGHOnn873
	 igqj8cMmH4PTaQ3B/dXr2REKe0vXqCJOHe51VaPBJicXx+hn2t7HTOgeTO3BWotHy8A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Va+M8M6+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67282606A32D
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 02:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Va+M8M6+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C69C31F00A00;
	Wed, 11 Nov 2026 02:43:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794365006;
	bh=WXQr7MEGrHzqTn0ms0KLaoXjV90RIBFHgSummQMhxUs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Va+M8M6+kHtLRxZlS0ribdt7LJ0KY0R1bv1cjPUJeAGC85VYXAiQvfChRn8yIGIb1
	 Epei96DaxaG5xxscg1hX/lG9HRg/vlgRaXlsKzziFw2rsZO62zKmrxVREy5gGMqCgw
	 2EL+6pCQgu3Gr9gIVksNsUi+Hfhqak9XHGbZhNRoURRRLAOsR1mYw4kcgyEo1mGFKs
	 srHRA3ptBTTLzapMtxf4pOG717MVnI5HxgJ52bb6euh5I/L/WobwXq/rYq3mACwWu9
	 bXysna4RIGqlj8kiixduSOtu5EMGTYZTwbaZt/BBJMCjoLutv6Hm7V1htIbvozlQuG
	 1C/IEBEtdqrQA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Mateusz Guzik <mjguzik@gmail.com>,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 3/6] fs: spell out fenced ->i_state accesses with explicit smp_wmb/smp_rmb
Date: Tue, 10 Nov 2026 21:43:20 -0500
Message-ID: <20261111024017.675599-3-sashal@kernel.org>
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

From: Mateusz Guzik <mjguzik@gmail.com>

[ Upstream commit cb5db358ab5769cbd3e8e864f14af321126cccdb ]

The incomming helpers don't ship with _release/_acquire variants, for
the time being anyway.

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
Signed-off-by: Christian Brauner <brauner@kernel.org>
Stable-dep-of: 8ee09f597763 ("fs: rotate inodes whose page cache could not be dropped")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/fs-writeback.c           | 5 +++--
 include/linux/backing-dev.h | 5 +++--
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index 85f21ecc59958..e479e310f92c6 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -476,10 +476,11 @@ static bool inode_do_switch_wbs(struct inode *inode,
 	switched = true;
 skip_switch:
 	/*
-	 * Paired with load_acquire in unlocked_inode_to_wb_begin() and
+	 * Paired with an acquire fence in unlocked_inode_to_wb_begin() and
 	 * ensures that the new wb is visible if they see !I_WB_SWITCH.
 	 */
-	smp_store_release(&inode->i_state, inode->i_state & ~I_WB_SWITCH);
+	smp_wmb();
+	inode->i_state &= ~I_WB_SWITCH;
 
 	xa_unlock_irq(&mapping->i_pages);
 	spin_unlock(&inode->i_lock);
diff --git a/include/linux/backing-dev.h b/include/linux/backing-dev.h
index 3e64f14739dd2..065cba5dc111b 100644
--- a/include/linux/backing-dev.h
+++ b/include/linux/backing-dev.h
@@ -277,10 +277,11 @@ unlocked_inode_to_wb_begin(struct inode *inode, struct wb_lock_cookie *cookie)
 	rcu_read_lock();
 
 	/*
-	 * Paired with store_release in inode_switch_wbs_work_fn() and
+	 * Paired with a release fence in inode_do_switch_wbs() and
 	 * ensures that we see the new wb if we see cleared I_WB_SWITCH.
 	 */
-	cookie->locked = smp_load_acquire(&inode->i_state) & I_WB_SWITCH;
+	cookie->locked = inode->i_state & I_WB_SWITCH;
+	smp_rmb();
 
 	if (unlikely(cookie->locked))
 		xa_lock_irqsave(&inode->i_mapping->i_pages, cookie->flags);
-- 
2.53.0

