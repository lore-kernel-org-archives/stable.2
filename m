Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02AB8274FD1
	for <stable@vger.kernel.org>; Thu,  9 Jul 2026 15:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783612007; cv=none; b=gzK1uwQMQ5X5eTy7vwnSsxRJxHmp9J8zrNbLRfjn41FvGNzE7zwny3WcCNTQUSdSe2AxA7EM52XydkmFmOfmnENlj/DCrBSzbenSV2erji3hrZEmT5ISWdxhLY1W4I0WJdHqn5AJ7Ob4hf5qHrGlADB+TL+UAmXGCXyFVeWwepI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783612007; c=relaxed/simple;
	bh=YWBKUDKRZRPtU+PtzWhqbylWfF/NGc3GC8ecVfV7g+s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m4TqvNvGW/a2Td22o/SIDgJsp2hNTwv0HUuEwka7Nl2zkDy6uIxzfaeZdl4eKs7wWNrgeMmrJPtchQ4NMbQnVcrQbumENwSKD+bB8E+374vYbCrvzKmlzFpMtfaS67EcnKaSf6JVlbk3DGwvgTjZ2bRsQZZGNu6xLK+hpdUzYXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hmA0qLCc; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hmA0qLCc"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-493bb510ce4so8933685e9.1
        for <stable@vger.kernel.org>; Thu, 09 Jul 2026 08:46:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783612003; x=1784216803; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=26eVrUBn/cVkx7Rxtr9TR48JaobyoAImvrhEAkxHe1E=;
        b=hmA0qLCcaQ4vAVGLb6e+Vf5CmWDwbjipK7ZBbQLjcXKSH5lF9ODPkBn5BbjeL/U/ed
         m2oIjZtgxDH6+4T8IVIuu3GMDhWFW1OXYvlEBsG2HCl0JWMNg8akuBKPMFXAzULb6Jk1
         igTLMl4QS5v4IjKbDETn3cEjbekir67GOYMYYb7dnA2nle1BkwPNfWG/aboOGwgQa93B
         0zdW1YUU9Mn4yxYxqD+rV8W+DXpKUsEUm00z5rQLnwfZnfWtzdbkK9OCoYhTT+dfz4u+
         2gutfZblAFaSvi3KBUMNAeOPULQaf8BRrI3wzcjO5Bhujb/NBUCuv4IghpmLCuv9Fyc6
         NjPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783612003; x=1784216803;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=26eVrUBn/cVkx7Rxtr9TR48JaobyoAImvrhEAkxHe1E=;
        b=lILCGjEm90cilTIkhPsnVvYfJL8LEQ+Ue/9Q/DSU9XXGpd6ygULvzAYvh+b7yJgvcf
         X+itjAWB83/diyn2rNq7BwTN7nrq4goIwHB5i1B0AcCNnac6dz68WU/cN4s6yMHzr1So
         0dwLUK55mzWTSz6sH3LPtgQGAtCW4Dp6jz4TckYQzAivycg06cDDjKgqbE3LslNgqlv9
         oyhoheq+H0By1R8Qy+o7cQ4+erR1zT6QcN1A0q5APHJiHO0b772h6iKkVwfVaBQ6zx5x
         11traS34pJ7JLyzfhCbovmZShkb2EvKQvE1sezJZfZN4Nm0bLIUeGhDNUwKtyoWq1gEl
         EHRg==
X-Forwarded-Encrypted: i=1; AHgh+RqZzAJXe4Wqm+/n/dTlvoVam1LscFksDjDs5tKGvhbVgsMZJj356KgJT6cosdwOSWrngoG41NM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVmnNJlFRBkxmwtiUxilAqK+ysbkxEor4zqqlJrhSBzDwdC4HC
	p7SuPtSsZwssv7F5YqJ233bB0JE2j05Lg5Q8cNiCdC7j08w2qwKc98Pg
X-Gm-Gg: AfdE7cmWhvfhGxiuGBkdNwg+3G/229auxkdP3CnR/oj7wGXT6H6LiRZnwxi/HsMUGXD
	3shY25Z0r3lHC6FMvynTcWDfFzJiOEDkRoD0am/xLSjHK5O/O3q7G8eK437kagAJLXAcVJGlzwE
	yKZTUaej46xAbQCeVgc5clH5j441azSooVjC3S2+w0iIWWRqXMtjk1x4wYoMmHRBVcRUm4E0w+M
	vf1r8ofc5AH82jLmtcURfrv4LN1lzn9FhFEgf+9YlkvesfVUw2LItxFxV9dbEO1N3LIJrGk6qd3
	C8tuI/k832I3tprmqwOgY8fifKVzqfW2J3Zzqf49GWx7P0nmzFFbo0KX3iwm6/ql/EREHOmV4f7
	z3QS2wN/NWMsaJQ++8MyKQvZ2nLOwuTPYEjFSpP7PTA8WIllEFKCdKGyNGeNLlfA50KctVY4leV
	eJlnUIW3UK/LPrWXBCrFR6ClVEL13S0EScZPK9w1gKzrKh6g==
X-Received: by 2002:a05:600c:6286:b0:493:b7a6:3dac with SMTP id 5b1f17b1804b1-493e68f0746mr70686575e9.33.1783612002553;
        Thu, 09 Jul 2026 08:46:42 -0700 (PDT)
Received: from pumpkin (host-92-21-50-228.as13285.net. [92.21.50.228])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47aa039afacsm50085771f8f.19.2026.07.09.08.46.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 08:46:42 -0700 (PDT)
Date: Thu, 9 Jul 2026 16:46:40 +0100
From: David Laight <david.laight.linux@gmail.com>
To: David CARLIER <devnexen@gmail.com>
Cc: Jacopo Mondi <jacopo.mondi@ideasonboard.com>, Laurent Pinchart
 <laurent.pinchart@ideasonboard.com>, dan.scally@ideasonboard.com,
 mchehab@kernel.org, linux-media@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] media: mali-c55: Fix unaligned access of AEC histogram
 zone weights
Message-ID: <20260709164640.1dba64bf@pumpkin>
In-Reply-To: <CA+XhMqz2oTTy2kY_4uqvJRnoXb0am5h6hXnLFM4EPQ7Yb6N-pw@mail.gmail.com>
References: <20260702103453.348056-1-devnexen@gmail.com>
	<akd8E5jr722oTm49@zed>
	<20260703221651.41669d55@pumpkin>
	<aks7usxfDajS-W_5@zed>
	<20260706104652.GB66892@killaraus.ideasonboard.com>
	<20260706133956.39a11738@pumpkin>
	<aku6R_EI0kLUqD8e@zed>
	<CA+XhMqz2oTTy2kY_4uqvJRnoXb0am5h6hXnLFM4EPQ7Yb6N-pw@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 9 Jul 2026 06:00:58 +0100
David CARLIER <devnexen@gmail.com> wrote:

> > Does it ?  
> [...]
> > seems to clarify this is a non-issue ?  
> 
> I think you're right that there's no runtime fault: arm64 has
> HAVE_EFFICIENT_UNALIGNED_ACCESS and runs with SCTLR.A off, so the
> unaligned load doesn't trap. It's really just a C-level thing - the
> (u32 *) cast is UB and -fsanitize=alignment would moan - rather than a
> real bug, which is why v2 already dropped Fixes:/stable.
> 
> > I still see zone_weights[] at offset 10 which is not 4 bytes aligned.
> > What have I missed ?  
> 
> I don't think you missed anything - the union isn't trying to move the
> array, offset 10 has to stay. The idea is just the __packed member: it
> makes zone_weights_32[i] an alignment-1 read, so the compiler does the
> right thing (a plain LDR on arm64) with no cast, no get_unaligned() and
> no memcpy(). Same 240-byte layout, and it also avoids David's KASAN
> concern about memcpy().

I think you'll also find that gcc will generate a real call to memcpy()
on both sparc64 and riscv64 (and possibly all architectures that fault
misaligned accesses) even if the char[] is at an aligned structure offset.
Either that or, if you include the (u32) cast, it will assume the pointer
is a valid 'u32' pointer and generate faulting misaligned access. 
So while this is arm64 specific code it is a bad idea in general.

> 
> So if you'd like it cleaned up, in mali-c55-config.h:
> 
>       union {
>               __u32 zone_weights_32[56] __attribute__((__packed__));

Should be MALI_C55_MAX_ZONES/4.

>               __u8  zone_weights[MALI_C55_MAX_ZONES];
>       };
> 
> and index zone_weights_32[i] in the driver.

That is the safe way to do it.

Even on x86 I've fallen foul of misaligned data traps when gcc has
used simd instructions to unroll a loop.
I knew the buffer could be unaligned, but needed a sum of all the
32bit words (to set a checksum). Worked find until it didn't...

	David


> And if you'd rather not
> carry the uapi churn for something that isn't a fault, I'm equally happy
> to just drop it - whichever you prefer.
> 
> Cheers

