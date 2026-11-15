Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794728492;
	b=O5fAZfAf1CYLvWLphGwT+U5YSEycquG4Ezv38hIQSGjb8T5NgMSFX+bxTcvYYA8IXVRj
	 JEec4JKWjRYGytYtsKMILStFeX422PP0jPspMmA5zOmZ+9bPxK46QYQS8rvc8pucYi9qk
	 NE5X0Z0qZrrvVEjCz/l0/nIfGluPMT+1F2SNUarPMv4VgccObD+Wj586y8EjfVVFG/Qxo
	 bonv0HlWr2g5IM2V3zXHzh+p8/97FppE+6r8DyIMWNZ7F9zqP3DCy2I/mh9lFE84xYfMn
	 Ex+QhDCwYRzR8DzXy4eXpuxmkuRrQMvn/EU+CkwPCBZTV9EVf5a0y7K38A1tOgabcSg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794728492;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=Iy1yWZA87o4ANy6mo1o5HnWu61B5w2dWNIFuaUYI9SA=;
	b=mtWT7gBoSu2Koei/1PY20SaLAknwGztNmU89UFbtk7amFPB8N9IjweroOACIDM1nFyFR
	 a3tsosHM/UqBnhwTHahQRVspNMCCcPI/8UFZQ4XJeVJSjtOky1nLzCC7PmZExR6tn+CJP
	 W9cvMZl18sSiaWYsYjhS2EOBSdBBoES4wQp9JW+xUZ60D+2dwBIyFOy5GTVMcbRWSyko3
	 d/3w2bLxbOpXnJvhcafwNGM2ju5Omyv3hCsve9Yld914K3qjc5Tox3ANQwjB4qM0h0I24
	 tWTqR4Z9jzjMIzqsgOYatFHZbhpk8XKgR3/JJyK9UhwMKpG++azUqECCtU3PtXscfLQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mtr6zl5v;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F76A606A31D;
	Sun, 15 Nov 2026 07:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mtr6zl5v
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81C611F000C4;
	Sun, 15 Nov 2026 07:41:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794728492;
	bh=Iy1yWZA87o4ANy6mo1o5HnWu61B5w2dWNIFuaUYI9SA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=mtr6zl5vtZdcMhU8RYT7ZO+1iF5+jlryoLi8lH5M08/CZQnDAAO59t/I/SXIeMokj
	 D8O5zC4oWfHlcEtTEMSzcUjhTUNLZlOJJ2k5vK8gJjk6SsKFZ5vozS8JTlTS9Ifhkv
	 U5Sus+GSUTIzd7TfdQjhj7McNwnq9sr9BLbEuVxVYZsU/ygfZT4oy2f2SBiTEHPLua
	 vch01kbM2vnWyvBTPcJsKLm7sYPaOHo6erW57kCViR16cZLCjdkwOGexOzVj8slfx3
	 i/yaFJZCVN30fAwRjNn3tjbgl21wPCEY7XutedIZaelaEMkxgmvKXnG6NYa3fKHTSY
	 hTt6MKV/s1yAQ==
Date: Sun, 15 Nov 2026 09:41:27 +0200
From: Mike Rapoport <rppt@kernel.org>
To: shao.mingyin@zte.com.cn
Cc: akpm@linux-foundation.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] mm/execmem: check execmem_restore_rox() failure in
 execmem_cache_free()
Message-ID: <avliJ2K24YJYvxXe@kernel.org>
References: <20261115004704544fuMEkcx0F4A1sNBAzz46-@zte.com.cn>
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
In-Reply-To: <20261115004704544fuMEkcx0F4A1sNBAzz46-@zte.com.cn>

On Sun, Nov 15, 2026 at 12:47:04AM +0800, shao.mingyin@zte.com.cn wrote:
> From: Shao Mingyin <shao.mingyin@zte.com.cn>
> 
> mm/execmem: check execmem_restore_rox() failure in execmem_cache_free()
> 
> __execmem_cache_free() checks execmem_force_rw(), but ignores the
> matching execmem_restore_rox() result before adding the block to the
> free ROX cache. A failed restore can leave permissions only partially
> updated, so a later cache allocation can return memory that is not ROX.
> The cache allocation path does not reapply permissions.
> 
> Check the restore result and return the error. The existing callers keep
> failed frees pending and retry them through delayed work. This prevents
> a block whose ROX restoration failed from entering the free cache, and
> matches the error handling in execmem_vmalloc_rox().
> 
> Fixes: 187fd8521dd8 ("execmem: rework execmem_cache_free()")
> Cc: stable@vger.kernel.org # 6.17
> Signed-off-by: Shao Mingyin <shao.mingyin@zte.com.cn>
> ---
> Build-tested mm/execmem.o with W=1 and CONFIG_ARCH_HAS_EXECMEM_ROX=y
> on x86_64. The pending-free error path was reviewed statically.
> No natural CPA restore failure or BPF execution fault was reproduced.
 
Yes, because it cannot happen.
 
>  mm/execmem.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/execmem.c b/mm/execmem.c
> index 349cadd874863a8b82052470e3b0e7b0df2e0ba7..4a48e9f445a02f783ca4dd501559cded54892dd8 100644
> --- a/mm/execmem.c
> +++ b/mm/execmem.c
> @@ -351,7 +351,9 @@ static int __execmem_cache_free(struct ma_state *mas, void *ptr, gfp_t gfp_mask)
>  		return err;
>  
>  	execmem_fill_trapping_insns(ptr, size);
> -	execmem_restore_rox(ptr, size);
> +	err = execmem_restore_rox(ptr, size);
> +	if (err)
> +		return err;
>  
>  	err = execmem_cache_add_locked(ptr, size, gfp_mask);
>  	if (err)
> 
> base-commit: 84abb955b1015477aa11a96e2f3ac1b938b77f48
> -- 
> 2.43.0

-- 
Sincerely yours,
Mike.
