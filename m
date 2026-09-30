Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FD812AEF5
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 00:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790726645; cv=none; b=c8hBfjlxdfGvA0sRlaS/Np2PJ5bgDibKSUpipE3KbTtswAw1hjadin+UBBIyN9GRjVgkX7Lp9qtmwgUeoxPGHu2AXyDC9SuMA8fRKxH4a9Mjm/b/IrQOiG0/Y1Y2VSLUl5jN3Yq5/ETNWEV9LlzVTUKdJMArpWa2iVa+FSvNUGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790726645; c=relaxed/simple;
	bh=Vk27DIFsJx4/rFwzXqzEx2Lr3EKfqLF/Pd+Wyxqpe/U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WblOEXoNd0IqFEZ/WALHaqWOL+oLbdjyRUwhD+u0hKzgweM165AGJVowwfiqXm2X3L5Q3lFpjftzEfkRYchO8+AEtdKFnqMOIuly6wxcD5xpBKIZzHeNivhOWVg7j+yy0jnDsym5oDpyQ2+cg0EID4s9wnbgAaKqFUQIlTM1EhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bCWKcEju; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bCWKcEju"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D30AF1F00898;
	Wed, 30 Sep 2026 00:04:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790726644;
	bh=O4GRYBNFh9XECJXBRUuzF6zT/WJlT+Xd0Hd00lnwsOE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bCWKcEjuIVrvQT1kZN9MmpGt8kbwooUpbsOnHBP3N2kxfISgeYpwx8UHHWdJki13e
	 KUhjKnO+zeu4GnlP1hBiw6vbTELjr7Eh3Couw4ryGhKUyz50UiZkVOu9nNjxQozBEO
	 YiFcTtJ9mJZxu2184b64dAGteCkapalQ34STpnSp4j4+e4v+c6f4FZYF/YWGb6Ru0i
	 NEAK9nmePBNswpoLP5iHA66DUVdgdS6nsCNY6yTX4sIwxrkXeaMNvGERmh5VJywvLv
	 q2Et4H4lw2raUekeFxKhbfNKjNBtuuPY7zOLA9QdvkN7LAq5PWGY9Y3I7lqzahOet7
	 7hnEOJWeFqyqg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Liew Rui Yan <aethernet65535@gmail.com>,
	SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/2] mm/damon/core: allow esz to be set to zero
Date: Tue, 29 Sep 2026 20:04:01 -0400
Message-ID: <20260930000401.2861657-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260930000401.2861657-1-sashal@kernel.org>
References: <2026092900-prize-superglue-6d70@gregkh>
 <20260930000401.2861657-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Liew Rui Yan <aethernet65535@gmail.com>

[ Upstream commit 90179da203ba8b708c84a12a07cd44be0f346334 ]

When the temporal quota goal tuner determines that the goal has been
achieved (score >= 10000), it sets esz_bp to zero so that the esz becomes
zero.  However, damos_set_effective_quota() clamps the esz to
min_region_sz when quota->ms is set.

This is a minor issue, the main problem is that it doesn't match the
description in the documentation, which state that if the goal has already
been [over-]achieved, the quota will be set to zero.

Fix this by set quota (esz) as minimum as possible.

Link: https://lore.kernel.org/20260908135413.97570-1-sj@kernel.org
Fixes: 8bbde987c2b8 ("mm/damon/core: disallow time-quota setting zero esz")
Signed-off-by: SJ Park <sj@kernel.org>
Signed-off-by: Liew Rui Yan <aethernet65535@gmail.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Reviewed-by: SJ Park <sj@kernel.org>
Cc: <stable@vger.kernel.org> # v7.1.x
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/damon/core.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index c74a0cc9ea413..5b86d3db627ad 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -1638,6 +1638,7 @@ static void damos_set_effective_quota(struct damon_ctx *ctx, struct damos *s)
 	struct damos_quota *quota = &s->quota;
 	unsigned long throughput;
 	unsigned long esz = ULONG_MAX;
+	unsigned long esz_time;
 
 	if (!quota->ms && list_empty(&quota->goals)) {
 		quota->esz = quota->sz;
@@ -1659,8 +1660,8 @@ static void damos_set_effective_quota(struct damon_ctx *ctx, struct damos *s)
 					1000000, quota->total_charged_ns);
 		else
 			throughput = PAGE_SIZE * 1024;
-		esz = min(throughput * quota->ms, esz);
-		esz = max(ctx->min_region_sz, esz);
+		esz_time = max(throughput * quota->ms, ctx->min_region_sz);
+		esz = min(esz_time, esz);
 	}
 
 	if (quota->sz && quota->sz < esz)
-- 
2.53.0

