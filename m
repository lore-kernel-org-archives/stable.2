Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794420006;
	b=jsgHoFHUON3ixH56yTS1wLAr588v+8mxklMIvPFEbWNDvR+LWY8Yh+PcrT1kmai7/aUK
	 eeGwzDGrGGKtwJOJCDuofsj/JuuWYjT6VMeg5X4e+2W2b2479XG82gdCNB2f2mr4tM0Ds
	 bchkDXCWAWFileCjMNlSBs3M4GBnZZK8HWU7f/AAaX8A3/GSTx8te/MawBvD43PBilcw2
	 WDlljWR8v2x2igA+P9VjhYWT5hqv4wRwfEuHlZbFZefSjZ+F98PIyc2r0kMM7ys50L2il
	 hXz26GhkufQbGJ8P5mUd8SPz6x6kxYXJOWfysqHee4RR59dxnj+/efjwgM0r1HQia/w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794420006;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=v8ZIGZ9X9vi0CpZnLF2fUVL56sr7NsnSHe2NWfElok8=;
	b=gmFBgnglpswa07cgopl9pZVdPtNnM4hP2zoRnVQg5d9rF2LzevMkSbtrJ5m+isXIkCuG
	 oyDoFaKrh6UPgX/YSQv40he/sr6FRH1LYi/TnsSunDcM1o++xOLnUprEqQoulTj/Ss0ny
	 VCr7gWu0aj++GASWa7r/SUtRy8JGKKRmzJ3wektA3834hEFVvN/8J9IuM+97SbM9wN0ov
	 3TRNb5HHgM0IZtGBYTQFKVFn3xwUwxM59UV1bJrfG81ZD/Tp4xRoyGfXLDuTCoZ3Og9KT
	 qJMf2v+5lC0FzSLtPkT3GP+7AmaHMyd5IPek0wf2DRcHd7R1l8F/1fyjdoGcQ21IUzg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NaVylGOi;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 300E3606A32E
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 18:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NaVylGOi
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40BB81F00A05;
	Wed, 11 Nov 2026 18:00:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794420005;
	bh=v8ZIGZ9X9vi0CpZnLF2fUVL56sr7NsnSHe2NWfElok8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NaVylGOiJ/+bdEqHtgW59cynkK5TX04RM7TDtITetCzsns/lj+Zq+zNytP9zw2p+B
	 fqmQ5mo1RCvai4v2zqu0qvajBmA9S1+c7BnTZUYJ3kq/ynycr0PepnqN9ewRegpBBz
	 btwgc4p2Wz+wJIJofZ/7Ylef0FnuynfvDMdGp3uEmQUEty0mwfZ2LU0lCvsvT5JQkT
	 iMmAAJbJB2VWP7yt9ObZjoIIG5osafByOFb9VCqNrTXNcbzj/GKKG32Pi1uUFqhrXc
	 9o1bknIg44QaHcf7O7ujG3DH7OmjPx4lyUKO203PTcEk5XksX1Qr4kAmFQUKLSpQFI
	 AXXx7DHsF3nig==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Andrea Parri <parri.andrea@gmail.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.3.y] iommufd/iova_bitmap: Ensure that iova_bitmap_set() handles the full IOVA
Date: Wed, 11 Nov 2026 13:00:04 -0500
Message-ID: <20261111175946.3690928-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107050456-failed-7.3-e21952d72b47@kernel.org>
References: <20261107050456-failed-7.3-e21952d72b47@kernel.org>
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
[ sashal: Added missing prerequisite error storage and propagation from the bitmap through the iterator to the ioctl. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iommu/iommufd/io_pagetable.c |  2 +-
 drivers/iommu/iommufd/iova_bitmap.c  | 19 ++++++++++++++++++-
 include/uapi/linux/iommufd.h         |  6 ++++++
 3 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/iommufd/io_pagetable.c b/drivers/iommu/iommufd/io_pagetable.c
index 283ab372e8da8..5ac736cf5bb5a 100644
--- a/drivers/iommu/iommufd/io_pagetable.c
+++ b/drivers/iommu/iommufd/io_pagetable.c
@@ -589,7 +589,7 @@ iommu_read_and_clear_dirty(struct iommu_domain *domain,
 	arg.iopt = iopt;
 	arg.domain = domain;
 	arg.dirty = &dirty;
-	iova_bitmap_for_each(iter, &arg, __iommu_read_and_clear_dirty);
+	ret = iova_bitmap_for_each(iter, &arg, __iommu_read_and_clear_dirty);
 
 	if (!(flags & IOMMU_DIRTY_NO_CLEAR))
 		iommu_iotlb_sync(domain, &gather);
diff --git a/drivers/iommu/iommufd/iova_bitmap.c b/drivers/iommu/iommufd/iova_bitmap.c
index dac3e657d498d..908c70f5362e0 100644
--- a/drivers/iommu/iommufd/iova_bitmap.c
+++ b/drivers/iommu/iommufd/iova_bitmap.c
@@ -116,6 +116,9 @@ struct iova_bitmap {
 
 	/* length of the IOVA range for the whole bitmap */
 	size_t length;
+
+	/* first error from recording an IOVA range */
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
 EXPORT_SYMBOL_NS_GPL(iova_bitmap_for_each, "IOMMUFD");
 
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
 		/*
diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
index 5d47d1421c1fc..63a86354e822f 100644
--- a/include/uapi/linux/iommufd.h
+++ b/include/uapi/linux/iommufd.h
@@ -871,6 +871,12 @@ enum iommufd_hwpt_get_dirty_bitmap_flags {
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

