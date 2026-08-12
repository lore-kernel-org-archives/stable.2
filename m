Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F27A3191BA;
	Wed, 12 Aug 2026 05:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786513669; cv=none; b=coC6ctXkKlxJKT0ZoGJ03aKReOw9WLIcDdDGZ1m6qwikCO4OkmY0WhSwv4zcrswieqtGG6K6eQMdC4eFrerHAtdDx1BkrRkVj+WWxMX93ob/L+fkoLXeH97+Zk0R5HAQ0NyJ+s8d6ZKUnmAPCbCddnwq11M//A/T2aUElR5l1aE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786513669; c=relaxed/simple;
	bh=iABc9K8brbwAjp+6VtrT+VhIgqUXCpidx3XmFiTLDlY=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=RSKsnS3hU5nUmgG73lI1QRezQikPhWyf0CLi8O3JCoHRFN0kTyfAXl85+FDAgLdaWc2pvO37PvhGrCthjzVjOHpMEN32O5Kt+zILXRfdvPJVnUXhp8e+nKAKAeN/EAo78aUHX/ruzejSaq/azSe2eLdEwMf/GAsq/sQsVyU1T5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=ruEA3kvk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ruEA3kvk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3DEB1F000E9;
	Wed, 12 Aug 2026 05:47:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1786513667;
	bh=IWjDjgp43HDOKAAvhXf6tJ9XRcep7H8R/FphtBkyvCY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=ruEA3kvkxtFK7eWbkAqQPen2AEMf+hlBpUgBhnXOPr9FJ/KiPmgD7eVNKyF39gyr8
	 bK22sipkB+8gno+UM3kQXsWneAHxc/0If9eU5cgeb7WifH7vwo+7A5aL/KR/qVmOg4
	 Bp/vobOrCFOQRgVZhubk/5vbkMdDLmoMGBelxhi8=
Date: Tue, 11 Aug 2026 22:47:46 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Mike Rapoport <rppt@kernel.org>, Nick Desaulniers
 <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, Justin Stitt
 <justinstitt@google.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 llvm@lists.linux.dev, stable@vger.kernel.org, Kees Cook <kees@kernel.org>
Subject: Re: [PATCH] arch_numa: Avoid false positive fortify warning in
 setup_node_to_cpumask_map()
Message-Id: <20260811224746.fdb85bcf47533e12d365b182@linux-foundation.org>
In-Reply-To: <20260811-arch_numa-avoid-fortify-warning-v1-1-59ce3e689f3a@kernel.org>
References: <20260811-arch_numa-avoid-fortify-warning-v1-1-59ce3e689f3a@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 11 Aug 2026 22:22:42 -0700 Nathan Chancellor <nathan@kernel.org> wrote:

> When building ARCH=riscv using clang with CONFIG_FORTIFY_SOURCE and
> CONFIG_UBSAN_BOUNDS enabled, CONFIG_NR_CPUS > 64, and the default value
> of 2 for CONFIG_NODES_SHIFT, there is a compiletime warning from the
> fortify routines.

(cc Kees)

>   In file included from mm/arch_numa.c:11:
>   In file included from include/linux/acpi.h:14:
>   In file included from include/linux/resource_ext.h:11:
>   In file included from include/linux/slab.h:17:
>   In file included from include/linux/gfp.h:7:
>   In file included from include/linux/mmzone.h:8:
>   In file included from include/linux/spinlock.h:60:
>   In file included from include/linux/interrupt_rc.h:17:
>   In file included from include/linux/smp.h:13:
>   In file included from include/linux/cpumask.h:11:
>   In file included from include/linux/bitmap.h:13:
>   In file included from include/linux/string.h:383:
>   include/linux/fortify-string.h:430:4: warning: call to '__write_overflow_field' declared with 'warning' attribute: detected write beyond size of field (1st parameter); maybe use struct_group()? [-Wattribue-warning]
>     430 |                         __write_overflow_field(p_size_field, size);
>         |                         ^
>   include/linux/fortify-string.h:430:4: note: called by function 'fortify_memset_chk(unsigned long, unsigned long, unsigned long)'
>   include/linux/bitmap.h:248:3: note: inlined by function 'setup_node_to_cpumask_map'
>     248 |                 memset(dst, 0, len);
>         |                 ^
>   include/linux/fortify-string.h:462:25: note: expanded from macro 'memset'
>     462 | #define memset(p, c, s) __fortify_memset_chk(p, c, s,                   \
>         |                         ^
>   include/linux/fortify-string.h:453:2: note: expanded from macro '__fortify_memset_chk'
>     453 |         fortify_memset_chk(__fortify_size, p_size, p_size_field),       \
>         |         ^
>   include/linux/fortify-string.h:430:4: note: use '-gline-directives-only' (implied by '-g1') or higher for more accurate inlining chain locations
>     430 |                         __write_overflow_field(p_size_field, size);
>         |                         ^
>   1 warning generated.
> 
> In this configuration, MAX_NUMNODES is 4. clang unrolls the for loop in
> setup_node_to_cpumask_map() past this, which triggers the fortify check
> when accessing node_to_cpumask_map on the theoretical fifth loop
> iteration because it would be an out of bounds write.
> 
> Make it clear to clang that nr_node_ids is bounded by MAX_NUMNODES due
> to the logic in setup_nr_node_ids() by early returning in
> setup_node_to_cpumask_map() should that condition be violated.
> 
> Cc: stable@vger.kernel.org # all applicable
> Closes: https://github.com/ClangBuiltLinux/linux/issues/2174
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> ---
> This is based on mm-unstable due to the move of arch_numa.c from mm/ to
> drivers/base/ living there. I have CC'd stable because this warning
> appears in my testing back to at least 6.1 but I see no reason why it
> should not apply to all trees. No fixes tag since this is a layered
> problem that just happens to appear under certain conditions.
> 
> Another alternative would be using the __assume macro to say something
> like
> 
>   __assume(nr_node_ids <= MAX_NUMNODES);
> 
> but that seems a little more fragile.
> ---
>  mm/arch_numa.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/mm/arch_numa.c b/mm/arch_numa.c
> index 442ea239bba7..bd7772b05bcf 100644
> --- a/mm/arch_numa.c
> +++ b/mm/arch_numa.c
> @@ -105,6 +105,18 @@ static void __init setup_node_to_cpumask_map(void)
>  	if (nr_node_ids == MAX_NUMNODES)
>  		setup_nr_node_ids();
>  
> +	/*
> +	 * This check should never be true but it makes it clear to compilers
> +	 * that node_to_cpumask_map is bound by nr_node_ids, avoiding false
> +	 * positive fortify warnings when accessing node_to_cpumask_map in the
> +	 * for loop below.
> +	 */
> +	if (unlikely(nr_node_ids > MAX_NUMNODES)) {
> +		pr_err("nr_node_ids (%u) is larger than MAX_NUMNODES (%d)",

Sashiko wants a \n there.

> +		       nr_node_ids, MAX_NUMNODES);

Lord only knows why nr_node_ids is unsigned but MAX_NUMNODES is signed.

lgtm otherwise.

> +		return;
> +	}
> +

