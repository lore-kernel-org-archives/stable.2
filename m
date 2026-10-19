Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F7EB4B95C3
	for <stable@vger.kernel.org>; Mon, 19 Oct 2026 09:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792403850; cv=none; b=k0x27u1HmvlwRbDVVYMVYxq7j8eAEkXCjY4rIvyJxdqC2nx/vwnQrilQLYihue/A/iwZVSKuJ7qWMqtoCblhvyM4+GhW2Mh9FeH0DeA4sgNaOey0yaSWypqoVVP+uxni9zL9DZLthj/ptSSqntuc/DyjImgVhzNefKvd/wmFzAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792403850; c=relaxed/simple;
	bh=KJeJM3gxfreMXiixJCWA1ycRN1hcsKmMejGObncFlbE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Dp90FGr1st3+47fFAWzMrsp2fAaN2vXypVGosFCgVD3RhGD1B9l79ayzrPvET+X59K+RDDGdyGcMfyE55IDIzyA0ZlGODy/89wOOObiaYVdeKwxKxKUMClQTkiEzyv/m/jgOY5Bwsmdq+58NrwAyqdzrReiU/W1AxWKpgJGHuMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c1tXfaub; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c1tXfaub"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792403849; x=1823939849;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KJeJM3gxfreMXiixJCWA1ycRN1hcsKmMejGObncFlbE=;
  b=c1tXfaub/gKaKgOHW+N4pIIPLbkjnKJaEpeHeMqrQ8uLxE8nPQhBKXDK
   kR2TOoS39HEwhx3vhCMxASg5H5lt+WkYgwQwCDS5Gh0TlUPlUfMAfln9T
   CVEJprY2fWoM+FXbzrDtI+xlGjRcVsEJ2imM9hpE4mJBEgkLEE+6LVcmM
   9K6nBDJG/oJeJ5crs532SANfY3mI1CeDXt8cUmInKNo7p3136kXtkfBgM
   vDROB+nbatUej7Wy8gvzqT40hE6fzirPHBWinsHUtyac6lejKQmyARWwn
   rDSTLyOGPuiVL+rBc2s+Jkvp7cmJYYJsiT9pHGaoosiqyokd3snpnS1QE
   A==;
X-CSE-ConnectionGUID: pgIUNIxUSA+uZtSlJiG+Lw==
X-CSE-MsgGUID: sCSCP0qARpunfs7fDVvg2A==
X-IronPort-AV: E=McAfee;i="6800,10657,11939"; a="1094999"
X-IronPort-AV: E=Sophos;i="6.27,167,1787036400"; 
   d="scan'208";a="1094999"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2026 02:57:28 -0700
X-CSE-ConnectionGUID: S2zMtUBXTbCrpS5NcUghLQ==
X-CSE-MsgGUID: t18z5ShaRPac6VJmzEvMNA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,167,1787036400"; 
   d="scan'208";a="2553640"
Received: from jkrzyszt-mobl2.ger.corp.intel.com (HELO fedora) ([10.245.244.14])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2026 02:57:25 -0700
From: =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>
To: intel-xe@lists.freedesktop.org
Cc: =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	stable@vger.kernel.org,
	Matthew Auld <matthew.auld@intel.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Subject: [PATCH v5 1/4] drm/xe: Don't abort the shrinker walk on -EBUSY
Date: Mon, 19 Oct 2026 11:56:52 +0200
Message-ID: <20261019095655.3501-2-thomas.hellstrom@linux.intel.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261019095655.3501-1-thomas.hellstrom@linux.intel.com>
References: <20261019095655.3501-1-thomas.hellstrom@linux.intel.com>
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
Reviewed-by: Matthew Brost <matthew.brost@intel.com>
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

