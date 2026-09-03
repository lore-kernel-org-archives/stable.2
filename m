Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4119239446D
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 18:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788460836; cv=none; b=WvjEfXLyaJ/pKT4kYUENWu+CUerElpQZncPgHTlBOJ9ttqEqOc/RFPcO5jibj2EtUWxD8FekoYH9LoMjuP/uQh6qKnvAARZb39oYKOWSGh2cdU0Nt9oc+bHOqS21ZAuRfa0hYITHxKgwGAM7vbJtXDoEjNO3ro1aHzHcmQE5mmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788460836; c=relaxed/simple;
	bh=vr/aGos6iIFoKpRQvYBL7Nqydc9pSSJqF3KZT0VkjWU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G9VvwZMy3k8xsFDOx9JZvNr1iU0v5ULd5K8SNzRrttRaBqbLnSS/UZmeGB8HoGj6HG8kgAjoITrZIqvS35U9Vjp+Ozgax+jwYoK2Ii6Xg+4lGfsf0TEzRYPPLM6c3Y5SjV7NsHVqVNqNBFGVG1e49qJnmGSyrRcG1HtgdTLM8aA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jw4LEcH8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jw4LEcH8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 933B41F000E9;
	Thu,  3 Sep 2026 18:40:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788460833;
	bh=LVgiJ4D09L3/+TI9PYc7Gr1zGRctez4NIabMk1BqZf4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jw4LEcH8Khu6mGCt/bG3deibQelyZJj1ibDtuz3bmJoUyY0b+NyaLZs8XQsfffcXs
	 +o8wAY4EM8QsMrnWJJF/VR/0V5jCrcYKMvqBJET0Uiacx3pC1kqTpQumc5HqWtOFpv
	 zCF5qUu20v3sI8HVs4zyrJCI7j7PTW2ClY/L8tHLJDFPhz+jjX2COwGjAGCXxumheK
	 8AvJ+L6/bV2NFErTHpjm80EQlSHw3AQC8M0R3enU2ZxOGiIiPyWgRlK7P9nPnnXD/+
	 d7b9nd4G8rYVWZ7YFWrntdb5cXqoZe3MrUXQRZyq9Auk13279HZo6Q4gTW7aTCLCKX
	 fVFHS3DzUJkuA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Kairui Song <kasong@tencent.com>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Barry Song <baohua@kernel.org>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Chen Ridong <chenridong@huaweicloud.com>,
	Chris Li <chrisl@kernel.org>,
	David Hildenbrand <david@kernel.org>,
	David Stevens <stevensd@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Kalesh Singh <kaleshsingh@google.com>,
	Leno Hou <lenohou@gmail.com>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Michal Hocko <mhocko@kernel.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Suren Baghdasaryan <surenb@google.com>,
	Vernon Yang <vernon2gm@gmail.com>,
	Wei Xu <weixugc@google.com>,
	Yafang <laoar.shao@gmail.com>,
	Yuanchu Xie <yuanchu@google.com>,
	Yu Zhao <yuzhao@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 3/4] mm/mglru: use the common routine for dirty/writeback reactivation
Date: Thu,  3 Sep 2026 14:40:26 -0400
Message-ID: <20260903184027.1474890-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260903184027.1474890-1-sashal@kernel.org>
References: <2026090303-freezable-flatness-e858@gregkh>
 <20260903184027.1474890-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kairui Song <kasong@tencent.com>

[ Upstream commit 75d4c3f5fb980de1b620adede47e43dff4d6a5f3 ]

Currently MGLRU will move the dirty writeback folios to the second oldest
gen instead of reactivate them like the classical LRU.  This might help to
reduce the LRU contention as it skipped the isolation.  But as a result we
will see these folios at the LRU tail more frequently leading to
inefficient reclaim.

Besides, the dirty / writeback check after isolation in shrink_folio_list
is more accurate and covers more cases.  So instead, just drop the special
handling for dirty writeback, use the common routine and re-activate it
like the classical LRU.

This should in theory improve the scan efficiency.  These folios will be
rotated back to LRU tail once writeback is done so there is no risk of
hotness inversion.  And now each reclaim loop will have a higher success
rate.  This also prepares for unifying the writeback and throttling
mechanism with classical LRU, we keep these folios far from tail so
detecting the tail batch will have a similar pattern with classical LRU.

The micro optimization that avoids LRU contention by skipping the
isolation is gone, which should be fine.  Compared to IO and writeback
cost, the isolation overhead is trivial.

And using the common routine also keeps the folio's referenced bits (tier
bits), which could improve metrics in the long term.  Also no more need to
clean reclaim bit as the common routine will make use of it.

Note the common routine updates a few throttling and writeback counters,
which are not used, and never have been for the MGLRU case.  We will start
making use of these in later commits.

Link: https://lore.kernel.org/20260428-mglru-reclaim-v7-10-02fabb92dc43@tencent.com
Signed-off-by: Kairui Song <kasong@tencent.com>
Reviewed-by: Axel Rasmussen <axelrasmussen@google.com>
Reviewed-by: Barry Song <baohua@kernel.org>
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: Chen Ridong <chenridong@huaweicloud.com>
Cc: Chris Li <chrisl@kernel.org>
Cc: David Hildenbrand <david@kernel.org>
Cc: David Stevens <stevensd@google.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Kalesh Singh <kaleshsingh@google.com>
Cc: Leno Hou <lenohou@gmail.com>
Cc: Lorenzo Stoakes <ljs@kernel.org>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Vernon Yang <vernon2gm@gmail.com>
Cc: Wei Xu <weixugc@google.com>
Cc: Yafang <laoar.shao@gmail.com>
Cc: Yuanchu Xie <yuanchu@google.com>
Cc: Yu Zhao <yuzhao@google.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Stable-dep-of: f7e698e326b2 ("mm/mglru: fix and remove redundant unevictable folio handling")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/vmscan.c | 21 ---------------------
 1 file changed, 21 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 7a112f93a681a..f38fe097a46be 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -4358,23 +4358,6 @@ static bool sort_folio(struct lruvec *lruvec, struct folio *folio, struct scan_c
 		return true;
 	}
 
-	bool dirty = folio_test_dirty(folio);
-	bool writeback = folio_test_writeback(folio);
-
-	if (type == LRU_GEN_FILE && dirty) {
-		sc->nr.file_taken += delta;
-		if (!writeback)
-			sc->nr.unqueued_dirty += delta;
-	}
-
-	/* waiting for writeback */
-	if (folio_test_locked(folio) || writeback ||
-	    (type == LRU_GEN_FILE && dirty)) {
-		gen = folio_inc_gen(lruvec, folio, true);
-		list_move(&folio->lru, &lrugen->folios[gen][type][zone]);
-		return true;
-	}
-
 	return false;
 }
 
@@ -4402,10 +4385,6 @@ static bool isolate_folio(struct lruvec *lruvec, struct folio *folio, struct sca
 	if (!folio_test_referenced(folio))
 		folio_clear_lru_refs(folio);
 
-	/* for shrink_folio_list() */
-	folio_clear_reclaim(folio);
-	folio_clear_referenced(folio);
-
 	success = lru_gen_del_folio(lruvec, folio, true);
 	VM_WARN_ON_ONCE_FOLIO(!success, folio);
 
-- 
2.53.0

