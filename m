Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97FFA52E043
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 20:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788553954; cv=none; b=Ea+3cNtY7PintZqonmIqU619Qyz9rl7dIl8qtqsywZ8phdOv6mZy7Ag43ueywWgqTLYkANzvzq+E5o9m+SG8qyk1bK636T+G8Rcw/2iLGmhvwHYlKQA/tjnUOXu3/Rf7kAA6q0zLDEVfk8YeMxA9PcaRt+t3+xyW3WctKz2qjAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788553954; c=relaxed/simple;
	bh=R44tGvbOlq8eqqrpRcSpxsRfZ7jAMIrm23Q2B6piQJU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hP4JRDwBN7Dd8nKGeRyIEFoqApctEBNW5z9NzTR7LlFhw6oLKGVKTEYQ2ZMzMhz2ySQ75zmG1Z2WsErxRDzysF7n73Tc5DcuT5JMZJ2rrcOBG4V/vD6nFkfFXkoz+jbIB97DwWnAE0xgt4OB3heDppwTyQU+fHsmyYUeqPVyhw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hVJ36tlU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hVJ36tlU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2297D1F00A3F;
	Fri,  4 Sep 2026 20:32:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788553942;
	bh=LfNTJoNMMcIogN3iRG5yDYmil2AdRXz+gZY5ONLivgg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hVJ36tlUP8V+sEaGBUVW0sGf623IhqIbIfPbZK6nlSEI1cPgR2wfLhnn7/6Ohw/TO
	 t9NtVSfYB316AD7bG5veryrycmGJXz64+cW6Os0+cbck7N1hkiR+5lvUQ6DI6ZpaG3
	 ojG3/laNDDDQ+50ZdQrA3VvNZiYRMHWPPcra6P9y7iICLXHD/uxUuJpaDBJ5ea1Kub
	 nopZWsZLzlIMujBr9AbsxB6ZB1U5vQo4I1svCPlGIf+PPX1GgSQxl6clz0KVW6O0BO
	 o1p0zcV8nEcEj+f2P55ek2WXR2sZ4e4+dj3wr8RO/AjCkg1e5J8oeO/YKGU2NPq9hw
	 gjNbvPBNg5law==
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
Subject: [PATCH 6.6.y 3/9] mm/zsmalloc: remove set_zspage_mapping()
Date: Fri,  4 Sep 2026 16:32:11 -0400
Message-ID: <20260904203217.1548415-3-sashal@kernel.org>
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

[ Upstream commit a6a8cdfdde43b6231dd1ed61b8a7a6ee55956376 ]

Patch series "mm/zsmalloc: some cleanup for get/set_zspage_mapping()".

The discussion[1] with Sergey shows there are some cleanup works to do
in get/set_zspage_mapping():

- the fullness returned from get_zspage_mapping() is not stable outside
  pool->lock, this usage pattern is confusing, but should be ok in this
  free_zspage path.

- we seldom use the class_idx returned from get_zspage_mapping(), only
  free_zspage path use to get its class.

- set_zspage_mapping() always set the zspage->class, but it's never
  changed after zspage allocated.

[1] https://lore.kernel.org/all/a6c22e30-cf10-4122-91bc-ceb9fb57a5d6@bytedance.com/

This patch (of 3):

We only need to update zspage->fullness when insert_zspage(), since
zspage->class is never changed after allocated.

Link: https://lkml.kernel.org/r/20240220-b4-zsmalloc-cleanup-v1-0-5c5ee4ccdd87@bytedance.com
Link: https://lkml.kernel.org/r/20240220-b4-zsmalloc-cleanup-v1-1-5c5ee4ccdd87@bytedance.com
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
 mm/zsmalloc.c | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index 2f37901ace99a..075e2a692acd9 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -487,14 +487,6 @@ static struct size_class *zspage_class(struct zs_pool *pool,
 	return pool->size_class[zspage->class];
 }
 
-static void set_zspage_mapping(struct zspage *zspage,
-			       unsigned int class_idx,
-			       int fullness)
-{
-	zspage->class = class_idx;
-	zspage->fullness = fullness;
-}
-
 /*
  * zsmalloc divides the pool into various size classes where each
  * class maintains a list of zspages where each zspage is divided
@@ -689,6 +681,7 @@ static void insert_zspage(struct size_class *class,
 {
 	class_stat_add(class, fullness, 1);
 	list_add(&zspage->list, &class->fullness_list[fullness]);
+	zspage->fullness = fullness;
 }
 
 /*
@@ -726,7 +719,6 @@ static int fix_fullness_group(struct size_class *class, struct zspage *zspage)
 
 	remove_zspage(class, zspage, currfg);
 	insert_zspage(class, zspage, newfg);
-	set_zspage_mapping(zspage, class_idx, newfg);
 out:
 	return newfg;
 }
@@ -1009,6 +1001,7 @@ static struct zspage *alloc_zspage(struct zs_pool *pool,
 	create_page_chain(class, zspage, pages);
 	init_zspage(class, zspage);
 	zspage->pool = pool;
+	zspage->class = class->index;
 
 	return zspage;
 }
@@ -1398,7 +1391,6 @@ unsigned long zs_malloc(struct zs_pool *pool, size_t size, gfp_t gfp)
 	obj = obj_malloc(pool, zspage, handle);
 	newfg = get_fullness_group(class, zspage);
 	insert_zspage(class, zspage, newfg);
-	set_zspage_mapping(zspage, class->index, newfg);
 	record_obj(handle, obj);
 	atomic_long_add(class->pages_per_zspage, &pool->pages_allocated);
 	class_stat_add(class, ZS_OBJS_ALLOCATED, class->objs_per_zspage);
@@ -1656,7 +1648,6 @@ static int putback_zspage(struct size_class *class, struct zspage *zspage)
 
 	fullness = get_fullness_group(class, zspage);
 	insert_zspage(class, zspage, fullness);
-	set_zspage_mapping(zspage, class->index, fullness);
 
 	return fullness;
 }
-- 
2.53.0

