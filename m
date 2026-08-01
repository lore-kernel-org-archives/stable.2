Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 806E92F25F3
	for <stable@vger.kernel.org>; Sat,  1 Aug 2026 22:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785622032; cv=none; b=e9uAKTxUjP1puBtHvtBqBosp5kCJ8ZqkbFBPOZn6um60sVWliMWf3ZRVA47RDVHVkPOauZyYQAKg0dPhh2fMDqJSFqJ8J+zRsMVne+JJsYdJdLD18szwb3SEzzWHD5KYl4cOnQHlKvb4YQSVEUscAQT1SbLLIwEqzCZ3OZqPRf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785622032; c=relaxed/simple;
	bh=3KUeC7HRIA2DPBIG28P3L6gX+MHsV906e2Arjceluf4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EIGgtLcaG2KT6xP0PPTXKQlDFOCey66+f3qDzHLgSiEU9csZ7MkEZAVSZfBnblrv8B5rdUVD42ejkHNK3Z5NM7gR1z5yBVJhN9WuGn5h1n96sfSeTHSQHHpvx1exRChTYRAH3CYPG21oTgZCDt9QHvhswc45F7sIdqroSNSA6vE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=aa/OjSsV; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="aa/OjSsV"
Date: Sun, 2 Aug 2026 00:06:50 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1785622018;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=etwQp5nKC/6j0jIPO0+nawBmEUGNysMKUcMCQrhX0c8=;
	b=aa/OjSsVzX8DYWXfUGDkipCHD3V3P/RYtBMfsiXqhvkRsb68+Stmu42Anm5bSVaxxOp698
	yC3fwcYIMdlKmYY0zZgR/oZlerUUTlVM+C1Y4qzxnrY/QJguLZEjUPSuIYcrNLdykkheoW
	uODOIIxcKkCURkvKsdzytGySabgu1Ps=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Thorsten Blum <thorsten.blum@linux.dev>
To: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: Geoff Levand <geoff@infradead.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Justin Stitt <justinstitt@google.com>, Kees Cook <kees@kernel.org>,
	stable@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/ps3: Fix repository.c build failure
Message-ID: <am5t-ixyIp1IwdV5@linux.dev>
References: <20260703165834.137242-2-thorsten.blum@linux.dev>
 <6be33030-781f-4480-8ccd-81c5b1df220a@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6be33030-781f-4480-8ccd-81c5b1df220a@kernel.org>
X-Migadu-Flow: FLOW_OUT

On Fri, Jul 31, 2026 at 09:34:28AM +0200, Christophe Leroy (CS GROUP) wrote:
> Le 03/07/2026 à 18:58, Thorsten Blum a écrit :
> > GCC fails to build ps3_defconfig with the following errors:
> > 
> >    arch/powerpc/platforms/ps3/repository.c: In function ‘make_first_field.constprop’:
> >    arch/powerpc/platforms/ps3/repository.c:78:9: error: ‘strnlen’ specified bound 8 exceeds source size 3 [-Werror=stringop-overread]
> >       78 |         memcpy((char *)&n, text, strnlen(text, sizeof(n)));
> >          |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >    arch/powerpc/platforms/ps3/repository.c: In function ‘make_first_field.constprop’:
> >    arch/powerpc/platforms/ps3/repository.c:78:9: error: ‘strnlen’ specified bound 8 exceeds source size 4 [-Werror=stringop-overread]
> >       78 |         memcpy((char *)&n, text, strnlen(text, sizeof(n)));
> >          |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > 
> > The current use of strnlen(text, sizeof(n)) triggers -Wstringop-overread
> > when text is a short string literal that is smaller than sizeof(n), such
> > as "bi" or "bus". Use strlen(text) instead and clamp the copy length to
> > sizeof(n) before memcpy().
> > 
> > Drop the redundant char * cast while at it.
> > 
> > Fixes: f94a84a09148 ("powerpc/ps3: refactor strncpy usage")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> > ---
> >   arch/powerpc/platforms/ps3/repository.c | 5 ++++-
> >   1 file changed, 4 insertions(+), 1 deletion(-)
> > 
> > diff --git a/arch/powerpc/platforms/ps3/repository.c b/arch/powerpc/platforms/ps3/repository.c
> > index b8c030eab138..0cc755ac3e7f 100644
> > --- a/arch/powerpc/platforms/ps3/repository.c
> > +++ b/arch/powerpc/platforms/ps3/repository.c
> > @@ -6,6 +6,8 @@
> >    *  Copyright 2006 Sony Corp.
> >    */
> > +#include <linux/minmax.h>
> > +
> >   #include <asm/lv1call.h>
> >   #include "platform.h"
> > @@ -74,8 +76,9 @@ static void _dump_node(unsigned int lpar_id, u64 n1, u64 n2, u64 n3, u64 n4,
> >   static u64 make_first_field(const char *text, u64 index)
> >   {
> >   	u64 n = 0;
> > +	size_t len = min(strlen(text), sizeof(n));
> > -	memcpy((char *)&n, text, strnlen(text, sizeof(n)));
> > +	memcpy(&n, text, len);
> >   	return PS3_VENDOR_ID_NONE + (n >> 32) + index;
> >   }
> 
> Maybe change to u32 and remove the n >> 32.
> 
> Shouldn't the same fix be done in make_field() ?

make_field() has two callers where the compiler can't infer the size
of the string at compile time, so it doesn't produce this error.

make_first_field() is called only with constant strings, which lets the
compiler infer that all string lengths are less than 8 bytes.
