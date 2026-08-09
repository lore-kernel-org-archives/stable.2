Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC1FE377A94
	for <stable@vger.kernel.org>; Sun,  9 Aug 2026 17:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786297044; cv=none; b=nK1gHc9QnWIMmKTFcsoduxggnJw1JpwllVEDYvJTMMcTgAz2EY+pBl2n0XY+UfOMrJu2W84JWf7dqjfuu8/4YtWb3IOXisVkdt9g6v9oBeIoEzFl9j97lGKy7t4uBKVP3DIDYxMvQKcBlFXBSEUR7/QxpowbwURroFtNA2EwlGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786297044; c=relaxed/simple;
	bh=iW+Fmt84r/jOM4AJjU1cEErKScitlaJqG/PyeuPEOPU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nrdJH1wVLhFAaiccDZj6hApdeJRLrK007TsF7rFq7dcp38Vg4rywIyJxdYUWP/M3l15dou4GnFGPXJbz7qy0NurFBl+91JXV4mabm9uNhQ7oYSIc6Xd/yWL0XYF26AHYUvIPCd7c/ML9rtjPpDt/uqbCDvHjaXFT3XMDPl/lzeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZjUo5Z5Y; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZjUo5Z5Y"
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-8ff5d1b0f91so6497716d6.2
        for <stable@vger.kernel.org>; Sun, 09 Aug 2026 10:37:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786297041; x=1786901841; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=UDwhP+SNEQonzNCu80xIUxXIG/Qn0ez/r1xaxvU+zXo=;
        b=ZjUo5Z5YDfarTvXUZWKRdssqG1KvjArs9AAdaH+PPrffYMw7bLuaDT2+HhzztYpyeg
         6+E3NquTho49gwQeUiOb3MzxFfFLpu2v21WFaUupaDss8B7/05v0VbjwSKSLDhaGj9Ah
         oW5LeTfym3XW+xY7TT2QZ4u+Ps/DOGj++oZCw6CsMyRd8lmOmz5RXfqVI3Xf9sVmzrqN
         B7p0aY/wltllOILmfXW7h4Wg/TMrh5uDXSLwZFitL8ky+7WwZMv9LSUVMxrDtlNX7h8B
         IYIZA5+gg7v5MLtIBw8ZjJzSo/Reep2m7lRvm1fM1yph5UIZKtam79Loq7Qv2enW6rbE
         vY2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786297041; x=1786901841;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UDwhP+SNEQonzNCu80xIUxXIG/Qn0ez/r1xaxvU+zXo=;
        b=NI/k6CBZ4yg2nK0MtNc2T7oEe3hQeiozC5euTEslXUiHxCfc8a0XS3/hS2tvxEWPB3
         BDmLITWIbEmA0pLkTEbbdWs2p2cq2k3JmYzI318UvW8Q6Acm02YT0y/6Cq2fHyfdAKEB
         /Qo6Lt0brvXye4S6QEkNdJZKOd+U5AkkYW3llNBfUCk7XvWT8JArSNH0UXg0AYsNy6v6
         fvAdFZbslmvr5hBpUjGGM3JdrtPFANcxcOcoQOrhlne1T1cOs9UGUU4bvEbIph6xhtVM
         /adlfxjBr5BJevNbn52bEVhobe1p8b3PcKedJL781TWzpRaJRMh44PdYeDhVO6UDd/G8
         MjQw==
X-Forwarded-Encrypted: i=1; AHgh+RqAPFRhxJgLUz9Q4wFXO5u9IwPoMhVmrApK2Ob7lrwPeZanx+V3Kl9cgfFfdhBn7S3kx2motCg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWw+ypaGd9rJdg//f0H5YxU8mwABdKu4SI7uBC9yZO+I4VL0p/
	3vFEOgB2oKi76IjWDg3MJ5+X00MwYjVflZhAOZSnBg4hSoJWeYICYDa7
X-Gm-Gg: AR+sD10iT7f4bqNpkCHqQDSayea1U1M+STzfRGMJtrV7S4pZT6XxFkvcp2XM+QRUpr4
	DOw+sZu5Gh3o5yvbzoyRkd88u7W4TWm5+LeGTp65OgzS6geAtwp5BmPpOzXqsIUY2LY6iT4Wrsh
	SiI+cVHM7BHg1x5OqpRbc/UKgbGkQkUP6n7BN03eFQ2ogpx2+0011P/KzdNYMrPXTbNFcTzLXHB
	xn4Mg20n/156Li9aJZ8HQ13SK2Ou+ZUqhyYmaNhkXick4V28dy7flL8mxtaUWNezhhhJI8fqHn9
	SOBEVk2RWkKrH3dHdc3ztseYvVsK0LN8Ahzi/udqUP4TmjUXaYi6K5L7mKZfGM3ESJZx6EJpM7p
	NwHrbSkzaFZ753+MAD0JTJTZeXOX1KAbCEyMIck9ShGdpknLuRbunV7MDZdyUmRxIbsbS2KZ1e5
	9tYTKvKFnVJZGpl3Y9K4Zv2nXK5NO1IRJpgZwtQ8pdbYFrFFvMbrEnn24j7ZbYiCaQjevpL9u0p
	xBSNf9D+EHipfAAk2/XRRWKsGBY
X-Received: by 2002:a05:6214:4f06:b0:908:9045:217a with SMTP id 6a1803df08f44-908904526e0mr330626976d6.29.1786297041447;
        Sun, 09 Aug 2026 10:37:21 -0700 (PDT)
Received: from i4-l-hqh5357-03.ad.psu.edu ([130.203.139.71])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-908a918ec9fsm55388176d6.5.2026.08.09.10.37.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Aug 2026 10:37:21 -0700 (PDT)
From: Shuangpeng Bai <shuangpeng.kernel@gmail.com>
To: intel-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	jani.nikula@linux.intel.com,
	joonas.lahtinen@linux.intel.com,
	rodrigo.vivi@intel.com,
	tursulin@ursulin.net,
	chris@chris-wilson.co.uk,
	Shuangpeng Bai <shuangpeng.kernel@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] drm/i915/gem: Fix request use-after-free in active_engine()
Date: Sun,  9 Aug 2026 13:36:46 -0400
Message-ID: <20260809173646.3292361-1-shuangpeng.kernel@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

active_engine() walks timeline->requests in reverse under RCU and takes a
temporary reference before inspecting each request. However, it drops that
reference in the loop body before list_for_each_entry_reverse() advances
the cursor.

Concurrent retirement can unlink the same request and drop its base
reference while active_engine() holds the temporary reference. The put in
active_engine() may then be final, freeing or recycling the request before
the loop step reads rq->link.prev. SLAB_TYPESAFE_BY_RCU does not defer that
reuse.

Open-code the reverse walk and cache the previous request while the current
request is still referenced. The next request remains protected by
i915_request_get_rcu() and validated against the timeline before use.

An i915 mock selftest forced retirement between the active check and cursor
advance. The vulnerable tree reached the final request release and
kmem_cache_free(), while the fixed tree completed the same ordering without
accessing rq after the put.

Fixes: 3cfea8c97c93 ("drm/i915/gem: Hold request reference for canceling an active context")
Cc: stable@vger.kernel.org # v5.10+
Signed-off-by: Shuangpeng Bai <shuangpeng.kernel@gmail.com>
---
 drivers/gpu/drm/i915/gem/i915_gem_context.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/i915/gem/i915_gem_context.c b/drivers/gpu/drm/i915/gem/i915_gem_context.c
index c58ffa5a8fa6..ff5c892a0176 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_context.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_context.c
@@ -1361,7 +1361,7 @@ static bool __cancel_engine(struct intel_engine_cs *engine)
 static struct intel_engine_cs *active_engine(struct intel_context *ce)
 {
 	struct intel_engine_cs *engine = NULL;
-	struct i915_request *rq;
+	struct i915_request *rq, *prev;
 
 	if (intel_context_has_inflight(ce))
 		return intel_context_inflight(ce);
@@ -1375,7 +1375,8 @@ static struct intel_engine_cs *active_engine(struct intel_context *ce)
 	 * (and onto a new timeline->requests list).
 	 */
 	rcu_read_lock();
-	list_for_each_entry_reverse(rq, &ce->timeline->requests, link) {
+	rq = list_last_entry(&ce->timeline->requests, typeof(*rq), link);
+	while (!list_entry_is_head(rq, &ce->timeline->requests, link)) {
 		bool found;
 
 		/* timeline is already completed upto this point? */
@@ -1387,9 +1388,14 @@ static struct intel_engine_cs *active_engine(struct intel_context *ce)
 		if (likely(rcu_access_pointer(rq->timeline) == ce->timeline))
 			found = i915_request_active_engine(rq, &engine);
 
+		/* Cache the cursor before the put, which may release rq. */
+		if (!found)
+			prev = list_prev_entry(rq, link);
 		i915_request_put(rq);
 		if (found)
 			break;
+
+		rq = prev;
 	}
 	rcu_read_unlock();
 

base-commit: a59f57e2aa127c5354168d2ec4bac920df1be4f4
-- 
2.43.0

