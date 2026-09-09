Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D664254CF41
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 12:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788955703; cv=none; b=H7tbj5iahRLrKAAkYHBHE9mE2FjBCsraeCB0MG2vVQi1TgwZNe02/9m9FGyCp+3+BEqY3lFs+JnlPPDczZEvrbg3Ges+iYLRIcCrujujnr4vuPA2gNchxcnSIhiMv/d6MeiwhAf8RkyG0Gxg2p94wthKftzgv869LghnuiRCy+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788955703; c=relaxed/simple;
	bh=ZumE+dm/IxmY/jZaNy/5RocTY7R1RelIYKrtQS7omz4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=BfUIKZDBuxtsBaRVVbmUm7jsFTjKkq1t6R1CjG5K70BgII+QCMYILAqNQYfAl5alHkF7KAhaqQPr+6nNocWuzv8aXVJ8R2RCOr7mj7QTIUc7oPiKwih1iP1fTmWEu+HWc4s4kZeKGzN3iI/QGOAem9aggw+Lapbyds+lspGs4ZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=g8m2ET3O; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="g8m2ET3O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 061311F00A3A;
	Wed,  9 Sep 2026 12:08:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788955701;
	bh=qhtOAfMgn0z4KePidPVNUyGwJ2yP4q1Ko+Po7RCTl1c=;
	h=Subject:To:Cc:From:Date;
	b=g8m2ET3OWhvGSfwKzGO75xWIwRIlfN1sLSSpmcLxL7KTBcNrVjkHnXkrsuZColPq4
	 HV5vW33wMCKByAEZ0lhQfohShgywZIlIO34o9ofeingbVkvDNkoVlGPLTlUyplt5Pm
	 deHV9ZOd+P5CiWCVkmn0eJSkEBA9l/eG55G9jj7I=
Subject: FAILED: patch "[PATCH] drm/pagemap: dma-unmap pages before handling migration errors" failed to apply to 6.18-stable tree
To: matthew.brost@intel.com,himal.prasad.ghimiray@intel.com,sashiko-bot@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 09 Sep 2026 14:02:28 +0200
Message-ID: <2026090928-junkyard-knee-1e95@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 9e6372ec2a3990662ae0a67f56ac0aee19848d5b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090928-junkyard-knee-1e95@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 9e6372ec2a3990662ae0a67f56ac0aee19848d5b Mon Sep 17 00:00:00 2001
From: Matthew Brost <matthew.brost@intel.com>
Date: Tue, 1 Sep 2026 23:35:03 -0700
Subject: [PATCH] drm/pagemap: dma-unmap pages before handling migration errors

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

diff --git a/drivers/gpu/drm/drm_pagemap.c b/drivers/gpu/drm/drm_pagemap.c
index 097a900cf55d..6aa745682270 100644
--- a/drivers/gpu/drm/drm_pagemap.c
+++ b/drivers/gpu/drm/drm_pagemap.c
@@ -1283,13 +1283,13 @@ int drm_pagemap_evict_to_ram(struct drm_pagemap_devmem *devmem_allocation)
 		goto err_finalize;
 
 err_finalize:
+	drm_pagemap_migrate_unmap_pages(devmem_allocation->dev, pagemap_addr, dst, npages,
+					DMA_FROM_DEVICE, &state);
 	if (err)
 		drm_pagemap_migration_unlock_put_pages(npages, dst);
 	migrate_device_pages(src, dst, npages);
 	drm_pagemap_retire_migrated_pages(src, npages);
 	migrate_device_finalize(src, dst, npages);
-	drm_pagemap_migrate_unmap_pages(devmem_allocation->dev, pagemap_addr, dst, npages,
-					DMA_FROM_DEVICE, &state);
 
 err_free:
 	kvfree(buf);
@@ -1416,15 +1416,15 @@ static int __drm_pagemap_migrate_to_ram(struct vm_area_struct *vas,
 		goto err_finalize;
 
 err_finalize:
+	if (dev)
+		drm_pagemap_migrate_unmap_pages(dev, pagemap_addr, migrate.dst,
+						npages, DMA_FROM_DEVICE,
+						&state);
 	if (err)
 		drm_pagemap_migration_unlock_put_pages(npages, migrate.dst);
 	migrate_vma_pages(&migrate);
 	drm_pagemap_retire_migrated_pages(migrate.src, npages);
 	migrate_vma_finalize(&migrate);
-	if (dev)
-		drm_pagemap_migrate_unmap_pages(dev, pagemap_addr, migrate.dst,
-						npages, DMA_FROM_DEVICE,
-						&state);
 err_free:
 	kvfree(buf);
 err_out:

