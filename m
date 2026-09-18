Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 833943A873C
	for <stable@vger.kernel.org>; Fri, 18 Sep 2026 14:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789742164; cv=none; b=b9yMfFQHpo1g+LUOx1BmzavqAk60OP33nhmR4CQjexdPDXjOQBLKbFHaTXCrTWg5/IwUxLmHfqCTXTCCB0jf2AVegsxy5u0Bg37vH3J0clkDOQzjH2qwMMEwn4edh1rJ3zjszQi8kBkDTHncyguGEPgnRC1YvmXaynCdflHZjBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789742164; c=relaxed/simple;
	bh=ot8Tb7RYx08WMlEjevn1gXX3bL83Futgu6go/Jy1K9Y=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ma4VU3tPj6j5TrK4IcDiI4w1r3G3EtcZwd39lNtgGQ4b0W0fRX1CKaBE6Pt7VuzoZkNQbKMPtecAG/IdCrJglVe46BCw3fFDYB6NQlau6xxfhmwtYXuJzLLch1gCnAfRlbya4ETvXXbYkiO0aqdUnGLWr6j8JZaZJE598I+g/V8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jKyOCxkK; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jKyOCxkK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789742162; x=1821278162;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=ot8Tb7RYx08WMlEjevn1gXX3bL83Futgu6go/Jy1K9Y=;
  b=jKyOCxkKde4LEKaaJOaDOTWmfpSwX7gwXUT5V726BZLPBW6FzZpN/t6d
   +/vgtlVpPuLKHrVJh5Iz8sDHqY40eXlVN0EBouACaeib/x/hl8K8yD2aH
   RvPdJmcZuHDOfvsj2ZHMAFyUT7VztYDnhLdpXNKcspZ1wPx3MARCtemcV
   Av3VboecmfCBWOOEpuES5+2/IfidRihc4mLDTGHSWmQAFVfuDlXyia2rO
   RKzb3mHHtaNK9bNOcE1EBH23hN+7rvRgysxSJF70i59X9shwAH4wuQztZ
   /3y3pKBhKc1iN+SmDWZjCR4hg+QrcJcf9D9+1T1SvcKKGWqDxG2dCawD9
   g==;
X-CSE-ConnectionGUID: JU0AJNqJRaaU6ZAdyFpGGQ==
X-CSE-MsgGUID: JSMF9tn3QmOmxi76JgH3UA==
X-IronPort-AV: E=McAfee;i="6800,10657,11909"; a="90118801"
X-IronPort-AV: E=Sophos;i="6.27,109,1787036400"; 
   d="scan'208";a="90118801"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2026 07:35:52 -0700
X-CSE-ConnectionGUID: PHLgrIX/Tg6mbuMPSHlzfg==
X-CSE-MsgGUID: A4g0KCaLQX61zwumOOUU2Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,109,1787036400"; 
   d="scan'208";a="270131837"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO [10.245.245.247]) ([10.245.245.247])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2026 07:35:50 -0700
Message-ID: <8c1744e4012ab5b30d1f26f8129d4944da1dcfa3.camel@linux.intel.com>
Subject: Re: [PATCH] drm/xe/vm: nuke PTs only after unlinking contested VMAs
From: Thomas =?ISO-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
To: Matthew Auld <matthew.auld@intel.com>, intel-xe@lists.freedesktop.org
Cc: Matthew Brost <matthew.brost@intel.com>, stable@vger.kernel.org
Date: Fri, 18 Sep 2026 16:35:43 +0200
In-Reply-To: <20260918131034.598078-2-matthew.auld@intel.com>
References: <20260918131034.598078-2-matthew.auld@intel.com>
Organization: Intel Sweden AB, Registration Number: 556189-6027
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2026-09-18 at 14:10 +0100, Matthew Auld wrote:
> In xe_vm_close_and_put(), external-BO VMAs are queued on the
> contested
> list for deferred destruction via xe_vma_destroy_unlocked(). However,
> xe_vm_pt_destroy() was previously invoked before processing contested
> VMAs, destroying vm->pt_root while those VMAs were still linked to
> their
> respective buffer objects (vm_bo->list.gpuva).
>=20
> If a concurrent thread evicts one of those shared buffer objects,
> xe_bo_trigger_rebind() holding only bo->resv walks the BO's VMAs and,
> in
> fault mode, calls xe_vm_invalidate_vma() -> xe_pt_zap_ptes(). Because
> vm->pt_root[tile->id] is already NULL, dereferencing pt->level causes
> a
> NULL ptr deref.
>=20
> Fix this by deferring xe_vm_free_scratch() and xe_vm_pt_destroy()
> until
> after all contested VMAs have been unlinked and destroyed.
>=20
> User is reporting hitting a NULL ptr deref in xe_pt_zap_ptes(), which
> could be explained by this race.
>=20
> Assisted-by: LLM
> Fixes: b06d47be7c83 ("drm/xe: Port Xe to GPUVA")
> Link: https://gitlab.freedesktop.org/drm/xe/kernel/-/work_items/9290
> Signed-off-by: Matthew Auld <matthew.auld@intel.com>
> Cc: Thomas Hellstr=C3=B6m <thomas.hellstrom@linux.intel.com>
> Cc: Matthew Brost <matthew.brost@intel.com>
> Cc: <stable@vger.kernel.org> # v6.12+

Reviewed-by: Thomas Hellstr=C3=B6m <thomas.hellstrom@linux.intel.com>


> ---
> =C2=A0drivers/gpu/drm/xe/xe_vm.c | 21 +++++++++------------
> =C2=A01 file changed, 9 insertions(+), 12 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/xe/xe_vm.c b/drivers/gpu/drm/xe/xe_vm.c
> index 17dc4debe7c1..390da884c727 100644
> --- a/drivers/gpu/drm/xe/xe_vm.c
> +++ b/drivers/gpu/drm/xe/xe_vm.c
> @@ -1979,21 +1979,13 @@ void xe_vm_close_and_put(struct xe_vm *vm)
> =C2=A0		vma->gpuva.flags |=3D XE_VMA_DESTROYED;
> =C2=A0	}
> =C2=A0
> -	/*
> -	 * All vm operations will add shared fences to resv.
> -	 * The only exception is eviction for a shared object,
> -	 * but even so, the unbind when evicted would still
> -	 * install a fence to resv. Hence it's safe to
> -	 * destroy the pagetables immediately.
> -	 */
> -	xe_vm_free_scratch(vm);
> -	xe_vm_pt_destroy(vm);
> =C2=A0	xe_vm_unlock(vm);
> =C2=A0
> =C2=A0	/*
> -	 * VM is now dead, cannot re-add nodes to vm->vmas if it's
> NULL
> -	 * Since we hold a refcount to the bo, we can remove and
> free
> -	 * the members safely without locking.
> +	 * Unlink and destroy all contested external-BO VMAs before
> destroying
> +	 * the page tables. Otherwise, concurrent eviction holding
> only bo->resv
> +	 * can walk the BO's VMAs and attempt to invalidate/zap page
> tables that
> +	 * have already been freed.
> =C2=A0	 */
> =C2=A0	list_for_each_entry_safe(vma, next_vma, &contested,
> =C2=A0				 combined_links.destroy) {
> @@ -2001,6 +1993,11 @@ void xe_vm_close_and_put(struct xe_vm *vm)
> =C2=A0		xe_vma_destroy_unlocked(vma);
> =C2=A0	}
> =C2=A0
> +	xe_vm_lock(vm, false);
> +	xe_vm_free_scratch(vm);
> +	xe_vm_pt_destroy(vm);
> +	xe_vm_unlock(vm);
> +
> =C2=A0	xe_svm_fini(vm);
> =C2=A0
> =C2=A0	up_write(&vm->lock);
