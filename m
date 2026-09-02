Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81733476CE5
	for <stable@vger.kernel.org>; Wed,  2 Sep 2026 17:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788369115; cv=pass; b=jFn8VZDI68uNmmXN8LBkcngPuaLDOBtjZVef+Wz8aJpqBCYrK/sXJfcfcLeO1gM1+ucGwdtkN5FFl4PwSwt1AZy7Ku/bjLSwaQ2M0Rnxy61hVv4pmLBZlt+3sQzlD6ZPlyo+LsC71qHx1kDrF82G6di9DLyBUVFV7GwRxQFYgfo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788369115; c=relaxed/simple;
	bh=CAYWGXwkwt8+u/LxyR1chbCwCtu6a8KVTc22slh2Qj8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jBVcr9lDciS5RakiPMjRpXzUaa+/6+U0LBFYUVfh7KfimtOSOiIrizLpUj+v8qpJFRYyInZf2YliTo/CSf4nvgCwh7tOowUdTHBPngEUeVQIzxMVwK+v0AKQEFUqjUcn8QVx97B3UQZxt9yvt3XVJUiH75DanNXnNk0kXpy+vDU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GXu9lepA; arc=pass smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GXu9lepA"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-498028b3d5eso13689365e9.1
        for <stable@vger.kernel.org>; Wed, 02 Sep 2026 10:11:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788369112; cv=none;
        d=google.com; s=arc-20260327;
        b=ju1nKH69lFJc2ik2NCeImI0cTYk2+ta2kYDhuzhBHmwBkfXEV/hLkAwK0YbQXV9wku
         k2zYWmExaaAsqRiGXFnSizOFZBlPjMUSyf3JZxbDR98Qj0ANIZBZww1euJ3KVHg/ipA3
         tKCirmXPX8hRbG+c7vG9bDzNUWqIwDya5Io5pWdEk6sib29e28JOURdZ9WqsxHBUdO1a
         CCeGyIYQza+WpM4pIniBwd6F0s3LRxg4CmufoSvjq94pmINOIMS0poXhc+fs+9YFmJi1
         Rpkz03fItQbZn5IB+c82BRnN0ggnQyh+0qkC4fwqMJv8rMTeeLS/KQsoXWG5rZKyhder
         XSbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=mYAOQwQb2HfqPywVtWuRASfqN3xJx96u2yl4fq6Cc0Y=;
        fh=W+VkHVsW/jEiEAZMSI3W9at8xg+x0jdyE6ujFljTRWs=;
        b=JpYylm0xA6d3h2+Owgi+kDOf/1N+MWBeo/sf+xgiNrPcCYNZ2PgGERr+PL7v+xDicK
         zKcdNIyBNGNQso/0F9THAuo/5U+LS3ulWHOH1JvEZ3joC+/pRCeT/C2cYNdGcNvvtNS4
         +X/wgXzX6Lj9etobnwOF7HH7R4icJEI1fFpXu08e72xPL8PlWHt8LgABdKsPPWOAnQ+n
         8QpS7f7lt1+K59jVFjEclNAC/FHhCxcKdA4I0EHgeLF9vbQZak4jtHsWEzQ8waok2HqO
         uR7ydUSOgxTngfnFFu8V1agBWxDOww7v3yHTytXvL7Nhe5fng50fyuAKzYg6wxubMF5y
         yEtw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788369112; x=1788973912; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=mYAOQwQb2HfqPywVtWuRASfqN3xJx96u2yl4fq6Cc0Y=;
        b=GXu9lepAWHOiYOf9rNfaoVePGplEnX5Or2SbLk6+y9uPSjLFJFqjJv5gkE60U3QJv7
         EaglYNxaAdpmcnx8q4C2DMhOdyNvOorhuJeBiAzslo/l7Og6sTyiC0rPoIFi9tmXu8MO
         K4tafOuQxc8adkA0rhF6zGwI9CeEiGjFp6hwRj//UM1XOGorkJWxww0XbgpCsaDV2AwX
         EfbDNSj/R/mtiPucSjERLfsBMgSnWafHnfWnQsiuZHklt4T4TwdYOGuXCmck5/LFh+xg
         IGmQcHufBt//T7aYnLqYG0bVVHtHTSHn+279qx7GHVXbe7Rv5CP/zcxBJb+5n/dmByvl
         GG8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788369112; x=1788973912;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mYAOQwQb2HfqPywVtWuRASfqN3xJx96u2yl4fq6Cc0Y=;
        b=DyOqDo8kp2R3iYmmf5k6sVRKfq1N/099lvnfTURHsSd2HgXiZ7ATJRwmWTnLYAkGDT
         VYDJ8JWlGWn3bZHiWeoTVX8U78rdJZdyr97EJDEJkBlgSgWK2FZ/WTU2t/9zaRtyv80p
         /X+OSmljXtzwSTU4Iu1wGmaRZWOQlnbD4MqEd3Il04ibsXf1IJ4/G4CJE/b9kwU1Liya
         Mr5KjvQFlaOcpxDNlG3dQYM0TvSpG2UsOIib8GvOwLG68spUJixcjEk0QKGYMj20Fwy3
         8YffdEpAU45/peV+FpvsbV/8IT0nAK5/BpuckQziueQkZ1+8e5jKivZhQciRRqkXhVm8
         5PMg==
X-Forwarded-Encrypted: i=1; AHgh+RplqZNJeAlH5ba4JzzulFSZ+MnddXipLXTL1UlTjBtil3np36qewT6wgwQyWyyBMEkRC3TPf2Q=@vger.kernel.org
X-Gm-Message-State: AFuF++mFD385ZePlRP2R7SyzjxkIDD12KVE6rWBB3F9nT3bMVACqz5HB
	n5i7hpVLdEz2Cd/uvg+0LcYy8ILZC20Qj5WxAP4Hp2k3bRODgni59Yg1wbNbeuNob6zsTxYoysc
	0dQKYo7qrea8VPAKTVbzcTxzQPLLdMMmDIIlg9C/d
X-Gm-Gg: AR+sD11KwpiLdyMlZOy/ZrUn7zraOfK5FQBgpYWqY77GVrX98klVlInMdw0dQAo9/9w
	jJdMdIZkzD31u/GdTO9c8mz2oNqzJCClQS3n3LSOPMybGzBlKxCX9HtWxp9UYs1r33Y/OH7CB5l
	CREPGUacD/E5oqQwIAFiG+rJBOuTyE+LGpP7heaLNBFt+TVsg+YoXcLY3SICygGoWq/bmtEn11K
	ey4vfevqDeUaL/M9A/RNvPGC0ZO0yZ2lRvZ9n8hXaB1q7J4twxBj9zvIjYUi53jiaH6hHEBPO8S
	yN0ms7K3T8J5QUI5f/KZIcSsKIBWLmp2uM1oNPONtTRxXe2+HaJXD3UaKyD5EsuyydJeqdJAs9u
	4LBKxlKpEP41hvlzrslnnW04czP9Tt4twKCFlb1l3XymXnFQt7jszAOnD4jS1ErUf2g==
X-Received: by 2002:a05:600c:4e86:b0:49a:77c1:d246 with SMTP id
 5b1f17b1804b1-49ce5852589mr112274565e9.15.1788369110872; Wed, 02 Sep 2026
 10:11:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260718111340.159896-1-linux@yoavmoshe.com> <20260827194508.446733-1-linux@yoavmoshe.com>
 <CAKwvOdkSZBbq=e916=efx8G-CTzZ5b31AhyUytO6eJjjkEdMow@mail.gmail.com>
 <CABCJKuc0cWWdkA7zrCcuze4AE-qTSETuUi-eRewPnn_ivHEADQ@mail.gmail.com>
 <CAKwvOdnA7Ej_uppSL7U2xwxyUQoDMvO+RArj4HCUSOziH0rCqA@mail.gmail.com>
 <CABCJKuezb0HtOcMBsObczS=HBaRvMszagkOZGHyOVbXBqtJi5g@mail.gmail.com>
 <2bd0c842-d0cb-4ad7-b3a3-fed2000dea83@yoavmoshe.com> <CABCJKudb5RegHcNPkXG5p1TcCFAe5_8+hqBP-2GyHVK19oB94g@mail.gmail.com>
 <CAKwvOd=OLLO5AXiR54o0nU16e_pTDt_yiEPQ0GgnX8DRGJXYmw@mail.gmail.com>
 <aphSYUS7xGJjj2gT@SMW015318> <CAKwvOdmG92SPOuMJka6KqODqObB0F8YJ6NhpEj7eisv-ZK+GXQ@mail.gmail.com>
In-Reply-To: <CAKwvOdmG92SPOuMJka6KqODqObB0F8YJ6NhpEj7eisv-ZK+GXQ@mail.gmail.com>
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Wed, 2 Sep 2026 10:11:39 -0700
X-Gm-Features: AcwNN1Xmy-BrINuLcPwv_tFccFrs29sUnSKtr5FfgrTjlEDRCX8NohA0W3QuOR8
Message-ID: <CAKwvOd=P+bnKm_wDaZjBJQUcYKvVHb55MtOLKWO4k99By8emNA@mail.gmail.com>
Subject: Re: [PATCH v4] ARM: imx: Fix suspend/resume crash with Clang CFI
To: Frank Li <Frank.li@oss.nxp.com>, Nathan Chancellor <nathan@kernel.org>
Cc: Sami Tolvanen <samitolvanen@google.com>, "Yo'av Moshe" <linux@yoavmoshe.com>, 
	Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Russell King <linux@armlinux.org.uk>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, llvm@lists.linux.dev, 
	stable@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 2, 2026 at 10:10=E2=80=AFAM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Wed, Sep 2, 2026 at 9:44=E2=80=AFAM Frank Li <Frank.li@oss.nxp.com> wr=
ote:
> >
> > Nick Desaulniers:
> >
> >         Is this patch good to pickup?
>
> Yes.
>
> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
>
> It does depend on
> https://lore.kernel.org/lkml/20260604-tracing-fix-cfi-h-build-error-v1-1-=
b27015390901@kernel.org/
> though, so you might need to coordinate your PRs to Linus with Nathan.
> Nathan, is https://lore.kernel.org/lkml/20260604-tracing-fix-cfi-h-build-=
error-v1-1-b27015390901@kernel.org/
> going via kbuild tree or what?

And make sure to pick up v5, not v4. Was just looking at this thread
on lore, and it seems like Frank you replied on v4, not v5. My RB tag
is for v5, not v4.
https://lore.kernel.org/llvm/ca86be7a-7439-49cb-9deb-8d565ca0b1dd@yoavmoshe=
.com/T/#mc0e4f1537fba074b962de6b4338f289dbb26c81e
--=20
Thanks,
~Nick Desaulniers
