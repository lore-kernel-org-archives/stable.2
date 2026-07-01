Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A28D37AA81
	for <stable@vger.kernel.org>; Wed,  1 Jul 2026 07:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782891043; cv=none; b=UXBCC+wACOYUSATGOcnkXwSgiaiVpvMWoQ3loKo1TqHslQnEUF7ucgmxDvlIlg0J1Q0EiMpRTdcFWzmv72gyuXTC935/FFm436g90ra+gCbNL+FFOv565D5oLfM/N4so0vFJoE16FkLIePqrmILM/XNwVXwhhDKdVP24dmOT/Rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782891043; c=relaxed/simple;
	bh=OYZHIPEYhfsH8T3WnWawsBUJdLa7fxv2rMb2oeqcjf4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sUxuX03KgcPTCJ8A6gsFBhVU5uydQGX/werkQpqD6P552n182Ts+j9jNRlFlCyZs15QheNEJ4J5ZqJ+Dz88oUH5HtPP2mZtzVbHaLqc2+HF6cfGB+cIADUKLnMaZ+ohso6XUkD/KgGDUO7QVf3ekFH8VI9ipYDt5/2WesHSaSrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GpCd+XdB; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GpCd+XdB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782891041; x=1814427041;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=OYZHIPEYhfsH8T3WnWawsBUJdLa7fxv2rMb2oeqcjf4=;
  b=GpCd+XdBX2A3evL7kB5aLasNMspqJesyS/itM1KfFkMIu4zWD5t5vKU7
   GvZZ7qN/oLlJs50vmi8uS5Rruz2tLun6Tdu+uKWFTttkSyOOvHLQ4V0tT
   EBYQkCGJo3HEjbrn8e9NCv3cwZYuRdBCJruE6ELwMZsO8tPYGdQxUjpYg
   e0dlT3MSlASU1UzXt7V7l3Ivp6QlD667uinGvRFtAfN1iMWOWqz0uzmsD
   Ac7I/tivvojSeReB8NuPlqXeHGsg3k1bALGCLhXknC1Ewf9soehG4Z0ac
   xowlFdD+SuIibhm8iG/82/CJBRyuBln8qv/Eh0dtl/5D/Sc2Q12DlaXAj
   g==;
X-CSE-ConnectionGUID: TImtRMpjSSytqPa3OSD2ew==
X-CSE-MsgGUID: wlVqZtkZSwu3rmprBok7Zg==
X-IronPort-AV: E=McAfee;i="6800,10657,11833"; a="94996795"
X-IronPort-AV: E=Sophos;i="6.24,235,1774335600"; 
   d="scan'208";a="94996795"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2026 00:30:40 -0700
X-CSE-ConnectionGUID: IEWKBaZ+TW+Od+RCPtAZMQ==
X-CSE-MsgGUID: jDGjoYNlTJmF5eatM12dSw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,235,1774335600"; 
   d="scan'208";a="276792913"
Received: from abityuts-desk.ger.corp.intel.com (HELO localhost) ([10.245.244.25])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2026 00:30:37 -0700
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
Subject: [PATCH] drm/i915/gem: Do not leak siblings[] on proto context error
Date: Wed,  1 Jul 2026 10:30:30 +0300
Message-ID: <20260701073030.44850-1-joonas.lahtinen@linux.intel.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After a successful BALANCE/PARALLEL_SUBMIT extension on context
creation, error during processing of next user extension leaks
the siblings[] array. Fix that.

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
 drivers/gpu/drm/i915/gem/i915_gem_context.c | 22 +++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/i915/gem/i915_gem_context.c b/drivers/gpu/drm/i915/gem/i915_gem_context.c
index aeafe1742d30..87fce2adfeef 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_context.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_context.c
@@ -769,8 +769,8 @@ static int set_proto_ctx_engines(struct drm_i915_file_private *fpriv,
 		struct intel_engine_cs *engine;
 
 		if (copy_from_user(&ci, &user->engines[n], sizeof(ci))) {
-			kfree(set.engines);
-			return -EFAULT;
+			err = -EFAULT;
+			goto err;
 		}
 
 		memset(&set.engines[n], 0, sizeof(set.engines[n]));
@@ -786,8 +786,8 @@ static int set_proto_ctx_engines(struct drm_i915_file_private *fpriv,
 			drm_dbg(&i915->drm,
 				"Invalid engine[%d]: { class:%d, instance:%d }\n",
 				n, ci.engine_class, ci.engine_instance);
-			kfree(set.engines);
-			return -ENOENT;
+			err = -ENOENT;
+			goto err;
 		}
 
 		set.engines[n].type = I915_GEM_ENGINE_TYPE_PHYSICAL;
@@ -800,15 +800,21 @@ static int set_proto_ctx_engines(struct drm_i915_file_private *fpriv,
 					   set_proto_ctx_engines_extensions,
 					   ARRAY_SIZE(set_proto_ctx_engines_extensions),
 					   &set);
-	if (err) {
-		kfree(set.engines);
-		return err;
-	}
+	if (err)
+		goto err_extensions;
 
 	pc->num_user_engines = set.num_engines;
 	pc->user_engines = set.engines;
 
 	return 0;
+
+err_extensions:
+	for (n = 0; n < set.num_engines; n++)
+		kfree(set.engines[n].siblings);
+err:
+	kfree(set.engines);
+
+	return err;
 }
 
 static int set_proto_ctx_sseu(struct drm_i915_file_private *fpriv,
-- 
2.54.0

