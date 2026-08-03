Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB3C9346E67;
	Mon,  3 Aug 2026 11:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785757372; cv=none; b=nkLiQLw/MOFOSqH3m/6nD9agy2YA/NDOkagFXfP/xE4WNeAQA5rU6nsejoNnEKyKqXXxE0s9SlZRYYg6JEthZCrz3jQFW1kG4Ybck9tYISsKdKqjG+KIaYDtXgAwx+mkFtQs2ik2SRSS7hdjAwxgYF2yPgGzfm2RCNrXw8F9ypA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785757372; c=relaxed/simple;
	bh=rTZkIZ7AYzr5sng+Sl6nOq/HMvBWuORNE+oAA4/Mn1g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RNKYPagPqR8aJZtmCq8xV3nbZJ73SthYvq6tEaCh1OZeBDSX5/j/rMWiBKFkKdOUtMFjxllWO4ySh2E5Q2/qgY6/wJ/PrLT7ITM4MCMmVhgoG9JBJcKS32ipSbzDXLCl3D97t7nrCEexlb7FlUGB4Ntt1LEB4rMyy1TQ6iCWw34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=KdK2pad3; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="KdK2pad3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=KH
	2vsK1iA0+4XbVZyzVdP7cOlJFNtlG2C9n5rWR/HN8=; b=KdK2pad3dP1tEqwueQ
	YdScdlk+kklDXSaz/dncp02ApdUues7Pl7kHVRxD0tXQN2hEke0jIU95LIrtVBLa
	GRyLAspmtelJmefZUcuuv6epz9huqNnnnH8Zu7PXj3lbGC1ze2nlkB1VsCqSGsOB
	gWSQj6aUc0r1nGzmbIbTf1v3Q=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id _____wA3lCV8fnBqaDgbMA--.41059S2;
	Mon, 03 Aug 2026 19:41:49 +0800 (CST)
From: albin_yang@163.com
To: gregkh@linuxfoundation.org,
	baolu.lu@linux.intel.com
Cc: joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	jgg@ziepe.ca,
	akpm@linux-foundation.org,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	albinwyang@tencent.com
Subject: [PATCH 6.6] iommu/sva: move x86 disable check before allocation
Date: Mon,  3 Aug 2026 19:40:39 +0800
Message-ID: <20260803114039.319953-1-albin_yang@163.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wA3lCV8fnBqaDgbMA--.41059S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxJrW5WrW5ZF15GFW7uw1kGrg_yoW8tF1rpF
	WrK34YvFW5tF18G3W2krs5ury5tw4vga4Yqw15W395ur15tFW5KF9YqF4UW34UWrW5Aa1f
	J3WDXwsxCF45A37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jniSdUUUUU=
X-CM-SenderInfo: pdoex0xb1d0wi6rwjhhfrp/xtbC7x11GGpwfn3hggAA3l

From: Wei Yang <albinwyang@tencent.com>

Backport of commit 72f98ef9a4be ("iommu: disable SVA when CONFIG_X86 is
set") placed the IS_ENABLED(CONFIG_X86) early-return in
iommu_sva_bind_device() after iommu_sva_alloc_pasid() and kzalloc(handle),
while upstream puts it at the function start.

On x86 this leaks the kzalloc'd struct iommu_sva (early return skips
kfree) and a globally allocated PASID (mm->pasid wrongly set, never
unbound). Move the check before any allocation/side effect.

Fixes: 240cd7f2812c ("iommu: disable SVA when CONFIG_X86 is set")

Signed-off-by: Wei Yang <albinwyang@tencent.com>
---

This is a stable-only fix for the linux-6.6.y tree.

The buggy commit 240cd7f2812c ("iommu: disable SVA when CONFIG_X86 is set")
is a backport of upstream commit 72f98ef9a4be ("iommu: disable SVA when
CONFIG_X86 is set") to 6.6. The upstream version places the
IS_ENABLED(CONFIG_X86) early-return at the start of iommu_sva_bind_device(),
but the 6.6 backport placed it after iommu_sva_alloc_pasid() and
kzalloc(handle), causing the leak described above. The upstream/mainline
code is correct, so this fix is not needed there and only applies to 6.6.

Please double-check against upstream commit 72f98ef9a4be before applying.
---
 drivers/iommu/iommu-sva.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/iommu-sva.c b/drivers/iommu/iommu-sva.c
index 611733c02b7c..a340b805b82b 100644
--- a/drivers/iommu/iommu-sva.c
+++ b/drivers/iommu/iommu-sva.c
@@ -62,6 +62,9 @@ struct iommu_sva *iommu_sva_bind_device(struct device *dev, struct mm_struct *mm
 	struct iommu_sva *handle;
 	int ret;
 
+	if (IS_ENABLED(CONFIG_X86))
+		return ERR_PTR(-EOPNOTSUPP);
+
 	/* Allocate mm->pasid if necessary. */
 	ret = iommu_sva_alloc_pasid(mm, dev);
 	if (ret)
@@ -71,9 +74,6 @@ struct iommu_sva *iommu_sva_bind_device(struct device *dev, struct mm_struct *mm
 	if (!handle)
 		return ERR_PTR(-ENOMEM);
 
-	if (IS_ENABLED(CONFIG_X86))
-		return ERR_PTR(-EOPNOTSUPP);
-
 	mutex_lock(&iommu_sva_lock);
 	/* Search for an existing domain. */
 	domain = iommu_get_domain_for_dev_pasid(dev, mm->pasid,
-- 
2.43.7

