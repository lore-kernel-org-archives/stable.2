Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60F1049E5CD
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 16:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789143108; cv=none; b=SSRVXbiIywUL/vCBg2BQpvGm4IkPT45Sq65B2c2rJOP/rBdJIUNPopQwbZ3CwVy9rkWCJfAKjebDQ7k09k56J+J97lAFlJe5lUDQDzqnmepcTpXQ6zir212zpeofUuoaJfaJX2DTh3+u490gDD5WNBnnmzuKROQjyNLOsD1bbv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789143108; c=relaxed/simple;
	bh=9KC+h19QeQ0ZAIjwroejZmCB0hItZuK8z4JXahZWHzE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u4LRp76kBYwuPj58sNkoldgTLVgFrHlajNziIKjz3m75xIBqCxhf+CtA6VuCB3wO08x/pYxhScHMT9Ioc1/eg/8f4nPZGkeDZcuUiNW02gyo0sAC3Ows4Tr5Kh+UCKbFbdP3IfK4Omfy5Lz/NkKPQ6MMexHyFpU2+W6KDPMdpJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=WuWkToDm; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="WuWkToDm"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4956869750eso9914475e9.2
        for <stable@vger.kernel.org>; Fri, 11 Sep 2026 09:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1789143104; x=1789747904; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9KC+h19QeQ0ZAIjwroejZmCB0hItZuK8z4JXahZWHzE=;
        b=WuWkToDm+Tgtab3HmqyL+TuySviu3lJ2ykp/qRvVUOtqFHW4CebAqQT4V1hSa6u2LY
         5CreKmfv9iv9xPaWFnH0siWe77SEisvOO7oLGTNpwiWw81mfRQkdPAeRiq7LVKS2Ml07
         3aM/E0MvLtuhE0fgE6Yb7ondVR83+QLgHqUzbFFcVIyJiBSRP6Ky5Jc6fEOzQQ+0FsbQ
         JW4/P33Cp02I32IRRHuTNPqy24pcHkLmF3KtlTwRL1whTwc5vaQ+9m1Kgldox2aEzMNH
         dIVP36VA4Q7bowUDCuXVLeSw5f6qiBtvGWdrEpFFL+SvCeoj4q4gVaH5Q2+WQx4gcywV
         VgOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789143104; x=1789747904;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9KC+h19QeQ0ZAIjwroejZmCB0hItZuK8z4JXahZWHzE=;
        b=kVt7AwaKerx9t6odKVVcRJXa/3QDmkTVRzqwsUMnFkaeBFAbh9DmovWUzxpXQD7C9J
         rRQUcUUTUduKw+Flhv2xVQ5/4qy3ds9bVef7eF3UZLl8GveJaB1rspz1Mk0tZuyYjWYZ
         F1olCAuGQOCEy9r6MfBwuD0sZggQa2z/SHHantYyxsoe49TKa3Xk4Hd56RGwkHbaJQ7a
         MAP1AEj7LELO2GbObO55kgJhrc6d9lEGe3+4rxluIXJ3Z7vbEJxaF/weVt83rlqXVZHX
         UxzMXodZ5NH2/XQzFn1PQpX9CNEjopH0Rms3ljPGNdK/yr7EcZd+6NsrSza6L6wZALnk
         k+mg==
X-Forwarded-Encrypted: i=1; AKwUvBxtDYTbq7NRMbAeyEaEr3BKcMsI+xzKHu634kjKrZRs8D4Lf2FtQfWBe69CPv8lrzu6xQydJh4=@vger.kernel.org
X-Gm-Message-State: AFuF++n1Zfjbk2M2MlSHwMvicfeJiOaIv1VifTIlnxfy3aPgT8pzrVUl
	dgHejisxugGsWxRsxthGt1q+JTRAJbVzuJ2XiPyXV00eJkvOpWaNvEUBhO3ATdyHMBA=
X-Gm-Gg: AYBFou1sJYdJi098JAP9q6nw3QnW3OtHtlsRMbS64SEDfhXyOXQW8mnw/OVILg1TYJ/
	CQIcB0Lt+RVC1SgxwjQvqdnTn3uXpW0NoJOYC2a0++mRitlL6ADQRmUbOmdTorY0/027bgzCUhU
	dXhRs56ZGlw3VglmKZQvEYRtbHhQM+xjDdalLLNPEIEFb3O2Xi4SiJu6tve7SjmGmV1sPOLyyo2
	DPVtRi5NXmWU4R9QH9lhg0bSWSsQjd5DDrsIG4NyFONkEufey5rGTDQmgc/afXCqON8bOwgEE7H
	RHGuCTd3ZUvhcU5qIQ/Xv4ylvuynVYcF9Qi9UHhsDBH0oU4YKsagYq/jwoRUAJxUTax/kKEh8tg
	mtSvc7Meind1Y3bRPg1UNU/nIyJcvSxotup7/iNJjbjoKTXN8RUKxiFKWxaaNTEtFFzbLCJWkIi
	rLllhhhV1fsXNFqTq0SIbiGhFU1R+CnfRI3SRIMTnCRPJo+j9wHjxFhIMgxaV0usPd08Ax/S38t
	Q==
X-Received: by 2002:a05:600c:45d5:b0:49c:fa20:cbfc with SMTP id 5b1f17b1804b1-49e619c18c1mr59656705e9.19.1789143104418;
        Fri, 11 Sep 2026 09:11:44 -0700 (PDT)
Received: from localhost.localdomain ([2001:af0:8000:1409:193:86:92:181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49d26c1bc5fsm159143865e9.3.2026.09.11.09.11.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 09:11:44 -0700 (PDT)
Date: Fri, 11 Sep 2026 18:11:42 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Noah Feldt <noah@feldt.systems>
Cc: Tejun Heo <tj@kernel.org>, cgroups@vger.kernel.org, 
	linux-kernel@vger.kernel.org, N.Feldt@mittwald.de, carnil@debian.org, dschatzberg@meta.com, 
	hannes@cmpxchg.org, peterz@infradead.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] cgroup: Avoid iteration of dying tasks with zero
 refcount
Message-ID: <aqQlowpkYrTaVmid@localhost.localdomain>
References: <20260907192723.72167-1-noah@feldt.systems>
 <aqAtv3WVn51LN3E8@localhost.localdomain>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="vqaqn3dazvpkwhgu"
Content-Disposition: inline
In-Reply-To: <aqAtv3WVn51LN3E8@localhost.localdomain>


--vqaqn3dazvpkwhgu
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2] cgroup: Avoid iteration of dying tasks with zero
 refcount
MIME-Version: 1.0

On Tue, Sep 08, 2026 at 05:55:45PM +0200, Michal Koutn=FD <mkoutny@suse.com=
> wrote:
> Though, the fix loses a bit of elegance. Hm, thinking...

So, it occurs to me that the ->live based predicate from v2 might break
CSS_TASK_ITER_WITH_DEAD callers (zombies they asked for would be
skipped).
We need to distinguish between (both on dying_tasks list):
- regular zombies waiting to be reaped and
- RCU remnant tasks that are going to be free'd.
IIUC these two are split on the ->usage count. (Correct me if I'm
wrong.)

I'm starting to like the tryget_task_struct() approach from v1 again.

Michal

--vqaqn3dazvpkwhgu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCaqQoOhsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMiwyLDIACgkQfj0C55Tb+Ai4DQEAgpiBFl5EmgRYQ2x8tv4Y
gyHzyg0fU1nthPmlt+skLTkA/0HFH/C6Bws9kXraWbS2BO4rZ6+N2FJFygphH/o9
QkYI
=7ubW
-----END PGP SIGNATURE-----

--vqaqn3dazvpkwhgu--
