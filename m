Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 373D940BCA0;
	Mon, 17 Aug 2026 12:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786968626; cv=none; b=N02okCfNQLcrgy/Nx6PiaUBa1SiVwLWefO3hVPfxyE9n0B6MjMKshG5W/FHptnQMvsb4dQsc815lw6dEIp/I1WbOOQ8YyYxTRBfrq5WNY1Dp6hBFBqxALNcn0AIHzB1VVIwjCVS6gNRhzVcnqKULnWv0QfQCGYztx0gS+fafPes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786968626; c=relaxed/simple;
	bh=hbU7wg8u1lZULIvKNQZIkpjS01V7MhDXJfMjuyzDN7I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=od9T9VXmDnQUjuXILUfVDAcOc4DgTXgfdoIgXEXF8pTsALQZbyNYq3540lb9REFtUGtzASVJr0PeUDdeOJ8ceorJzyppCYZPPhcpdVMKXsZOlcMaz3UvmkfNltJn8/1X1sIjtjoq5uNNnu4pKPvmF0HMDH2INE05zv/vp6ODyTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=JX5FVsx+; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="JX5FVsx+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=7h
	H8SEbWRyKCE3jQdtxktQ3xXVtwKBmUFnlCGecuPeI=; b=JX5FVsx+KFnEfak8/X
	LTICC4Ckg3PQDGC2luU/oyyijeiMi+tPSbzsx16V2WJI9MZk/wHgMG4oOpF6rfw2
	kDb2OE9LdR5W9WCDjz/zwAVZRfPzbBxgKrFSUhuTaQ0a6lXhWd+aKC1WMzYfIGHK
	1y1Qbx10ny+TA/dUETDDa3VbM=
Received: from localhost (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wCXL4Ty+YJq0YOTPw--.30266S2;
	Mon, 17 Aug 2026 20:09:24 +0800 (CST)
From: Hui Su <sh_def@163.com>
To: akpm@linux-foundation.org,
	david@kernel.org,
	balbirs@nvidia.com
Cc: ziy@nvidia.com,
	matthew.brost@intel.com,
	joshua.hahnjy@gmail.com,
	rakie.kim@sk.com,
	byungchul@sk.com,
	gourry@gourry.net,
	ying.huang@linux.alibaba.com,
	apopple@nvidia.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Hui Su <sh_def@163.com>
Subject: [PATCH v2] mm/migrate_device: avoid out-of-bounds writes for compound folios
Date: Mon, 17 Aug 2026 20:08:00 +0800
Message-ID: <20260817120758.669807-3-sh_def@163.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wCXL4Ty+YJq0YOTPw--.30266S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxXw4xCF4rKry3KFWDuFW5Awb_yoW5GrWfpr
	4Fg3WDJrWDG347Kw13u3WxZr1293s8Xa1fKas7GwnakFZ8JF95ua4IqwnxtFs0y397AFyx
	Zay2qFyxZ3WUXaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0piJUUUUUUUU=
X-CM-SenderInfo: xvkbvvri6rljoofrz/xtbC6RT2VmqC+fTynAAA3W

migrate_device_range() and migrate_device_pfns() clear the entries
following a compound folio so that the PFN arrays retain their
page-granular representation.

If a compound folio extends beyond the end of the caller-provided range,
the loops clear all following folio entries without limiting them to the
number of slots remaining in the npages-sized array, causing an
out-of-bounds write.

Do not proceed with a compound folio if its page-granular representation
does not fit entirely in the remaining PFN array. If this happens, drop
any reference and lock acquired for the folio, clear the remaining
entries, and stop collecting.

Observed with a KASAN x86 QEMU kernel using the HMM
migrate_anon_huge_zero selftest. Closing /dev/hmm_dmirror0 after
migrating an anonymous huge page to device memory exercises:

  dmirror_fops_release()
    -> dmirror_device_evict_chunk()
      -> migrate_device_range()

Fixes: a30b48bf1b24 ("mm/migrate_device: implement THP migration of zone device pages")
Cc: stable@vger.kernel.org
Signed-off-by: Hui Su <sh_def@163.com>
---
Changes in v2:
- Do not partially represent a compound folio when it does not fit in
  the remaining PFN array.
- Drop any reference and lock acquired for that folio, clear the
  remaining entries, and stop collecting, as suggested by Balbir Singh.

v1: https://lore.kernel.org/lkml/20260817074350.442493-2-sh_def@163.com/

 mm/migrate_device.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/mm/migrate_device.c b/mm/migrate_device.c
index 908d2d4ec43a..69b8d0660bab 100644
--- a/mm/migrate_device.c
+++ b/mm/migrate_device.c
@@ -1400,6 +1400,15 @@ int migrate_device_range(unsigned long *src_pfns, unsigned long start,
 
 		src_pfns[i] = migrate_device_pfn_lock(pfn);
 		nr = folio_nr_pages(folio);
+		if (nr > npages - i) {
+			if (src_pfns[i] & MIGRATE_PFN_MIGRATE) {
+				folio_unlock(folio);
+				folio_put(folio);
+			}
+			memset(&src_pfns[i], 0,
+			       (npages - i) * sizeof(*src_pfns));
+			break;
+		}
 		if (nr > 1) {
 			src_pfns[i] |= MIGRATE_PFN_COMPOUND;
 			for (j = 1; j < nr; j++)
@@ -1434,6 +1443,15 @@ int migrate_device_pfns(unsigned long *src_pfns, unsigned long npages)
 
 		src_pfns[i] = migrate_device_pfn_lock(src_pfns[i]);
 		nr = folio_nr_pages(folio);
+		if (nr > npages - i) {
+			if (src_pfns[i] & MIGRATE_PFN_MIGRATE) {
+				folio_unlock(folio);
+				folio_put(folio);
+			}
+			memset(&src_pfns[i], 0,
+			       (npages - i) * sizeof(*src_pfns));
+			break;
+		}
 		if (nr > 1) {
 			src_pfns[i] |= MIGRATE_PFN_COMPOUND;
 			for (j = 1; j < nr; j++)
-- 
2.54.0

