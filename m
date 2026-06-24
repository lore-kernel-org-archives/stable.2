Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6C5630569F
	for <stable@vger.kernel.org>; Wed, 24 Jun 2026 09:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782292203; cv=none; b=SyH1XzD+U79LQQDl4NEhjUvrVpLe5BQxNqG8l88P4EO4VcA3TtqHf/I1DvAEgTz6NwDPMorY+dAykMxmp7cejRb4fZ95/mz1sgBoeyUx3MUipsMVjMmPYLteLmlg1Qyn/9BT5zvgsJNhQJdiWGJ5JA0vVU80sb/xZidw84Z38Vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782292203; c=relaxed/simple;
	bh=2+AYVRt5sXs90dXPOyDTHlXALrZ4HOpnjfYqPyRpyZE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gcEnh+VYR+J8eqzFUwCu6oMFCvQys1jJ2PpVdBUxNZu8u5/Ccsn4keb8Qk0fpWDH9c9FiljuSQjofwLIlVi/Gs6WHZBgv+g6pLjwawIBiTHXnUH9umXS+gK6Yt64mYCsFS01RhOmdRMkZwjn20urPHVd85bB/hLyMH2h7rVLug0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=k2E600TH; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k2E600TH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782292201; x=1813828201;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=2+AYVRt5sXs90dXPOyDTHlXALrZ4HOpnjfYqPyRpyZE=;
  b=k2E600THkghbwK8aVsvI9a0XizwCHNGHzfFR2QAmStg2wHWoRaq8cfFY
   fwDx5h0yiiHpGOxUa2koIRRQNVCgj0Bilpu4XGjGo5oWvXQ4d1UV16mfA
   Mqy5WkYfKRPp4JfzbfX5US0tPdJ/3oXcFneuBS4aboFFQpIXBppprk6hM
   40+kkvDTx4Cx4Z2FaDiUNNJju8n9NsDFfBitrVGZzo37qYJ4b79vDGU6Y
   BHUNqZbVOu0hbLNyeEJEK5pYQXybnFNYmm3vGUGi7EawYecf46ZaWQ3Nc
   Zk/68Q6GvJRLJtzdkRtNms2dd7YvQfywkzbgqTwmspHtO5nh+sE2XPykD
   g==;
X-CSE-ConnectionGUID: J8kr8G9TRbu+J4fkUk6AIA==
X-CSE-MsgGUID: 6W+uNhu2TF6/OyNnIPHDrg==
X-IronPort-AV: E=McAfee;i="6800,10657,11826"; a="100598682"
X-IronPort-AV: E=Sophos;i="6.24,222,1774335600"; 
   d="scan'208";a="100598682"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2026 02:10:00 -0700
X-CSE-ConnectionGUID: KfwQPapZRiWPbZUEA0FmyA==
X-CSE-MsgGUID: +m2B6kc9RUybhaFhj3Nsrw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,222,1774335600"; 
   d="scan'208";a="279938649"
Received: from amilburn-desk.amilburn-desk (HELO localhost) ([10.245.244.147])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2026 02:09:58 -0700
From: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
To: Intel graphics driver community testing & development <intel-gfx@lists.freedesktop.org>
Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Martin Hodo <martin.hodo@intel.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Simona Vetter <simona.vetter@ffwll.ch>,
	stable@vger.kernel.org
Subject: [PATCH] drm/i915: Return NULL on error in active_instance
Date: Wed, 24 Jun 2026 12:09:40 +0300
Message-ID: <20260624090940.74840-1-joonas.lahtinen@linux.intel.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Avoid returning &node->base when node is NULL due to OOM
during GFP_ATOMIC allocation.

Discovered using AI-assisted static analysis confirmed by
Intel Product Security.

Reported-by: Martin Hodo <martin.hodo@intel.com>
Fixes: bfaae47db3c0 ("drm/i915: make lockdep slightly happier about execbuf.")
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Cc: Simona Vetter <simona.vetter@ffwll.ch>
Cc: <stable@vger.kernel.org> # v5.13+
Signed-off-by: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
---
 drivers/gpu/drm/i915/i915_active.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/i915_active.c b/drivers/gpu/drm/i915/i915_active.c
index 5cb7a72774a0..aa77def0bc0d 100644
--- a/drivers/gpu/drm/i915/i915_active.c
+++ b/drivers/gpu/drm/i915/i915_active.c
@@ -318,7 +318,7 @@ active_instance(struct i915_active *ref, u64 idx)
 	 */
 	node = kmem_cache_alloc(slab_cache, GFP_ATOMIC);
 	if (!node)
-		goto out;
+		goto err;
 
 	__i915_active_fence_init(&node->base, NULL, node_retire);
 	node->ref = ref;
@@ -332,6 +332,11 @@ active_instance(struct i915_active *ref, u64 idx)
 	spin_unlock_irq(&ref->tree_lock);
 
 	return &node->base;
+
+err:
+	spin_unlock_irq(&ref->tree_lock);
+
+	return NULL;
 }
 
 void __i915_active_init(struct i915_active *ref,
-- 
2.54.0

