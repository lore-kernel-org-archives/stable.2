Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793660689;
	b=a63qOprW4cVmeHN9R6ZGXLOqdV3Q/Ml/Ub367zr7AP4Zv54G3REJI157mdqEvV/aSvX6
	 rEgxUiEc5TUkzC10RSA1zoe+2ESGacYHlul0f6iliXEsTk1shG4RVC1Hgi5Jke5w94yN9
	 F1czwY4N9qlidDV0xhEyTKw2AVhLP2LysTCpXqEBwjMrI0VoMjxN0OkYj3vG4uIYq7YE7
	 Sv4OPckPNqlJDL8stwZeTc8GvuVEXXUibvObSsq/vLxF761Qmv/sZBW4Wfg8VsfFmOLHF
	 Q252gKCj+637BFeFchjvME6f4DD3KpYDzog+TF3FQJzBuQ+isgQoZAwsAsXYTcTwa/w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793660689;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=qdpAw2CeVyl2O4/SsZKsGMa/ZVARBuLoVGSK/7j1CNs=;
	b=MZDDhcq5U10AQaRYYbXS5PGFkiem4ewVd1glH6Rc8fg8wWG2ne8+yTwywso3pb4OVhOo
	 yVE2Z+EO92qBgc/iA1lPGK6+tpOwCnyShEiNjiu+SprmTB/k7HTyMttTTC+ifvRm2h4Z0
	 aNNzw1iJUJgoD0SEmQevyEXQuBkERRB0FuJzaPn9tIySpX8HH6tJOlSfV5g+xEzAv6rTy
	 jwZbpBIsUJ6yhwmdxGirMdnJPt3z0tjhLKUsmur9VKli8O15aG2vP1uUZwXdZBGeE0dQc
	 NwN5ChI/kaMo8azZesNMkSycAK5/hORIMzn4ACKCpaCgIfafNCX3YXwWBhCJAtUb3TA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=hah3TSoG;
	arc=none smtp.remote-ip=74.125.82.198
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACE24606A33C
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 23:04:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ACE24606A33C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=hah3TSoG
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-33713e5e6daso4273723eec.0
        for <stable@vger.kernel.org>; Mon, 02 Nov 2026 15:04:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793660688; x=1794265488; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qdpAw2CeVyl2O4/SsZKsGMa/ZVARBuLoVGSK/7j1CNs=;
        b=hah3TSoGUiSjnJ9CjCJ0hl31I4MkPtW5OjjUoE0rfgwTX8MmuuVLCwXkqDjKeSLV2o
         AcfUqTPlyBGVeB4pvirfmOt8VpkKRarpjE3aSCD+w23EEjCNL8r02oMSELAnax0wVtHq
         3OGKFddD5fCW4TCLPpU5SyijQD+7E6XaRkVJBA2tAfQo6I4Xz54UD4GOzBddKwLHNxfm
         kfS/DPvarpF/CztXwG7ze0dVXR1hgBhMHqxjJhD2pbCUi5KyNHdUzgZSJHxZzxT9c9tf
         n3LM0XFiplDKDKO7OoTmrHStiYcgSLSW5wDErJ3IBLkTRjDrFmd/sJnN/shK40lItCwT
         POYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793660688; x=1794265488;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qdpAw2CeVyl2O4/SsZKsGMa/ZVARBuLoVGSK/7j1CNs=;
        b=wf41qKTk1XTnjXNGyH1P8kVoEagqshWqe478O8mGfOJOwwcH0cBKfXwG5YueDPbvE5
         MW5Gsvq/6WNeO8+fc/r88XG51W7j8Lk8cq6eLjJST59vMI8BG3zYyXY39pDxPwJ/SGP+
         K0byaKQ6YsBUJXNfAhEMS8FHOhY9mbqXh37S/GfpIGKHoICNunJ7mLT6Z/A6rS9CTgwj
         6ME6cooDPIgiZ+hkCjx9l+VeNZS70orofzw1rg4jWJJKVQODAhnzHyutS9p5abXFdksp
         HtHMHEMc0Vs0I17a4/h3grkZ4M1c7AWU2+LQjzHbeamuVhgUFCuzyqLBOxUlvdjms9dy
         pZPA==
X-Forwarded-Encrypted: i=1; AKwUvBxCQcwH9X/Bff3sOKtcHkJqZmViS6jDjyh4n97svqNWy7qJTECqknxri1Nppo1g0r574j73Ztk=@vger.kernel.org
X-Gm-Message-State: APuU4Z/WKUBeesMLwcxV7Gtj/etS0s40GSubikL2G9L6XBLr0RVSZZ2o
	Ii9aTfKdBO3KeA1MsXmQq0PrZz3UUt6AiA0IV2P72yujrcsxv5zsDNxaL9vV55aDoA4iY50/tWl
	iS0J/ZXEjvOcnq3rbeMHhogQr/w==
X-Received: from dyki13.prod.google.com ([2002:a05:7300:7c0d:b0:369:f67f:7a43])
 (user=almasrymina job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:693c:41dc:10b0:366:9f06:3c4c with SMTP id 5a478bee46e88-36a423f8794mr17637350eec.32.1793660687421;
 Mon, 02 Nov 2026 15:04:47 -0800 (PST)
Date: Mon,  2 Nov 2026 23:04:43 +0000
In-Reply-To: <20261102230445.3993629-1-almasrymina@google.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261102230445.3993629-1-almasrymina@google.com>
X-Mailer: git-send-email 2.56.0.385.gac671c819a-goog
Message-ID: <20261102230445.3993629-2-almasrymina@google.com>
Subject: [PATCH v3 1/3] vfio/pci: pass FAULT_FLAG_WRITE to vmf_insert_pfn_pmd/pud()
From: Mina Almasry <almasrymina@google.com>
To: Peter Xu <peterx@redhat.com>, Alex Williamson <alex@shazbot.org>, 
	Andrew Morton <akpm@linux-foundation.org>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc: Mina Almasry <almasrymina@google.com>, David Matlack <dmatlack@google.com>, 
	Shuah Khan <shuah@kernel.org>, Kevin Tian <kevin.tian@intel.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Raghavendra Rao Ananta <rananta@google.com>, Vipin Sharma <vipinsh@google.com>, Alex Mastro <amastro@fb.com>, 
	stable@vger.kernel.org, Ankit Agrawal <ankita@nvidia.com>, 
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Content-Type: text/plain; charset="UTF-8"

vfio_pci_vmf_insert_pfn() is the only caller of vmf_insert_pfn_pmd() and
vmf_insert_pfn_pud() in the kernel that hardcodes write=false instead of
passing vmf->flags & FAULT_FLAG_WRITE (unlike drm, panthor, and mshv).

On x86_64, normal MAP_SHARED | PROT_WRITE VFIO BAR mappings usually mask
this bug because vma->vm_page_prot already has _PAGE_RW set. However,
when vma->vm_page_prot starts read-only, insert_pmd() and insert_pud()
with write=false install a read-only huge entry without calling
pmd_mkdirty()/maybe_pmd_mkwrite() (and similarly for PUD). Subsequent
write-protection faults enter wp_huge_pmd() or wp_huge_pud(), which call
vma->vm_ops->huge_fault() to upgrade the entry in place. Because
vfio_pci_vmf_insert_pfn() passes write=false, insert_pmd() and
insert_pud() see !pmd_none(*pmd) with !write, do nothing, and return
VM_FAULT_NOPAGE, causing an unrecoverable infinite write page-fault loop
and host CPU soft lockup on the next userspace or KVM guest MMIO store.

In practice, vma->vm_page_prot is read-only on a writable MAP_SHARED BAR
mapping in two situations:

1. Userspace soft-dirty tracking (CONFIG_MEM_SOFT_DIRTY) when a process
   such as CRIU (during pre-dump/checkpoint), a VMM live-migration loop,
   a memory profiler, or an unprivileged process holding a VFIO device
   fd writes "4" (CLEAR_REFS_SOFT_DIRTY) to /proc/<pid>/clear_refs. That
   clears VM_SOFTDIRTY on all VMAs (including VM_PFNMAP) and calls
   vma_set_page_prot(), stripping _PAGE_RW from vma->vm_page_prot for
   subsequent huge faults.

2. Architectures where shared writable mappings start read-only for
   software dirty tracking, such as arm64 without hardware DBM
   (CONFIG_ARM64_HW_AFDBM off or FEAT_HAFDBS absent), where _PAGE_SHARED
   sets PTE_RDONLY | PTE_WRITE and pgprot_noncached() preserves
   PTE_RDONLY on MT_DEVICE_nGnRnE mappings until pmd_mkdirty() clears
   it on a write fault.

This bug was found by code inspection while auditing huge_fault handlers
and reproduced with a VFIO PCI selftest on a 2 MiB-aligned BAR mapping
after writing "4" to /proc/self/clear_refs.

Pass vmf->flags & FAULT_FLAG_WRITE to vmf_insert_pfn_pmd() and
vmf_insert_pfn_pud() so write faults properly mark huge PFNMAP entries
dirty and writable.

Fixes: f9e54c3a2f5b ("vfio/pci: implement huge_fault support")
Cc: stable@vger.kernel.org
Cc: Ankit Agrawal <ankita@nvidia.com>
Cc: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
Cc: David Matlack <dmatlack@google.com>
Signed-off-by: Mina Almasry <almasrymina@google.com>
---
 drivers/vfio/pci/vfio_pci_core.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
index fcbb2da860e2..204d959086e9 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -1745,6 +1745,8 @@ vm_fault_t vfio_pci_vmf_insert_pfn(struct vfio_pci_core_device *vdev,
 				   unsigned long pfn,
 				   unsigned int order)
 {
+	bool write = vmf->flags & FAULT_FLAG_WRITE;
+
 	lockdep_assert_held_read(&vdev->memory_lock);
 
 	if (vdev->pm_runtime_engaged || !__vfio_pci_memory_enabled(vdev))
@@ -1754,10 +1756,10 @@ vm_fault_t vfio_pci_vmf_insert_pfn(struct vfio_pci_core_device *vdev,
 		return vmf_insert_pfn(vmf->vma, vmf->address, pfn);
 
 	if (IS_ENABLED(CONFIG_ARCH_SUPPORTS_PMD_PFNMAP) && order == PMD_ORDER)
-		return vmf_insert_pfn_pmd(vmf, pfn, false);
+		return vmf_insert_pfn_pmd(vmf, pfn, write);
 
 	if (IS_ENABLED(CONFIG_ARCH_SUPPORTS_PUD_PFNMAP) && order == PUD_ORDER)
-		return vmf_insert_pfn_pud(vmf, pfn, false);
+		return vmf_insert_pfn_pud(vmf, pfn, write);
 
 	return VM_FAULT_FALLBACK;
 }
-- 
2.56.0.385.gac671c819a-goog

