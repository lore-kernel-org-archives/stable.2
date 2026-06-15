Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29870211A14
	for <stable@vger.kernel.org>; Mon, 15 Jun 2026 23:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781567403; cv=none; b=gJ+NW6rq7SJ0tFPtO+cfWCbnno5YF4gKlBeLpYnh1rRACzYN3y3NukdmABAjuRbDHYJnL+HxVqBAix2dp6xGktIfyL/qia1tWajuOk/iuq9UZmz7VxJHFah+9ratRPGuWURiNVRMHuwFNYuuEEN5CjEvjcol8lP3jEInAUIOBlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781567403; c=relaxed/simple;
	bh=1KAwpuaqunao85edd0BfgLzDtsviQonKpCBP9gPML0U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B9iBDmIKLpDSLHR89dPDJAq8sR24LQOIt7kfMtBa6ume/9bZxLaMSh0HL47MwMyPBfS66woAgMNan6/kIeeuSaggDKgmBZz8xdqxQS6qjvChRNEYomtcFLYCkgXJSMvxw+uh/kRQ2El6VxPnSzl4UfMxUtDIdjy+jFYW0YVDQzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PidoONYI; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PidoONYI"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-915b5ce94c7so433727485a.2
        for <stable@vger.kernel.org>; Mon, 15 Jun 2026 16:50:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781567401; x=1782172201; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aD59fWP6U+2oV2sPLiRI6B5viEMhkSgKAPCznTndvPM=;
        b=PidoONYIQpUK5QCw8Il/XFS3GJwJAWJHvgW4Yt9EOsR3iNEdVE0uZiQz9xxD/75jBh
         O691Fr117H8nz6TIFaKCoUav1Uqtxbf9TVZHQc74r8AkSPTNFze80i45EmNdahvSRoQE
         n7Supc+Y9VOaqxIRCRxtKDskgznO5TONOSI0mkEY32oC/dXKR5UEV2eF1747pA0m4DDJ
         KHt3e46UXSDAKHpIie1bo5DXdin6Sd1bzr4NJGbA4QCzGDEOl4Cexma12N4tM7G3grA1
         oj4vwxiExHVkBdl3eFEkJ9q8rqoO223bD33165nbBNJ9OfoAsN5yJO5Gjo6NGcURdRbE
         ZcWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781567401; x=1782172201;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aD59fWP6U+2oV2sPLiRI6B5viEMhkSgKAPCznTndvPM=;
        b=bqBHiy4PHRNSnH+og922CLMFbEA7vBZ7NEJDJKReW/uVys8M0rOiV2K8sL1pNjRkrV
         Q9KkA66DK7Pb0pPEq6yayrR8pcbBxCLlgobisJgQEKNp0zJeIeVu30PiiTh0QxAjuZbM
         aD7QT8lsYw0gbJXu4x52qpimLJzLjucQtKts/XqqVQqaq8trHnFMY8fQ92BUkKBbxRPa
         DAYLHxr7sTwysr3KowkyfiyJ2dVZXMUW+NbwsI2UDgf0Zb3/VSVsL5qPe12Vc7cGv50t
         eSGEXbkT8JuuBxGSrIJA9J6k6wNKVsnvP/H97ayFPVTXT0EkAZldU2KixTgsgMRQLAnE
         3oaQ==
X-Forwarded-Encrypted: i=1; AFNElJ+S26y++fm86BbUfvMmO1A66QbSwY/i9Zs/vcGcfPUMnSR4v7bLglEwB+hZxVN/eDpUREGlIlo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjyWU0FW9o9cDf7y3uKppNuASTtmunaxqJZjtGAUNyLs870lez
	khg/kFdzAYVZNepyqxYevsbtuTBfn9HnNr7uC72RuDV7JB33PQFL6tCl
X-Gm-Gg: Acq92OG7RL2/9Ss430tHky/PraGSqYOim+5qHIbMOEuC9MQcEPM/+3Y+Pahvg7qySsg
	1EqxtLVVbY2abJkLT6CdK9keCfEl0S5SvuBMYtAm7fBMbECNxVJZixhv0D8zJF82IG61wl/K6FU
	SIL8pLGwqFDo+aNVm7JHfuXnKY1D7VW6OvZuEsR7epbIJTSP6y7Xy+9nmA31GL+Ho87bYj/1UBv
	CgvePTA30Roi8liBrL5DijBvcK8wr65Ib4yROXwGjqJDXr5YNrJ5Y1U5D9T8eD0ApsWY1tJo1pt
	lUrySznOK+qwjySwdZk7eppcLfvHneZtrpBqcrAjY4JKR4cjsy1wJ/5xDXMe+7BvZdsLo0MSqAI
	VH+bCZ1pCHxAFgjZqtJlKeXyYTybJCFCJ1Z43MtVFzhj76CwvNvu80g9NFw9jJx866Hx61+CDtn
	sFU1AMz4I/6GVbqQiHt/p70njTVw8ChYmQHbq585qE+YzgXaV+RIu1he7LNi5cVyL3gBjdmnojC
	29PtPtiZVLc
X-Received: by 2002:a05:620a:4720:b0:915:8f76:7ffa with SMTP id af79cd13be357-917f1474c76mr2073103685a.45.1781567400807;
        Mon, 15 Jun 2026 16:50:00 -0700 (PDT)
Received: from tropical-turnip.tail32462.ts.net ([216.132.43.94])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9161a00af50sm1387942285a.30.2026.06.15.16.49.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 16:50:00 -0700 (PDT)
From: Samuel Ainsworth <skainsworth@gmail.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Huang Rui <ray.huang@amd.com>
Cc: =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Matthew Auld <matthew.auld@intel.com>,
	Matthew Brost <matthew.brost@intel.com>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Samuel Ainsworth <skainsworth@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v1 1/2] drm/ttm: don't leave bulk_move cursor dangling for unevictable resources
Date: Mon, 15 Jun 2026 19:49:21 -0400
Message-ID: <20260615234922.151263-2-skainsworth@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260615234922.151263-1-skainsworth@gmail.com>
References: <20260615234922.151263-1-skainsworth@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ttm_resource_add_bulk_move() and ttm_resource_del_bulk_move() both act
only when the resource is evictable (!ttm_resource_unevictable()). A
resource is added to its bo's bulk_move cursor (pos->first / pos->last)
while evictable, but it can become unevictable -- pinned or swapped --
after it has been added.

ttm_resource_del_bulk_move() is reached both when the resource is freed
(ttm_resource_free()) and when the bo's bulk_move is cleared on teardown
(ttm_bo_set_bulk_move()). If the resource has become unevictable by then,
the del is skipped, so pos->first / pos->last are left pointing at it.
Once the resource is freed the cursor dangles, and the next
ttm_resource_add_bulk_move() / ttm_resource_move_to_lru_tail() on that
bulk_move dereferences it: a use-after-free read of
pos->first->bo->base.resv (the WARN_ON in ttm_lru_bulk_move_add())
followed by a list_move() through freed memory that corrupts the LRU
list. With CONFIG_DEBUG_LIST this manifests as a fatal "list_del
corruption" BUG.

On a Framework 13 (AMD Ryzen 7040, gfx1103) this is hit via hibernation:
a buffer object swapped out during hibernate (its resource becomes
unevictable) is later closed after resume (amdgpu_gem_object_close ->
amdgpu_vm_bo_del -> ttm_bo_set_bulk_move()), which skips removing its
resource from the VM's bulk_move cursor; a later GEM allocation on that
cursor then faults. KASAN reports a slab-use-after-free in
ttm_resource_add_bulk_move().

Track whether a resource is actually on the bulk_move cursor with a new
ttm_resource::bulk_move flag, set when it is added, and remove based on
that flag rather than on the resource's current evictability. The del
then always undoes what the add did, regardless of any pin/swap
transition in between.

Fixes: fc5d96670eb2 ("drm/ttm: Move swapped objects off the manager's LRU list")
Cc: stable@vger.kernel.org
Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/5387
Signed-off-by: Samuel Ainsworth <skainsworth@gmail.com>
---
 drivers/gpu/drm/ttm/ttm_resource.c | 18 +++++++++++++++---
 include/drm/ttm/ttm_resource.h     |  9 +++++++++
 2 files changed, 24 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/ttm/ttm_resource.c b/drivers/gpu/drm/ttm/ttm_resource.c
index 192fca24f37e..1a031ef151a7 100644
--- a/drivers/gpu/drm/ttm/ttm_resource.c
+++ b/drivers/gpu/drm/ttm/ttm_resource.c
@@ -280,16 +280,27 @@ static bool ttm_resource_unevictable(struct ttm_resource *res, struct ttm_buffer
 void ttm_resource_add_bulk_move(struct ttm_resource *res,
 				struct ttm_buffer_object *bo)
 {
-	if (bo->bulk_move && !ttm_resource_unevictable(res, bo))
+	if (bo->bulk_move && !ttm_resource_unevictable(res, bo)) {
 		ttm_lru_bulk_move_add(bo->bulk_move, res);
+		res->bulk_move = true;
+	}
 }
 
 /* Remove the resource from a bulk move if the BO is configured for it */
 void ttm_resource_del_bulk_move(struct ttm_resource *res,
 				struct ttm_buffer_object *bo)
 {
-	if (bo->bulk_move && !ttm_resource_unevictable(res, bo))
+	/*
+	 * Remove based on whether the resource was actually added, not on its
+	 * current evictability: a resource can become unevictable (pinned or
+	 * swapped) after being added, and must still be taken off the bulk_move
+	 * cursor before it is freed -- otherwise pos->first/last are left
+	 * dangling at freed memory.
+	 */
+	if (res->bulk_move) {
 		ttm_lru_bulk_move_del(bo->bulk_move, res);
+		res->bulk_move = false;
+	}
 }
 
 /* Move a resource to the LRU or bulk tail */
@@ -303,7 +314,7 @@ void ttm_resource_move_to_lru_tail(struct ttm_resource *res)
 	if (ttm_resource_unevictable(res, bo)) {
 		list_move_tail(&res->lru.link, &bdev->unevictable);
 
-	} else if (bo->bulk_move) {
+	} else if (res->bulk_move) {
 		struct ttm_lru_bulk_move_pos *pos =
 			ttm_lru_bulk_move_pos(bo->bulk_move, res);
 
@@ -339,6 +350,7 @@ void ttm_resource_init(struct ttm_buffer_object *bo,
 	res->bus.is_iomem = false;
 	res->bus.caching = ttm_cached;
 	res->bo = bo;
+	res->bulk_move = false;
 
 	man = ttm_manager_type(bo->bdev, place->mem_type);
 	spin_lock(&bo->bdev->lru_lock);
diff --git a/include/drm/ttm/ttm_resource.h b/include/drm/ttm/ttm_resource.h
index 33e80f30b8b8..1fedf75bab96 100644
--- a/include/drm/ttm/ttm_resource.h
+++ b/include/drm/ttm/ttm_resource.h
@@ -274,6 +274,15 @@ struct ttm_resource {
 	 * @lru: Least recently used list, see &ttm_resource_manager.lru
 	 */
 	struct ttm_lru_item lru;
+
+	/**
+	 * @bulk_move: Whether this resource is currently tracked by its bo's
+	 * &ttm_buffer_object.bulk_move cursor. Recorded when the resource is
+	 * added so the matching del removes it even if the resource has since
+	 * become unevictable (pinned or swapped) -- otherwise the cursor would
+	 * be left pointing at this resource after it is freed.
+	 */
+	bool bulk_move;
 };
 
 /**
-- 
2.54.0

