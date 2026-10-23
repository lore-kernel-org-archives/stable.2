Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792776664;
	b=p9CGUpRlJBUSSpld8L2un2jpiHE2jr+rSUjBhNfGubKrIVRKE/7wCSd5vbiox5GBSEsY
	 8+NbGEgCuB5I5J7qmazV3uzj+LPAQfq881Jy5JSrV2ZfA0/87amDBzKnY0msarEjN3sAW
	 5Bxy6yfMz9xuS2MuanF2p9/LdkOqpejvGPUdeMN1On98uLu3MerQ7xztKk+2GF8E1ZrFp
	 k41s1MUamDd9R8RqE8IMNO62fryMWMyhAyOQiNeq4j9Oi8x+E+oxUGfaO3iF7FNQaXzNb
	 /WHizb3n1QC9iSi4pp+nhBd/KeWlpfP5higQ1YW4h5Cn8Fx5SfunWCrgFF7+WD089uw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792776664;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=vCuyheP3hRwaXPnVY11qKs5HWYXsCMG1K1Wdmf7PfIM=;
	b=0Cj8tP7Lr15wneWlBsr8trylo3v1zzgJ3DE/oeONL91b3etRY8ysoNgdQHTRSzv5mdTY
	 q6qTiOep39AkR17DgRgEg9+3HhNblL3y0O0XWaamXWs8sxbo5F/212B/+GQzlZQDqqKG6
	 UHLLrg0yZNXxr0Ucj+0eZv3KMYfrjWzqy1RyvvHsRJ2bwflEDkbTRJmFK1hkTPbYhIGeq
	 nlOnXaEeHhI6Oe/KxUXb44vrnM+hRwdDX9QOTt5rL1zKfzzvNenPQjrKiuOyCU6688MMT
	 UyJyLqytsAIydHAJruUwwwMEK9/J/1h/b4cO7AcLmgr+hJyw8ke5CGxwoGCp3tUNbXA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OLMBpdxF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BB9C606A31B;
	Fri, 23 Oct 2026 17:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OLMBpdxF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73A1E1F01825;
	Fri, 23 Oct 2026 17:31:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792776664;
	bh=vCuyheP3hRwaXPnVY11qKs5HWYXsCMG1K1Wdmf7PfIM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=OLMBpdxFOpWykEJlNQFOsL+hIYiRkoWdxHGC6hU3w6aU/G93yMFipAiwJkR2JVW3J
	 Z9nkLRTa+kgdaHLTGwrK1URPwqMkcBs+6aGag+eRSf7XqsmFtY7kABsazSKHt1Vo3u
	 B6KrXksB6gg4FJFSfUn81ykSx/YbnJJSmJ1fhCuB9q3Z1BFQEU7T6KPUtvjh0SHi6C
	 e92vTigW79GPVx5PUlt1bTunKrpmngrvfM8eA7DqEVFgX+bh+F/R0MGCaRoQv/gOJ8
	 RG3yZvY+EDZNCjh3i71ASo6pFThoSjcWk0n1DRsrmzMxaSu7fCfau9cYLXKJar3QVD
	 FHG1Nl54mNwUg==
Date: Fri, 23 Oct 2026 18:30:58 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, 
	Jakub =?utf-8?Q?Mat=C4=9Bna?= <matenajakub@gmail.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Luiz Capitulino <luizcap@redhat.com>, stable@vger.kernel.org
Subject: Re: [PATCH] mm/vma: fix expansion of VMA_MIXEDMAP_BIT VMAs
Message-ID: <atuY-n02IWHY7SOT@gremlin>
References: <20261023-vma-expansion-fix-v1-1-6142baf1f46b@kernel.org>
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
In-Reply-To: <20261023-vma-expansion-fix-v1-1-6142baf1f46b@kernel.org>

On Fri, Oct 23, 2026 at 04:17:31PM +0100, Lorenzo Stoakes (ARM) wrote:
> Commit ca3d76b0aa80 ("mm: add merging after mremap resize") combined
> merging with expansion of mremap()'d VMAs, however it also unintentionally
> disallowed the expansion of unmergeable VMAs.
>
> Previously it was possible to expand a mixed mapping which mremap() had
> already ensured was a legal expansion.
>
> This is clearly seen in the mremap() logic, as it checks
> vma_is_fixed_mapping() to determine legality of an expansion rather than
> vma_can_merge().
>
> Additionally, copy_vma() allows for a failed merge to result in a new VMA
> being instantiated if MREMAP_MAYMOVE is specified.
>
> However, this is not attempted, as a failure in vma_merge_extend() is
> assumed to be an -ENOMEM failure.

Just to note that VMA_MIXEDMAP_BIT VMAs can _currently_ be expanded if not
attempted to be expanded in-place (e.g. MREMAP_FIXED, or if not enough space to
expand into).

So this patch doesn't re-add the ability to do that per se, it just fixes one
specific means of doing what is already a valid operation.

VMA_MIXEDMAP _expanding_ isn't really a problem - if no fault handler is
installed, faults in the expanded region will SIGBUS, and if one exists it'll be
invoked correctly.

This doesn't work for VMA_PFNMAP_BIT because the page offset might be co-opted
for CoW (!) and thus is unreliable.

And it seems some users do, at least in theory, require it, even if they are
using older kernel revisions :)

> Since vma_merge_extend() is used exclusively by mremap() to perform a merge
> and/or expansion, resolve the issue by invoking vma_expand() for
> unmergeable VMAs there.
>
> Explicitly assert that the VMA is both non-fixed and a mixed mapping.
> This provides double insurance against broken changes in future.
>
> Note that khugepaged_enter_vma() (which vma_merge_new_range() runs) is
> redundant in this case, as a mixed mapping is not subject to khugepaged.
>
> Also update the VMA userland tests to add a required predicate.
>
> Reported-by: Luiz Capitulino <luizcap@redhat.com>
> Closes: https://lore.kernel.org/all/20261023023106.515365-1-luizcap@redhat.com/
> Fixes: ca3d76b0aa80 ("mm: add merging after mremap resize")
> Cc: stable@vger.kernel.org
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> ---
> Confirmed that this fixes the repro and passes mm selftests and the VMA
> userland tests.

--
Cheers, Lorenzo
