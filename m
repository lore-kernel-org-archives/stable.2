Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794682711;
	b=UBpKyFgaO+Y5FrnEqmPaZ4t7DhsHDZyU8XuZbpPpdV83KDkpLwy3RNyfGeMb4qFmTc9F
	 ZZxpt/A0q0N/CXr9zT7rI/yBPdu3vpProVozUjl8o6VpDa+24NHIr/PsSnA2R9XX5BG6K
	 TZ1y8BW00MDBkZp3xSIziFEvhdrbQmKJmzIiYDo1H0oVVfjYNTWKwCbpTZcOmMtfke2hw
	 zE9AbPXD9QomGIkEmnw+xhsDr2ncJchqyXeuGSJxu0HpEOOzXVVnTEcpTNWFvT5Mqa2nq
	 CZQ1Lx+ovXBQN3CeskD/KVQLHUv6KEXVFocReyXQ4YLuyZELp5yLl7fDJ928Icutz7w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794682711;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=fbMRE2X5e/AHLMS1eoGd56ly9fU3NIj/Z6Js5YflNNw=;
	b=3GrOt6v73UYy8RA5FnEb07L6lsrkwcEJ4ktEUsAcILjxZgicM6RLkbp3bR3uyd/syrD/
	 c1+5DSO3TJauTkzMLVE+ySu6VunhgohbdNvBDhjmPa+6OVzzSMxWuztDqv4LMmG6c1FO7
	 yYaX8UzchRRela1KwlCwNV0ZdKsAJhwptj89yLQBGJR2qrpGk/GNPqPL/wT769J6EZFXO
	 ZsMSgb4ikK+i+7mDroNevy3+5PkoWwVX+zc0AvJqb9bFxFol6DsJKkoAJo+v1i5PmImGQ
	 /cTtouF7IgdB6wcbf3vI0amXgom8zDu80uo/4pi5WITfscd9EdPUUjBwtsY83v6CH5Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QrNKwZwA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 782B0606A32E;
	Sat, 14 Nov 2026 18:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QrNKwZwA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 705CF1F000C4;
	Sat, 14 Nov 2026 18:58:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794682711;
	bh=fbMRE2X5e/AHLMS1eoGd56ly9fU3NIj/Z6Js5YflNNw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=QrNKwZwAQuneaTtIjhUo4EUrUSYJ0Tgqq+BeI6i3EclcZg5Aj0cKdFRA2jWkaRwVM
	 o89/ZYvAdf+R+m4hwUnNiti7YkwNBxWtmrgYa16vUWoUKDg2kwR8Pyn2ppXAWGc1rE
	 Odhrb3oyldEOoXHE8VirjW40E7ouLZcuaBg2Uvct+GTJGPFpgY/zNGoh4D1P7J8bcn
	 b2LWJ3PKD+DMr0cigxJqKKOi4hps0f2zLWEdtnX4RYGDbBO2mJSQHrkOmPTL9ujpE7
	 VFFpA6W+fv+gE1ajgBImOn3GCzZXx606MCvodl4cErNAR6jXS0Okksz/7gb8sBZdSa
	 6cOWGRzdkaSmg==
Date: Sat, 14 Nov 2026 18:58:21 +0000
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
	dri-devel@lists.freedesktop.org, linuxppc-dev@lists.ozlabs.org, stable@vger.kernel.org
Subject: Re: [PATCH 2/5] drm/i915: consider vm_pgoff in vm_access()
Message-ID: <avivB9Pw8I_oMbpk@gremlin>
References: <20261112-access_shite-v1-0-988a5c470db2@kernel.org>
 <20261112-access_shite-v1-2-988a5c470db2@kernel.org>
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
In-Reply-To: <20261112-access_shite-v1-2-988a5c470db2@kernel.org>

On Thu, Nov 12, 2026 at 11:08:58PM +0100, David Hildenbrand (Arm) wrote:
> vm_access() treats the start of every VMA as the beginning of the GEM
> object. After a VMA split, vm_pgoff identifies a later part of the
> object. Debugger reads and writes through ptrace or /proc/<pid>/mem then
> access the wrong bytes.
>
> Properly consider vm_pgoff just like the fault handlers already do.
>
> Fixes: 9f909e215fea ("drm/i915: Implement vm_ops->access for gdb access into mmaps")
> Cc: stable@vger.kernel.org
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

And since this is an mmap-an-fd driver thing there's no need to worry about anon
pgoff etc.

Looks sensible to me so:

Acked-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

> ---
>  drivers/gpu/drm/i915/gem/i915_gem_mman.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/i915/gem/i915_gem_mman.c b/drivers/gpu/drm/i915/gem/i915_gem_mman.c
> index 6b337684dbfe8..e3b24dc8e94f5 100644
> --- a/drivers/gpu/drm/i915/gem/i915_gem_mman.c
> +++ b/drivers/gpu/drm/i915/gem/i915_gem_mman.c
> @@ -511,13 +511,15 @@ vm_access(struct vm_area_struct *area, unsigned long addr,
>  	struct i915_mmap_offset *mmo = area->vm_private_data;
>  	struct drm_i915_gem_object *obj = mmo->obj;
>  	struct i915_gem_ww_ctx ww;
> +	unsigned long obj_offset;
>  	void *vaddr;
>  	int err = 0;
>
>  	if (i915_gem_object_is_readonly(obj) && write)
>  		return -EACCES;
>
> -	addr -= area->vm_start;
> +	obj_offset = area->vm_pgoff - drm_vma_node_start(&mmo->vma_node);
> +	addr += (obj_offset << PAGE_SHIFT) - area->vm_start;
>  	if (range_overflows_t(u64, addr, len, obj->base.size))
>  		return -EINVAL;
>
>
> --
> 2.43.0
>

--
Cheers, Lorenzo
