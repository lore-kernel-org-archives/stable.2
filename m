Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BECB3E075C
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 08:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785916915; cv=none; b=c04UTCgf9I9mU/hFTiG1cbVJXAcFwuVG2eIe3uttSDe3csaQslzFdMxgRgfreTQZi8PkR7DBmVnj4SXwuRaYsG8RwMJdP85NxBHkhHLshkRJaYMr4GKEnWN/+Wt8nRAufAuOdi7riDmYO9VmZb2Oey3Mwyojpvv8tRtj7nPvEP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785916915; c=relaxed/simple;
	bh=MlBqrOpt3rgDIGyH2ULIv4blD/fJqwd8tkI7/IUhkCI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MDjR5LpXJ2+Kbf/Zo73meFhBKvMuiMgq0zL/nX5dem5owTq6JW8GdMc60CXNXyZ1Q55s6i7ng10zzjQZ+fwmlLU+lK9jseOaHa7CzaSRQr1Pj5eAQmyeLcIvCyBd3R4dboXp4w2bo+xeNu5Nmmlk6LKw7AlSfymVPIq6K1VLcgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xbow.com; spf=pass smtp.mailfrom=xbow.com; dkim=pass (2048-bit key) header.d=xbow.com header.i=@xbow.com header.b=XMzaM2ql; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xbow.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xbow.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xbow.com header.i=@xbow.com header.b="XMzaM2ql"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-38e58034d05so623872a91.2
        for <stable@vger.kernel.org>; Wed, 05 Aug 2026 01:01:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=xbow.com; s=google; t=1785916912; x=1786521712; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=AUz5eQQY4ZXKNBZLMrPCzNtvBb314GGu8HHfd2z4ufg=;
        b=XMzaM2qlcdbKcysD6LMDSGvb1LChPkEwI/a6X6E3NOxCRX8DJ7tm/FFIA5hvGDccTT
         XOKbYAWxnwd3axUvarSkbbixqD6V776GzqlCDcHJ6Efk7C+LqcC3u4QfflNH+p87Roib
         WKED6Dh+gczkBU0IpUjXHHbAcuBUem/IUiFsbJZhRQOjNULft47zwBWzaqoBGhS9I2aG
         3sp31CuUOlb4i0gL0N52y00HFrOrLcky/ylfnoU78G8hv7+CtjQ13ctAC4mwmVupy29m
         zCpZFKa1LtP/it3epRUFlYvNOsVzFKKgEsFcouHWVhK8KhZDyxCu8cJW6QPyilpmw3Z1
         PVvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785916912; x=1786521712;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AUz5eQQY4ZXKNBZLMrPCzNtvBb314GGu8HHfd2z4ufg=;
        b=UpjEFwljl5YuawxnWDeRf8PolIRGfV/s9Q3niV+pMD5fsHNi0MsMY+QU+Q1NwuXEbK
         JhxSBQG2IkZlEy4dINfIp+pUlJA1/rLfWJTGa+7Lrk1V+J030GXLZBYVgKR6fnjdX9am
         woTb8ZnXxe/Sse9YLhVEYujVHbTGrflcVHV34tCFctbSIdd97QJfJ+3BBG4nybZC7coj
         GC+oq0E/ekxySf4EBDpWWPVp48HQ1EQTey3sfKjiHXvLLTsAfiUXaNNSLBTpAggvCUBV
         eEZMFuCLHXYzaxpr7t+CLoksAP1o0Lo3b3Cep6k36pHAWN7sso/XbLiGOjaHG73mt7HC
         xW+g==
X-Forwarded-Encrypted: i=1; AHgh+RqOYVQm4m2L/+KjDKlSbPA9GrZAAmJnbRiJtyJ6CiNUPHDmhkgSW1BBCg6zpS29qaC1Rt8RVEw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1ZYSNv7A8qu6Tpi1o3YPG5dQch+TaqtBvqc4mGRQfsXOu7nBI
	9fP4dqosNbP6Vlk+St3td1HY1+LEyi4J/3v6WetFa4dqPF/sHVwOOka7BSx57TfAYMXjLE1naUU
	3ALCfvgo=
X-Gm-Gg: AR+sD12N54RWiuqcG6y7dnJv+FVTCxIdHzk+fXfS0BCNWr1eQwyWqnPQFfi7VPhK4gI
	hK0xuZzPuHrXm/a7wx1Q2IPxGUj7HJnIcuY/U57SCgzPJ2KCW52gMNZllw2fsURf19ERrAY5qCM
	5iUjb1J/yYX4kozZw+uJfz0ylIG/H5NwBF41Kj9aFT3wvynN+LmjOMYJCpXWOpp5K6fMdxqh+0t
	br+37b+tbBn7UWHyFGPLOElMMRTYzVSccT6fRnoASWxgG1thaqVTnlqGIpdTJJr8Vd2k8a9WjW7
	9bfHnSmq17KnZ7J/8f29GHw2hY+kVzhyody71dC5NOFIlJXJKfipjv9XJ6m7G78J7RQ2Wf3G1uu
	msXSyNFld8WKPXTGwIEjz4WYnPW/aHWcBXShZklHR4V7r4WZZllfHPxZzmKJYZhbHDukQFfaKkl
	Ihil6c9CWcPTZv/22meUHmhTRpGezaI1Tf3iB4o5HTsl2Ks04qmSGQ0fC7SRtIvJgFCNrxb4ggT
	ZQTq0WM3kQ2updXlGOiBgh6NsBj
X-Received: by 2002:a17:90a:ec8b:b0:38f:aab1:5148 with SMTP id 98e67ed59e1d1-3903c5d313bmr5059257a91.13.1785916912122;
        Wed, 05 Aug 2026 01:01:52 -0700 (PDT)
Received: from Mac.lan ([125.128.148.126])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38febfdae62sm3922263a91.1.2026.08.05.01.01.49
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 05 Aug 2026 01:01:51 -0700 (PDT)
From: Baul Lee <baul.lee@xbow.com>
To: maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	federico.kirschbaum@xbow.com,
	stable@vger.kernel.org,
	Baul Lee <baul.lee@xbow.com>
Subject: [PATCH] drm/gem-dma: bound the mmap against the object size
Date: Wed,  5 Aug 2026 17:01:47 +0900
Message-ID: <20260805080147.12564-1-baul.lee@xbow.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

drm_gem_dma_mmap() passes the caller's request, not the object, as the
size of the buffer being mapped:

	ret = dma_mmap_wc(drm_dev_dma_dev(dma_obj->base.dev), vma,
			  dma_obj->vaddr, dma_obj->dma_addr,
			  vma->vm_end - vma->vm_start);

dma_direct_mmap() derives its page count from that size, so count and
user_count are the same number and the bounds test degenerates into
"vm_pgoff must be zero":

	unsigned long user_count = vma_pages(vma);
	unsigned long count = PAGE_ALIGN(size) >> PAGE_SHIFT;
	...
	if (vma->vm_pgoff >= count || user_count > count - vma->vm_pgoff)
		return -ENXIO;

remap_pfn_range() then installs writable PTEs for every frame the caller
asked for, starting at the object and running past its end.

On the DRM node that is unreachable: drm_gem_mmap_obj() rejects a VMA
larger than the object before the object's mmap function runs.  The fbdev
emulation does not go through it.  drm_fbdev_dma_fb_mmap() calls
drm_gem_prime_mmap(), which invokes obj->funcs->mmap() directly, so
/dev/fb0 accepts a length that /dev/dri/card0 refuses for the same object.

The framebuffer is contiguous CMA inside system DRAM, so the excess
mapping covers kernel-owned RAM, readable and writable, at an offset the
caller picks.  On arm64 a 1 GiB mapping of an 8294400-byte framebuffer
object was accepted, and writes through it landed in the private memory
of another unprivileged process.  Nothing is logged: every access comes
from userspace through a PTE the kernel installed.  open() and mmap() on
/dev/fb0 are enough, so any member of group video reaches it.

Pass the object size to the DMA layer, which makes the dma_direct_mmap()
test meaningful, and check the VMA length the way drm_gem_mmap_obj() does
so both nodes reject the same request.

Fixes: b79fe9abd58b ("drm/fbdev-dma: Implement fbdev emulation for GEM DMA helpers")
Cc: stable@vger.kernel.org
Signed-off-by: Baul Lee <baul.lee@xbow.com>
---
 drivers/gpu/drm/drm_gem_dma_helper.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_gem_dma_helper.c b/drivers/gpu/drm/drm_gem_dma_helper.c
--- a/drivers/gpu/drm/drm_gem_dma_helper.c
+++ b/drivers/gpu/drm/drm_gem_dma_helper.c
@@ -531,6 +531,9 @@ int drm_gem_dma_mmap(struct drm_gem_dma_object *dma_obj, struct vm_area_struct *
 	struct drm_gem_object *obj = &dma_obj->base;
 	int ret;

+	if (obj->size < vma->vm_end - vma->vm_start)
+		return -EINVAL;
+
 	/*
 	 * Clear the VM_PFNMAP flag that was set by drm_gem_mmap(), and set the
 	 * vm_pgoff (used as a fake buffer offset by DRM) to 0 as we want to map
@@ -543,12 +546,12 @@ int drm_gem_dma_mmap(struct drm_gem_dma_object *dma_obj, struct vm_area_struct *
 		vma->vm_page_prot = vm_get_page_prot(vma->vm_flags);

 		ret = dma_mmap_pages(drm_dev_dma_dev(dma_obj->base.dev),
-				     vma, vma->vm_end - vma->vm_start,
+				     vma, obj->size,
 				     virt_to_page(dma_obj->vaddr));
 	} else {
 		ret = dma_mmap_wc(drm_dev_dma_dev(dma_obj->base.dev), vma,
 				  dma_obj->vaddr, dma_obj->dma_addr,
-				  vma->vm_end - vma->vm_start);
+				  obj->size);
 	}
 	if (ret)
 		drm_gem_vm_close(vma);
-- 
2.50.1 (Apple Git-155)

