Received: from mta1.migadu.com (out-214.mta1.migadu.com [95.215.58.214])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78968443AB0
	for <stable@vger.kernel.org>; Fri, 28 Aug 2026 11:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.214
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787917159; cv=none; b=GGlb6IaehaNEUXvlhEzb+CD5fG6k1MaSzfoIsBL+n6JrwkYfQWo/F16PNwGbRJf6FdISLN0B+YRkPUP8ml8sd3LNDDBxVX2Xk9yvb+oJBSJhuwlrOUImyyoEzZhM2jObXn8VG0gU9mAfWe6zqUmxsO0n5sUOW4vMkGUe54v++ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787917159; c=relaxed/simple;
	bh=NdjwIHjLMtwULySAl01jbxlCbe76DSmtR6VHa3IT7SQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bd/OAnPiPNbHmqkZTl7ydtBvtvDsNsRm+D8gb6e2I6FH/Wzf/v9laj5qkbw5EkheCnFzid83nVnXyRGfQFBbDpAb45iPkQD6ZGDwtaTxlqEM+FZwqqaL/hkWOhvIM4LlfOiu93skN7QCVQd8entqYjV31FPfjSS+P39gASXcpSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=c50g6GpT; arc=none smtp.client-ip=95.215.58.214
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="c50g6GpT"
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=NdjwIHjLMtwULySAl01jbxlCbe76DSmtR6VHa3IT7SQ=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787917139; v=1; x=1788521939;
 b=c50g6GpTINKgaAAbDKTwuL+c2Jn3CMl5UwUVA3SylvE64I3UuHumDS9hBVrS7eA8qwAyD9SQ
 Eu5tlTDh3oU9VJznxgVEVhSaktmC2uot8AF0/6STwB3HJGXuMvCaNbHIwTJemDRNvpOmO1sXz4+
 Uy5hMvbxNuO4bGUqgLGbysRc=
X-Envelope-To: stable@vger.kernel.org
Received: by mta11.migadu.com with ESMTPS id 83ddab0aff98e2c5;
	Fri, 28 Aug 2026 11:38:59 +0000
X-Mizu-Trace-ID: 83ddab0aff98e2c5
X-Migadu-Flow: FLOW_OUT
Date: Fri, 28 Aug 2026 13:38:53 +0200
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
Message-ID: <apFzTdakRxQMLJ2n@linux.dev>
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

Gentle ping - it's been a few weeks and the build failure is still
present. Is the approach here ok or would you prefer something else?

Thanks,
Thorsten
