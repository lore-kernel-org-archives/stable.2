Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793981082;
	b=p7yH+N4FlzWN8aa0Zcq403RNaWD/jCUFX6GlVxfDiFbDjiXuw6YNwA1OSRQed9H1L7Cl
	 pxSQpdLduhDHO5s09bVKPe8xe4CoZuvPYFdMGq9jsgNh912FHgtUeKm0k66BjqJyOQj0H
	 nlWTOu0zgWFExlMH3RAR+qZ/J8L07ebPKmLQbl5a0YiIjJYwTuXOVWBgDW0C3A46Xzxfy
	 nEz5e/cRpf0CwH/rHTmZv/VjMKhyoiPCrHIhrlTPAmfmkN0a1YTrodczhy0IS9t+D9Qnl
	 rYQrdNMuKBXZa1N80qDr6kp3x5t9PWApoCwG2xn8z6LAh4Lxt51oBZyFIILJGRrDv3Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793981082;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=IbAo/XVll2SGDEss8QZao+7wapwcfSzf7Q09tuS5w64=;
	b=NtucE0cuwnWTDtlbNLBKSq+OGJ3CFetKXLs/jK4H1tsDdZTaSKfUfgfC2QgT/eZUCIdw
	 bs01JKazLoGm6o5K10sGRdnPnHJoXzRoghEUf202g0g3y+FbGCYGcPkH4JnXMzgSvxH4J
	 M9KHAZohppQouy72WnvPl+3H9RKNRJ0r+BT4WHHIqSzetHOuohrgLyCbYjENT3Madpra6
	 vs8yzQ38RHRMueGgWzbV/PSXyG4a014YocO8n76KGRUnWn8RooquaPH0hG6BDc3/c1//E
	 hOLPwtkj+IE2qIb2PlIlMxNLEJYUIuM4czQcLVzlsCJz2RdwBw87rhCw/l4IDro+aWg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=toAU0PUL;
	arc=none smtp.remote-ip=209.85.128.179
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27371606A32C
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 16:04:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 27371606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=toAU0PUL
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-8b305d38bafso6698027b3.3
        for <stable@vger.kernel.org>; Fri, 06 Nov 2026 08:04:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793981081; x=1794585881; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IbAo/XVll2SGDEss8QZao+7wapwcfSzf7Q09tuS5w64=;
        b=toAU0PULMx4lp0K6cH2kYZw6ovTqDdgIJzh+GWMSgQ+Il0iqLfTky5m9VdTiMzQ8ya
         U0UdF4G8VU1K5Jh0ZslycxwOW9htwhzzdW0kg3TDzqM93UQYPworNojXBFe3CxjejcV/
         BpPx5ucpwVhL4f0NHCawPwD/mQ8RIBgwWot8RoloN6kgnj8j4w+Ysp/dkMu/W1keuiIx
         rAJsfm4xXhbjmXC9Bb/0xRfQG2+AZQcjNGl8WmrfVQhfHSCMA4oVIJy3Sw3eCB3iUT5j
         h9Ps+7wL4hJpa82Udn3PQJZLNksCf/vZw+QidI60lBnaN9AyFcBUvLxCam8COnRTJG2Y
         CcOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793981081; x=1794585881;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=IbAo/XVll2SGDEss8QZao+7wapwcfSzf7Q09tuS5w64=;
        b=SqJbLZv9M3Q17/RrenCOCWUC3/mDgJT7/vGHOhWd4AzM6tO6ddjEj+JX82/Y6+Hggy
         u26ijyatJzFAIEe6JhcHVtK34HjljDEVl+LUqgJV5RNpmASaZ8yQeTJ2X8tpvCft2IUB
         dBYryvKxZglJo5RXk3GTZX5vRGwQb6ElQL7gYWP1OwqEkFKM8pzy7mm6NqMa6KQBg8wg
         ETc8HsNoBShYbL6ofyU3P2sdBz3btL1TcYPFXY0QPPgmGfbSKFwQ7/8x4P5Rptp/TNl/
         LsvVGBgIOqP3rIloBT5t4C1ojTZKOuDs4whMzYOW7w86u6WfiLhzwX3a+4gJxdep1bSE
         ZKbA==
X-Gm-Message-State: APuU4Z9kgwbzBfo+mf+9nFzVNkSUB/McMF/npIaEo+Dc+qGuEenyzMQP
	7u49eJpHqDBtuHnmy4mscOPH3vukiPQFwrle3M1QbyqLPaxyIB7Hr5VAlZx2DNrp
X-Gm-Gg: AYBFou12eMtM1EjD5q4giJg+wXmzWjHhyd5E+6G/BMvOGxGOUgxoDYVvn2hIv1cPjHS
	2aIrDAEBLa25WW/ZJOUMOoEA4pCm3kSfBnYhYIiEjy1RyMtx1/lj4x35+2M/1aa/K8Qc46HeeBJ
	9u9Z4Zip5ke6vYpjlX2Jlb5V0lDQ1yHouLZcfAc3JpqbZJZknPTSlUy8LwRh4BO+HygedvfbhPf
	x1uzH77FsA50/4jQbgKeq826KYOnqimHe94PaRYHbSQAD8Fny8DLRIF+/n0Ivm/WDx61072e1Z/
	7Cc6/5A/xGPEAHiWAWwRJMYc8g5msGMJAw1n8+MdhsahWODwdlWKgnAHHMeu6VCQQMTdklI+86w
	eOc63rfp35YwGQLhpmf9aBR9mkoJS6jaqoRUg09yfjvdQn0Sa0KcInX9QQhnXa/y/tsK7Apz5Pr
	JY7mZs0IflQw++68XiUpsrk0tvaZrQfr1wpPDtUWaqG0++n+yL0a6tKdLVL4GP/hY3YMQLDLEcH
	7Z/9+CMdi1O98cqi+ylJ3XAxvvuicLt3zYgy7bAOvODtbOgChG/BwRAe/bzS4dT919lfiQtRIQm
	0bIVSH2VqGXU4X8lANgEzwKEyT/3xa6Fa+rOd6hcGZa1lP0F04CVHjcEmrT/QWPlIfkbjkAb3Go
	wcJ2Djde+xIe7dMwCn5VweHYPkAlMgQsc99HpsA==
X-Received: by 2002:a05:690c:9517:b0:8b3:3fc5:2be with SMTP id 00721157ae682-8b341947d76mr12228297b3.20.1793981080879;
        Fri, 06 Nov 2026 08:04:40 -0800 (PST)
Received: from localhost ([2a03:2880:10ff:4a::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b33f7fec67sm22059507b3.22.2026.11.06.08.04.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 08:04:39 -0800 (PST)
From: Nhat Pham <nphamcs@gmail.com>
To: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	axelrasmussen@google.com,
	baohua@kernel.org,
	baolin.wang@linux.alibaba.com,
	baoquan.he@linux.dev,
	brauner@kernel.org,
	chrisl@kernel.org,
	david@kernel.org,
	hannes@cmpxchg.org,
	kasong@tencent.com,
	ljs@kernel.org,
	mhocko@kernel.org,
	nphamcs@gmail.com,
	qi.zheng@linux.dev,
	shakeel.butt@linux.dev,
	shikemeng@huaweicloud.com,
	weixugc@google.com,
	willy@infradead.org,
	youngjun.park@lge.com,
	yuanchu@google.com
Cc: stable@vger.kernel.org,
	ryncsn@gmail.com
Subject: [PATCH 2/2] mm/swap: publish cluster tables after reacquiring allocator locks
Date: Fri,  6 Nov 2026 08:04:32 -0800
Message-ID: <20261106160432.2552507-3-nphamcs@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261106160432.2552507-1-nphamcs@gmail.com>
References: <20261106160432.2552507-1-nphamcs@gmail.com>
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

Under memory pressure, swap_cluster_populate() can publish a table
while its locks are dropped for a sleeping allocation. A cached
allocator can consume and free that table before the populating
allocator resumes, leaving the resumed scan with a NULL table.

    CPU0                           CPU1
    swap_cluster_populate()
      drop local/global/ci locks
      allocate and publish table
                                   swap_alloc_fast()
                                     consume the table
                                   charge failure cleanup
                                     free the table
      reacquire local/global/ci
      return ci
    alloc_swap_scan_cluster()
      read the missing table

Keep the count table, cgroup table and zero bitmap private until
swap_cluster_alloc_table() restores all allocator locks. Install them
under the cluster lock and retain it through the scan. Initial bad-slot
setup takes only the cluster lock because the device is unpublished.

A stale reclaimer can return the isolated cluster to allocation while
its locks are dropped. Abandon installation if the list state changes or
a table appears, freeing only private allocations. Restore locks on
allocation failure too, so the caller can return a still-isolated
cluster to its free list.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Link: https://lore.kernel.org/all/sashiko-outbox-181084@kernel.org/
Link: https://lore.kernel.org/all/sashiko-outbox-181086@kernel.org/
Co-developed-by: Kairui Song <ryncsn@gmail.com>
Fixes: cdd77f84d966 ("mm, swap: consolidate cluster allocation helpers")
Cc: stable@vger.kernel.org
Signed-off-by: Nhat Pham <nphamcs@gmail.com>
---
 mm/swapfile.c | 106 +++++++++++++++++++++++++++++++++++---------------
 1 file changed, 74 insertions(+), 32 deletions(-)

diff --git a/mm/swapfile.c b/mm/swapfile.c
index 189f04d8838f..162a73a9e663 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -449,15 +449,23 @@ static void swap_cluster_free_table(struct swap_cluster_info *ci)
 	swap_cluster_free_count_table(table);
 }
 
-static int swap_cluster_alloc_table(struct swap_cluster_info *ci, gfp_t gfp)
+/*
+ * Return with ci locked. An unlocked allocator also needs si's outer locks;
+ * initial bad-slot setup passes NULL because the device is not published.
+ */
+static int swap_cluster_alloc_table(struct swap_info_struct *si,
+				    struct swap_cluster_info *ci,
+				    gfp_t gfp, bool locked)
 {
 	struct swap_table *table = NULL;
+#ifdef CONFIG_MEMCG
+	struct swap_memcg_table *memcg_table = NULL;
+#endif
+#if !SWAP_TABLE_HAS_ZEROFLAG
+	unsigned long *zero_bitmap = NULL;
+#endif
 	struct folio *folio;
-
-	/* The cluster must be empty and not on any list during allocation. */
-	VM_WARN_ON_ONCE(ci->flags || !cluster_is_empty(ci));
-	if (rcu_access_pointer(ci->table))
-		return 0;
+	int ret = -ENOMEM;
 
 	if (SWP_TABLE_USE_PAGE) {
 		folio = folio_alloc(gfp | __GFP_ZERO, 0);
@@ -467,27 +475,49 @@ static int swap_cluster_alloc_table(struct swap_cluster_info *ci, gfp_t gfp)
 		table = kmem_cache_zalloc(swap_table_cachep, gfp);
 	}
 	if (!table)
-		return -ENOMEM;
+		goto lock;
 
 #ifdef CONFIG_MEMCG
 	if (!mem_cgroup_disabled()) {
-		VM_WARN_ON_ONCE(ci->memcg_table);
-		ci->memcg_table = kzalloc_obj(*ci->memcg_table, gfp);
-		if (!ci->memcg_table) {
-			swap_cluster_free_count_table(table);
-			return -ENOMEM;
-		}
+		memcg_table = kzalloc_obj(*ci->memcg_table, gfp);
+		if (!memcg_table)
+			goto lock;
 	}
 #endif
 
 #if !SWAP_TABLE_HAS_ZEROFLAG
-	VM_WARN_ON_ONCE(ci->zero_bitmap);
-	ci->zero_bitmap = bitmap_zalloc(SWAPFILE_CLUSTER, gfp);
-	if (!ci->zero_bitmap) {
-		swap_cluster_free_table(ci);
-		swap_cluster_free_count_table(table);
-		return -ENOMEM;
+	zero_bitmap = bitmap_zalloc(SWAPFILE_CLUSTER, gfp);
+	if (!zero_bitmap)
+		goto lock;
+#endif
+	ret = 0;
+
+lock:
+	if (!locked) {
+		if (si) {
+			local_lock(&percpu_swap_cluster.lock);
+			if (!(si->flags & SWP_SOLIDSTATE))
+				spin_lock(&si->global_cluster_lock);
+		}
+		spin_lock(&ci->lock);
 	}
+	lockdep_assert_held(&ci->lock);
+
+	/* A stale reclaimer may have returned the cluster to allocation. */
+	if (ci->flags != CLUSTER_FLAG_NONE || cluster_table_is_alloced(ci))
+		ret = -EAGAIN;
+	if (ret)
+		goto free;
+
+	/* The cluster must be empty and not on any list during allocation. */
+	VM_WARN_ON_ONCE(!cluster_is_empty(ci));
+#ifdef CONFIG_MEMCG
+	VM_WARN_ON_ONCE(ci->memcg_table);
+	ci->memcg_table = memcg_table;
+#endif
+#if !SWAP_TABLE_HAS_ZEROFLAG
+	VM_WARN_ON_ONCE(ci->zero_bitmap);
+	ci->zero_bitmap = zero_bitmap;
 #endif
 
 	/*
@@ -496,6 +526,17 @@ static int swap_cluster_alloc_table(struct swap_cluster_info *ci, gfp_t gfp)
 	 */
 	rcu_assign_pointer(ci->table, table);
 	return 0;
+
+free:
+#ifdef CONFIG_MEMCG
+	kfree(memcg_table);
+#endif
+#if !SWAP_TABLE_HAS_ZEROFLAG
+	bitmap_free(zero_bitmap);
+#endif
+	if (table)
+		swap_cluster_free_count_table(table);
+	return ret;
 }
 
 /*
@@ -546,8 +587,8 @@ swap_cluster_populate(struct swap_info_struct *si,
 		lockdep_assert_held(&si->global_cluster_lock);
 	lockdep_assert_held(&ci->lock);
 
-	if (!swap_cluster_alloc_table(ci, __GFP_HIGH | __GFP_NOMEMALLOC |
-					  __GFP_NOWARN))
+	if (!swap_cluster_alloc_table(si, ci, __GFP_HIGH | __GFP_NOMEMALLOC |
+					      __GFP_NOWARN, true))
 		return ci;
 
 	/*
@@ -560,8 +601,8 @@ swap_cluster_populate(struct swap_info_struct *si,
 		spin_unlock(&si->global_cluster_lock);
 	local_unlock(&percpu_swap_cluster.lock);
 
-	ret = swap_cluster_alloc_table(ci, __GFP_HIGH | __GFP_NOMEMALLOC |
-					   GFP_KERNEL);
+	ret = swap_cluster_alloc_table(si, ci, __GFP_HIGH | __GFP_NOMEMALLOC |
+					     GFP_KERNEL, false);
 
 	/*
 	 * Back to atomic context. We might have migrated to a new CPU with a
@@ -571,13 +612,9 @@ swap_cluster_populate(struct swap_info_struct *si,
 	 * could happen with ignoring the percpu cluster is fragmentation,
 	 * which is acceptable since this fallback and race is rare.
 	 */
-	local_lock(&percpu_swap_cluster.lock);
-	if (!(si->flags & SWP_SOLIDSTATE))
-		spin_lock(&si->global_cluster_lock);
-	spin_lock(&ci->lock);
-
 	if (ret) {
-		move_cluster(si, ci, &si->free_clusters, CLUSTER_FLAG_FREE);
+		if (ret != -EAGAIN)
+			move_cluster(si, ci, &si->free_clusters, CLUSTER_FLAG_FREE);
 		spin_unlock(&ci->lock);
 		return NULL;
 	}
@@ -825,9 +862,13 @@ static int swap_cluster_setup_bad_slot(struct swap_info_struct *si,
 
 	ci = cluster_info + idx;
 	/* Need to allocate swap table first for initial bad slot marking. */
-	if (!ci->count && swap_cluster_alloc_table(ci, GFP_KERNEL))
-		return -ENOMEM;
-	spin_lock(&ci->lock);
+	if (!ci->count) {
+		ret = swap_cluster_alloc_table(NULL, ci, GFP_KERNEL, false);
+		if (ret)
+			goto out;
+	} else {
+		spin_lock(&ci->lock);
+	}
 	/* Check for duplicated bad swap slots. */
 	if (__swap_table_xchg(ci, ci_off, SWP_TB_BAD) != SWP_TB_NULL) {
 		pr_warn("Duplicated bad slot offset %d\n", offset);
@@ -835,6 +876,7 @@ static int swap_cluster_setup_bad_slot(struct swap_info_struct *si,
 	} else {
 		ci->count++;
 	}
+out:
 	spin_unlock(&ci->lock);
 
 	WARN_ON(ci->count > SWAPFILE_CLUSTER);
