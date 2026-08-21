Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97B6D435A86
	for <stable@vger.kernel.org>; Fri, 21 Aug 2026 14:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787323773; cv=none; b=plU37w76oBIuxE3IZxf7xK2RW8PVATz4J3gjCUsJOg9nlLynpaoAeOupk0LK7/eMkYvRCEeBdX/5ogkGJSHc5W5xmceRKqHut+hT0ZSYJhAhmCjfaNDJ1RV+pIxO7gIcPjZ8qlUBbT0kBc6cCjuM6y4GcFtYmvkGJyduAtBh+ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787323773; c=relaxed/simple;
	bh=LaoK5OEGPkOSEEcfzoMlGxZ7EWTDGGzll7JVV2hyF70=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dT07kFwnOPxdTOzG3Cbq2ScumrdQd0XtEo5k73PjyNvUbh3M4utkLClpX5a3OoRYHd9vg58iXcDI+aIIUIMZ8H6owlgf6vaoliyIqsTrfB0ocLsHJpas95+4EQTh6N7kWIj894eZ7f2hV2aUnyBmgsdfIjkMyVl372mj8Hb1EM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tvo+ixdk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tvo+ixdk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA8031F00A3F;
	Fri, 21 Aug 2026 14:49:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787323771;
	bh=3lzc6WatVGbl8HErMDooca8nNzQzUBBhSXedVzojiMY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Tvo+ixdk1vecxsy9XId79F+uIxcfulKoE4LsTvdQZ/9oHx5bAA5aIx7AzgVWOCtEw
	 /mXhyWt5yExtetrNJJe3ai6SSe6NXLTxDvFLZXMlU2K/Jvrz/87DktqBw3CG9xXJhH
	 YTG/Q+wvIx4DLlFjSWbJcjkhSuJ6EjGdohAFWqyNC7Fo87aIfbpY5Q0XaauGo4p33p
	 uBI5ebM47voL7BR88HdisGj2hCKovA135GgSfffbK7KtYNnE1aYbHLw2m4SnwwvM5R
	 NSBSQLipGxkfxVwKiJf7CnUJpMvHXXVjJdl3IjK9ZvzlKW/3EUrl5sNksX0/F+Von9
	 r80NkKFmTWkZA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Zhiling Zou <zhilinz@nebusec.ai>,
	Vega <vega@nebusec.ai>,
	Ren Wei <enjou1224z@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 5/5] inet: frags: publish queues before arming timer
Date: Fri, 21 Aug 2026 10:49:26 -0400
Message-ID: <20260821144926.3428433-5-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260821144926.3428433-1-sashal@kernel.org>
References: <2026081749-cash-armed-755d@gregkh>
 <20260821144926.3428433-1-sashal@kernel.org>
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
index 91e598e0a6dca..ea3f15f59c723 100644
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

