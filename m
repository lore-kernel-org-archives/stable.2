Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80FD939794B
	for <stable@vger.kernel.org>; Tue,  4 Aug 2026 12:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785845159; cv=none; b=Y0N4RdT0SMGeYOC4f/3/tQvHDRGJpfYocb+NXMxSXa97noTOLr6o2EQUfQeOy6et+Hd7oejO9b0OYchin0H/eTXgOtSW0XqKE4Jgwranq2Pv/MpyzNccbVIe/GDv90n7oR6ssUnXDW6XmJThZrF+O8epmNjdRllTePnDsG3dBRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785845159; c=relaxed/simple;
	bh=ShgJllGtoj3B6lj3SHwP+387ixSZNj2YWvPFDV6BseQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iK8JyhrFT04eU4ZiB+n/CmYu591b0U4Lc9BnD+bqnQ7kinMVHXkl+4AHkjFeOna9kSo4/mpAoucapoh7nTijFgP7/U4vyHCImsy/13H5433ISIxl6YeRDGEthx4wRSkF9dl1JyIHggUqak8zi/9qmBmcxuy9ykx96PbQVjtrofY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Lkbpw6Uw; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=cAIhJJ5i; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Lkbpw6Uw";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="cAIhJJ5i"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785845154;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7VbhR/EeseCGUhv0h0yNN2Py/m+SxPzo7FfzMk4g7pY=;
	b=Lkbpw6UwaLsL2A4ZXBDYYsxqDFDELJT8j1r/0uUULsXKbqyW+ibC0iZV7Z485leidyqHp8
	NfO1vaLWTSszyMGqNXgrrMa1QI4RZt0uN1fqkliiGtdcN7IaEKxjqdjKci85Du0tCye68C
	F5xiq3Yf7z8A6aIsHgwPuNjTgSITBuU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-222-BjhZixXBP2KEOfdQtDU9SA-1; Tue, 04 Aug 2026 08:05:47 -0400
X-MC-Unique: BjhZixXBP2KEOfdQtDU9SA-1
X-Mimecast-MFC-AGG-ID: BjhZixXBP2KEOfdQtDU9SA_1785845146
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-47fe23b5acdso1981278f8f.0
        for <stable@vger.kernel.org>; Tue, 04 Aug 2026 05:05:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1785845146; x=1786449946; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7VbhR/EeseCGUhv0h0yNN2Py/m+SxPzo7FfzMk4g7pY=;
        b=cAIhJJ5iypZOUTPkcOfJVA/+T+eNpiURGumey1wvCCiEqCPTbkXpjDSGd2kXAlHDgI
         it6fL70CYJYt++jBX6Pg7dkNwpXmtH4S8MZJHfIyPz7qSzaoI7AJWObi6LyXq1QAfh/N
         Nr2H8i0KrzVACddd0yxSRxEE6+k/odK4HgyRlQphWwyA20wzRZgCDegc5FmKqS2c5ye6
         RpHmIy+9gHvLWdHzrHXywY3ZWc4sDBUJ7s6R48hgs3rRopd8PtRMx2yA9PQRiWon403Q
         VhxLqw3teQZewLTMwxlTswIepR9ZxT8+XJNtkWPVglCnSf0NucOUpwbbhFuuxmtfrjBV
         3ijw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785845146; x=1786449946;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=7VbhR/EeseCGUhv0h0yNN2Py/m+SxPzo7FfzMk4g7pY=;
        b=Dgg9RZw+koJlUNKOvra2twasgi8A82NFRW31Gmj9o2rqUVb+wmhqm9lODYFOxBXRso
         5m3Y0ko3e7YMTBhe0mZsJpNmkrKSHkCB6sxtNVbWMemH/u5v7unc0+EJAgQtq5t4pavI
         YUgfyx10SKmrgNLrg++PPZw2W6YwapScOprtx/o13Ax66x+5brWqHB2LZSOxk+yJb+03
         xo24e9Q5wBiiovDVivWXO5aMRY5NHfkSf3yjWyN+4nJGjJP4eF3cYe97l/k99I0FAl7Q
         0aFpSTDJxEi/5UMgvf/1V2CmNpiKHPLQJbk+rICKKtvT9rpxTQuLIVNTbUfsIizYg0GC
         LtmQ==
X-Forwarded-Encrypted: i=1; AHgh+Rob2UTelybXXOJnDVSFJyoZRG658WezNo5h5L5lpcAw0rxITCP9fvQlaDIaaY+s0swalKWIn5o=@vger.kernel.org
X-Gm-Message-State: AOJu0YyX/OORtyQ7loPHZeyqXfTZP6Q0oIDmLHLas745P7aSU+S+Bqwe
	VFv0/L9vcrWBlztNCGxyxQoVP6aC2O8gmMegw9o/2F3cAXSBeazVl8jyZ0l5GVBFYCHdoDQwRT7
	VHpvG5OosFy4SeIE+9WIRdEiI1KDAMasXAbyJbsa6IPdN3K8RTgO9fRA0EQ==
X-Gm-Gg: AR+sD12N0aLDc+4sjlL8PV3Z15rPdeIz4uPKhVvs6B66uMYxQ2koqMcFynZG3tWQC2i
	irYKlE3+F1hgq8TOci8MlkjWmS90Hh36HRCQzGsGdLX+4cIsB+HYjgj/jnqdOcJd5LrAHVNlhQB
	y7hJIBvgcdofJimZjPtnu1dA3scqo0PjzHn1U8URYCet/2odv9gskBj61aaBbVA+UC6we+15XzH
	QG/W9OJdg+U05sWLToplVSPbqlPoCM2RD2/8WSemhtuNNx5dEABnen3nCBGxHa+dk9asdYs8B/Y
	e8ZsOQB3LyU8Kv3FX/hr3UmbTVJx/h7/ARkVkaqYseE9K80JDewcrEMCBZTXK4Ed+YN7O3fT+mW
	AqzZIYqlDLI1tHD1vqMDGkzza9coQ4kunyMCHR1ipM/Y9hDzXa0WkGUFrFob9eRw+SCC33CDyek
	dtXD4=
X-Received: by 2002:a05:6000:2989:20b0:47f:7154:9dfc with SMTP id ffacd0b85a97d-47fd72a8e68mr29813774f8f.9.1785845146053;
        Tue, 04 Aug 2026 05:05:46 -0700 (PDT)
X-Received: by 2002:a05:6000:2989:20b0:47f:7154:9dfc with SMTP id ffacd0b85a97d-47fd72a8e68mr29813677f8f.9.1785845145601;
        Tue, 04 Aug 2026 05:05:45 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.34.92])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fd4562667sm45367660f8f.24.2026.08.04.05.05.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 05:05:43 -0700 (PDT)
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
Subject: [PATCH v2 4/6] kvm: apply VM_READ/VM_WRITE checks to all VMA types
Date: Tue,  4 Aug 2026 14:05:26 +0200
Message-ID: <20260804120529.1730187-5-pbonzini@redhat.com>
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

The VM_READ and VM_WRITE flags are checked only at the very end of
hva_to_pfn().  For both the hva_to_pfn_remapped() case and for regular
mappings, this adds unnecessary cases and inconsistent error behavior.

For hva_to_pfn_remapped(), the code is relying on fixup_user_fault() to
detect this situation.  This is fragile because hva_to_pfn_remapped()
returns different error codes for a !VM_WRITE VMA depending on whether
the PTE happens to be mapped:

* if the PTE is present, follow_pfnmap_start() sets args.writable to
  false and KVM_PFN_ERR_RO_FAULT is returned;

* if no PTE is present, fixup_user_fault(FAULT_FLAG_WRITE) returns
  -EFAULT after checking vma_permits_fault(), and hva_to_pfn() ends
  up returning KVM_PFN_ERR_FAULT.

With this patch KVM_PFN_ERR_RO_FAULT is returned uniformly.  Likewise,
a PROT_NONE pfnmap VMA would be mapped into the guest if the PTE was
pte_present()[1] when the guest attempted to read it; with the patch
instead KVM uniformly returns KVM_PFN_ERR_FAULT.  Doing the check early
avoids these special cases and also sidesteps the issue pointed out at
https://sashiko.dev/#/patchset/20260731160514.1101989-1-pbonzini%40redhat.com.

For regular mappings a PROT_READ VMA, if placed in a writable memslot,
would return KVM_PFN_ERR_FAULT instead of KVM_PFN_ERR_RO_FAULT when
the guest writes to it.  This would cause a -EFAULT exit to userspace,
instead of triggering emulation as the VM_IO|VM_PFNMAP arm would do;
however it should be considered part of the KVM API because mmu_stress_test
relies on it.

Still, even with this snag about the returned pfn error code, pull the
vm_flags checks in front so that they are done for all VMAs and the
above inconsistency goes away for the VM_IO|VM_PFNMAP case.

[1] on x86, for example, such a page would have _PAGE_PRESENT clear
  but _PAGE_PROTNONE set

Fixes: 28e3918179aa ("drm/gem-shmem: Track folio accessed/dirty status in mmap")
Cc: stable@vger.kernel.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 virt/kvm/kvm_main.c | 34 ++++++++++++++++------------------
 1 file changed, 16 insertions(+), 18 deletions(-)

diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 45e784462ec6..576bcb21be3a 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -2925,17 +2925,6 @@ static int hva_to_pfn_slow(struct kvm_follow_pfn *kfp, kvm_pfn_t *pfn)
 	return npages;
 }
 
-static bool vma_is_valid(struct vm_area_struct *vma, bool write_fault)
-{
-	if (unlikely(!(vma->vm_flags & VM_READ)))
-		return false;
-
-	if (write_fault && (unlikely(!(vma->vm_flags & VM_WRITE))))
-		return false;
-
-	return true;
-}
-
 static int hva_to_pfn_remapped(struct vm_area_struct *vma,
 			       struct kvm_follow_pfn *kfp, kvm_pfn_t *p_pfn)
 {
@@ -3008,20 +2997,29 @@ kvm_pfn_t hva_to_pfn(struct kvm_follow_pfn *kfp)
 retry:
 	vma = vma_lookup(current->mm, kfp->hva);
 
-	if (vma == NULL)
+	/*
+	 * GUP failed.  It could be an inaccessible mapping, a pfnmap one,
+	 * or the page might be absent.
+	 */
+
+	if (vma == NULL || unlikely(!(vma->vm_flags & VM_READ))) {
 		pfn = KVM_PFN_ERR_FAULT;
-	else if (vma->vm_flags & (VM_IO | VM_PFNMAP)) {
+	} else if ((kfp->flags & FOLL_WRITE) && unlikely(!(vma->vm_flags & VM_WRITE))) {
+		/*
+		 * Exit to userspace for PROT_READ mappings in a writable
+		 * memslot, as this is part of the API.
+		 */
+		pfn = vma->vm_flags & (VM_IO | VM_PFNMAP) ? KVM_PFN_ERR_RO_FAULT :
+			KVM_PFN_ERR_FAULT;
+	} else if (vma->vm_flags & (VM_IO | VM_PFNMAP)) {
 		r = hva_to_pfn_remapped(vma, kfp, &pfn);
 		if (r == -EAGAIN)
 			goto retry;
 		if (r < 0)
 			pfn = KVM_PFN_ERR_FAULT;
 	} else {
-		if ((kfp->flags & FOLL_NOWAIT) &&
-		    vma_is_valid(vma, kfp->flags & FOLL_WRITE))
-			pfn = KVM_PFN_ERR_NEEDS_IO;
-		else
-			pfn = KVM_PFN_ERR_FAULT;
+		pfn = kfp->flags & FOLL_NOWAIT ? KVM_PFN_ERR_NEEDS_IO :
+			KVM_PFN_ERR_FAULT;
 	}
 	mmap_read_unlock(current->mm);
 	return pfn;
-- 
2.55.0

