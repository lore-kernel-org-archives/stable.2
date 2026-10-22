Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792690872;
	b=cIVuwpNXiLJRn5RPuluTbVdpojAbui96pBOjWzzJyVSy74DYGOZtK5ac+k1TJcsg19TI
	 5iXaDILhVRWRWJ9/DPRqEXRfZVSXKB2X/j2A0dVY60m/4Xeg5xnW0qoPkaPR5XF44DTgH
	 Jwp3ov87t7IW6aLpNZiiV+HDgj6o+4+VD5Ei9bEEkh5qlKdQzrBjg8o/y1Gru1EPX3qvC
	 22knFYl+USESf/G+HO/8Q8os+g+O9VTaSix6i4D2vQKK1Er8WNG89+xP07lVBdtGdsxnP
	 nkfmq1ZAhkv0Q3sWjiCYa6vvMefvi+GYkEadBf6Cl+r0e4OJStjbWfCvaX1JbkPpuAw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792690872;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=cDla6l8fMfj8jJdamp45SxPiawr5zChOQJjC1LHk/iY=;
	b=5b5MwH4z28otasmRmqsQay0BUv1TlX/XvLqx6WgJRuNl78Sj/ITRbnbJgbzqyNduW8K/
	 T254xmEi8HaLbnKp7O8820m/rj70Apm7n/vQeBB8W7Dt6Sa/RzFHOoJsjOGrq3xojYb4V
	 7pXmNiFI6HyA/rgH+NaJXNtJAQnmHc4hoEMIFo1GYO3Bf+6dXZX7VMuypqMPNXh3ul4iB
	 mwu5Vt1bX/ueCFegKO4jhzylPgN+UT6q+eel6rCtxSRHkOzeRKFtmfvyYW/sAJfWkZLw4
	 DW7ArXN0pfPwskMLIuQ7W+BcK6MED7mTOMf65ADH74OvWNO+lTOH6mYy5qTk+Ou/DNA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=dMlzGX5d;
	arc=none smtp.remote-ip=198.175.65.16
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B351606A31D
	for <stable@vger.kernel.org>; Thu, 22 Oct 2026 17:41:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4B351606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=dMlzGX5d
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792690871; x=1824226871;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=i0sUBTn7zZHjGdLUQOGsSLgWeN2sedvkN870GTcfR8E=;
  b=dMlzGX5dAlyael9969AcLBzT0WLcnRwPnB08n6kmuOf7Z4t/2X4jOij8
   dk5lRFR3+iEOcuOMbod2uIlmFKwxrctV4r68mnHkUEldZJ/8bFkln7881
   CbYO+Gm3qdGYIViprCLG1NAw1VSPwubAJ3Dwm2BIk1aBjFjAKRGgoENtv
   T6wJ2bnx+p4wRnKuK4OXWwua+7WFkNkNQsgzJIY/YX/bHzR+BvjGVq93c
   jTgGDJhvGJ3skLhH4BOm5g8WaScOxJ0wtWZMKI6owcY7z5O4dqX6U2BWM
   VV53UH8dEkOYiCUj65NO4Cak90zaAqh66VVabsQO8NrgFUT6HkChsPiVZ
   Q==;
X-CSE-ConnectionGUID: 2iiru1XEQd6uHDq+E4DpZg==
X-CSE-MsgGUID: 49OdYG0QRRqoEHvtpBYhEw==
X-IronPort-AV: E=McAfee;i="6800,10657,11942"; a="1435958"
X-IronPort-AV: E=Sophos;i="6.27,172,1787036400"; 
   d="scan'208";a="1435958"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2026 10:41:10 -0700
X-CSE-ConnectionGUID: tO/Bvy6VRjqyvYDaKkdhrA==
X-CSE-MsgGUID: Mjcx5rxVS9W868FwUvC7Bg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,172,1787036400"; 
   d="scan'208";a="3366104"
Received: from abityuts-desk1.ger.corp.intel.com (HELO mwauld-desk.intel.com) ([10.245.245.243])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2026 10:41:09 -0700
From: Matthew Auld <matthew.auld@intel.com>
To: intel-xe@lists.freedesktop.org
Cc: =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Matthew Brost <matthew.brost@intel.com>,
	stable@vger.kernel.org
Subject: [PATCH 1/2] drm/xe/sa: make suballocator waits uninterruptible
Date: Thu, 22 Oct 2026 18:41:00 +0100
Message-ID: <20261022174058.226432-5-matthew.auld@intel.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261022174058.226432-4-matthew.auld@intel.com>
References: <20261022174058.226432-4-matthew.auld@intel.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Large BO clears and copies in xe_migrate_clear() and xe_migrate_copy()
are split into multiple passes, each needing a batchbuffer from the
fixed size kernel bb pool. Once the pool fills up, __xe_sa_bo_new()
waits interruptibly for space, so a pending signal (e.g. Xorg's 5ms
SIGALRM smart-scheduler timer) makes it fail mid-loop with -ERESTARTSYS.
The partial progress is then thrown away and the restarted ioctl starts
again from byte 0, including the memory allocation, which can livelock
if the signal arrives faster than the whole operation completes. In the
shrinker path the same error also aborts the shrinker walk, even though
ctx->interruptible is false.

Being interruptible here doesn't seem to buy much anyway: on error
the loop already waits uninterruptibly for all submitted passes before
returning. So just make the suballocator waits uninterruptible, matching
amdgpu and radeon. The other users (page reclaim from a kworker, and the
GuC buffer cache) shouldn't really see any meaningful change.

Assisted-by: LLM
Link: https://gitlab.freedesktop.org/drm/xe/kernel/-/work_items/9644
Fixes: dd08ebf6c352 ("drm/xe: Introduce a new DRM driver for Intel GPUs")
Signed-off-by: Matthew Auld <matthew.auld@intel.com>
Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: <stable@vger.kernel.org> # v6.12+
---
 drivers/gpu/drm/xe/xe_sa.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_sa.c b/drivers/gpu/drm/xe/xe_sa.c
index f32045f40b7a..d9c2b28b08c2 100644
--- a/drivers/gpu/drm/xe/xe_sa.c
+++ b/drivers/gpu/drm/xe/xe_sa.c
@@ -165,7 +165,8 @@ void xe_sa_bo_sync_shadow(struct drm_suballoc *sa_bo)
  * @size: number of bytes we want to suballocate
  * @gfp: gfp flags used for memory allocation. Typically GFP_KERNEL.
  *
- * Try to make a suballocation of size @size.
+ * Try to make a suballocation of size @size. Any waits for space are
+ * uninterruptible.
  *
  * Return: a &drm_suballoc, or an ERR_PTR.
  */
@@ -178,7 +179,7 @@ struct drm_suballoc *__xe_sa_bo_new(struct xe_sa_manager *sa_manager, u32 size,
 	if (size > sa_manager->base.size)
 		return ERR_PTR(-ENOBUFS);
 
-	return drm_suballoc_new(&sa_manager->base, size, gfp, true, 0);
+	return drm_suballoc_new(&sa_manager->base, size, gfp, false, 0);
 }
 
 /**
-- 
2.56.0

