Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44586485511;
	Mon, 31 Aug 2026 14:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788184986; cv=none; b=fyAk4p0bq8i4VC9pxD4TM+Hejd9N8bEo+Ao2csFI0s5okWDWgULJd8Eb54W9lTFG/4mB9ww4MccU7+ewfpMb6wiO3SmqbWz+YzRSJZVtqONg5PapE0yW59Ozgp2KI0RxjLwQHu0YatMHn395Eq4aGEPOvcIWXGaX0g7regOuGRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788184986; c=relaxed/simple;
	bh=axrgDohB9pRR8QC5Ey27g+zeND1mCd5WgD3HP/J4WSg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Heei2wg+1l3v8PBbxfdGEeFVsiKk7BRQPZowyUWJeQ5870n350Dkih0/McXDOMwscEsAkMNYcn+k9gSxEvArjg1sgViXwKvyD+bQ2aE5xdq5cRw/OMZNgs92v8wtDW1byezQiBeQ45+OmVYnxxqzaKAIdI4dyCRDN1ISFiphcBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oJxpLDdV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oJxpLDdV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA3581F000E9;
	Mon, 31 Aug 2026 14:03:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788184985;
	bh=wjxFgW2qNu2RQvNA0pBq7+cQKGiXodxnzF3g5CFurUE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=oJxpLDdVlPHJRD4OBQA0YEmwv5RdeoyTODGHJk9zi6EAtfAJONJ12tMhjaLQE1cQS
	 K0bCOwsuKK8My/5RD8Dac+hvm0QNFuUtBB4m122d1FgrK+mIhgUwZosoipv0Vb+FDk
	 d83/CCEP66tbJ5ezQ6GmckTsnB7MUtDz+QoTH+HJwKTBoI0SJjnQFAMf+uBGViCT10
	 TFjkYPQk8HRnfu2IMh8OxjHkCxn4BQSV8vhx2rvvdORWLOJP9dSfrF+KTHkEJhsxnG
	 2ZpC9BBom8O8JJhlIWu462KRFCinaOzmClyX0wS8idLOa9EwGr2T4TW5XeOPHQn5di
	 DtyQk2vgwPyjg==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	stable@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v1.2 7/8] mm/damon/core: handle extreme memory state in get_node_memcg_used_bp()
Date: Mon, 31 Aug 2026 07:02:46 -0700
Message-ID: <20260831140254.72004-8-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260831140254.72004-1-sj@kernel.org>
References: <20260831140254.72004-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In extreme unlikely situations, total memory might be zero.  In less
extreme but still very unlikely situations, lruvec_page_state() calls
might let the caller show used memory larger than total memory.  In the
two cases, damos_get_node_memcg_used_bp() could cause division by zero,
or return underflowed value, respectively.  Handle the cases by
respectively returning 100% and 0% for used and free memory queries in
the corner cases.

This issue was discovered [1] by Sashiko.

[1] https://lore.kernel.org/20260329154813.47382-1-sj@kernel.org

Fixes: b74a120bcf50 ("mm/damon/core: implement DAMOS_QUOTA_NODE_MEMCG_USED_BP")
Cc: <stable@vger.kernel.org> # 6.19.x
Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/core.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 75d71ac09515e..3779a04753061 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -2863,6 +2863,12 @@ static unsigned long damos_get_node_memcg_used_bp(
 	mem_cgroup_put(memcg);
 
 	si_meminfo_node(&i, goal->nid);
+	if (!i.totalram || i.totalram < used_pages) {
+		if (goal->metric == DAMOS_QUOTA_NODE_MEMCG_USED_BP)
+			return 10000;
+		else	/* DAMOS_QUOTA_NODE_MEMCG_FREE_BP */
+			return 0;
+	}
 	if (goal->metric == DAMOS_QUOTA_NODE_MEMCG_USED_BP)
 		numerator = used_pages;
 	else	/* DAMOS_QUOTA_NODE_MEMCG_FREE_BP */
-- 
2.47.3
