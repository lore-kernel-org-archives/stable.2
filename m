Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79C873033FD
	for <stable@vger.kernel.org>; Fri,  3 Jul 2026 16:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783097599; cv=none; b=pQXmm5952zoGqEyGEyHRjqat0ZRSCdNQU+oTy7WoeS9lvHhqfROhb9fY7LvL2T/eSnTT5LulLnhz2Jq2ljO5OmrD2qOI8MnWABR8eNOkhq6Ze3RfBLWsjuKhHmbhS3nSW+Fq+gv9Q0jbugfqa48mwGN5w47Oh344jL7TqvMVx5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783097599; c=relaxed/simple;
	bh=sUpzvAtostE3MW8LT1/9LROV5+uUUmRdE1s1QLaacSw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YmBp1epCES8Cl87TCpTCVkWitLSAXBjfDoG5Rt02iDYku9mq/PWLi7i+XBGKmciEWaS+1ifAnQaL0/yAz5J0l7H30q3ypfGrHaFmuKaQWhs6oZR6z8myftH168eNpR0Ghthff3Zv4KQEYVJWoj4UbNVZRQrHRQButUUc3rYfg7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=oyxLaysk; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="oyxLaysk"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-474e7ba9fd6so433734f8f.1
        for <stable@vger.kernel.org>; Fri, 03 Jul 2026 09:53:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1783097596; x=1783702396; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sUpzvAtostE3MW8LT1/9LROV5+uUUmRdE1s1QLaacSw=;
        b=oyxLayskjViGd7jUQJQx2RZW1oVQ2C9KtokSIXV/oVxB5oWfrq/MbR/S+/hltkROqt
         e8cC+KiREAbxogh96+PEYpnKHnlmkP2TgTQgiVkhWSHFqUY5/isoFquV+lAImZ95P/gZ
         6F5LBqWcyFX4ezemS2eIhZtDO68vCPvuf5f63xGanYnOavLK2UXZHOxDEfuvEYyw73Qu
         LALfbTinr5zM7uK+RwJPktW6cPMngP9OiHQn/N9z6+PmmTELMPD5tKwWvDl7MceAiZWB
         jaEAneuhPL08ioclF8iyg6j3aZUqX99T3KhuGcKMYlRK2YvJPmK4xInu7+qod8AnKxvo
         Xa6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783097596; x=1783702396;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sUpzvAtostE3MW8LT1/9LROV5+uUUmRdE1s1QLaacSw=;
        b=OgCDg5GfGINnQkazGtEvIsJSQ4han/hedCp5hzw5qj7LsU5ihyRO2Xp7QAQr/HMIsM
         JjiSooeWvQQdxjvJMbOZFIJ9z4T0+OhKEAK9CKISnuwDKZqc73wmCdFsynaxEewQbkS6
         /iTzt8s0ep4YstkECMp+hzT3mLubfe7i9zb+g6JYp94GiAqJlIFIYAYtdTQK3qsvO+HM
         b85c/OsS2ljefshVXiGKainS8uLw0DYBcrvO3LLX3vhUrnF8nEDOcmHwFn7XLY9Qnr21
         5y0ksPKJaloFP0fygCuBCNU6RYVVEJlP8FDhZy39KUs1spUZ9mAfxF/NqiuG0oY1PMDX
         71BA==
X-Forwarded-Encrypted: i=1; AHgh+RqRhGxALEcRpx0MMPWQq2IKICl0h7HxouhAL1W7DzwPKLIGE9Jki8ca1MDGQ9UveItkcq/MEWc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4oNLa95dAQvNE3dps2Nzh9VbuV+P6BTgnGGXjhod0EX+o4Tu/
	EzwpZ929S+R8oBDIazcyK7ZD338jSu2FFvHGL+zo/y7JxhwTAoABLPhtanhhY6w06D8=
X-Gm-Gg: AfdE7cni+5CAv1/4SAaUajyOJtb1n/LyGVBLJLu4Xpp75XiexFeLto2KRubyMa7I4E4
	mF2riP4NrNZ+nDY/G8/sZbO4++ioyP28Kp5CgAWYv9y2+15XAyOvUju7KxJNWHWN6zEtlsb8FnW
	83V7TQTa+bFxeskLjYn9/VzPy46syl9MEiDc7NyJ0AUHivv0iC27tCWoIxznDjnQ6UKx2vU/TsW
	BvyvHFpRhgWTH++msOCrbywosWPFfY1dkdz4hGQAIpOUQbfcRTO7/cgrh+rVFnenxInQLI4xMaI
	7XAzfLoe+dSQw3hM+hroN8UL941sqEEQTHBT00cD+3zOR988bqscHVIGzvlw3pSNjCICFdPI0/Z
	JD7YxxvCKpCDhN4GZ7A5K4UE45MyFXEXoxab52bi7lTnzN62h+647clLga1uE8bnYlRtM/7omiM
	XmtiYZob/txQdaa+Mf1rbFvCN6WpymKwqnJgImYv/91fKYuH2y125GniC2Quowv38HZ0kROjNGV
	ol0
X-Received: by 2002:a5d:4b4f:0:b0:477:80fa:f480 with SMTP id ffacd0b85a97d-47aae8884e8mr113189f8f.39.1783097595912;
        Fri, 03 Jul 2026 09:53:15 -0700 (PDT)
Received: from localhost (p200300f65f47db0472e4f1e98703de96.dip0.t-ipconnect.de. [2003:f6:5f47:db04:72e4:f1e9:8703:de96])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-47aa0f214d2sm586590f8f.33.2026.07.03.09.53.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 09:53:15 -0700 (PDT)
Date: Fri, 3 Jul 2026 18:53:13 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>, 
	Vincent Mailhol <mailhol@kernel.org>, Rob Herring <robh@kernel.org>
Cc: Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>, 
	linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net] can: flexcan: Fix probing for m68k/coldfire
Message-ID: <akfoYuyHMAxIfalD@monoceros>
References: <20260618140147.142489-2-u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="esqz4aktzsx7daht"
Content-Disposition: inline
In-Reply-To: <20260618140147.142489-2-u.kleine-koenig@baylibre.com>


--esqz4aktzsx7daht
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH net] can: flexcan: Fix probing for m68k/coldfire
MIME-Version: 1.0

Hello Marc,

On Thu, Jun 18, 2026 at 04:01:47PM +0200, Uwe Kleine-K=F6nig (The Capable H=
ub) wrote:
> When determining the device details was reworked in commit 5e6c3454b405
> ("net: can: Use device_get_match_data()") there was no replacement for
> the previous handling of non-of instantiated devices via the device's
> id_entry which then results in a NULL pointer exception. The only
> in-tree provider of such a device is arch/m68k/coldfire/device.c.
>=20
> Given the id_table only contains a single entry just hardcode the result
> of `platform_get_device_id(pdev)->driver_data` and drop the unused
> assignment to .driver_data from the table.
>=20
> While touching the id table, drop the unusual comma after the terminator
> entry.
>=20
> Fixes: 5e6c3454b405 ("net: can: Use device_get_match_data()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Uwe Kleine-K=F6nig (The Capable Hub) <u.kleine-koenig@bayl=
ibre.com>

Given this fixes a crash (NULL pointer exception), it would be great to
get this applied. The issue is already old (Sept 2023, v6.8-rc1), so
there is probably no urge to get this in before 7.2, but getting it into
next and then 7.3-rc1 would be good.

Best regards
Uwe

--esqz4aktzsx7daht
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmpH6PYACgkQj4D7WH0S
/k7a6QgAnxYTK/BkhslqdnK7jFa+bO/4zfBNv8zZHBfWsjNBgC6PagZ6dTO9aU27
PuZuqpeyfCAYrR0UbOXwydKQdz4S3PJHIFJ/viESSkokiqOp6sFh7uE5KZUQPbtp
bV069rZ7oE+nWgzTLIRJzWu6P8/jZ85PJ3k+qJ0hod1q0W9BON/WQJbqE6RsDvN9
Wuy/aUKVZNClY1kSRuQ0c/BoGijynyoc7HNsDxKVw8iPUApQeJVxGxH2gBQ2syGX
xxVujC+EZXguh/yNKsAgy7TusChDYrd/kfPZpuXlA/NnLqfDcO6te4++6NiXePzp
JxobVAOorXtBr6DJ+nL/IUDOfKP8Kw==
=oQW0
-----END PGP SIGNATURE-----

--esqz4aktzsx7daht--
