Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C30732E72F
	for <stable@vger.kernel.org>; Fri, 12 Jun 2026 05:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781243639; cv=pass; b=ROjt1EaqwdVkF4JFdHnk/JiqWkCgvrCMQ9/UfIF/ZFqCmtz82Jz3c9HrEbdReGbt+MeFoqt8Fh/63GBceAO8rnB+HMXE6Mm1M3DnbSZAr5CV9NWJCOMR+hTjiaXGCzSOnIHAWqG+y6qvHw4HdJAhTcn3fCZu5jWULpDuUxwDuXs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781243639; c=relaxed/simple;
	bh=1vWL0BXeG0FSXQnsxbKIMJmpZgquuCn4Tk59McPRHfc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pDWgMfSObcqauT4IBEm6AI4aMDFSAbVApGzHrtPzBTLvdBlV7bS9KUG4Jp9RE3vglSgNOsUvwQXHj/tM8KkPZN3YM9GN8t02tgMRCYIv6FAY/Y/CSmcgkAW/da3QZgrmwFqjq4BkS5kDH2aKkCbFeIh+P4sP5K7Qb9btLdTefC4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KlKb9gAK; arc=pass smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KlKb9gAK"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-9157d3f2098so75491985a.3
        for <stable@vger.kernel.org>; Thu, 11 Jun 2026 22:53:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781243637; cv=none;
        d=google.com; s=arc-20240605;
        b=OARYjMAz3BdfDQvCFm7uZAUWKLmNnKjvr2GR6UW5EU7+ZCIzKX0yqUqmzUrQlb6CZC
         9dKiU7nXpcatHYUD0ABwrP55ar+CRq8Xpw9pqq6l8m7XX3vqwC/BZpiK1awqtf1LKnpc
         i97OpvX8g4Wt6vvtZtSIDMv/Z5z/OltPjF7HY4a5jA0thcBy7Eys7bERlOwVpOiRZo8+
         vlPdEJHf9dnNNvhyXZOrf2GcZot5fxatGUHI3Ku+MoM0DLAmTmGKgNHlG6l5xQPFiirY
         BQpkIfK3DgtPUsONm4onLduPkO9BmG725hIpLE9igNrvjmczVIpjzj0VyAqjG8cnfvCG
         NEfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Jim7VVCGySRECFhqXko5r4bOP/J+hPyEF0t7DCcEkPA=;
        fh=vdLHYggRXNJlkW3J+Xkvhf6J2lX648spyvxxeU56ayY=;
        b=BD6G5daqTkvt5CQ1qKBvavZJuJGun1bEOjdp449PX6l6u0P/1skjp2zIugxVllZsk3
         qsB8BVf6nIKzs4XOKXYydhKl0XyeAzu3wk4HvsfMUH9cH8vA9v5RUU9ZiptOEhb5sjJZ
         pMroTLPF2Uz1/+rVcTUEhGE+5lao4l7siy2+4CsnlS5OewJNzx0eSRSqHM36KRgwAs6A
         uGKvQhrCMuoJxHkhGML1iLbUrYMic1Jmhxk6A4t2ebjSwykqRMHcIMI4h9aZTxvUiz0o
         4Y4imS6ovTPQxJBVP1alzMkMwz8/ElmdS9OTmtQkN3A2J1Wr1B+v7YViH4TZuPlxiUSn
         6YCw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781243637; x=1781848437; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jim7VVCGySRECFhqXko5r4bOP/J+hPyEF0t7DCcEkPA=;
        b=KlKb9gAKCIOuOtHkuIN6cuYZT8jyh6j2e83kf/zW+qUIoMsSy/QGuHJYe8UjbHbO2u
         q1Efv3wiyHPbSO/zh7zes8CPv2fEmTgvXzlP/sUqtvoSxLXbdXRsdT1fThe5mrUhakcQ
         dN7KusyMYPOwji4v4WGy0cIkZ8SVI4sczFdeU8FyKj5e71RXExRwX7TuQjKH/f/oGOAY
         5UKwo/UKaxGMTG+Bfx8wvrYoWWvW05lxwVEnKsvgyqB9jV2kDTJEcR2HyPRJkDBgdCUo
         FVI94Z6im5lAcUZbabnFQiF1sKBDNQ1NA7hu/K/+NkOXhdRBwcA1/UKuA0GBPLAE/DDI
         WeIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781243637; x=1781848437;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Jim7VVCGySRECFhqXko5r4bOP/J+hPyEF0t7DCcEkPA=;
        b=EJdeiSYvXk+G9eAdRCafpakvEtF3lh8HfjqGUwrLv3KqqXeazrGkID9WM2siFrSDwM
         Xw9lUNXMFBD2C1CZdJFvBosFWSbYcT7Cdj5iivp+7F5glqzbsJxvNTN5MGEQI5ge/etg
         ONYT/gQdpjQ4SkzNC/PAW9Yr8SIysP0J+TYcyHFmagjCAR1X+z5RXqwVRRPNcwKqKBo2
         emzQrqNGqK7kqB5xlVzfGkCZZO1wXVqaUG3yRbzD8tKc6jVh+ySoo1UpuF6wfv3qcyaW
         og/lfiGbWiLRVlABj+jCyb1dQ0wniWvmdnEQMZvtuYH3CnQa79LwG022l7Hqmn0Im2Oc
         Rpdw==
X-Forwarded-Encrypted: i=1; AFNElJ//wHC7ehJ7ZsU1kYO43D4wG5D3AYZBS0dtcLm/CZdbKt56Cs+J0wOl1GXHMJggNfzz6cxWdIQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyykOrCdyk7/MUSiu4bb+LdKsr7RZadauarKnj0Re/JFDA/hq/h
	Hj0IV7u65JRasrmTGlLL0fEQFXYFcoCCGxbcqym/cTz3NEEg9y0bMmJpbtkcfH4y29VbzKtPUHy
	fw5g3y439PYeL0mV4lTgn8YZWEUFWZ+ROn6ExqdCa
X-Gm-Gg: Acq92OHXq4LFUgzQlPwOEYBPKWqfaBhBf7YNVQzpFjhb7uXcOVvei/NQgQVSnGSplYx
	K2vqSWMgdrB1Dp4Gd/0nio1FZMvMC9eKNH/K0Ew6t/HnOjHF7AYc/NV3o/YdplXG9oidJfBIMoc
	QlAAkWdkoyNVOY7zMhV85abI+jRUC+U59Z8LkFWrWpMbbhe6KTKL0Zwe+WY8BUaoYFaMPkX/M55
	uq1Guq22kbAohQphyyfhEYOSQfAmRjmZ909rq8OPzemagLjd35xK2b1RBj+IvLGWV+BrKDDKEGG
	uOMrq6vsN3PX0jWIc+qiW/wN07ylkE8vyvshoj8wlOgXiBBAsLef8qA9sXuQ6zPS2M1lO7fU1gv
	T5mwBdaXT9JF8t5P/52M=
X-Received: by 2002:a05:620a:4406:b0:915:9943:d760 with SMTP id
 af79cd13be357-9161bf6d7b6mr154634585a.43.1781243636400; Thu, 11 Jun 2026
 22:53:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260612020941.12694-1-vulab@iscas.ac.cn>
In-Reply-To: <20260612020941.12694-1-vulab@iscas.ac.cn>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 11 Jun 2026 22:53:45 -0700
X-Gm-Features: AVVi8CfxgffmPJH6SaGYfAW8T6cMU8tQodJPSSvqbmPQBshWMh2lxfmQtVthhMQ
Message-ID: <CANn89iJVksVj+tnSgGFeWo9C1m7V6gM7pA_badBs6G5Z=GMO9Q@mail.gmail.com>
Subject: Re: [PATCH] net/xfrm: fix refcount leak in clone_policy()
To: WenTao Liang <vulab@iscas.ac.cn>
Cc: steffen.klassert@secunet.com, herbert@gondor.apana.org.au, 
	davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 11, 2026 at 7:09=E2=80=AFPM WenTao Liang <vulab@iscas.ac.cn> wr=
ote:
>
> In clone_policy(), xfrm_policy_alloc() initializes the refcount to 1
> and sets up the timer. If security_xfrm_policy_clone() fails, the error
> path uses kfree(newp) directly, bypassing the proper release through
> xfrm_pol_put(). This leaves the refcount unbalanced, triggering
> warnings if refcount debugging is enabled, and also skips
> xfrm_policy_destroy() which would clean up the timer.

Can you show us the warning?



>
> Replace the open-coded kfree() with xfrm_pol_put() so that when the
> refcount drops to zero xfrm_policy_destroy() performs the correct
> cleanup and frees the object.
>
> Cc: stable@vger.kernel.org
> Fixes: df71837d5024 ("[LSM-IPSec]: Security association restriction.")
> Signed-off-by: WenTao Liang <vulab@iscas.ac.cn>
> ---
>  net/xfrm/xfrm_policy.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/xfrm/xfrm_policy.c b/net/xfrm/xfrm_policy.c
> index dd09d2063da2..3074692b4556 100644
> --- a/net/xfrm/xfrm_policy.c
> +++ b/net/xfrm/xfrm_policy.c
> @@ -2421,7 +2421,7 @@ static struct xfrm_policy *clone_policy(const struc=
t xfrm_policy *old, int dir)
>                 newp->selector =3D old->selector;
>                 if (security_xfrm_policy_clone(old->security,
>                                                &newp->security)) {
> -                       kfree(newp);
> +                       xfrm_pol_put(newp);
>                         return NULL;  /* ENOMEM */
>                 }
>                 newp->lft =3D old->lft;
> --
> 2.50.1 (Apple Git-155)
>
