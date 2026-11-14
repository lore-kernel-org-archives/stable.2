Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794683292;
	b=xu5oQ9G18OxM8C8mxZ6uytWFVHQnuY1xJY4FS2Vnb8FqCu6dSiRyVOy8YYDs1ZKaVg4a
	 TJ8+TJgMylY5xcwpWD6dKT0u9gGTM9RYbWwo0j+UJ+uFQi8S6wvc/dc8KsEedBu9cB2g1
	 q+boBIRMJ0UlkenMhb69FUdt9ZXgHMOmaXxEBE1SNbY65/dvj5PLXi41KPdbZkFQ51/Ha
	 wJ4840j8Q4KGzUd3pylm0alEZvKAQ+roX8oFNojaExM6jmkawYdDFaT5EUaUcaig1C7sW
	 fl58Tdya8P5e+tK9y7lw/ZzBWi3NGPYui4IwjY4DSoUfU+z8P3EK+zpTGkqVVqU7guw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794683292;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=jrpYg7S3w1u/s304fksd+9WkuwgFpjkNMJMjxnYOktE=;
	b=d5wSaGyIB36OuT7VPDHbcSpm61Bdw+uLFnXiFs5axHZlGHjiHL2enVeRXywmHmhwE5Ox
	 Mcnd5iGMKNoBw0rBwh6QqUD6UJ+T8l6q9GsXhVZlJ/gBfN5UTTLmd+f2mAMMgJMR4Y1ik
	 TaWzrp/8rEtqfteU2CeZWi+XDRk9Ts3Gq8lyMTiJdYPNixzw4MBfUcc3NO2eJv2oK2p8/
	 2OyGWbBhbyPM6PR8wcAKs/iR05VIOddG9cyovLraPi8NCfL8eEPL6Nmw9X6e0gyfnTphH
	 V8n8ZNQSszMRLEX2+zmG60iat+rjEa8hXDL/Xm5NxCfh7VRZLywQh4v7KudoDbCCHsA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QYNoTnXj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B93AA606A323;
	Sat, 14 Nov 2026 19:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QYNoTnXj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C2531F000C4;
	Sat, 14 Nov 2026 19:08:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794683292;
	bh=jrpYg7S3w1u/s304fksd+9WkuwgFpjkNMJMjxnYOktE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=QYNoTnXjjZhBPnpa8pOfyk2yFfApF74bnIOvALp/oKYkwpyK77UolVRCAS9PWBwUT
	 vTBNeJc2BT3hD65bSUXiJIzuZRodbsdX1fnL8/SMLFCYNn/+H570eO0UW2ZwVw9sWk
	 GMxUycxR4kFYE/1x4BsPOWM6QfVcHWY7lAkRzLGYC2spj4KtaAwckhv3IaoPq1c+i0
	 7WJXBqF1BvvLoxaDFl2abs10ZuIiJ39Ub7KZHMiai60iJ0e/m7v+0PTgqGv8kiifml
	 yLA7l8Fl3UguxEqgTAbhHe6k1GakSXqMGY5FQ9ZyVqlS8LVqbDnHwiqz6bl9cWiY9E
	 wqQgRo+ur+kWQ==
Date: Sat, 14 Nov 2026 19:08:02 +0000
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: "Liam R. Howlett" <liam@infradead.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Willy Tarreau <w@1wt.eu>, 
	Jani Nikula <jani.nikula@linux.intel.com>, Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, 
	Rodrigo Vivi <rodrigo.vivi@intel.com>, Tvrtko Ursulin <tursulin@ursulin.net>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Chris Wilson <chris@chris-wilson.co.uk>, Matthew Auld <matthew.auld@intel.com>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, Shrikanth Hegde <sshegde@linux.ibm.com>, 
	Rik van Riel <riel@redhat.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linuxppc-dev@lists.ozlabs.org, stable@vger.kernel.org, 
	Felix Kuehling <Felix.Kuehling@amd.com>, Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>, 
	Chris Mason <mason@kernel.org>
Subject: Re: [PATCH 5/5] mm: check permissions and bounds for vm_ops->access
Message-ID: <aviwYZhpXFczMwRR@gremlin>
References: <20261112-access_shite-v1-0-988a5c470db2@kernel.org>
 <20261112-access_shite-v1-5-988a5c470db2@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261112-access_shite-v1-5-988a5c470db2@kernel.org>

On Thu, Nov 12, 2026 at 11:09:01PM +0100, David Hildenbrand (Arm) wrote:
> GUP rejects VM_IO and VM_PFNMAP mappings early. __access_remote_vm() then
> falls back to vm_ops->access without checking VMA permissions and without
> limiting the request to the VMA size.
>
> Consequently, /proc/<pid>/mem can bypass protections even without
> FOLL_FORCE, or cross into another mapping without checking its
> permissions.
>
> Check VMA permissions before calling ->access and limit each request to
> the current VMA. Implement similar access permission checks as GUP,
> however:
>  (1) Reject writes to CoW mappings because the callbacks access backing
>      memory directly and cannot handle CoW.
>  (2) Allow forced writes to non-CoW mappings with VM_MAYWRITE.
>
> This intentionally breaks forced writes through legacy amdgpu PROT_NONE,
> MAP_PRIVATE debugger mappings. The workaround in commit fa5239f2af98
> ("drm/amdgpu: workaround failed COW checks for Thunk VMAs") cleared
> VM_MAYWRITE to avoid CoW, but debugger writes still succeeded by
> exploiting the missing access-permission checks fixed here. Reads remain
> supported. Userspace must use MAP_SHARED instead; ROCm 5.5.0, released
> in May 2023, already does so.
>
> Link: https://github.com/ROCm/ROCT-Thunk-Interface/commit/fea44fab6e84eda52fcf6b419b35600c18f4c022
> Fixes: 272ddc8b3735 ("proc: don't use FOLL_FORCE for reading cmdline and environment")
> Cc: stable@vger.kernel.org
> Cc: Felix Kuehling <Felix.Kuehling@amd.com>
> Cc: Christian König <christian.koenig@amd.com>
> Cc: Simona Vetter <simona@ffwll.ch>
> Reported-by: Chris Mason <mason@kernel.org>
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

LGTM, yikes at this in general :)

Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

> ---
>  mm/memory.c | 25 +++++++++++++++++++++++--
>  1 file changed, 23 insertions(+), 2 deletions(-)
>
> diff --git a/mm/memory.c b/mm/memory.c
> index d4370c1b331c9..9872f289c1e49 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -7362,6 +7362,7 @@ EXPORT_SYMBOL_GPL(generic_access_phys);
>  static int __access_remote_vm(struct mm_struct *mm, unsigned long addr,
>  			      void *buf, int len, unsigned int gup_flags)
>  {
> +	const bool force = gup_flags & FOLL_FORCE;
>  	void *old_buf = buf;
>  	int write = gup_flags & FOLL_WRITE;
>
> @@ -7401,15 +7402,35 @@ static int __access_remote_vm(struct mm_struct *mm, unsigned long addr,
>  			if (gup_flags & FOLL_ANON)
>  				break;
>
> +			if (write) {
> +				if (!vma_test(vma, VMA_MAYWRITE_BIT))
> +					break;
> +				if (!vma_test(vma, VMA_WRITE_BIT) && !force)
> +					break;
> +				/*
> +				 * In contrast to GUP, we historically allowed
> +				 * FOLL_FORCE write access to non-CoW mappings.
> +				 * However, we must always reject CoW mappings
> +				 * as we cannot CoW here.
> +				 */
> +				if (vma_is_cow_mapping(vma))
> +					break;
> +			} else if (!vma_test(vma, VMA_READ_BIT)) {
> +				if (!force || !vma_test(vma, VMA_MAYREAD_BIT))
> +					break;
> +			}
> +
>  			/*
>  			 * Check if this is a VM_IO | VM_PFNMAP VMA, which
>  			 * we can access using slightly different code.
>  			 */
>  			bytes = 0;
>  #ifdef CONFIG_HAVE_IOREMAP_PROT
> -			if (vma->vm_ops && vma->vm_ops->access)
> +			if (vma->vm_ops && vma->vm_ops->access) {
> +				bytes = min_t(unsigned long, len, vma->vm_end - addr);
>  				bytes = vma->vm_ops->access(vma, addr, buf,
> -							    len, write);
> +							    bytes, write);
> +			}
>  #endif
>  			if (bytes <= 0)
>  				break;
>
> --
> 2.43.0
>

--
Cheers, Lorenzo
