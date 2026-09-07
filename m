Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5559F4CA294
	for <stable@vger.kernel.org>; Mon,  7 Sep 2026 17:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788800835; cv=none; b=RJ7akmJsHlR1jKLefU5G4qvKqJQcuGLiCW25Z12qhrVeaCRjylQXSWqvXFu6LPH8PDa3lYxiKk9iefRfBIz1z+C7pZ7eIiTLACIwpTfXIGimFj8YzmqTYAx5hkLyyvg9RtoEoQ7W4FCxD1/R16ysbrTiwtDz69ffkJS7FKH28Ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788800835; c=relaxed/simple;
	bh=hF56qCTi739DT8nr2jvT+BipglmVctIpYXsJfZQZh8Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m1wTmAVlILwpUH0HUjRezwN8SrFiz3K+Wm42pg6Pv/vA6WIfMmRG5/fK469cO5PSQEvp/fJX/ya652qll0YrzNqimHt3dgi40lN+BWq4sVPDwgk7DbBOwW7Xbb7HerVaiA46U7wk9LvagCFI2EWYnUUM4Ohja3/cceiiYrysZHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=KlDeTZIn; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="KlDeTZIn"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-49b8687630fso32407755e9.3
        for <stable@vger.kernel.org>; Mon, 07 Sep 2026 10:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1788800830; x=1789405630; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hF56qCTi739DT8nr2jvT+BipglmVctIpYXsJfZQZh8Y=;
        b=KlDeTZInmXjx0/cNo5crrqemQ4lLhw/W/OB2hDD4QeSL/gnNNuH9Ykd38YellQT0cC
         mXqhSfU9Uhz8TxggOtWEtRphS2FrLzIe5KsNaogzlg41NMFjqtUT697ipFXCE35T6AM8
         t4Y60S3HXDGKSL+6wNh/n9B2VPpdeYsrxg2cadTVlQv00AM5l68JXMEJh1VMNTrqb9ms
         YUtsuW6h+GGRqH0ahspEb+7gNLhdgOBKeb+YlyIMajeLb0iRRp+r+Rm1j8irjWJS/wsA
         +1wMAUGGqaK9+r9TZ4lZ4fvTyN3m87ZvKdW/hHDKlRWd0+GpSuBWVMwyKCg3gUnwo7zw
         m42g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788800830; x=1789405630;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hF56qCTi739DT8nr2jvT+BipglmVctIpYXsJfZQZh8Y=;
        b=mMWK8f3rB5N7ZdVEG0mwbyTeU5VAyDNJQ58ppG6qXiW3P7azFBruN7eTRYlIfazQa6
         nv5lhNlQ9cw0X/PM+y7o8/mKqr2IqicBJe35WLbn4ixK0v7H4mzeHomwTaB3uq+FMjU7
         A8aR9HauMLD+Jr9Y9Cd/E/wBQKwhGwr9I/g5oMGlSm1DmsdJDn64Zf669A3SDpMEcSHh
         KhFPiY7sod19XzlCMyc5HwCHZbN5s7hU0FuL+fJUEZfhfNCrzBb+1HDpiTYsmebE6j0+
         24Mn+Vb/6pkW4l8E38kzqZuOcyTBYulqjZkCC3LG/PT/MLbIXUxweLfvOEKOQob4+4vm
         +cXA==
X-Forwarded-Encrypted: i=1; AKwUvBwwU82X1Vr5FjHOtvKVKYVinO1p3KeYyeEhfGJhP4CoWMCUIC9RwAmfzCqBK3QzzT2jKzZi/zY=@vger.kernel.org
X-Gm-Message-State: AFuF++lfVIv/J24z75gTeXpM3AZmB4vcA+KkgzulzqpIcG1YiINCmdGH
	1JQXT76iOYxStgF0C7avxZdeCB2AJ2gZpSWFqod8bfqLJ27r+74E6AwU/rOn5v3efuo=
X-Gm-Gg: AYBFou0QP3t7XWU2kmQxKpda5k+eU//5upD1vJxynZOnduIPUNUv2WdT04NYYyK+xIt
	3QLiK+u5Ah4/FIFkXX/TDkFr+QNdJ9xMMLdycNr97OwriuCP2O6yp03Qb0g5CYASpwzwvTqH7mU
	MbrpaQ67lfI0uHIeisKKcWo//ZKX6rY3/h3t4KLUOUaua2yZAJhmzFA6tQMC8wdhYQro9s36TqD
	y0J2YnCVGWcRp63QG3IwsHMzGxR3MsfMqIxWMpDvYS1kuVQgZooA4yRTNALGMk7LF9bCqeS0D/a
	RawInZtTCCZtrloaC8fOyczpMXviZcKI1SxgXyhZV3yiUnuXCtTtOTtRdRxvqRhrYZD+mRNWffO
	wh1MnGjHE8gaylJYEjdISPCvL1XowcG3d3DGmCE5URWTb5fkuBxnBPogneCwVHYjzX7k0u8A286
	go+eJcotjcP+sRa7pPTsRFPD1OB8oA2l3htRV0bViOmPKfupN31Ulj80etjjLoncs=
X-Received: by 2002:a05:600c:3b99:b0:499:bf0e:95c8 with SMTP id 5b1f17b1804b1-49cf81fb72amr256160685e9.1.1788800829897;
        Mon, 07 Sep 2026 10:07:09 -0700 (PDT)
Received: from localhost.localdomain ([2001:af0:8000:1409:193:86:92:181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49d15918fb3sm25060275e9.0.2026.09.07.10.07.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 10:07:09 -0700 (PDT)
Date: Mon, 7 Sep 2026 19:07:07 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Tejun Heo <tj@kernel.org>, cgroups@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Cc: Dan Schatzberg <dschatzberg@meta.com>, 
	Peter Zijlstra <peterz@infradead.org>, stable@vger.kernel.org, Noah Elias Feldt <N.Feldt@mittwald.de>, 
	Salvatore Bonaccorso <carnil@debian.org>, Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [PATCH v2] cgroup: Avoid iteration of dying tasks with zero
 refcount
Message-ID: <ap7u0VaI7JVAIq7K@localhost.localdomain>
References: <20260907170345.45316-1-mkoutny@suse.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="jtnc6cwmahlcj6p2"
Content-Disposition: inline
In-Reply-To: <20260907170345.45316-1-mkoutny@suse.com>


--jtnc6cwmahlcj6p2
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2] cgroup: Avoid iteration of dying tasks with zero
 refcount
MIME-Version: 1.0

On Mon, Sep 07, 2026 at 07:03:44PM +0200, Michal Koutn=FD <mkoutny@suse.com=
> wrote:
> cgroup_task_release() is not synced via css_set_lock hence the race
> possibility. (I'm not 100% convinced about this LLM-assisted
> interleaving, multiple css_task_iter_next() calls may be involved with
> css_set_lock released.)

This paragraph should be editted out too because of

> Changes from v1 (https://lore.kernel.org/r/20260902161653.1051794-1-mkout=
ny@suse.com)
> - add css_set_lock release to sequence diagram

(Sorry for multi-messaging.)

Michal

--jtnc6cwmahlcj6p2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCap7vNxsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMiwyLDIACgkQfj0C55Tb+AhioQEAmJhHHhGjIo7Om5IAREUA
o0BeFqPGwj+N8w9xPavgGs0BAJ2+iIXGFwdVXInVdS+Qs/Dz2jNb/b3impZkCl5P
p/MF
=DHgd
-----END PGP SIGNATURE-----

--jtnc6cwmahlcj6p2--
