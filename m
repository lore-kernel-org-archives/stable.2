Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FBF243744D
	for <stable@vger.kernel.org>; Thu, 23 Jul 2026 10:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784802022; cv=none; b=Ni1lpdiScECPHaxshw1sF6Nvz44Ba1/ojxKCXBj4J618qamWcH8xoGUCKbwwsvD+1z3222BBu6sF26LIANPx+f0lVg1GZcsxmkdhAAe4xffpx9WtuhurqgV6hXjebw01s2AeXAGicxQeaiQAuSwHrW+yIY0b9KiJRy1r61y6CJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784802022; c=relaxed/simple;
	bh=nC/xlCpeSyBq95ue4rxNQinTld5hqqGNXahdHDg5W6k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nAaNjWHUfDXwPHxV0xAEqS7M4MHW2X+iL2BmnlDG9nwkhOEvlHuQsyqxQio0u9tY0HtLK3QTDL2GgVUkDGDmWsCtelRdD5UOZK0gd6LzoFDPoLGTQFKnr6ZVeT88UbWDL7ezKUXkryas8VacyqNWhC6/0vRM8IHcn4rnLyzMico=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 651DA1F00A3A;
	Thu, 23 Jul 2026 10:20:19 +0000 (UTC)
Date: Thu, 23 Jul 2026 12:19:57 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Shung-Hsi Yu <shung-hsi.yu@suse.com>
Cc: stable@vger.kernel.org, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Jann Horn <jannh@google.com>, John Hubbard <jhubbard@nvidia.com>,
	Liam Howlett <liam.howlett@oracle.com>,
	Sidhartha Kumar <sidhartha.kumar@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Dan Williams <dan.j.williams@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH stable 6.12 6.6 1/2] tools/testing: add linux/args.h
 header and fix radix, VMA tests
Message-ID: <2026072347-ebony-creme-8c85@gregkh>
References: <20260723071334.39630-1-shung-hsi.yu@suse.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260723071334.39630-1-shung-hsi.yu@suse.com>

On Thu, Jul 23, 2026 at 03:13:31PM +0800, Shung-Hsi Yu wrote:
> From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> 
> commit 9a6a6a3191574a01dcf7a7d9385246d7bc8736bc upstream.
> 
> Commit 857d18f23ab1 ("cleanup: Introduce ACQUIRE() and ACQUIRE_ERR() for
> conditional locks") accidentally broke the radix tree, VMA userland tests
> by including linux/args.h which is not present in the tools/include
> directory.
> 
> This patch copies this over and adds an #ifdef block to avoid duplicate
> __CONCAT declaration in conflict with system headers when we ultimately
> include this.
> 
> Link: https://lkml.kernel.org/r/20250811052654.33286-1-lorenzo.stoakes@oracle.com
> Fixes: 857d18f23ab1 ("cleanup: Introduce ACQUIRE() and ACQUIRE_ERR() for conditional locks")
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Cc: Jann Horn <jannh@google.com>
> Cc: John Hubbard <jhubbard@nvidia.com>
> Cc: Liam Howlett <liam.howlett@oracle.com>
> Cc: Sidhartha Kumar <sidhartha.kumar@oracle.com>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> Stable-dep-of: 63c49efc987a ("selftests/bpf: Add simple strscpy() implementation")
> Signed-off-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
> ---
>  tools/include/linux/args.h       | 28 ++++++++++++++++++++++++++++
>  tools/testing/shared/linux/idr.h |  4 ++++
>  2 files changed, 32 insertions(+)
>  create mode 100644 tools/include/linux/args.h
> 
> diff --git a/tools/include/linux/args.h b/tools/include/linux/args.h
> new file mode 100644
> index 000000000000..2e8e65d975c7
> --- /dev/null
> +++ b/tools/include/linux/args.h
> @@ -0,0 +1,28 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +#ifndef _LINUX_ARGS_H
> +#define _LINUX_ARGS_H
> +
> +/*
> + * How do these macros work?
> + *
> + * In __COUNT_ARGS() _0 to _12 are just placeholders from the start
> + * in order to make sure _n is positioned over the correct number
> + * from 12 to 0 (depending on X, which is a variadic argument list).
> + * They serve no purpose other than occupying a position. Since each
> + * macro parameter must have a distinct identifier, those identifiers
> + * are as good as any.
> + *
> + * In COUNT_ARGS() we use actual integers, so __COUNT_ARGS() returns
> + * that as _n.
> + */
> +
> +/* This counts to 15. Any more, it will return 16th argument. */
> +#define __COUNT_ARGS(_0, _1, _2, _3, _4, _5, _6, _7, _8, _9, _10, _11, _12, _13, _14, _15, _n, X...) _n
> +#define COUNT_ARGS(X...) __COUNT_ARGS(, ##X, 15, 14, 13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1, 0)
> +
> +/* Concatenate two parameters, but allow them to be expanded beforehand. */
> +#define __CONCAT(a, b) a ## b
> +#define CONCATENATE(a, b) __CONCAT(a, b)
> +
> +#endif	/* _LINUX_ARGS_H */
> diff --git a/tools/testing/shared/linux/idr.h b/tools/testing/shared/linux/idr.h
> index 4e342f2e37cf..676c5564e33f 100644
> --- a/tools/testing/shared/linux/idr.h
> +++ b/tools/testing/shared/linux/idr.h
> @@ -1 +1,5 @@
> +/* Avoid duplicate definitions due to system headers. */
> +#ifdef __CONCAT
> +#undef __CONCAT
> +#endif
>  #include "../../../../include/linux/idr.h"
> -- 
> 2.55.0
> 
> 

Does not apply to 6.6.y at all :(

