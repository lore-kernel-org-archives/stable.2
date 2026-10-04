Received: from mail-dy2-f29.google.com (mail-dy2-f29.google.com [74.125.229.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5318E3E1713
	for <stable@vger.kernel.org>; Sun,  4 Oct 2026 03:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791084056; cv=none; b=mPJJkGqF7R903/vGDux1kR8mQc2IPteF3S/9BzERQp1de+o0cdvKt0z67WIlUXygtF6M6vuHly3D+yrqzN0iAqX6J7fO2Y75aJ06Op90WE2Miy5fqu8nKmXGRNWX5hYwM6Rl2XPInW6JO4GKKvsumyqNojvHzSlcH6ntrML5sn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791084056; c=relaxed/simple;
	bh=ZuoVLXI9mZ7Ed8I5MUuPHCLNfDIzZ0wmyd2KS2Qgu5M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bMN7XeZAWKpFuHhz0xzh6IJDL15Voe/ocSPMKaLRT4QuUGS4jpe+4ydpRMl8nTNlwtwmHPuaIu7huW80n4ZtxsxzkG1YQCNg/Um891/HQ9fK9Ijhll2dHSQOCaqYebQX8Y5d/f12SZmwmYUR6Fg/kFYeRY8ypXdZgkLOZcWYSo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B0XgZHiw; arc=none smtp.client-ip=74.125.229.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B0XgZHiw"
Received: by mail-dy2-f29.google.com with SMTP id 5a478bee46e88-34b48100af4so596635eec.3
        for <stable@vger.kernel.org>; Sat, 03 Oct 2026 20:20:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791084054; x=1791688854; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=x2thzfSt5QLT8HAsgWdixq/Y9P05apsvpgjsWLwXNuo=;
        b=B0XgZHiwIuXftckS6QbH+LUuWK7NJZDT3/wKixb7SF2xgjN+IcAmACMyKp3RMn14Go
         op8+gW0fVXk5In3Gk89F36XPaIhwDc4TYGoaIOsSBpRS2j6CRj6GZUG5305h4dTrsLCO
         GqJ7Fz6CvTGCBXVHAGDkOQTO8hNn37AvcVSWejREOxelnu7OgwXs13R6mbEIZM2QOcEA
         FYT05de1UJGniKCblrixXDM3hguvsd9VI2Y1fVaeoiyYOxnQ7qge7S/dK7WLirdrhLkh
         c/No4shSCuZfOUkHMeiHi5g3ESe6S6RVvZxODTLSSige2A7MVdGT5u74ND/C3RW3a1sW
         jQgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791084054; x=1791688854;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=x2thzfSt5QLT8HAsgWdixq/Y9P05apsvpgjsWLwXNuo=;
        b=iEpSF1WA6TobaGg/Kse22VA3e9WrjoBCJlSfrbUNnSwXVjxvjFTUNoqwt8U4RLUxSz
         dcn5fi7UD/pGXdzoUerrKrtBsYbfcv4mUIFd2bCBJS954DLo/T+8ntBTzmvToy9To8vj
         2sctIgCKd+b+pugM1aCnvD9AeqXp6T8HMlOrH+ssTr3RQe8BK5/sxG+7g8kBqYRrWJrr
         RpEctSzMatfF9KHcux/8oIGCU9F/UpqyaCKLsQyGqeaHZu/d2djHfnnbLaa/maGyFAkV
         MeNF0lWvdugwHszpQMKAmcIxcVbno6bieupc9ta59iPPpM3d+yzBSlXlqvcYIqZxVRFN
         CGXg==
X-Forwarded-Encrypted: i=1; AKwUvBxEDXSn0CC8Ms/aw8OllYMKwZ5mVdKaYZVal0gKbelmvAg/1QjMQuWfD0I3cPlE12HzM46SV3k=@vger.kernel.org
X-Gm-Message-State: AFq9FYLg2aziKXuCrXaCpVApzAs5HNT1s0gxXlvybzII+hppOCmYce8+
	77w9E7UYwYO1aCXx01ctdfpZ0+W4gmeVl5zQtfkyAxs5pyHvqV5Xvk/n
X-Gm-Gg: AYBFou2F28jxaAQDp1j5+Ol/rlbGbimObVMtXFe9bOKoA/TK5xfI+HVPUGenx6OXPKZ
	Tt8mtGDbcjRFdRmTuSiOez0zsTYSF08MAgYi0vtKhJZqj+fkplG4aI3C8BwKZhG+tKyGElkum5/
	+PdY/P7riwN55BAcTNWjPMGZV1LfDfQkjXyDjRlQNNW+pq7dPcYeZgRi+Q3hhOypkckIG8/r0nW
	bk2YIkyaxfMglR3U0KK6Qc4s+7dxsV778x/FmC52nBNMX3bEn+BbMQsJiiOCtx08Ox8jFT1C0U5
	g8aVrdB44ew8RgsHgddJ7x5XQC5q3C7e8f89INbXquP6AAfghoCwmmF0Gm9hsuHoe6t1ifE8p69
	qHEuIuDDT4FGI7421i+JVG3oc9f6WLellWAO/hgV+Z7ptD/hsFaowmIsyFotffd5xL8tIKTgyal
	ufpgaiC26M6zWYITW2hwm23uAiJbR5zuGyQep/e21K3ThzGsjjOKi86fDE+pkO8/O7J+GY8D3cL
	YkgI1JSf6KwOXkyYVg=
X-Received: by 2002:a05:7300:6a90:b0:339:8131:424e with SMTP id 5a478bee46e88-34f2185ad93mr8712750eec.34.1791084054190;
        Sat, 03 Oct 2026 20:20:54 -0700 (PDT)
Received: from kernel ([103.219.206.69])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-351272bb9basm1070301eec.24.2026.10.03.20.20.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Oct 2026 20:20:53 -0700 (PDT)
Date: Sun, 4 Oct 2026 08:50:47 +0530
From: Mohamad Raizudeen <raizudeen.kerneldev@gmail.com>
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: ebiggers@kernel.org, ardb@kernel.org, skhan@linuxfoundation.org,
	me@brighamcampbell.com, jkoolstra@xs4all.nl,
	linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] crypto: chacha20poly1305 - Fix missing state zeroization
 in xchacha decrypt
Message-ID: <asHGD1_z-N9k0czy@kernel>
References: <20261003060826.7792-1-raizudeen.kerneldev@gmail.com>
 <asFj6Nxf6fglYfor@zx2c4.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <asFj6Nxf6fglYfor@zx2c4.com>

On Sat, Oct 03, 2026 at 10:22:00PM +0200, Jason A. Donenfeld wrote:
> On Sat, Oct 03, 2026 at 11:38:26AM +0530, Mohamad Raizudeen wrote:
> > The `__chacha20poly1305_decrypt` function does not zeroize the chacha
> > state, unlike its encrypt counterpart. The regular
> > `chacha20poly1305_decrypt` function handles this by manually calling
> > chacha_zeroize_state(). However, `xchacha20poly1305_decrypt` returns
> > the result directly without clearing the state.
> > 
> > This leaves the derived chacha20 subkey on the stack after the function
> > returns. Fix this by storing the return value, calling
> > chacha_zeroize_state() and then returning the result, matching the
> > logic in `chacha20poly1305_decrypt`.
> > 
> > Fixes: ed20078b7e333 ("crypto: chacha20poly1305 - import construction and selftest from Zinc")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Mohamad Raizudeen <raizudeen.kerneldev@gmail.com>
> > ---
> >  lib/crypto/chacha20poly1305.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> > 
> > diff --git a/lib/crypto/chacha20poly1305.c b/lib/crypto/chacha20poly1305.c
> > index ea42a28f4ff7..03b14d272520 100644
> > --- a/lib/crypto/chacha20poly1305.c
> > +++ b/lib/crypto/chacha20poly1305.c
> > @@ -199,10 +199,13 @@ bool xchacha20poly1305_decrypt(u8 *dst, const u8 *src, const size_t src_len,
> >  			       const u8 key[at_least CHACHA20POLY1305_KEY_SIZE])
> >  {
> >  	struct chacha_state chacha_state;
> > +	bool ret;
> >  
> >  	xchacha_init(&chacha_state, key, nonce);
> > -	return __chacha20poly1305_decrypt(dst, src, src_len, ad, ad_len,
> > +	ret = __chacha20poly1305_decrypt(dst, src, src_len, ad, ad_len,
> >  					  &chacha_state);
> > +	chacha_zeroize_state(&chacha_state);
> > +	return ret;
> >  }
> >  EXPORT_SYMBOL(xchacha20poly1305_decrypt);
> 
> In my memory, the reason it's like this is because for WireGuard,
> xchapoly is just being used to encrypt a cookie value, which has no
> forward secrecy concerns at all. So it doesn't matter if it's left
> around on the stack.
> 
> Are there other use cases, though, where you think it might matter?
> 
> Jason

No, none that exist today. The only in-tree callers are the wireguard
cookie code and the kunit test and I agree the cookie has no forward
secrecy concerns. My only thought is that the function is
EXPORT_SYMBOL()ed, so a future caller with a long term key would leave
the derived subkey on the stack and since chacha20poly1305_decrypt()
already wipes the state, having the xchacha variant do the same seemed
like safer default.

Also, Eric requested a v2 that moves the zeroization into the helper
function for consistency with the encrypt path, so I will be sending
that out shortly.

Thanks,
Mohamad Raizudeen
