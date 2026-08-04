Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE6A546AA75
	for <stable@vger.kernel.org>; Tue,  4 Aug 2026 14:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785852267; cv=none; b=qhwu57BG6LESsqEg4qjEIOG0ga+tCeCTuvt/SEd7rA9e01oUn/XpomUqkQChvE4O1+pzevkXYH3sFsrahzagUfALoTlnqeABw3bukQquXYZjOOBPaimGuEr2PQqCX1oslBMLU6HRxdcTFXw7PGJTNsAX125Yx94/8lebeeJh7Bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785852267; c=relaxed/simple;
	bh=wL00NWYR0qqOjvAw7M3DFDe7cB35AxOZNJLMdcw9+EQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nN+yDkAi+3CEfMS/k0OHpEgNXFdUWdYeQgbUylBTh4RpsxnGj6j0Aaq3Ye2UjTKMEFBozRb3PAcAemqKZ0pEQN1f18t7vVbHFmGyflomn7D7+ojDH5BTyafY8bpiQfLbeCBMKwOtl5147HOq3JcQFPDDx1VxM7T/iSQDDuAzHww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=s0pcfNGS; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s0pcfNGS"
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-39c83acb86eso40793791fa.1
        for <stable@vger.kernel.org>; Tue, 04 Aug 2026 07:04:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785852264; x=1786457064; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=0SIB9ZNDGWSkbhYbrVPXtpZTZPzNmn29odQM0RAb0dw=;
        b=s0pcfNGSqzdjIIti68wVLUA2+yK3X1T+MBgM8Tqx6mB/CjSUKUh2oQeqPHSrqnXI4H
         pKQXWeHGrYFnZCjchm285AMy+LymnOfYlqTBXkn9GJInblrBKeaRDnY/xAmfdafqNKDX
         6nagiqYKLo6z/+Bci0xDBbqTS3xDDSjmfhHNQLAWlDb3aYHnSF8kdiYiBtLZJbwpZfpM
         IOGkzDRWdXeKspYX4bY7Y3M2VOjmFJ60DaTG7Nl/C/Q4ShhZqyQfVhqxfqM25OqlRsyD
         /3oTT3GLngptmrcKGjJtoKS9QuRM/tWb4KnonWo6k87T9TrOdOO9yGTxbrwfsBFwepMo
         P/3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785852264; x=1786457064;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0SIB9ZNDGWSkbhYbrVPXtpZTZPzNmn29odQM0RAb0dw=;
        b=QSSxVtCFNNP4b1ZAe2HgU0fn5GPkbN23+qfv7c7NNjeqGcale8+0c/XN3qBPlTw1mt
         ogmYkeZbg+lAgkame1Ak0/sN5C3ZoeK5vIrkkPydapkJOj/WzOAHkJDDZ56eYuTqs8WI
         mA2LY9nmgPLj8HQ7kxJq2y5tRSyuKO/9wd8GP87Awv54lO7KArEuhhgPYSMbfbx5498L
         /tCuZ9Y8yCIDj+edsEBu8rt07GKxx52DrpGtUjs6KhSZOYprhrxteguhm3CQjqwVVEbh
         4iP/XOlMGK+REsQDDXK/AicxRWy4uiwlyzPA4UK0R96dqVTwn8G+HCPlCf0dx+YVRBAF
         c7jA==
X-Forwarded-Encrypted: i=1; AHgh+RpfTK7Lrp62aTja/LlaVrYho3keTeZ7dzS0nd0ba6cvx0mBCjvkXFnAkqwPZDVk2Fem/JJq4/s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxm73DcTwg98tlVxPt38mANJbuo4KY0dl/08MtewHpt1Zrm3AZS
	fgtk1UWubYb16v9/bm2fyiILu7P3rLXSaUu7Ik0asEmKlL3dh1OBxDjI
X-Gm-Gg: AR+sD10BDWbedM0UpfG4lceCgEsG93AAqnZQN9PaSlvva1ozgkQt6nQHON7I8W1Pjxt
	NYYu4LvOIDNxQchkGx5CrpKZPyM26Mz6JBnfgaQn4L4d5+XM3ObwdbcxceYGRmrW7gc7n2LjD/v
	q132Z1mBDZ+zw59VRVd+MAtkIy8OvGROowVLCbmZloSkJubaifE+vct41n0yZDs9LNUTdmv4oDR
	zaJXmTNT5rEF1r1HFzWglwVmBtWse8o2OEamwxA8yCVGa5VJdAVBcqszFZyktx3IW6OSkxu9LkC
	lz85Ze6wsakgaCl6VRvchomq0yaEEDf+IlGxK5MxuoqmOI/A9sS+ZquNF/J2Doe4l1VfmZgkCU2
	mZyn0U1yFpgmrvMd81LqoOz6dNIKQznfcvFs+vmvS6IDQa0cLGGTXBru3ZH9BdyimkfN8EBAaSN
	6i0PMyvaM5O1Y7/o5FsF0VsSDrtgMSXH+zP6XtFNrwyvZZZtXsQGqdfzduQn616qf7GTfCXDWrW
	X4BWHP51/QAKC+OFP/Qld5VPynJ/el1bbhMSOgL
X-Received: by 2002:a05:6512:39c3:b0:5b2:a396:1793 with SMTP id 2adb3069b0e04-5b2e4f76abemr2965624e87.37.1785852263358;
        Tue, 04 Aug 2026 07:04:23 -0700 (PDT)
Received: from kfastov-mac ([91.217.3.226])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b2e245536dsm2669672e87.67.2026.08.04.07.04.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 07:04:22 -0700 (PDT)
From: Konstantin Fastov <kfastov@gmail.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>
Cc: David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Boris Brezillon <boris.brezillon@collabora.com>,
	dri-devel@lists.freedesktop.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	regressions@lists.linux.dev,
	stable@vger.kernel.org,
	Konstantin Fastov <kfastov@gmail.com>
Subject: [PATCH] drm/gem-shmem: Install writable PTEs for write faults
Date: Tue,  4 Aug 2026 17:04:03 +0300
Message-ID: <20260804140403.16337-1-kfastov@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since the introduction of dirty tracking, drm_gem_shmem_vm_ops has a
.pfn_mkwrite handler.  Its presence makes vma_wants_writenotify() true,
so vma_set_page_prot() removes the write bit from vm_page_prot of
shared mappings, and the vmf_insert_pfn() call in the fault handler now
installs read-only PTEs even when serving a write fault.

For regular CPU accesses this is transparent: the retried access faults
again on the present read-only PTE, goes through wp_pfn_shared() into
.pfn_mkwrite() and the PTE is upgraded to writable.  But consumers that
resolve faults through fixup_user_fault() + follow_pfnmap_start()
perform no such retry.  In particular KVM's hva_to_pfn_remapped(),
after "successfully" handling a write fault, finds a present read-only
PTE, treats it as KVM_PFN_ERR_RO_FAULT and fails the vcpu run with
EFAULT.  Observed as AsahiLinux/linux#560: muvm/libkrun microVMs
mapping virtio-gpu blob resources die with EFAULT on first GPU access.
The traced failing sequence:

  follow_pfnmap_start()        -> -EINVAL   (no PTE yet)
  fixup_user_fault(WRITE)
    drm_gem_shmem_fault()
      vmf_insert_pfn()         -> NOPAGE    (read-only PTE installed)
  fixup_user_fault()           -> 0         (fault "handled")
  follow_pfnmap_start()        -> 0, !writable
  hva_to_pfn()                 -> KVM_PFN_ERR_RO_FAULT

Fix it the same way commit cb2a2a5b37ad ("drm/shmem_helper: Make sure
PMD entries get the writeable upgrade") did for the PMD path: when the
fault is a write fault, install a writable entry directly and record
the write for dirty tracking, instead of relying on a refault that not
every fault-resolution path performs.

To do that at PTE level, add vmf_insert_pfn_mkwrite(), the VM_PFNMAP
counterpart of vmf_insert_mixed_mkwrite(): insert_pfn() already
implements the mkwrite semantics, there was just no wrapper exposing it
for pfn inserts with the default pgprot.

Fixes: 28e3918179aa ("drm/gem-shmem: Track folio accessed/dirty status in mmap")
Cc: stable@vger.kernel.org
Closes: https://github.com/AsahiLinux/linux/issues/560
Assisted-by: Claude:claude-fable-5
Signed-off-by: Konstantin Fastov <kfastov@gmail.com>
---
 drivers/gpu/drm/drm_gem_shmem_helper.c | 20 +++++++++++++-
 include/linux/mm.h                     |  2 ++
 mm/memory.c                            | 36 +++++++++++++++++++++++---
 3 files changed, 54 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/drm_gem_shmem_helper.c b/drivers/gpu/drm/drm_gem_shmem_helper.c
index 545933c7f712..37662f6f6ed9 100644
--- a/drivers/gpu/drm/drm_gem_shmem_helper.c
+++ b/drivers/gpu/drm/drm_gem_shmem_helper.c
@@ -573,7 +573,25 @@ static vm_fault_t try_insert_pfn(struct vm_fault *vmf, unsigned int order,
 				 unsigned long pfn)
 {
 	if (!order) {
-		return vmf_insert_pfn(vmf->vma, vmf->address, pfn);
+		vm_fault_t ret;
+
+		/* .pfn_mkwrite enables write-notify, so vm_page_prot lacks
+		 * the write bit and a plain vmf_insert_pfn() would install
+		 * a read-only PTE even for a write fault.  Not every fault
+		 * resolver refaults into .pfn_mkwrite() to upgrade it (KVM
+		 * doesn't), so install a writable PTE and record the write
+		 * directly, like the PMD path below.
+		 */
+		if (vmf->flags & FAULT_FLAG_WRITE) {
+			ret = vmf_insert_pfn_mkwrite(vmf->vma, vmf->address,
+						     pfn);
+			if (ret == VM_FAULT_NOPAGE)
+				drm_gem_shmem_record_mkwrite(vmf);
+		} else {
+			ret = vmf_insert_pfn(vmf->vma, vmf->address, pfn);
+		}
+
+		return ret;
 #ifdef CONFIG_ARCH_SUPPORTS_PMD_PFNMAP
 	} else if (order == PMD_ORDER) {
 		unsigned long paddr = pfn << PAGE_SHIFT;
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 80fce2515930..7b76a281bdd1 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -4551,6 +4551,8 @@ vm_fault_t vmf_insert_page_mkwrite(struct vm_fault *vmf, struct page *page,
 			bool write);
 vm_fault_t vmf_insert_pfn(struct vm_area_struct *vma, unsigned long addr,
 			unsigned long pfn);
+vm_fault_t vmf_insert_pfn_mkwrite(struct vm_area_struct *vma,
+		unsigned long addr, unsigned long pfn);
 vm_fault_t vmf_insert_pfn_prot(struct vm_area_struct *vma, unsigned long addr,
 			unsigned long pfn, pgprot_t pgprot);
 vm_fault_t vmf_insert_mixed(struct vm_area_struct *vma, unsigned long addr,
diff --git a/mm/memory.c b/mm/memory.c
index 86a973119bd4..6562a0d8bb68 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -2751,8 +2751,9 @@ static vm_fault_t insert_pfn(struct vm_area_struct *vma, unsigned long addr,
  * Context: Process context.  May allocate using %GFP_KERNEL.
  * Return: vm_fault_t value.
  */
-vm_fault_t vmf_insert_pfn_prot(struct vm_area_struct *vma, unsigned long addr,
-			unsigned long pfn, pgprot_t pgprot)
+static vm_fault_t __vmf_insert_pfn_prot(struct vm_area_struct *vma,
+		unsigned long addr, unsigned long pfn, pgprot_t pgprot,
+		bool mkwrite)
 {
 	/*
 	 * Technically, architectures with pte_special can avoid all these
@@ -2774,10 +2775,39 @@ vm_fault_t vmf_insert_pfn_prot(struct vm_area_struct *vma, unsigned long addr,
 
 	pfnmap_setup_cachemode_pfn(pfn, &pgprot);
 
-	return insert_pfn(vma, addr, pfn, pgprot, false);
+	return insert_pfn(vma, addr, pfn, pgprot, mkwrite);
+}
+
+vm_fault_t vmf_insert_pfn_prot(struct vm_area_struct *vma, unsigned long addr,
+			unsigned long pfn, pgprot_t pgprot)
+{
+	return __vmf_insert_pfn_prot(vma, addr, pfn, pgprot, false);
 }
 EXPORT_SYMBOL(vmf_insert_pfn_prot);
 
+/**
+ * vmf_insert_pfn_mkwrite - insert single pfn into user vma, making it writable
+ * @vma: user vma to map to
+ * @addr: target user address of this page
+ * @pfn: source kernel pfn
+ *
+ * Similar to vmf_insert_pfn(), but the inserted PTE is made young, dirty and
+ * writable (subject to the VMA's write permission).  For use by fault
+ * handlers of write-notify VMAs (where vma->vm_page_prot has the write bit
+ * removed) that serve a write fault and do their own dirty accounting, so
+ * that a "handled" write fault always results in a writable PTE.  The
+ * VM_PFNMAP counterpart of vmf_insert_mixed_mkwrite().
+ *
+ * Context: Process context.  May allocate using %GFP_KERNEL.
+ * Return: vm_fault_t value.
+ */
+vm_fault_t vmf_insert_pfn_mkwrite(struct vm_area_struct *vma,
+		unsigned long addr, unsigned long pfn)
+{
+	return __vmf_insert_pfn_prot(vma, addr, pfn, vma->vm_page_prot, true);
+}
+EXPORT_SYMBOL(vmf_insert_pfn_mkwrite);
+
 /**
  * vmf_insert_pfn - insert single pfn into user vma
  * @vma: user vma to map to
-- 
2.55.0

