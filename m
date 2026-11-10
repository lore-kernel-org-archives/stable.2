Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794323655;
	b=2wy84jO+lL9QwHCa2WVpRNF1p02ixFyaixV/okzqRyglFP4QJV3VvRC2BAg3aBfVGkvM
	 2EJJwyIo0sEp8wgKk0N0uaupznqV+K78lqEmqtVtOs1/DtPToNHCWmu4tWqs1Rw5v2FA6
	 kVqnjxgVDueoK+LDnxpObhu45HIl96TlSVEbohYE6MXl2Up94nQdsvntB7hqGpsQNCmYB
	 Yh7HJq8YVn2k76okXiRY0o4Da0fQ+B1RaFox7gXcV+JLaIkw5jTpNGB7/Fc0JQ3jYu/d+
	 xuxwanRmn7iBJAL/QpcamrEg/6ae9+uzTIhaonnC7I/A65JyBK9b/NcRL37sPqDbs+A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794323655;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=13KTkyVNEIQ5V42TdPpP7NWq5YI0e8VPsfUukosD8Ao=;
	b=EhQhWVk4iG257aIlSfMN0iTrukIm59fBce2PZZFtQ4s9KFVawBQ59jEONKInXjQs37u4
	 Uwxd4cAAJFvBIGnOLXqzPO2/PxRJ+6ApO8C/hmLcRkWHPdhJEq2zjice/6d5PBD0D35fp
	 6Is4AUm9jHa+pNi/Ju6K9tE8O8bFrvLOBH03W1QuwQ6LUnosANIQhPVOh7+iH43JZJT3r
	 KtJcZTjBSitmyzw4JrT8qUD9FSsmxrSK8QyyPQfl8aaJolTKQGCd7LJei26Vf+Qfoawqv
	 18O3pWtxBzXo/v/sygdvAjrNd4Nq3LQlVB70C/IaXntD2lpLGzh9pe2GezVXL6/amog==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hGTvXrTj;
	arc=none smtp.remote-ip=209.85.128.176
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4F91606A335
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 15:14:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E4F91606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hGTvXrTj
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-8b30cbfa628so26454977b3.0
        for <stable@vger.kernel.org>; Tue, 10 Nov 2026 07:14:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794323654; x=1794928454; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=13KTkyVNEIQ5V42TdPpP7NWq5YI0e8VPsfUukosD8Ao=;
        b=hGTvXrTjFhX6eV8pLCmY4VnfwBvbPt6QknS11AAlIZ2xq49OekbdJXhamiE2n40YdD
         SzBQSIiM8PH2AYe8Yfb4blBJ/vGn/OxSCpwbev8p4uPWB3FXQg8Rl5S+dtTEfUrAcV/A
         3yDEd1DBngdBqItft0CLtpO5ej1Eq8uz2MVJpHnbehOqw7NZMIqa7CxDEiVYQF6i4O3+
         U2FTc6vspxVFnftkZBPxlOmDfoIvn5Tt0k4d24j8pDQpymjx3MyWSqi9NPnZR7CT9QbV
         ej2hMunOUKrKXEvTPmdz1+ePqUl+jBpjvMyqLrV0DndukIUHLMvWoMpn5FBcDhB6yzZH
         K+Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794323654; x=1794928454;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=13KTkyVNEIQ5V42TdPpP7NWq5YI0e8VPsfUukosD8Ao=;
        b=zXpR17Y9Jrg0oHZemV1wIRYI0u1HxHhyk3GZnkIouMBw1f/vk8CMXxf+0T2mNw0nLp
         7MZVTn4oKOHSm3DOfqr0jEz7bQo4D7goyWcPJCwU4tbH//neTTMualb/3ZFI/FXdaHQp
         cQ0fFe2zfMgbSR1P1BEoRoseMms84oknsL8nfg9+sLXA3KAMgVuUJuZh4BgPNPTWDKX/
         Ws+Y565iZrQCfdRfudFhL7UTHEQO0Shk1ak5B2biJ5KeMMBQP2y5/GwLHWrL4HVKKLTo
         EUuakH50u3iywHPHgSx4ytd370L2DfdQBPpsC0zL1HUIN+aJMFWXLi3TsdYDhUZIPCBU
         w55Q==
X-Forwarded-Encrypted: i=1; AL+hErEJEUZXjxMhR3MiACAwZmlprrZMa4dzoc0pCLfLMWy1RkNAACoRa7os9xBslBOJ+6GtMDGTMSE=@vger.kernel.org
X-Gm-Message-State: APuU4Z+sYMzDjozzPdK7Zu23Iam7j9olkddsTBfwUr/mv7m/kYofSf4q
	ZD7isCSvcUdBx1+1bMDLMw12FFdnt/7zVBgxQ4LbQoXx98xfP+IaO3HI
X-Gm-Gg: AYBFou0oyznKt48VbMfYaWwRAcCtnVtrvIZS1qSh2/eSE9HaW3fmsQ38/tLm7Bo5iv1
	8vfbfP1BxlDItwYi39n0Vp1ZrYoV4VuvkpdL+jrwSyPbgTC+1mWaBhK06ou10r+D/STHz+bEPNk
	eNWcuKixl5Sz5fyXA85rYTFdcgxDPwZ9O1ZWCbK5klbBN09+sI5d5XesNJ00SnpFom2vxalylF4
	Rwqyd2bcP6CT8fSyvfR4Aa9qXFsJRP2qBvQkrQ+3pXGZbmOPwCC/pUUNbANDmhWpCOCSP4MGpqs
	i/if6i5NQKaiEust4lpGAwnkwPhM3uOJldInsmB0K3X7bVN4xLkh8EjVj7FH9lJFi404//zR+Mx
	VQcQ4noFJLI+2scBYoqfJsGbTuLs06Ojq2ntYQdSkINZLmkQEBZZpkhr3oxXjpCxHqck1Tjcd/4
	5yZWsbaXxa37Oow1opwwjRKy8tCGZiYNKzqY+KtdtZ5RyMynGTTkbtZ9sRT9gJEyDE+2NugjTA/
	XDG76/d7Q1irFEgUrGMmwdrW3q4jc53pNsuF6hCl+9TzphxSnUDqzms9W+nj095dNydK4VyHaDQ
	dMFnRsGMPYXt8x54XMs44e6M6n1GtFEqICei0X4XcshNH4L1pNtCgja3tiYUPtkG19L+QfqF/J2
	f61ZV+vHQEWpRXeNRtFiAUfBeIo3ynqa1RLmgfQ==
X-Received: by 2002:a05:690c:399:b0:8b0:dd35:7b9b with SMTP id 00721157ae682-8b392b8dd13mr18540417b3.67.1794323653650;
        Tue, 10 Nov 2026 07:14:13 -0800 (PST)
Received: from localhost ([2a03:2880:10ff:45::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b3934542bdsm21415477b3.38.2026.11.10.07.14.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 07:14:12 -0800 (PST)
From: Nhat Pham <nphamcs@gmail.com>
To: linux-mm@kvack.org
Cc: akpm@linux-foundation.org,
	hannes@cmpxchg.org,
	david@kernel.org,
	mhocko@kernel.org,
	qi.zheng@linux.dev,
	shakeel.butt@linux.dev,
	ljs@kernel.org,
	kasong@tencent.com,
	baohua@kernel.org,
	axelrasmussen@google.com,
	yuanchu@google.com,
	weixugc@google.com,
	baoquan.he@linux.dev,
	baolin.wang@linux.alibaba.com,
	willy@infradead.org,
	brauner@kernel.org,
	linux-kernel@vger.kernel.org,
	chrisl@kernel.org,
	shikemeng@huaweicloud.com,
	nphamcs@gmail.com,
	youngjun.park@lge.com,
	ryncsn@gmail.com,
	sashiko-bot@kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2 2/3] mm/swap: publish cluster tables after reacquiring allocator locks
Date: Tue, 10 Nov 2026 07:14:06 -0800
Message-ID: <20261110151407.789960-3-nphamcs@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110151407.789960-1-nphamcs@gmail.com>
References: <20261110151407.789960-1-nphamcs@gmail.com>
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
    alloc_swap_scan_list()
      isolate_lock_cluster()
        swap_cluster_populate()
          drop local/global/ci locks
          swap_cluster_alloc_table()
            rcu_assign_pointer(ci->table, table)
                                   folio_alloc_swap()
                                     swap_alloc_fast()
                                       alloc_swap_scan_cluster()
                                         __swap_cluster_alloc_entries()
                                     mem_cgroup_try_charge_swap()
                                       return -ENOMEM
                                     swap_cache_del_folio()
                                       __swap_cache_del_folio()
                                         __swap_cache_do_del_folio()
                                           __swap_cluster_free_entries()
                                             free_cluster()
                                               __free_cluster()
                                                 swap_cluster_free_table()
          reacquire local/global/ci locks
          return ci
      alloc_swap_scan_cluster()
        cluster_scan_range()
          __swap_table_get()  /* NULL table */

Keep the count table, cgroup table and zero bitmap private until
swap_cluster_alloc_table() restores all allocator locks. Install them
under the cluster lock and retain it through the scan. Initial bad-slot
setup takes only the cluster lock because the device is unpublished.

The allocator releases its locks before the sleeping allocation. A
reclaimer that dropped ci->lock earlier can then resume and put the
cluster back on the free list. Abandon installation if the list state
changes or a table appears, freeing only private allocations. Restore
locks on allocation failure too, so the caller can return a still-isolated
cluster to its free list.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Link: https://lore.kernel.org/all/sashiko-outbox-181084@kernel.org/
Link: https://lore.kernel.org/all/sashiko-outbox-181086@kernel.org/
Suggested-by: Kairui Song <ryncsn@gmail.com>
Fixes: cdd77f84d966 ("mm, swap: consolidate cluster allocation helpers")
Cc: stable@vger.kernel.org
Signed-off-by: Nhat Pham <nphamcs@gmail.com>
---
 mm/swapfile.c | 106 +++++++++++++++++++++++++++++++++++---------------
 1 file changed, 74 insertions(+), 32 deletions(-)

diff --git a/mm/swapfile.c b/mm/swapfile.c
index 038d2efe26ad..32639f65f13c 100644
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
+	/* A stale reclaimer may have returned the cluster to the free list. */
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
-- 
2.53.0-Meta

