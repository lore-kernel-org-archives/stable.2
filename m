Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B096F3EFFCE
	for <stable@vger.kernel.org>; Thu,  6 Aug 2026 08:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786004906; cv=none; b=dWT7wJURnJB5mk9uUCQYzISORgBFXfRKaXe4OOi839gOS7EltyvRBwG26HhF5fUAOe63WUtlmTM7yW+LLQGmVOUFFZkLUyCc6gv1N2iPD7LKxd3ZuHszR6vIDkMXPCCsOMOMF3BZ3KjVnUtSPg2s/KOcKA1PqAZi4qVXPMuepZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786004906; c=relaxed/simple;
	bh=yg838gto5IOJaMTAetelvsOdRzNE1BbR63FNwtft4zI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ASmITXwMic39Snj9xCfuaXmy1v2XP0MgkIWX1cacxy9BAHPCkfFdHRcVz9Xp5986QQz777x7RlDPtARvLW19vLjUeD/fAPFeubPnZhs+iGgmVBscxL8hRwXhtux3gFfzgJDSCP1dskpFwVPZOH9fRwJNesJIeRuO6s2R5J3DRmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QYM1n773; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QYM1n773"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4954d29264cso9660815e9.2
        for <stable@vger.kernel.org>; Thu, 06 Aug 2026 01:28:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786004900; x=1786609700; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=COVKnxaXbvkMkEzzbEMC1ENd8eyx/4BNqddLa1MlqMg=;
        b=QYM1n773hCMSUs5SfDCKXoUhVFW2L+yA4zgILPBpMk1p+Mz8LonuM0IKFGi2UGZlzT
         z0TA1rBovjQTADD0tMmR7lZcOoqVst2ibKK/GKryAlvZCeAmTIWEIZoPtWllmheXhfdQ
         VG8gZEJYaqb/IWVDxY9eAniajvnU0i+OtrdMdnVDMDdrEbEVf23UGKbzEj4tvQjBBkgo
         r70swgjxUUQS60LeahsZFFeDDaZrVPJHoQCvs+QehQHLzcf1iKhVVfkht4Umm5hJzBcn
         zRgsUWPXnOdPYB5tsovZEakAQ1/MHyOFFXrAnAPbyohrElOgaIrwc8kAH5v+zcClCtmM
         nE/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786004900; x=1786609700;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=COVKnxaXbvkMkEzzbEMC1ENd8eyx/4BNqddLa1MlqMg=;
        b=lOQN2Buj071gsMdk9v2Akz4CEkJjyBKkheqIO2QBTbOmiLl7qBWWUoUD0t+xmkxCIP
         rWC31mopri3TUsXzopH2DAkYscv8erK4Y0uJx4enLYKX/91y0kW2sUxVWnpFJJytrsvI
         ijjFTFjOZ3NEGcaDAH9ml9dKqkc/BDF2DXZNlmjyEOk+96AtDG3SepwoMO9UkPmmL5r+
         En3FtsLVCS4zzUPO6b2n5Vqm/flnVj01RVmOurR8JivplQnKLc7osrT49QqNt4qOjnOl
         Xkm9X95OCZSPX4uKC70R1Bb7pYfnVrwo7U5Qy6cE40TwgkuBZvL4fO+hiG/m/NEeGwVy
         jisQ==
X-Forwarded-Encrypted: i=1; AHgh+RqtesoQCLGefDG53q7hMKi/hn7tePAwN7Ya2Bfh4E1hSfV6R27ESw1RdN5JSXdN0DJdKJ5erc4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyV0zTENoP1008aYOGafYXkq+1uk/l7tGbTyltuvF+fNBBTWsT
	35iVUd8xGPbPqn9pDoezT/PfMCb0upMWLrtlI2VXG8WMgIqz0msn26A1
X-Gm-Gg: AR+sD118imKjIK0nbzPDCCaMvhluBgvqti+Cwtq19y+owBZoPjY2kHt0IL0Tjh69tdW
	MTSX6iQbcVw20I40FVY9jPPPYHnOG85LIP6StN7M99cSmqsLkcG9xh3jYVRxyHfK4AidQNfNjjS
	mKHBjZzk85WXYqEFpzy4ymYHd9J0mmUZV8g8H9rPs5k4YwBPAGd1yaNNVwH8JJVijh+kEUHm6jl
	7HiJwPIbsZD4jGK6HmFc8nwvFSiwRUeR8Uc0d46Iw1T9mWlYrcS7Fn7denTcQRFH7V0vezj8LNI
	V05A5XcWOSAIk6MFIa/GGBF3YIxZGn6xPCcT8O2xHGAkXIB4PPu2Lvxw2XwvBkFX0GnFXfYwhzl
	nRrw3o+pN/VOf/MsorMHkBV0PtFiu7retUN8TQk9ITQM1WJEy2sBUhnPfkJIzj1D8MMcgeh/qC5
	LLBdkFpWtsZydvQoF86NHtCEcAGdBPZEMnFDe5qLVWbH2kda7Zxzc0Uso5aJN4Rxhuwuxxp8Z6z
	ACOhEAGBwePGMYk6gONOVwjI2sLApfJhAl0bA==
X-Received: by 2002:a05:600c:35c8:b0:499:593b:a15b with SMTP id 5b1f17b1804b1-499593ba192mr6111495e9.1.1786004899623;
        Thu, 06 Aug 2026 01:28:19 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47ff7b250e5sm4410098f8f.27.2026.08.06.01.28.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 01:28:19 -0700 (PDT)
Date: Thu, 6 Aug 2026 09:28:15 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, ada.coupriediaz@arm.com,
 ardb@kernel.org, catalin.marinas@arm.com, cl@gentwo.org, david@kernel.org,
 james.morse@arm.com, ljs@kernel.org, maz@kernel.org, peterz@infradead.org,
 ruanjinjie@huawei.com, ryan.roberts@arm.com, stable@vger.kernel.org,
 vladimir.murzin@arm.com, will@kernel.org, yang@os.amperecomputing.com
Subject: Re: [PATCH v2 02/20] arm64: percpu: Fix this_cpu_and() mask
 generation
Message-ID: <20260806092815.082c6b2a@pumpkin>
In-Reply-To: <anM0S1jVmwO0mqEt@J2N7QTR9R3>
References: <20260804170503.3513916-1-mark.rutland@arm.com>
	<20260804170503.3513916-3-mark.rutland@arm.com>
	<20260805101416.454a49b6@pumpkin>
	<anM0S1jVmwO0mqEt@J2N7QTR9R3>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 5 Aug 2026 14:02:03 +0100
Mark Rutland <mark.rutland@arm.com> wrote:

> On Wed, Aug 05, 2026 at 10:14:16AM +0100, David Laight wrote:
> > On Tue,  4 Aug 2026 18:04:45 +0100
> > Mark Rutland <mark.rutland@arm.com> wrote:
> >   
> > > The arm64 implementation of this_cpu_and(pcp, val) is built in terms of
> > > ANDNOT operations, which requires the 'val' argument to be bitwise
> > > negated. The bitwise negation is not implemented correctly, with two
> > > bugs described below.
> > > 
> > > (1) The bitwise negation is performed as '~val' rather than '~(val)'.
> > >     This won't always generate the expected value when 'val' is an
> > >     expression.
> > > 
> > >     For example, for this_cpu_and(pcp, 1 - 1):
> > > 
> > >     * 'val'    is  '1 - 1'   ===> (int) 0x00000000
> > >     * '~val'   is '~1 - 1'   ===> (int) 0xfffffffd
> > >     * '~(val)' is '~(1 - 1)' ===> (int) 0xffffffff
> > > 
> > >     ... and thus bit[1] of 'pcp' would be preserved unexpectedly by the
> > >     ANDNOT operation.
> > > 
> > > (2) The bitwise negation is performed on 'val' before it has been cast
> > >     to (at least) the width of 'pcp'. This won't always generate the
> > >     expected value for the upper bits.
> > > 
> > >     For example, for this_cpu_and(pcp, zero), where 'pcp' is a u64 and
> > >     'zero' is a u32:
> > > 
> > >     * 'zero'           ===> (u32) 0x00000000
> > >     * '~(zero)'        ===> (u32) 0xffffffff
> > >     * '(u64)~(zero)'   ===> (u64) 0x00000000ffffffff
> > >     * '~((u64)(zero))' ===> (u64) 0xffffffffffffffff
> > > 
> > >     ... and thus bits[63:32] of 'pcp' would be preserved unexpectedly by
> > >     the ANDNOT operation.
> > > 
> > > Fix these issues by adding brackets around 'val', and by casting 'val'
> > > to an appropriately-sized type before bitwise negation.  
...
> > >  #define this_cpu_and_8(pcp, val)	\
> > > -	_pcp_protect(__percpu_andnot_case_64, pcp, ~val)
> > > +	_pcp_protect(__percpu_andnot_case_64, pcp, ~(u64)(val))  
> > 
> > This one still isn't right.
> > If val is a signed int with a negative value then it is sign extended
> > before being inverted.
> > 	val             (int)0x80000000
> > 	(u64)(val)   0xffffffff80000000
> > 	~(u64)(val)  0x000000007fffffff
> > Something like ~(u64)((val) + 0u) will DTRT.  
> 
> As above, where have you got that idea from?
> 
> AFAICT, a smaller signed type *should* be sign extended, and that must
> happen before bitwise negation, since that bitwise negation is to cancel
> out the NOT part of the ANDNOT operation.
>  
> Think:
> 
>     'pcp'                    is (u64) 0x0123456789abcdef
>     'val'                    is (int) 0x800000000
>     '(u64)(val)'             is (u64) 0xffffffff80000000
>     'pcp & (u64)(val)'       is (u64) 0x0123456780000000
> 
>     '~(u64)(val)'            is (u64) 0x000000007fffffff
>     'pcp ANDNOT ~(u64)(val)' is (u64) 0x0123456780000000

The problem tends to arise with (u8)128 << 24 which is signed even
though that is never intended.

To my mind sign extension prior to and/or operations is almost
certainly unexpected.

	David
