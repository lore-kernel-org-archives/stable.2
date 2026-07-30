Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B88E43A6B7F
	for <stable@vger.kernel.org>; Thu, 30 Jul 2026 14:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785421702; cv=none; b=JI5aZbvokI72FBuVU7i2VwU2gFruFXfCKUpkBoV6WJh3DqQHlFY48DTOTzXnFC8DNsozl9Opy5GI/+cfRSvTUVYQFRQN41ecHR/9RGUUmC+iCDIlXWTvk8kuF//xC2VUVXgN5EqLekoz5uxxtoU4mv7JdwIblDBt9wL7O8iakfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785421702; c=relaxed/simple;
	bh=/2iryfKyAXW9UhQVAX4SWwtkAZXQw4EBE5mtGF1ig1k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ck+7fVPdTNaNRxN/Llo8ef1WnaXs8iNy7XBwBFajy1jZc2nP4qo7G+AuoV3LknRhMOjnMfsFoFm/2zaxUY9PsLa9qls5ra0hV6DtUX1mznFFx3BiQIIAqZEG0XiOwYtxByCxw/77b0IDfYy5UhColaWq5ocUxpNakFqRLQ3msnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=aBc6kdGc; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="aBc6kdGc"
Date: Thu, 30 Jul 2026 16:28:08 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1785421697;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=T3ac2CFXlJ8wxc4DqXVNNL1F/4/fTPWOM+4N0hlAhII=;
	b=aBc6kdGcrvmf1QuzIJqjJzWr6cBQtAVoQZwfblt82hs7QBtFv9g1ht5WiphIz5IiiJs+Ng
	fxcG8bNO70eRzMDjTk5DFFwB6yJmRF+dO32tFajrUulkJNltWqtigsYRI0NLcMJC1bBVF8
	x0ttg5NeKVL444ftwoAark8BL1FwFuw=
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
Message-ID: <amtfeLGWTUNN8vc1@linux.dev>
References: <20260703165834.137242-2-thorsten.blum@linux.dev>
 <amowzufwQrIqHVZX@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <amowzufwQrIqHVZX@linux.dev>
X-Migadu-Flow: FLOW_OUT

On Wed, Jul 29, 2026 at 06:56:59PM +0200, Thorsten Blum wrote:
> On Fri, Jul 03, 2026 at 06:58:35PM +0200, Thorsten Blum wrote:
> > GCC fails to build ps3_defconfig with the following errors:
> > 
> >   arch/powerpc/platforms/ps3/repository.c: In function ‘make_first_field.constprop’:
> >   arch/powerpc/platforms/ps3/repository.c:78:9: error: ‘strnlen’ specified bound 8 exceeds source size 3 [-Werror=stringop-overread]
> >      78 |         memcpy((char *)&n, text, strnlen(text, sizeof(n)));
> >         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >   arch/powerpc/platforms/ps3/repository.c: In function ‘make_first_field.constprop’:
> >   arch/powerpc/platforms/ps3/repository.c:78:9: error: ‘strnlen’ specified bound 8 exceeds source size 4 [-Werror=stringop-overread]
> >      78 |         memcpy((char *)&n, text, strnlen(text, sizeof(n)));
> >         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
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
> >  arch/powerpc/platforms/ps3/repository.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> > 
> > diff --git a/arch/powerpc/platforms/ps3/repository.c b/arch/powerpc/platforms/ps3/repository.c
> > index b8c030eab138..0cc755ac3e7f 100644
> > --- a/arch/powerpc/platforms/ps3/repository.c
> > +++ b/arch/powerpc/platforms/ps3/repository.c
> > @@ -6,6 +6,8 @@
> >   *  Copyright 2006 Sony Corp.
> >   */
> >  
> > +#include <linux/minmax.h>
> > +
> >  #include <asm/lv1call.h>
> >  
> >  #include "platform.h"
> > @@ -74,8 +76,9 @@ static void _dump_node(unsigned int lpar_id, u64 n1, u64 n2, u64 n3, u64 n4,
> >  static u64 make_first_field(const char *text, u64 index)
> >  {
> >  	u64 n = 0;
> > +	size_t len = min(strlen(text), sizeof(n));
> >  
> > -	memcpy((char *)&n, text, strnlen(text, sizeof(n)));
> > +	memcpy(&n, text, len);
> >  	return PS3_VENDOR_ID_NONE + (n >> 32) + index;
> >  }
> >  
> 
> Gentle ping.
> 
> Thanks,
> Thorsten

Interestingly, GCC 14.2.0 and Clang 22.1.8 don't report an error,
whereas GCC 16.1.1 does.
