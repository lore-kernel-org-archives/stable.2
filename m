Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793607998;
	b=nbjijc0PlGX5lw4rNYJaev8dTIGPyPtx275We7+jVwYfQ6iY3Og/J+XH2gSMCiHdIhUW
	 8UaiMz6QwUP1BChlv2C5WXKrIbP0IUEtMREh4THEJ7JikxUni7P/sFQFCICnnAqvdg3Zt
	 X/VTUKItF8IfutmdKuKHq07C9h+hV22njYET/rxJ48toXqLHCfMj7zC9vIiXF2jhQ4fO1
	 ghaw3+NYabfzIq9PTX8en8av3FsgCnmWjvQV7jeiWtLQLoQksloVExKBo+iLziUyPY7Gh
	 Igd6/U5ylVx/SVuQ7wncSxsYA1he0j/evDwJPlIU9yGjmi7zphxBPEXDzzYCEmUXJwg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793607998;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=ra/0Z6Ruy1NBLQLcfzV5WQBLLHxX2KVQ0pJWS+NHvFQ=;
	b=FyNiQwi5WC6eo1HldPedfgxElYaxDtrUgm/AUhWKYp1XfbY0/7hLOKBfDQqki73JZPWh
	 M21qimgY4m3qjZZxfyndJbBU0rPE+EYT4lOaxaGxaaQxXNHf3wrvAAsw1DVDEv9MgDIMq
	 FKJRX7aCy2HCEWUEEQ85KMj+C+1tmY58Ty6oZ8GGEiHKtamJY2fypkp8PNe4mgqjsDZJf
	 imV7+ffICAO6uIYvsOxW+O7/vWPCXfC3ic7oxnRjND08UnMlPJqwC79vwSgW8YEHHfPfc
	 gG/ejJNLts3esSCNdMfrIpOQz5zVsnSJCdnKtZSwYSx8lp6ZzkdJHa3kCcbCS34KhrA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=DUTbARDE;
	arc=none smtp.remote-ip=198.175.65.11
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12CE3606A324
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 08:26:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 12CE3606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=DUTbARDE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793607998; x=1825143998;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=k41mBmtJkuVXeJseFaZycWkbR33x7I/1nItYj3EU9ac=;
  b=DUTbARDE5waBIc1YS7sWIxypHxit/ImSKLgUX/xQpERNiFNMeQDiew4n
   XoKLZsymBoSDD4KpWKMlYV5GhHICwA8mDG9AF0Rk0jJBaCUxIlLn0LINH
   JL5D+Jg9tZawn0sVY7EtpH81b24/6Z8Nf6B+LamGgBAQx+lBMeggHTTiA
   YZmEqT6/Js6tnzxHvtaqYRf97cvhVNNyJmu1Y0BfR1rI7z3tqI1KfIBLU
   OmIxubPashXY5q5QtC+n23u3V5f5yMoMw1c91w7BSmrF9ZydQ8i5qp+5Q
   srBpDMKmgm2vcpgvkFf1IJl8uG96nrdMiswEfOO2++xuAqlgkfm+un8is
   w==;
X-CSE-ConnectionGUID: +WJTnuxJSZ2roAcNhOYFjA==
X-CSE-MsgGUID: 5hAKHtYiS56eHChMFr81yw==
X-IronPort-AV: E=McAfee;i="6800,10657,11953"; a="2169612"
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="2169612"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2026 00:26:37 -0800
X-CSE-ConnectionGUID: zVUl1XY6Q3OKJFfd2Ys+iA==
X-CSE-MsgGUID: detXpDILRkixxWiZUQ5Atw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="6414417"
Received: from varungup-desk.iind.intel.com ([10.190.238.71])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2026 00:26:34 -0800
From: Arvind Yadav <arvind.yadav@intel.com>
To: intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: matthew.brost@intel.com,
	himal.prasad.ghimiray@intel.com,
	thomas.hellstrom@linux.intel.com,
	rodrigo.vivi@intel.com,
	stable@vger.kernel.org
Subject: [PATCH] drm/xe: Tear down kernel mappings in release_notify
Date: Mon,  2 Nov 2026 13:56:26 +0530
Message-ID: <20261102082626.747462-1-arvind.yadav@intel.com>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

xe_gem_object_free() calls __xe_bo_vunmap() without holding the BO
reservation. The last GEM reference does not exclude TTM eviction,
which takes a separate reference on the TTM BO.

Eviction can free the resource while ttm_bo_kunmap() is using it.
ttm_mem_io_free() can then clear bus.addr and bus.offset in the freed
resource. This is consistent with the 16 zeroed bytes reported by
SLUB for a resource freed by xe_ttm_vram_mgr_del() during eviction.

Move __xe_bo_vunmap() to xe_ttm_bo_release_notify(). It runs when the
TTM BO refcount reaches zero, so eviction and swapout can no longer
take a reference, and before TTM frees the resource and backing pages.

Fixes: dd08ebf6c352 ("drm/xe: Introduce a new DRM driver for Intel GPUs")
Cc: stable@vger.kernel.org
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Cc: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Signed-off-by: Arvind Yadav <arvind.yadav@intel.com>
---
 drivers/gpu/drm/xe/xe_bo.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/xe/xe_bo.c b/drivers/gpu/drm/xe/xe_bo.c
index 42a6aa1a2e4a..b7a982a9d81a 100644
--- a/drivers/gpu/drm/xe/xe_bo.c
+++ b/drivers/gpu/drm/xe/xe_bo.c
@@ -1866,6 +1866,12 @@ static void xe_ttm_bo_release_notify(struct ttm_buffer_object *ttm_bo)
 	bo = ttm_to_xe_bo(ttm_bo);
 	xe_assert(xe_bo_device(bo), !(bo->created && kref_read(&ttm_bo->base.refcount)));
 
+	/*
+	 * The TTM BO refcount is zero, so eviction and swapout cannot
+	 * take a reference. Unmap before TTM frees the backing store.
+	 */
+	__xe_bo_vunmap(bo);
+
 	if (!xe_ttm_bo_lock_in_destructor(ttm_bo))
 		return;
 
@@ -2056,7 +2062,6 @@ static void xe_gem_object_free(struct drm_gem_object *obj)
 	 * driver ttm callbacks is allowed to use the ttm_buffer_object
 	 * refcount directly if needed.
 	 */
-	__xe_bo_vunmap(gem_to_xe_bo(obj));
 	ttm_bo_fini(container_of(obj, struct ttm_buffer_object, base));
 }
 
-- 
2.43.0

