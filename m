Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 537F54A99C9
	for <stable@vger.kernel.org>; Wed,  2 Sep 2026 16:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788365230; cv=none; b=YOsuRpUZ2UUy4tGF5luwKGSGcjL6m9T1i5SwAGNmGhCt24EassU+s2ym55IyKnDRD/aRFnyIgo4KRemRYaiSlk4QBfi/mn0FAYQof3r1DjWNszvasFCOrUf/nSmEzn/+7AOB9dIeiBowcEKFSF8J9v4+ZF4Tko3A1sefebCyVfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788365230; c=relaxed/simple;
	bh=byZTt5R6BjpzTu8+p8/eAxBr5GXUWYt9qNckwpzaZvs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qrxTijcJ4v9wvhkhIzWGh08JYudYjai9G1BlCdLzdo39AWr2uyHby4PyDMsL7mS1taQ9MjY/fr1GLJTpVS83xvyZvzecrRY7ICU5inLjZwUNP/FOcHpV1Lxs63T8E7/KpxUA20HimvtnDn34KjAq+I7Dqw9RpyEZRdRSGoIV0GU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xp4exYyY; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xp4exYyY"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-49ccfae359fso8648545e9.3
        for <stable@vger.kernel.org>; Wed, 02 Sep 2026 09:07:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788365226; x=1788970026; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0jnVwXo8Qv+75toQ73l7dAA+32JWKJPezOLtyqrUA2Q=;
        b=Xp4exYyYpT5tyUME3p1PWfQsqIkGqo/wS46qQm98CwI4mVFkw/z1IphW+NUjRhWG60
         4ltumy3caJ8tkGAGusoxicYN6AxRcLTXNvPWhR4rrwFWc3nuYVozXTFAGf37EAa6cAMS
         dCuG1Fmd25PmXM8DwhfXr1GzN38/Ken7yy1NrxH6yUsFf9V0C81ZsXyLqXNxizGmtMnU
         lhogqrx+4GskOwp+SyP44dAuj7OqZEx/Q9kzmcz82WGcGzbeD787LfxANiFJa5wXb2Ym
         Bb7dA9Xdo6kUti1V11rMUrbBn18nCD+b8DeKcAzuDCKGGIWGxLcSauTOZxa3fiWZ9d2A
         9QTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788365226; x=1788970026;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0jnVwXo8Qv+75toQ73l7dAA+32JWKJPezOLtyqrUA2Q=;
        b=MNKH/lN5ERoZjx1qmUX7ILnEXlXxUJ3wGQV/TcSkXfowqow3UPImKrkXYKQouALahK
         NHjURFXe80evKP/61nxoa2RIOMjxkwUHYewSExdc8nJ+qR8OA2gwl/oZtw+8TvztaBrh
         uAojvix6LVbvPpnfaTWG9lQtqHk+f+iZg2ZLwYQjv5dUBoh7zhYdnP84GzHxBAGXqZJl
         OWzfNE8ZOTIFAjxkyoByDDzPBeol+2P5y5khtoWQsWhcG8eoBKbj5Qref1EdfnGeInYe
         Wq4+cEOduDPkdyRQug2yI7gx1C6Qg89Mg5d2r0HWwuzUKFZtPCo44Ax6rJiRWzbSc///
         KY/g==
X-Forwarded-Encrypted: i=1; AHgh+Ro4J9PPVnX6A2O5gtRQHVyxeg9iydS+AwT4pIleiftdGcSRdfGSvqs5CuXEJNqJZt0Vn/kKkOQ=@vger.kernel.org
X-Gm-Message-State: AFuF++kvu1GjqD/+1yz9SrJJbv7i/hZ6mhsSTbZLgznUnjgq9JU+kFAn
	CNOh9vYIfx3NhKWDXYmbAK3cWJ/wQDcMhcf6xub6/H9J0sGAQRa3/VoU
X-Gm-Gg: AR+sD13f/dfv3Vt2AFgzNdFvCZxX4LlztjBsE0lmo+KCriHCz+5Cq5DKTK9V1JRfVNQ
	tZaHYjjR2QTtLMiL58BxaBuLu4IVtYJBFg1xmkgYs1R2JhtPw7Ww5+byZauxr5FynMsygO9XzPt
	0yDxXWhsTDNbkYzufeHw5G8ESF9NzA7A91p/p/JCBD92GJDQ3RrgAwriYfS2/1m52oFC2cuuQ0P
	AgQqBRJ+Q+Ttb7Yd55AOwclAwN7b13Kza7mOQ40sEtFKKriERDP7Zq4Cw6eokGiZd2TUetVdWw5
	9RFMHpCHUbg/Nt/cHR+r+TJOZPVjPhyVhwYRmnlpfe6w6q+BI7uEL0Ci2y/77crpfVjXHIiOEOQ
	kSUYahvTwkrHRzvYDfX2QQMEoeYStoh1u0YxeRlj99DBIUQtv+LKtZv/dy129D3udFLCrhOHb1H
	1yKBZWFk2+99GPGmFe8tgM3AMOp0XTFM3a20O0O8SMNEYVVZf2d6/xX3009Jc0AO/ol5/6GqLvN
	fKPCZ22fbdBqjdUSn8VVU6SUQ==
X-Received: by 2002:a05:600c:45c4:b0:499:79b9:e220 with SMTP id 5b1f17b1804b1-49ce5816186mr109276985e9.10.1788365226253;
        Wed, 02 Sep 2026 09:07:06 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cee5d476esm2206255e9.1.2026.09.02.09.07.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 09:07:05 -0700 (PDT)
Date: Wed, 2 Sep 2026 17:07:05 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Eric Biggers <ebiggers@kernel.org>, Andrew Morton
 <akpm@linux-foundation.org>, linux-raid@vger.kernel.org,
 linux-kernel@vger.kernel.org, x86@kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH RESEND] xor: add missing vzeroupper to AVX code
Message-ID: <20260902170705.213d432d@pumpkin>
In-Reply-To: <20260902133706.GA21538@lst.de>
References: <20260831212248.213805-1-ebiggers@kernel.org>
	<20260902133706.GA21538@lst.de>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 2 Sep 2026 15:37:06 +0200
Christoph Hellwig <hch@lst.de> wrote:

> On Mon, Aug 31, 2026 at 02:22:48PM -0700, Eric Biggers wrote:
> > Since the AVX optimized XOR code uses YMM registers, execute vzeroupper
> > before returning from it.  This is needed to avoid degrading the
> > performance of any later SSE code that may happen to be executed.
> > 
> > Fixes: ea4d26ae24e5 ("raid5: add AVX optimized RAID5 checksumming")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Eric Biggers <ebiggers@kernel.org>
> > ---
> > 
> > This didn't get taken through the x86 tree.  Andrew, it seems you're
> > taking patches to lib/raid/.  Can you apply this one?  
> 
> Can we do kernel_avx_{begin,end} instead of having to open code
> and document this everywhere, please?

In which case I think you want the vzeroupper in kernel_avx_begin().

Actually, for some cpu at least, you need vzeroupper in kernel_fpu_begin()
even if the code only uses the SSE registers.

See: https://stackoverflow.com/questions/41303780/why-is-this-sse-code-6-times-slower-without-vzeroupper-on-skylake
Basically, on Skylake, all SSE hit a penalty if any ymm high bits might be non-zero.
Don't know what has changed since...

I don't have the Intel optimisation manual downloaded (ok, I might have
it but have NFI where), and the link on that page is broken.

David
