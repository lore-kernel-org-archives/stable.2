Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E28451A681C
	for <stable@vger.kernel.org>; Mon, 21 Sep 2026 01:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789952935; cv=none; b=YvrLh1JG4olceTiusA/Co4TRxUBtorq/kDIFMo145uaa20EPy03KQcuwXAJBxMFVoas4gCPRwC70r1i1waYrbr5yaOgDt8fT/QGf306nO67zh1ZWPa5lcAB8iQ2m43WKAhzHnunu4YjqoN2FaH53TR4GaoW8F8N2ShqBtZVdnzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789952935; c=relaxed/simple;
	bh=1AWfg/RsvZy+Zxv8nWJwTgfp3smx0MABeryhzY0yBTI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nffWTac1CrgslxKYTslH3C891147QidteGosFQDyAKv0f/A+Ad2YJEnYyev3VKDtHfI5DayTRz5ecqLyAMsa3SQH6SG5xLQ9B4RvyrV2Azjs2D9vNDUVMxMaZNdq5tFLZ6upkaKBEA0K8UPEbp6WhmEd7KMyC6Ox3hfH9DEophc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BStrSG7a; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BStrSG7a"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-396ccb1a990so2162587a91.3
        for <stable@vger.kernel.org>; Sun, 20 Sep 2026 18:08:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789952933; x=1790557733; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1AWfg/RsvZy+Zxv8nWJwTgfp3smx0MABeryhzY0yBTI=;
        b=BStrSG7aFqy1AlNbhvZKI20VP35Yo75ORzTCAYqpJsPuqiT+DnVsFZRlYdECxQEsvb
         Nhw3hxkQ2SrD4wCjRLrK8vmq1mrGVQ0ghiUFVDhNYHZzTAduayvj1xMf1VZYgqulSs1a
         UL3hYfImZXpC36U9PObARBAaZu37CwXVa4HF1hPwhsznmvmRphuM9Q3+OhuLhjVW4nHH
         6o8ni6IZNU4gxYXghMutzxnV0X+mSVJiYhVBBzsKDWdcqz4PgONeTt5+MW9oRFLZNYX5
         nJ9nyEsDGEJbFpxot6vUspuPlZcaeOGA2q/OBHtE7ejgXNJBr3poOG+BVRgbQpkAtcwB
         QdwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789952933; x=1790557733;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1AWfg/RsvZy+Zxv8nWJwTgfp3smx0MABeryhzY0yBTI=;
        b=vkStBaE/JDBU3VaQShaCVovlQBtj1MRkpD243i62cnQciHald+SFTvROtQ9o22PQpI
         94WC8vKNoXtL54gJ3nEYFC4zcdxq7cXW+TgBkukfknzR3X77xB76XxJyqb6MaCWDv2+8
         GjJfiWVI9w6+dsQfgNIjZqavx2MGegytn4qWDTK6w2jVCDtnopV816Ks53GIVZq/yrLa
         651/ItwtJFXUlx7psEEI9Y9bacPMGTb1eAAbpr1Gv0sgHFNW/NRLY1SS79ycFbghTZMS
         iuxW+cNdB88sQdgsWWDznM7crmNCkMrQYEDTHeN0AxigximM8xI15631aYbh6b0ELHe6
         WA0g==
X-Gm-Message-State: AFuF++lvXShZCdPl7YIeUT1qATQmP8VKSllFjyKULf69GudsZdxmcjmk
	y8DI3hmGpkzK6AfRIojBzFz+f6AN0Zxzqw5aKQfkUTNf9G/qyTWOuMfZ
X-Gm-Gg: AYBFou3tY0Bv6h+Ag/d+wMKZnyUJhsNgWmGbh9tDsM7UcI54RksG0rYoTRul3YL8QQK
	viTg/jdPl2Z54uM/RLSOMyj2aqECA8WLVFv+x2AlkXzPPvvUdgFOD2fMUJN2dfQFb1LcTiwPqHt
	B+Skq6q1Q+s6ffO9boZz+IqbJirIzqEh/4eeq5MgAWKNkytbq0UqWOCNpiYQP+VJCSrB4EbGij0
	oGFwH0GUdbECaJZuQJcrN8X49U/VUhCcKxP5gRk+x2+/j1Fui0mlvHWtqQhEziLq9S8KfH4xEd7
	9LZmkpUwDTSGtxXxkxIgFEEtoNUCKWnkZqOmAclA587RK6BQbZkv0O2l9VD941cC4XYtMuP4A2J
	ug6Zo5wW5UDgHe62ZVyPPDcFoMT/fNXd2P30N6lpNhLlxLWGiI9UWKrEXK1FVsraznDlEF3vj2U
	yFBWb+JOSmxv/2wT4dbRjs1cBnQrxRGwHNvplr7mlwCTpAWO1hzQOO3YNOPkn+iFfC3w==
X-Received: by 2002:a17:90a:38a5:b0:39e:6ec6:f4d0 with SMTP id 98e67ed59e1d1-39e6ec70cf9mr5218616a91.8.1789952932855;
        Sun, 20 Sep 2026 18:08:52 -0700 (PDT)
Received: from xiaowei ([2406:da18:1aa1:6600:7a60:aa58:4b0c:e1c0])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-144e16a7f71sm5345934c88.8.2026.09.20.18.08.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2026 18:08:52 -0700 (PDT)
Date: Mon, 21 Sep 2026 09:08:46 +0800
From: Kevin Hao <haokexin@gmail.com>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH 6.12.y 0/2] Porting two fixes for the cpsw Ethernet
 driver to the v6.12.y stable kernel
Message-ID: <arCDnvm_wTpdYF0M@xiaowei>
References: <20260920-v6-12-cpsw-v1-0-b8490c4ef019@gmail.com>
 <2026-09-20-daily-reply-0005-re-cpsw-rx-mode-work-6-12@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="YqyfBPYSKkEoqpe6"
Content-Disposition: inline
In-Reply-To: <2026-09-20-daily-reply-0005-re-cpsw-rx-mode-work-6-12@kernel.org>

--YqyfBPYSKkEoqpe6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 20, 2026 at 01:50:37PM -0400, Sasha Levin wrote:
> > As requested by Sasha, both commits are now being ported together to th=
e v6.12,
> > v6.6, and v5.15 stable kernels. The two patches apply cleanly to v6.12.=
y.
>=20
> Queued the series for 6.12, thanks.
>=20
> 6.6 and 5.15 still need their own versions. Neither tree has
> disable_work_sync(), so the teardown in cpsw_unregister_ports() needs
> adapting rather than a straight port. Could you send those when you get
> a chance?

I sent the v5.15, v6.6, and v6.12 versions together at the same time.

Thanks,
Kevin

--YqyfBPYSKkEoqpe6
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEHc6qFoLCZqgJD98Zk1jtMN6usXEFAmqwg54ACgkQk1jtMN6u
sXFtXAgAjB0hQ9yXf6uMw4oYe9fJ6Xr8fh7NWGAvyY0GxOQcbZmIaA5k7QC/dV7O
AxIsVWDlRjKvTKAARhQu+fCdDexANDfJxSWoXGYz0/t7hsf4jqNYZpZkIAHYOX5e
vn/Y9hNN0qJHO0gThjbv2fnYsDf8AuGHWZZm8EqB4nFqfNTglxcmNvzLfaTVWACU
pTs1J+rNX+686xysqTrFs+LWoN0Q9D9ASTNadN6h0iM8Dl3gwYay5klOsZuiNBwM
jiH3i4DAKLo1rVwrNNRm3Erepfhh3h4QwlL9t3+eeWvrWPwfHy7dVtkLCCP2J4vZ
ThImC1d0CppFuAcrb0ciWi7bKsgugA==
=Sbzl
-----END PGP SIGNATURE-----

--YqyfBPYSKkEoqpe6--
