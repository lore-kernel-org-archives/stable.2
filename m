Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794420865;
	b=G09az5zDwwXTklFs/kYU4im+2cvXnwL9pPIlMKEdfOuRAbuDQBBieDk5skAS9z9y6X/X
	 3m/oi7DoQOs0OT2jQ7pVSDXC3rTu89F2FDI81tEdJpoI5BjtcpU4ozwC/F9y3Kq4XHbk6
	 NuuTyrx3/6Iq4D8rfYHBniO1maZh8UuzCZZM8VeHH4/99GCrxupniM0IpNcw0tCjHf8sa
	 gLrDLewizDxCCDlxy08bQnRG+FIj+Li379K0qDFHxYuxCprb1htSVl3tJi8c3xwhZ/AgX
	 9dHe+JHOLXqMoE90XtUQgoC9Y02umkzbgT4yJMJMMieivyrDpXytUVQaugZPTSNFm0w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794420865;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=rkhyKQXmZ01pLNtAx+Rpj6vVvEcp+C4aLgaU8KL+p+o=;
	b=CloeGz2w4JB9fpmdjys3eqyfgamsUMtTJZjmiKSFSRInwibaEx7M7iuC6NOzwqjlpM0K
	 EaOiBMGg1DX8Dvar/eUjn+dXzGaG6Mumb27bAn6lHQ6qBJiGlUFs5o9QDE+fZDZVIFvlO
	 W2lxUNekwpeNfOFJjEvl2ij46kuYu7Dpjv3dsUQh79SFeiWH+88KRaAcNF0xKnGpUZeAg
	 BLWUdIhQc9GIPHl2Eh8y6+dhttgLBvkSi9XQhk7wttZgZUR8lYYEUYTwteJv0ZivyVKzU
	 xYbPIY0QB4fo3+jjeu0zbfPPpbwh1Qa9qp6rF32IbIixCxRXzMXpUaUC9lBfuBV9eYQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Chd74lXB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BEFB606D720
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 18:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Chd74lXB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C6BC1F00A09;
	Wed, 11 Nov 2026 18:14:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794420865;
	bh=rkhyKQXmZ01pLNtAx+Rpj6vVvEcp+C4aLgaU8KL+p+o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Chd74lXBTaYoO0RHtnBt4IauYQ2KKqO+rEgD6kaGkcnV0wzrY8HKVqvr3/roiNvcU
	 l5cC9THSgLx4dcZadJm3ysalrjiZ/CxMpV4HbY7by1ZZeGxrF1kokpBnvCqV7Xtv8G
	 cvc+lrUyxpuxu+eu1n2SXPRwR6y/D+bJxvbsV4C5Kw2yoiNVy0KDz5z10wiMrp9D4Y
	 NFOW0/7G5H1RmoM5dtoAfEc6trauV2Z+G5skIX6qm7vsauRMSZnFtytpE7+R5dyLqe
	 7pYqAUbEfbQsd+/xiKnsZ4qjsLVsKntw55smBLM+qLyOjnhxpO4AXSVJZNMqaoC8qT
	 7gsSEZlzxs9Qg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Andrea Parri <parri.andrea@gmail.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] iommufd/iova_bitmap: Ensure that iova_bitmap_set() handles the full IOVA
Date: Wed, 11 Nov 2026 13:14:23 -0500
Message-ID: <20261111181404.3754010-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107052305-failed-6.12-e21952d72b47@kernel.org>
References: <20261107052305-failed-6.12-e21952d72b47@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Andrea Parri <parri.andrea@gmail.com>

[ Upstream commit e21952d72b4740f08a272d694cca223b6b0099ca ]

Generally userspace is going to step the dirty bitmap through the IOVA
space. However if the bitmap ends in the middle of a large PTE this is
problematic. The first step will clear the dirty bit and report dirty to
the end of its bitmap while the second step will see the clear'd dirty and
report clean for the start of the bitmap. If it happens this ends up
losing dirties.

Further this function is missing bounds checking so if this does happen
ther is a good chance it will write memory beyond what the userspace was
expecting.

Return an error code if this illegal condition happens.

Fixes: 58ccf0190d19 ("vfio: Add an IOVA bitmap support")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Andrea Parri <parri.andrea@gmail.com>
Link: https://patch.msgid.link/20260925161142.189813-2-parri.andrea@gmail.com
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
[ sashal: Added missing bitmap error-propagation infrastructure connecting the stored error field to the iterator and ioctl caller. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iommu/iommufd/io_pagetable.c |  2 +-
 drivers/iommu/iommufd/iova_bitmap.c  | 19 ++++++++++++++++++-
 include/uapi/linux/iommufd.h         |  6 ++++++
 3 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/iommufd/io_pagetable.c b/drivers/iommu/iommufd/io_pagetable.c
index 177e8e12f189f..382150147f4d1 100644
--- a/drivers/iommu/iommufd/io_pagetable.c
+++ b/drivers/iommu/iommufd/io_pagetable.c
@@ -505,7 +505,7 @@ iommu_read_and_clear_dirty(struct iommu_domain *domain,
 	arg.iopt = iopt;
 	arg.domain = domain;
 	arg.dirty = &dirty;
-	iova_bitmap_for_each(iter, &arg, __iommu_read_and_clear_dirty);
+	ret = iova_bitmap_for_each(iter, &arg, __iommu_read_and_clear_dirty);
 
 	if (!(flags & IOMMU_DIRTY_NO_CLEAR))
 		iommu_iotlb_sync(domain, &gather);
diff --git a/drivers/iommu/iommufd/iova_bitmap.c b/drivers/iommu/iommufd/iova_bitmap.c
index 0943a351fb917..e12a36bf6aed5 100644
--- a/drivers/iommu/iommufd/iova_bitmap.c
+++ b/drivers/iommu/iommufd/iova_bitmap.c
@@ -116,6 +116,9 @@ struct iova_bitmap {
 
 	/* length of the IOVA range for the whole bitmap */
 	size_t length;
+
+	/* first error encountered while recording dirty IOVAs */
+	int err;
 };
 
 /*
@@ -384,7 +387,9 @@ static int iova_bitmap_advance_to(struct iova_bitmap *bitmap,
 int iova_bitmap_for_each(struct iova_bitmap *bitmap, void *opaque,
 			 iova_bitmap_fn_t fn)
 {
-	return fn(bitmap, bitmap->iova, bitmap->length, opaque);
+	int ret = fn(bitmap, bitmap->iova, bitmap->length, opaque);
+
+	return ret ? ret : bitmap->err;
 }
 EXPORT_SYMBOL_NS_GPL(iova_bitmap_for_each, IOMMUFD);
 
@@ -404,6 +409,18 @@ void iova_bitmap_set(struct iova_bitmap *bitmap,
 	struct iova_bitmap_map *mapped = &bitmap->mapped;
 	unsigned long cur_bit, last_bit, last_page_idx;
 
+	/*
+	 * If the range cannot be recorded then the system call returns failure.
+	 * This is to prevent loosing dirties if userspace is expecting to step
+	 * the bitmap through the IOVA space.
+	 */
+	if (!length || length > bitmap->length || iova < bitmap->iova ||
+	    iova - bitmap->iova > bitmap->length - length) {
+		if (!bitmap->err)
+			bitmap->err = -EPROTO;
+		return;
+	}
+
 update_indexes:
 	if (unlikely(!iova_bitmap_mapped_range(mapped, iova, length))) {
 
diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
index 41048271a0667..e245fa295662a 100644
--- a/include/uapi/linux/iommufd.h
+++ b/include/uapi/linux/iommufd.h
@@ -621,6 +621,12 @@ enum iommufd_hwpt_get_dirty_bitmap_flags {
  * Walk the IOMMU pagetables for a given IOVA range to return a bitmap
  * with the dirty IOVAs. In doing so it will also by default clear any
  * dirty bit metadata set in the IOPTE.
+ *
+ * The IOVA range given must fully enclose any IOPTE. If the range starts or
+ * ends inside a dirty IOPTE then the ioctl will fail. This avoids partially
+ * reporting a dirty range.
+ *
+ * On failure the dirty state becomes unknown and the userspace must restart.
  */
 struct iommu_hwpt_get_dirty_bitmap {
 	__u32 size;
-- 
2.53.0

