Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DA0537207F
	for <stable@vger.kernel.org>; Sun,  4 Oct 2026 10:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791109087; cv=none; b=OMVnTW44KdFN0oyc4KUIXTmfYerMhpq/3CQa/ZPTaROhfUTu2HdE+0hWR/SJ4EBDfAiWhHv/NUaSjvRYtxM8Jf5D7AxSS9DQiJTIaY16CTHxBzZHolEdquxBk3z2CCPlX1VGHgFgroaCn94jWhKWkaKKENUJ7sTACN/EVYkj85s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791109087; c=relaxed/simple;
	bh=Mvc2MnM8v9rEgPkrOXQmHnVX7MW0McKbHJ0Ag2r0wFo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PALW+Uag1RPdAWb4uMKj1Gy/d9RtaUPfJdc0qdgj4G7bI+1OwnGY9wN65p81omr5QwZFLEUC08KcJdroNxzv6XvvdQfaMjWcEZmwKUqHDZoZ/Yz2CkSOBz+jRHbsje1xlqR+M2YNRBF17Y4Lg3Brsy51nwG5BgjKIYGhmpFvkQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PnTQIM9s; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PnTQIM9s"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B20701F00898;
	Sun,  4 Oct 2026 10:18:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791109085;
	bh=mybQPnpY8iRbZA6cK+lEPEmtFJ/gTDyDIJTVXffu+qI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PnTQIM9slESO6cwc6hBPxu0M0rkcA761Bl3DDx1/Qghr5CZPUSyn7WOW0p/reRCSY
	 FAjDqlZVbkGOozf0GgWY7Y4rGIlvnNniwU54Cl5gGbblK6rC43PiNga5JossVysC2v
	 njAAVz7suDK9FqUWp/YvpxnDVY69isqjBRnntoaiJj0JYLKDYuresZ4fP/APRONTuq
	 lrgdz+pKktuvBe1cDKpomI8g9eVQ7cv7j0yl0SoCnJN/ibzUYgDTlT4rrDkswuTA4t
	 6sRxCxCBsXl3/EEmJRhdsOirp30a3FoDCM5c+IIB/79NZUJissFpTGvkXwpBW0OjWR
	 CxFSqn+PUyKkw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>,
	Matthew Wilcox <willy@infradead.org>,
	Barry Song <baohua@kernel.org>,
	David Hildenbrand <david@redhat.com>,
	Daniel Gomez <da.gomez@samsung.com>,
	Hugh Dickins <hughd@google.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	Lance Yang <ioworker0@gmail.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/4] mm: factor out the order calculation into a new helper
Date: Sun,  4 Oct 2026 06:17:55 -0400
Message-ID: <20261004101724.1697042-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261004101724.1697042-1-sashal@kernel.org>
References: <2026100338-roundworm-goatskin-a51b@gregkh>
 <20261004101724.1697042-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Baolin Wang <baolin.wang@linux.alibaba.com>

[ Upstream commit da243c5479add600bdd58c910c9fae3355b4f026 ]

Patch series "Support large folios for tmpfs", v3.

Traditionally, tmpfs only supported PMD-sized large folios.  However
nowadays with other file systems supporting any sized large folios, and
extending anonymous to support mTHP, we should not restrict tmpfs to
allocating only PMD-sized large folios, making it more special.  Instead,
we should allow tmpfs can allocate any sized large folios.

Considering that tmpfs already has the 'huge=' option to control the
PMD-sized large folios allocation, we can extend the 'huge=' option to
allow any sized large folios.  The semantics of the 'huge=' mount option
are:

huge=never: no any sized large folios
huge=always: any sized large folios
huge=within_size: like 'always' but respect the i_size
huge=advise: like 'always' if requested with madvise()

Note: for tmpfs mmap() faults, due to the lack of a write size hint, still
allocate the PMD-sized large folios if huge=always/within_size/advise is
set.

Moreover, the 'deny' and 'force' testing options controlled by
'/sys/kernel/mm/transparent_hugepage/shmem_enabled', still retain the same
semantics.  The 'deny' can disable any sized large folios for tmpfs, while
the 'force' can enable PMD sized large folios for tmpfs.

This patch (of 6):

Factor out the order calculation into a new helper, which can be reused by
shmem in the following patch.

Link: https://lkml.kernel.org/r/cover.1732779148.git.baolin.wang@linux.alibaba.com
Link: https://lkml.kernel.org/r/5505f9ea50942820c1924d1803bfdd3a524e54f6.1732779148.git.baolin.wang@linux.alibaba.com
Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Suggested-by: Matthew Wilcox <willy@infradead.org>
Reviewed-by: Barry Song <baohua@kernel.org>
Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Daniel Gomez <da.gomez@samsung.com>
Cc: Hugh Dickins <hughd@google.com>
Cc: Kefeng Wang <wangkefeng.wang@huawei.com>
Cc: Lance Yang <ioworker0@gmail.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Stable-dep-of: 72c3d682c165 ("mm: shmem: ignore sysfs configs for shmem forced collapse")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/pagemap.h | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 68a5f1ff3301c..01717aa4a054b 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -727,6 +727,16 @@ typedef unsigned int __bitwise fgf_t;
 
 #define FGP_WRITEBEGIN		(FGP_LOCK | FGP_WRITE | FGP_CREAT | FGP_STABLE)
 
+static inline unsigned int filemap_get_order(size_t size)
+{
+	unsigned int shift = ilog2(size);
+
+	if (shift <= PAGE_SHIFT)
+		return 0;
+
+	return shift - PAGE_SHIFT;
+}
+
 /**
  * fgf_set_order - Encode a length in the fgf_t flags.
  * @size: The suggested size of the folio to create.
@@ -740,11 +750,11 @@ typedef unsigned int __bitwise fgf_t;
  */
 static inline fgf_t fgf_set_order(size_t size)
 {
-	unsigned int shift = ilog2(size);
+	unsigned int order = filemap_get_order(size);
 
-	if (shift <= PAGE_SHIFT)
+	if (!order)
 		return 0;
-	return (__force fgf_t)((shift - PAGE_SHIFT) << 26);
+	return (__force fgf_t)(order << 26);
 }
 
 void *filemap_get_entry(struct address_space *mapping, pgoff_t index);
-- 
2.53.0

