Received: from mail-dy2-f42.google.com (mail-dy2-f42.google.com [74.125.229.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A2F647FAE8
	for <stable@vger.kernel.org>; Sat,  3 Oct 2026 16:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791046512; cv=none; b=YVm4JrT3FhlpGsXOgJ4u0lELz0le8nNynh9tXyeRvA/WOTxJuHX2xUI8P8kdZ2RLg7AwkLuq+MhWxJo/tJ9IS0H7IBymky+FaKayGkJ8oFP0SKDNjVEWKjtDl9a9NreaZESFU08VU/FOSKkbdA+/diNvmzNKxoxrw0KW01g9hdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791046512; c=relaxed/simple;
	bh=X+JsHy9hcmmtZJVBa9Kkkln84dK+oOE5eRwAZnxmFJY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pSUwQ+zGa0kbpLD8o/6YWHsDo5/9cUWaMcXHkGBlQyJrXRZxiK1tXUxFnK+BDZzuyvR3/P57otNlvntrLu1jI0VuAqXZoWvHqXz32rkBjkIaABT+WoFclaRrQPWw6AvKFLI4eZtMj3qDsM6d0hQWjuq97HfQp3/oeOgLacgrHi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wpb5/xPa; arc=none smtp.client-ip=74.125.229.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wpb5/xPa"
Received: by mail-dy2-f42.google.com with SMTP id 5a478bee46e88-3510b42f4e3so442658eec.2
        for <stable@vger.kernel.org>; Sat, 03 Oct 2026 09:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791046509; x=1791651309; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vfNONSg/6lEhGon/gJ7DMZGMT+W70fNRaOzKZcnrLmk=;
        b=Wpb5/xPa8rjPsNtwJuOIGUdW1VZv1F1GswyijTEk3+u6K13k3G9zKd83uHTu8DNBQL
         HlLpFC/tBuNizcPJdF5FFZPkJjbGDILUzZzOrSGX2S+GQyzZHP8N7YTlGuQywOL0hWP0
         moN1QMSJmvpQOIsmpzPkyiQswObFuuE0BxL6huVI22vQdNMwnAeSXAfzx92jWdiLEgD/
         vYUX2O3kjDfwyHc/zeLFn4PHTQ6NndBFrtRe55STFDEhy/qPTJEJKcYRwp9SQYue8vPd
         Qz+FSHTPpobiUMTHs3dKKaYuaT32ljJOAn84e+tfqx0pqn3RSI9wZMjeJ+FbzjmGGVap
         pBVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791046509; x=1791651309;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vfNONSg/6lEhGon/gJ7DMZGMT+W70fNRaOzKZcnrLmk=;
        b=INcSusgpZQbrMVQjqL7m5Eeebf4YN7dzodmIc72zFvpPlu3un3zr6irZOdHjgYvGjS
         /mXn4A9/W0Je0xn0cZXG5Cb7WRhL8678zxzR8Xb+d5lBLPQTQlNomQ2+mjRG+JpyMbFp
         NpoicDNxyQp6HDMfhz2GeRwbQrRXwtOVHNOGZdbeBgjrIvB8eBz+BgoUnWzr50kImSND
         hZiO6Pltt0rxsH3A1J54WmHCGmAcU1YJG3V1Y/KsK+qbE+wWHLb7rf2YWeM4oL/Vloph
         kds/ghPsANOd/0QTL9FYOtK0scpjHfrollT2SOxWZrFGvCQklHnIgOEF8Rf/HVMtupMu
         oiaQ==
X-Forwarded-Encrypted: i=1; AKwUvBzbtD6iIpN0Gp49bszJq4qFa9dVRh8ZAZDed66D2ZzsW8HN0ZFjpcxhuLdIe580n3WFEjttHec=@vger.kernel.org
X-Gm-Message-State: AFuF++lD67EgycSrqV7SAIQr06MVr87uqgT2c6gfOVq0vwoQ+Tx3vMMG
	eJ5gbeghPZcPs470bS/LotUdHCp8doHfNOEuq+X8AVmxHMrzD+5AGt+3
X-Gm-Gg: AYBFou2j9Dasao3jNBLVlK0/9SMQ0KV9ApM2jdPuHeqcRhBlQoW04VQG0U/JiTQQUsB
	NVMToM2wvEbpQGSMT43biUHdy+Qo8Ke/FLk9wTickIa0D6gemvXJAyokL/m4xdp9cqqw1BquO2v
	JA7skVRs63DXcEyS5qST+3Ly54Q4LSvH9aECx7/fhMiykK/a4caSMKH8TgoSD3HGqFcKuTyLlAg
	CDL7vZg65xGYTDrClkcStiJhUnn8nAf5mUrc9cebIAbx2HloPGGSQ79rw88EtYEzlu3OMnSVfNP
	5sqTq2jxmP+nk/ucDU2xn3+QA7HjCjf4xb+5eZxUj5zpzk9m/rUoAia26+463pXPT/wyTrIK3sE
	XmxqZsshA1u0yectyS11kPgoXhc1OKTS09WnWIt20QEDQypso5md+1GwWRaKW9ghZ5WhY6i1vNT
	meeQS1r2ldgDvyB3JKtal+N9cZx0oYhfGRsurJOFmjod/F3PeHu4EGYOPDiyG5v8fUqCQXymAUI
	ko8h3DsIpOXM7j8xQBqR9ZjTjcz
X-Received: by 2002:a05:7022:304:b0:14a:51c8:e9f2 with SMTP id a92af1059eb24-14f5c2ef7bfmr11363603c88.31.1791046509232;
        Sat, 03 Oct 2026 09:55:09 -0700 (PDT)
Received: from kernel ([103.219.206.69])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-151fa751693sm18671183c88.2.2026.10.03.09.55.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Oct 2026 09:55:08 -0700 (PDT)
Date: Sat, 3 Oct 2026 22:25:01 +0530
From: Mohamad Raizudeen <raizudeen.kerneldev@gmail.com>
To: Eric Biggers <ebiggers@kernel.org>
Cc: Ard Biesheuvel <ardb@kernel.org>,
	"Jason A . Donenfeld" <Jason@zx2c4.com>,
	Shuah Khan <skhan@linuxfoundation.org>, me@brighamcampbell.com,
	jkoolstra@xs4all.nl, linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] crypto: chacha20poly1305 - Fix missing state zeroization
 in xchacha decrypt
Message-ID: <asEzZY2-PqUK0N-M@kernel>
References: <20261003060826.7792-1-raizudeen.kerneldev@gmail.com>
 <b937fca8-f436-47a5-988c-963fa1af6296@app.fastmail.com>
 <20261003085757.GA144870@quark>
 <ea68191f-86cf-44b1-a045-237b93a4953f@app.fastmail.com>
 <20261003163926.GC152469@quark>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261003163926.GC152469@quark>

On Sat, Oct 03, 2026 at 06:39:26PM +0200, Eric Biggers wrote:
> On Sat, Oct 03, 2026 at 11:28:20AM +0200, Ard Biesheuvel wrote:
> > 
> > 
> > On Sat, 3 Oct 2026, at 10:57, Eric Biggers wrote:
> > > On Sat, Oct 03, 2026 at 09:34:21AM +0200, Ard Biesheuvel wrote:
> > >> 
> > >> 
> > >> On Sat, 3 Oct 2026, at 08:08, Mohamad Raizudeen wrote:
> > >> > The `__chacha20poly1305_decrypt` function does not zeroize the chacha
> > >> > state, unlike its encrypt counterpart. The regular
> > >> > `chacha20poly1305_decrypt` function handles this by manually calling
> > >> > chacha_zeroize_state(). However, `xchacha20poly1305_decrypt` returns
> > >> > the result directly without clearing the state.
> > >> >
> > >> > This leaves the derived chacha20 subkey on the stack after the function
> > >> > returns. Fix this by storing the return value, calling
> > >> > chacha_zeroize_state() and then returning the result, matching the
> > >> > logic in `chacha20poly1305_decrypt`.
> > >> >
> > >> > Fixes: ed20078b7e333 ("crypto: chacha20poly1305 - import construction 
> > >> > and selftest from Zinc")
> > >> > Cc: stable@vger.kernel.org
> > >> > Signed-off-by: Mohamad Raizudeen <raizudeen.kerneldev@gmail.com>
> > >> > ---
> > >> >  lib/crypto/chacha20poly1305.c | 5 ++++-
> > >> >  1 file changed, 4 insertions(+), 1 deletion(-)
> > >> >
> > >> > diff --git a/lib/crypto/chacha20poly1305.c 
> > >> > b/lib/crypto/chacha20poly1305.c
> > >> > index ea42a28f4ff7..03b14d272520 100644
> > >> > --- a/lib/crypto/chacha20poly1305.c
> > >> > +++ b/lib/crypto/chacha20poly1305.c
> > >> > @@ -199,10 +199,13 @@ bool xchacha20poly1305_decrypt(u8 *dst, const u8 
> > >> > *src, const size_t src_len,
> > >> >  			       const u8 key[at_least CHACHA20POLY1305_KEY_SIZE])
> > >> >  {
> > >> >  	struct chacha_state chacha_state;
> > >> > +	bool ret;
> > >> > 
> > >> >  	xchacha_init(&chacha_state, key, nonce);
> > >> > -	return __chacha20poly1305_decrypt(dst, src, src_len, ad, ad_len,
> > >> > +	ret = __chacha20poly1305_decrypt(dst, src, src_len, ad, ad_len,
> > >> >  					  &chacha_state);
> > >> > +	chacha_zeroize_state(&chacha_state);
> > >> > +	return ret;
> > >> >  }
> > >> >  EXPORT_SYMBOL(xchacha20poly1305_decrypt);
> > >> > 
> > >> 
> > >> Wouldn't it be better to move the existing call from chacha20poly1305_decrypt()
> > >> to __chacha20poly1305_decrypt()?
> > >
> > > Since __chacha20poly1305_decrypt() has two return statements that would
> > > need to be considered, I think this patch (which makes each
> > > *chacha_init() clearly paired with chacha_zeroize_state()) is slightly
> > > cleaner.
> > >
> > 
> > Fair enough.
> 
> Actually, looking at the whole file, in the encryption case
> __chacha20poly1305_encrypt() already "takes ownership" of the state and
> handles zeroizing it.  So given that, I think it does make sense for
> __chacha20poly1305_decrypt() to do the same thing, for consistency
> between the encryption and decryption cases.
> 
> Mohamad, could you send out a v2 that does that?
> 
> Also, for the subject prefix, use: "lib/crypto: chacha20poly1305:"
> 
> Thanks!
> 
> - Eric

Hi Eric,

Sure, I will send the v2 soon.

Thanks,
Mohamad Raizudeen
