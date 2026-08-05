Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 133E22F7F1C
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 12:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785933889; cv=none; b=u0uA6vN39vWzc1k+IWHNQb8zSoawmR/bna4SpTRMtbJB/eroAq1LsixWihw+S0xBxJzIgk42f3e1Ds9i6xSf8dR5Bu2/lzbR9VspkwBIgIF8pfsOhaKuFNEvLqEBMYOUfsT15zvixkJty6duMYRh1sng46iyvTPqb2RdOJBgBnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785933889; c=relaxed/simple;
	bh=U1oYV/7Y80Kw7sQVX5AYhCc6Q2KJnxdNduTSaTv1L4E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aMVwBUCmrk3aUu1+O2RlKGFpS0P9AOUeqv5Hd2hBKWM544t9LUpYeEut8YZNns4s000V+DIVB6NwiqQNctr6hC+Bu6dr1s53kXoYS9gAjNcBywUld6K94d/RwjnqaCG925E7mbPds8NqjPD7ylsQNST8HFp1kHKTzCmmaRtUb1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xbow.com; spf=pass smtp.mailfrom=xbow.com; dkim=pass (2048-bit key) header.d=xbow.com header.i=@xbow.com header.b=Ph9BgSLg; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xbow.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xbow.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xbow.com header.i=@xbow.com header.b="Ph9BgSLg"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-cb5b8572b70so988059a12.2
        for <stable@vger.kernel.org>; Wed, 05 Aug 2026 05:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=xbow.com; s=google; t=1785933887; x=1786538687; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=QBugC61SebRfHUYlxhe8LyjAwmlc8xHKfpXGCT71Nbs=;
        b=Ph9BgSLgjVFnUu6h3rFcHkWsGMvGvHWzLtPpMuHhlacjl8MHnUb+F4FR3bFUxY9ilm
         4WRLG9e3rHYet15ixZRBkH2nkYBcFI6n6Fp+3ryHj7ifdsHZI9kUosK5/ffiJuUi1hFI
         VN/oui4PZB8sD90gkcfQ6YRMHQa6sJJ9mwt46D0KTGfeWxxb+FvveHMJmZVgM6LIr2uR
         JP6VP6WosvCIzfTVUONHIufFHv0Uq6Pg8akhawBjFw68LZonDJfIlYT8hcjDILDMy19E
         jj74rUycQqU8JUXsvD0GoQLgPAF9xlH33CWfMYeleqk3JCZsS3TtIEMBvW3NOScARAGg
         EThA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785933887; x=1786538687;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QBugC61SebRfHUYlxhe8LyjAwmlc8xHKfpXGCT71Nbs=;
        b=sgAjnOu5gR41sgijY0gqpFgqQKqkRPsFFrrT/DCCGrLdFT+lWuoA+p6aiLkQmeUCND
         +5rTdU8OJNs4qwYc6+LzUUdzKLQN0gZgXFrvpV3n12nmYySeyiuCmPU0o/RY+MK4wUC1
         Cu01KxxCaSYfgsYLKc2SKtUF5DphSKT8fZTAr/6VEbks5jyAR25N3RWmyBPx8mhV70np
         fr9+M0ic1k1O+iCXkF2RD+fIKh4qaUUPtmTXeRRuTIgob+lg48LugAN/+i+MhleuidWm
         hEK70YT2nwEIcyrRFAIokiA89w16JYb9Ya90lgOH+AkTWitmIniNy+a6TIWxU7xWnWyO
         U5TA==
X-Forwarded-Encrypted: i=1; AHgh+RqkEy/5AI7//QAutcFwrL3B1sVVJR7Is9OevjjzIr6de8S1trDsGhg8SP3/3uWvNfuMaJv8lvY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVswTyRhrOUNptohwvkCHs0jTl69e9zabUeuAHkzKBQOp6lUpv
	RHf0IDqMU+fmkY6xx2OxTcKfw+wRTmx4oH4sjdbkTyYLGMLVkOvQWie8Gi4Q82+Fnt4=
X-Gm-Gg: AR+sD12VTJyuCVnWbRvJBVzAFvKuCKbWqvozDJIzqOhPrjTcyV4HA7xA+uCuqn+0kza
	9JHfc32Md94HpIyqngso3YogN9TeLchn4eH7vL0uqULeKZ3d4uwnU9rmK1eN1j1nxk5doV7Hx9l
	MGeAp5p/2fvjsJCNb687VIH+TE/mUBevySH/a66diSmz+F/4zjHYRoqM8/bbrcjUrjKPwK0b3mi
	zJ4eArAbXjaaTIkIJ6ogEPDb6S8PO0iLE1WJE7Bv9S1sjyagTjg1EFrrTIT5Tk+t18ADcZ48e0I
	L9fCVv2RX0KyzRinu0DD7GSmKal88/bMmWdSmE0XJRsdjM0kPMzsDXAXWJbP+WwFVJCYZgBllzO
	l+9rjo2qE5Whe+N0gpP4YqkJ1Tmfz0XDXqjEBq3pAC/z076WAYNQr1BYVLcI7HIFW17TNk30nS+
	wJjFl+F5wST2VCQh+UxRiY/L87ynutcqNrVrH2pbZBjXjLFm6GAgdhilcCTvZ2RtP13TscirwNU
	V/Gr9/Xc0qNRCMRwtM9J9V23nJ0M7kZ1HMv3IQ=
X-Received: by 2002:a05:6a00:4b43:b0:845:e2da:91a3 with SMTP id d2e1a72fcca58-84f2e0276ddmr6987044b3a.30.1785933887134;
        Wed, 05 Aug 2026 05:44:47 -0700 (PDT)
Received: from Mac.lan ([125.128.148.126])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cbe707cab37sm1546962a12.7.2026.08.05.05.44.44
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 05 Aug 2026 05:44:46 -0700 (PDT)
From: Baul Lee <baul.lee@xbow.com>
To: maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Baul Lee <baul.lee@xbow.com>
Subject: [PATCH] drm/gem-dma: fix double GEM object put on the mmap error path
Date: Wed,  5 Aug 2026 21:44:42 +0900
Message-ID: <20260805124442.57426-1-baul.lee@xbow.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

drm_gem_dma_mmap() drops a GEM reference when the DMA mapping fails:

	if (ret)
		drm_gem_vm_close(vma);

drm_gem_vm_close() puts vma->vm_private_data.  drm_gem_mmap_obj() has
already pointed that at the object, and puts it again when the callback
returns an error:

	drm_gem_object_get(obj);
	vma->vm_private_data = obj;
	...
	ret = obj->funcs->mmap(obj, vma);
	if (ret)
		goto err_drm_gem_object_put;

One get, two puts: a failing dma_mmap_wc() or dma_mmap_pages() underflows
the reference count and can free the object while the caller still holds
it.

The callee does not own that reference.  drm_gem_shmem_mmap() returns the
error and leaves the put to the caller, and both callers do it,
drm_gem_mmap_obj() as above and drm_gem_prime_mmap() from its own error
path.  Drop the call.

It was harmless until commit f49a51bfdc8e ("drm/shme-helpers: Fix
dma_buf_mmap forwarding bug") moved the vm_private_data assignment ahead
of the callback; before that the field was still NULL when the callback
ran and drm_gem_vm_close() put nothing.

exynos_drm_gem_mmap() and __tegra_gem_mmap() have the same error path.

Fixes: f49a51bfdc8e ("drm/shme-helpers: Fix dma_buf_mmap forwarding bug")
Cc: stable@vger.kernel.org
Signed-off-by: Baul Lee <baul.lee@xbow.com>
---
 drivers/gpu/drm/drm_gem_dma_helper.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_gem_dma_helper.c b/drivers/gpu/drm/drm_gem_dma_helper.c
index 1c00a71ab3c9..a34561efd1ae 100644
--- a/drivers/gpu/drm/drm_gem_dma_helper.c
+++ b/drivers/gpu/drm/drm_gem_dma_helper.c
@@ -550,8 +550,6 @@ int drm_gem_dma_mmap(struct drm_gem_dma_object *dma_obj, struct vm_area_struct *
 				  dma_obj->vaddr, dma_obj->dma_addr,
 				  vma->vm_end - vma->vm_start);
 	}
-	if (ret)
-		drm_gem_vm_close(vma);
 
 	return ret;
 }
-- 
2.50.1 (Apple Git-155)
