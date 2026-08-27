Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEAAA474268;
	Thu, 27 Aug 2026 13:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787838284; cv=none; b=UB7NVDyPAnqcxA0XHqLFTLKACp0vpRwGZauG9PyzIbgcfG1o4pnzTUEqv4NdAk3bMebaSSvbK1OgrLzg9Dfkwqpl0YkOkzYNBzy8f4cmBUqjxhYLJ4GQNazNLL0TtaEn6ek9IMt0WYCVWXCe0PNTtTjHjqSvSXIhnJXw0OyUNuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787838284; c=relaxed/simple;
	bh=kJ2Ud7PvtAmojA10yRw+4iw55lj069EP3qGprK7d94U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=am10CCCX1rujdSbhm4YLmHqh7AnmWc7gq0AHH4qNIpwqqsZ7B0GFWkDuDH7oCn1Mg65u2MW68Pj3lGITdab8T9v3lagj3QsW3rQIimKcDCuVpU9leSLmR71zOFOL6HsnPWAC2Ucf+qiz0NIWUNOlcfjLDgtD+CZ4LwjWUBIRcvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c2ZK4nv7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c2ZK4nv7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A3591F000E9;
	Thu, 27 Aug 2026 13:44:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787838277;
	bh=MNodYGFJor5NpRAwFjGvSAle8qKkp2eKVQXo5mh31SE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=c2ZK4nv7SvHz1jwrCjfNf5ADTUUHq0mPFWo2aZbBBW+4Dhu+dIMawjlNlqEftD2uQ
	 RsT8M3xY0rSCT7nNWhkucLnCmoedxp/We4n3ZzMOBUv2X2wymWeofbCEflds4A3Wre
	 EcaKVi1uGra13UlcTUhe3P736azkwdAVRYFG0waKkwhg7AY+Be/8O1+7EAwcUzAcSe
	 m2F7AX8vBQXq3WdJo4m45h79C2ChapBJWjFeHmvsGQOALoeHQ+VOevIz0wVYMYj4FO
	 n2nfLplU0q5l+5YE1InCjx4VjIk1+fbZvqI6X6qXJNF1I9c7c1hx/7uvW7771R2FVN
	 +JZY2zMmyDrlQ==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	stable@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Ravi Jonnalagadda <ravis.opensrc@gmail.com>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v1.1 2/3] mm/damon/core: copy nid for eligible_mem_bp damos quota goal commit
Date: Thu, 27 Aug 2026 06:44:27 -0700
Message-ID: <20260827134429.123023-3-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260827134429.123023-1-sj@kernel.org>
References: <20260827134429.123023-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

damos_commit_quota_goal_union() is not updating the ->nid union field
when the goal metric is DAMOS_QUITA_NODE_ELIGIBLE_MEM_BP.  Hence, if a
DAMOS quota goal of the type is online committed in a way that it will
reuse other quota goal's memory space, the new goal will work with a
garbage nid value.  As a result, the DAMOS scheme can show unexpected
aggressiveness.  Do the update.

The user impact is not catastrophic.  No leak or crash happens.  Doing
the quota goal online commit that can reproduce the issue is expected to
be not common.  This issue was not found by real users but the AI
review.  That said, the issue can reliably be reproduced.

This issue was discovered [1] by Sashiko.

[1] https://lore.kkernel.org/20260827045035.94611-1-sj@kernel.org

Fixes: 9138e27a3bc3 ("mm/damon: add node_eligible_mem_bp goal metric")
Cc: <stable@vger.kernel.org> # 7.2.x
Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index e5b6b1c6bb7b2..11b20a4a726f9 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -1136,6 +1136,9 @@ static void damos_commit_quota_goal_union(
 		dst->nid = src->nid;
 		dst->memcg_id = src->memcg_id;
 		break;
+	case DAMOS_QUOTA_NODE_ELIGIBLE_MEM_BP:
+		dst->nid = src->nid;
+		break;
 	default:
 		break;
 	}
-- 
2.47.3
