Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B99E72D5C68
	for <stable@vger.kernel.org>; Sat, 12 Sep 2026 16:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789229139; cv=none; b=UgVc/nkKfs9Uh0c4KbO8yusCMC1hSRYn8bbPbPGQFGGUl4dJ0wDYSuz7vmVbVnI2raVpjzus4RtVF+hVdA1x0N7lDU8VA+1xxPJs305xvvUJIVVVHmqf2hTfXtliwpI3taX4TqDZoygLA0OPaTF5pfv4MecgpA6FsHp5ZkKE0ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789229139; c=relaxed/simple;
	bh=gjTlVJdgnAaL22btZ8k1APr9zTZjSEXJecksj4vA3RQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=udxqQRatvDedlkOH65WnD2O7NKbuluGJQnPhivOzCMnEf0oh0rFjeFe+m2VIsDFXtjZ+d9nathi8puAWhgtlFUB61d+bwFI4i/sC8iCZWgCe1EkRhUcvSO8MIE6RdSXuTrz/tLZQK2L1k/dTaErtGG5p4ETiDOC894DnoKxII/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RxOsjT1x; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RxOsjT1x"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 012601F000FF;
	Sat, 12 Sep 2026 16:05:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789229138;
	bh=5GCXF6Bvp4Fbng8CT18aiyS4cyovxgq49pp33BwNfJQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RxOsjT1xxeFjRPltcbMfpfrkXlTIyKX9KlZrlG3Uf9/S8b0g1qj0oUaVEcma15S+L
	 NFvRr/cJzoeJHKzfFD5C4f1zpe/nvnE7/x/pgr05Un2d/59W+0OXLHJpcNiVuKt7PN
	 /vjMl9qqIImuDd5PPv/GwJnTApBY3KYjggWbSgExJ5NOHMpISlwD0FIfoHkt4bDS26
	 usnrJ3T/x54gPzW1/CFpdcB0+HzmJ4ekTYZ8piThDwvj6wvzyLpMHs/51qSGqXipaD
	 pz3PIlKPvJCwFgLNApNytZboneN4Alvhq4T81L/uFOkO4CpihgomV+3Wgs9APHH1nC
	 DgJxsCOnlvs0w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Matthew Brost <matthew.brost@intel.com>,
	Sashiko <sashiko-bot@kernel.org>,
	Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.2.y] drm/pagemap: dma-unmap pages before handling migration errors
Date: Sat, 12 Sep 2026 12:05:36 -0400
Message-ID: <20260912160536.3614798-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090928-daisy-vitamins-0900@gregkh>
References: <2026090928-daisy-vitamins-0900@gregkh>
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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/drm_pagemap.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/drm_pagemap.c b/drivers/gpu/drm/drm_pagemap.c
index 05eb7254028f7..51c6f12e42560 100644
--- a/drivers/gpu/drm/drm_pagemap.c
+++ b/drivers/gpu/drm/drm_pagemap.c
@@ -1260,12 +1260,12 @@ int drm_pagemap_evict_to_ram(struct drm_pagemap_devmem *devmem_allocation)
 		goto err_finalize;
 
 err_finalize:
+	drm_pagemap_migrate_unmap_pages(devmem_allocation->dev, pagemap_addr, dst, npages,
+					DMA_FROM_DEVICE, &state);
 	if (err)
 		drm_pagemap_migration_unlock_put_pages(npages, dst);
 	migrate_device_pages(src, dst, npages);
 	migrate_device_finalize(src, dst, npages);
-	drm_pagemap_migrate_unmap_pages(devmem_allocation->dev, pagemap_addr, dst, npages,
-					DMA_FROM_DEVICE, &state);
 
 err_free:
 	kvfree(buf);
@@ -1383,14 +1383,14 @@ static int __drm_pagemap_migrate_to_ram(struct vm_area_struct *vas,
 		goto err_finalize;
 
 err_finalize:
-	if (err)
-		drm_pagemap_migration_unlock_put_pages(npages, migrate.dst);
-	migrate_vma_pages(&migrate);
-	migrate_vma_finalize(&migrate);
 	if (dev)
 		drm_pagemap_migrate_unmap_pages(dev, pagemap_addr, migrate.dst,
 						npages, DMA_FROM_DEVICE,
 						&state);
+	if (err)
+		drm_pagemap_migration_unlock_put_pages(npages, migrate.dst);
+	migrate_vma_pages(&migrate);
+	migrate_vma_finalize(&migrate);
 err_free:
 	kvfree(buf);
 err_out:
-- 
2.53.0

