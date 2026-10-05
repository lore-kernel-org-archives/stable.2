Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA3892EB5B8
	for <stable@vger.kernel.org>; Mon,  5 Oct 2026 03:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791172366; cv=none; b=aeX6vbbaszBqV4Xj20zb3QdLyknmaKh2q0C6zTike69zkYQXeI+AZUljg9bWllndGjT4UiwNo8Nchqz7lpuy1vGcUtZ4+1hw1kFF9lmnRJhnCyJI1c06HvBrJeen/3s7VOxhvwuw/6licAqWhGbKdnqqL802q4Fnx5FVKpOIjqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791172366; c=relaxed/simple;
	bh=rg8HqcEt6/UKvtkh4FvIyk7WZ6ROa9pdbPJeFBHWYtM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wi4SfAi48pDrIA/XcGW0tfTbyMQQ9PgTClW1yiqgzo9BThiiRnDhQtBHbGDoYxW0ToBSuBy1rw86zA9TUH/I/Q4JT8joOEFkn3O0QeDcuO05WRhUsHf/LakXntAPt4+4He7vCxim0VZiWpyp0p9eMz1vLV/KKhYv+tuFVqsw3f8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rj2QoOZd; arc=none smtp.client-ip=74.125.82.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rj2QoOZd"
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-33fb4680717so3964583eec.1
        for <stable@vger.kernel.org>; Sun, 04 Oct 2026 20:52:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791172364; x=1791777164; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Y0A/ymLpHBtY+HqPCY23ZCUWm2WvUIC70nptaCiUNE4=;
        b=rj2QoOZdzOgjAberCJa2w7HT3cqLsu6XGG4ZVqn2bGR+DW7wXHQImG9g8igd4U26y8
         GldvwE7ZF5kU4RtMAubkxhuA08wbbPvW6e7j1hKzRo4+FR2uBjjA1/G8KGwZ21T6HoFT
         7q8u500yuQ07Y6gWmwRik4ZC/HWexj6wxzNuTKBmrzg89fZKE4IBscfpJtrsbPeo5aL/
         77Wwjyu51Q3bNVW+QPau5MmYLbG4VrzRWxm7w/geuY2qgrFcLaz5JoFgz4+xMyHPBAEQ
         EaNCBBlg6TavHzzBbSFMCWtoVvdiRkV7mUeVJgniQtlraCNQx/dsTdCO8LTDMzaI2Dil
         A7HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791172364; x=1791777164;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Y0A/ymLpHBtY+HqPCY23ZCUWm2WvUIC70nptaCiUNE4=;
        b=lcLWJqPFbEWYHPLZSYB5sCmRp0ogH7qXlAbGKDnFuR+AqeBdfTNLZ9+yAP4AuBbt73
         29wY2Bo5l2m7yG0byQbR7gosG2zqOmJ12KSMvyaY/3uce13owxafoCeF7lqLNUvRC07C
         8srLZIhHcBBZRiIRfFZ091le62K3ZW6Hnr+qJ1dJ0hWTaJVNmXjoJFRdxv6ZK9mtmqib
         VOj9agc6ByFpVa5OaDyqnnJICrnA2SGRyw5tACKMPK9+yDK2XNvDl6/8JAxGVGmuIvgh
         4pUk/cyQn0xoYi/PBfYRYxl+cE9HoQZNhqZDbNOcutEBBkvju5oSO0/25tGN16u+RjDE
         DYCQ==
X-Forwarded-Encrypted: i=1; AKwUvBwAjuS5/tnlqMbupSBKIDvavhHGP/qN8lUxsQD3RpgnbnitvUAFhuA/6IjMyyCfhWYrZgNnOPE=@vger.kernel.org
X-Gm-Message-State: AFuF++kJHak1lQjOANh1So6DORkKTacAyv8TZ8P5kW+c7YF5sOio2dIK
	MjeUmF12Sp9CuxDGVZwKk+GgZSJJzVGpFstgZj+yRGvLRHNRM/+UWojq
X-Gm-Gg: AYBFou2RlZUtZOIYO9VGVNoasM7pZtYSVWLixgOYH4uoKQia/RYwwl7oInDCmRbQYrC
	DjhF8+xOFQshpI7o8tjW7+jOdAH9VsSKScgvEJZsRlBaqfcowmwX+1q7U+UzCJ0ajNJB/yrXeCK
	rYfj9ajPppvSacxRct0QeIo2p02uU4f8I3lZG2xMuY7b6287GiOz5veK5jbcSK0AykBhUqL+nCc
	8+IdzjgnRsTzEdRBkD903GN4ekYYnPWq8s36+QS2HLAHw0xeOqrbuk1ZOl8AXQYIM5G5i02xdQM
	o2QLR+zwCNpigvb8vkLEBW8VWohkazMxsEY4NSaXdwO1E5+bVCI4JD/i60jvh7AuAHbTt7OPJSq
	JSojGDcPkxZQ7Z4oiWuVkhdERzFxnBC+tEz8IbocgWJdqw9B3s20dvIE2esSl/VCoQ2otgYfCKH
	dX+cekRG1sFI8cbBevtSJyWM2CEYAdvHRkOk/Eke/RMCwb7idY6pRfVHUDl1o95tqZfx7g9K4z6
	vQ+v8fEzL8E4vmZErcmBYO27mbI
X-Received: by 2002:a05:7023:a4d:20b0:149:1feb:6d9d with SMTP id a92af1059eb24-151c38b3a52mr8616726c88.19.1791172363728;
        Sun, 04 Oct 2026 20:52:43 -0700 (PDT)
Received: from kernel ([103.219.206.69])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-151fa751693sm41149630c88.2.2026.10.04.20.52.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Oct 2026 20:52:43 -0700 (PDT)
Date: Mon, 5 Oct 2026 09:22:36 +0530
From: Mohamad Raizudeen <raizudeen.kerneldev@gmail.com>
To: Eric Biggers <ebiggers@kernel.org>
Cc: ardb@kernel.org, Jason@zx2c4.com, skhan@linuxfoundation.org,
	me@brighamcampbell.com, jkoolstra@xs4all.nl,
	linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] lib/crypto: chacha20poly1305: zeroize state in
 __chacha20poly1305_decrypt
Message-ID: <asMfBGbckJAhCa45@kernel>
References: <20261004043413.6870-1-raizudeen.kerneldev@gmail.com>
 <20261004172155.GB1906@quark>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261004172155.GB1906@quark>

On Sun, Oct 04, 2026 at 07:21:55PM +0200, Eric Biggers wrote:
> On Sun, Oct 04, 2026 at 10:04:13AM +0530, Mohamad Raizudeen wrote:
> > The `__chacha20poly1305_decrypt` function does not zeroize the chacha
> > state, unlike its encrypt counterpart. The regular
> > `chacha20poly1305_decrypt` function handles this by manually calling
> > chacha_zeroize_state(). However, `xchacha20poly1305_decrypt` returns
> > the result directly without clearing the state, leaving the derived
> > chacha20 subkey on the stack.
> > 
> > Fix this by moving the chacha_zeroize_state() call into
> > __chacha20poly1305_decrypt() itself, so the helper cleans up after
> > itself just like __chacha20poly1305_encrypt does. This ensures all
> > callers are secure without needing manual cleanup.
> > 
> > Fixes: ed20078b7e333 ("crypto: chacha20poly1305 - import construction and selftest from Zinc")
> > Cc: stable@vger.kernel.org
> > Suggested-by: Ard Biesheuvel <ardb@kernel.org>
> > Signed-off-by: Mohamad Raizudeen <raizudeen.kerneldev@gmail.com>
> 
> Sorry, to nitpick this a bit more:
> 
> Can you reword this to clarify that this is an ABI robustness
> improvement rather than a fix, since currently the single caller of
> xchacha20poly1305_decrypt() in wg_cookie_message_consume() doesn't
> require forward secrecy, as mentioned by Jason.  And maybe remove Fixes
> and 'Cc stable'.  Otherwise this commit will unnecessarily trigger all
> the stable backport and CVE spam.
> 
> > diff --git a/lib/crypto/chacha20poly1305.c b/lib/crypto/chacha20poly1305.c
> > index ea42a28f4ff7..80904321458b 100644
> > --- a/lib/crypto/chacha20poly1305.c
> > +++ b/lib/crypto/chacha20poly1305.c
> > @@ -137,8 +137,10 @@ __chacha20poly1305_decrypt(u8 *dst, const u8 *src, const size_t src_len,
> >  		__le64 lens[2];
> >  	} b;
> >  
> > -	if (unlikely(src_len < POLY1305_DIGEST_SIZE))
> > +	if (unlikely(src_len < POLY1305_DIGEST_SIZE)) {
> > +		chacha_zeroize_state(chacha_state);
> >  		return false;
> > +	}
> 
> How about we move this length check into the two callers before they
> write anything to the state at all?  Then the state would not need to be
> zeroized if the length check fails.  Note that
> chacha20poly1305_decrypt_sg_inplace() already does it this way.
> 
> >  	memzero_explicit(&b, sizeof(b));
> >  
> > +	chacha_zeroize_state(chacha_state);
> >  	return !ret;
> 
> Nit: Use the same order and whitespace as
> chacha20poly1305_crypt_sg_inplace():
> 
> 	chacha_zeroize_state(chacha_state);
> 	memzero_explicit(&b, sizeof(b));
> 
> 	return !ret;
> 
> - Eric

Sure, that makes sense. I will drop the fixes and stable tags and reword
the commit message to focus on ABI robustness.

Moving the length check to the callers is a much cleaner approach. I
will implement that and fix the whitespace ordering for v3.

Thanks,
Mohamad Raizudeen
