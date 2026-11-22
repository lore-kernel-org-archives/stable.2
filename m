Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795325201;
	b=bWL47eD4fei/BwzxISNwFtbcBxTp9fM7qQ5rKyxYaqQrGosUNjPpc9wVZZFpnN/6B+C8
	 D+hTnKmujb8xPZHzWMS4FjRbqYw9zrTgT138lSlktZNw8ryRZm+wGI+Ox/2kGB2YElG8u
	 seTM2NYyRbS4vQGPHLd/8hOx8nn3GfcxjOoQTzGWsR9Xqy/7KZvJLg7iUYYKFm2gTM9qA
	 RuuO2gW/SZWwWlvOueDG1gNYaOJhfAM4OqjLvGzL+De++JNp8b5cyIRG7iDl22ClHL6am
	 s2aXUNuAx6U9ZK0X3xdnxEcUUEc6GElmz+J9SS1upmGyb+tYKHSvevaqhPfycn6n97w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795325201;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=WSnfBOApNbDPGY48k9YGggczifS4bUOcX4lLr98nel0=;
	b=btQ3QaIx6FsRi/7GBQRlFpzdHRmOGE7oQ6UGTelZhethz4xj4mSo/TDliH8strh5ztfb
	 Vj1Fd4vC7aw6gJkWFiIZTbSmmE9jd04zqnpICWSOKR3tYm+rJEFIVLzaq4GwKtoYXzIKi
	 ZXHP4jy8Gl5cstoe6aEqWrrRHhCwstEoVlZ/cSC6WQ8va14uSUXJ7fIcGj7I8Cobpzz6Z
	 mu9ExhnS86xT3U6bBcByuU8eP2e3RdGH6o/t+U7fBbUcK83x8bVTYX6v6wt3FpzV0JXvd
	 nNUuMYCGlGvD3VSSvAT6aO8xErXk/TrIIRpX2fNQFJXeWkkN5r/FnYKnB/3rFfc6aog==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HJItbHDv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF3FB606A320;
	Sun, 22 Nov 2026 05:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HJItbHDv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF2751F000C0;
	Sun, 22 Nov 2026 05:26:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795325200;
	bh=WSnfBOApNbDPGY48k9YGggczifS4bUOcX4lLr98nel0=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=HJItbHDvxHdHNGEPigBjrg7fcjQSOd8PgOf7vuO+6yBqH4tB7RipP96RU6pFQozl3
	 pGEPRYhoDmFS+ppu5C1unEChsx7GLJg8aVuE9t7wSdsWl/7aULMhVeFeCXQ6SbIjNM
	 qX8RCByQKeyixmKo0d+RciosMXerwxInMCuL60HHJi4obdjmmM4XJJ7OY9YbU44IwD
	 5Mwqje+QOCJTnjYV09Ul58Y3+SctZQdKbcflU8NvdeWKtGpJMQybuuW0S7zDvobBtY
	 0GdLVXMU0a3mnktHlL8d8E13Z0ZqZLGPs7hR3JNU+TURzE7b6d5cVTfPkHL9G12Nc1
	 KdAd8v4L3MrwQ==
Content-Type: multipart/mixed; boundary="===============8672382131251748710=="
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <86a108a3441c8160bcf73fe92b8ff79dd6562d3313c80e65489607f3d737d50b@mail.kernel.org>
In-Reply-To: <20261122-b4-03-bpf-arena-vmalloc-oob-v2-5f6209c1a20e-v2-1-b2a9906e9676@pm.me>
References: <20261122-b4-03-bpf-arena-vmalloc-oob-v2-5f6209c1a20e-v2-1-b2a9906e9676@pm.me>
Subject: Re: [PATCH bpf v2] bpf: bound arena allocations to the user VMA
From: bot+bpf-ci@kernel.org
To: fadouse@pm.me,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com
Cc: martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,ihor.solodrai@linux.dev,bpf@vger.kernel.org,linux-kernel@vger.kernel.org,stable@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Sun, 22 Nov 2026 05:26:38 +0000 (UTC)

--===============8672382131251748710==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: bound arena allocations to the user VMA

TL;DR: Commit message page counts don't add up and its "can never be mapped
without wrapping" claim is questionable; the new -ERANGE check in
arena_adjust_tree() looks unreachable and its comment seems inaccurate.

> A program that first allocates 287 pages and
> then asks for 288 more receives pgoff = 287, uaddr32 = 0xfffff000,
> and arena_alloc_pages() maps 288 pages at kern_vm_start + 0xfffff000:
> one page inside the VMA, then the arena's upper guard pages, and then
> 258 pages into the vmalloc area past the end of the arena's own
> vmap area - installing PTEs into address space the arena does not own
> and returning a "success" pointer to the caller.
[ ... ]
> Fix this on both sides.  On the first mmap() of a map created without
> map_extra, mark [vma_pages, max_entries) as allocated in the range
> tree, because nothing outside the VMA can ever be freed or mapped
> without wrapping;

The page counts do not seem to add up here.  GUARD_SZ is
round_up(1 << 16, PAGE_SIZE << 1), so kern_vm_start is offset by 32 KiB
into the area and the upper guard above kern_vm_start + 4 GiB is 32 KiB,
which is 8 pages with 4 KiB pages.

Mapping 288 pages at kern_vm_start + 0xfffff000 would then be 1 page in
the 4 GiB band and 8 upper guard pages, leaving 279 pages past the end of
the arena's vm area, and 1 + 8 + 258 is 267, not 288.  Could the numbers
be corrected?

Also, is "nothing outside the VMA can ever be freed or mapped without
wrapping" accurate?  Pages outside the VMA can never be freed because
arena_free_pages() clips to user_vm_end, but they only wrap when the VMA
ends close to a 4 GiB boundary.  For a 4 GiB aligned user_vm_start,
uaddr32 = pgoff * PAGE_SIZE stays inside the arena's own kernel area.

> diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
> --- a/kernel/bpf/arena.c
> +++ b/kernel/bpf/arena.c

[ ... ]

> @@ -758,8 +787,19 @@ static int arena_adjust_tree(struct bpf_arena *arena, long uaddr, long page_cnt,
>  	ret = range_tree_find(&arena->rt, page_cnt);
>  	if (ret < 0)
>  		return ret;
>
> +	/*
> +	 * The range tree spans max_entries pages, but when map_extra was
> +	 * not given at arena creation time the user VMA, and hence the
> +	 * range whose lower 32 bits do not wrap past the 32-bit boundary,
> +	 * can be smaller.  A pgoff past the VMA would wrap uaddr32 past
> +	 * the 32-bit boundary, be mapped past the end of the arena's
> +	 * kernel vm area, and could never be freed, so reject it.
> +	 */
> +	if (ret > page_cnt_max - page_cnt)
> +		return -ERANGE;
> +
>  	*pgoff = ret;

This isn't a bug, but does this comment match the code after this patch?

The comment says "The range tree spans max_entries pages", but
arena_map_mmap() now clips the tree on the first mmap():

    ret = range_tree_clear(&arena->rt, vma_pages(vma),
                           map->max_entries - vma_pages(vma));

Since page_cnt_max is 0 until user_vm_start/user_vm_end are stored, and
arena_alloc_pages() returns early when page_cnt > page_cnt_max, the tree
already spans at most page_cnt_max pages whenever arena_adjust_tree()
runs.  That would make the -ERANGE branch unreachable today, with the
clip in arena_map_mmap() being what enforces the bound.

The claim that "a pgoff past the VMA would wrap uaddr32" also only holds
when the VMA ends near a 4 GiB boundary.  For a VMA starting at a 4 GiB
aligned address, uaddr32 = pgoff * PAGE_SIZE < 4 GiB for every pgoff <
max_entries, so those pages land inside the arena's own kernel area.

Could the comment say that the mmap-side clip enforces the bound and that
this check is only a backstop, and drop the universal "would wrap" claim?
Alternatively, could the check be removed if the clip alone is the
intended invariant?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/44987264909
--===============8672382131251748710==--
