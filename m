Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 148D725776
	for <stable@vger.kernel.org>; Tue,  1 Sep 2026 03:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788233533; cv=none; b=OJxiusAMEEIiELyjRgpNhI2dh4DNz/Udq+JSkMEAn3QQkIpkExDAJo+Etk9BZxcE8Bj5lksNN7FyzxA81ju+G3/JeAMeLBnOaz2P8QVxTQ6ecM2Y+eoPKGc9uqJbiolYXr68Ns7Gldwsi1Mstzfk+92Fa3LEuiUTu8CTz8MuRD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788233533; c=relaxed/simple;
	bh=EG7MnfTLdxLeOKYIVnkrgU6zGF+VwXWONTK8wdbYWKU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=teNpyxmtxqey5P0R0mA+tV0O1+V5qw9hUjf/Zcp2n4AX9TCtJgb99qqHfYL1DK3gTw1g6BDLGDWbkhgz0SgQVnjdKnC5PzCopGciVVzlHcenUaX4ydCW0MWjtLXTCNeYS1F4Tua1jdhL5lYjMHCZAK13V31xe8WjEJ1kzqDQITk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i8PjPrXE; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i8PjPrXE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788233531; x=1819769531;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EG7MnfTLdxLeOKYIVnkrgU6zGF+VwXWONTK8wdbYWKU=;
  b=i8PjPrXEagJfTWxyfaB8sP1uAVCw0lL/4W1DW0eYYfwSGRhX9RaO5z+R
   JiEkNVrrkcX6jx4fZMkg5zMoMg78jwgqTB1wV8CUlvQukWnpu8vn6vF80
   9hN558pcH6SMfNrijGGW75Q6v6W3iubM+mnqK7plKmpdWfb/s8DdYBFN4
   7ytOn0ed8enP/L+1L7hc8lz+Zof8ata8ETgTaQASYbVe5swdbcCGtrcsJ
   dVXOuMdnTAWH29B47VIt88UxFgjp9HyoZvd9B4mBSBXR648gnkxRCPWZr
   /LpN27PR5H9DkUPSiPbKhUxZ90wEfwrujIS7ggRKX0Os2whVkgrDqE2Hu
   A==;
X-CSE-ConnectionGUID: 9nYKBTWYST6MdHrr2Hqkdg==
X-CSE-MsgGUID: 537kQnizSQWjGa+3nIZy9A==
X-IronPort-AV: E=McAfee;i="6800,10657,11892"; a="99249704"
X-IronPort-AV: E=Sophos;i="6.25,255,1779174000"; 
   d="scan'208";a="99249704"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2026 20:32:10 -0700
X-CSE-ConnectionGUID: 1FI7gDOxQc2r4cxOvHaGwQ==
X-CSE-MsgGUID: Phu/lA9qS8Gq02GeMsyyPA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,255,1779174000"; 
   d="scan'208";a="264685142"
Received: from osgcshtiger.sh.intel.com ([10.239.81.49])
  by fmviesa006.fm.intel.com with ESMTP; 31 Aug 2026 20:32:08 -0700
From: Shuicheng Lin <shuicheng.lin@intel.com>
To: intel-xe@lists.freedesktop.org
Cc: Shuicheng Lin <shuicheng.lin@intel.com>,
	Sashiko <sashiko-bot@kernel.org>,
	stable@vger.kernel.org,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Matthew Brost <matthew.brost@intel.com>
Subject: [PATCH v4 1/2] drm/xe/shrinker: Do not abort the walk on unshrinkable bos
Date: Tue,  1 Sep 2026 03:31:52 +0000
Message-Id: <20260901033153.219481-2-shuicheng.lin@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260901033153.219481-1-shuicheng.lin@intel.com>
References: <20260901033153.219481-1-shuicheng.lin@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

xe_bo_shrink() returns -EBUSY for a bo that is simply not a candidate:
a kernel bo, a non-purgeable bo during the purge pass, or one that is
not eviction valuable.  ttm_bo_shrink_suitable() does not filter those
out, so __xe_shrinker_walk() ends the walk at the first one it meets and
returns the error in place of the pages it had already freed.

xe_shrinker_walk() re-enters the walk for each escalation level, so the
remaining bos are usually still reached and the effect is repeated
restarts rather than lost reclaim.

Skip the bo on -EBUSY and keep walking, and on a real error report what
was already freed rather than dropping it.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Fixes: 00c8efc3180f ("drm/xe: Add a shrinker for xe bos")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-5
Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Cc: Matthew Brost <matthew.brost@intel.com>
Signed-off-by: Shuicheng Lin <shuicheng.lin@intel.com>
---
 drivers/gpu/drm/xe/xe_shrinker.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/xe/xe_shrinker.c b/drivers/gpu/drm/xe/xe_shrinker.c
index 83374cd57660..953a911b51b3 100644
--- a/drivers/gpu/drm/xe/xe_shrinker.c
+++ b/drivers/gpu/drm/xe/xe_shrinker.c
@@ -79,8 +79,10 @@ static s64 __xe_shrinker_walk(struct xe_device *xe,
 				continue;
 
 			lret = xe_bo_shrink(ctx, ttm_bo, flags, scanned);
+			if (lret == -EBUSY)
+				continue;
 			if (lret < 0)
-				return lret;
+				return freed ? freed : lret;
 
 			freed += lret;
 			if (*scanned >= to_scan)
-- 
2.43.0

