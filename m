Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9811481ABE
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 12:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785328938; cv=none; b=kKbyq0r/omYKoNnOqMrXrEZtHutfOW16DPqw1HFOI+WjbmQ6fySmvxxf+TMTEMQSZ7xtOGwt6c/9AFZzwLkxN0LK0nbEPNvGJeApC1IdVNH5ExBUQr5ynMBE5/AOoPZigqvD/vGbt/dETkxX4NnveX/bG/Q9s1rPIEQm1x16KtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785328938; c=relaxed/simple;
	bh=35u4nhUuATjJ4qDynd2UdVchSwC39XaHPJwI/JxuLFw=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=CGcL5gaTEiWWbcGKstraGWl8lb5HFx0UoGXBvZoRsUEk2BNuMHXv6G8/9dwRjbuN9FzBGYhcYTvRdq7W1MPsqmaSWvK7hUSzKua+F8B0yed27mrIZVGLb4hL+HESdUkwU6nSEmugUVPV2WXfQ1IfOUwSc/iNxi1DvlEqnmute2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2uby6IbP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2uby6IbP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 762AC1F00A3E;
	Wed, 29 Jul 2026 12:42:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785328930;
	bh=ld7fEwa5Hu1aWbD7Ip4HwfXaFSw8yVFAMfjt+7UD3zc=;
	h=Subject:To:Cc:From:Date;
	b=2uby6IbPxFCEUuu2Ld9Ze4huL/OcUz/xOfAt7JSiJ2UJXt4fh6iwmE+Wrmu/wFThO
	 ViEnDtvMPZSWipw6XkFCt2ivS5Ht3RAoWKP6w20wvUNfVPXq22e9w4nMCpGpueU0pu
	 /EMfMw5SDoFnt8gRYV+Ur0XyCCOgAiLO3jukzcg0=
Subject: FAILED: patch "[PATCH] drm/gpusvm: publish dpagemap early to avoid device mapping" failed to apply to 6.18-stable tree
To: honghuan@amd.com,matthew.brost@intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 29 Jul 2026 14:41:12 +0200
Message-ID: <2026072912-heritage-womb-d38a@gregkh>
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
git cherry-pick -x 7f708f51e3955bda0d77a0b67ab9bea6c97fea99
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072912-heritage-womb-d38a@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 7f708f51e3955bda0d77a0b67ab9bea6c97fea99 Mon Sep 17 00:00:00 2001
From: Honglei Huang <honghuan@amd.com>
Date: Wed, 1 Jul 2026 14:28:00 +0800
Subject: [PATCH] drm/gpusvm: publish dpagemap early to avoid device mapping
 leak on error

drm_gpusvm_get_pages() only stored the local dpagemap into
svm_pages->dpagemap on the success path. If a later page failed (e.g.
-EOPNOTSUPP when ctx->allow_mixed is false) and jumped to err_unmap,
svm_pages->dpagemap was still NULL, so __drm_gpusvm_unmap_pages() skipped
device_unmap() and leaked the device mappings already created.

Assign svm_pages->dpagemap when the first device page is mapped so the
err_unmap path can device_unmap() those mappings.

This issue was found by Sashiko AI review.

Fixes: f70da6f99d4f ("drm/gpusvm: pull out drm_gpusvm_pages substructure")
Cc: stable@vger.kernel.org
Reviewed-by: Matthew Brost <matthew.brost@intel.com>
Signed-off-by: Honglei Huang <honghuan@amd.com>
Signed-off-by: Matthew Brost <matthew.brost@intel.com>
Link: https://patch.msgid.link/20260701062800.409248-4-honghuan@amd.com

diff --git a/drivers/gpu/drm/drm_gpusvm.c b/drivers/gpu/drm/drm_gpusvm.c
index 44bb19658dd6..9a06ff7d2608 100644
--- a/drivers/gpu/drm/drm_gpusvm.c
+++ b/drivers/gpu/drm/drm_gpusvm.c
@@ -1544,6 +1544,16 @@ int drm_gpusvm_get_pages(struct drm_gpusvm *gpusvm,
 					err = -EAGAIN;
 					goto err_unmap;
 				}
+
+				/*
+				 * Set the dpagemap as soon as the first
+				 * device page is mapped so the err_unmap path
+				 * can device_unmap() the device mappings that
+				 * have already been created.
+				 */
+				drm_pagemap_get(dpagemap);
+				drm_pagemap_put(svm_pages->dpagemap);
+				svm_pages->dpagemap = dpagemap;
 			}
 			svm_pages->dma_addr[j] =
 				dpagemap->ops->device_map(dpagemap,
@@ -1611,12 +1621,8 @@ int drm_gpusvm_get_pages(struct drm_gpusvm *gpusvm,
 			goto err_unmap;
 	}
 
-	if (pagemap) {
+	if (pagemap)
 		flags.has_devmem_pages = true;
-		drm_pagemap_get(dpagemap);
-		drm_pagemap_put(svm_pages->dpagemap);
-		svm_pages->dpagemap = dpagemap;
-	}
 
 	/* WRITE_ONCE pairs with READ_ONCE for opportunistic checks */
 	WRITE_ONCE(svm_pages->flags.__flags, flags.__flags);

