Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D79941A38F9;
	Fri, 28 Aug 2026 01:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787881630; cv=none; b=X2SXvjx9KoHjjyN7GRDGKOvid1I94S22d5Cj6YAfYlHg/jh2pm2NWpfa7K3YawTUxLQXv3LTgXDg5BwrPH2LDBe8gMhy6czH4xGjwL3bIvdEGOnlhHyFFeLYgA3Y7FOiOyASaZyjrhs/fe6UR14A6/k7DQecieEgCmguCfUffxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787881630; c=relaxed/simple;
	bh=TozQB/WgBl+iwkTH+pZrlxy4C0091wVwGu2mbAbS2uI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DI/CoNtPiXYxJyGZMzXTbtdQ7T+u2J4J6Hw66A78785QsawG9lcdFJ4iBSv9tQgg9IBErWzz1tdfUvaFH5O3wyFdZEf3eV3WWCBrKENr6vXbmjWjeK/TqoH+XEnyGAGo8qvFr/bkgikOiywCMH8VsEHhZ7ErGS/tq6DSGCjg1MQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AlK0mVoT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AlK0mVoT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B8891F00A3F;
	Fri, 28 Aug 2026 01:47:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787881628;
	bh=F46JVlLMoxNXNINmE9LzA4Hlq6H2HwDbRZsnhixmMF8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AlK0mVoTY6sneItpiY2CtIJnhxTr/lvHMD13iW6tiNvxXPs+jwfVUykRN9ByK5wfc
	 x1jZs9BXUP1WYdd9JRQzSwrTLjtN9sF4j08XOiPmZV1qdecrzfpDztzLJEbWdeWlcI
	 9YqZE6P74LaE6M9o4dnLB5UhXfAQxd6wu5QCl62B1i8h/UP7mYAmCnzT0heXKDXzqF
	 redVhJNHObmk+V3Zo50atu/aJtEMnZ4d9C7PFHpeKWONUwl7749P7QrFbf8ERJMT0o
	 ObuDkq0todeVlkaKawJCxaeFrbgaLpprLKJ+Sqqs1V+ZwcgbwMQCtQVcK9Fwg8BAbz
	 v7ZevBSKHMFtw==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	stable@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Ravi Jonnalagadda <ravis.opensrc@gmail.com>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v1.2 3/4] mm/damon/core: copy nid for eligible_mem_bp damos quota goal commit
Date: Thu, 27 Aug 2026 18:46:57 -0700
Message-ID: <20260828014659.121058-4-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260828014659.121058-1-sj@kernel.org>
References: <20260828014659.121058-1-sj@kernel.org>
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
index f7e66898aeb84..ce649553d768d 100644
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
