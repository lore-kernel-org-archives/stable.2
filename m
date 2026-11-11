Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794420289;
	b=K7G/Ar8BqdqHUVEcLWnTdkV7bF2mQ1WiZp5J8ORAm+iH+6Sr5YZyNK3h1vRG2+LKPCR0
	 pbrQ2HlRmTV6Fz8kE06rpXhSdZNCpyIfyo2Dd3s7PaoxEtDIf1ncWUUvr+8saiqbHc1FL
	 PeMf7RTPNgrP8P4w4qXNg2fy+0rDP/eHYwGX88FvdCix6ffmZJ2WusVJVvEj+MOSnnmez
	 VcLCrcqG5Od5NJvnV1fLPfCbVcKcQBKqY0XU0WrPUMG+IlSRR1YGVuKcg6NIIaN66Yk9H
	 +/y1P0LmGJHtZtjcanQsruj91EVHLbgqJz7L+7+wTe4Vwr4Nn3zDMWrAfkFfWdbybKw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794420289;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=whYFr35S7ALTsTHlsM+B3tJFzRmTe5FaPPModDhaD/I=;
	b=xL0nJ7PiISO9DJqqnyMGUiDEbotjlyHfGqfpfmjHrPWLxx132CMioTFGZLWyfGws8XHZ
	 6AZAl7FPsKFTq4Ztj350pIIahiZMw2m0hbFdoE/2RKLTF6sdOdxzhO2ScYiILdPIa/f2u
	 53mWHPSg3PIZsZD+GUOGGEB6P4UbC5WyzeXV8r0AF1sh99pphvBGDsH9kkSEwwP27GiUP
	 4Dou46c2hbKaTHrRSx/1SfvYYI6vs74Tj8RXKFZSvDiQ9fWEmbh48qNZKg1wleck9Sure
	 2zbZ8f6zi7TW/a7bgOEq59FIbSEUacXIqPjyy4GrPyRxqG6oUcAC8xvBheNiQyc7pkw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fFt+nDBQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7399606A324
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 18:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fFt+nDBQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D02D21F00A05;
	Wed, 11 Nov 2026 18:04:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794420289;
	bh=whYFr35S7ALTsTHlsM+B3tJFzRmTe5FaPPModDhaD/I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fFt+nDBQ4wsYT0/pxJZFH0piDPByltVMznK+i6FkG/oCXmsdQ9ReiL/hc9zTrrqOX
	 9JA0g26C3yNDCgCXNdX9WzfKkrLxOS27tgS6yPj7NxWFXWUVK3MA7PFx9MEyowtrdE
	 f9kWDNxaO6MQEHmh2XoUuxUySWYag5Ldd+oRciqppmnZxhgCJjSCtRFh6+HnptOgUS
	 e+x2pWI7tsc6tTSha2ZhwgkIU86cRqoTL5KgOCzGtM3l7Xjol5slIk8eaS6wHUn0fz
	 0x2fBM2iBiGl4j01e8o5qYvwXXuISmrw2lEnHEmtHke5cnJe3z/VoCvuqY3rlnch51
	 +OrD18ans4Akw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Andrea Parri <parri.andrea@gmail.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] iommufd/iova_bitmap: Ensure that iova_bitmap_set() handles the full IOVA
Date: Wed, 11 Nov 2026 13:04:47 -0500
Message-ID: <20261111180427.3717784-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107051152-failed-6.18-e21952d72b47@kernel.org>
References: <20261107051152-failed-6.18-e21952d72b47@kernel.org>
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
[ sashal: Added missing prerequisite support for recording bitmap errors and propagating them through the iterator to the ioctl caller. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iommu/iommufd/io_pagetable.c |  2 +-
 drivers/iommu/iommufd/iova_bitmap.c  | 18 +++++++++++++++++-
 include/uapi/linux/iommufd.h         |  6 ++++++
 3 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/iommufd/io_pagetable.c b/drivers/iommu/iommufd/io_pagetable.c
index 77891d4d65fb1..a6face8a46f58 100644
--- a/drivers/iommu/iommufd/io_pagetable.c
+++ b/drivers/iommu/iommufd/io_pagetable.c
@@ -552,7 +552,7 @@ iommu_read_and_clear_dirty(struct iommu_domain *domain,
 	arg.iopt = iopt;
 	arg.domain = domain;
 	arg.dirty = &dirty;
-	iova_bitmap_for_each(iter, &arg, __iommu_read_and_clear_dirty);
+	ret = iova_bitmap_for_each(iter, &arg, __iommu_read_and_clear_dirty);
 
 	if (!(flags & IOMMU_DIRTY_NO_CLEAR))
 		iommu_iotlb_sync(domain, &gather);
diff --git a/drivers/iommu/iommufd/iova_bitmap.c b/drivers/iommu/iommufd/iova_bitmap.c
index b5b67a9d3fb35..3a7eca3c7d989 100644
--- a/drivers/iommu/iommufd/iova_bitmap.c
+++ b/drivers/iommu/iommufd/iova_bitmap.c
@@ -116,6 +116,8 @@ struct iova_bitmap {
 
 	/* length of the IOVA range for the whole bitmap */
 	size_t length;
+
+	int err;
 };
 
 /*
@@ -384,7 +386,9 @@ static int iova_bitmap_advance_to(struct iova_bitmap *bitmap,
 int iova_bitmap_for_each(struct iova_bitmap *bitmap, void *opaque,
 			 iova_bitmap_fn_t fn)
 {
-	return fn(bitmap, bitmap->iova, bitmap->length, opaque);
+	int ret = fn(bitmap, bitmap->iova, bitmap->length, opaque);
+
+	return ret ? ret : bitmap->err;
 }
 EXPORT_SYMBOL_NS_GPL(iova_bitmap_for_each, "IOMMUFD");
 
@@ -404,6 +408,18 @@ void iova_bitmap_set(struct iova_bitmap *bitmap,
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
index bdd20666d1eb1..65e564965e98a 100644
--- a/include/uapi/linux/iommufd.h
+++ b/include/uapi/linux/iommufd.h
@@ -775,6 +775,12 @@ enum iommufd_hwpt_get_dirty_bitmap_flags {
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

