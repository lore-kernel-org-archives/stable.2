Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6A2B2DB789
	for <stable@vger.kernel.org>; Thu,  9 Jul 2026 23:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783641206; cv=pass; b=JsTrt4YsnG8AQOOoZFunZJcBpmbN3aMJG5pef1CLUhZCH6aO7lB7irLQffA5C1rNVqIDGQFFI8vrGpPVS2AqFXoayEH3W0scq4OuuPHFtVvmjA1ZA6T63Wu3EdhBhRPNGo/E6E2zhjhsTVTKy9Q9CQTuQfc5YiKbt1xwXYyT3go=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783641206; c=relaxed/simple;
	bh=QxXJ2iYC74zZ1k//RBChmroSQvJ48Sy3zPw9JY9QGNk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TgNJmxerNbn0TrLtdBl6qI20+qS8l6JDSmfTzNCgMkUTW9H73AdGMRs9iqnKeK3FJ2aw/ViyTvIBwwVLT0kAK332B5MQ9YL/40lIDazBcFN3jbjGXkJ3GTRHjzfGme/SGBPI7PaWWsbUonuqSLJYOyhNNnAKrtf8a4ngHWCml4M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=La2HozxR; arc=pass smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="La2HozxR"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2cacef7d299so29285ad.1
        for <stable@vger.kernel.org>; Thu, 09 Jul 2026 16:53:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783641204; cv=none;
        d=google.com; s=arc-20260327;
        b=Cy/sXQFSRkt5uGkjjIqG9ZmXCCdRp2aOhvuEZQT+rLbjAvnNzKlFy1R1esO8dtu7mL
         ELwCNZml6dvxrPjrw8RyB0Pc5qNejF7cMbe1IeF5FNCw4AxqFefAKgH3XNRppfkFcDp7
         MIM2pYjzVMIOltQOcJh3gEwQZ3sJEWKpdH6NzydfYIr5WMIK2iUJOwcYAAPiwLLn8XHl
         cuYdttmMX5xVOWAvHkah2mvod1l4okzzKSpEo71CI5diQdArn86eBUbascCwOTfeRDqo
         vchQQB5USHADhmNveerwNQibeG2MoPNRyYhO49RB+9/t/B+j4pNjCmRX8hHwmwdh81L3
         y2EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=gOivgKSF2Ne5xcZXKv/1fscB/+VMh3Ha5+HjjR37dZ0=;
        fh=MDMXaHb+IM/RlIccVmRNy9YD2Dk47cx/Idhq9Q4Jgi4=;
        b=CJ6izbsz5v2UvBybvCBEm87sqjqvMVcRcXtzjOuzocvwQeLQqyycrBaUw+PSzTc0Wv
         z8TyQHa3nMWB49KFXD1Xmcb+ULZRtUEUJbLLSk0M6YxmXPkEde/Zvcm31tPIjeuvq9Qy
         WpmlfyFgaWBi7p0nitpt74Mh+gLBElKQDBGc0ncWJZWQZPbX9O/hWril0jrFgujEw1Ok
         KaeFfwpWyNwERz76xCsNv2BUrdB0ZknzEF+ax93hmd6JvgXw01/yYL57QvjYt0AFPYJN
         2l9Jnz8IQ/ojiPMuNVFtdY7ExlY54ChGvwc9FHCoWu7ayh2pOMtk8tfj+tuLtzWMXSh8
         orRg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783641204; x=1784246004; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=gOivgKSF2Ne5xcZXKv/1fscB/+VMh3Ha5+HjjR37dZ0=;
        b=La2HozxRnblxV2ePLS7hkd67Dheu3EeW8apCI1+fK29/+Beu3dez2MNcAlRk3WHta7
         //qc3zmRPwIQ3IQIOayLeU/iKlORauT0l/OMP97RybLj8dT6T+13yv6vHChvWyQMnHGM
         5dzFmF0nCGGf3YVnozzOqaYHviE1jb5onuQoTsZnYNFEexqr1M5VuJHOb31A9WXQoxNH
         L57BlexjBBpLyjsWYlj/o2ehDBMgs3Ym6bqezaVgmEKZAZp49S7lTl1WF9MV7Qt5JMu2
         bGQsYyQJ6zQ1GOA/S6x8LFKNqKnZgC+1yvyFjZj0+k5Mn++5VrpdpJMJCgVIZLTuQl+b
         U5Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783641204; x=1784246004;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gOivgKSF2Ne5xcZXKv/1fscB/+VMh3Ha5+HjjR37dZ0=;
        b=XGJTAT/ZYYRL4KJjS9TeFsqNtYhMdMNjOrJRADw8r7MHjviAwMczaL3JxxsDNwYXNX
         EDveWe3m/BWkoH3cj6a2nnQFfGLHNOmSZZZNyiHQwhH8isQF+BMeHkbcNAkX9wemtLNa
         HjBHwLCgFt2V39tQf55KUOoTUXlODwIWmDkqkb/lHQsGbrJvVy2/gvSryM0kshVhFdni
         rg0hnm8cqCPlkiWNu4Qtedekotpws5FLHHjpDaqH2jt9NzdbwQgK2sDtsrmJRuvitAYP
         wLyHAXglXLp0Pq5s+io+yrVPuOlsHlYW3dfng4CUoyJ6UlrGd2+FGxGYZP7IU8IszdIj
         b9Ng==
X-Forwarded-Encrypted: i=1; AHgh+RrLAKw+LsaIm2heCtZAg9Yn7TBm4ZJ/u+51c5k6ySKAV5qtIZ7YR6qeiMTeLHt+Kv/+Bq0n4nI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3wBuLaSaTl1iANFiMHWKTPzWRkM4wyawZO3Y533RI1Xt2Jx0P
	U3VhDSQ2J6Kq97D+1gLJDVJ93tI6Vgx1iq0bRc3FYyqGnhkADWGMufw/5y0IMUglBTB1YvphGnZ
	NbnN74XDHGchsOmZJGrrq0LLO4pOeZuj17lLurIkm
X-Gm-Gg: AfdE7cn7GL/GdqTCYHfuE0SMIjQMD4Cs4zD9KKL/fKz/4b33hJHGEh0ATMRCMb8QQdz
	m2ZlRMtrUAdC5+wYoLvoDd6KalLnu83n32SA9AgT104dEhl/Kw1etruUyMzySG/Usc3HkJVaEmh
	jhS6hFyo5W87K84rZOC6lztmQfDQm0qqLkhvzFpYfHNWskJjN1QkofZB4fz/zEhw78kLoPaoUsw
	8q48XQFILUcrvUWJnvuOY0ozdKg/6FckHFws5Tz9f2Ia/YADvLmi/q5icOcqIB04TJOoaJp85ic
	fBRjOBu/MsWW2b/yDDDMjR2YFaITzY3pMhgHXMUToh2olIyDHXkLCA3GN+zycWgk2d7iT93X
X-Received: by 2002:a17:902:ef46:b0:2ca:bf8e:360b with SMTP id
 d9443c01a7336-2ce86df6820mr902405ad.9.1783641203766; Thu, 09 Jul 2026
 16:53:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260709082713.829446-1-johan@kernel.org>
In-Reply-To: <20260709082713.829446-1-johan@kernel.org>
From: Harshitha Ramamurthy <hramamurthy@google.com>
Date: Thu, 9 Jul 2026 16:53:11 -0700
X-Gm-Features: AVVi8Cd5ZRhOi_vLjftB610oSlNn26rSijaAnAjkQUi_bYjoJyjhZsIDCoXkKSU
Message-ID: <CAEAWyHfTBcPxV2zq55mQmvprqwViSvhvXFNRW0VKxv76KRiTgA@mail.gmail.com>
Subject: Re: [PATCH] net: mvneta: bm: fix device reference leak on failed lookup
To: Johan Hovold <johan@kernel.org>
Cc: Marcin Wojtas <marcin.s.wojtas@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	David S Miller <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Gregory CLEMENT <gregory.clement@bootlin.com>, netdev@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 9, 2026 at 1:32=E2=80=AFAM Johan Hovold <johan@kernel.org> wrot=
e:
>
> Make sure to drop the reference taken to the buffer manager device when
> attempting to look up its driver data before the driver has been bound.
>
> Note that holding a reference to a device does not prevent its driver
> data from going away.
>
> Fixes: 965cbbec7f20 ("net: mvneta: remove data pointer usage from device_=
node structure")
> Cc: stable@vger.kernel.org      # 4.19
> Cc: Gregory CLEMENT <gregory.clement@bootlin.com>
> Signed-off-by: Johan Hovold <johan@kernel.org>

Okay, platform_device_put() has to be called directly instead of
mvneta_bm_put() because that takes in the priv structure.

Reviewed-by: Harshitha Ramamurthy <hramamurthy@google.com>

> ---
>  drivers/net/ethernet/marvell/mvneta_bm.c | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/net/ethernet/marvell/mvneta_bm.c b/drivers/net/ether=
net/marvell/mvneta_bm.c
> index 6bb380494919..128fe1f512b4 100644
> --- a/drivers/net/ethernet/marvell/mvneta_bm.c
> +++ b/drivers/net/ethernet/marvell/mvneta_bm.c
> @@ -395,9 +395,20 @@ static void mvneta_bm_put_sram(struct mvneta_bm *pri=
v)
>
>  struct mvneta_bm *mvneta_bm_get(struct device_node *node)
>  {
> -       struct platform_device *pdev =3D of_find_device_by_node(node);
> +       struct platform_device *pdev;
> +       struct mvneta_bm *priv;
> +
> +       pdev =3D of_find_device_by_node(node);
> +       if (!pdev)
> +               return NULL;
> +
> +       priv =3D platform_get_drvdata(pdev);
> +       if (!priv) {
> +               platform_device_put(pdev);
> +               return NULL;
> +       }
>
> -       return pdev ? platform_get_drvdata(pdev) : NULL;
> +       return priv;
>  }
>  EXPORT_SYMBOL_GPL(mvneta_bm_get);
>
> --
> 2.54.0
>
>
