Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 399DD517BC7
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 20:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788553951; cv=none; b=t8gvAg6PeJ6Cz1r9C958fL38YSgUbt3VoNyXFz0qXH8IivDfgrg/CJzSMRLGxAuIMmx+Fb7Q6nhR+el8YJ8J/p+l6Fe8fkv4LNCM53Jkb1K5VVuopExNyqHdita3k+Y8BcM2YlGCh7MsaBVBpf5Jc2C3nMCH8mTnqNK1H2Ou3OI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788553951; c=relaxed/simple;
	bh=gu/o07OEOgdXyVB/Y1UA7+0DANKl/dXyRR1VICdy420=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I4PKoRqmysDWnV4M+ziPZlFLWjvxLQgL0J7ZSzUKI30E9kPs/PtF5Xr1j0YJTdAZNhfbBTGWr8HQatTo4QNZyiSsPkrAcOEAB9cJ2uO1d6vRip/9LUu06TpxpHQfwHo7BXocQRyXxAsH2waYygIxfrJSaXTMSTFDlRcJQpuVMSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mgI1DrX0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mgI1DrX0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 987871F00ACA;
	Fri,  4 Sep 2026 20:32:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788553944;
	bh=UzB1j5WJifMVvCPS2NcPyfG24qWEdq/GK3nnf3hdxeQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mgI1DrX0NsKs9shbv+BUJgWGA64KeeWyO80D5fPaBqZBzW8aGLBPNjz7SzYcZ8UhJ
	 82hTiBmuMgh1sWVxrxG+IBYbqdDBbHZHxX5NX7Hpg1eNXUnX3/CSj11KGpdpWFkxYW
	 dT+RxaFgDsdUFP1RxUrvwOQdz8J9fOJYkBl+JaFdBLk9ooyiaW2t3x0FCn4+HwZDbr
	 le6idVmnvcpZGWS1K+JUkI76JsIWeoFKA9poJcuroTZQvGlPwYDOAb+QgWqoYKiTHq
	 5zKJEqlPi/Yy+xCCUdz5ThwN5ljWLLwmb9JDj5wEGUnphdUNhVcg9I5IM1UjS6Nlo9
	 B6fjClga/KJcQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chengming Zhou <zhouchengming@bytedance.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Minchan Kim <minchan@kernel.org>,
	Nhat Pham <nphamcs@gmail.com>,
	Yosry Ahmed <yosryahmed@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 5/9] mm/zsmalloc: remove get_zspage_mapping()
Date: Fri,  4 Sep 2026 16:32:13 -0400
Message-ID: <20260904203217.1548415-5-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260904203217.1548415-1-sashal@kernel.org>
References: <2026090349-deniable-copilot-d36a@gregkh>
 <20260904203217.1548415-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chengming Zhou <zhouchengming@bytedance.com>

[ Upstream commit ce335e0723470203ca3498d70de2eb97e6869a06 ]

Actually we seldom use the class_idx returned from get_zspage_mapping(),
only the zspage->fullness is useful, just use zspage->fullness to remove
this helper.

Note zspage->fullness is not stable outside pool->lock, remove redundant
"VM_BUG_ON(fullness != ZS_INUSE_RATIO_0)" in async_free_zspage() since we
already have the same VM_BUG_ON() in __free_zspage(), which is safe to
access zspage->fullness with pool->lock held.

Link: https://lkml.kernel.org/r/20240220-b4-zsmalloc-cleanup-v1-3-5c5ee4ccdd87@bytedance.com
Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Minchan Kim <minchan@kernel.org>
Cc: Nhat Pham <nphamcs@gmail.com>
Cc: Yosry Ahmed <yosryahmed@google.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Stable-dep-of: f7bf5cd5b5f2 ("zsmalloc: account for handle size in class lookup")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/zsmalloc.c | 28 ++++------------------------
 1 file changed, 4 insertions(+), 24 deletions(-)

diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index 0cf814a809ec1..187936f3ea794 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -471,16 +471,6 @@ static inline void set_freeobj(struct zspage *zspage, unsigned int obj)
 	zspage->freeobj = obj;
 }
 
-static void get_zspage_mapping(struct zspage *zspage,
-			       unsigned int *class_idx,
-			       int *fullness)
-{
-	BUG_ON(zspage->magic != ZSPAGE_MAGIC);
-
-	*fullness = zspage->fullness;
-	*class_idx = zspage->class;
-}
-
 static struct size_class *zspage_class(struct zs_pool *pool,
 				       struct zspage *zspage)
 {
@@ -709,12 +699,10 @@ static void remove_zspage(struct size_class *class, struct zspage *zspage)
  */
 static int fix_fullness_group(struct size_class *class, struct zspage *zspage)
 {
-	int class_idx;
-	int currfg, newfg;
+	int newfg;
 
-	get_zspage_mapping(zspage, &class_idx, &currfg);
 	newfg = get_fullness_group(class, zspage);
-	if (newfg == currfg)
+	if (newfg == zspage->fullness)
 		goto out;
 
 	remove_zspage(class, zspage);
@@ -836,15 +824,11 @@ static void __free_zspage(struct zs_pool *pool, struct size_class *class,
 				struct zspage *zspage)
 {
 	struct page *page, *next;
-	int fg;
-	unsigned int class_idx;
-
-	get_zspage_mapping(zspage, &class_idx, &fg);
 
 	assert_spin_locked(&pool->lock);
 
 	VM_BUG_ON(get_zspage_inuse(zspage));
-	VM_BUG_ON(fg != ZS_INUSE_RATIO_0);
+	VM_BUG_ON(zspage->fullness != ZS_INUSE_RATIO_0);
 
 	next = page = get_first_page(zspage);
 	do {
@@ -1857,8 +1841,6 @@ static void async_free_zspage(struct work_struct *work)
 {
 	int i;
 	struct size_class *class;
-	unsigned int class_idx;
-	int fullness;
 	struct zspage *zspage, *tmp;
 	LIST_HEAD(free_pages);
 	struct zs_pool *pool = container_of(work, struct zs_pool,
@@ -1879,10 +1861,8 @@ static void async_free_zspage(struct work_struct *work)
 		list_del(&zspage->list);
 		lock_zspage(zspage);
 
-		get_zspage_mapping(zspage, &class_idx, &fullness);
-		VM_BUG_ON(fullness != ZS_INUSE_RATIO_0);
-		class = pool->size_class[class_idx];
 		spin_lock(&pool->lock);
+		class = zspage_class(pool, zspage);
 		__free_zspage(pool, class, zspage);
 		spin_unlock(&pool->lock);
 	}
-- 
2.53.0

