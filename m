Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63892376A1C
	for <stable@vger.kernel.org>; Fri, 12 Jun 2026 13:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781272699; cv=pass; b=KHgRH0HMh95I4knRk/MBnhJBAqfDTe4P5EfGXwUBgfNppvkb/mrU/Z1gZhVjlxckSz8q+z9rz3DzNnBUfLjKsikJnOCLXb5KcT+sSnTkwpZIc9n5KX894OkjPWnAJ0jPBPLSa/wo/tz150/QirzqSs+/LiW15XG+wUZKOGRyp/0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781272699; c=relaxed/simple;
	bh=7nkmyuk+mVPRHuMjba29kjsd8mvWEce3DORmTPAygTo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uhwTFYAOun5BgYu3DdB3MrX6Q1yPKUNDWHHm1IUFEifNjtgQHZ/33pyQ9iTBPMJ8gIgIwjECApfhpYG6fGOoxUQvVPPNo3waVY0gSxiPM7nG0J9GebjrEaxENjGzfP0mc6UhCZ0MJMds18lkhz7OEsj99v2LlBT6bCujer6/qkc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Uvzkse3t; arc=pass smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uvzkse3t"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-842273a2c4dso726262b3a.3
        for <stable@vger.kernel.org>; Fri, 12 Jun 2026 06:58:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781272695; cv=none;
        d=google.com; s=arc-20240605;
        b=ZmV4a5FLRxmAxJhsb6k9sE/Lqdgf1SCOG8J/Mdlbem86weL4Xb3jwizQAXNlRjyayS
         xyQ6F327XXZ0WUDAPdqFzA67uC0+jzz0ZUS2+2J44oXspVARb+TXGaGQrssOxPHEF8pH
         oSd+10YFOWjTFQv56hb9Ror05mnzqpiXE3GAQZM8WIjGDQBtMELbcRNcn75Y0j9W32Gy
         6n101E6ZvHN76XH6QCVcnSSlv7MmVtyIIzefiu4O7wuwvYKWS9wvDp6MbdYBsUcPu1VK
         brj6JScB7FEDKMoF8GvIceW6K54MeeBGRerXTQUfppt07b9+pSezH7qT7mGihawXIxfL
         0SpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=39JwziAVEtMY+TsSm//5hIngMfgIk9ci79M8m9H/nTI=;
        fh=o0fl3Bh83bvlfg31i43fLGr86aw86whPwIkARPnSsF4=;
        b=lZD1HSDWK2eNlvi6R9VV1J6GHSL8JZSTmVSMQkLLG/eys/AG9b1IFo+/Tf87IZ4Vm2
         5x09EAZ55iurxhz4tT8VJ5LdsDzo7LIqY6Qm5UWKKnK4z5jygd15yKpw5bbfyr+v2teT
         xMaQyv8qjBMAChYJptkJ8dsILo2VHenuuQEic766AM5YVWnb7py2YvCen3+LO3S33Zo9
         OXZpiVTn3k2ymdYd8vPBHhLyiTUK8h0itAMgwXYta0G4Zu0DqOfYV21JxjuvsvXAml96
         gwEGlypIMlVw7axSZ2bvkhkeHVYkf39/nrNbqMy0V222eqAZn81HkvFYvUSA/tWRFacl
         Vhhg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781272695; x=1781877495; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=39JwziAVEtMY+TsSm//5hIngMfgIk9ci79M8m9H/nTI=;
        b=Uvzkse3t6M4ckXfvjk3Dlo+4IHwe/pS0AIOu8/D+u+EsH6RRqbZK4F3nKFv14I28wv
         fOzP/Dz6vHuorsA61dOZmcxHvuJvsRKcD+Xz9wtEk/eON7HDutc/89yuaz9NQGiVbh0O
         cUpTyYdxv5ysumMmoIOmtcERqvU24+GH4qL0X1cyKY8oBJTbcCu2VpZuhauxdKa9KPta
         NQNF8SWIB72XYi/iErktdgmEucuKSCHk8hWn4edjStKc1SKiB194WIbGTS6LRS5PMlR7
         GA5uy1f8H5FVasaUoC+HpGSbQuIacUqk95e8echa8+OREBWN6aa+N/HTMoKdXYoZ8vnT
         fDcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781272695; x=1781877495;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=39JwziAVEtMY+TsSm//5hIngMfgIk9ci79M8m9H/nTI=;
        b=TsXJf/aLbwdYozsCQprOnHyzEPgVZCvuOAlgsUvFHYGQh6dYnjeIW957HO6s1JJVm9
         RbHFJptJCgehdlslzzsnnymXTvAeqdY4i/YLUL0Y13fDTjkqjBn2gr7abkEa6jZrkApy
         KS6OprAKu3koA0d+JF0bk5DVr4KY6h139EcTzmVb11Rgu8mqyfbVy07F56Cpr5uT0zeG
         U9gJlB0m4VWsRC3ZIjS8cCDNS01poFMHqWcBsumzRBIRqVzgkn5fmuANokK6PiK9Oh9j
         fzBOWgsr0E+zP5F4LmzFYx4MT1CrlDeZc6gcpuaIGySioCxvuYST84EHCkjZwpT/km3Y
         LoxQ==
X-Forwarded-Encrypted: i=1; AFNElJ/N3hU+DgvlMk7Vsi18dsA6P4TEHGD4f7Bcq2WOhl/WUMH8oOl00zrrfpY7dPgpd014/3Gl9e0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtG7Ap11mAt+u45US+UxdQTftJfe80Gb4NcUvzPl1iaPfaEBsY
	fSuuVTi1dODv9w+ul1nVy906WFcqKD4ifSvWJ7rNJCddXwo+iPWVOnQXcnhNg09RrWX04gLprsZ
	DXoDitAamdE/kV37ZexqpW41ezmIZT9U=
X-Gm-Gg: Acq92OHq5NkGXsijJto5ml4pmbzwpGQYFFGfQyAdPZlU1iOIbz3vDYwEx21KWyPLPTz
	L/03hpZn6Q53z1vu3wqdt0+J0MEPUkkA+OoQ2WNNG9JJuax8nbHgjP8kJscPUwVswF9yp+O5BmY
	TabV2QZJ/A6YCRy9Xa0OYAUe23NuSQw0fClViy0MlPYhyyNEQ6vQIhXNeENXlQ4bHLucmBI2NT8
	PVJn5IEVhZX4BcBkRyc3R9KKcFj0h7AfGzQUlvdQqeAk+8lQGCY/K6OqOZTCozus/UUIvZa+ASM
	+vEMSxBP8PgokskC3kUxuIFt4QLQyFe7FhMAmW4sSZKSjRSIAJCUP5oo1q2Jf/b3Cp2gVtKq0Hq
	jadk6H8deRP0qtqEY
X-Received: by 2002:a05:6a00:1884:b0:82f:50cd:e586 with SMTP id
 d2e1a72fcca58-8434cc0b172mr3363582b3a.13.1781272694689; Fri, 12 Jun 2026
 06:58:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260612012530.7889-1-vulab@iscas.ac.cn>
In-Reply-To: <20260612012530.7889-1-vulab@iscas.ac.cn>
From: Xin Long <lucien.xin@gmail.com>
Date: Fri, 12 Jun 2026 09:58:03 -0400
X-Gm-Features: AVVi8CdGRRqHLxpu5pXSGqJ6sSUoP3MuudWkexvLo07GnoDx744Nx0AV02fwFSE
Message-ID: <CADvbK_fTdr7rtwK7jgO8wveVptnAK=JhBr_L+d7NaDv-6td6DQ@mail.gmail.com>
Subject: Re: [PATCH] sctp: auth: fix inconsistent key release in
 sctp_auth_set_key error path
To: WenTao Liang <vulab@iscas.ac.cn>
Cc: marcelo.leitner@gmail.com, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	linux-sctp@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 11, 2026 at 9:25=E2=80=AFPM WenTao Liang <vulab@iscas.ac.cn> wr=
ote:
>
> When sctp_auth_create_key() fails in sctp_auth_set_key(), the newly
> allocated shared key was freed via kfree() instead of the proper
> refcount-aware helper sctp_auth_shkey_release(). While both are
> functionally equivalent in this specific error path (cur_key->key is
> NULL, refcnt is 1, and the key is not yet shared), using kfree()
> bypasses the refcount abstraction and creates a latent bug if the
> code is later reordered (e.g. cur_key->key set before the allocation
> check). All other error and success paths in this function correctly
> use sctp_auth_shkey_release().
>
> Cc: stable@vger.kernel.org
> Fixes: 1b1e0bc99474 ("sctp: add refcnt support for sh_key")
> Signed-off-by: WenTao Liang <vulab@iscas.ac.cn>
> ---
>  net/sctp/auth.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/sctp/auth.c b/net/sctp/auth.c
> index be9782760f50..84708f87392f 100644
> --- a/net/sctp/auth.c
> +++ b/net/sctp/auth.c
> @@ -753,7 +753,7 @@ int sctp_auth_set_key(struct sctp_endpoint *ep,
>         /* Create a new key data based on the info passed in */
>         key =3D sctp_auth_create_key(auth_key->sca_keylength, GFP_KERNEL)=
;
>         if (!key) {
> -               kfree(cur_key);
> +               sctp_auth_shkey_release(cur_key);
>                 return -ENOMEM;
>         }
>
> --
> 2.50.1 (Apple Git-155)
>
This is more of a defensive programming change, so please target it to
net-next and may drop the =E2=80=9CFixes=E2=80=9D tag.

Thanks.
