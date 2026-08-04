Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 957EC3A9DB9
	for <stable@vger.kernel.org>; Tue,  4 Aug 2026 12:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785845148; cv=none; b=GFFHLc6Zc9ekxr6dIWPNCy/7SotVauaPaPWDJsLdUZ8jDEs7wGbnOGRtSPdIi2TuMYj4Vc2ASP++56CTeCFtM1E6OJp7TwOZATMfF2JCv3qqiqhZMFGVepeFoSlrFY5rk7Jq65GhU9HVacatwNwT7mLKXfB3iSPC8oJAF1gKDAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785845148; c=relaxed/simple;
	bh=cDZoklWx0/N7wex/E0OmJ7dckrnB/Lv/S0imotkXjpA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Sb9cuwqW9LoD7lROUcGDmf5V3VTvLVXjQgvTP8sN4gEcEemjUFULicDoPsr0ONnulSRiSjQ8Y6Iq86usGpBBZi0ZQC2Zl8UuH28xwfSbHwrwwfqkYaqq8Yb3UXjwruVwATyz5cn84Y8ugbgDhliCZdfhOZLhoux2zqgEqSmATH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Z778NE8K; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=PBlyJqgg; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z778NE8K";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="PBlyJqgg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785845145;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tjD464vOIu2Voqk/KOGceV068H0b4O8GMn0RbRgTxRU=;
	b=Z778NE8KJmZiwpuy4IcGDUqv9zIeJ/lRV4kHC6li4NMpoTvzaEy3bCgzQqEFp9mrwq+Kmy
	dgCqGL2pypA7a6GeMh46JBGa1y98Zy6vhxxoOUQYJ6R4dBZA8J7YAss4hBgy8kopjJQkAe
	c3VI9O+leDAxNRK4VwjRc/yixWKFkb4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-563-YcNiBPP9MRetGvx6GDkwYQ-1; Tue, 04 Aug 2026 08:05:44 -0400
X-MC-Unique: YcNiBPP9MRetGvx6GDkwYQ-1
X-Mimecast-MFC-AGG-ID: YcNiBPP9MRetGvx6GDkwYQ_1785845142
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-495529a93f9so33867255e9.3
        for <stable@vger.kernel.org>; Tue, 04 Aug 2026 05:05:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1785845142; x=1786449942; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tjD464vOIu2Voqk/KOGceV068H0b4O8GMn0RbRgTxRU=;
        b=PBlyJqggW557o63F/kMXtvdzr2cYcTMTTjJqXhJYSUppJ8jSsDSuNBQDc8qYBT3iTU
         K4KnBO6ItEFRf/kI5UjlrfAuGEQfJsOYxAhhMXxbVkDiciKBVL3ljk3HV+UwvXajOhr4
         UQuz2Ddmdw/sZDZRMsjuIeXuU/KXy84ll79fckKqYsiw+Scf5uev7spLgc8nn8Jby9Mf
         kC/vFboTw2C6Gd2l5LecAQVE4BuR/5RCDHBzPK+Y9tnUWL0bakvh/EX9ftAmZL/ba8RW
         Q+oHjgYaWQps0V9rkmJrz4pvSSUAGf8d88sp3v9Q7fYQp5FxRbjfLxZDf38IG9P/pVc3
         B29Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785845142; x=1786449942;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=tjD464vOIu2Voqk/KOGceV068H0b4O8GMn0RbRgTxRU=;
        b=lJMiKQP9s9VZi6cfQ5cObDbVRWlAR6w4JEysgbrm3zMiUKkwwsmm4ZMPyLX2Edrv0M
         YQ9VZN5Z9UbtC9WlM7HV9WrdoCMYb2dSj3R9GT3BO6QmNE54uJiHdv64j3LWo19OhFhL
         aE3KKLJgmtVYUa6Q64vyA2C5cRam76EBalnxjbNXFojsVHG9d7t7dxiVBQ2+G1Q/gIPw
         mPBvtnUvLTaNEsyRtn7hWyqZHd7J5kmq7o2AAm7yXrLv0panHS536YnzT/a5bkHeZq8d
         TKIzcjwSpb6uVty5LHWgKVFDKNV9iM7cbvxYeVJJ5azyk4N2wTrDsR9P0bHoWsk0FFDV
         6YjQ==
X-Forwarded-Encrypted: i=1; AHgh+RqUroMYeeckrcwDwESEpRJJD/lDN+oZO/rfk9gtXpqy2H96puhN0YSG4qz+5XpWPzNuODdPv5o=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywb6Ta1lS5X18K3OJkeFaHAGUQ+uI1wZeqF/yt+DG4LDhNZ2CHE
	diV4KQ3j0ABo07bUc1pYMUo0Uazc/kXlRh3+6rTOzCdIzhtbJUz4B1qOLZbio53rogf4QLP1iEy
	KTHE/GdWrPZ4wwtgwNtKf6BVPiJKMNb/WlS4ezpT5WXfun27Dwys2Osbd4Q==
X-Gm-Gg: AR+sD121geICGzTiDWFJfYz6Yo873ZCL5YMpZrQp2Nm9oqTR199o05WE6586OUb8Jv1
	KGjMWkolnoJMvIGbQ3wOmAwPT2g6G3qQ2rdMHGFMCQ+OC4WspVwHBJFOZkITlw3JqvFhAjnttnV
	GU67zGs2JFct4jnqbRJqXqU/YhL1p3gSVmMfY+b6gcJ4AeVuxgbv+eYK2k+wosB9iuIq3fZMhZq
	hco4/pUVcBGw9yqbPQLrrfn9SA6Zee+105Rqv10wN4l6PXrcXqpBjFTmfRipEHyvDAPxXTnrlNO
	a4jwHnPcLz8jN/n4820xomUEcoy8qZV54McnbH34amMG5EowcItCvgAMf/N2pUCQauUsyudatoc
	2y0oWnWFyB3gamX+VULAsLBjDaP7GNHJQIfIWUEMO0I8qjB9zylrjzYuZbm5WwpqdpvueiIy6RR
	ADiew=
X-Received: by 2002:a05:600c:c8c:b0:495:4589:707 with SMTP id 5b1f17b1804b1-4980c6452f7mr312396085e9.5.1785845142087;
        Tue, 04 Aug 2026 05:05:42 -0700 (PDT)
X-Received: by 2002:a05:600c:c8c:b0:495:4589:707 with SMTP id 5b1f17b1804b1-4980c6452f7mr312394755e9.5.1785845141410;
        Tue, 04 Aug 2026 05:05:41 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.34.92])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49949fc2ff6sm79768615e9.1.2026.08.04.05.05.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 05:05:39 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: Alex Williamson <alex@shazbot.org>,
	bcm-kernel-feedback-list@broadcom.com,
	Boris Brezillon <boris.brezillon@collabora.com>,
	Christian Koenig <christian.koenig@amd.com>,
	David Hildenbrand <david@kernel.org>,
	dri-devel@lists.freedesktop.org,
	Fei Li <fei1.li@intel.com>,
	Huang Rui <ray.huang@amd.com>,
	linux-mm@kvack.org,
	linux-s390@vger.kernel.org,
	Michal Hocko <mhocko@suse.com>,
	Peter Xu <peterx@redhat.com>,
	Sergio Lopez <slp@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	stable@vger.kernel.org
Subject: [PATCH v2 3/6] drm/ttm, drm/vmwgfx: directly create writable PTEs when mkwrite is in use
Date: Tue,  4 Aug 2026 14:05:25 +0200
Message-ID: <20260804120529.1730187-4-pbonzini@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260804120529.1730187-1-pbonzini@redhat.com>
References: <20260804120529.1730187-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This ensures that fixup_user_fault() users see a writable PTE when
they request one.  The flip side is that vmw_bo_vm_fault() now has
to record by hand the write fault, because .pfn_mkwrite() is
not invoked.

Prefaulting works as before because only the first entry comes
out writable, while the following ones still end up executing
the .pfn_mkwrite() callback.

Cc: stable@vger.kernel.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 drivers/gpu/drm/ttm/ttm_bo_vm.c            |  7 ++--
 drivers/gpu/drm/vmwgfx/vmwgfx_page_dirty.c | 42 ++++++++++++----------
 2 files changed, 29 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/ttm/ttm_bo_vm.c b/drivers/gpu/drm/ttm/ttm_bo_vm.c
index a80510489c45..3ebde936ce60 100644
--- a/drivers/gpu/drm/ttm/ttm_bo_vm.c
+++ b/drivers/gpu/drm/ttm/ttm_bo_vm.c
@@ -191,6 +191,7 @@ vm_fault_t ttm_bo_vm_fault_reserved(struct vm_fault *vmf,
 	unsigned long pfn;
 	struct ttm_tt *ttm = NULL;
 	struct page *page;
+	bool mkwrite;
 	int err;
 	pgoff_t i;
 	vm_fault_t ret = VM_FAULT_NOPAGE;
@@ -242,6 +243,7 @@ vm_fault_t ttm_bo_vm_fault_reserved(struct vm_fault *vmf,
 	 * Speculatively prefault a number of pages. Only error on
 	 * first page.
 	 */
+	mkwrite = !!(vmf->flags & FAULT_FLAG_WRITE);
 	for (i = 0; i < num_prefault; ++i) {
 		if (bo->resource->bus.is_iomem) {
 			pfn = ttm_bo_io_mem_pfn(bo, page_offset);
@@ -263,9 +265,10 @@ vm_fault_t ttm_bo_vm_fault_reserved(struct vm_fault *vmf,
 		 * at arbitrary times while the data is mmap'ed.
 		 * See vmf_insert_pfn_prot() for a discussion.
 		 */
-		ret = vmf_insert_pfn_prot(vma, address, pfn, prot);
+		ret = vmf_insert_pfn_prot_mkwrite(vma, address, pfn, prot, mkwrite);
 
-		/* Never error on prefaulted PTEs */
+		/* Never error on prefaulted PTEs and never map them writable */
+		mkwrite = false;
 		if (unlikely((ret & VM_FAULT_ERROR))) {
 			if (i == 0)
 				return VM_FAULT_NOPAGE;
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_page_dirty.c b/drivers/gpu/drm/vmwgfx/vmwgfx_page_dirty.c
index 45561bc1c9ef..3099558c0762 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_page_dirty.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_page_dirty.c
@@ -398,15 +398,33 @@ void vmw_bo_dirty_clear_res(struct vmw_resource *res)
 		dirty->end = res_start;
 }
 
+static vm_fault_t vmw_bo_dirty_mkwrite(struct vm_fault *vmf, struct ttm_buffer_object *bo)
+{
+	unsigned long page_offset;
+	struct vmw_bo *vbo = to_vmw_bo(&bo->base);
+
+	page_offset = vmf->pgoff - drm_vma_node_start(&bo->base.vma_node);
+	if (unlikely(page_offset >= PFN_UP(bo->resource->size)))
+		return VM_FAULT_SIGBUS;
+
+	if (vbo->dirty && vbo->dirty->method == VMW_BO_DIRTY_MKWRITE &&
+	    !test_bit(page_offset, &vbo->dirty->bitmap[0])) {
+		struct vmw_bo_dirty *dirty = vbo->dirty;
+
+		__set_bit(page_offset, &dirty->bitmap[0]);
+		dirty->start = min(dirty->start, page_offset);
+		dirty->end = max(dirty->end, page_offset + 1);
+	}
+	return 0;
+}
+
 vm_fault_t vmw_bo_vm_mkwrite(struct vm_fault *vmf)
 {
 	struct vm_area_struct *vma = vmf->vma;
 	struct ttm_buffer_object *bo = (struct ttm_buffer_object *)
 	    vma->vm_private_data;
 	vm_fault_t ret;
-	unsigned long page_offset;
 	unsigned int save_flags;
-	struct vmw_bo *vbo = to_vmw_bo(&bo->base);
 
 	/*
 	 * mkwrite() doesn't handle the VM_FAULT_RETRY return value correctly.
@@ -419,22 +437,7 @@ vm_fault_t vmw_bo_vm_mkwrite(struct vm_fault *vmf)
 	if (ret)
 		return ret;
 
-	page_offset = vmf->pgoff - drm_vma_node_start(&bo->base.vma_node);
-	if (unlikely(page_offset >= PFN_UP(bo->resource->size))) {
-		ret = VM_FAULT_SIGBUS;
-		goto out_unlock;
-	}
-
-	if (vbo->dirty && vbo->dirty->method == VMW_BO_DIRTY_MKWRITE &&
-	    !test_bit(page_offset, &vbo->dirty->bitmap[0])) {
-		struct vmw_bo_dirty *dirty = vbo->dirty;
-
-		__set_bit(page_offset, &dirty->bitmap[0]);
-		dirty->start = min(dirty->start, page_offset);
-		dirty->end = max(dirty->end, page_offset + 1);
-	}
-
-out_unlock:
+	ret = vmw_bo_dirty_mkwrite(vmf, bo);
 	dma_resv_unlock(bo->base.resv);
 	return ret;
 }
@@ -484,6 +487,9 @@ vm_fault_t vmw_bo_vm_fault(struct vm_fault *vmf)
 		prot = vm_get_page_prot(vma->vm_flags);
 
 	ret = ttm_bo_vm_fault_reserved(vmf, prot, num_prefault);
+	if (ret == VM_FAULT_NOPAGE && (vmf->flags & FAULT_FLAG_WRITE))
+		WARN_ON_ONCE(vmw_bo_dirty_mkwrite(vmf, bo));
+
 	if (ret == VM_FAULT_RETRY && !(vmf->flags & FAULT_FLAG_RETRY_NOWAIT))
 		return ret;
 
-- 
2.55.0

