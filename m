Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DBF83AF656;
	Wed,  2 Sep 2026 07:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788332422; cv=none; b=KQ62vhEfryrLGLkVJGeXMMkXp/Rb9xd41V9sK1TlZNu2/6sIvDdMdwcipBAiN09M1Sqvr1aY3L/b493nagEdSIgP0imhqSUDatiETa3SBVLBSCPnoKCRi6EoWiCGf3hlk6KfAQpVVk6YjRfZllJYgPBlcp/dNT50vJKelExOI+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788332422; c=relaxed/simple;
	bh=8bj7QNbdM6zlJ+BocDGXs3na7c4GnZFS7071sjJJMhU=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=b2qZ6qesIXdJ2RidmdnqXHXdeg+uF9cQrOv3e4Z0wKBVXndufRgPwcHJGZxY50kujJ+pCA9NdANBFYfDMhYNQPdgt8nd/xqgmpS95ZecZDemcfCdiGASu3cPTKjBH0FEGd9hQXqq9xYZaJBPEZ01KVjsG0rag0TCX9wjwzktjGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=edprlGG5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="edprlGG5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBE2C1F00A3A;
	Wed,  2 Sep 2026 07:00:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788332421;
	bh=6GQWjWiyHMh2NyzpXqt8ZPQBafv2oClqvk7rN86jNY0=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=edprlGG5rdgI2dhNAMIZridLzVabhdXyXnRUiZRQg1vo77kz7/3zA82+1F40pWTAj
	 s4tgyizJeg9xRGuXD3/CWPs/okWeFAQ8C4kCx0u97J86dHSFvYzmbCYojYM/brpI4o
	 GMmGG4J82I3NbaI34HrPdHSBhI07+ZLFkencpHTjEU3fUFRWNl2+QynIZ0YLW75g78
	 4g5MhnsRPZ/gaKIYsGVFEDN5MfB3Trxm29HZYUpSDH0UjKNLTphUR2YGcNIwBFimIs
	 uV7yi3NDcyzx4SECSrq7SJTJZN9C1zlgVQQRNfv3DpP+L9D9QGhQPWH3wfmxwxoJnE
	 vdRaQqwNlrsrA==
Content-Type: multipart/mixed; boundary="===============5269529957093976897=="
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <594ed4944926f6a7202b016eca03d879d11bfdf09a2cbaea039421ae4ab962c0@mail.kernel.org>
In-Reply-To: <20260902061451.1416-1-cp0613@linux.alibaba.com>
References: <20260902061451.1416-1-cp0613@linux.alibaba.com>
Subject: Re: [PATCH bpf v2] bpf, riscv: Make arena support depend on ZACAS
From: bot+bpf-ci@kernel.org
To: cp0613@linux.alibaba.com,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,memxor@gmail.com,bjorn@kernel.org,puranjay@kernel.org
Cc: ihor.solodrai@linux.dev,eddyz87@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,pulehui@huawei.com,pjw@kernel.org,palmer@dabbelt.com,guoren@kernel.org,bpf@vger.kernel.org,linux-riscv@lists.infradead.org,linux-kernel@vger.kernel.org,stable@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Wed,  2 Sep 2026 07:00:19 +0000 (UTC)

--===============5269529957093976897==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_comp64.c
> index 74efe4b138d2..151031e97a24 100644
> --- a/arch/riscv/net/bpf_jit_comp64.c
> +++ b/arch/riscv/net/bpf_jit_comp64.c
> @@ -2128,7 +2128,15 @@ bool bpf_jit_supports_ptr_xchg(void)
>
>  bool bpf_jit_supports_arena(void)
>  {
> -	return true;
> +	/*
> +	 * The arena range tree uses kmalloc_nolock(), which needs
> +	 * cmpxchg128, provided by ZACAS on riscv.
> +	 */
> +#ifdef system_has_cmpxchg128
> +	return system_has_cmpxchg128();
> +#else
> +	return false;
> +#endif
>  }

The constraint being checked here is a slab property (kmalloc_nolock()
requiring cmpxchg128 support), not a JIT property. Fixing it
per-architecture leaves the identical misleading -ENOMEM on every other
architecture.

Looking at mm/slub.c, kmalloc_nolock() rejects the request whenever
the cache lacks __CMPXCHG_DOUBLE:

    if (!(s->flags & __CMPXCHG_DOUBLE) && !kmem_cache_debug(s))
            return NULL;

and __CMPXCHG_DOUBLE is __SLAB_FLAG_UNUSED (0) whenever the arch
provides no system_has_cmpxchg128 on 64-bit (mm/slab.h).

Grepping every definition of system_has_cmpxchg128 in the tree gives:

    arm64        constant 1
    s390         constant 1
    x86_64       boot_cpu_has(X86_FEATURE_CX16)
    loongarch    cpu_opt(LOONGARCH_CPU_SCQ)
    riscv        this patch's ZACAS check

Yet the other bpf_jit_supports_arena() implementations are unconditional:

    arch/powerpc/net/bpf_jit_comp.c      return IS_ENABLED(CONFIG_PPC64);
    arch/x86/net/bpf_jit_comp.c          return true;
    arch/loongarch/net/bpf_jit.c         return true;

So on ppc64 kmalloc_nolock() can never succeed for a non-debug cache,
and arena_map_alloc() returns -ENOMEM unconditionally -- exactly the
symptom this patch is fixing, with no ZACAS involved. The same holds
for x86_64 CPUs without CX16 and loongarch without SCQ.

Is a check in generic code (arena_map_alloc() or a slab-provided
helper) worth considering to fix all affected architectures at once and
avoid replicating SLUB internals knowledge into each arch JIT hook?

--- Commit message ---

> The arena range tree allocates its nodes with kmalloc_nolock() since
> commit f8c67d8550ee ("bpf: Use kmalloc_nolock() in range tree").
> kmalloc_nolock() requires slab caches with cmpxchg128 support
> (__CMPXCHG_DOUBLE); on riscv cmpxchg128 is provided by the ZACAS
> extension. On systems without ZACAS every arena map creation fails
> with a misleading -ENOMEM.

The claim "every arena map creation fails with a misleading -ENOMEM" is
not exhaustively accurate. Looking at mm/slub.c:

    if (!(s->flags & __CMPXCHG_DOUBLE) && !kmem_cache_debug(s))
            /*
             * kmalloc_nolock() is not supported on architectures that
             * don't implement cmpxchg16b and thus need slab_lock()
             * ...
             * kmem_cache_node->list_lock, so kmalloc_nolock() can attempt
             * to allocate from debug caches by
             * spin_trylock_irqsave(&n->list_lock, ...)
             */
            return NULL;

The condition is an AND: when the cache is a debug cache (slub_debug
boot parameter, or CONFIG_SLUB_DEBUG_ON=y), kmalloc_nolock() proceeds
even with no cmpxchg128, so range_tree_set() and the arena.c
kmalloc_nolock() sites succeed and arena maps can be created today on a
non-ZACAS riscv64 system. After this change those same systems get
-EOPNOTSUPP.

That narrowing is arguably desirable (BPF should not depend on a SLUB
debug-mode escape hatch), but is the changelog accurate about the
current behavior? Should it note the debug-cache exception, or state
explicitly that gating on the CPU feature is deliberately stricter than
kmalloc_nolock()'s minimum requirement?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/33598715943
--===============5269529957093976897==--
