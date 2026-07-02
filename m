Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F03EC3914ED
	for <stable@vger.kernel.org>; Thu,  2 Jul 2026 07:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782977295; cv=pass; b=EcipvKWQZkwbDd4pERfpTJ9wMB05TWYo/PyAPrzXFV+v+FS5gbHUljmw5AE6C/oKw+uSxjMdLXd3B0e/srtqonBfnznyEa2BP2OBH+PO8sIhYRE74vLrkSnrmMIiigDmxrnxFxMiKgj/y0dyiMaHSltEpDX3yyDF7vdn7LVpbVs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782977295; c=relaxed/simple;
	bh=iSg7UmndrJmXXq+2G8hB7zmOgf39V74PutvtsgDozeU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bzPs7aHjw1XBfllkmcCPNOT03lCJvRIjur2AvLE9ZILqY92PmAIwHs3qke+Bmmz3EbeBBDyZAT03cnD57iK5bjBS6+VisUNCSihhec4sXd+xP82ranrK69z8bdV64Rr208lJQtxCrTNBfQpDCe7/ZI3ZzgnoStm/rQGxdQKP2XQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PK7WOqlV; arc=pass smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PK7WOqlV"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-c981c2c37cbso657990a12.0
        for <stable@vger.kernel.org>; Thu, 02 Jul 2026 00:28:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782977293; cv=none;
        d=google.com; s=arc-20260327;
        b=KuY5ID3ehBUTVewmIJCVVtP2b2GX6hJSQ0mykOvyPtJer8fCTqMC41hK6e6L3W+OP/
         kjKZ8cqfIXcuHkP+BizlSQvxI9hY4vuKIgklFCNs+HJAxwA1O5OhtvszOrecJxZWS5ji
         vTTFkeHNqp00KI7+fQzBBj+dKDaj70BoCMitbh/kSfle+WD57n+N3LAPUKEr8amE3qta
         pzhyJmWj7UR2iP2vPWtWOdLjlY252wW66u557+6t/yNqcquB4gY+Ya9bGL8MManYO08g
         pausUE3JjMEdah5kF6JEr89cKZUMTPSyd92pJyUX1Ft8jxuqckJ/5YELVBhEi1rtyuhi
         sssQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=iSg7UmndrJmXXq+2G8hB7zmOgf39V74PutvtsgDozeU=;
        fh=DrVD+eTYzW/RRKMWcKsj+riOlJimUtovOrn4ucKolSk=;
        b=rv4Kr3v9a/gvtVlnvhWNUTy22I7KOXouiqJ05yEb2QpPs3YcZe3nAHB8Q+PLLdULrK
         emFCy5Vx+LM7N+2u7TSWcwqUQW3ppTYwLpJOYrSLfqcTSs1u0wDdrqeA4JcBHJ+B3G7J
         w1B/n1l0d9NM6ZxodzD19jCgkdiCe/aBTgXXhMj7gbClaglxPyAJs9JzY6dtxSlu4tKE
         cuzbjX4FdB0QVasZlkDPIlV4HTynASq63Z3BqoxjQZbh/FhOkHQbHc8SqNLBOToSKVp7
         Q6621LcokGN567iF84PxDN5Q0P9AyBmV/AzEzR/p0sZU4e+RGJXpsdAD6vca6w6HtQ13
         GlBg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782977293; x=1783582093; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iSg7UmndrJmXXq+2G8hB7zmOgf39V74PutvtsgDozeU=;
        b=PK7WOqlVCKe3WAUMB/8QiMgZe6hpqs0vJRuZj7/EfFBGDJzDVMfdfBeS962Gh8Ph3c
         lJjTQMJW2RRibDhK3jgDUhRbkj+b0PVYPKZgqIP3UCkz12Sz+hQBVDtrFmQFlXH8l6pB
         efbiYPSHKO5CaMgz1PSxin1ydyrSs/pedrdGGNdogAb9ahANMg4svG7/rs9gw/KzPexk
         OPPVmgizjlW1HggTZzvTgjvJAUIN2Q5MjcM5b9AxLDbH4GUcT/BWrx94eP+f8L+13Fjg
         jwhBwfuYwx/tNOUrV0N/yM+CeBg+b2xykpE9EB2UBADYWC/ThDsDf99tuP8PK3dFzma3
         +Iww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782977293; x=1783582093;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iSg7UmndrJmXXq+2G8hB7zmOgf39V74PutvtsgDozeU=;
        b=Hev5MrCoaxMSA8itDoQtPy4c8g5QpQaV258f2ATcg4099qhEaC+O8k3pd4wj97PZDx
         VcnWQEsOkKiNWRn7pIm0fiSdolZLrWkQQ63y8ZqZtikGWCGCjpaGVEHCHj40z7Hwbbbk
         mPRw3sBkXVolajEjAHqHURzIUFVm2dNXeLDnwzQ5JSYYVnSzRrmtzp9oL7jJDDRYjZj8
         PBo/Q9EljKsV7JQzzcyzw4KHuOJkogNVx1o9lX5sQ3S+eYia1kYacb14OX9WtcfxjYh7
         98X6ncy1SMCQte+VO1tuD6HCeKVf8qlEnCrTof3rd1YgbJM3j0zpyAaSqyx58Gn4J68I
         mTPg==
X-Forwarded-Encrypted: i=1; AFNElJ+jyjYoR/OKbQMUeV9uR1m/oZ2KRTK+Qwp2wyFWVP+i8UmmDol4/KrKosMC7WDnePYVu+C0P70=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz65/F+qVhCPUC5O3TYApsx5CS+EHl/zJQZTxqJL1d+LZ9FQIkU
	Aza86XjNqZO9AFEdhAPQW1SMlfmle2olY+VmKq3NWS8cjmf4TUvWixn/dPT6LUt78m6c9sDJ8lH
	yO4r6F4t11dbGZ0/xvd373caJdzNbsQU=
X-Gm-Gg: AfdE7cnVf0XgC01bM3GXhR2BPKJar+rJeUdAdoO4Rpj6D4VS4r9o7xb+QVyakOMpMln
	IZJI5l2Ir1hLTLit8EYXe/8EtpjqlDf4flhfDEQa8g7/YJgGWqQm/uI++9ccRaFyY8dvrDAfJO6
	n7bIaPyonlfAE05Ga7wISgXV0SV+ZyVfBAq2dwgeEL7mv56b6gUxXPsrFBupaOH42ruQ8vMGvov
	IwnbNiQVm1wsyVEpspweZpK7fz/9uGAwK6oVDOD/sDg2ArVDQcHxhSWXwf/AWNefoI7pOD3
X-Received: by 2002:a05:6a20:734f:b0:3bf:e2f1:1b17 with SMTP id
 adf61e73a8af0-3bfed5d84b3mr5130678637.50.1782977292785; Thu, 02 Jul 2026
 00:28:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260701023619.2730136-1-linchengming884@gmail.com>
 <stable-reply-mtd-macronix-66-20260701193800@kernel.org> <CAAyq3SY48RRSO1nN-uRH7HVnXbnvQ1_K823Lc_hRsCyVuf9L3g@mail.gmail.com>
 <DJNVRMSG4C6K.34EGBE463IOCZ@kernel.org>
In-Reply-To: <DJNVRMSG4C6K.34EGBE463IOCZ@kernel.org>
From: Cheng Ming Lin <linchengming884@gmail.com>
Date: Thu, 2 Jul 2026 15:25:08 +0800
X-Gm-Features: AVVi8CcWlU27hjRKRNYS1yEHj59voSMvjse80wpxaUbcKd4sp8ZX2S5x4aeIs_k
Message-ID: <CAAyq3Sb6d4xtp-wEwM9EhMo5OSzjvsh450JcwyeEOh2NeLrA8Q@mail.gmail.com>
Subject: Re: [PATCH 6.6.y] mtd: spi-nor: macronix: Add post_sfdp fixups for
 Quad Input Page Program
To: Michael Walle <mwalle@kernel.org>
Cc: Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org, tudor.ambarus@linaro.org, 
	pratyush@kernel.org, miquel.raynal@bootlin.com, richard@nod.at, 
	vigneshr@ti.com, linux-mtd@lists.infradead.org, alvinzhou@mxic.com.tw, 
	Cheng Ming Lin <chengminglin@mxic.com.tw>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Michael,

Michael Walle <mwalle@kernel.org> =E6=96=BC 2026=E5=B9=B47=E6=9C=882=E6=97=
=A5=E9=80=B1=E5=9B=9B =E4=B8=8B=E5=8D=882:44=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On Thu Jul 2, 2026 at 4:13 AM CEST, Cheng Ming Lin wrote:
> > Hi Sasha,
> >
> > Sasha Levin <sashal@kernel.org> =E6=96=BC 2026=E5=B9=B47=E6=9C=882=E6=
=97=A5=E9=80=B1=E5=9B=9B =E4=B8=8A=E5=8D=888:38=E5=AF=AB=E9=81=93=EF=BC=9A
> >>
> >> I can't take this series for 6.6.y: patch 2 adds flash_info entries
> >> with a NULL .name, and 6.6's spi_nor_match_name() has no NULL guard
> >> (only added upstream in ac5bfa968b60), so the legacy probe-by-name
> >> path can oops at boot.
> >
> > Thank you for pointing this out and catching the potential issue.
> >
> > I have verified this, and you are absolutely right. The issue stems fro=
m
> > the strcmp(name, manufacturers[i]->parts[j].name) evaluation within the
> > legacy probe path. Since 6.6.y lacks the null guard, passing a NULL .na=
me
> > will result in a null pointer dereference in strcmp() and cause a kerne=
l
> > oops during boot.
> >
> > I will add the .name to the new flash entries and submit a v2 series.
>
> No, please backport the needed patches. The reason is that the name
> shouldn't become something an application relies on (it is also
> exposed via sysfs).
>
> For all people not too involved: we are dropping the name for new
> flash additions, because it is almost always wrong, due to flash id
> reuse among almost all flash vendors.

Thank you for the clarification regarding the upstream policy on dropping
flash names. That makes perfect sense given the ID reuse issues.

Unfortunately, our emails crossed paths, and I had already submitted the
v2 series (which adds the .name back) just before seeing your message.
Please disregard the v2 submission.

To follow your guidance, I will prepare a v3 series.
My plan is to:

1. Backport commit ac5bfa968b60 ("mtd: spi-nor: fix flash probing") as the
first patch in the v3 series to resolve the NULL pointer dereference issue
in 6.6.y.

2. Send my flash addition patches (without the .name field, using comments
instead) as the subsequent patches in the series.

Does this structure for the v3 series look good to you?

>
> -michael
>
> >
> >>
> >> Please send a v2 that either names the new entries or backports
> >> ac5bfa968b60 first.
> >>
> >> The 6.12.y series is queued, thanks.
> >>
> >> --
> >> Thanks,
> >> Sasha
> >
> > Thanks,
> > Cheng Ming Lin
>

Thanks,
Cheng Ming Lin
