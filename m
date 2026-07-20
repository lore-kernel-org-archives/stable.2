Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D3273B8959
	for <stable@vger.kernel.org>; Mon, 20 Jul 2026 13:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784555001; cv=none; b=qTOmd2qX+faj5j4JR2CghhAOmI41XBSZx6HZ8cQTv9CenbOwyEWic6q6eX+MhREPXJRO5lkkauRDgpBuDlfxLbJTTgEy/YlXfN/99B40nMYpF39NwHLsyaMn2YMM4Nvym/43WcvH53V6x0U3QaAQ28JP8RWg1eELEruN/jLMHYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784555001; c=relaxed/simple;
	bh=zmBJ/0A84g3rungkV5GDtUzaTyuvksj0gerDJWlqPf4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aASc2ejdGnhU9wlbjhYWTyH1OG6gVbit/evufZoPac4HcNIth1zHdO0f2R73w0kCO+XiMyRS685u7zwsZIhrobqHjNaw3Ty0/zTdntqEIcWUkBdei4LIJl72S82qsCULQXYqmriGTTN5bld4plhHW67P2tmMZ01xB16UQ8dl8mM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=VKYXOJaV; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="VKYXOJaV"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-49558ce01afso11956675e9.1
        for <stable@vger.kernel.org>; Mon, 20 Jul 2026 06:43:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1784554991; x=1785159791; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zmBJ/0A84g3rungkV5GDtUzaTyuvksj0gerDJWlqPf4=;
        b=VKYXOJaVwdS5a7a7y6wBBKng3z/GnWsWuT2JM1MfuuAMLeAxGdBHSBCenrxfPufAF1
         GqAEHI/WxWcA596B5Nv7+cqksIzfsrmT/ZZEqHLM3XZVgQa4XN5WFIh4ixNZX9u2QaOH
         ydBjJ2EEUUCu/N43q5U1B2XW8wst8vR6EMidnNp6P+RbFJ+4cu4m8+ArRva3K1XF3DxE
         M8MmtNpQu7KorhGx6QINqnrQUiKkgpLXdg5FZxEbpoyzRwdHQhWhIUTvcO/LkvA2p+V/
         8vgFaCDDYdDTCC941DdsPdKJsVbaPUt3iNXY64T3DMqvotyHcenbPO5UeeXKXHp35CaS
         QXUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784554991; x=1785159791;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zmBJ/0A84g3rungkV5GDtUzaTyuvksj0gerDJWlqPf4=;
        b=Qgr4yVm1IbuG6slUDPLqCvHzhVKrmM5T5Y461Aec3QGClT5AUT1ti8DzI+rKaAuk4d
         NhsqCZ1q/kBGyV3YCr9rpcV78Nj/ASF8CFPoHQgyqOeYyVE7pNkGVm1LvvHEREYnIuss
         FGMASEiUI7dXUOytM8UB+5Svnd4rMHw6xdS/+uqOtSipaQ6Yy+UqgRTkv01vUxqMriX4
         A6ybHh7WwMiFv9h+pnxXoD+T64A3lo/1VyTFgivkvZdBhnH8a+BLJvkH3sIKNByjLtrE
         aFe/I7B7ysphCXaW0Uam8cPU0N2xh0cLYQnmNSdoMjAr4DqliHWWwrmyIQTwlnPklVXl
         mr0w==
X-Forwarded-Encrypted: i=1; AHgh+Rr3ZbE8Ha4t7sN8EG2zaQpdEOmB73Vj1koKg7MMtTYgvDeYKE4HEY/98+6QOOfdsFP9sD8ztC4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcYuRWEfXvIm8KB3L39V+7dTu5XGblsgcSlhd/dwvzyLA42q80
	lxFTyknmDrGtdhJC5QDI1WUaOY+97Ug6HAJbMmftOjnZVmj6+MISu9XYBM2BhQqds7U=
X-Gm-Gg: AfdE7ckb1SWSe5uqV26uYuwLgpwSSSXtXm6bnlobjzf90T0c2NuxqdWG4Qp+4fph3SO
	StpHA45dw91w5gTrYNNzOzvm8L0izodx1THTrgCS7UcsLuXqrxIrXJX7tqcjmdqVvYMkQzIleDm
	I7EyAaYPrrvp8m5+4cjddTqnp/tb4GsKy+TjxCECMQ3+XQpaltvPQQ6Rm3lspYzvaR3v1/vEqII
	7M8Hk7ri10TlQ4xvwkwi15YMNCYf/d24FC5v7imCTLDBBjmE8+u5qbSDPvtFvs74dUAz309582q
	TTsuxgCcLmDPAOhkJWogT2lFLULyVu+rbCpDiG2hPLZ1wxwmgVExMfJtSC8Y7HTUbLrJ/CR+nqz
	ZNZIDQyJw2OqJd3Rqb5RA90dKLvpjMOV2tHpEHgBsW8nDcbX5c2CaZi0e1cc/8aODGjFAb3XzEu
	yXd1kqzPKJB+QPBCMWgRYJsD0cglSDNLcPLM9gK4Zu/3EhuoqpxyOm6oS1u3Sa8ShlgA==
X-Received: by 2002:a05:600c:4685:b0:495:3f99:849c with SMTP id 5b1f17b1804b1-4954a3f48ebmr182901205e9.15.1784554989689;
        Mon, 20 Jul 2026 06:43:09 -0700 (PDT)
Received: from localhost (p200300f65f47db048587886ecb5b26b2.dip0.t-ipconnect.de. [2003:f6:5f47:db04:8587:886e:cb5b:26b2])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4954a2e83ddsm273264985e9.10.2026.07.20.06.43.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 06:43:08 -0700 (PDT)
Date: Mon, 20 Jul 2026 15:43:07 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>, 
	Vincent Mailhol <mailhol@kernel.org>, Rob Herring <robh@kernel.org>
Cc: Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>, 
	linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net] can: flexcan: Fix probing for m68k/coldfire
Message-ID: <al4lxVud4_6NTZQG@monoceros>
References: <20260618140147.142489-2-u.kleine-koenig@baylibre.com>
 <akfoYuyHMAxIfalD@monoceros>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7gz5gbihnzriqixc"
Content-Disposition: inline
In-Reply-To: <akfoYuyHMAxIfalD@monoceros>


--7gz5gbihnzriqixc
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH net] can: flexcan: Fix probing for m68k/coldfire
MIME-Version: 1.0

Hello,

On Fri, Jul 03, 2026 at 06:53:16PM +0200, Uwe Kleine-K=F6nig (The Capable H=
ub) wrote:
> On Thu, Jun 18, 2026 at 04:01:47PM +0200, Uwe Kleine-K=F6nig (The Capable=
 Hub) wrote:
> > When determining the device details was reworked in commit 5e6c3454b405
> > ("net: can: Use device_get_match_data()") there was no replacement for
> > the previous handling of non-of instantiated devices via the device's
> > id_entry which then results in a NULL pointer exception. The only
> > in-tree provider of such a device is arch/m68k/coldfire/device.c.
> >=20
> > Given the id_table only contains a single entry just hardcode the result
> > of `platform_get_device_id(pdev)->driver_data` and drop the unused
> > assignment to .driver_data from the table.
> >=20
> > While touching the id table, drop the unusual comma after the terminator
> > entry.
> >=20
> > Fixes: 5e6c3454b405 ("net: can: Use device_get_match_data()")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Uwe Kleine-K=F6nig (The Capable Hub) <u.kleine-koenig@ba=
ylibre.com>
>=20
> Given this fixes a crash (NULL pointer exception), it would be great to
> get this applied. The issue is already old (Sept 2023, v6.8-rc1), so
> there is probably no urge to get this in before 7.2, but getting it into
> next and then 7.3-rc1 would be good.

This still stands. Marc, do you have this patch still on your radar?

Best regards
Uwe

--7gz5gbihnzriqixc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmpeJegACgkQj4D7WH0S
/k48MAf8CwYvCoFTxvTNVmeMwQ+UhSiB1fZhEmppRaXZ2vbqFGkPOjgM+F0G4QFS
Y/GxMzMygtEeCe/rv2ucw5+rB0pWJE7hoCmCsClXHTsMKzb8MPxZxVypHSVoRMlj
MVC+5Y0r/9ZrfW5W5iFV5Y43SzmDutjkvF8mbFI/1Zrs3n6/nH3mxNRjGL/1A5CA
oA0bOtkd6lOHVyU4s/lZFfji4Tg3Q0X9Fgs3tmA/5Ev82QhVnW3spANA/U7x9jhM
OzBD9sDszUbJFf0GdA3DG7jZ3dsePRePy7EfPs+rT1QHbxiLjFTcAY/CyyH07MMj
RgTX4AWpQlxwcMSuOeP7UvJmtyGjxQ==
=sovE
-----END PGP SIGNATURE-----

--7gz5gbihnzriqixc--
