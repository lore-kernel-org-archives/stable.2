Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.227.8
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793422162;
	b=sXt+DR1nnUqO5Y1na2XPkbhBSLa39WmZpxS/k5Pzv0QHCccGlsd+jwKaumx0oW3I82u3
	 oumWgMB4AC6ubECYc2VW9r82ZG914gbko/PKGRrMA9vkr3bNF5NNQDWwomO5Qx5HEhsh9
	 nL0jnezXyB26U7FgeoRZ17lokZFspArJj59J9QlJ72mgiEtsPpegP6rPY1lLDK9IRmUf4
	 4tT8DTV2lCX/WOiAXuCfmypz1ch1swg5dv4hJcHcYVO+H/QgHmDjumdUWX7AfI7QQr2q+
	 7iA4JWuryc9eu/7biVxpkJXCyUS9UD1b9KwNbS4BE6ktNvD1Z+azJ8UAHHxKXEf9mmA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793422162;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=DFy0aXOcH5qGYelFMWeP0BXiiUrKikgkI3RC4XhUa28=;
	b=ciAF8JpmYAalaWPUzXLWBwNGrhXiIdYVawMnhm7B8u4dbXwLTiUj4nYpvHYAtH1VDMnV
	 wJpVHvde8TW496/5UAJJ5OFXndk3nSd+hPFNYm+49cB1WMr5lg/Vh5JyIVslVeUaChHrM
	 fxncBvlhtPqTnF+fOH85CjaDPXGMI9n46DrUh8d3zk4Q3kwW/pHGvV7YwvwLy4uPn1dlJ
	 em9jU0TKg0VTVBYrAocXztqf8oBrFEgucZWTpzyYq7X6KbLqWSypY4crGpaQ4u21/W/Tr
	 In/rRAdJ1nvlk5PL7N6ZaUkOp3bRXForS3lUxou9PsGzT/KE13dqBLHxf4sAxxaIUbg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xfBSgSCE;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.227.8
Received: from mail-vs2-f8.google.com (mail-vs2-f8.google.com [74.125.227.8])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9F99606A31C
	for <stable@vger.kernel.org>; Sat, 31 Oct 2026 04:49:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C9F99606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xfBSgSCE
Received: by mail-vs2-f8.google.com with SMTP id ada2fe7eead31-7cc2c327e1fso283689137.0
        for <stable@vger.kernel.org>; Fri, 30 Oct 2026 21:49:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793422161; cv=none;
        d=google.com; s=arc-20260327;
        b=HnXyO0nNSEf+pK5DxH3O4z0rN2wT+piFfI8wLAkdnAm5gfbSNe2tgvxXlERsfgomok
         OZWEPU1EFBfA6tVp4KnVOoZHzNskgCSHNDGJ14bjcArTaQqcjIEjEup6LqKffj+vSzBf
         hKGiXlqDlN0PRh0cWLaahHvHBcd6zmxjfIbOGyA+Ia2Zdu9m3uuI0Z3UyTiz2r4ALFrK
         F/c0L+nbEVJCTCr/42hYUHAvFQ45BqHMfPkpYGh9dIOx9rD/Exz4p/2TmRcucdlhr44e
         up+38oBwdNpTjBJ8ac1+N9Y1Vgp2oVxzN2sxEAzHGJBPhTq/15LnsEII/DzbrdRnHwen
         BonQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=DFy0aXOcH5qGYelFMWeP0BXiiUrKikgkI3RC4XhUa28=;
        fh=jTom+hmHd3H5hRIkHcdEsciTMyyzoOJm2B1yqaeSTRg=;
        b=SbsmK9NQlZ4E8qmPIt52DZdPpr473WS/himhs0VbLdZRTgif6cB95hIR7EGWgc307L
         37neR3DX+BSCseO/oH5mrKTE5W8omieprbEs6VFi5puxYN8TlKZGVtj4oatDWXkHB7HD
         TFVduEP2t/fTsUY7c/pT0OPZJiNcLEXIdWB78zkgphTSlVFmDX1dl6SrCNav3R1TFP35
         dDiRA6GchVABa4cFFZ8AxJ/IPl/WZtruPc47/ZFQLkJhlRJ9SkAToCiXuI7sME2JblAr
         Gppabvxaep/FFpRsUzgan0KiotnOZYZiDRuylQPSa3AIJeMRuzyh516asoqq6/bX+/Hb
         3Ggg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793422161; x=1794026961; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=DFy0aXOcH5qGYelFMWeP0BXiiUrKikgkI3RC4XhUa28=;
        b=xfBSgSCEWJzIq7AjGQNCQPuTQvYK9qaFK9vqMVQWIAIMv39PJy/essix3RXjual/6v
         Y8dbuZiPFSm1jVVOKX5CNi8r1q2aBVTe0QdmS9cvpBkLQuZbERj1Ork6wSqcNQbh1wbC
         rzjz6sc7IGnuv3LGlNMD3FOBjyrnRL8ma9bHG+a3/mihH1wtmgYJap54Dol9LO5qFljY
         ENzU8SACdZFhayVjas109bcVz2o/g47bUZ2M14spABocCEBJ00nuckG7kn4YxoCGAXYw
         x+HC1hxg10v1kAz6hB37Yf1/HHCcpDCfoNxTKzY30aMk1V5ze2Sg9djLqmaByVCbtzt3
         hHbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793422161; x=1794026961;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DFy0aXOcH5qGYelFMWeP0BXiiUrKikgkI3RC4XhUa28=;
        b=kncw8H0YuNzmumHtawZRE2vVF32WUzfddkB/0uV4xN+Q8UMB6Y/cAFEn1nGKAVQj9X
         HdTqXoyn0GEQGwackU4Fxe607jCIvYxDLoTb8ztLGZVIKJNNxKTRkzNBe2yWghfMV6Gm
         fs7L/43CiITu+ZVy2+vG85jSe2WwoELE4Wl8EdNoPO66iOv00K+4Wn5mok1L1k4dyBf6
         SV2BGv4mL6omvCYxKpEaBwyEa5N3BA8rfJeCG/U7fGiaPVW6R4Mylkf9TsxfdVmWFXxu
         P8IX9y8OS5yXsLS9+oAT+cP9irYOYhcP+n8CjU7SAcnoeOJLFFjSIkQU2bS5NcW4XocB
         mnAQ==
X-Forwarded-Encrypted: i=1; AKwUvBxQShD/Bjg3lxYvBF4WNBmYlAvxsDXS5TE/2qOXO1QZz6uQJUmgTMPamUx7+Cr1gVrBPIHtJdc=@vger.kernel.org
X-Gm-Message-State: AFq9FYJXCEB8p2qf7osL6/g0rB6WlYAy2eI1qF3w9K0YTfB3cdnzLB5N
	t5inKlOVi8avjU3BML4XH5GwJ0siKzZmKBy1me81BH3QRx7HwyP1G4EHLydWdNPZOiM1EgHpfFh
	i3D4S1wXsl5XDpm2jhnvm7zeJ37UC3g==
X-Gm-Gg: AYBFou3EvJcVThUlEdmkM9t/0zoc2RDSgdY4yWQbsQQkLiQBSKgjhDOTJRwyZl8qz8r
	5Lt27YDStVJh3BuBiGi2SWKoXXvrBYDiC0gY+5XFtkVsIsiwiEjl05rutFwnGKNNi0oNhku63iX
	Lw+coPrMm02olSupw2oJqPsowv1/Mc7415MDXK74kLkhHTs/3y57UibHl8wo91lyF733Uc+w/1P
	ds8qU2gpjKJ3tnDbXltE5NQ5NrBfE4Fk8qUpAgasLdl0ZzExIdEIa14BQC1gXb67T431JQ5Am3R
	UuOaMQOJlpLGoYoSaFuKnLq+TmENLfxhY8yu965EVnYpbec+QBQYCQEmv20uJwOYeOpxzD9XROX
	RPdCWkvl4gh36ym6waTg2J6x2Cz7BkbzhQL/DJQGZ7EwrBoJsrYQNFilJz9FbmVVDVtrD
X-Received: by 2002:a05:6102:5106:b0:7c1:e804:3c91 with SMTP id
 ada2fe7eead31-7d072c398bdmr1240318137.8.1793422160846; Fri, 30 Oct 2026
 21:49:20 -0700 (PDT)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261030173930.40948-1-permissiontogallop@gmail.com> <auTfZL8RjQqT8uiW@kernel.org>
In-Reply-To: <auTfZL8RjQqT8uiW@kernel.org>
From: Gallop Permission <permissiontogallop@gmail.com>
Date: Sat, 31 Oct 2026 10:10:36 +0530
X-Gm-Features: AclHuK-FdSUYVJnYySxi8P-Zi8EKZ3CeyjPrglCec33fiP5ieEc_Yb5Fdpv6Yas
Message-ID: <CAMdFwLH_cg_=cLaL-j2B_0kzAEof89r13=cYR--hgeLxC7Bubw@mail.gmail.com>
Subject: Re: [PATCH] KEYS: request_key: enforce keyring restrictions on
 constructed keys
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: keyrings@vger.kernel.org, David Howells <dhowells@redhat.com>, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Jarkko

1. you asked: What does "key becoming positive" mean here broken down?
    Here key becoming positive=E2=80=9D means the transition from
KEY_IS_UNINSTANTIATED to KEY_IS_POSITIVE
    after the type=E2=80=99s instantiate() succeeded and the payload is pre=
sent.

2. And on the second para
    For an unrestricted destination, construct_alloc_key() still
pre-links the under-construction key,
    so concurrent request_key() calls for the same type/description
find it and wait instead of
    starting another helper. That visibility is what deduplicates construct=
ion.

    For a restricted destination, the patch skips that provisional
link until the key has been
    constructed and checked. A concurrent request for the same key may
therefore fail to find
    the in-progress key and start a second helper. The keyring still
holds at most one link for
    a given type/description; each result is offered through
key_link(), and only a key accepted by
    the restriction is cached. This is a duplicate-work tradeoff, not
duplicate links in the keyring.

    KEY_ALLOC_BYPASS_RESTRICTION callers are excluded from the deferral,
    they keep the existing provisional-link behavior and bypass the
restriction check as before.

3. the rationale for the code change will be to stop an un priviledge
actor with write access to
a restricted keyring from bypassing the restriction checks.

As for the points raised by sashiko ai (concerning
potential outer-search bypasses in request_key_and_link)
im going to need some more time to verify them and fold any necessary
fixes for v2.

Best regards,
Anvik


On Fri, 30 Oct 2026 at 23:48, Jarkko Sakkinen <jarkko@kernel.org> wrote:
>
> On Fri, Oct 30, 2026 at 11:09:30PM +0530, Anvik Loitongbam wrote:
> > construct_alloc_key() pre-links a newly allocated key into the destinat=
ion
> > keyring with __key_link(), bypassing __key_link_check_restriction(). If
> > the request-key helper instantiates the key with ringid 0 (or any keyri=
ng
> > other than the restricted destination), the key becomes positive while =
the
> > provisional link in a restricted keyring remains, so the restriction ne=
ver
> > sees the payload, potentially resulting in a policy violation, where a
> > user with write access can inject keys which are restricted on the rest=
ricted
> > keyring.
>
> What does "key becoming positive" mean here broken down?
>
> Also I have really hard time on reading the second paragrah as it is,
> let me count, over five lines long. I honestly cannot say that I
> understood what I read. I tried it three times.
>
> If you understand your fix, you should be able to nail it.
>
> >
> > Restricted destinations lose the provisional-link deduplication while t=
he
> > key is being constructed. Callers that pass
> > KEY_ALLOC_BYPASS_RESTRICTION keep the existing provisional-link behavio=
r.
>
> The second paragraph should be reformatted and there is no rationale
> or descriptio for the code change.
>
> Br, Jarkko
