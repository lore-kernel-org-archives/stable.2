Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3FF147ECCF
	for <stable@vger.kernel.org>; Tue, 11 Aug 2026 19:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786477366; cv=none; b=u2+yMtjc6H4crywKa6ob4RcE5HmNCcPFhSRzehztiMqCnHvAIpI+OQrCCfHMZJGYLLnDAxu0Ik+jPSrZHbxWQNYY0qg9Iufe98XuaBd/FTvq0ynTkkvhq8f+707xpqWMZ6m6bln3QBZmc0ISjha44IzAZQ40D9zy6XnQ6YLCWLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786477366; c=relaxed/simple;
	bh=U1vS2hAziy9qUItkEoTyRmbezIqMpTHDIy3iBj2cyM8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QezyzU9xdc6UwoEdCr6vkNcP0chiWQJHXM8C5LibUzUGVIXNk9NSpetA0AgTNuC4ZsEaUFE7xR90NS6GIkPjWCYSbW88hV3txli6SLOR0Nxn9pDu+aPM5quSGML6hX2d4kHq3EHjnAYiWusPjxEklMFO2ymx0JQ/TshJG08Tx8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NGm56c+a; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NGm56c+a"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4954aff6088so513945e9.3
        for <stable@vger.kernel.org>; Tue, 11 Aug 2026 12:42:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786477363; x=1787082163; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ThEXNcRr1uXZthkNQc1yyhogFUr1K8iZ1YVWwE63FbE=;
        b=NGm56c+aCWP/l58H2V1CRfpFp8lr6tPBhLTbD+n9TyELFNa/PLbcoBaPWP7rwjWO+9
         0Q6n/SlHCFx66NvBjbA1Jm7ZorAJFSSY9wcSGvCXfeSTRhp1Gf1GbLt7icV1U0QsCQH2
         Tgw941ZC9vgqtdYK4SPXePgU5P/4EO+WhZhgButpuwKhAjrT7xJimL8xZQ2QQW5Z0iRh
         4iGyhbGmbM7Sl5tS6vpPxnBOWPFPmzstynoiB3sqMfzqaBmj8s9UPnFeiRPixDhUPb5P
         v5jGFK7OZbWFjjs+PDgfwoZdNoVZ62YGWLt4RnQGQwuEh0ZIn0ZEoASRUy9EkrSGSDLc
         xIcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786477363; x=1787082163;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ThEXNcRr1uXZthkNQc1yyhogFUr1K8iZ1YVWwE63FbE=;
        b=D6+bUegdNRc81pHKbixlPIDj+ATVeDy44AvB9gbpeO7jq/1/yg8DF27XTvHC6nC4v9
         +1/rcgpiZpIyqMS0Mh1sK/TBLmYrmYuHLEFvMixLZjSLe5jf2Rq+gCHdDRbW1kjKTkIH
         hkdO0ge30diHAtLLTGFtEaePPI4rm4Q2fffXfvAiEr2pxG1VB3rbCma4QGb4WpYRAisT
         1SFrVm1gOulZOXqNPqXK6Cbr7YXp4V+g/g3InyixXgiQB1v6dqEJpAPuRAVjzn3SwKcs
         6661JPejoNohxkEj2caW9H9rCiGcLA7f0MQHIh69NeyfIwPS5DuEdKsLpO62cEJZuzN6
         DuMw==
X-Forwarded-Encrypted: i=1; AHgh+Rr3nZZanza85a1S2BzY7lzcGp11qBc7V/DVTjFZhJnAcJhlcma46KuZU9N622+CE0XOvtgS2A4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjQERW0gcZAH4G2wQG1taTFsjVlSGwbdXj6HZGoSRxZVOsfPzH
	3YByag//6X4h4vQG6sbtISrkrjxl53pH4SxDKvYddAELNI9spB30bFet
X-Gm-Gg: AR+sD10iPD7G6I4lPY2CZ8v+iIgUIRlNs4bQ6Le5vTtH5Kr8JaLKTQbQctnmtSu4P7h
	H+kl5g38FBFXxbkku10d0FQGVDaW+gRvLICUbIapwkFv5ySvISCVmOkaSFj3VCug6gjUQlHYADF
	SlGOzAJFdCa8KImhWkDkBEgLEx3xj84M8D/k9sbsNXBiXvrf08hiSY8u8RKSmFTfXMC+/gbAYT0
	PsIP1dYiUgLJpS2V3fSBko13G2XTjqBEww/G8kgn0B0tPP/YDdJUiNqFTPqZn7qN3PbNOcSiG8z
	nTE2k2GZ+kwrn7PykzeVbeM54CIFgJtR8Bp9JMErEzjdDqI3LpivhRxJBQIzxQKOeCaNNb1ytmc
	aULn5jAf9k3ad7qQrSO41DIXiwBvwETmFhwdlpaQesjmNKA9yW9YDCRxJ/mxuWHy3YMa2+w3WgR
	JOI3oxDIVxZj9OjXFxJ6GM0jQMIlkx9MYx/wIebr7BvWVJuIQ0CPCs3CeXdZrLWaErSKpZ3w2gq
	aB2VsM/hCRH7agMH51bhIVK8YhNQSg477Ja0+Qt68yAnd1pXeox4U7/iP2QQ8A=
X-Received: by 2002:a05:600c:1f83:b0:499:4e47:eaf2 with SMTP id 5b1f17b1804b1-49978413130mr87241535e9.6.1786477362706;
        Tue, 11 Aug 2026 12:42:42 -0700 (PDT)
Received: from torre-GIGABYTE-B550-AORUS-ELITE-V2 (212.pool95-21-2.static.orange.es. [95.21.2.212])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4997adad05esm3986195e9.3.2026.08.11.12.42.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 12:42:42 -0700 (PDT)
From: =?UTF-8?q?=C3=93scar=20Meg=C3=ADa=20L=C3=B3pez?= <megia.oscar@gmail.com>
To: Christian Koenig <christian.koenig@amd.com>,
	Huang Rui <ray.huang@amd.com>
Cc: =?UTF-8?q?=C3=93scar=20Meg=C3=ADa=20L=C3=B3pez?= <megia.oscar@gmail.com>,
	Matthew Auld <matthew.auld@intel.com>,
	Matthew Brost <matthew.brost@intel.com>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linux.dev,
	stable@vger.kernel.org
Subject: [PATCH v5 4/6] ttm_pool_type_init() does not check return value
Date: Tue, 11 Aug 2026 21:42:19 +0200
Message-ID: <20260811194224.121597-5-megia.oscar@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260811194224.121597-1-megia.oscar@gmail.com>
References: <20260811194224.121597-1-megia.oscar@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Bug: ttm_pool_mgr_init() does not check ttm_pool_type_init() return
value and does not free pool if returns error.

Fix: Move up shrinker_alloc(), check ttm_pool_type_init() return and free
pool types and shrinker if non-zero and return error.

Assisted-by: OpenCode:1.17.18-Big Pickle/DeepSeek V4 Flash
Assisted-by: claude.ai:Sonnet 5
Cc: <stable@vger.kernel.org> # 7.1.0
Fixes: 444e2a19d7fd ("ttm/pool: port to list_lru. (v2)")
Signed-off-by: Óscar Megía López <megia.oscar@gmail.com>
---
 drivers/gpu/drm/ttm/ttm_pool.c | 100 ++++++++++++++++++++++++++++++---
 1 file changed, 92 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/ttm/ttm_pool.c b/drivers/gpu/drm/ttm/ttm_pool.c
index 87c843f52736..74d8770f41d8 100644
--- a/drivers/gpu/drm/ttm/ttm_pool.c
+++ b/drivers/gpu/drm/ttm/ttm_pool.c
@@ -1421,6 +1421,54 @@ static inline u64 ttm_get_node_memory_size(int nid)
 	return managed_pages * PAGE_SIZE;
 }
 
+static void ttm_pool_type_fini_and_list_lru_destroy(unsigned int nr)
+{
+	unsigned int i;
+
+	if (nr == 0)
+		return;
+
+	for (i = 0; i < nr; ++i) {
+		ttm_pool_type_fini(&global_write_combined[i]);
+		ttm_pool_type_fini(&global_uncached[i]);
+		ttm_pool_type_fini(&global_dma32_write_combined[i]);
+		ttm_pool_type_fini(&global_dma32_uncached[i]);
+	}
+
+	/* We removed the pool types from the LRU, but we need to also make sure
+	 * that no shrinker is concurrently freeing pages from the pool.
+	 */
+	ttm_pool_synchronize_shrinkers();
+
+	for (i = 0; i < nr; ++i) {
+		list_lru_destroy(&global_write_combined[i].pages);
+		list_lru_destroy(&global_uncached[i].pages);
+		list_lru_destroy(&global_dma32_write_combined[i].pages);
+		list_lru_destroy(&global_dma32_uncached[i].pages);
+	}
+
+}
+
+static void ttm_pool_type_fini_and_list_lru_destroy_partial(
+				struct ttm_pool_type *types[], unsigned int n)
+{
+	unsigned int k;
+
+	if (n == 0)
+		return;
+
+	for (k = 0; k < n; ++k)
+		ttm_pool_type_fini(types[k]);
+
+	/* We removed the pool types from the LRU, but we need to also make sure
+	 * that no shrinker is concurrently freeing pages from the pool.
+	 */
+	ttm_pool_synchronize_shrinkers();
+
+	for (k = 0; k < n; ++k)
+		list_lru_destroy(&types[k]->pages);
+}
+
 /**
  * ttm_pool_mgr_init - Initialize globals
  *
@@ -1431,6 +1479,8 @@ static inline u64 ttm_get_node_memory_size(int nid)
 int ttm_pool_mgr_init(unsigned long num_pages)
 {
 	unsigned int i;
+	int ret = 0;
+	struct ttm_pool_type *types_free[3];
 
 	int nid;
 	for_each_node(nid) {
@@ -1445,15 +1495,53 @@ int ttm_pool_mgr_init(unsigned long num_pages)
 	spin_lock_init(&shrinker_lock);
 	INIT_LIST_HEAD(&shrinker_list);
 
+	mm_shrinker = shrinker_alloc(SHRINKER_NUMA_AWARE, "drm-ttm_pool");
+	if (!mm_shrinker)
+		return -ENOMEM;
+
 	for (i = 0; i < NR_PAGE_ORDERS; ++i) {
-		ttm_pool_type_init(&global_write_combined[i], NULL,
+		ret = ttm_pool_type_init(&global_write_combined[i], NULL,
 				   ttm_write_combined, i);
-		ttm_pool_type_init(&global_uncached[i], NULL, ttm_uncached, i);
+		if (ret) {
+			ttm_pool_type_fini_and_list_lru_destroy(i);
+			shrinker_free(mm_shrinker);
+			return ret;
+		}
+
+		ret = ttm_pool_type_init(&global_uncached[i], NULL, ttm_uncached, i);
+		if (ret) {
+			types_free[0] = &global_write_combined[i];
+			ttm_pool_type_fini_and_list_lru_destroy_partial(types_free, 1);
 
-		ttm_pool_type_init(&global_dma32_write_combined[i], NULL,
+			ttm_pool_type_fini_and_list_lru_destroy(i);
+			shrinker_free(mm_shrinker);
+			return ret;
+		}
+
+		ret = ttm_pool_type_init(&global_dma32_write_combined[i], NULL,
 				   ttm_write_combined, i);
-		ttm_pool_type_init(&global_dma32_uncached[i], NULL,
+		if (ret) {
+			types_free[0] = &global_write_combined[i];
+			types_free[1] = &global_uncached[i];
+			ttm_pool_type_fini_and_list_lru_destroy_partial(types_free, 2);
+
+			ttm_pool_type_fini_and_list_lru_destroy(i);
+			shrinker_free(mm_shrinker);
+			return ret;
+		}
+
+		ret = ttm_pool_type_init(&global_dma32_uncached[i], NULL,
 				   ttm_uncached, i);
+		if (ret) {
+			types_free[0] = &global_write_combined[i];
+			types_free[1] = &global_uncached[i];
+			types_free[2] = &global_dma32_write_combined[i];
+			ttm_pool_type_fini_and_list_lru_destroy_partial(types_free, 3);
+
+			ttm_pool_type_fini_and_list_lru_destroy(i);
+			shrinker_free(mm_shrinker);
+			return ret;
+		}
 	}
 
 #ifdef CONFIG_DEBUG_FS
@@ -1467,10 +1555,6 @@ int ttm_pool_mgr_init(unsigned long num_pages)
 #endif
 #endif
 
-	mm_shrinker = shrinker_alloc(SHRINKER_NUMA_AWARE, "drm-ttm_pool");
-	if (!mm_shrinker)
-		return -ENOMEM;
-
 	mm_shrinker->count_objects = ttm_pool_shrinker_count;
 	mm_shrinker->scan_objects = ttm_pool_shrinker_scan;
 	mm_shrinker->batch = TTM_SHRINKER_BATCH;
-- 
2.55.0

