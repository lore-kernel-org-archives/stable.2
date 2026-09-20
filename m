Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52CF03FF8B6
	for <stable@vger.kernel.org>; Sun, 20 Sep 2026 12:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789908086; cv=none; b=RvMwewrMkw7nuxEL9tzeYOeeTeij6SPVz7Oj0q1a76gLefGvsdp54EaYRjwxgFODo0G2YFvzHU0/f2ajJSIUknV608RI42Zzfp5C84G9AK6mIJ7ALU3iM7nBqr7NJeGm4eGnL1r9QVKI02NVmNXs81xNJ6qu8YE8zHs5v/2LwxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789908086; c=relaxed/simple;
	bh=FiDW52r4aEut1QWROMUkSg1UFsKkBZoECLAVKtOtqH4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lj5f2kPJLr6fdgjUzK3ts7Lw617i7AwL8nYpKbMlvaFFmsd7b3gpeL/yd0t4bafa0PN83ZmTFZmiQQOV/TvdQ5DLLxo6P9OtwBelKVEwjTUJDbvLUUouGLmLM/BLsA6Iha9SVKDuwLqggYuaYBHLthgJDjek+E5CVNQsbrfINFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OJUpBSV2; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OJUpBSV2"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-398b1e63c49so2340903a91.0
        for <stable@vger.kernel.org>; Sun, 20 Sep 2026 05:41:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789908070; x=1790512870; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=FShkQP9FjjcmWIMEBaHGEh9TKajc5Rm5deyrnT3Pixw=;
        b=OJUpBSV2n95S9Dw+mmXEdbD7Zt8lsbur7V3le+m1SiHRJQFv52xkpfDBLo1vQmb1is
         V+u9X3gqCZdd4P0SWnntKuhTgq/4BPVxrfOLKzplQeT0h7jRYH8moaWGGx6CEIiMRsyY
         VTNuA2oMtpWm5jVRlykEfhCFhPqOKvDBJMu3dvy/kz+NvOVyf55cS468NpHYh9WWRT9a
         BsfOlQRkKdXFBnVvK0D8qyDmLbXOiBkVNw8hfVcagVd7efn5MmJDB1OSDWN0thM6NwmR
         ZfgDzzqhRxS6Ys8rKzqiHXBLurUlmdT6xrQyPIOJFlPpLmL6lVjd7rTdVUZJqCWHZK7x
         LzVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789908070; x=1790512870;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FShkQP9FjjcmWIMEBaHGEh9TKajc5Rm5deyrnT3Pixw=;
        b=rF39sidh0yDjlNZgexvzolRFqs1N0kG3B1pVU+X4O1uXUXIxJUFpx/ksV9P4EiOcX8
         nGMZ1mq88BFUwJGYRL1Cjgmv17JgbPKwhtJYl4nVSo9YBqEgzzojt0NsAH3r6kdcRJJw
         MiI4QxHzxRvcGBKYKPzQTjClDveZKPDikx5hhjs26VlHuK0LLJWDbtsUjsggb14oVkIT
         /oYxrV8EE6UB9Y2jfm0YkwWk2dWz8Yi7BJ6qWkyUj7x6b9aMVfoNX5FAv329LmEQZcfj
         0CVW8CN3tFiu2y7pIDBl+5ctxUGwI+YCWIkCLW796mf/dUg9H8dtTGy/SRP1KizCfl8a
         T1JQ==
X-Forwarded-Encrypted: i=1; AKwUvByzK/9OM7pkdBtwGIDZb56qudzpshmtiFZ3jEfiwAFFakIMO8HKdMlJUrFSKEiWFkQLKD2OZAQ=@vger.kernel.org
X-Gm-Message-State: AFuF++mCjpfcp9vjrvylWBsI9OJwWyTfYGOp/g3m5sGAgdp6VBEhnTRs
	D5dDcjPOhskO9Is6+WXJQayqmNBvwiOX6riK+Usf6CHmjUpNYAHTioWz
X-Gm-Gg: AYBFou27XvM30HwTEy8Xn9iezV8RWvc5GMN3tMwVUcMHZ5ZuAx0g/WUkoUJAUK1rS5y
	dr0VMdAm5jZ6rdE5Wpgr9lxVXlzuwv4rGegToU1rX6IP+7pjUTJ42jCSjS/etdIj+4NQ/L5a0pu
	+/0pjd+hncmI1iKfW88OjdJd7Lwf34Jta3rYX8ioGQPOCBK/0xhBYgnWC0eg28EoOZKBerV06+I
	hAvCIN/5AhF3/gL61+aMQbZlXpbM8CMvK3wLbGVt2/fxHBeMZ+N4w+eqVYfNV8c7zaZJjFCJgA1
	KtTCTZNSKK0IUVqokg/GVEvmvjoAQAEg+pQdGVCEMUVv8HWxa+ByJyW63nTNEWca1C5ISg+qIun
	Z0KXg/q98TotI4rO1lAg7OJyVemaBlCUNAfT2X1RG2DwhTywWOCb/WUPfJOvmnyUO6IpU9OuK4U
	4AZAZKO55JOXCK1xSYJlQD54PUdxQZ9QQBmaWKuPA4e+hGY+gCnNdVnoKi67+Mkbbpag==
X-Received: by 2002:a17:90b:3952:b0:3a0:25f0:d89e with SMTP id 98e67ed59e1d1-3a025f0ddb8mr3886407a91.53.1789908069737;
        Sun, 20 Sep 2026 05:41:09 -0700 (PDT)
Received: from xiaowei ([2406:da18:1aa1:6600:7a60:aa58:4b0c:e1c0])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-144d53968afsm13173337c88.0.2026.09.20.05.41.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2026 05:41:09 -0700 (PDT)
Date: Sun, 20 Sep 2026 20:41:04 +0800
From: Kevin Hao <haokexin@gmail.com>
To: Sasha Levin <sashal@kernel.org>
Cc: kernelci-results@groups.io, stable@vger.kernel.org,
	KernelCI bot <bot@kernelci.org>
Subject: Re: [REGRESSION] =?utf-8?Q?stable-rc=2Flin?=
 =?utf-8?Q?ux-6=2E6=2Ey=3A_=28build=29in_expansion_of_macro_=E2=80=98conta?=
 =?utf-8?B?aW5lcl9vZuKAmQ==?= in drivers/net/ethernet/ti/cps...
Message-ID: <aq_UX31cS15phx6Z@xiaowei>
References: <178965354369.144182.3820631599752867786@kernelci.org>
 <2026-09-18-daily-reply-0013-re-cpsw-rx-mode-work@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="eLyoggJzZEbFl4F3"
Content-Disposition: inline
In-Reply-To: <2026-09-18-daily-reply-0013-re-cpsw-rx-mode-work@kernel.org>

--eLyoggJzZEbFl4F3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 18, 2026 at 03:45:40PM -0400, Sasha Levin wrote:
> > /tmp/kci/linux/drivers/net/ethernet/ti/cpsw.c:310:34: note: in expansio=
n of macro 'container_of'
> >   310 |         struct cpsw_priv *priv =3D container_of(work, struct cp=
sw_priv, rx_mode_work);
> > /tmp/kci/linux/include/linux/stddef.h:16:33: error: 'struct cpsw_priv' =
has no member named 'rx_mode_work'
>=20
> The queue took 0b8c878d1173 ("net: cpsw: Execute ndo_set_rx_mode callback=
 in a
> work queue") without its sibling c0b5dc73a38f ("net: cpsw_new: Execute
> ndo_set_rx_mode callback in a work queue"), which is the commit that adds
> rx_mode_work to struct cpsw_priv. It is dropped from 6.12, 6.6 and 5.15 n=
ow.
> Note that the cpsw.c half applies textually clean on all three trees on i=
ts own
> and only fails at compile.
>=20
> Kevin, could you send a backport of the pair for 6.12, 6.6 and 5.15?

Sure.

Thanks,
Kevin

> 6.6 and
> 5.15 have no disable_work_sync(), so those two need adapting. 6.1 and 5.1=
0 do
> not need it, the Fixes: commit 1767bb2d47b7 ("ipv6: mcast: Don't hold RTN=
L for
> IPV6_ADD_MEMBERSHIP and MCAST_JOIN_GROUP.") is not there.
>=20
> --=20
> Thanks,
> Sasha

--eLyoggJzZEbFl4F3
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEHc6qFoLCZqgJD98Zk1jtMN6usXEFAmqv1GAACgkQk1jtMN6u
sXEXgQgAk/ffYeqFykEIBlfaIf6P0udpvRcw3mdDbnMeWdlVcZC1cpdaejOII2zb
GnhDzAlkhPVnyNgRteMoAWLw/A9od13943nuS9yCNfmWuojRvHAG/Ke9I4S80rU0
ItedXhLS5FbLsa/i7joxYIUaHxovSHhFJmbGXdL2x0etybjsiqlPlvum6d4K6dtG
sqZ4MZtk/qD7GnZJGT1jP8adiMV2ENgTZEDh4MwiPijxYrZYIxgiBXzkntHDPr1G
FBWNbDuLdXBZspfDD6uVqcCvaK9f+Ttdiq6WD5o4xGfmteiZzi/4zl8u+hLBhfhZ
/ioM1sO8vq7cCLze+7jfe/wbaeatMQ==
=9nx1
-----END PGP SIGNATURE-----

--eLyoggJzZEbFl4F3--
