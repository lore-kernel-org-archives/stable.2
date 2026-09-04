Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 211E652BE3A
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 20:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788553952; cv=none; b=CrBsje+9qKK/kuSjAXedq67urVO+1e9BJ6WGWeyVb+HgCNHOi2VJfTRJpG+AbUnmYKYX2m/I8yW5VkbTUC7ukx2NpXTGU5IKSvcAxnEkeffa+J/zegzBuclt4FD5Uh/Eso7Bg5H5ARIVDXIcaT79obbcCb5To1fxhVKiqSyGMRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788553952; c=relaxed/simple;
	bh=e6C5PHrhWWPAH9KFR27GAM3CGR4RbCP87FBWf+zHwNE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A8A44IzCuKmjSaESZ8Lk8RCcx+zKh2oTb7OzRhkpZ1QaEXgJWY9JAkBpFGo8gj2V1foS+CW5oGQ7n7T6hQFas3wKZXC1+dAC3iIDpyJOINu7Wlry+Bovv4mC4VJdQy5sURFBfNbDRXMtlN8+8xYArfYI/lRHa/sfhiF+LjBpEv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AZqFlxGw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AZqFlxGw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F9B71F0155B;
	Fri,  4 Sep 2026 20:32:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788553939;
	bh=etbcglniAFusniSQtxRRdFKlQTlf5HDEydXQQVVXsNQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AZqFlxGwvsOqj67fBi1TB3/hBIkirXxypAEksh9PC37AVNjFpNpFeYBopDzd5qJ/v
	 uB5UBw4vzriAKnq2OKSZf+qKMSvoQxc07JY0dp0TPA76aBec0K9IqrAln73OnQl3DO
	 H1nO30kvdFI/mHVL7e6wGdztp8vwu2018qpTMqz3wlYxQxcaHHWatwJG3CIIC2jSxT
	 1FHbx/T8U2oxHlFZXecP0LFFcHLvsil9pbSziFh52DDqaBB9zAWEBlKlN3jF3yiesS
	 aEyGcoPKlntI8grIrqAHB8g0uPhwLDumeNUe6I7VgCMC9QIceKuV7xgptrPrMgFMRf
	 jysPW7Dft0t2g==
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
Subject: [PATCH 6.6.y 1/9] mm/zsmalloc: remove migrate_write_lock_nested()
Date: Fri,  4 Sep 2026 16:32:09 -0400
Message-ID: <20260904203217.1548415-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090349-deniable-copilot-d36a@gregkh>
References: <2026090349-deniable-copilot-d36a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chengming Zhou <zhouchengming@bytedance.com>

[ Upstream commit 59def443c9942545a9bc702d8a42babc615a8d97 ]

The migrate write lock is to protect the race between zspage migration and
zspage objects' map users.

We only need to lock out the map users of src zspage, not dst zspage,
which is safe to map by users concurrently, since we only need to do
obj_malloc() from dst zspage.

So we can remove the migrate_write_lock_nested() use case.

As we are here, cleanup the __zs_compact() by moving putback_zspage()
outside of migrate_write_unlock since we hold pool lock, no malloc or free
users can come in.

Link: https://lkml.kernel.org/r/20240219-b4-szmalloc-migrate-v1-2-34cd49c6545b@bytedance.com
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
 mm/zsmalloc.c | 22 +++++-----------------
 1 file changed, 5 insertions(+), 17 deletions(-)

diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index 14327fc34aa71..874d7d24d2d0f 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -279,7 +279,6 @@ static void migrate_read_unlock(struct zspage *zspage);
 
 #ifdef CONFIG_COMPACTION
 static void migrate_write_lock(struct zspage *zspage);
-static void migrate_write_lock_nested(struct zspage *zspage);
 static void migrate_write_unlock(struct zspage *zspage);
 static void kick_deferred_free(struct zs_pool *pool);
 static void init_deferred_free(struct zs_pool *pool);
@@ -1729,11 +1728,6 @@ static void migrate_write_lock(struct zspage *zspage)
 	write_lock(&zspage->lock);
 }
 
-static void migrate_write_lock_nested(struct zspage *zspage)
-{
-	write_lock_nested(&zspage->lock, SINGLE_DEPTH_NESTING);
-}
-
 static void migrate_write_unlock(struct zspage *zspage)
 {
 	write_unlock(&zspage->lock);
@@ -2004,19 +1998,17 @@ static unsigned long __zs_compact(struct zs_pool *pool,
 			dst_zspage = isolate_dst_zspage(class);
 			if (!dst_zspage)
 				break;
-			migrate_write_lock(dst_zspage);
 		}
 
 		src_zspage = isolate_src_zspage(class);
 		if (!src_zspage)
 			break;
 
-		migrate_write_lock_nested(src_zspage);
-
+		migrate_write_lock(src_zspage);
 		migrate_zspage(pool, src_zspage, dst_zspage);
-		fg = putback_zspage(class, src_zspage);
 		migrate_write_unlock(src_zspage);
 
+		fg = putback_zspage(class, src_zspage);
 		if (fg == ZS_INUSE_RATIO_0) {
 			free_zspage(pool, class, src_zspage);
 			pages_freed += class->pages_per_zspage;
@@ -2026,7 +2018,6 @@ static unsigned long __zs_compact(struct zs_pool *pool,
 		if (get_fullness_group(class, dst_zspage) == ZS_INUSE_RATIO_100
 		    || spin_is_contended(&pool->lock)) {
 			putback_zspage(class, dst_zspage);
-			migrate_write_unlock(dst_zspage);
 			dst_zspage = NULL;
 
 			spin_unlock(&pool->lock);
@@ -2035,15 +2026,12 @@ static unsigned long __zs_compact(struct zs_pool *pool,
 		}
 	}
 
-	if (src_zspage) {
+	if (src_zspage)
 		putback_zspage(class, src_zspage);
-		migrate_write_unlock(src_zspage);
-	}
 
-	if (dst_zspage) {
+	if (dst_zspage)
 		putback_zspage(class, dst_zspage);
-		migrate_write_unlock(dst_zspage);
-	}
+
 	spin_unlock(&pool->lock);
 
 	return pages_freed;
-- 
2.53.0

