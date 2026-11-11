Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794370823;
	b=n/vLJlGCqhfQfJ4SKalsrjKQwOs8oHiJMLafgi8I421Ke1dpbzNwzmoaRsTC8QV801tA
	 59gCGRqdLdHqUzseI5xbpBohM8buBbblVGNj7UULit6YrAJjTzve4A+j/UjeYRFZQUwUa
	 hbylKKhleQl/bxzcc/L8FOGMF4Qxq7/lm3+yi7hZeGgUDhRjOg/PCiLR1bSjFinOuIu6j
	 05oWF/dvJDIPhtjrfCHpJ1zNMX63GcGMrMszSc9n3XjKV7Fy/sdzYQW3NnZvYiG+tDi3k
	 g6BZf7ewsOSVNX5Yksd0lvcYHbNKa8+Q+g4SfBH9r6qYa8CmQNVuKSkLtboAR2B5IPw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794370823;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=y46kTuhFS3pdFZXMnTpIZWohn+16FYvelrkuLSGYIho=;
	b=hd217ZtK6SG72tCNH7pShjTHZfFTYP+9a6jWXDu66uQHqDNwwFMXDN+Ou+k4sAskB3Gw
	 mSBj2xmqZx17DY7Fe7GdFjyaNUr94+OCLO0hkeZhjZ9UwDogGvZDfLDOIUgF02hQkEWvN
	 ESR4CQ/liQ/z8GZfAE//fXfRMZ/VuZhFJZcte6X7+9d7+IuKSMSjX20l3CGLPyD/6UJky
	 Zeb5tYvA5AuHr3hC2DY6oc/i529K4diIxXQlbtP8Fc1I4Vpr1zAEW60jP5SJA7R3akqeu
	 DA5L/kRLFpCXgx2HEaAUOLTw6QpeVsMc2pM+lM3Bcqe+1WZrod/Xx3UMT33IjlTgmEg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QbrRDWwk;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E67A606A330
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 04:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QbrRDWwk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A59761F00A03;
	Wed, 11 Nov 2026 04:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794370823;
	bh=y46kTuhFS3pdFZXMnTpIZWohn+16FYvelrkuLSGYIho=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QbrRDWwk1XCFGt9gpJdAuHDAOwCUWQPWL05q+PWUPjzh4TvtnN+E9ly8nBezhOlc6
	 6PSZJL/dReihkE1/ymQWCjChoGOZp08T8JfEwnobKKw77XKzzn+1KgLkTvLlfbjoWd
	 0FOGwU/Ktt94E5MIcgPtRWlCTH1dd172SlIuidqPJoDYH4bJ80AkLm7+u6UPlAfmsV
	 ttWe1TmiyNqMn+hW5aV1VmFWqacaVhYsy7x+fqy2C5uaJexhPN8SSnaVvOjXxDnQbT
	 pvEO4GVzJ1CLFI1fX5ektEmdYexLKTdQYSdM0ZLWLIh/KJ5zYSfUOSbq+zPK7xq6ya
	 N0Rbxg70ZniuQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Baoquan He <baoquan.he@linux.dev>,
	Barry Song <baohua@kernel.org>,
	David Hildenbrand <david@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Kairui Song <kasong@tencent.com>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Michal Hocko <mhocko@kernel.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Wei Xu <weixugc@google.com>,
	Yuanchu Xie <yuanchu@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.3.y 2/2] mm/vmscan: avoid false-positive -Wuninitialized warning, again
Date: Tue, 10 Nov 2026 23:20:17 -0500
Message-ID: <20261111041806.1021595-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261111041806.1021595-1-sashal@kernel.org>
References: <20261107050419-failed-7.3-ca6e32f3f424@kernel.org>
 <20261111041806.1021595-1-sashal@kernel.org>
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

From: Arnd Bergmann <arnd@arndb.de>

[ Upstream commit ca6e32f3f4240d0335775a11afc21e0451dd8d8f ]

I previously worked around a false-postive gcc-16 warning in the
get_tier_idx() function, by adding a fake initializer. This happens with
the -fsanitize=bounds sanitizer when the compiler creates a specialized
variant of isolate_folios():

In function 'get_tier_idx',
    inlined from 'isolate_folios.constprop' at mm/vmscan.c:4982:9:
mm/vmscan.c:4934:9: error: 'sp.refaulted' is used uninitialized [-Werror=uninitialized]
 4934 |         read_ctrl_pos(lruvec, type, LRU_TIER_MIN, LRU_TIER_MIN, 2, &sp);
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
mm/vmscan.c: In function 'isolate_folios.constprop':
mm/vmscan.c:4946:25: note: 'sp.refaulted' was declared here
 4946 |         struct ctrl_pos sp, pv = {};
      |                         ^~

Adding another "= {}" would solve the problem as well, but to prevent
this from happening again after the next code refactoring, try instead to
prevent this by forbidding interprocedural optimizations on this function.

Link: https://lore.kernel.org/all/20260213123902.3466040-1-arnd@kernel.org/
Link: https://lore.kernel.org/20260916083456.4136132-1-arnd@kernel.org
Fixes: 3de705a43a46 ("mm/vmscan: avoid false-positive -Wuninitialized warning")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Cc: Axel Rasmussen <axelrasmussen@google.com>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: Baoquan He <baoquan.he@linux.dev>
Cc: Barry Song <baohua@kernel.org>
Cc: David Hildenbrand <david@kernel.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Kairui Song <kasong@tencent.com>
Cc: Lorenzo Stoakes <ljs@kernel.org>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Wei Xu <weixugc@google.com>
Cc: Yuanchu Xie <yuanchu@google.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/vmscan.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 8ec8fdede5dd8..88fd31d135853 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -3194,8 +3194,11 @@ struct ctrl_pos {
 	int gain;
 };
 
-static void read_ctrl_pos(struct lruvec *lruvec, int type, int tier_min,
-			  int tier_max, int gain, struct ctrl_pos *pos)
+/*
+ * __noipa works around gcc-16 warning for uninitialized use of pos->refaulted
+ */
+static void __noipa read_ctrl_pos(struct lruvec *lruvec, int type, int tier_min,
+				  int tier_max, int gain, struct ctrl_pos *pos)
 {
 	int i;
 	struct lru_gen_folio *lrugen = &lruvec->lrugen;
@@ -4801,7 +4804,7 @@ static int scan_folios(unsigned long nr_to_scan, struct lruvec *lruvec,
 static int get_tier_idx(struct lruvec *lruvec, int type)
 {
 	int tier;
-	struct ctrl_pos sp, pv = {};
+	struct ctrl_pos sp, pv;
 
 	/*
 	 * To leave a margin for fluctuations, use a larger gain factor (2:3).
@@ -4820,7 +4823,7 @@ static int get_tier_idx(struct lruvec *lruvec, int type)
 
 static int get_type_to_scan(struct lruvec *lruvec, int swappiness)
 {
-	struct ctrl_pos sp, pv = {};
+	struct ctrl_pos sp, pv;
 
 	if (swappiness <= MIN_SWAPPINESS + 1)
 		return LRU_GEN_FILE;
-- 
2.53.0

