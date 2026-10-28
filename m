Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.8
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793221711;
	b=44bKMQGpB7iLbdBD8t/0D7CpYHLmh3EYqo+wWTqpYEAJaDYhBqz4N8eBi4cHZk0SG4RD
	 tGldnbH/coWu/6HuvX1In+TB7fnkjAekhMaMEGGKY/pEX6eqwKTRL/uSFbQvmsTLm+KT9
	 OIFId0ud0vgNHnxU2dbwsewcLeZAcz70zRORIxlaCBvGJFhN1h+EJPi3FFZcxcmJTziaa
	 Cl1zn54VxMX/dXtxe7j7APxvAo1bHRiG8/x1ydRtpXNjknv3WUxMUY6BtBXpo8q3tZ3zF
	 8omIDL6/AkC+u8/oeuK6Ul9M7rAITk6Mf0LfURBeoTgx5wdKrAHKHO+LSFE8vEIfeJQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793221711;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=Sl3kZqWx/+3pPQ92rSp1so9APOUKUCe99kg7pt8llhM=;
	b=C/Q8qgkoq2VbpnN+rtoewH9jdfp4aHosnTSuycMgOnTLQqBgMvR7N2WrjP27i3sgbRQO
	 /kwaVo0XRkymdCLcT6hsAX2YLfl0gk1t8W4Pq808/9tBvUgOJUN+q1ZceKuUIVmdSD+8y
	 k0TI6IapzmV/PALy+0JgvA2jSkRda96lPInYtrFfQDVp0ktWGONERJ29X0mgiVPGfV6tc
	 ms//Xt5pOFejy+/ALKy5T7N8wXHqoZtgoxxZCt2ilaQkE5GpQCQ+Mdd2VDt0ltGpgn4J+
	 RjBJwUiNb3AUs0V71dqjiDruVuydtI81wR2qoKKOQKzbUm01iKSChGhCm1PeVqnJHHA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=L4vO78vv;
	arc=none smtp.remote-ip=192.198.163.8
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2B0B606A31A
	for <stable@vger.kernel.org>; Wed, 28 Oct 2026 21:08:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D2B0B606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=L4vO78vv
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793221711; x=1824757711;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=JSqLMD0yJ9BsT8A5GHlX4cdSlzeO148Z4xyTPyvPHbg=;
  b=L4vO78vvgc9NhfJSIIXgVnX4kHCG8kRDGyAUosO9cUWAonztHfGdZ7Li
   bYI0TNCSSVWsO4DOW5mubUNarLiMP38+W8MLtqgzURdzeifYdW3rlAFSA
   j0Nxy/fH+yiGi2ZznEwbZ7lB1qFYwncbKkTZmZ54Vjd1WCg5IZTIoxWVQ
   RJfqrXOvFnonV2LQmR/wyF9s2X2gBb2fhPMmRedxgmcXqRUlUGB6bTjED
   zCdSPci+dXWn15ZhyuSqqi/mfC0o6ZqZkTW2GEuPuLLoCqvdIC/ZUOXYU
   uGSClCMeg1yHyt8vLNZ+sDIED9GIxGvW5voq/oS+molM8T2KRtF1ZJ4nd
   Q==;
X-CSE-ConnectionGUID: IXhsFmKTQtmHF+YOq8Ra9Q==
X-CSE-MsgGUID: AtSB6b3NQqKKHMPZXPmOmw==
X-IronPort-AV: E=McAfee;i="6800,10657,11949"; a="1848662"
X-IronPort-AV: E=Sophos;i="6.27,183,1787036400"; 
   d="scan'208";a="1848662"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2026 14:08:30 -0700
X-CSE-ConnectionGUID: +eg4jCc8TpWyGBl8bRlklg==
X-CSE-MsgGUID: FCTXz6KBSCeuIiMdf93UvQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,183,1787036400"; 
   d="scan'208";a="4811349"
Received: from aalteres-desk1.fm.intel.com ([10.121.64.173])
  by orviesa008.jf.intel.com with ESMTP; 28 Oct 2026 14:08:30 -0700
From: Alan Previn <alan.previn.teres.alexis@intel.com>
To: intel-gfx@lists.freedesktop.org
Cc: Alan Previn <alan.previn.teres.alexis@intel.com>,
	dri-devel@lists.freedesktop.org,
	Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>,
	stable@vger.kernel.org
Subject: [PATCH 1/1] drm/i915: Fix OOB access of reset_engine_count for compute class
Date: Wed, 28 Oct 2026 14:08:25 -0700
Message-ID: <20261028210828.433225-2-alan.previn.teres.alexis@intel.com>
X-Mailer: git-send-email 2.43.0
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

MAX_ENGINE_CLASS is the highest valid engine class value (COMPUTE_CLASS
== 5), not the number of classes. reset_engine_count[] was sized with
MAX_ENGINE_CLASS entries, so resetting a CCS engine incremented (and
i915_reset_engine_count() read) one element past the end of the array,
aliasing the adjacent field in drm_i915_private (suspend_count).

Size the array as MAX_ENGINE_CLASS + 1, consistent with other per-class
arrays such as intel_gt.engine_class[].

Fixes: cf9cb028ac56 ("drm/i915: Use internal class when counting engine resets")
Cc: <stable@vger.kernel.org>

Assisted-by: LLM
Signed-off-by: Alan Previn <alan.previn.teres.alexis@intel.com>
---
 drivers/gpu/drm/i915/i915_gpu_error.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/i915_gpu_error.h b/drivers/gpu/drm/i915/i915_gpu_error.h
index 26970c5e291e..e53139cb77ea 100644
--- a/drivers/gpu/drm/i915/i915_gpu_error.h
+++ b/drivers/gpu/drm/i915/i915_gpu_error.h
@@ -225,7 +225,7 @@ struct i915_gpu_error {
 	atomic_t reset_count;
 
 	/** Number of times an engine has been reset */
-	atomic_t reset_engine_count[MAX_ENGINE_CLASS];
+	atomic_t reset_engine_count[MAX_ENGINE_CLASS + 1];
 };
 
 struct drm_i915_error_state_buf {

base-commit: fbed42265ffde9b162e21ed7ff0cfce070e19aaa
-- 
2.43.0

