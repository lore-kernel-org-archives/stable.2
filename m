Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A84CF4657F2
	for <stable@vger.kernel.org>; Fri, 16 Oct 2026 13:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792157760; cv=none; b=b7khVixo3kPzWaFz/PqrqShe4OiBr2kwFK+SXsg+dvR6QAS+R1JgxelMS+tYndHm3nk2JHBQe3FLpxrNxRmejXhOfpPhcqyA4uQkIj8KK90FeVrR8qzBTbSTtrE7aDcoHm4CR0fWGZ1TEtZ+DE2DaZ33glOkmQ2YjaSlGKfumcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792157760; c=relaxed/simple;
	bh=TZPKnHzmnPvR+pTdU/JKk7q6aoJOo0mB+2Y59rx1Fn0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qUlYa84jG+RottvPiHU3vbH8uOLsPsjuERhFSlRoqZ+/86QwJKx7sAUG96wpwZAni0MlpXxyjPAfDRO3pf24NM2ERGLNzD4az+JnT2PCtwySSJlil/uP43lZg6/TsdKohIoRa3PsW6Xw9qac9s8ASUq8olUYsZDmSOW2XJUWuLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WNAr9ahE; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WNAr9ahE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792157759; x=1823693759;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TZPKnHzmnPvR+pTdU/JKk7q6aoJOo0mB+2Y59rx1Fn0=;
  b=WNAr9ahEfcBH1X/VAqS1v3YdF5ZnNmugaB2CCBciZenKsAdYWQa0zqsa
   GW2OQIDlNawjet4tgrrz0ZiVgnkIcL6GVyVOu/U6rQ5a2aDLoAxJ2kL/v
   yqe+xmLgNechQPvP0PrNDXXkFHFm+7xXlCATjbpaPYcflXFvpl9mdL8JL
   tJZKEAvKhWceDjx4FSbkqbgwlDWlI76Gb5OT5e08WKtnQkOHCjVYNUUYv
   YwKuLSB70VWiwoUKY+hkWF6xW/bxJmfAJmTzIrkEvx8TEd6iIW76qrxXE
   N5p1k6SqaJbkw88CPMPIg+r3mKDiWFvxiWOj3P5DMNazppPxwDn6k9LWm
   g==;
X-CSE-ConnectionGUID: B+Ksr0CGSoC2QyPOCSg7Hw==
X-CSE-MsgGUID: 3F11UQVgQ3qgAC2gWCJ7Bw==
X-IronPort-AV: E=McAfee;i="6800,10657,11936"; a="831443"
X-IronPort-AV: E=Sophos;i="6.27,161,1787036400"; 
   d="scan'208";a="831443"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2026 06:35:58 -0700
X-CSE-ConnectionGUID: 39geqrgSQLO7YnmFDslMYg==
X-CSE-MsgGUID: JAMgY4FHRiyIEEdPtuhI2w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,161,1787036400"; 
   d="scan'208";a="2273469"
Received: from abityuts-desk1.ger.corp.intel.com (HELO fedora) ([10.245.245.54])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2026 06:35:56 -0700
From: =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>
To: intel-xe@lists.freedesktop.org
Cc: =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	stable@vger.kernel.org,
	Matthew Auld <matthew.auld@intel.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Subject: [PATCH v4 1/4] drm/xe: Don't abort the shrinker walk on -EBUSY
Date: Fri, 16 Oct 2026 15:35:20 +0200
Message-ID: <20261016133523.3622-2-thomas.hellstrom@linux.intel.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261016133523.3622-1-thomas.hellstrom@linux.intel.com>
References: <20261016133523.3622-1-thomas.hellstrom@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

xe_bo_shrink() returns -EBUSY for bos that can't currently be shrunk,
for example imported dma-bufs, bos whose vm is currently validating,
bos that are still busy after the wait timeout, or bos whose backup
fails. The shrinker LRU walk treats any negative return value as
fatal and aborts, which also skips the remaining shrinker passes.

As a result, a single such bo, like an imported dma-buf on the
XE_PL_TT LRU, prevents reclaim of all bos behind it on the LRU.

Skip bos for which xe_bo_shrink() returns -EBUSY and continue the
walk, like the TTM LRU walk does.

v4:
- Patch introduced.

Fixes: 00c8efc3180f ("drm/xe: Add a shrinker for xe bos")
Cc: Christian König <christian.koenig@amd.com>
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: intel-xe@lists.freedesktop.org
Cc: <stable@vger.kernel.org> # v6.15+
Assisted-by: LLM
Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
---
 drivers/gpu/drm/xe/xe_shrinker.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/xe/xe_shrinker.c b/drivers/gpu/drm/xe/xe_shrinker.c
index deb4378c1ec1..4e4da76936f4 100644
--- a/drivers/gpu/drm/xe/xe_shrinker.c
+++ b/drivers/gpu/drm/xe/xe_shrinker.c
@@ -113,6 +113,9 @@ static int __xe_shrinker_walk(struct xe_shrinker *shrinker,
 				continue;
 
 			lret = xe_bo_shrink(ctx, ttm_bo, flags, scanned);
+			/* Like the TTM LRU walk, skip bos we can't shrink now. */
+			if (lret == -EBUSY)
+				continue;
 			if (lret < 0) {
 				ret = lret;
 				goto out;
-- 
2.56.0

