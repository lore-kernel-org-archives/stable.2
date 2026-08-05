Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7D873DCD80;
	Wed,  5 Aug 2026 19:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785958546; cv=none; b=fcjtaHvkXYE8BNM/cK8kEXsTnKjCy8b8uDaK62NFs9fX+fqbrb3zcAEiaXaS0iuIJfU6EfudWmXwLjbtUI1f1GZKO9Xa2iPGsbycChdKi4zOCGgjnS580JNPJaLYOObsh82UXrfUfUVINrjQ2Irpgf2aafKG8rDwee13JVCWReQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785958546; c=relaxed/simple;
	bh=0YG7iyYcbF3G1EFKh9ioNjadG3W1OhFnqKUemvuHbQY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iQzsGLYLQ5DA2iJ4tFsx48njpZL9nF/vT5axRrdtaZMXO5LrIEyO6Rmso0rkRlfxtKhY1xzo+UIudPy9j6TagjcXXig2wKKY0sxdv+rPdzMQhCyWGsvtbpkyG4fTa3RKCnOI2tQSsHjTsvPeqes7vciYUQ7YHbdJnqDol4o28gI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WxIEp9Uy; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WxIEp9Uy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785958544; x=1817494544;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0YG7iyYcbF3G1EFKh9ioNjadG3W1OhFnqKUemvuHbQY=;
  b=WxIEp9UyybAK5OHwZ+yljQuyX5fEFKaSMzyYwoI5T6znV+qmzQpf2jGY
   i2VhcB8pkTfzPuIPoMrrJJXxcIypOoEl7y9EfAEedtJRaUgY74l6ilMHh
   YXdQ9dRf/HwSIYFUCHRnkDuSAxdUQOAaQ2raNzpc5J+xWXi3m+c3ohNTl
   tDGsw/iOy2WAwmYksEyjb1ZV4o0Gb1OiNuPUhb3eY3l4e/2E7QT65s0xn
   pSrDcFJCcllsagTiht5oyaVJvfZ/sx/cPitcnNazQVMUkGGNHRvk85xaL
   gSlEI/97B1WMnBRITsK31UgYAmz/digX6+lQtn4E50HYkPsSlzYlH0v+I
   Q==;
X-CSE-ConnectionGUID: H+0PxfBzS/G21SqIgdc+VA==
X-CSE-MsgGUID: ztfvh61TQKe9UyXQMmf0OA==
X-IronPort-AV: E=McAfee;i="6800,10657,11866"; a="109332918"
X-IronPort-AV: E=Sophos;i="6.25,207,1779174000"; 
   d="scan'208";a="109332918"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2026 12:35:42 -0700
X-CSE-ConnectionGUID: +IlgXOyXTU+bAoeSzcnfsg==
X-CSE-MsgGUID: aH+F8fM8RHmiW/7pNd/qeA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,207,1779174000"; 
   d="scan'208";a="285263519"
Received: from gsse-cloud1.jf.intel.com ([10.54.39.91])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2026 12:35:42 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: Sashiko <sashiko-bot@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Zi Yan <ziy@nvidia.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	"Liam R . Howlett" <liam@infradead.org>,
	Nico Pache <nico.pache@linux.dev>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>,
	Barry Song <baohua@kernel.org>,
	Lance Yang <lance.yang@linux.dev>,
	Usama Arif <usama.arif@linux.dev>,
	Joshua Hahn <joshua.hahnjy@gmail.com>,
	Rakie Kim <rakie.kim@sk.com>,
	Byungchul Park <byungchul@sk.com>,
	Gregory Price <gourry@gourry.net>,
	Ying Huang <ying.huang@linux.alibaba.com>,
	Alistair Popple <apopple@nvidia.com>,
	Balbir Singh <balbirs@nvidia.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Francois Dugast <francois.dugast@intel.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 1/5] mm/migrate_device: Clear MIGRATE_PFN_MIGRATE on all sub-folios of a split THP
Date: Wed,  5 Aug 2026 12:35:32 -0700
Message-Id: <20260805193536.3756457-2-matthew.brost@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260805193536.3756457-1-matthew.brost@intel.com>
References: <20260805193536.3756457-1-matthew.brost@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

migrate_vma_split_unmapped_folio() propagates MIGRATE_PFN_MIGRATE from
the head entry to all HPAGE_PMD_NR entries of src_pfns[]. The two
bailouts below it in __migrate_device_pages() only cleared the head, and
the "next" label then advances by @nr, so the tails keep the flag and a
valid destination without ever going through folio_migrate_mapping().
migrate_vma_finalize() then maps unpopulated destination folios into
userspace.

Clear the flag across the whole @nr range at both bailouts.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Fixes: 4265d67e405a ("mm/migrate_device: add THP splitting during migration")
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: David Hildenbrand <david@kernel.org>
Cc: Lorenzo Stoakes <ljs@kernel.org>
Cc: Zi Yan <ziy@nvidia.com>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: Liam R. Howlett <liam@infradead.org>
Cc: Nico Pache <nico.pache@linux.dev>
Cc: Ryan Roberts <ryan.roberts@arm.com>
Cc: Dev Jain <dev.jain@arm.com>
Cc: Barry Song <baohua@kernel.org>
Cc: Lance Yang <lance.yang@linux.dev>
Cc: Usama Arif <usama.arif@linux.dev>
Cc: Joshua Hahn <joshua.hahnjy@gmail.com>
Cc: Rakie Kim <rakie.kim@sk.com>
Cc: Byungchul Park <byungchul@sk.com>
Cc: Gregory Price <gourry@gourry.net>
Cc: Ying Huang <ying.huang@linux.alibaba.com>
Cc: Alistair Popple <apopple@nvidia.com>
Cc: Balbir Singh <balbirs@nvidia.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Maxime Ripard <mripard@kernel.org>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: David Airlie <airlied@gmail.com>
Cc: Simona Vetter <simona@ffwll.ch>
Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Cc: Francois Dugast <francois.dugast@intel.com>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Assisted-by: GitHub_Copilot:claude-opus-5
Signed-off-by: Matthew Brost <matthew.brost@intel.com>
---
 mm/migrate_device.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/mm/migrate_device.c b/mm/migrate_device.c
index 908d2d4ec43a..d37a96cc6335 100644
--- a/mm/migrate_device.c
+++ b/mm/migrate_device.c
@@ -1199,10 +1199,14 @@ static void __migrate_device_pages(unsigned long *src_pfns,
 				 * device private or coherent memory.
 				 *
 				 * Try to get rid of swap cache if possible.
+				 *
+				 * @folio may have been split into @nr folios
+				 * above, so clear all of them.
 				 */
 				if (!folio_test_anon(folio) ||
 				    !folio_free_swap(folio)) {
-					src_pfns[i] &= ~MIGRATE_PFN_MIGRATE;
+					for (j = 0; j < nr && i + j < npages; j++)
+						src_pfns[i+j] &= ~MIGRATE_PFN_MIGRATE;
 					goto next;
 				}
 			}
@@ -1210,7 +1214,8 @@ static void __migrate_device_pages(unsigned long *src_pfns,
 			/*
 			 * Other types of ZONE_DEVICE page are not supported.
 			 */
-			src_pfns[i] &= ~MIGRATE_PFN_MIGRATE;
+			for (j = 0; j < nr && i + j < npages; j++)
+				src_pfns[i+j] &= ~MIGRATE_PFN_MIGRATE;
 			goto next;
 		}
 
-- 
2.34.1

