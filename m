Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E46484DA9D7
	for <stable@vger.kernel.org>; Thu,  8 Oct 2026 15:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791472025; cv=pass; b=Z6Dmel+5Nzla30sMcdJcHWYWz569yUxKl8Lfnh/re8Njai2WPV9Ciy9nbq5aT02V70qFV3j1t7WZZAIroUQeTpxmDApMnxjaMW/47Y3+5vIdJc7AREXtsHz5zroSKeTdZ5g9+ZVMb+ZRE9+6lNscCa3Mh53vqVQ/T4IOjZXZnqY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791472025; c=relaxed/simple;
	bh=PPemHYd+f49/x1k9OhaO6TJLctq/Cqq9D6GbeCEQ3Cg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q8OEYZiQKWNgU4Ge5mi21RwDgADfbo/FpCzhFG5yQbbPX7QZ/So0Y6TAoKqJy+Vae8f3M1fGZWYT+qMgO0sTSGgpsmVSziCRk2cG5GHxFBerDF+hQb+YiCX3ZidpnkuGtMQvI4KJFS7wIFs/vte6FnQj87xTFcxWLqBPSuhPTYc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fYecoBYW; arc=pass smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fYecoBYW"
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-676858d42f8so3157192d50.2
        for <stable@vger.kernel.org>; Thu, 08 Oct 2026 08:06:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791472017; cv=none;
        d=google.com; s=arc-20260327;
        b=pyrUber8GWX8W2vI+bJ1xE/X7F5F4D0PJTnoaawwm4j2BalUNE/z+9GMfJd3R7ux05
         +7Pq34tkMAcHg5vJ1reTJZBkQ5rowWgZv6jQvSHk47Bcc0+h82yuQ439S4UaqTjE+8QP
         Ypei1zkw94pmM4J56NZGsDbWfDsXijj9w9hd0MGFXB/jIMuTWEKiXrSYHi4ot8IOmBSm
         I5UCnC6DBTzauGkPr+pLu/iRULm8wmv6LcHi5be/0Ko1vYoFjGQ7KvRVAabCw7IO3Lw4
         VGxKD6dQLpYw6sfJqt0GUXm3lg2HnoAGfns1/FkELIMao49YVR+zmPRtOahy+dyuZbS/
         46EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7nTNII3n3G87GHhdFtHT3hqd10T6INaV8G3FhaWt9A0=;
        fh=VJFwTG8Q6n3Muk2km6nqO85Mp8+BcggfIj1BvsckuEE=;
        b=CLm4uudjqWty20H5+uCLr1RydsjKTpqrAFUHMJU73+7o2hmZQaDB/wsp6TCc8ANo1z
         RaHJqxtwaVbMbCiM0JtK79iST224cPd8YJNS6c4A755C+xSPCck5c3FggilGFg/G062n
         JuTJqI5XmRTWHQAg1tN7gIzJeQUMggbF+UUbv6ldO9YbdzjUHw9VKIozh1iPNyx/0DlL
         tvYhLwSih96tfZ4Uc3t0YthPIlfFp+hVxf1+w2wKpWTcobXOncY66MOXUMvXop4Bkn6N
         U572UkaIOego6xbWq+yHfwlq6LSFFP5q2DiUnVu6+1HFbbA1ioyNyMeqv98sNuse9aQ1
         SaRw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791472017; x=1792076817; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7nTNII3n3G87GHhdFtHT3hqd10T6INaV8G3FhaWt9A0=;
        b=fYecoBYWT0r2VLx/C4NAeQoxzaOVyN1FK5IuuDXVZabGmlslOAOK8yoOkAWeOoi6/S
         WLrKax0fjfa0akrCn3de+XeLI6siCPFZrPaCajKmmy8/jZqea2dgUc0q6NicgAdWqQmF
         DKGHn2K74XE4vBO3+aDzfEX1/rIcIQEL6/Gk60h4tabJPye4CE8eu3QH4OOLxdeeXuXs
         ClWYI3GX4zbmkvo5zXcKZJkmyjcVyc0kbZnXhw+yLwHwZlyliIgLUN+4QhY6TcdeMiD+
         FwWNbVc1UTLvyTPLJQhBW3/F5AKSXly60xUSz+rlbiXKHzwstTD5GDubdhfin6+jfKaI
         yR6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791472017; x=1792076817;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7nTNII3n3G87GHhdFtHT3hqd10T6INaV8G3FhaWt9A0=;
        b=JUEb1tiU39MnUJPXDE2DYjT9rdOgIef6aiM6TY7++X9REpaP9jCbJEvkQrv0g9wvEj
         ECHdzdY+O1aYbFUEp8mpLpFVQDnP+LvADUTcOkXXGFFLOZycSW7sehQ2PUGzMqr2bLAP
         Q9szvOB1LO61IUExwCBVdLBN+SrteDqeD/V87+RgnpadjhvyvhqhsQ0HBOkMj5QsPvA4
         bQCltORc3+9EoVAyClwk5/KoWY5R2jIYTXzX0QjEKZY0oxKNSF+0BY7I5jD0Q/UX1shW
         XFIwwW8uOPMOx7WZanV6/xamctcG2M+CifRB1Ruv7tUUU2sRxrtgDqBkMCiLftluG+R0
         dgWg==
X-Forwarded-Encrypted: i=1; AKwUvBy+d2OK5x6m0qBAA5q6TM0cxug/RVGJp7XKE3kHY0O0W25q3bz9yyYIYCjTeToZ/c2DKdUzAbo=@vger.kernel.org
X-Gm-Message-State: AFq9FYKCMxrcsAjI678hTgEVZcp8jqVsg6GRR8+pcPqCLyEIiVFJETTR
	DoRZDqJGzpiBeg/3iTc93/jFleA8/H3dYayrx9memdawKpSRCzcBHi3/neH2LnQqxpl+BahPiPo
	mt39YYc1lgAYftmEsU0KdZOgnawnRzP0=
X-Gm-Gg: AYBFou1UCAIsxDUAPn/A2oR1TAcipTosQQDyD94I4yL7lyxpDGqW/4uMv+RHRjmBYeH
	VXwgYvB0//SsWt9dYSGouQwnamEuM1TF0bERRnFEyMsXDbKOBa65R65Qglmjdo8Mw3S/m5p9cIs
	YTRp9Cq3rWlvX8MVBJ9fVIbiivjaFgdf/FVMMW7gt03RWr4ccOlmoAclDLRHsQmLBXHo35Jff/A
	7/0fI2Yj3l7jPjI0rR4TmmgKrxvbmavgUa6HVmNqJ01bvX5icypwWxAQjSSqkRP4AzCPymdaKOH
	23cRB8FlrGDc+WJkirCOM10LPN6IhM3hYYhVdXdxgz524F83Ez3ZoxGjwn6MxFKYJ0KZXOFgzc0
	U3/tB4HFv
X-Received: by 2002:a05:690e:4199:b0:677:b923:dbd3 with SMTP id
 956f58d0204a3-6790a49aef4mr1817579d50.154.1791472016554; Thu, 08 Oct 2026
 08:06:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261007163403.1643768-1-ekffu200098@gmail.com> <asaEdFRDdZlRdAc4@thinkpad>
In-Reply-To: <asaEdFRDdZlRdAc4@thinkpad>
From: Sang-Heon Jeon <ekffu200098@gmail.com>
Date: Fri, 9 Oct 2026 00:06:44 +0900
X-Gm-Features: AclHuK8DoN5ENhoGGsqTh6mQAA4XecrayQgZajzaBuMSAutJnzs0JzwLoPXtW-M
Message-ID: <CABFDxMHsn+Dj42GU0zk-HEfYOhoEs1c+UsmLMSjNSrWfUu4MsA@mail.gmail.com>
Subject: Re: [PATCH] mm/slub: clamp slab_min_order to MAX_PAGE_ORDER
To: Harry Yoo <harry@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>, Hao Li <hao.li@linux.dev>, 
	linux-mm@kvack.org, Roman Gushchin <roman.gushchin@linux.dev>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Harry

2026=EB=85=84 10=EC=9B=94 8=EC=9D=BC (=EB=AA=A9) =EC=98=A4=EC=A0=84 2:47, H=
arry Yoo <harry@kernel.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> On Thu, Oct 08, 2026 at 01:34:02AM +0900, Sang-Heon Jeon wrote:
> > setup_slub_max_order() clamps slab_max_order to MAX_PAGE_ORDER, but
> > setup_slub_min_order() has no such clamp.
> >
> > The buddy allocator cannot allocate more than 2^MAX_PAGE_ORDER pages
> > at once, so slab_min_order above it makes no sense.
> >
> > If slab_min_order is set above MAX_PAGE_ORDER, it can even panic at
> > boot or invoke undefined behavior in order_objects().
> >
> > So clamp slab_min_order to MAX_PAGE_ORDER as well.
> >
> > Fixes: 818cf5909701 ("slub: enforce MAX_ORDER")
>
> I think Fixes: should be the commit that introduced slub_min_order.

Thanks for your guidance. I'll switch this to 81819f0fc828 ("SLUB core") in=
 v2.

> > Cc: stable@vger.kernel.org
>
> And no need for Cc: stable? It's been there for decades and people
> should realize the kernel parameter is broken when it doesn't boot.

Okay, I'll remove it in v2.

> Otherwise looks good to me.

Thanks for the review :)

> > Signed-off-by: Sang-Heon Jeon <ekffu200098@gmail.com>
> > ---
> > QEMU-based test results
> >
> > - Booted with "slab_min_order=3D20"
> >
> > 1) AS-IS (before fix)
> > [    0.094926] mem auto-init: stack:all(zero), heap alloc:off, heap fre=
e:off
> > [    0.097776] Kernel panic - not syncing: Creation of kmalloc slab kme=
m_cache_node size=3D64 failed. Reason -22
> > [    0.099542] CPU: 0 UID: 0 PID: 0 Comm: swapper Not tainted 7.2.0 #1 =
PREEMPT(undef)
> > [    0.100903] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), B=
IOS 1.16.3-debian-1.16.3-2 04/01/2014
> > [    0.102607] Call Trace:
> > [    0.103040]  <TASK>
> > [    0.103417]  vpanic+0x32a/0x4b0
> > [    0.103976]  panic+0x5e/0x60
> > [    0.104491]  create_boot_cache+0xe3/0xf0
> > [    0.105194]  kmem_cache_init+0x12d/0x410
> > [    0.105890]  ? mem_init+0x1fc/0x210
> > [    0.106521]  mm_core_init+0xba/0x140
> > [    0.107153]  start_kernel+0x441/0x8b0
> > [    0.107814]  x86_64_start_reservations+0x18/0x30
> > [    0.108638]  x86_64_start_kernel+0x10c/0x120
> > [    0.109401]  common_startup_64+0x13e/0x158
> > [    0.110145]  </TASK>
> > [    0.110584] ---[ end Kernel panic - not syncing: Creation of kmalloc=
 slab kmem_cache_node size=3D64 failed. Reason -22 ]---
> >
> > 2) TO-BE (after fix)
> > [    0.008976] mem auto-init: stack:all(zero), heap alloc:off, heap fre=
e:off
> > [    0.011366] SLUB: HWalign=3D64, Order=3D10-10, MinObjects=3D0, CPUs=
=3D4, Nodes=3D1
> >
> > Also, I'm not sure about the Fixes commit. Please change it if you know
> > a better one.
> >
> > ---
> >  mm/slub.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/mm/slub.c b/mm/slub.c
> > index 1559cbace469..8400df7c222e 100644
> > --- a/mm/slub.c
> > +++ b/mm/slub.c
> > @@ -8354,6 +8354,8 @@ static int __init setup_slub_min_order(const char=
 *str, const struct kernel_para
> >       if (ret)
> >               return ret;
> >
> > +     slub_min_order =3D min_t(unsigned int, slub_min_order, MAX_PAGE_O=
RDER);
> > +
> >       if (slub_min_order > slub_max_order)
> >               slub_max_order =3D slub_min_order;
> >
> >
> > base-commit: d755441b7672c74f29d1241ffdd2b067ecab1ca0
> > --
> > 2.43.0
> >
>
> --
> Cheers,
> Harry / Hyeonggon

Best regards,
Sang-Heon Jeon
