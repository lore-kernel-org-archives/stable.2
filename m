Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C08F11A6830
	for <stable@vger.kernel.org>; Fri, 21 Aug 2026 16:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787331118; cv=none; b=orR8hHCitvU/vMWOTYhHvxAM9KD9E4h9jKm2bKfyFmEfp/SGClJgAmK2dsOi4sLdbqdS66FyLOPxodQd9bXbLXlObdzWZkjcS9P9llSlafXuFOsSzybGH3uTJjHO5WP+Uu2fFeGHZO4XPK1TCllLBETt95xN7nVjvGcKSrXPWwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787331118; c=relaxed/simple;
	bh=rzToU0iJRyMJ1tgxWH04OmJ6J0ukznhqhn2NWVh0guk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sD9K2pFVgk8n6r0+YGA+AgpWXXUNjAaY5kf1c8eMpYqFRd/QTxcWNE3cDzaW3X5VP16drNFYk66l4OHBfhwWGEfLOkvwvsebPwb0uj5N5MyxRf68J6q1vP4lSuNy5Oxr9/kgpo3KfZJOv33hEJmSCzyrr541iy4s1Im0OXPIKMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jbAHi7Fi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jbAHi7Fi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8F341F00AC4;
	Fri, 21 Aug 2026 16:51:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787331112;
	bh=8hfvwqis53PsemJr1hNt2MupoHC9oA06nukcLRM6PrA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jbAHi7Fieg3csmBif4YGhdCozffCLDDjOBhyifGyfpglXnEs8yLJ3PGyMH/oHSqOS
	 GMmkAkmNZ4HfZapJRDhIAjPB/mpFmYagX4c+ZCa6LiTL0H+MJJEKqEWuUoNFUFgbCa
	 Gbw510HLjO96dh+AfUJmV4yszgH7QTot+N0abDHsBHMmqU0NGxwTXl+wDopxCzu0qh
	 mI4uY9beuKkDT5SkgQB8NOawNQFu1o97cl1rANZJM98tNvstuaMKwFUit1ElYZSmbx
	 HEymR5Re5IdtXG9/LO7cYl2C3iobn6a7/HQpeaIDipA65va+vz0cTLXqCrPGpujUE2
	 aNEci4Y8/D+Nw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Zhiling Zou <zhilinz@nebusec.ai>,
	Vega <vega@nebusec.ai>,
	Ren Wei <enjou1224z@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 5/5] inet: frags: publish queues before arming timer
Date: Fri, 21 Aug 2026 12:51:47 -0400
Message-ID: <20260821165147.3593301-5-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260821165147.3593301-1-sashal@kernel.org>
References: <2026081750-scion-darkened-b02a@gregkh>
 <20260821165147.3593301-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zhiling Zou <zhilinz@nebusec.ai>

[ Upstream commit 653d7ddf6cba867777a3d14c4f83ace008c5ad13 ]

inet_frag_create() arms the fragment queue timer before inserting the
queue into the fqdir rhashtable. If the namespace fragment timeout is
zero or negative, the timer can run before the queue is published.

The timer callback then marks the queue complete, tries to remove a node
that is not in the hash table yet, and drops the anticipated hash
reference. Creation can subsequently publish the completed queue without
restoring that reference, leaving a stale hash node after the caller drops
the remaining reference.

Publish the queue first and arm the timer while holding the queue lock.
This makes timer expiry wait until the queue is visible in the hash table,
so inet_frag_kill() can remove the node and balance the hash reference.

Fixes: 648700f76b03 ("inet: frags: use rhashtables for reassembly units")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Signed-off-by: Zhiling Zou <zhilinz@nebusec.ai>
Signed-off-by: Ren Wei <enjou1224z@gmail.com>
Link: https://patch.msgid.link/bf66785e7c0c139d7a1900e2f01faeeab344b960.1784948849.git.zhilinz@nebusec.ai
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv4/inet_fragment.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/net/ipv4/inet_fragment.c b/net/ipv4/inet_fragment.c
index e5b03de2f6afc..1299413bc9804 100644
--- a/net/ipv4/inet_fragment.c
+++ b/net/ipv4/inet_fragment.c
@@ -393,8 +393,8 @@ static struct inet_frag_queue *inet_frag_create(struct fqdir *fqdir,
 		*prev = ERR_PTR(-ENOMEM);
 		return NULL;
 	}
-	mod_timer(&q->timer, jiffies + fqdir->timeout);
 
+	spin_lock_bh(&q->lock);
 	*prev = rhashtable_lookup_get_insert_key(&fqdir->rhashtable, &q->key,
 						 &q->node, f->rhash_params);
 	if (*prev) {
@@ -402,13 +402,13 @@ static struct inet_frag_queue *inet_frag_create(struct fqdir *fqdir,
 		 * we need to cancel what inet_frag_alloc()
 		 * anticipated.
 		 */
-		int refs = 1;
-
 		q->flags |= INET_FRAG_COMPLETE;
-		inet_frag_kill(q, &refs);
-		inet_frag_putn(q, refs);
+		spin_unlock_bh(&q->lock);
+		inet_frag_putn(q, 2);
 		return NULL;
 	}
+	mod_timer(&q->timer, jiffies + fqdir->timeout);
+	spin_unlock_bh(&q->lock);
 	return q;
 }
 
-- 
2.53.0

