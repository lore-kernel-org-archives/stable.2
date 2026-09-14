Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08396312807
	for <stable@vger.kernel.org>; Mon, 14 Sep 2026 03:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789355078; cv=pass; b=MWs9xIl1eaUtowEV4EAD8EVRCYE6Z+oq8DWEv4Ej8Tidb06VvSYbOjwbiMhQw2CvldrHHV2O8TnFTUtGUDKo0ry+p7iyaBBgkqAzRQ254rWo92dI9zfsIKpigIJxlXtdoOBBu8fHUBhRoJWkc4BrEa8Qd0yPtlJ7RC1zWK7jSUg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789355078; c=relaxed/simple;
	bh=EnbOJbctUI3jeICE1p676LAx9nJxpk2azJhMo+Wok+A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a+5J5A7I82k466TTYm8TaWfXcr4mU3H3dwndj9p42lUvT9XJRxhX97B5Q3VnW9F8g9q/W8yOTwC5mHqe07sn9hEYhYQhoOMwdHx9/T6YkVeclT558XVqvF8FbZbxHY/TPns9GfwCTSAawqdqaTajBcoAfni7jk5OjgzQneqpAoc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O6VkCAOl; arc=pass smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O6VkCAOl"
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-3a595487d43so16147501fa.3
        for <stable@vger.kernel.org>; Sun, 13 Sep 2026 20:04:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789355075; cv=none;
        d=google.com; s=arc-20260327;
        b=bKEvqZTnlCqP8885j2AwneDTuPsf2QeNRFZI8yKXWEkep9AAJ3hPJnYTGvBermGte6
         HeqOLvrQtzUHU3k05ufJmccdfjNHZ1uZy1OmakalwAJ7ws29mWzxl9g6Onmf44Ukxm7v
         ABT78B3/y6wGTEvhm3sHbn5E24AV6Sc6j65AQWssToqEjk79N6yPPLVd+kkb+AXTvGzq
         g4zcL5MtbMkXflweiQZ3E+iVDX2+d1rEAgIoX0qwyyA5V1OmYMizU1GSn5kSd4rAVNT6
         yA2N0Xs0/NSAVKnKIFLiFJ0mbHL32ViFplEU39fA+WEF4dPj4GysHrBCb2f4ax7EtpFk
         Xmxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=KJqOqNeQWR2s2A9ELu5zJ2HbMajdgUAwUmVmEHOOFLk=;
        fh=Z8cU5keSv4G29ZtfO5S5aEo3igUwjB7r9tagLPLeOtE=;
        b=WGg8JMg0MLmw7+cdpvl98umOUJql9+OamPpWh5yJpL4+AKdcfZQXiSdYaG8W4g/wyn
         u85Ig59WgB8Ae+s5Luw/9RYMsclmVJaafUyBYwp9ipQGfIYY9m4gh4opDQyymie5ZFn7
         fLWJUveao7uFXZon6iidkLCaOhjLUpDk23an5N9tmHBlickkGSpvMhrhXueICcFTr0Le
         22eG3O4Qo2dxW+2BNnEop8KmrA9O70zh2kYeogQpwQy2OM1dbrRtIs+pBXXC//36UYlf
         vv0Skwyo+fU7sT5RvUY1VCY2pyB7gPeWra7k90GlOR+cbV+sMD3tDIin8lbpljlEOXnB
         E18g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789355075; x=1789959875; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=KJqOqNeQWR2s2A9ELu5zJ2HbMajdgUAwUmVmEHOOFLk=;
        b=O6VkCAOldE/FmAIq2O+IzOjgRL8Y7tUNyEW62h2Pqq9eZBuwZC+9ijsG0Sc+jyk3V0
         BhlWLjRpJtBDDamrI+FguPRirhgrcoBKM2PH58C9Fnt/XubPxXu94gJ8QnkGWE6d4dTR
         fQsWwvkdBY2wFGztCH3J/kFT4FGgRFCgFoxVHSBkqZ8ZThALbmZ2n+lhOmDyH2y2r2Xv
         6T8ViKoG04DWdsHdTFxLa8Grfponaw0y7TjOFl6Wn7LV/J5QJqFHS300h25xjghM59oD
         Zwt8z0uDry7HSj93uwQUwFyHH7+WvGWk/q9mTq/Szi4VJEpmZfGsjl0aa3/WtefjU0M/
         CA8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789355075; x=1789959875;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KJqOqNeQWR2s2A9ELu5zJ2HbMajdgUAwUmVmEHOOFLk=;
        b=IwAiQ8Mjw4bLZSPq8k2nYVh/1/WUfm2obnMoEO1VIb250q4eX6q7K92vK7hUWKsIYE
         pH23i+7ZUndPpOySRhHaLBCBFvpCeW1GzGAvkPgAqLUqQGMwq/DQBUOGGgcKsfmQOKkk
         /ka9qvD65iVZ1aI5hLVTaOR2n2r3s0XQRFmBFLl1JUg8YahmnfCswLmY/XQ+M99aaNm1
         cFoayIjGO+zlyvBzCOpGWnkDOeMw6CBS36jZib1NX5IOw7TJuL+hZo+QWUzNcvmtOcUx
         ONf83sDvrVmTnzbqSYtdTebI2Nab4IwLJQTHGeDcY/b9dP/+YPELEA/bnPAMltVuqMHN
         /bSg==
X-Forwarded-Encrypted: i=1; AKwUvBxs1MClVv8kgKpW2H9kPZ5q4PUVOkvvxtTrvfbIWHsSk0Db9JXfx+ib5jmYxai6JtM7EekZxzE=@vger.kernel.org
X-Gm-Message-State: AFuF++mpf9/Ny5M28obgLE3cLcYRdz2zKd5Qzl8L1SN+rJaNcZ3tBV/s
	76HuCPOseUnKR8efVJtZVZZ2Epw9HnIk23VSLJbzYtfu8VSAWE1GSunmvwOWimr7XjHsHBUwZ/y
	kK+KS6CNtpVNYxhP2+s5bjqGBsMTcJrhzqQ==
X-Gm-Gg: AYBFou38iHgNVJ2UYEBcs7E4bmAEUEwJ2oWGubhF9h84dLK8ae+NuLqS7JsmIiSTQFt
	jinLynpdGZFEXURCc2Ig7CuaqijNpENcTeXc0RUSAIvjVzf86Mp1ceWk0PId7tERmLtA4e5fOnj
	CXS1bMeSIgiwTo/gRRO9A9oqQnYcMI4ROFSer1CJhwPX+vMvAEMDuzwE7E+C50+faXFju4Vzlv/
	kwyM1EMtow8ThFoiBdSTft/jqHvCNejShLDTqGj+yL5go5jmYsSJ++jmnFP7CJz+oqRZt6Nu1mY
	+M6aVz1CrkxmoS+ecogmJUs6w8pelEF87RfjTmTS0r/IwhXzk7RWM+hir3PozC3YBjPQsIFL691
	PMPX6NPNMER9eUsxG/6awz59P
X-Received: by 2002:a05:651c:4ca:b0:3a1:94fc:e1cf with SMTP id
 38308e7fff4ca-3a5c88b91f5mr576081fa.10.1789355074742; Sun, 13 Sep 2026
 20:04:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260912-b4-bunzip2-blocksize-fix-v1-1-c7384bbfc954@gmail.com>
 <20260913190904.bd6811bc8e094047017c67f3@linux-foundation.org>
 <CAEdQ38FOnZPmhc2LYOCXS4sqpi4gqLGnkUMA7EXyDFL_9A=X0w@mail.gmail.com> <20260913194932.c36fad94a3a74fbed5cdb4a6@linux-foundation.org>
In-Reply-To: <20260913194932.c36fad94a3a74fbed5cdb4a6@linux-foundation.org>
From: Matt Turner <mattst88@gmail.com>
Date: Sun, 13 Sep 2026 23:04:20 -0400
X-Gm-Features: AcwNN1VwzDqGO9CdnOVUBM5-wBa44-Riof3Z6CPl3pCqTJz353sJaoGueShPDK0
Message-ID: <CAEdQ38G3V8BtL7kFehNCg1C6=khxcS+h+v6yv=iRSfgto0HvQw@mail.gmail.com>
Subject: Re: [PATCH] lib/decompress_bunzip2: fix off-by-one in run-length
 bounds check
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Alain Knaff <alain@knaff.lu>, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 13, 2026 at 10:49=E2=80=AFPM Andrew Morton
<akpm@linux-foundation.org> wrote:
>
> On Sun, 13 Sep 2026 22:18:07 -0400 Matt Turner <mattst88@gmail.com> wrote=
:
>
> > On Sun, Sep 13, 2026 at 10:09=E2=80=AFPM Andrew Morton
> > <akpm@linux-foundation.org> wrote:
> > >
> > > On Sat, 12 Sep 2026 14:17:35 -0400 Matt Turner <mattst88@gmail.com> w=
rote:
> > >
> > > > The run-length path rejects a block when dbufCount+t equals dbufSiz=
e,
> > > > but the loop that follows writes exactly t bytes starting at dbufCo=
unt,
> > > > so a block that fills the buffer exactly is legal. bzip2 allows it =
too:
> > > > its decompressor bounds a block at 100000 * blockSize100k and check=
s
> > > > that limit per byte appended. Use > instead of >=3D.
> > > >
> > > > bzip2's encoder stops filling a block 19 bytes early, so nothing it
> > > > produces ever reaches the limit and the bug stays hidden. Compresso=
rs
> > > > that use the full block size do reach it: an lbzip2 -9 image whose =
block
> > > > ends on a run fails to decode, and a self-extracting kernel built t=
hat
> > > > way does not boot.
> > > >
> > > > This code came from busybox, which fixed the same line in 2013 in c=
ommit
> > > > 932e233a491b ("bunzip2: fix off-by-one check").
> > > >
> > > >
> > > > ...
> > > >
> > > > -                     if (dbufCount+t >=3D dbufSize)
> > > > +                     if (dbufCount+t > dbufSize)
> > >
> > > Sashiko thinks there's also a potential overflow here which could be
> > > addressed in this patch.
> > >
> > >         https://sashiko.dev/#/patchset/20260912-b4-bunzip2-blocksize-=
fix-v1-1-c7384bbfc954@gmail.com
> >
> > What's the appropriate flow to/from busybox (from which this code
> > originates)? Apparently we don't sync from busybox, but do we want to
> > avoid divergences?
>
> I'm not aware of any such process for any of the lib/ material which
> mirrors some userspace project.  So I guess it's an ad-hoc "send them
> an email" thing.  There's clearly risk that if we accept a new drop
> from upstream, such kernel-first fixes will get lost :(

Okay, thanks. I'll investigate the Sashiko report and follow up with
busybox upstream and then circle back to LKML if there's something we
need to address here.
