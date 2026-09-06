Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9618F3D8123;
	Sun,  6 Sep 2026 14:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788704442; cv=none; b=ZF6kcYSCPs9yFUYNDJ4bTAuy1v17qgVRgczz4g1xxDU00WdFII4Iad1VcfP+SoGPLFGoik6FMXq5h9bmE5L+tS9ZcULCbAHFi6SHgh3xcgijZ0DhgSugcO6/W3c7/KoDHCBv1FPZflx+s4wpVLCvu7/K4YdKRBelRYjkf3ZvZ6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788704442; c=relaxed/simple;
	bh=mToAqu1R5KV2mlZG8ZGCAaj4KiJKJ1hAzowthm++9YE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=X0JcpGUpZUKoy4YaSNcAEYRL6h/q2ui3Z0r5kvEwxx2U8KlC2y3Iy8hTHEnQKs56sSUj3ZvHfzxeH2xDIiTy3F5/hic9I7PzGcM4D539cjP/8gdeUq9OCGwBGN7r+cVbHmCpjC+SprKv+BEMzhIw7Y/t0Rn4duVHMvArwGoC2BU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ELb99cvo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ELb99cvo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B48D81F00A3A;
	Sun,  6 Sep 2026 14:20:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788704441;
	bh=0F1azxiMxjgKsUcEaIZbzvHWVTHkjTn5dRyqXspuLL0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=ELb99cvo0evuCmxptKEsJk8cWtGxtnh626IQnH09g+HlTzMSC+eiqvhOZeoob0zrv
	 EEL1tb7YbHjAocfoMPO0VntXZgkhKB74RRYfgPvnJX9wxTheLHQvfHW5YKA3b5THLP
	 JJvGu6JuYhnSeWailjn9o6R4YY7gQMwVw/2Zm/qJ0SD+nKzvmjgaPBwM8zsciizzs7
	 3VS0I9oVevjratMqLqhCeJanBEHEmLVOr3HiajOaR84DZDZsPJ2n4J6SJNdWfRDNeS
	 ef7fXtqnUzJHpZCo1mdU8fB4uka+eQCYc1Y3MDNlzdfARNZfr8YfGxgvk5j5pB4OdN
	 KtTrLZKoSjs7Q==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Chen Pei <cp0613@linux.alibaba.com>, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, memxor@gmail.com,
 puranjay@kernel.org
Cc: ihor.solodrai@linux.dev, eddyz87@gmail.com, martin.lau@linux.dev,
 song@kernel.org, yonghong.song@linux.dev, jolsa@kernel.org,
 emil@etsalapatis.com, pulehui@huawei.com, pjw@kernel.org,
 palmer@dabbelt.com, guoren@kernel.org, bpf@vger.kernel.org,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH bpf v2] bpf, riscv: Make arena support depend on ZACAS
In-Reply-To: <20260902061451.1416-1-cp0613@linux.alibaba.com>
References: <20260902061451.1416-1-cp0613@linux.alibaba.com>
Date: Sun, 06 Sep 2026 16:20:37 +0200
Message-ID: <874ig2pikq.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Chen Pei <cp0613@linux.alibaba.com> writes:

> The arena range tree allocates its nodes with kmalloc_nolock() since
> commit f8c67d8550ee ("bpf: Use kmalloc_nolock() in range tree").
> kmalloc_nolock() requires slab caches with cmpxchg128 support
> (__CMPXCHG_DOUBLE); on riscv cmpxchg128 is provided by the ZACAS
> extension. On systems without ZACAS every arena map creation fails
> with a misleading -ENOMEM.
>
> Report the missing support instead: make bpf_jit_supports_arena()
> return system_has_cmpxchg128() where it is defined, so arena map
> creation fails with -EOPNOTSUPP on systems without ZACAS. The macro
> is only defined when both CONFIG_RISCV_ISA_ZACAS and
> CONFIG_TOOLCHAIN_HAS_ZACAS are enabled, so guard it with #ifdef the
> same way mm/slab.h consumes it, and reject arena otherwise. This
> matches how arena BPF_CMPXCHG instructions are already gated on ZACAS
> in bpf_jit_supports_insn().
>
> Fixes: f8c67d8550ee ("bpf: Use kmalloc_nolock() in range tree")
> Cc: stable@vger.kernel.org
> Signed-off-by: Chen Pei <cp0613@linux.alibaba.com>
> ---
> Changes since v1:
> - Guard system_has_cmpxchg128() with #ifdef instead of calling it
>   unconditionally: the macro is only defined when both
>   CONFIG_RISCV_ISA_ZACAS and CONFIG_TOOLCHAIN_HAS_ZACAS are enabled
>   (as reported by sashiko-bot), so v1 broke the build when either
>   was disabled. This mirrors how mm/slab.h consumes the macro.
>
> Why #ifdef rather than rv_ext_enabled(ZACAS)? The predicates differ
> exactly in the configurations that matter:
>
>   scenario (ISA_ZACAS/TOOLCHAIN/hw)  v1           rv_ext_enabled  #ifdef
>   ISA=3Dn or TOOLCHAIN=3Dn               build fails  rejects         rej=
ects
>   ISA=3Dy TOOLCHAIN=3Dn hw has ZACAS     build fails  accepts, then   rej=
ects
>                                                   -ENOMEM again
>   ISA=3Dy TOOLCHAIN=3Dy hw has ZACAS     exact        exact           exa=
ct

Thanks for clarifying this; Yeah, ZACAS requires runtime *and* toolchain
support.

Acked-by: Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org>

