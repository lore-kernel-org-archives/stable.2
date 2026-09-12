Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1629418DB35
	for <stable@vger.kernel.org>; Sat, 12 Sep 2026 20:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789246760; cv=none; b=iwrf55BOJQ7KFj4kOk4skN/9or3m5I6uJG8aB5DOmxndhkcTvY4sA3Gf/CVNmugj+q/cSKmMtskukXyfVp13jorWHVC5kQ/wjO2s1Mzq8YKwqbEgM0VmqiAV50yQUCbtMeIo0ax7N6Vsz7H2tE0eD0aKVMhTfEmMGWDK156MOxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789246760; c=relaxed/simple;
	bh=tUaKYYe7CqtWwBM0LbahrfhgOlwPGTGYaYwgayclEVw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kbYOlcv4f0cFKmEmwN4jPTY6jy6oGir4n+xvrMnUnatNKo5Z9rKv2t3e/ZHfdlYQ6MBFNNcz+9VdCpVvQEjeSJ4NVRW5YtbtQsQTm5c9T2XQVcBsKxTb5TVQBNjGDVTxmA7cfxJGu2EtarssE0phe4WSIuGrV2DWLx6FiqRDjeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EX2kHQfe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EX2kHQfe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BB031F000FF;
	Sat, 12 Sep 2026 20:59:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789246758;
	bh=0LMpwG9k0cPAinnBM7HcTVcRbojeiPh93zaGeXJYvfQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EX2kHQfehEaIfQTctdXT9ga3N44V+wn+PBhQl5tUNFlw2RaD797PuRMttI1q6xIH8
	 ua7Il77lb2+bjfjYvjAqZZkWG/vvFTpbqe3QZgDJqPNn3l8GZyhw+cAuydUKXKmTBu
	 7tYVjrfrcREokMLEaO9mMVpvOVsVsPrAF9+oUudMQdkjr4YW6J0F4Dm7RBci38EF6a
	 Fws81mX+6rbFKam7INeYdbJHXBjyLyJgvL+m7BliK34/0VQewjgukhnyuHgllrSzJ1
	 TGPN639HZygcUnBmO4bkJAQ745TjEbYcJLLZys5JQZiOJwjyVbkdQJzShKaNrDg86n
	 dCssAwkT0Puug==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Matthew Brost <matthew.brost@intel.com>,
	Sashiko <sashiko-bot@kernel.org>,
	Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] drm/pagemap: dma-unmap pages before handling migration errors
Date: Sat, 12 Sep 2026 16:59:16 -0400
Message-ID: <20260912205916.3934353-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090928-junkyard-knee-1e95@gregkh>
References: <2026090928-junkyard-knee-1e95@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Matthew Brost <matthew.brost@intel.com>

[ Upstream commit 9e6372ec2a3990662ae0a67f56ac0aee19848d5b ]

drm_pagemap_migrate_unmap_pages() relies on the pages array to determine
which pages require DMA unmapping. However,
drm_pagemap_migration_unlock_put_pages() clears the array as part of its
cleanup, leaving drm_pagemap_migrate_unmap_pages() with no valid page
information if it is called afterward.

Call drm_pagemap_migrate_unmap_pages() before
drm_pagemap_migration_unlock_put_pages() so the pages array remains
valid during DMA unmapping.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Fixes: f86ad0ed620c ("drm/gpusvm, drm/pagemap: Move migration functionality to drm_pagemap")
Cc: stable@vger.kernel.org
Signed-off-by: Matthew Brost <matthew.brost@intel.com>
Reviewed-by: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
Link: https://patch.msgid.link/20260902063504.3024362-1-matthew.brost@intel.com
[ Adapted DMA-unmap calls to the older helper signature without destination-page or IOVA-state arguments. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/drm_pagemap.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/drm_pagemap.c b/drivers/gpu/drm/drm_pagemap.c
index 445cf0e6589fa..4cd5182f82051 100644
--- a/drivers/gpu/drm/drm_pagemap.c
+++ b/drivers/gpu/drm/drm_pagemap.c
@@ -606,12 +606,12 @@ int drm_pagemap_evict_to_ram(struct drm_pagemap_devmem *devmem_allocation)
 		goto err_finalize;
 
 err_finalize:
+	drm_pagemap_migrate_unmap_pages(devmem_allocation->dev, pagemap_addr, npages,
+					DMA_FROM_DEVICE);
 	if (err)
 		drm_pagemap_migration_unlock_put_pages(npages, dst);
 	migrate_device_pages(src, dst, npages);
 	migrate_device_finalize(src, dst, npages);
-	drm_pagemap_migrate_unmap_pages(devmem_allocation->dev, pagemap_addr, npages,
-					DMA_FROM_DEVICE);
 err_free:
 	kvfree(buf);
 err_out:
@@ -742,13 +742,13 @@ static int __drm_pagemap_migrate_to_ram(struct vm_area_struct *vas,
 		goto err_finalize;
 
 err_finalize:
+	if (dev)
+		drm_pagemap_migrate_unmap_pages(dev, pagemap_addr, npages,
+						DMA_FROM_DEVICE);
 	if (err)
 		drm_pagemap_migration_unlock_put_pages(npages, migrate.dst);
 	migrate_vma_pages(&migrate);
 	migrate_vma_finalize(&migrate);
-	if (dev)
-		drm_pagemap_migrate_unmap_pages(dev, pagemap_addr, npages,
-						DMA_FROM_DEVICE);
 err_free:
 	kvfree(buf);
 err_out:
-- 
2.53.0

