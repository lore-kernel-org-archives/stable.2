Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794599884;
	b=VMF/YiFoN2z1OZUmX4iICR5HdKiY9fe0PDsV3YnQJ42h5qGn9ZezIr0BFIvCwiRFYcq1
	 NJz6PoZaH2+jtNCclvu2nL7T6CYzbT8iBVHf280cEnh0jNdZAldAav4TZMEy3CE6eB5hx
	 T5gPT03fN8bCa20TbmD+mnvRaycNDuBzJrGe9t6TQ4QNFRweLOxpzIBG0N99vTHPMU6M0
	 L0fjK0qomLenHzyNEKYpx81l24jsprQ25ah609F/enSDhXj7FELIMsbayBMU6aVYJBZMi
	 QerQRNVNN1q6xCT7J0/3o3Yi3QRR3p5tPdfJRn7GlYfnJ8tV1BrTVsjKapRyOv9qWiw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794599884;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=IbLqO6g0MnnThcPzBQZqW0ZRgI8AVvZaYZ5qNuebmZw=;
	b=fear/k0NtosUDvaT4QdxoqPOP96ASzTY90+9ZY1I4TEfYHeqs62ZjCfJtrAulVgU5I+R
	 XHSckfdk7wRqOERgQe2E1j69IJ7pxW8oyxBgpT/GC6jknr8nljv1/SapweEgL1/50UiJK
	 F7Iwj5qhNAY/S2H2Jr8hZY8jXpaR0O+05d3ZKRzhnr2fbaiS/wQyl2xGNvjGMRt2ptWRW
	 5KxAbn8ocf7drOutv8pDiuJ2/Y+toScnR/WZTwO9fdUQpvoojvFzcqE2EO2ei6rmGOVzT
	 wRZa/oRhXn9BIOcpLXpvSNdCibxq2d5/kwGjZpKOAa18qfy4yMNpmDDMxJYyJk+MFfA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BBOhDTuU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47D20606A8B3;
	Fri, 13 Nov 2026 19:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BBOhDTuU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91E851F000C4;
	Fri, 13 Nov 2026 19:58:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794599883;
	bh=IbLqO6g0MnnThcPzBQZqW0ZRgI8AVvZaYZ5qNuebmZw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=BBOhDTuU2n/nCaaU+nqxXKoavYB8xw1K8tCCIvrNVcpBL7ENgr/B27IziPRbNzyyd
	 aNdSayCifYvib6Z5Hr78yad6NBJdmHl7/NVANgM+kdWkUS9lftyZXD4oOZNTHVxeQ4
	 scOicWe7x9RgVoIyjgvWnA0EPnIcqMTYROuTCaycprVbErerCeXdIVR6dapBwhgyuv
	 VZ0rSyXzCEwgrTd020Wqxi+kq8OjsXpiRsuRMUoXY2V9CvT8Bnrsh9Utu5a+PxeubS
	 pUL0Vs1d92xFpQsUqKb2EI4XwMwYAauS1y6+EFU4F7VQgewrgrYfex/qI63EC89uR6
	 R2XsRsE+bGaCg==
Date: Fri, 13 Nov 2026 19:57:57 +0000
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: "Gregory Price (Meta)" <gourry@gourry.net>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, kernel-team@meta.com, 
	jgg@ziepe.ca, leon@kernel.org, akpm@linux-foundation.org, david@kernel.org, 
	kas@kernel.org, dave.hansen@linux.intel.com, bp@alien8.de, rppt@kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH] mm/hmm: reject shadow-stack mappings
Message-ID: <avdrZ716BHN-JLc6@gremlin>
References: <20261113195536.2660763-1-gourry@gourry.net>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261113195536.2660763-1-gourry@gourry.net>

On Fri, Nov 13, 2026 at 02:55:36PM -0500, Gregory Price (Meta) wrote:
> HMM can grant ordinary device write access to a userspace shadow stack.
> On x86, pte_write() is true for a shadow-stack PTE, so a populated page
> can be returned with HMM_PFN_WRITE without taking a CPU write fault.
>
> Nouveau translates that flag into a writable GPU mapping.
>
> Reject shadow-stack VMAs in hmm_vma_walk_test(). Use the existing
> unsupported-range handling: a requested fault returns -EFAULT, while a
> snapshot records HMM_PFN_ERROR.
>
> Link: https://lore.kernel.org/linux-mm/20261111-mason-migrate-et-al-fixes-v1-10-3d2454362e8d@kernel.org/
> Fixes: 54007f818206 ("mm: Introduce VM_SHADOW_STACK for shadow stack memory")
> Cc: stable@vger.kernel.org
> Cc: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
> Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>

Thanks for doing the HMM side of this, LGTM and:

Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

> ---
>  mm/hmm.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/mm/hmm.c b/mm/hmm.c
> index 2f1e98c6b644..fa61ca59d927 100644
> --- a/mm/hmm.c
> +++ b/mm/hmm.c
> @@ -596,6 +596,7 @@ static int hmm_vma_walk_test(unsigned long start, unsigned long end,
>  	struct vm_area_struct *vma = walk->vma;
>
>  	if (!(vma->vm_flags & (VM_IO | VM_PFNMAP)) &&
> +	    !vma_test_single_mask(vma, VMA_SHADOW_STACK) &&
>  	    vma->vm_flags & VM_READ)
>  		return 0;
>
> @@ -607,6 +608,8 @@ static int hmm_vma_walk_test(unsigned long start, unsigned long end,
>  	 * allow write access either. HMM does not support architectures that
>  	 * allow write without read.
>  	 *
> +	 * Devices must not gain ordinary write access to shadow stacks.
> +	 *
>  	 * If a fault is requested for an unsupported range then it is a hard
>  	 * failure.
>  	 */
> --
> 2.56.0
>

--
Cheers, Lorenzo
