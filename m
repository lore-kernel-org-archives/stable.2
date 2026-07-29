Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F70B44C50F
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 10:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785322145; cv=none; b=nrsUPCsLJ4dZF0AgzGkWDS45qQhdu22MF+QANZI7cD5UvPvl/0kcwf4aFzUwmkgQUz+rH5VWvSjprkahmlr6LxvQbq3IJ/ULis5cddlORqOpgftg/yDrK3x149JeXFxDJ4n/ksldDcCiI2WxED49m1SYvoOdb8StWnc0cjle68Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785322145; c=relaxed/simple;
	bh=x+ZnYtqItBS+NU56XYCZMdifDF7edsn0GoImML5LgOo=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=p284iSMQt1Ru21yJiB3SwnaeRfoMlJYkTYme//zkpKi4x6I4hRHrqZ2ZWihHjbVJ4zi4EfTkfOaCHIr9VQMzerjWt61zyEi7KKvqGhZ4nQ6tbjM8UpXAQnKTWwkAhKs+Jkb8leyR3mKGtP7MuiwaiK3XTaDThz8OAK69W/jx5sE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hxNF3Sm0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hxNF3Sm0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 453791F000E9;
	Wed, 29 Jul 2026 10:49:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785322143;
	bh=KPZ6+xfdK156S4rIOXzmE4Rg2bD6OpvDxZfg6NQyPFU=;
	h=Subject:To:Cc:From:Date;
	b=hxNF3Sm0RnLDSmbnliiuu06qJGm20hOEy8U7GxREWvU1tZyY9dQl3p7RnSxB46hn5
	 Gjoij6FB+oPI2E8DcT1c5cmRtFL8/DJZDBVLshuArAfJUc/NATcXoyU46bsuSDit9O
	 fa9qh0Rdf2IqeEIATvv0/aWLNHqAvxtIbLVxGvNM=
Subject: FAILED: patch "[PATCH] drm/xe: Set TTM device beneficial_order to 9 (2M)" failed to apply to 7.1-stable tree
To: matthew.brost@intel.com,andi.shyti@linux.intel.com,thomas.hellstrom@linux.intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 29 Jul 2026 12:48:50 +0200
Message-ID: <2026072950-giggling-gooey-3782@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 7.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-7.1.y
git checkout FETCH_HEAD
git cherry-pick -x ba7fd163422877ad5a5cf31306a38c07d3932b0c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072950-giggling-gooey-3782@gregkh' --subject-prefix 'PATCH 7.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From ba7fd163422877ad5a5cf31306a38c07d3932b0c Mon Sep 17 00:00:00 2001
From: Matthew Brost <matthew.brost@intel.com>
Date: Thu, 11 Jun 2026 16:58:44 -0700
Subject: [PATCH] drm/xe: Set TTM device beneficial_order to 9 (2M)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Set the TTM device beneficial_order to 9 (2M), which is the sweet
spot for Xe when attempting reclaim on system memory BOs, as it matches
the large GPU page size. This ensures reclaim is attempted at the most
effective order for the driver.

This fixes an issue where an order-10 (4M) allocation cannot be found
despite an abundance of memory. The 4M allocation triggers reclaim,
unnecessarily evicting the working set and hurting performance. Since
the TTM infrastructure was introduced recently, we are tagging the TTM
patch as the Fixes target, even though this resolves an Xe-side problem.

Fixes: 7e9c548d3709 ("drm/ttm: Allow drivers to specify maximum beneficial TTM pool size")
Cc: stable@vger.kernel.org
Signed-off-by: Matthew Brost <matthew.brost@intel.com>
Reviewed-by: Andi Shyti <andi.shyti@linux.intel.com>
Reviewed-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Link: https://patch.msgid.link/20260611235844.3725147-1-matthew.brost@intel.com
(cherry picked from commit 0d81db90d364cb3d733410829118759f28957c5a)
Signed-off-by: Matthew Brost <matthew.brost@intel.com>

diff --git a/drivers/gpu/drm/xe/xe_device.c b/drivers/gpu/drm/xe/xe_device.c
index d224861b6f6f..abe25aedeead 100644
--- a/drivers/gpu/drm/xe/xe_device.c
+++ b/drivers/gpu/drm/xe/xe_device.c
@@ -526,7 +526,8 @@ int xe_device_init_early(struct xe_device *xe)
 
 	err = ttm_device_init(&xe->ttm, &xe_ttm_funcs, xe->drm.dev,
 			      xe->drm.anon_inode->i_mapping,
-			      xe->drm.vma_offset_manager, 0);
+			      xe->drm.vma_offset_manager,
+			      TTM_ALLOCATION_POOL_BENEFICIAL_ORDER(get_order(SZ_2M)));
 	if (err)
 		return err;
 

