Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D78983C7E1D
	for <stable@vger.kernel.org>; Thu,  2 Jul 2026 07:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782979137; cv=pass; b=LvW19VfHHdduig/FNNuiXqIodQdtj4l6CeDhKL4/h1eZlb3DuK1pOGM1SEljkTXrNhlcLE0AeQDf1/sFziCrDEI+d/bOZ4l5EJAw6HqNxCGTm0BYIDYu8z49D32pVplTid5OZQqXEKpN8iltajxFKk0to4bj/N6a3+v4xfKmShU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782979137; c=relaxed/simple;
	bh=TNzHkKZQm4SaRgDClMZnbyJnolbtRVGm7YP24qxfSX8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Nn1QUWKMW8b9/Vk0t+xWwym8Z6a5sxabd1xH6B13yqR0MufTZp6PWCv57OJyDC38MUXO6P26ntX8m+7FLP/Q1+YDlaDTL2YBemSOtkwRVxz9UxYwqwcdPhQ3YUUvb7KqKB0nj6PpIIt999jF83QwtK2SnneK4W33zQiIYI9c8Fw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O87BSvbG; arc=pass smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O87BSvbG"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-8478fe07f65so1270842b3a.0
        for <stable@vger.kernel.org>; Thu, 02 Jul 2026 00:58:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782979135; cv=none;
        d=google.com; s=arc-20260327;
        b=piiMDg4UCr1VLrL5Fqj5YogjrnBu4Qhmd5YesDY3DwMGkLfibHYbi+o0TseIALGxGW
         I5O3DStW8rQkBfto1D4MkeezFtFbNEdsId91SaPIA2BHL4NKy0znOHNdioMT4g1KN7s/
         rUESyWh9Sb8a1REWUxTQasNBXzkgzToz2kDJrhyw7GMi3Cy+N7z/WH78CvHvj1P3/Tp2
         asRa/kViQiqdR0vfFI4kfTy54Bx1ivXa7UkP+1j939CD5s5VF2WGPEBgnmw7rwj8kmI9
         saBdpIQKa1XA761aQBBIyvNn1arXZgIHYh+4fWo5KaCrO3/RPAUm4Y4TwNAbRUWxBLAi
         zvsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Wf7IjjgHB70wDZfi+k6Zba+hdTQrCs3LbacT6YThaj8=;
        fh=DD1PMPpTJX37b2fdwiVBgjjkA8LUCwPlffS5Sf/0Ll0=;
        b=gIntCH6B3lVr7FZrwXG0Az+Fv/M0H4R5XrbN5lJZ41HSZH3u6KiXH3FI0qMlIwRvVk
         YOJJ61776gKaMTkyNCK15i5QuaTZFAXKTMpmJcYwjkmFsIk7y45sNU8aYtMmWygRHwj6
         O5BxRoL/dHuwk/faoc0q7vPLgEiZXpYabhcrNGkmIdcTgY5scYyPiPBDHOk7mcxGEjku
         HuF9zOqP3ysmLvdjK3vTd8CqX6ByVk799zc2kdZU52z9Kt9NOPk7YO/lCPEC61y5YnGg
         YFHFLC3HSVGmR4AtO1rSBMgVwrKks0OOWQqrGDNtF0aiZMzS5XNKsTOOOEn01PYrMVg1
         Zy0w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782979135; x=1783583935; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wf7IjjgHB70wDZfi+k6Zba+hdTQrCs3LbacT6YThaj8=;
        b=O87BSvbGVlzQk8TLeI3vvEN9678nQyGZP6x6vKfC7KHt2OwN0d9xMXAwizDUAK2Edi
         ecRGAP1FOmVH2C//7vQuBNivqb293I57r1KBYg9pLjL3yMcHPE/8i5kpzsMStUSuFdNv
         DCODNKO4yAeASO9TYVIfUymRYNleu58ffQ4ofEKKyA3ejNd1RZRdUjp3XprFK87KkLFm
         obr/iuC6qx9VR8WRNH37u1iBJkoTg2tpa0XRqQOY87Z0M5zide+mADlmBrfa65oW5AxC
         qUXCSwhFVcdBpQFXIbXZSgpD85KrrXWa3Q4CyfwtPRzhTOFdFC+R5nw9HvYyCBvGBTq7
         3QZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782979135; x=1783583935;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Wf7IjjgHB70wDZfi+k6Zba+hdTQrCs3LbacT6YThaj8=;
        b=Raw6fjg50V9dVqT9krdE4WnsFg50YvNYsdVtVqP7HLxeVvvGNKtophKXDndMmZjnj5
         jKq7IwoJzpSD/NS/UsJJoAPS0lpUeiw6XwHzrNwAddVcklz1xr3Ugu5ViNwo1psZ2ZgM
         /19V5nMilmCvpnR2SFVUP/A2XOHjH6oNpnKmH2jXzkLgDvW2H8ezeyrggz219rbTTDCC
         /+9TcmXviKW20XW0lkbky2e8i4e4waJkEkb4Ug6aXvcsy9Jd8g+y9MWYN2BQzjqSSQN1
         QKrAOQViBYsP9coKCr7XRJVgpNPGQuy0PIZ2/64OiLhTW94xCPlfYKyEo1BPImBCETLW
         W8/g==
X-Forwarded-Encrypted: i=1; AFNElJ9SckgGJWB6nijis+QE46h++psR2vyVrDUjFnlgoARH9yQWV58Xeex7tSRKji30MEQKD+2ALhU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIfRZZPgkZ8pKHpsPSqWXrWIgVUPaKtiZIvDk38ZA+lipfsOG/
	d9Unl1HCE+f1z14uCYptZ2ua+OkECYeK3+lkO9tePcWu/X8BdRpJSwSAgHlJd+94W1fb399fKgP
	tcGhpb+5xgdal9r2f71uTDs4iBgaN+6aARV+G
X-Gm-Gg: AfdE7ckfttB+mbTp+qxtblpzJ5Ahiz3BM4QEI0cCJRQKESfVNwIHw/bC1fzt0ztbTk8
	hvJkn3jQjZXyYBAzKixTjBY3M/u5NTxx3dmG+pukwqB3VkKbJaT6jMSh3mSF3BBYcUzGN5cFjM5
	rTi0nXKgpbgZHig5LuFFiOab0wOsByx6QhfaFKxjxyqSpM+JopjJYjUJCpe5kLO85ir6Z8lSPDn
	wDdoZcetVKkeqH803qhyYcPx14dVMfSmeVChMaZHCSoRjkCC3bG9Wj1X4yPgF4iBOPHIvF7zhCc
	Wp2M4RI=
X-Received: by 2002:a05:6a21:7d02:b0:3bf:9e25:1a17 with SMTP id
 adf61e73a8af0-3bfed0f65bemr6379819637.12.1782979134883; Thu, 02 Jul 2026
 00:58:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260701200635.3992767-1-rkr0k0r@gmail.com> <20260701154512.22e1e5377f21d8a2dd374cd5@linux-foundation.org>
 <CAKAxSWCnsHhYeFo-Bp8wcAA+GmEo9bQBW3aVDhn3o0PrF-yJbg@mail.gmail.com>
In-Reply-To: <CAKAxSWCnsHhYeFo-Bp8wcAA+GmEo9bQBW3aVDhn3o0PrF-yJbg@mail.gmail.com>
From: R0K0R rk <rkr0k0r@gmail.com>
Date: Thu, 2 Jul 2026 16:58:42 +0900
X-Gm-Features: AVVi8Cesy5-ChFuoVwcqevMadra1kV8M70K7ypQy7stPBmWAOCIBctS3o1iDvSQ
Message-ID: <CAKAxSWAdQCHQWDr8_JNWoTF7dGXOi5gyX76J3jXfV_240T=L3w@mail.gmail.com>
Subject: Re: [PATCH v2] tools/compiler: match glibc 2.42 definition of __attribute_const__
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Nathan Chancellor <nathan@kernel.org>, David Laight <david.laight.linux@gmail.com>, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

2026=EB=85=84 7=EC=9B=94 2=EC=9D=BC (=EB=AA=A9) 13:52, R0K0R rk <rkr0k0r@gm=
ail.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
>
>
> 2026=EB=85=84 7=EC=9B=94 2=EC=9D=BC (=EB=AA=A9) 07:45, Andrew Morton <akp=
m@linux-foundation.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>>
>> On Thu,  2 Jul 2026 05:06:35 +0900 "Joy H.J. Lee" <rkr0k0r@gmail.com> wr=
ote:
>>
>> > glibc 2.42 added __attribute_const__ to sys/cdefs.h:
>> >
>> >     # define __attribute_const__ __attribute__ ((__const__))
>> >
>> > GCC 15 warns when a macro is redefined to a different replacement list
>> > (-Wbuiltin-macro-redefined). Since host tool Makefiles (resolve_btfids=
,
>> > objtool) pass -Werror, this conflict becomes fatal.
>> >
>> > The warning is suppressed on standard native builds because GCC treats
>> > /usr/include as a system header path (-isystem), and macro-redefinitio=
n
>> > warnings from system headers are silently suppressed by GCC. It fires
>> > when glibc headers are on a regular include path (-I) instead, which
>> > is the case in cross-compilation setups such as NixOS, where the
>> > sysroot's glibc is passed explicitly via -I rather than -isystem.
>> >
>> > Per (C11 6.10.3), identical replacement lists are accepted silently.
>> > Match the glibc definition exactly, including the space before "((", s=
o
>> > the redefinition is accepted without warning regardless of whether
>> > glibc headers are treated as system or non-system includes.
>> >
>> > ...
>> >
>> > --- a/tools/include/linux/compiler.h
>> > +++ b/tools/include/linux/compiler.h
>> > @@ -119,7 +119,7 @@
>> >  #define __read_mostly
>> >
>> >  #ifndef __attribute_const__
>> > -# define __attribute_const__
>> > +# define __attribute_const__ __attribute__ ((__const__))
>> >  #endif
>> >
>> >  #ifndef __maybe_unused
>>
>> I'm thinking this should be backported into earlier kernels, so they
>> can be compiled successfully on glibc-2.42 systems.  Do you agree?


(Resending in plain text due to a mailing list HTML rejection.
Apologies for the duplicate.)

> Yes, I completely agree. This build issue occurs regardless of the
> kernel version, so backporting it to stable trees would be highly benefic=
ial.
>
> Thank you!
