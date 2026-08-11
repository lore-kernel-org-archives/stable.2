Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AD3344A71D
	for <stable@vger.kernel.org>; Tue, 11 Aug 2026 14:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786459845; cv=none; b=Rih5FhdT5Vdy16BERxf5G+FZJBrNdGKEwbYL3UXBsaeTqWbzY2GVsoTMrg/qWoiNrEEmLgfYcwM/My+SJEiXzB9+G9LKZxAm+jFmiqr3i6ytFhUaqRuIszwEwN8jZXOTDkaXEsXp2rYja1RjBm1EqVAtjTm1LcsWOvyMTiUFonc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786459845; c=relaxed/simple;
	bh=cyZOMTc0CavCv1iXY1faXzjK3R7C/Lw0W8YuSnuiZuk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oR2KmCupO5VI+uKn0C5NZ/H8xD3E5Fe3pwY8QqdluRxgmwEUmxHI/Db8vrMqcpsLF7r0RxMsCy7LDkN1JRxh8Vvj48IKJdI9k/iS9qVI/FNXluNZ8Fy8XxPctO0s2UulxJReW261luaQ1kdIz1vvO8tplQpB+KBD+JkKPNhDlNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rGvlprHB; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rGvlprHB"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-47fe377a217so615104f8f.1
        for <stable@vger.kernel.org>; Tue, 11 Aug 2026 07:50:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786459840; x=1787064640; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/ZFJ9NJv55ZqQdxFJ1GooxaamO5/m9Hc7TceAIdmiK8=;
        b=rGvlprHB/tJfLd20+VpnnhbaUwYyYdi7jqlJp0RrAwd6Ovmr0jEJ8PQFqV7f1HHHaJ
         LU+j4Ssz7YWNG+ElT2NeakVLRuqcCEFaMizsEVJQBZEcgSWrCFwH9ONGUdktVatsAOIj
         urtK8LWK2cOcxTvZ1oefKgKIyYazCI/xkVlY39Y7ip9TsRvrua3Y2nA5ZgGFxywD2btw
         XunTr90yafs9+PQ7g2sM81UsxT4FLscS0X05i7M/u0pNB7lh68cwGZclXsg/tBhql5ca
         Nd1R8o9tEivlRdle3OUS1045mZwrlJfp58RGHnHe3WoC/MWdqmzBMB6gEc8dLeyUFzJk
         qj3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786459840; x=1787064640;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/ZFJ9NJv55ZqQdxFJ1GooxaamO5/m9Hc7TceAIdmiK8=;
        b=rhWf2+Dt0p1FnDdqjLM527SUNpmPvc7synK075dzkdc3ZJiNIiZOwPSYfEYgXB22cw
         etu9ABi/GN0hFuUZ5ntggupLp8CHCO3ISZiVpYdShPOL1ErRPGTG0XI8AXqukSUCsXQT
         G0rQncE9npGOhEJSwkfvUcI0hUlaP41eERYQT+bKledRiXpZhOMa7MlXJ3bW6COZSoUA
         r6PrtLYFgZElKiqaKNssxcQp0DxBnS8syaqqLt6RBmaQlip7Fy0iuUmR9NrmNMusJQMG
         2sa6oeRceT5tscGWT30ncBo9EMbEDxa664TIvDQEwkhQPfguJvVdweOOu8B7ItHwlD9Y
         Pt9w==
X-Gm-Message-State: AOJu0Yy2Sg2rgy+xp+8x6JZj3Khm0yqPWg4jFQbXcY2nN3vMBAPXEAfJ
	WlN+egTkL/kP76SF6iXwciRzL8MbdcipSrukbplx1Ex8Rd5DfOQx4AX9UeXGQg==
X-Gm-Gg: AR+sD126hLDfDW09bavDq2jW9phNGImA4tXgVfNftqVW33nPlEULtWW/pAwFPK6i/9/
	KF+B8cUJYzSY+b7jWoX7EKm0/1MkP05m0sSCAY5rARY8Plr+gR11bHgEnB/f7hSTWa+Uc7IRxhv
	B4WQtA3g3s6ZJ9Q/+YOK9Mnlu6IbUSIXvUSowC0KBVHWQgICKsxtnd4EAT2ND7RG07FUm69LikE
	EpgDIGjS1XYTvmT1WU6aoRmGuyhdPHN4sbJtAYYNSdFyBWrUAQDo5kdRcMDJkv5uFnJ79L43GDC
	c8PEM4SF+o7r0hYAfw6CiASyhZxhNJITirUWaAYPpsddFZJvDwT9yqN2+NhmZkrRGjKD+aRRUtd
	xpHZ9rVvIq8hGTzuWi5DewE7i2wUtlvxwllRlGsSaMbstSqrumMr5yvapq2sVf/weWJeRBTICsu
	FUwxpImUtrop/ggseq2r2nEU8de4eujzTMRfMOI0fr7J+r4Yl3bkZoYaYTkh5If4b01CQRA0T9U
	kbIwtBkO7JvA6/EpXNOdOH1QU9yWmX7WJl3dmzdJRepofw2wNKrTOqw9p/bHlU=
X-Received: by 2002:a05:6000:2209:b0:47f:9de0:c27f with SMTP id ffacd0b85a97d-4814fd431b5mr1834779f8f.1.1786459840236;
        Tue, 11 Aug 2026 07:50:40 -0700 (PDT)
Received: from torre-GIGABYTE-B550-AORUS-ELITE-V2 (212.pool95-21-2.static.orange.es. [95.21.2.212])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4814a72cea1sm5646271f8f.37.2026.08.11.07.50.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 07:50:39 -0700 (PDT)
From: =?UTF-8?q?=C3=93scar=20Meg=C3=ADa=20L=C3=B3pez?= <megia.oscar@gmail.com>
To: megia.oscar@gmail.com
Cc: stable@vger.kernel.org
Subject: [PATCH v5 4/6] Memory leak error in qxl unbind
Date: Tue, 11 Aug 2026 16:49:20 +0200
Message-ID: <20260811144957.69900-5-megia.oscar@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260811144957.69900-1-megia.oscar@gmail.com>
References: <20260811144957.69900-1-megia.oscar@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Bug: ttm_pool_mgr_init() does not check ttm_pool_type_init() return
and does not free pool if returns error.

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
index 3e6520297fb2..46e13707493a 100644
--- a/drivers/gpu/drm/ttm/ttm_pool.c
+++ b/drivers/gpu/drm/ttm/ttm_pool.c
@@ -1424,6 +1424,54 @@ static inline u64 ttm_get_node_memory_size(int nid)
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
@@ -1434,6 +1482,8 @@ static inline u64 ttm_get_node_memory_size(int nid)
 int ttm_pool_mgr_init(unsigned long num_pages)
 {
 	unsigned int i;
+	int ret = 0;
+	struct ttm_pool_type *types_free[3];
 
 	int nid;
 	for_each_node(nid) {
@@ -1448,15 +1498,53 @@ int ttm_pool_mgr_init(unsigned long num_pages)
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
@@ -1470,10 +1558,6 @@ int ttm_pool_mgr_init(unsigned long num_pages)
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

