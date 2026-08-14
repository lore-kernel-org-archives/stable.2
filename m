Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37AF8339872;
	Fri, 14 Aug 2026 21:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786742425; cv=none; b=SdieF/cwvGbWzP+UYG1YHso1BZM5nvU+j7rMiCBeMaJJb4sliSb8gm08tvFLOuhjiMTo7NZcD/m5FfH6Vswrxd87VKGvGi8dCOYZL0KOtEiD9L4rjbYDOD3xshz9coO07UY8DVh5NRsvpd8eIqGJZLski1VfEaYBEA52peo44/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786742425; c=relaxed/simple;
	bh=5RSqLjRx4HyqqV8crTr1jXkIMp7xf39zVE5ruVKcLc8=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=ZmUpQQ2zpuzjIBcNKP/KEn9M+ATuYz9MZuyGhfUEtxJTENuxnRxSZJ0ZnozkE9pl0PmIwDp596sEUX8kn07HgrX+EdTZLCbCU2Bo3zN7mf3un1/wVteuVAmjWeHx+OgxlqRkPBG1Ewtz7/sRzs5GvAx6D4B8uCPEDWzEspIFwI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jYpGxKRM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jYpGxKRM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DB431F000E9;
	Fri, 14 Aug 2026 21:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786742424;
	bh=K9808pCTS0lU1x+gV6QC/9Hva49VgRKffIZnTWJGqfg=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=jYpGxKRMGIK+OaiFMKJk493CKEWveL5uXMOEyI0QIu089fSDV4AO022kBvWSYWjtb
	 O+vA9wsQj0enRxoQc+T3s2aLlm8Yb2Ta00QQRZVakUnisWWFm3iam6r5XQf+jlJ6cm
	 Bu57XqLuD0HJDSBo5LFmbdkCJg62nr7v2EO7U3XbI0gNDhws1RgKvcdw/71KseQmBM
	 A7R8WujCHTNBcD2aYz5uPVoXw7BgW8DAMTPi8GiNSGlSareo4iObEA0kb2ueFNT2CR
	 fnyeB3Sf3TeIa4gSB9IH2qJZtTzDqrUveWNPltTY9Fef0bmon1Hn/Kq34GqW5gVyRW
	 EWIkl04L94YWQ==
Content-Type: multipart/mixed; boundary="===============3605277855702563190=="
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <7276efcb565f80eed9a05dd364570b432a68ba5d980d9d1676bf620501f10040@mail.kernel.org>
In-Reply-To: <20260814203248.3714536-3-vineet.gupta@linux.dev>
References: <20260814203248.3714536-3-vineet.gupta@linux.dev>
Subject: Re: [PATCH bpf v2 2/2] selftests/bpf: Check per-CPU address resolution per register
From: bot+bpf-ci@kernel.org
To: vineet.gupta@linux.dev,bpf@vger.kernel.org
Cc: ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,x86@kernel.org,stable@vger.kernel.org,vineet.gupta@linux.dev,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Fri, 14 Aug 2026 21:20:23 +0000 (UTC)

--===============3605277855702563190==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/progs/verifier_percpu_addr.c b/tools/testing/selftests/bpf/progs/verifier_percpu_addr.c
> new file mode 100644
> index 000000000000..962faea8ef90
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/verifier_percpu_addr.c
> @@ -0,0 +1,114 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <vmlinux.h>
> +#include <bpf/bpf_helpers.h>
> +#include "bpf_misc.h"
> +
> +int percpu_data SEC(".percpu");
> +
> +#if defined(__TARGET_ARCH_x86)
> +
> +/*
> + * An ld_imm64 of a per-CPU map value is followed by a mov_percpu_addr that
> + * reuses the same register, so the register the address lands in decides how
> + * the JIT encodes the add. On x86 R5, R7, R8 and R9 are the extended
> + * registers, whose high bit needs REX.R because the destination sits in
> + * ModRM.reg. Check one program per extended register, since getting the
> + * prefix wrong resolves the address into whichever register shares the low
> + * three bits instead.
> + */
> +
> +SEC("raw_tp")
> +__description("per-CPU address into r5")
> +__success
> +__arch_x86_64
> +__jited("	addq	%gs:{{.*}}, %r8")
> +__naked void percpu_addr_into_r5(void)
> +{
> +	asm volatile ("					\
> +	r5 = %[percpu_data] ll;				\
> +	r0 = *(u32 *)(r5 + 0);				\
> +	exit;						\
> +"	:
> +	: __imm_addr(percpu_data)
> +	: __clobber_all);
> +}

This isn't a bug, but would it be tidier to move the percpu_data
declaration inside the __TARGET_ARCH_x86 block?

Currently percpu_data is declared above the arch guard, but its only
readers (percpu_addr_into_r1/r5/r7/r8/r9) are inside the guard:

+int percpu_data SEC(".percpu");
+
+#if defined(__TARGET_ARCH_x86)
+
+/* ... test functions using percpu_data ... */

On every other target the object still carries a .percpu section, so
libbpf still creates an unused percpu data map for it.

Comparable files in the same directory keep objects used only by guarded
programs inside the guard. verifier_private_stack.c declares its 'struct
elem' and 'array SEC(".maps")' after the '#if defined(__TARGET_ARCH_x86)
|| defined(__TARGET_ARCH_arm64)' guard, and verifier_ldsx.c declares its
'arena SEC(".maps")' map inside its arch guard.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/31839526403
--===============3605277855702563190==--
