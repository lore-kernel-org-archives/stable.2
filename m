Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF0C9427F85
	for <stable@vger.kernel.org>; Wed, 26 Aug 2026 13:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787751411; cv=none; b=bq1ymzwEOBAClemCQDKDBeK1rM2I9kWBwUWbHXehhqce0TURGo+E+9FJW24pAQGcejXtpUPtyTjfkwjNm1M/oYTa9KyF8Xsy1V6sI5MnUw9JWrRsQsSznoxzAPqOpV2kZxANUHQ00Zt2xDthynF8KRz10WCuUcrAPGT5ktNYJSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787751411; c=relaxed/simple;
	bh=jqpOnMHgbbqDbuHS/I7m/d6Hc9Shph1tNa+wCHuPmCM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sXwF1h93q7a+Hgjh6W+T6H9khp8s+wq1e5JzI/1W6tglx05f6FLBHzbAB+GVhITjSnI3IXYl3FvHY4ZDywJkABLumFCYBmDnEI/U/w5Tm3CMf5bJtSHi/LV3bZqmYWQGflkBptbpmraFW8XP+zQrH5ryZLPwR+Hss5vroDM9h8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T0X27YGa; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T0X27YGa"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-493b966dd74so4478285e9.3
        for <stable@vger.kernel.org>; Wed, 26 Aug 2026 06:36:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787751408; x=1788356208; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=iac2l5x1G2euKklhoCcR1PZsgghWHKyc8OBHeXTFnfU=;
        b=T0X27YGax8RU3tu9hj0Mc1HCf2lCtyvyZ9eZ6xCMpXPRYo3Ju6EgoaJaLpopJ5ACc/
         sPCKvvBg9mxYdwODcSWe6+uUFSg6XLjZe7xSK9SCcDsszdC9GPFHvAPXeh4bFmhnyBmr
         QhTzoU4GMOPwgO+ocXG+oUBhrVs+KmUMQ0kSJB7JculCooPGHYIGTq/hDHgUq8r10VwB
         id9ep8zzvGpkWMfYKI5cF16ASCZCijRGYDoSsJTFWOcqn6hHd1mfXAkpFPdfEE+OliG5
         cwP+LK03V/glWmkAPZJ1aVLMN/hFvfk5GZ1wK2VZCmioyR3lgic2NwOnSIF0XayOqK8c
         EfAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787751408; x=1788356208;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iac2l5x1G2euKklhoCcR1PZsgghWHKyc8OBHeXTFnfU=;
        b=CbRHvx4DiryrDwuyLh+Mu56YE+okPIFuugCFELzMtr/gdWqGui/iEQiCaRTwr138KP
         6XsmzzLgmfNQ7eqGbqP5C0yEGmHTera96WymUxSWTFtfckubeZjy4hL5ATby9FWTFQP1
         rPlkhbpNxjRMpZEucWYQFoF+/kOSUWNmK2935w18jFjUOZ99PHix68P2FwzAbxfZwt4Z
         iA5jjd0ueKlJqMVz/lwwVcZgMvae7sXmMFh7uytPKiu4pn+KvluxnHX2nu71vCuluMG3
         LbM11gsmx5HjgwVYawv6DdLDbOnlUokN3+GvZd+ydXQZ7JRM3N+V4CF07qUoNeexELV3
         Bepw==
X-Forwarded-Encrypted: i=1; AHgh+Rp1O2dVG0Kd+E8qvGTLzr1r1H0q8LiKd8b2DGrtFQ6Vb8xtKs2zvNvjK2kzhddp4ApcdQbYIUw=@vger.kernel.org
X-Gm-Message-State: AFuF++kqHm+tJ7DyCC8QV04qk3vK8RnnmaqvvGKrp792zkBQX/oSqXP+
	dMbVs/MWA+LtqYmIERddKqVjnv8roz2sPLb9OkiRW0ADMKy6fYiNh15r
X-Gm-Gg: AR+sD139dVFj/NaniGTXWmOoWVRijqK4TUT/qgawI3RrFUoQocKI4jDi3Ozqle8QRbf
	XTQdO6VAVhDgVvhKEWmuJLT8O0fLDAewYVRz12hm9fTKK9kgM3a7jo9IZrdPwRxK40WWNgtXCgD
	sLEOahNR7EXWiSsm40lKbmobY+cs5YZrqtEdtK3zLEHf10kKGG3Q/UA+ctlhPNi3cXhM3nN9fZX
	Eqwp+beckiaDmulUeP9kjLgDrNGIRLa2E5E1iH8fvhUHAqsoaDSQyFir9X9L3MEHue3g98C3H37
	h+Ur/oJql+XXGLc/sjZCLDSV8lI76qxZyhFj+ImVqxXgT59Yb86vP3F8wDXoOeyDmLi13s+Y+0c
	JBKV4xb7/Rs3Awf3cZcG8UfuL5Ji7UvEbBkPMIiLDkOfQS83ZkCo/yHTK0c/Q1kuR4F5P6Gtla9
	ERGoCAWSMO60kW/6ap/FvFoghW1HLTn34mXff4xcRN8SdpCQLfzKlAiiIHEtQdenwqqtpU7y6Mb
	LihmffpJOJMieWkNU1o3KsE7g==
X-Received: by 2002:a05:600c:a0d:b0:499:bdf1:7578 with SMTP id 5b1f17b1804b1-499dc6e9b00mr69476415e9.3.1787751407615;
        Wed, 26 Aug 2026 06:36:47 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499dcad0cbasm26303825e9.10.2026.08.26.06.36.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2026 06:36:47 -0700 (PDT)
Date: Wed, 26 Aug 2026 14:36:44 +0100
From: David Laight <david.laight.linux@gmail.com>
To: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Cc: Zi Yan <ziy@nvidia.com>, Harry Yoo <harry@kernel.org>, Andrew Morton
 <akpm@linux-foundation.org>, Hao Li <hao.li@linux.dev>, Christoph Lameter
 <cl@gentwo.org>, David Rientjes <rientjes@google.com>, Roman Gushchin
 <roman.gushchin@linux.dev>, Alan Stern <stern@rowland.harvard.edu>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
 syzbot+805630f1453e490427fa@syzkaller.appspotmail.com,
 stable@vger.kernel.org
Subject: Re: [PATCH] mm/slab: reject unsupported kmalloc sizes
Message-ID: <20260826143644.5b3de07a@pumpkin>
In-Reply-To: <82f138f5-11d4-4839-94a3-c226fd982715@kernel.org>
References: <20260817-limit_kmalloc_size-v1-1-5bef487701cc@nvidia.com>
	<82f138f5-11d4-4839-94a3-c226fd982715@kernel.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 26 Aug 2026 11:28:12 +0200
"Vlastimil Babka (SUSE)" <vbabka@kernel.org> wrote:

> On 8/17/26 22:40, Zi Yan wrote:
> > kmalloc is used to allocate physically contiguous memory for kernel
> > allocations. For requests larger than KMALLOC_MAX_CACHE_SIZE, kmalloc uses
> > the page allocator and can only support up to KMALLOC_MAX_SIZE. For request
> > sizes bigger than KMALLOC_MAX_SIZE, the page allocator can emit a WARN
> > because kmalloc allocates an order greater than MAX_PAGE_ORDER. Systems
> > with panic_on_warn=1 crash because of this WARN. Fix it by rejecting any
> > kmalloc size bigger than KMALLOC_MAX_SIZE.
> > 
> > Fixes: aadb4bc4a1f9 ("SLUB: direct pass through of page size or higher kmalloc requests")
> > Reported-by: syzbot+805630f1453e490427fa@syzkaller.appspotmail.com
> > Closes: https://lore.kernel.org/all/6a820ebc.9ebadd4d.20b15e.001b.GAE@google.com/
> > Tested-by: syzbot+805630f1453e490427fa@syzkaller.appspotmail.com
> > Signed-off-by: Zi Yan <ziy@nvidia.com>
> > Cc: stable@vger.kernel.org
> > ---
> > It fixes a page allocator warning (order > MAX_PAGE_ORDER) when gadgetfs
> > requests excessively large memory from kmalloc. Instead of adding
> > __GFP_NOWARN to suppress the warning, as was done for usbfs[1], change
> > kmalloc to return NULL without a warning for this specific issue.
> > 
> > [1] commit 4f2629ea67e72 ("USB: usbfs: Don't WARN about excessively large memory allocations")  
> 
> So I checked and for kvmalloc() we have in __kvmalloc_node_noprof()
> 
>         /* Don't even allow crazy sizes */
>         if (unlikely(size > INT_MAX)) {
>                 WARN_ON_ONCE(!(flags & __GFP_NOWARN));
>                 return NULL;
>         }
> 
> This comes from Linus in commit 7661809d493b4. I'd do the same thing here
> then. Thus there would be a useful warning for e.g. development mistakes
> resulting in the size to be unexpectedly high.
> 
> Callers passing size that comes from userspace or similar untrusted source
> can either pass __GFP_NOWARN or sanitize the size to what they expect to be
> sane (which is context dependent and I assume actually way lower than
> kmalloc limits in practice). Note that passing even sizes within but close
> to/at the limit, trusting blindly some external source, can succeed the
> allocations but effectively DoS the system with heavy reclaim/compaction. So
> caller sanitization should still be preferred IMHO.

Indeed, and sanitising the values early on saves all the size_add() and
size_mult() operations (that are just saturating maths) but still let
through the 'DoS the system' sizes.
Mostly the actual maximum size is actually small. I suspect limits like
64k, 1M or 16M would be appropriate.

David

> Some of the recent
> arguments from Linus [1] would apply to this too, I think.
> 
> [1]
> https://lore.kernel.org/all/CAHk-=wiSmgwwLKCqJwGS-dVHnSLU8W+7q1UQq-G9=TBGGZbuhQ@mail.gmail.com/
> 
> > ---
> >  mm/slub.c | 7 ++++++-
> >  1 file changed, 6 insertions(+), 1 deletion(-)
> > 
> > diff --git a/mm/slub.c b/mm/slub.c
> > index 0337e60db5ace..a3071f4ef1945 100644
> > --- a/mm/slub.c
> > +++ b/mm/slub.c
> > @@ -5263,7 +5263,12 @@ static void *___kmalloc_large_node(size_t size, gfp_t flags, int node)
> >  {
> >  	struct page *page;
> >  	void *ptr = NULL;
> > -	unsigned int order = get_order(size);
> > +	unsigned int order;
> > +
> > +	if (size > KMALLOC_MAX_SIZE)
> > +		return NULL;
> > +
> > +	order = get_order(size);
> >  
> >  	if (unlikely(flags & GFP_SLAB_BUG_MASK))
> >  		flags = kmalloc_fix_flags(flags);
> > 
> > ---
> > base-commit: 8d3ae59288f1e7d58d76558a6ee96d533bc5019f
> > change-id: 20260817-limit_kmalloc_size-3a4a2c73beac
> > 
> > Best regards,
> > --  
> > Yan, Zi
> >   
> 
> 

