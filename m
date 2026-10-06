Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F238375AC4
	for <stable@vger.kernel.org>; Tue,  6 Oct 2026 11:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791284875; cv=none; b=cSpwvsTU45b9S7/v6V3uB29xVmpWhSnDHQliF5XVgJZK4ohtzWQLTQ2KydQcTDwma5GEkKw/qdNIbRUgCuV52qi07/+N0rxIKKr2SYxFYYXS41015kbHJDJunGgpt4DPTLG1BFQPjvz5dNYbQmFK/eRIRNkGU78ASNiEY7F3X2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791284875; c=relaxed/simple;
	bh=bXb1SeEeu3JPvryt9a24XFMIMldKqAekjGxkpo0iRL4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sJzQype+77OwTNo5oOCJSxShLxjeMJcV28kEfq4qcfBQZGNFTqSCuZOEkWNF4vqizX5XsxTJyHFbnhrlZUJ9q0YsXrk5ur4PlBrC1om1ZR5GYRpjUf/7qOjlH+FIpYA4VI3zeTS6k8auWBMc2pZD7ej3m9DNCgsYORH8ALj9EIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aoYAVIWy; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aoYAVIWy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791284873; x=1822820873;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=bXb1SeEeu3JPvryt9a24XFMIMldKqAekjGxkpo0iRL4=;
  b=aoYAVIWyLFW7331FPdPEFwGYVz8iJevRHHHuhX/bR75RKixNYDA9/wuM
   YZcEfT3EGa7dzNs0INZ6U8LXSszBIHAZSrWZIiemYmw5I5fBtCkKxYbhZ
   Mu2FJztddBOHOC0GZWpC2QDzQ+wyFU2EYEt4Vz7VtcfnmZnpx19Z2ZJpe
   QHxsGrMevq/7wMqjE3+iKao20ZwVg6r0swe8VMs8o7nBVSZaVfjCWIklR
   DBh77G9dvK27GoMlU9DeUeC20/IrJx/G0KJPk9dIS96IoLlG3I7I1HUJA
   JTPBM6m5PdvlbF4ff7Rme6FNl5GEcXl8eKDN06syDw9Lt1en6U4QKsupl
   A==;
X-CSE-ConnectionGUID: gbeC2mOXT5GNQt2aoOLaKQ==
X-CSE-MsgGUID: yAsFt9pnQ2Gow0+kk/qsTQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11926"; a="120244"
X-IronPort-AV: E=Sophos;i="6.27,143,1787036400"; 
   d="scan'208";a="120244"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2026 04:07:53 -0700
X-CSE-ConnectionGUID: 8g0ERyDAS7OPYPeVVawlYg==
X-CSE-MsgGUID: LzBYpXU0RN+umuPiuWOTSw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,143,1787036400"; 
   d="scan'208";a="275778612"
Received: from abityuts-desk1.ger.corp.intel.com (HELO mwauld-desk.intel.com) ([10.245.244.81])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2026 04:07:51 -0700
From: Matthew Auld <matthew.auld@intel.com>
To: intel-xe@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org,
	Shashiko <sashiko-bot@kernel.org>,
	Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	stable@vger.kernel.org
Subject: [PATCH] gpu/buddy: do not pass caller list to __alloc_contig_try_harder()
Date: Tue,  6 Oct 2026 12:07:07 +0100
Message-ID: <20261006110706.1636971-2-matthew.auld@intel.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If the caller passes a non-empty blocks list, __alloc_contig_try_harder()
unconditionally frees it on failure or during retry.

Pass the local allocated list instead and only splice it onto the caller's
list upon success.

Assisted-by: LLM
Reported-by: Shashiko <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/bug/linux-fa721daf-7333-48b5-a26b-624c7f5791d7
Fixes: 0a1844bf0b53 ("drm/buddy: Improve contiguous memory allocation")
Signed-off-by: Matthew Auld <matthew.auld@intel.com>
Cc: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
Cc: Joel Fernandes <joelagnelf@nvidia.com>
Cc: <stable@vger.kernel.org>
---
 drivers/gpu/buddy.c                | 20 ++++++++++++++------
 drivers/gpu/tests/gpu_buddy_test.c |  9 +++++++++
 2 files changed, 23 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/buddy.c b/drivers/gpu/buddy.c
index 2f2aaadafe35..a86f454fbb40 100644
--- a/drivers/gpu/buddy.c
+++ b/drivers/gpu/buddy.c
@@ -2022,10 +2022,16 @@ int gpu_buddy_alloc_blocks(struct gpu_buddy *mm,
 
 	if (order > mm->max_order || size > mm->size) {
 		if ((flags & GPU_BUDDY_CONTIGUOUS_ALLOCATION) &&
-		    !(flags & GPU_BUDDY_RANGE_ALLOCATION))
-			return __alloc_contig_try_harder(mm, original_size,
-							 original_min_size,
-							 flags, blocks);
+		    !(flags & GPU_BUDDY_RANGE_ALLOCATION)) {
+			err = __alloc_contig_try_harder(mm, original_size,
+							original_min_size,
+							flags, &allocated);
+			if (err)
+				return err;
+
+			list_splice_tail(&allocated, blocks);
+			return 0;
+		}
 
 		return -EINVAL;
 	}
@@ -2064,9 +2070,11 @@ int gpu_buddy_alloc_blocks(struct gpu_buddy *mm,
 								original_size,
 								original_min_size,
 								flags,
-								blocks);
-				if (!err)
+								&allocated);
+				if (!err) {
+					list_splice_tail(&allocated, blocks);
 					return 0;
+				}
 				if (err != -ENOSPC)
 					return err;
 				goto err_free;
diff --git a/drivers/gpu/tests/gpu_buddy_test.c b/drivers/gpu/tests/gpu_buddy_test.c
index b75d32ca6ca0..2c6f1da1a6d1 100644
--- a/drivers/gpu/tests/gpu_buddy_test.c
+++ b/drivers/gpu/tests/gpu_buddy_test.c
@@ -1235,6 +1235,15 @@ static void gpu_test_buddy_alloc_contiguous(struct kunit *test)
 							    GPU_BUDDY_CONTIGUOUS_ALLOCATION),
 			       "buddy_alloc hit an error size=%lu\n", 2 * ps);
 
+	/*
+	 * A failed contiguous allocation with a non-empty blocks list
+	 * must NOT corrupt or free pre-existing blocks.
+	 */
+	KUNIT_EXPECT_TRUE(test, gpu_buddy_alloc_blocks(&mm, 0, mm_size,
+						       3 * ps, ps, &allocated,
+						       GPU_BUDDY_CONTIGUOUS_ALLOCATION));
+	KUNIT_EXPECT_FALSE(test, list_empty(&allocated));
+
 	gpu_buddy_free_list(&mm, &left, 0);
 	KUNIT_ASSERT_FALSE_MSG(test, gpu_buddy_alloc_blocks(&mm, 0, mm_size,
 							    3 * ps, ps, &allocated,
-- 
2.55.0

