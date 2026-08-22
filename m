Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FDAF493650
	for <stable@vger.kernel.org>; Sat, 22 Aug 2026 12:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787400537; cv=none; b=g8Qx3zllMHjmdIPzhwRf0Ql7JGG1os4twIGxuF7jWLNZLeqRFV1j3VXpU5EOhTlbfbsAD6TtCkbBNowrWJsTYxnmHB4x0OqbjNnrwIADEtiCrIhvpcXFO92sK1uqgGvpboWLNQtLGltWjNm/V/YBG2AF2h0bRH3CxMhjoKMLC9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787400537; c=relaxed/simple;
	bh=OdsFwvwiTFXNPRiIhPQAyw/8IH2U+VoY9ckxqvwHgwo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=twr91ZPuD/s2/UYIjbUEIWe854GmJ+/ODOgpRCpOtw8OtjNJOgnHLqaQvEDbXm8UVej9R8nb8tCmMc6R1TxY9J+/ehBtmtDKiU6ZLkMhCG31gpL9CW+WVYrDoJ+VQF385j9qNtAuOfrbgJk85mbsY9B1idxvTWdDVLdAtJHFClY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A5i9grRq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A5i9grRq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 088AC1F000E9;
	Sat, 22 Aug 2026 12:08:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787400535;
	bh=4ixR8DbzALoiqvnMsZYL3DxxeMYh8Ypk8wuK3B9c/e4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=A5i9grRqxMo8jBrH0RqWFURvIdRSHflSot47wjSwMbJVhQjDxciyXIsYyz3zyRlOJ
	 zWSTb0TXwpunm0w/QcSWI4D0XEnxmGq6qNwB/AnoYD9jCgsBYChcX/QC0Wm6mSSRCM
	 7o6gaxiJiSX4a/LU7QZOOQQdFtvFqtXH28pT2RQ31Z9ceboDoFAXiu3zpuZ430z13T
	 pfDughmrtfISilswY3pKHS3PENrcWL2RTnoX0gx8WQbkmPyLl5Vs9VAFx+ZQV7kxO0
	 KUxjavqmNdc6nhlPvAO9yGzJOIfVlTi+97/1EINYEBcRKHk5xnyE4VvEf+bEWd4bHf
	 hMqnRT60k12Ow==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Zhiling Zou <zhilinz@nebusec.ai>,
	Vega <vega@nebusec.ai>,
	Ren Wei <enjou1224z@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] inet: frags: publish queues before arming timer
Date: Sat, 22 Aug 2026 08:08:53 -0400
Message-ID: <20260822120853.2100061-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026081751-nape-kissing-c981@gregkh>
References: <2026081751-nape-kissing-c981@gregkh>
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
 net/ipv4/inet_fragment.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/inet_fragment.c b/net/ipv4/inet_fragment.c
index 12ef3cb26676d..016b224a17e55 100644
--- a/net/ipv4/inet_fragment.c
+++ b/net/ipv4/inet_fragment.c
@@ -308,16 +308,18 @@ static struct inet_frag_queue *inet_frag_create(struct fqdir *fqdir,
 		*prev = ERR_PTR(-ENOMEM);
 		return NULL;
 	}
-	mod_timer(&q->timer, jiffies + fqdir->timeout);
 
+	spin_lock_bh(&q->lock);
 	*prev = rhashtable_lookup_get_insert_key(&fqdir->rhashtable, &q->key,
 						 &q->node, f->rhash_params);
 	if (*prev) {
 		q->flags |= INET_FRAG_COMPLETE;
-		inet_frag_kill(q);
+		spin_unlock_bh(&q->lock);
 		inet_frag_destroy(q);
 		return NULL;
 	}
+	mod_timer(&q->timer, jiffies + fqdir->timeout);
+	spin_unlock_bh(&q->lock);
 	return q;
 }
 
-- 
2.53.0

