Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B3873A1D05;
	Fri, 31 Jul 2026 07:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785483277; cv=none; b=Uq1B0wVVenx9OzrdRKZ7jt3EFWsXcCkTckPzj4USfOekegxCgzzJQAi5L/Nait9BoH7FTxQALEdIrAiwjDbiMrp1rjyBIFOR3juZzmUt4JxGci+L2dUZuZefp1TZ4+Vp34ImOmdOTJEEh8SIEFw/R3OYS3nOL7su/hw31uxvMlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785483277; c=relaxed/simple;
	bh=bawBBQ8+MtR07NIQB/FE0piEWTNOQdSZFRtArUsM5q4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GixbaomeCV0unYACYrjbz12tzIn1JBcJFV8CdqqTKVg1lt3bBEdBGaFSwWEQXLy9eW9wvHTrzSij/43H9d/om2Z21S8qUnC3WG+NZmFigie3oy1XuXj4ccDEcsmxC2TKHu5t6AE4XUt2bFUHvwbHP1gCOfQJeVE0di1bffiwQ+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B+DQMeRU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B+DQMeRU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F2AB1F000E9;
	Fri, 31 Jul 2026 07:34:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785483273;
	bh=MyKJJuUwMNNDK+7BAt01g+E4SJ/puql/PuU35u2uXCY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=B+DQMeRUqP9H9atv572awP1Rm0bkPUF3mUi/0apsBW9ZHU7bx+A0GClo6oq0fGSkF
	 A9pHXDN5YEK1X4njOl6KXzoudgDFph+x+ilOh0svRbyOi+ASDFOafmaxlpzYZMLy7t
	 wDMyXBeGvA/8BqS+togmCrNbkbS8okuMaWVfsOvOPOO0NB9v/9Ycx9XI3F4/CAIYli
	 hUmwdcQ2YaH0fZP3EH4qVSNzwN9sSSLgjN+lHt7NOqoUuWb6RF67i2Lh8CDfRfFQVT
	 pxF7RVMYEwosXVsLs4VEeM3ybLzewcYYziOI2YbwYDZy1LxoLDp7ME7/6EqEVZ/JL0
	 dVjkh9NzvbDZA==
Message-ID: <6be33030-781f-4480-8ccd-81c5b1df220a@kernel.org>
Date: Fri, 31 Jul 2026 09:34:28 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] powerpc/ps3: Fix repository.c build failure
To: Thorsten Blum <thorsten.blum@linux.dev>,
 Geoff Levand <geoff@infradead.org>, Madhavan Srinivasan
 <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Nicholas Piggin <npiggin@gmail.com>, Justin Stitt <justinstitt@google.com>,
 Kees Cook <kees@kernel.org>
Cc: stable@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
References: <20260703165834.137242-2-thorsten.blum@linux.dev>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <20260703165834.137242-2-thorsten.blum@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 03/07/2026 à 18:58, Thorsten Blum a écrit :
> GCC fails to build ps3_defconfig with the following errors:
> 
>    arch/powerpc/platforms/ps3/repository.c: In function ‘make_first_field.constprop’:
>    arch/powerpc/platforms/ps3/repository.c:78:9: error: ‘strnlen’ specified bound 8 exceeds source size 3 [-Werror=stringop-overread]
>       78 |         memcpy((char *)&n, text, strnlen(text, sizeof(n)));
>          |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    arch/powerpc/platforms/ps3/repository.c: In function ‘make_first_field.constprop’:
>    arch/powerpc/platforms/ps3/repository.c:78:9: error: ‘strnlen’ specified bound 8 exceeds source size 4 [-Werror=stringop-overread]
>       78 |         memcpy((char *)&n, text, strnlen(text, sizeof(n)));
>          |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
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
>   arch/powerpc/platforms/ps3/repository.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/platforms/ps3/repository.c b/arch/powerpc/platforms/ps3/repository.c
> index b8c030eab138..0cc755ac3e7f 100644
> --- a/arch/powerpc/platforms/ps3/repository.c
> +++ b/arch/powerpc/platforms/ps3/repository.c
> @@ -6,6 +6,8 @@
>    *  Copyright 2006 Sony Corp.
>    */
>   
> +#include <linux/minmax.h>
> +
>   #include <asm/lv1call.h>
>   
>   #include "platform.h"
> @@ -74,8 +76,9 @@ static void _dump_node(unsigned int lpar_id, u64 n1, u64 n2, u64 n3, u64 n4,
>   static u64 make_first_field(const char *text, u64 index)
>   {
>   	u64 n = 0;
> +	size_t len = min(strlen(text), sizeof(n));
>   
> -	memcpy((char *)&n, text, strnlen(text, sizeof(n)));
> +	memcpy(&n, text, len);
>   	return PS3_VENDOR_ID_NONE + (n >> 32) + index;
>   }
>   

Maybe change to u32 and remove the n >> 32.

Shouldn't the same fix be done in make_field() ?

Christophe
