Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 429A83B27F5;
	Tue,  4 Aug 2026 14:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785853782; cv=none; b=HJNy4RIvLRCia1Q3EDdeRmEklBkyUrZnUbbhbt7CPDmBJtqCFFgYd65RR1kF0xalXX9TeK2F3uO/CTXELg/hoTcR+WIuCssuXjJcA2YTAYaexg/Nb8s690zA4YMaixiCMW3kOn7fZJQdfxmt5ijLm3nC87Xm0hqBawHXgvikYEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785853782; c=relaxed/simple;
	bh=CJZscXcd9jlSmZbfO+HKE7sWYPbvfpCJX3EqrHKqS7g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qroa09hcwToLc7+hW6tZDberskB9UnduylsPzZLIRWSaHO6X38r8Erk6Cq7TNr9MEUlyPyPJ4pnvK3kHPBiwHF46YAtFULqKlqcQulKuZP3J7YoSDzCrWHZ80oxBJaKNiwl6A3ZaJqAiVHsTK0aHh3hX0fBTw++ZCVr5ijFPBzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=hwueehHy; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="hwueehHy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1785853769;
	bh=CJZscXcd9jlSmZbfO+HKE7sWYPbvfpCJX3EqrHKqS7g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hwueehHyhN6iMjR5EvaXX4oTQgnnhQwVdI60kO5yIcdEyKutsDlq80ySXlHIRwZwp
	 l/+uNBE6mhwajbrNd6gFV2UMt1t151diqYdM3qTs/ag7apb7GsjzUceskdr79iU91o
	 aSiDPnbgy26hGcznS4vc1KSDsomDuUVUHbxyXn0aHXjqfDGpcBgYC1FTZYjffCL9Lb
	 AnL9fTfbdxPL7BMelsT1eCTPAwaJDKTZaqQ5jv8hZLlEPmt/DcG+g4ECTu40VpQbJX
	 0+7dqxGR9WqbSlSslTNPbWK671Zjduz8qi0mkuIOJWTQM9lpSatb6bbE1eEg0AHS97
	 zu2L+pTAUkfHA==
Received: from fedora-21.home (unknown [100.64.0.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bbrezillon)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 2D0A017E06DB;
	Tue, 04 Aug 2026 16:29:29 +0200 (CEST)
Date: Tue, 4 Aug 2026 16:29:24 +0200
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Konstantin Fastov <kfastov@gmail.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Andrew Morton
 <akpm@linux-foundation.org>, David Hildenbrand <david@kernel.org>,
 dri-devel@lists.freedesktop.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, regressions@lists.linux.dev,
 stable@vger.kernel.org
Subject: Re: [PATCH] drm/gem-shmem: Install writable PTEs for write faults
Message-ID: <20260804162924.0268f80a@fedora-21.home>
In-Reply-To: <20260804140403.16337-1-kfastov@gmail.com>
References: <20260804140403.16337-1-kfastov@gmail.com>
Organization: Collabora
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hello Konstantin,

On Tue,  4 Aug 2026 17:04:03 +0300
Konstantin Fastov <kfastov@gmail.com> wrote:

> Since the introduction of dirty tracking, drm_gem_shmem_vm_ops has a
> .pfn_mkwrite handler.  Its presence makes vma_wants_writenotify() true,
> so vma_set_page_prot() removes the write bit from vm_page_prot of
> shared mappings, and the vmf_insert_pfn() call in the fault handler now
> installs read-only PTEs even when serving a write fault.
> 
> For regular CPU accesses this is transparent: the retried access faults
> again on the present read-only PTE, goes through wp_pfn_shared() into
> .pfn_mkwrite() and the PTE is upgraded to writable.  But consumers that
> resolve faults through fixup_user_fault() + follow_pfnmap_start()
> perform no such retry.  In particular KVM's hva_to_pfn_remapped(),
> after "successfully" handling a write fault, finds a present read-only
> PTE, treats it as KVM_PFN_ERR_RO_FAULT and fails the vcpu run with
> EFAULT.  Observed as AsahiLinux/linux#560: muvm/libkrun microVMs
> mapping virtio-gpu blob resources die with EFAULT on first GPU access.
> The traced failing sequence:
> 
>   follow_pfnmap_start()        -> -EINVAL   (no PTE yet)
>   fixup_user_fault(WRITE)
>     drm_gem_shmem_fault()
>       vmf_insert_pfn()         -> NOPAGE    (read-only PTE installed)
>   fixup_user_fault()           -> 0         (fault "handled")
>   follow_pfnmap_start()        -> 0, !writable
>   hva_to_pfn()                 -> KVM_PFN_ERR_RO_FAULT
> 
> Fix it the same way commit cb2a2a5b37ad ("drm/shmem_helper: Make sure
> PMD entries get the writeable upgrade") did for the PMD path: when the
> fault is a write fault, install a writable entry directly and record
> the write for dirty tracking, instead of relying on a refault that not
> every fault-resolution path performs.
> 
> To do that at PTE level, add vmf_insert_pfn_mkwrite(), the VM_PFNMAP
> counterpart of vmf_insert_mixed_mkwrite(): insert_pfn() already
> implements the mkwrite semantics, there was just no wrapper exposing it
> for pfn inserts with the default pgprot.

The same issue is being discussed here [1].

Regards,

Boris

[1]https://lore.kernel.org/dri-devel/20260804120529.1730187-1-pbonzini@redhat.com/
