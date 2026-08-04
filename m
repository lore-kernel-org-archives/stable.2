Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07EE2394499
	for <stable@vger.kernel.org>; Tue,  4 Aug 2026 12:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785845142; cv=none; b=dCscHhjY6srws5EaqqWTJi6OTC0yMPRyyValduIFEUBBrcD+70M2rHCBFNSWujZbDwXWrvRMlpKlzOA7g5S4u6L3Lyq0hLJ4XtKxrEJs+xNPdrHwmQj/9xiIIIAjRwsYQO3HEptI+X79F4loFXt29jh4sar9KGyNXDEh79dmq4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785845142; c=relaxed/simple;
	bh=2NmEb6/L7QYcfhxZ8+lab83yjq9i9GZownbXwTIqVvs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YPgC80Ee0OFLSaTRxg+IwD5XwKUaLB1ZpjWV3PzvPn+aJPEoflUzSRRq6WG8ROi7xgiC65HH4/S90kBMfJY4N2mv3qIkk7NEbSw4sAuTjodum3/x9ILOQDiKM5lVFLQEH29xj5WL6BXYHQBcTPNqaA0W3dS3WbSKVo6ILA24NFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UbW8QkjM; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=F1vW3SkW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UbW8QkjM";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="F1vW3SkW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785845138;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VnnVy48ydCXauSW+w5ZraHIy4YMvaYkPwdBxROmLWeM=;
	b=UbW8QkjMHh6y2r3PT7FYazUcub8AkJcFBNTUZlhd+KXxIS31AmUQnGKR8NWe+cAVgqdx3H
	TpfpBuHm3bhmp08uh31f+9k+WqU8tH6u9g64TPlgXvE7WXti9SiqWC470C6ZigqpL/MQ3W
	Z6Y9VOHbWDvqo1n2g4DKyc+3HphJmyY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-645-hLDyQZK_O7qGnQeuYA7OlQ-1; Tue, 04 Aug 2026 08:05:36 -0400
X-MC-Unique: hLDyQZK_O7qGnQeuYA7OlQ-1
X-Mimecast-MFC-AGG-ID: hLDyQZK_O7qGnQeuYA7OlQ_1785845135
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-49545071724so32916955e9.0
        for <stable@vger.kernel.org>; Tue, 04 Aug 2026 05:05:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1785845135; x=1786449935; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VnnVy48ydCXauSW+w5ZraHIy4YMvaYkPwdBxROmLWeM=;
        b=F1vW3SkWmd0iZP2caG6mWqUi7foUE0PRoAB2IfQHdZ8W8jUlUzzmscOhHjV7x++J78
         ip56G6Bcnt4C8z5+35/TlIOGeaTFS1H28jYyjBBORRDBO30S3fCLlO+JK4uoWcxI25OT
         z722XNXVDr0SF+UU7UPpgDR3oE513ieVqVUxSUhKScb0SgytNHow7Cn/KnrCEMhnIclY
         +cxPoaCGs6+zu7ko4HRakKnDzTzg1kve5U4cEKlPJqk99+LOvfrpM0notoU7d4InSATB
         mO+1LZwf1i1pPd/2LH4GPYep5pNoTWMABcgxN9lx+3piMPs0u05Ryv3GKTptYXiGHB2r
         AieA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785845135; x=1786449935;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=VnnVy48ydCXauSW+w5ZraHIy4YMvaYkPwdBxROmLWeM=;
        b=rCZoMo9rsJqTdjsCT3uIEUkcwgsjOuCHd72rmhacF86BUu5JhINnOHZTLrd6QRs/FC
         iqp16AYDvS2GYgCB2aQIDUHEblWORwUssfvtOqDn55yfZytwP4JSkQhQdWDsX77cuk2z
         G9HP+HZhS7yQqDKJgMbyN7MVDhNKrDFjG8b7jh0xWcHHM+Jm11717dFUFV7KVi5FWD5J
         JSwqEFgmSzvCeWyXxO57f0bZHHU8ZWHNjgJm8NoBgCUD5KugnLk06Fdc5pouvcbfUzEK
         7QI015537FTb3oSPJPZISYT08a1hf/iCCyupzL0m+03WA93gqWOlYc4hYxgOV2U4e9WV
         3iZw==
X-Forwarded-Encrypted: i=1; AHgh+RrbHcQiTfcgXuWXur3Cp5jkttm+26D4SqPtCJVTyrIH2jX04JNY3PCKhJBwV2X1Pyo9UdjzbaA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgJ2c8jqeRqnDhlfwGEgkpcsncRH9NxD6TK+C0XS5+lbVBhNEd
	rjzbwmkfmkBhANk6yepoyYliQCqDDDxrRcAfG3w2b4pcybJdu8EtTEF8A6pmKkni7Fs7aj+a45w
	XfN5GzfmhcbQRzTNtseCZCTphHpe4ShY75KwSdaJ8txTQO10g++QUYKvrbQ==
X-Gm-Gg: AR+sD10SAQd9lrhK8iZ8ZnGm2XkuH00951ppaEv3zyFQDaHOifuK4ozX8II2AvDMVDW
	1IR/3whoClUR6DcLC5DFm08dGfBxCEJghSMGXQeUsjsDId0iYJ2XSEYyEoEqFvFE3f5B7+YYtGd
	L57KX5rrRP275B2PitOEAANniozr0Xvnzgo34+fL8MLwvwTVv1i0v47yjiJzrgcbjJIsIi866L9
	cKvrLiYih6w0L4yA3PU4rjDErJyYTboDESR8+trRL6gztxqnNE1YZW6Ua4UWlXW1bxtuxW1e446
	moUWf5PnMbrdB9STh4yxKf+vzdizunqlpJgYl3cSLC7jOpudCTmZ0apyBZA+59QDbSkApCEPmMQ
	zyoJnM/aWUCb9h+8/FtiG3EsUK8oStaszUDPWdsHLfOpkCYc8wHnKAVQsqJxLF2p12FJKeZpx+i
	qUN1g=
X-Received: by 2002:a05:600c:3507:b0:496:cb48:5eb8 with SMTP id 5b1f17b1804b1-4980c6747fdmr217894815e9.15.1785845135172;
        Tue, 04 Aug 2026 05:05:35 -0700 (PDT)
X-Received: by 2002:a05:600c:3507:b0:496:cb48:5eb8 with SMTP id 5b1f17b1804b1-4980c6747fdmr217893395e9.15.1785845134667;
        Tue, 04 Aug 2026 05:05:34 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.34.92])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49949f66168sm92311515e9.0.2026.08.04.05.05.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 05:05:34 -0700 (PDT)
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
Subject: [PATCH v2 1/6] mm: export vmf_insert_pfn_prot_mkwrite(), change variants to inline
Date: Tue,  4 Aug 2026 14:05:23 +0200
Message-ID: <20260804120529.1730187-2-pbonzini@redhat.com>
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

Right now, users of .pfn_mkwrite() have no way to create a PTE
that has gone through maybe_mkwrite().  Because vma_set_page_prot()
will have cleared the writable PTE bit, users of fixup_user_fault()
will see a read-only PTE and have no clue that the page needs
a *second* fault to reach its final status.

Handling this in fixup_user_fault() is problematic: the information
about the presence of *_mkwrite is only recorded in vma->vm_page_prot,
which is an opaque pgprot_t, therefore only follow_pfnmap_start()
knows how to retrieve it.

There are actually some preexisting functions that suggest how this
is supposed to be handled, namely vmf_insert_page_mkwrite() and
vmf_insert_pfn_pmd().  Fixing the drivers requires similar variants
of vm_insert_pfn(), namely vmf_insert_pfn_mkwrite() for the common
case where vma->vm_page_prot is okay, and vmf_insert_pfn_prot_mkwrite()
when really all parameters are needed.  This makes it possible
to fix drivers that use .pfn_mkwrite together with
vmf_insert_pfn() and vmf_insert_pfn_prot().

Since vmf_insert_pfn_prot_mkwrite() is the most general variant
and all the others are just special cases, turn them into inline
functions in the header.

Fixes: 28e3918179aa ("drm/gem-shmem: Track folio accessed/dirty status in mmap")
Cc: stable@vger.kernel.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/linux/mm.h | 81 +++++++++++++++++++++++++++++++++++++++++---
 mm/huge_memory.c   |  2 +-
 mm/memory.c        | 84 ++++++++++++++++++++--------------------------
 3 files changed, 114 insertions(+), 53 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 485df9c2dbdd..01184a4bdd6f 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -4544,16 +4544,89 @@ int vm_map_pages_zero(struct vm_area_struct *vma, struct page **pages,
 				unsigned long num);
 vm_fault_t vmf_insert_page_mkwrite(struct vm_fault *vmf, struct page *page,
 			bool write);
-vm_fault_t vmf_insert_pfn(struct vm_area_struct *vma, unsigned long addr,
-			unsigned long pfn);
-vm_fault_t vmf_insert_pfn_prot(struct vm_area_struct *vma, unsigned long addr,
-			unsigned long pfn, pgprot_t pgprot);
+vm_fault_t vmf_insert_pfn_prot_mkwrite(struct vm_area_struct *vma, unsigned long addr,
+			unsigned long pfn, pgprot_t pgprot, bool mkwrite);
 vm_fault_t vmf_insert_mixed(struct vm_area_struct *vma, unsigned long addr,
 			unsigned long pfn);
 vm_fault_t vmf_insert_mixed_mkwrite(struct vm_area_struct *vma,
 		unsigned long addr, unsigned long pfn);
 int vm_iomap_memory(struct vm_area_struct *vma, phys_addr_t start, unsigned long len);
 
+
+/**
+ * vmf_insert_pfn_prot - insert single pfn into user vma with specified pgprot
+ * @vma: user vma to map to
+ * @addr: target user address of this page
+ * @pfn: source kernel pfn
+ * @pgprot: pgprot flags for the inserted page
+ *
+ * This is exactly like vmf_insert_pfn(), except that it allows drivers
+ * to override pgprot on a per-page basis.  For more information,
+ * see vmf_insert_pfn_prot_mkwrite().
+ *
+ * This only makes sense for IO mappings, and it makes no sense for
+ * COW mappings.  In general, using multiple vmas is preferable;
+ * vmf_insert_pfn_prot should only be used if using multiple VMAs is
+ * impractical.
+ *
+ * Context: Process context.  May allocate using %GFP_KERNEL.
+ * Return: vm_fault_t value.
+ */
+static inline vm_fault_t vmf_insert_pfn_prot(struct vm_area_struct *vma,
+			unsigned long addr, unsigned long pfn, pgprot_t pgprot)
+{
+	return vmf_insert_pfn_prot_mkwrite(vma, addr, pfn, pgprot, false);
+}
+
+/**
+ * vmf_insert_pfn_mkwrite - insert single pfn into user vma, possibly writable
+ * @vma: user vma to map to
+ * @addr: target user address of this page
+ * @pfn: source kernel pfn
+ * @write: whether the PTE should be installed writable
+ *
+ * Like vmf_insert_pfn(), except that @write allows installing a writable
+ * PTE even when @vma is under write notification.  For more information,
+ * see vmf_insert_pfn_prot_mkwrite().
+ *
+ * Note that neither .pfn_mkwrite() nor .page_mkwrite() is invoked, so the
+ * caller must itself do whatever they would have done if @write is true.
+ *
+ * Context: Process context.  May allocate using %GFP_KERNEL.
+ * Return: vm_fault_t value.
+ */
+static inline vm_fault_t vmf_insert_pfn_mkwrite(struct vm_area_struct *vma,
+			unsigned long addr, unsigned long pfn, bool write)
+{
+	return vmf_insert_pfn_prot_mkwrite(vma, addr, pfn, vma->vm_page_prot, write);
+}
+
+/**
+ * vmf_insert_pfn - insert single pfn into user vma
+ * @vma: user vma to map to
+ * @addr: target user address of this page
+ * @pfn: source kernel pfn
+ *
+ * Similar to vm_insert_page, this allows drivers to insert individual pages
+ * they've allocated into a user vma. Same comments apply.
+ *
+ * This function should only be called from a vm_ops->fault handler, and
+ * in that case the handler should return the result of this function.
+ *
+ * vma cannot be a COW mapping.
+ *
+ * As this is called only for pages that do not currently exist, we
+ * do not need to flush old virtual caches or the TLB.
+ *
+ * Context: Process context.  May allocate using %GFP_KERNEL.
+ * Return: vm_fault_t value.
+ */
+static inline vm_fault_t vmf_insert_pfn(struct vm_area_struct *vma,
+			unsigned long addr, unsigned long pfn)
+{
+	return vmf_insert_pfn_mkwrite(vma, addr, pfn, false);
+}
+
 static inline vm_fault_t vmf_insert_page(struct vm_area_struct *vma,
 				unsigned long addr, struct page *page)
 {
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index b5d1e9d4463d..2f4dcaa819b7 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1615,7 +1615,7 @@ static vm_fault_t insert_pmd(struct vm_area_struct *vma, unsigned long addr,
  * @pfn: pfn to insert
  * @write: whether it's a write fault
  *
- * Insert a pmd size pfn. See vmf_insert_pfn() for additional info.
+ * Insert a pmd size pfn. See vmf_insert_pfn_mkwrite() for additional info.
  *
  * Return: vm_fault_t value.
  */
diff --git a/mm/memory.c b/mm/memory.c
index ff338c2abe92..b5555217b121 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -2719,40 +2719,55 @@ static vm_fault_t insert_pfn(struct vm_area_struct *vma, unsigned long addr,
 }
 
 /**
- * vmf_insert_pfn_prot - insert single pfn into user vma with specified pgprot
+ * vmf_insert_pfn_prot_mkwrite - insert single pfn into user vma with specified pgprot
  * @vma: user vma to map to
  * @addr: target user address of this page
  * @pfn: source kernel pfn
  * @pgprot: pgprot flags for the inserted page
+ * @mkwrite: whether to make the page writable.
  *
- * This is exactly like vmf_insert_pfn(), except that it allows drivers
- * to override pgprot on a per-page basis.
+ * This is the function underlying all the others in the vmf_insert_pfn()
+ * family.  It is the most flexible, as it allows drivers to override pgprot
+ * on a per-page basis, as well as to insert the pfn as if it already had
+ * a write fault.  vmf_insert_pfn() is usually sufficient, however.
+ *
+ * These functions should only be called from a vm_ops->fault handler, and
+ * in that case the handler should return the result of these functions.
  *
  * This only makes sense for IO mappings, and it makes no sense for
- * COW mappings.  In general, using multiple vmas is preferable;
- * vmf_insert_pfn_prot should only be used if using multiple VMAs is
- * impractical.
+ * COW mappings.
  *
- * pgprot typically only differs from @vma->vm_page_prot when drivers set
- * caching- and encryption bits different than those of @vma->vm_page_prot,
- * because the caching- or encryption mode may not be known at mmap() time.
+ * For vmf_insert_pfn_prot_mkwrite() and vmf_insert_pfn_mkwrite(), the
+ * @mkwrite argument allows installing a writable PTE even when @vma is
+ * under write notification, i.e. when it has a .pfn_mkwrite() callback.
+ * In this case, vma_set_page_prot() has cleared the write bit from
+ * @vma->vm_page_prot.  This lets the fault() callback install a writable
+ * PTE in response to write faults; note that .pfn_mkwrite() is not called,
+ * and therefore the caller has to do by itself whatever the callback would
+ * have done.
  *
- * This is ok as long as @vma->vm_page_prot is not used by the core vm
+ * For vmf_insert_pfn_prot_mkwrite() and vmf_insert_pfn_prot(),
+ * pgprot can differ from @vma->vm_page_prot.  This typically happens only
+ * for caching and encryption bits, which may not be known at mmap() time;
+ * it is ok as long as @vma->vm_page_prot is not used by the core vm
  * to set caching and encryption bits for those vmas (except for COW pages).
- * This is ensured by core vm only modifying these page table entries using
- * functions that don't touch caching- or encryption bits, using pte_modify()
- * if needed. (See for example mprotect()).
+ * This is ensured in two ways:
  *
- * Also when new page-table entries are created, this is only done using the
- * fault() callback, and never using the value of vma->vm_page_prot,
- * except for page-table entries that point to anonymous pages as the result
- * of COW.
+ * - core vm only modifies these page table entries using functions that don't
+ *   touch caching- or encryption bits, using pte_modify() if needed. (See
+ *   for example mprotect()).
+ *
+ * - when new page-table entries are created, this is only done using the
+ *   fault() callback, and never using the value of vma->vm_page_prot,
+ *   except for page-table entries that point to anonymous pages as the result
+ *   of COW.
  *
  * Context: Process context.  May allocate using %GFP_KERNEL.
  * Return: vm_fault_t value.
  */
-vm_fault_t vmf_insert_pfn_prot(struct vm_area_struct *vma, unsigned long addr,
-			unsigned long pfn, pgprot_t pgprot)
+vm_fault_t vmf_insert_pfn_prot_mkwrite(struct vm_area_struct *vma,
+			unsigned long addr, unsigned long pfn, pgprot_t pgprot,
+			bool mkwrite)
 {
 	/*
 	 * Technically, architectures with pte_special can avoid all these
@@ -2774,36 +2789,9 @@ vm_fault_t vmf_insert_pfn_prot(struct vm_area_struct *vma, unsigned long addr,
 
 	pfnmap_setup_cachemode_pfn(pfn, &pgprot);
 
-	return insert_pfn(vma, addr, pfn, pgprot, false);
+	return insert_pfn(vma, addr, pfn, pgprot, mkwrite);
 }
-EXPORT_SYMBOL(vmf_insert_pfn_prot);
-
-/**
- * vmf_insert_pfn - insert single pfn into user vma
- * @vma: user vma to map to
- * @addr: target user address of this page
- * @pfn: source kernel pfn
- *
- * Similar to vm_insert_page, this allows drivers to insert individual pages
- * they've allocated into a user vma. Same comments apply.
- *
- * This function should only be called from a vm_ops->fault handler, and
- * in that case the handler should return the result of this function.
- *
- * vma cannot be a COW mapping.
- *
- * As this is called only for pages that do not currently exist, we
- * do not need to flush old virtual caches or the TLB.
- *
- * Context: Process context.  May allocate using %GFP_KERNEL.
- * Return: vm_fault_t value.
- */
-vm_fault_t vmf_insert_pfn(struct vm_area_struct *vma, unsigned long addr,
-			unsigned long pfn)
-{
-	return vmf_insert_pfn_prot(vma, addr, pfn, vma->vm_page_prot);
-}
-EXPORT_SYMBOL(vmf_insert_pfn);
+EXPORT_SYMBOL(vmf_insert_pfn_prot_mkwrite);
 
 static bool vm_mixed_ok(struct vm_area_struct *vma, unsigned long pfn,
 			bool mkwrite)
-- 
2.55.0

