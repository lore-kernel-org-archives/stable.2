Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41D5B26158B
	for <stable@vger.kernel.org>; Thu, 27 Aug 2026 00:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787789495; cv=pass; b=Dfoo9i5QdhrBbjxI5qejb3p8i7pELugTVNPWXdY7KbbWiz7NP63hzyj/k3gFFwD2gfC2VwePv9ysFJL746FkCEr8FplRGImYPbFrJG2dNCxiq2TZV5H1my9CCwArVNnqgLqzy6kDIXEt+/u18BUc94U6j/gL4gIQDzXxfJyQJTI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787789495; c=relaxed/simple;
	bh=U0ZVJdy2xlpPXTTE9DVaFvSQYGlWfk/i2EZPp5O3aR0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YRJ/kuMoa0QhvXLmyDgT9bIpMd4ASqimraoiMyyGM5Yy3nRe2u/rBlS125ttv/qH8Vo/H0t0TuuTEpVAitMtqCAitPxrmHUq90k67k4wOIePAHqn9yJanG4DFQAXJ9q8qIniGf3SdwQMqrMy4g5MhAyj8PO++8jsIElLKHk5gpI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DQ4RaDox; arc=pass smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DQ4RaDox"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-51c10ed63c0so62641cf.1
        for <stable@vger.kernel.org>; Wed, 26 Aug 2026 17:11:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787789492; cv=none;
        d=google.com; s=arc-20260327;
        b=RKdiPCvDAyn5vSeGGSWwitJ+Eg0TqdEq3WR4uwNOoGOazwsT2pIybsWpP+emqG7vzf
         bVRWcnLIr+4u0ml9kt4eCMMB29zmgNb510Hu+E6CSKd9OTD3LvRrm8G5v+38waP4WHVo
         J0SRY5Wmzqq1OLCWXJuhkCp5gqYZSy5Rx1DevVg863heUQjNetNIETXVVQTtAgZhs2d1
         GqMYwVBC9vXseJOZ36EKXBEqO/uIKjgy9fDRXqN9RgIeH33trkSE3oi6SiGe/qk9Lq0l
         ppMTadrMMsBK2L+C9VtkPlUcj6Stoo55yZ4P4v7/ZG6b2Rx5NBVaAbdhiaL+WIZsgwDY
         t7qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5/sDIPJWVvy4M9xDKoTn87D0a2lykeAfDHJvuULa0K8=;
        fh=bM22ok6g1cXEveouD4QxiFxvm7EZh7iMn0a1P9zf594=;
        b=Etu2KneNcRXWBEFOamKEU0cmC9uSEELVUr0QvoJ27h3jFbsZcBCdAJK+6SPNFY+Pkp
         Nh+sNCcMs4ydUzJFOhUguAtSxxAA4ApT3WpS4TasTIOFQdwEnyLGrS6pzGnYPFwLrSSc
         /ptvDerxo3Ev5+4oUkabZmzUxvb0hsFJxnQTlLaJWRT5GECHt7o294H8f658jQ3+QEFD
         qqB7u92s2lveE3GrmClpF+WV/KzdO+Zbfd4TNk1oshXq1iDYuxax2jgmD9UBJQdCZz8O
         Ah1d6LSgdJC6eNj6RQ/UQ8HNuJZAkQFwYOuhyqkWsZScqEY28XhdzY88YSaIt1APeVKV
         3X1Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787789492; x=1788394292; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5/sDIPJWVvy4M9xDKoTn87D0a2lykeAfDHJvuULa0K8=;
        b=DQ4RaDoxwPXoleY2/DBK5nA5egrX5/rVO6rCLgHpgLh7OQpjXL1R1BPPMKMSefrtg3
         VZAI3oRnBNh+K45mJN3dzORZ6ac8QCknlVyB0wcX0IMGC0L2MnIbzlmKKPKvD0/phVvK
         +cq5saE9yqb6gzglLrOlrO6zfn+EgzavCDGkhNB2GRbnp0HYz5CCjclJiX3QTIKTLJ5o
         xoBQR7Kve3l5QX39NQhf1chGNzc1o4qEJV7OlRp930P77qHt91by4bn95+soYrmb0pgg
         /oC/vmBsWkCzr5T3nuliA3iI4+Enqy+h+p/7J9In04Uyq3c13ckCmyPBCbiKXb4xBdYq
         ogHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787789492; x=1788394292;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5/sDIPJWVvy4M9xDKoTn87D0a2lykeAfDHJvuULa0K8=;
        b=OIBjFovo0fx8Nrnqx2xSocg4TXkiCdIuktsXVXvMdyDrPaM55mXHZyH3kDX2btjlTb
         ZQmWzVA1UUVDSay40CcrREBZt3WjNa62SpscBo/7s9krmLEygtlMe3eUAY8trpbWJ+Ac
         Sam4ZEfAguMCgCYjkZFRJD1K10WV0HiSUnO2a3gKEikulFO5xBZMUWIyha6iEW0X8dEf
         ky5+XkwWNRL7m9Au488RGjWN3H4LjKEuel+0ZA6JCZDnMTuxN3fG2SewDABtTnlMDt7s
         posHOdQJ291nSMwVLPRT8Nx37BDPtIAnY4jhw7dVGHoZYEkLj/1iCLTHjg0P3OG7llu4
         2APw==
X-Forwarded-Encrypted: i=1; AHgh+Roe+QdI71XGBcn+ZLk71PV/3P3IBWlJZ4gWtleEBq76/JsS80iLd5OU+SYMWyLjcTgjLFuRB/E=@vger.kernel.org
X-Gm-Message-State: AFuF++nUaaVLiUuE7KeSoNe3H3ZraVRtLOm21Grg/ksZy87Mj4Zoogcc
	c+vUxjaM90hLMgA1pFJkjNXvjDlZl53vSLskQQfveQjeCME6xL/SajAL3A+r+vWAtr1m1TwtgpO
	D52BeLFiJCRdGpPc0xFlR4uGPRLHSGnYfk7iNkW/0
X-Gm-Gg: AR+sD10ARt3f5Qh18w/k7lbCZsN9W5HsiPHBTaSfOB7PPJlFqxtp8A7LzOCHeQlH0zB
	YFN1nua2ZLvi1TTouwRmCpBb3cYngVIgksVZk2Lh46DHQaj/ArGrJVXno8bbrgSra5VPMpl0+UW
	++xW9wujWSCCI6VvUpUo4GyZUsgN2rpPEIhrUh71EJkYloPEK+gphbszkkIGav//hq6AQf8jTxY
	ATgRXbImyyDN/MBgDojlUq/8YxJSW7VS9+QCHFaisOxePCyZdzfSat+Oq40MU6gIWGpMNF4Olv4
	8EWZDOGno0E4T0eMuRwhG8qcjMPRJyc7kF0RVDMbqvU=
X-Received: by 2002:a05:622a:155:b0:52f:9ed4:8d74 with SMTP id
 d75a77b69052e-52fa36b4dedmr7284201cf.14.1787789491416; Wed, 26 Aug 2026
 17:11:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260824014736.35026-1-hao.ge@linux.dev> <cd6b372d-cc68-445d-bcae-6cfc83d9e4db@suse.com>
In-Reply-To: <cd6b372d-cc68-445d-bcae-6cfc83d9e4db@suse.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 26 Aug 2026 17:11:19 -0700
X-Gm-Features: AcwNN1VDomkisfTnAtHt4KtA-jTwfLuIMQLzObQetyS450qtuGh4E69anVaRXCw
Message-ID: <CAJuCfpEzkuYBY2dBtUrR0pquajr_2LV3N=Ti6xTZB6MqhqAx8g@mail.gmail.com>
Subject: Re: [PATCH] module: fix lost error code from codetag_load_module()
To: Petr Pavlu <petr.pavlu@suse.com>
Cc: Hao Ge <hao.ge@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	Luis Chamberlain <mcgrof@kernel.org>, Daniel Gomez <da.gomez@kernel.org>, 
	Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>, 
	linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sashiko <sashiko-bot@kernel.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 26, 2026 at 2:24=E2=80=AFAM Petr Pavlu <petr.pavlu@suse.com> wr=
ote:
>
> On 8/24/26 3:47 AM, Hao Ge wrote:
> > If codetag_load_module() fails, err is never set and load_module()
> > returns 0 after the module has been torn down.
> >
> > Fixes: 044d2aee6c57 ("alloc_tag: handle module codetag load errors as m=
odule load failures")
> > Reported-by: Sashiko <sashiko-bot@kernel.org>
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Hao Ge <hao.ge@linux.dev>
> > ---
> >  kernel/module/main.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/kernel/module/main.c b/kernel/module/main.c
> > index 46dd8d25a605..afb810f0154c 100644
> > --- a/kernel/module/main.c
> > +++ b/kernel/module/main.c
> > @@ -3568,7 +3568,8 @@ static int load_module(struct load_info *info, co=
nst char __user *uargs,
> >                       goto sysfs_cleanup;
> >       }
> >
> > -     if (codetag_load_module(mod))
> > +     err =3D codetag_load_module(mod);
> > +     if (err)
> >               goto sysfs_cleanup;
> >
> >       /* Get rid of temporary copy. */
>
> This looks ok to me but there appears another bug related to this code
> that would be good to fix at the same time. If the module is
> a livepatch, the preceding call to copy_module_elf() allocates
> mod->klp_info. However, if codetag_load_module() fails, the code doesn't
> free it.

Ah, I see. Nice catch!

>
> I think we want something like this (not tested):

Yep, that looks like the right fix to me. Thanks!

>
> diff --git a/kernel/module/main.c b/kernel/module/main.c
> index d0e1e0bd2ad0..c1b34dc1e89a 100644
> --- a/kernel/module/main.c
> +++ b/kernel/module/main.c
> @@ -3581,8 +3581,9 @@ static int load_module(struct load_info *info, cons=
t char __user *uargs,
>                         goto sysfs_cleanup;
>         }
>
> -       if (codetag_load_module(mod))
> -               goto sysfs_cleanup;
> +       err =3D codetag_load_module(mod);
> +       if (err)
> +               goto livepatch_cleanup;
>
>         /* Get rid of temporary copy. */
>         free_copy(info, flags);
> @@ -3592,6 +3593,9 @@ static int load_module(struct load_info *info, cons=
t char __user *uargs,
>
>         return do_init_module(mod);
>
> + livepatch_cleanup:
> +       if (is_livepatch_module(mod))
> +               free_module_elf(mod);
>   sysfs_cleanup:
>         mod_sysfs_teardown(mod);
>   coming_cleanup:
>
> --
> Thanks,
> Petr
