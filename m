Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B216F3DA5B8
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 16:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785344236; cv=none; b=uDzY4kMh6i1jV8YJO4LzUutPsyTnVk2Q1q0hQ3nTcDsu6xivjUIKiUoY7/EvqRJWM52aQWETjJCqndZLrt022I6U7pFwb7iBfGhVuZ9WOnrXublrkS36pNxSyT0vlM+/LRzufnf0lClAOb83ubs8IrddBi1Po0fW3fL8XAarpa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785344236; c=relaxed/simple;
	bh=2a1XfvrP4d6h6/3j3LTrWukI4gSAHnD9xrEND1QwSuo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MotkpJsVXwZ9KwPBEb0Jv4EoMu5JGFb+fT9VYGkaeSfIp6W6I/4129WLQ5XBsrbYQRCOoG7zYttj/SpbvHIIKTh3D1BxoXlxYl8x3lN15/0C1D3dhEseqV6MVnZlcL4vSfii6J1n/B/EatSt5/Yccg3uoyWIURSg4AOTVdv5Bfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=GqHOI/mr; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="GqHOI/mr"
Date: Wed, 29 Jul 2026 18:56:46 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1785344219;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LDU7beg0fnhcr8nf3vku/Ay0bOzx6vJc/E1w7QNenGU=;
	b=GqHOI/mrjEDF0/9FnhvLr7V1OE8QeXzb5u7qQvzUVDf6ocCWc1qa/MJ0u/ctAHS7u3MJ5+
	qz1PomNpBKyG8cRJQfeyPp1aVeStzqzZilBdz/u6waOrGyR79rA3/abMmY6gaRPG+vlRG5
	5/Jf4ZEUJekaU5tJ0f/NcQ3dV9gvYRg=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Geoff Levand <geoff@infradead.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Justin Stitt <justinstitt@google.com>, Kees Cook <kees@kernel.org>
Cc: stable@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/ps3: Fix repository.c build failure
Message-ID: <amowzufwQrIqHVZX@linux.dev>
References: <20260703165834.137242-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260703165834.137242-2-thorsten.blum@linux.dev>
X-Migadu-Flow: FLOW_OUT

On Fri, Jul 03, 2026 at 06:58:35PM +0200, Thorsten Blum wrote:
> GCC fails to build ps3_defconfig with the following errors:
> 
>   arch/powerpc/platforms/ps3/repository.c: In function ‘make_first_field.constprop’:
>   arch/powerpc/platforms/ps3/repository.c:78:9: error: ‘strnlen’ specified bound 8 exceeds source size 3 [-Werror=stringop-overread]
>      78 |         memcpy((char *)&n, text, strnlen(text, sizeof(n)));
>         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   arch/powerpc/platforms/ps3/repository.c: In function ‘make_first_field.constprop’:
>   arch/powerpc/platforms/ps3/repository.c:78:9: error: ‘strnlen’ specified bound 8 exceeds source size 4 [-Werror=stringop-overread]
>      78 |         memcpy((char *)&n, text, strnlen(text, sizeof(n)));
>         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> The current use of strnlen(text, sizeof(n)) triggers -Wstringop-overread
> when text is a short string literal that is smaller than sizeof(n), such
> as "bi" or "bus". Use strlen(text) instead and clamp the copy length to
> sizeof(n) before memcpy().
> 
> Drop the redundant char * cast while at it.
> 
> Fixes: f94a84a09148 ("powerpc/ps3: refactor strncpy usage")
> Cc: stable@vger.kernel.org
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
>  arch/powerpc/platforms/ps3/repository.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/platforms/ps3/repository.c b/arch/powerpc/platforms/ps3/repository.c
> index b8c030eab138..0cc755ac3e7f 100644
> --- a/arch/powerpc/platforms/ps3/repository.c
> +++ b/arch/powerpc/platforms/ps3/repository.c
> @@ -6,6 +6,8 @@
>   *  Copyright 2006 Sony Corp.
>   */
>  
> +#include <linux/minmax.h>
> +
>  #include <asm/lv1call.h>
>  
>  #include "platform.h"
> @@ -74,8 +76,9 @@ static void _dump_node(unsigned int lpar_id, u64 n1, u64 n2, u64 n3, u64 n4,
>  static u64 make_first_field(const char *text, u64 index)
>  {
>  	u64 n = 0;
> +	size_t len = min(strlen(text), sizeof(n));
>  
> -	memcpy((char *)&n, text, strnlen(text, sizeof(n)));
> +	memcpy(&n, text, len);
>  	return PS3_VENDOR_ID_NONE + (n >> 32) + index;
>  }
>  

Gentle ping.

Thanks,
Thorsten
