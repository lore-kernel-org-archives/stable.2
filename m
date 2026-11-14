Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794682796;
	b=zO1Rrfbw/CGolJDKkgcfM4XTHQp8MrAsjhLqpJtSL9JdbHeuSRSw5Ar2T3T3t82e6ife
	 0XboCRn4mWOd8ylCVTy84pJAUFEQx2E/Z/tNGDVDHZomrYMLO/KFIIVdaMh5ostPeOXGi
	 vKLO0OoqGnKSrzo4sfdXwnfbSM782Hm5eY09KAn/v7wezluwpGEjnqs+oDg3OEzFljN//
	 SF7uiOJiGAtilsraAxrmlh86dDpl2Ne6XvBqyvM2GSNr5T6lia/+TNoXKdifYKYZirVXw
	 6hJGYr0PBHcvkZ08nqz9ZndbX5d6097OfXl1GcByTX9TYAM5fRR1ngaTAqcXvxOZVkg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794682796;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=aaNFykkpcP0cS9Qocp3fy2eSJ2KoYeW3YHSZ5vyz1zs=;
	b=ckk5k+qP7uoiTcNb8eJFjTwaWXUhLPGkXSTwnKzRPQcaBDC8U1w/UtZKecdSS8MCa/Y8
	 lUlBcyqqmAZLbJTmWO11AL0z5KmoUqcQmFRdKmQtBWrf5u6E38ls9WNVlT4Meztho0OW5
	 gaGnMBFwlsTj0tan/VuIgAwsxhQPCeQ6siCTwKH3jJdX/89wag7TN1pj2qUGRYFPM5jvo
	 YgsX7Pp4okEgH7MJQ93KsV4vD/pZffVtl7FlPseuIQcw9h6z7haBMMg+QeaAZZZWxvaYo
	 K6LLxs+7KOyqeeEKlT4K6agmuFeBlV4QKwHu6i7uAavSv6Ki9iECFI8cqrSLO8BIpEA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XMkwiY6D;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 412B8606A329;
	Sat, 14 Nov 2026 18:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XMkwiY6D
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0D9E1F000C5;
	Sat, 14 Nov 2026 18:59:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794682796;
	bh=aaNFykkpcP0cS9Qocp3fy2eSJ2KoYeW3YHSZ5vyz1zs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=XMkwiY6DpCIGsfriwGOqAWiPbK24F3D6OKfV/wHCov4+5BCJ1Wsj6VNzuk3cUkr4X
	 zqFlsrkAIPyHinsg2xIoVAroHyZRHs/937xwsCZMYzDt0j3vdA/aNN6AL4a7Ar1UIm
	 xWDZmQtLLMAX/3EzhkLpQva8U9TmOwg1uj+/DyTBWHgO4u2uypjXye5kITKh10eT4Q
	 mXWVM0MJ0Gqja2R0B3NAtgAPW5LNXakn+kjO8cjKvWyMGjP2b69i85RrE6V0+H6sD4
	 Vh4tyCRczjK0QAiDfPX9j729otk3VF/cGRqHlIYeL36JIC/Ihszo0adHvWQDm09JGM
	 rwfddaTkgm1Sw==
Date: Sat, 14 Nov 2026 18:59:46 +0000
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
Subject: Re: [PATCH 4/5] powerpc/spufs: consider vm_pgoff in
 spufs_mem_mmap_access()
Message-ID: <avivjtM2rxpUAXDB@gremlin>
References: <20261112-access_shite-v1-0-988a5c470db2@kernel.org>
 <20261112-access_shite-v1-4-988a5c470db2@kernel.org>
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
In-Reply-To: <20261112-access_shite-v1-4-988a5c470db2@kernel.org>

On Thu, Nov 12, 2026 at 11:09:00PM +0100, David Hildenbrand (Arm) wrote:
> spufs_mem_mmap_access() calculates the local store offset relative to the
> start of the VMA and ignores vm_pgoff. After VMA splits, debugger reads and
> writes access the wrong part of the local store. Mappings created with a
> nonzero file offset have the same problem.
>
> Properly take the vm_pgoff into account, just like spufs_mem_mmap_fault()
> already does.
>
> Fixes: a352894d0705 ("spufs: use new vm_ops->access to allow local state access from gdb")
> Cc: stable@vger.kernel.org
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

Seems sensible for similar reasoning for previous patch so:

Acked-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

> ---
>  arch/powerpc/platforms/cell/spufs/file.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/arch/powerpc/platforms/cell/spufs/file.c b/arch/powerpc/platforms/cell/spufs/file.c
> index 98c47bafaf678..0a46d6f7178ab 100644
> --- a/arch/powerpc/platforms/cell/spufs/file.c
> +++ b/arch/powerpc/platforms/cell/spufs/file.c
> @@ -248,7 +248,8 @@ static int spufs_mem_mmap_access(struct vm_area_struct *vma,
>  				void *buf, int len, int write)
>  {
>  	struct spu_context *ctx = vma->vm_file->private_data;
> -	unsigned long offset = address - vma->vm_start;
> +	unsigned long offset = address - vma->vm_start +
> +			       (vma->vm_pgoff << PAGE_SHIFT);
>  	char *local_store;
>
>  	if (write && !(vma->vm_flags & VM_WRITE))
>
> --
> 2.43.0
>

--
Cheers, Lorenzo
