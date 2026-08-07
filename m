Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52B67306498
	for <stable@vger.kernel.org>; Fri,  7 Aug 2026 17:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786123053; cv=none; b=ZJmwVpWZyZnWnU0uwi6tyBgm63go458AzHQUQByEvP+fI/OU2J8ZM22FG97mnFenKVi2UkLq3/03IsuTEh+GhahKMfJRkf5SYG6z7Rns2Oc8jrIeZSW6zeDC1zKXLDkutwQjib0bx7N/dZkaGH+E50lL04BXqUmChEbiPvFgZVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786123053; c=relaxed/simple;
	bh=utPtG9QR5HF6vRWJ22fYPBYfKIDFp7t1P0czkkxfnho=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Etimqq16grrZk7Fi4JUye5Te4m0jl/+iLx0Weii3LSJM9M92LI3mU175iS3i6XO9jQh04W9NrJy1PyzrV8jIbNNQ7rzuakCNW5tCdqbpUrCqTAIwC/LYdzAH1Uws5KmPXeO7mlVJGdsJQ9YB2O+sABktq32qErKVNKlb69CA2Dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kmO1CSDt; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kmO1CSDt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786123050; x=1817659050;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=utPtG9QR5HF6vRWJ22fYPBYfKIDFp7t1P0czkkxfnho=;
  b=kmO1CSDt7FRafOKJ0ZLKOx8iyCOMWhUsR2cIZv9r7abkChKqI4LJ+ogK
   5SJ5FXNLPqYb9ApjhpVn8KZjPULkWOznslh64AMUnfw+6n+MrP9yTNdIX
   1XOD/Dv1dV0kkSuLGq0WIP22Zuj/MR2LCSbcR5195Bf7NRNEyuDNYSWCC
   tGlaNcVf4qWZg1W224vNAUCZA4SkxA9c7a21f4z/rslu4RCM2CW9HAfUP
   7S778CXftAZBIXUtYR3zITRxxEiNrJbLLLILhsgjnRtjx8yX5PKLhgV3l
   SH2AbQFGAWL79mwci/nEbJfkeYlfDN3Cw+97srF6QHbGBFrJ2pQzh4wmY
   g==;
X-CSE-ConnectionGUID: L+O5GGh2TSSLB4PO8YgNNQ==
X-CSE-MsgGUID: A7DdkliHS2WxMxLpMMz2/Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11868"; a="97088140"
X-IronPort-AV: E=Sophos;i="6.25,210,1779174000"; 
   d="scan'208";a="97088140"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2026 10:17:29 -0700
X-CSE-ConnectionGUID: 3KdmniPKTsG1LkD3ZRim3w==
X-CSE-MsgGUID: cm1SZcrNQcOcEZjKUkUJUg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,210,1779174000"; 
   d="scan'208";a="258150245"
Received: from gsse-cloud1.jf.intel.com ([10.54.39.91])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2026 10:17:29 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: intel-xe@lists.freedesktop.org
Cc: stable@vger.kernel.org
Subject: [PATCH] drm/xe: Order ring writes before ring tail updates
Date: Fri,  7 Aug 2026 10:17:16 -0700
Message-Id: <20260807171716.140475-1-matthew.brost@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ring buffer and the LRC context image are both mapped WC, so the ring
tail update can become visible to the device before the ring contents it
is meant to publish.

The GuC CT send does contain an xe_device_wmb(), so sending the H2G would
flush the ring contents. The problem is that it comes too late:
xe_lrc_set_ring_tail() publishes the tail before the H2G is sent, and the
device samples the tail from the context image independently of it, either
at context switch-in or while the context is already resident. A submitter
which is interrupted between updating the tail and sending its H2G
therefore leaves the device free to observe the new tail while the ring
contents behind it are not yet visible:

  1. Thread A emits a job into the ring, sets the tail to T_A and sends
     the H2G, which flushes A's ring contents. The GuC starts scheduling
     the context in, but it is not executing yet.
  2. Thread B emits a job into ring[T_A..T_B]. Those writes are not yet
     visible to the device.
  3. Thread B updates the ring tail to T_B. That write targets a
     different page and becomes visible first.
  4. Thread B is interrupted before it sends its H2G, so the flush which
     would have published ring[T_A..T_B] has not happened yet.
  5. The context is switched in and samples the ring tail from the
     context image, picking up T_B rather than T_A.
  6. The GPU executes A's job, advances HEAD to T_A, and continues on to
     ring[T_A..T_B], which still holds the previous wrap's contents, so
     the CS parses stale commands.

The result is command stream corruption, which typically manifests as a
hang or a spurious pagefault rather than anything that points back at the
submission path.

Kernel jobs are by far the most likely to hit this. Kernel queues such as
the migration queue are shared and can be driven by many threads
concurrently, producing back-to-back submissions on an LRC which is
already executing. User queues are typically tied to a single submitting
thread, so the same interleaving is much harder to produce.

Add an xe_device_wmb() at the end of xe_lrc_write_ring() so that it covers
every ring tail publication site, and so the invariant is local: once
xe_lrc_write_ring() returns, the ring contents are visible to the device.

Fixes: dd08ebf6c352 ("drm/xe: Introduce a new DRM driver for Intel GPUs")
Closes: https://gitlab.freedesktop.org/drm/xe/kernel/-/work_items/8651
Closes: https://gitlab.freedesktop.org/drm/xe/kernel/-/work_items/7810
Cc: stable@vger.kernel.org
Signed-off-by: Matthew Brost <matthew.brost@intel.com>
Assisted-by: GitHub_Copilot:claude-opus-5
---
 drivers/gpu/drm/xe/xe_lrc.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/xe/xe_lrc.c b/drivers/gpu/drm/xe/xe_lrc.c
index 01d087e82205..a332c11420fd 100644
--- a/drivers/gpu/drm/xe/xe_lrc.c
+++ b/drivers/gpu/drm/xe/xe_lrc.c
@@ -1851,6 +1851,13 @@ void xe_lrc_write_ring(struct xe_lrc *lrc, const void *data, size_t size)
 
 		__xe_lrc_write_ring(lrc, ring, &noop, sizeof(noop));
 	}
+
+	/*
+	 * The ring and the LRC context image are both WC, so the ring tail
+	 * update which publishes these writes can become visible to the device
+	 * first. Ensure the ring contents are visible before returning.
+	 */
+	xe_device_wmb(xe);
 }
 
 u64 xe_lrc_descriptor(struct xe_lrc *lrc)
-- 
2.34.1

