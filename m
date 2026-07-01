Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAFBB3C108A
	for <stable@vger.kernel.org>; Wed,  1 Jul 2026 07:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782892591; cv=none; b=lng132c856ToWGXzhM3Dq+1d3Aqn0t9E/yGtJyVxGUY9JNFEj0udW8u8S399rG6OEwvyft4NrBbSArDUZCeHmldYwd/dG86UYoRJrm42jj5lpRJOO/Rv5Bvt6ryiGBRq6PaL826G+cjp5lX3QA5D5J4dItaSxpdZDYD1CaHWEzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782892591; c=relaxed/simple;
	bh=cGLe2jx75wNr3SO1dAi4HYYNNyZgWcKZdidD0DgIzm4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=L2ZaTVOEdeFe7ArMy8kEI3zMujq7HgvlpVYdQDWO4fbFDkdvz82f/3G6/bhlIpqozzT3EOrrdTUOoxCzZvltJNT3UEkhDrTw2tmcP90OLzDlW9QVYhIQ5wSHqCxJ5A29TplzYqAYPuBii8ur94Eu3GT3KgLfmjKdXQ4h0ycKzQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OBGgrITF; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OBGgrITF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782892590; x=1814428590;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=cGLe2jx75wNr3SO1dAi4HYYNNyZgWcKZdidD0DgIzm4=;
  b=OBGgrITFjRvn8hIkMGeqZ6p4/2dBQTXkkIbI80nTYj1awkoppx0Fagx6
   /tn1NFVqa/8eXGOYFOugKb600J4MJ5PN2FmirgVXCG6aYEz66wFy8n+p7
   S8JUplBf5EXchfSsiWcwpKwCgQXhB33/487Z8iff7YVv0BprJn4xpUMQj
   E+RqWUQaBtsN1oVNta5A5OvQjpz5pBS35RafIpRVjaxjqBqIW5mAP9Bzy
   8P4dOtSdnlTpeur+zeSYFGHMM2n5bSQvpEB1za/wOIzjuzpNdG0zZbDeP
   M8n/Fr8vbe3Tj1cqoBZ8MsspFYeVgqKNnYqkQPW2jVkXIQbc4dUnJHIH5
   w==;
X-CSE-ConnectionGUID: OkzDEzZfQO6tcYW29CeTHA==
X-CSE-MsgGUID: DD6tIXO8QGOg/NyW2+YdyQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11833"; a="83489028"
X-IronPort-AV: E=Sophos;i="6.24,235,1774335600"; 
   d="scan'208";a="83489028"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2026 00:56:29 -0700
X-CSE-ConnectionGUID: KrA5ud6sRq6dQjHeghZzPA==
X-CSE-MsgGUID: VBlF5NDCSt+kGDq48pNYbQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,235,1774335600"; 
   d="scan'208";a="250783155"
Received: from abityuts-desk.ger.corp.intel.com (HELO localhost) ([10.245.244.25])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2026 00:56:27 -0700
From: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
To: Intel graphics driver community testing & development <intel-gfx@lists.freedesktop.org>
Cc: Direct Rendering Infrastructure - Development <dri-devel@lists.freedesktop.org>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Martin Hodo <martin.hodo@intel.com>,
	Faith Ekstrand <faith.ekstrand@collabora.com>,
	Simona Vetter <simona.vetter@ffwll.ch>,
	Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	stable@vger.kernel.org
Subject: [PATCH] drm/i915/gem: Fix NULL deref in I915_CONTEXT_PARAM_SSEU
Date: Wed,  1 Jul 2026 10:55:55 +0300
Message-ID: <20260701075555.52142-1-joonas.lahtinen@linux.intel.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Setting context engine slot N into I915_ENGINE_CLASS_INVALID /
I915_ENGINE_CLASS_INVALID_NONE and attempting to apply
I915_CONTEXT_PARAM_SSEU to the same slot N will deref NULL.
Fix that.

Discovered using AI-assisted static analysis confirmed by
Intel Product Security.

Reported-by: Martin Hodo <martin.hodo@intel.com>
Fixes: d4433c7600f7 ("drm/i915/gem: Use the proto-context to handle create parameters (v5)")
Cc: Faith Ekstrand <faith.ekstrand@collabora.com>
Cc: Simona Vetter <simona.vetter@ffwll.ch>
Cc: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: <stable@vger.kernel.org> # v5.15+
Signed-off-by: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
---
 drivers/gpu/drm/i915/gem/i915_gem_context.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/gem/i915_gem_context.c b/drivers/gpu/drm/i915/gem/i915_gem_context.c
index aeafe1742d30..347d1f2c05f5 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_context.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_context.c
@@ -850,7 +850,7 @@ static int set_proto_ctx_sseu(struct drm_i915_file_private *fpriv,
 		pe = &pc->user_engines[idx];
 
 		/* Only render engine supports RPCS configuration. */
-		if (pe->engine->class != RENDER_CLASS)
+		if (!pe->engine || pe->engine->class != RENDER_CLASS)
 			return -EINVAL;
 
 		sseu = &pe->sseu;
-- 
2.54.0

