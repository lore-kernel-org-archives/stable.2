Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3DFD19D07A;
	Fri, 26 Jun 2026 14:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782485663; cv=none; b=QV/qUi5CQ4I/QOoGT0zjQ6k4KJWZDAvnNG1uXWmhcvZh7G+Ckm7e/8BTJIs8xEyozO1qIWGg0IoOaHuxLmiRXz/cNtYVgnP2mDw7MtFAh1da3lT2JTZwFy5A7GM4TXMldiIB9SeXx04jFodYraWZDJmUJIBhTy/tmXs21k1uuHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782485663; c=relaxed/simple;
	bh=rAe/OfMdGpTGZJcbNZ5Hw6xWXnnkikeI2oDUiqEkSJM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Jqsxz5Ur1Sb+fLbCXsukthIDf9SuJEBJ4nJDJMHf96vArjdMnZ3Kj8m1rJCJipLvTqZ8dzgIc3Y55dWuDdzp6D8cr+W1AIrm4NUwr9XA0Q5XQJzrW2Zj7A5LHsUKVbsUEaS8bMcD3/mdhPfZH66qum3EK4XlJxS94ssXaqLLLgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [117.182.75.66])
	by APP-01 (Coremail) with SMTP id qwCowAAHrNSSkj5qoPNqAw--.9971S2;
	Fri, 26 Jun 2026 22:54:11 +0800 (CST)
From: WenTao Liang <vulab@iscas.ac.cn>
To: Christian Koenig <christian.koenig@amd.com>,
	Huang Rui <ray.huang@amd.com>,
	dri-devel@lists.freedesktop.org
Cc: Matthew Auld <matthew.auld@intel.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Karolina Stolarek <karolina.stolarek@intel.com>,
	Amaranath Somalapuram <asomalap@amd.com>,
	Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	WenTao Liang <vulab@iscas.ac.cn>
Subject: [PATCH] fix: drm/ttm/tests: use KUNIT_ASSERT_EQ for critical error checks to   prevent kref underflow
Date: Fri, 26 Jun 2026 22:54:09 +0800
Message-Id: <20260626145409.49370-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowAAHrNSSkj5qoPNqAw--.9971S2
X-Coremail-Antispam: 1UD129KBjvJXoWxuw4DGw1kKr1DuryxKrWkXrb_yoW7Zr1UpF
	WUGFWjkry8JrsFgayUAr1UtFnFk39Y9FZYgrn5Wa1fXFnIv3Z8JFn5tF1fur43XFWjvFsY
	ka1YyanxX34kXwUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Y14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628v
	n2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
	kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
	67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
	CI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1x
	MIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCT
	nIWIevJa73UjIFyTuYvjfU5iihUUUUU
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiDAAKA2o+idsWxQAAsQ

Replace KUNIT_EXPECT_EQ with KUNIT_ASSERT_EQ in ttm_bo_validate test cases
where subsequent ttm_bo_fini would cause a kref underflow if the preceding
ttm_bo_init_reserved (or ttm_bo_validate) failed. When those functions fail
they already release their internal references, leaving the refcount at 0.
Continuing to ttm_bo_fini without aborting performs an extra kref_put.

Cc: stable@vger.kernel.org
Fixes: 8bd1ff5ddc7b ("drm/ttm/tests: Test simple BO creation and validation")
Signed-off-by: WenTao Liang <vulab@iscas.ac.cn>
---
 .../gpu/drm/ttm/tests/ttm_bo_validate_test.c  | 22 +++++++++----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/ttm/tests/ttm_bo_validate_test.c b/drivers/gpu/drm/ttm/tests/ttm_bo_validate_test.c
index 2db221f6fc3a..7c4179f6349c 100644
--- a/drivers/gpu/drm/ttm/tests/ttm_bo_validate_test.c
+++ b/drivers/gpu/drm/ttm/tests/ttm_bo_validate_test.c
@@ -217,7 +217,7 @@ static void ttm_bo_init_reserved_resv(struct kunit *test)
 				   &dummy_ttm_bo_destroy);
 	dma_resv_unlock(bo->base.resv);
 
-	KUNIT_EXPECT_EQ(test, err, 0);
+	KUNIT_ASSERT_EQ(test, err, 0);
 	KUNIT_EXPECT_PTR_EQ(test, bo->base.resv, &resv);
 
 	ttm_resource_free(bo, &bo->resource);
@@ -249,7 +249,7 @@ static void ttm_bo_validate_basic(struct kunit *test)
 	err = ttm_bo_init_reserved(priv->ttm_dev, bo, params->bo_type,
 				   fst_placement, PAGE_SIZE, &ctx_init, NULL,
 				   NULL, &dummy_ttm_bo_destroy);
-	KUNIT_EXPECT_EQ(test, err, 0);
+	KUNIT_ASSERT_EQ(test, err, 0);
 
 	snd_place = ttm_place_kunit_init(test, snd_mem, GPU_BUDDY_TOPDOWN_ALLOCATION);
 	snd_placement = ttm_placement_kunit_init(test, snd_place, 1);
@@ -395,7 +395,7 @@ static void ttm_bo_validate_same_placement(struct kunit *test)
 	err = ttm_bo_init_reserved(priv->ttm_dev, bo, params->bo_type,
 				   placement, PAGE_SIZE, &ctx_init, NULL,
 				   NULL, &dummy_ttm_bo_destroy);
-	KUNIT_EXPECT_EQ(test, err, 0);
+	KUNIT_ASSERT_EQ(test, err, 0);
 
 	err = ttm_bo_validate(bo, placement, &ctx_val);
 	dma_resv_unlock(bo->base.resv);
@@ -722,7 +722,7 @@ static void ttm_bo_validate_move_fence_not_signaled(struct kunit *test)
 	err = ttm_bo_init_reserved(priv->ttm_dev, bo, bo_type, placement_init,
 				   PAGE_SIZE, &ctx_init, NULL, NULL,
 				   &dummy_ttm_bo_destroy);
-	KUNIT_EXPECT_EQ(test, err, 0);
+	KUNIT_ASSERT_EQ(test, err, 0);
 
 	ttm_mock_manager_init(priv->ttm_dev, fst_mem, MANAGER_SIZE);
 	ttm_mock_manager_init(priv->ttm_dev, snd_mem, MANAGER_SIZE);
@@ -840,7 +840,7 @@ static void ttm_bo_validate_happy_evict(struct kunit *test)
 	err = ttm_bo_validate(bo_val, placement, &ctx_val);
 	ttm_bo_unreserve(bo_val);
 
-	KUNIT_EXPECT_EQ(test, err, 0);
+	KUNIT_ASSERT_EQ(test, err, 0);
 	KUNIT_EXPECT_EQ(test, bos[0].resource->mem_type, mem_type_evict);
 	KUNIT_EXPECT_TRUE(test, bos[0].ttm->page_flags & TTM_TT_FLAG_ZERO_ALLOC);
 	KUNIT_EXPECT_TRUE(test, bos[0].ttm->page_flags & TTM_TT_FLAG_PRIV_POPULATED);
@@ -879,7 +879,7 @@ static void ttm_bo_validate_all_pinned_evict(struct kunit *test)
 	err = ttm_bo_init_reserved(priv->ttm_dev, bo_big, bo_type, placement,
 				   PAGE_SIZE, &ctx_init, NULL, NULL,
 				   &dummy_ttm_bo_destroy);
-	KUNIT_EXPECT_EQ(test, err, 0);
+	KUNIT_ASSERT_EQ(test, err, 0);
 
 	ttm_bo_pin(bo_big);
 	dma_resv_unlock(bo_big->base.resv);
@@ -930,7 +930,7 @@ static void ttm_bo_validate_allowed_only_evict(struct kunit *test)
 	err = ttm_bo_init_reserved(priv->ttm_dev, bo_pinned, bo_type, placement,
 				   PAGE_SIZE, &ctx_init, NULL, NULL,
 				   &dummy_ttm_bo_destroy);
-	KUNIT_EXPECT_EQ(test, err, 0);
+	KUNIT_ASSERT_EQ(test, err, 0);
 	ttm_bo_pin(bo_pinned);
 	dma_resv_unlock(bo_pinned->base.resv);
 
@@ -941,7 +941,7 @@ static void ttm_bo_validate_allowed_only_evict(struct kunit *test)
 	err = ttm_bo_init_reserved(priv->ttm_dev, bo_evictable, bo_type, placement,
 				   PAGE_SIZE, &ctx_init, NULL, NULL,
 				   &dummy_ttm_bo_destroy);
-	KUNIT_EXPECT_EQ(test, err, 0);
+	KUNIT_ASSERT_EQ(test, err, 0);
 	dma_resv_unlock(bo_evictable->base.resv);
 
 	bo = ttm_bo_kunit_init(test, test->priv, BO_SIZE, NULL);
@@ -995,7 +995,7 @@ static void ttm_bo_validate_deleted_evict(struct kunit *test)
 	err = ttm_bo_init_reserved(priv->ttm_dev, bo_big, bo_type, placement,
 				   PAGE_SIZE, &ctx_init, NULL, NULL,
 				   &dummy_ttm_bo_destroy);
-	KUNIT_EXPECT_EQ(test, err, 0);
+	KUNIT_ASSERT_EQ(test, err, 0);
 	KUNIT_EXPECT_EQ(test, ttm_resource_manager_usage(man), big);
 
 	dma_resv_unlock(bo_big->base.resv);
@@ -1052,7 +1052,7 @@ static void ttm_bo_validate_busy_domain_evict(struct kunit *test)
 	err = ttm_bo_init_reserved(priv->ttm_dev, bo_init, bo_type, placement,
 				   PAGE_SIZE, &ctx_init, NULL, NULL,
 				   &dummy_ttm_bo_destroy);
-	KUNIT_EXPECT_EQ(test, err, 0);
+	KUNIT_ASSERT_EQ(test, err, 0);
 	dma_resv_unlock(bo_init->base.resv);
 
 	bo_val = ttm_bo_kunit_init(test, test->priv, BO_SIZE, NULL);
@@ -1096,7 +1096,7 @@ static void ttm_bo_validate_evict_gutting(struct kunit *test)
 	err = ttm_bo_init_reserved(priv->ttm_dev, bo_evict, bo_type, placement,
 				   PAGE_SIZE, &ctx_init, NULL, NULL,
 				   &dummy_ttm_bo_destroy);
-	KUNIT_EXPECT_EQ(test, err, 0);
+	KUNIT_ASSERT_EQ(test, err, 0);
 	dma_resv_unlock(bo_evict->base.resv);
 
 	bo = ttm_bo_kunit_init(test, test->priv, BO_SIZE, NULL);
-- 
2.39.5 (Apple Git-154)

