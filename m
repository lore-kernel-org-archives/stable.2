Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEF07363C60
	for <stable@vger.kernel.org>; Tue, 14 Jul 2026 11:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784028128; cv=pass; b=UAMlre2YeaC3HQReYa9k3ArrQZKKYBYMd/XH7AaKEGg3lEAzZM4FEqNlJ43kQyyigsEHJMY43iFgOguuEuOMxr7Kqwj0IqdYqWKYekqwXn/DATSKu9vLnEx3fm7S+UQ7/umNIntrHtX+JliAcwyD1xaoJt7Vs65VErm4BvL/a98=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784028128; c=relaxed/simple;
	bh=bJUeMKQG3cczeINdPYa5bHkurV0CwFGNWw6AvZenC78=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=csfHSEn/Pi19HiTuYyOq+DrTNgIn1x9fM/QxfJJiH1jcjsuF2IkjxQdud1R9dRFHyohKXTKZMzFt95X5Bw6ugVauVOS/pxRXDaQ+s1wcs4W99bErmyRJLzdl5b3sw5FGtmAn8gxN1JMcoRFjQcGh0kMwMF2sU+U9N7CSaT/ddcY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sty6K/AN; arc=pass smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sty6K/AN"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-6984169c126so7513082a12.1
        for <stable@vger.kernel.org>; Tue, 14 Jul 2026 04:22:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784028125; cv=none;
        d=google.com; s=arc-20260327;
        b=EAzvI9K9ikVpANH4oLbuG6RMnteeia4Jyh3NxcZmFLmPQfDOGR7CslwFnS/1vKRN9L
         lXjx7duseE2QEhdfxpX9udbBnWiW7nwKQtnZbzqyY/F0QxE8ZSpYIOXv2KXbVwf2VOdk
         IKxnZinm7cletQQSTISpArhFhTqnx3YRTEecBleYCIxYBeD5Wjv3IQwsdGVyIS96+w3m
         oIju+zBF7Y9WxnrzkKv9yQMuoDklqzb3Rr6F3DVxTkuXNOqHSUpZqKW35fY8GNJnWrW1
         7cJ3Y48SD0+LUAyI+LkFQTl6KxTIfVUBcCcHKhUVwSq6wpDVhkWmZVuqmuIZ9RcSrEtd
         tokw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bJUeMKQG3cczeINdPYa5bHkurV0CwFGNWw6AvZenC78=;
        fh=LTTcFN+zfLFSGNCj1F6GgvgtnxO/FHiJIOrNwOWX39g=;
        b=bnY8ywuBXl8o9Ff58UbDNIIeo54Jk68JEW+jER/OPZ/+ABQh6dUaMn8dEE5XDEZdqg
         84s3m/par4gjlWUBnBWrtgI1qgVP9u+pYu/mVllKvXlNbO/UF74NgDIN7gdeliV237jb
         QfwYbouRFJq+mZ8fQ3BszAR0BRhEj5p35E/FKL1n1QUTngRgJO+y0t61zl4dw8elsBkE
         DAdVPG+vtzwH776RobewDHE0xYCSDj2Qca56I2I4sQIJqvC22xJHTBnKyPE++ckISrCI
         xkuwPm/MUtBjH/7geGYittyI1SqqlcGM7ecVLqa13KurtQ6ht6t/Em8gVE2YICVwYkB8
         qHHA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784028125; x=1784632925; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bJUeMKQG3cczeINdPYa5bHkurV0CwFGNWw6AvZenC78=;
        b=Sty6K/ANhxtYYAOYXs/ttbRB6TFHEN0WdgprgkX8tXbxbiUO7kAG40ff6HihX7Kgwj
         gXgn463LvVemathG2+1299gX+X1eq5S+igO2dsA+YZJxC5jjjwsDQM7OTtcmfylWNgC0
         gH8+COiMqDRYlxEqhkhnLS9bx8iASbm9EZTR32+kmE18ol5spEgwSxSmJTOtFzQSrl9n
         0O9GHMhxWids4ETuvm1WSO1nOQM+9SCKlB20mPzc23YadnrZ+focWaS9DOlVw15Q4vaT
         JJtWoIpacWIEsjEJaUlMN8a5V5YsqsLoJhTxsbvU964ZFkTwWItboPpIRU1VCT6Inbea
         FsTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784028125; x=1784632925;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bJUeMKQG3cczeINdPYa5bHkurV0CwFGNWw6AvZenC78=;
        b=R3vLqFO5H2sLgPpJFoLa2BPcloz+J5SGZUjZwXdOlAxWEiQpbyIESOsK7fyl5SzTDA
         xotrh80zaijCGkDTvIYwU4IuOvBdWTHxO7zKDAnmNx5PDpd8ZwJAS7o9DdbuVuxchh9J
         RG8yfEe81yUYnQOX6dEQWBbx/uAPIoCIuw6tfETSk6MHLipQOMRi0Ao3NFPyftoFA2Ww
         Fb2BzLxnxOlX6sFQLs8Hb4cgK6VWzlhEBdLRfjO00gP5skvs/PhZzX4uYYLJZ9SXUkGs
         WzRB4Q6WQbqaLKN9kgyo1THK/73tilpIeCxOBDc3Uj9APes+IS4gu8NEX+R+l2Tje8xq
         OKrw==
X-Forwarded-Encrypted: i=1; AHgh+Rpn+CWXxKWgYpEFKWd4yjNxIJUV0BRmv1cuGKOCT+SA+Ufk/MKQFL1Lfhuk6vt7x8sVo11P3RA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4iXQk02F9l9YSx13vG1+tb3uAgn9Uqu3f1TmsU/eeUbbihCgI
	uK/H8Uskqgqlf29iXFhaoGlJdBAELFY6edZ0ifDKTcgTf7xgq+AmyBJoL/HX3chfJC94ixv/YiE
	GjK9fDNrGOZHWcOSgCFTZRLYtNmtIJ8A=
X-Gm-Gg: AfdE7ckHYrCHWx3isReUTP5ccnf69XargUxu70YV125H6kgdcpd6rkBAa0Uf7Ec4FZI
	8M6UuRNoFqgi9pSOHT2Ml0msn77rvngNSWjZjKcu9zxN2ISVTFOhYv0W2NMYnM3jnNyiiXt8P0e
	gieyEuSrVYhtnCfcM1To09/If/AAr3qcdSMvARsK3sNtWsIz8MXVn193IW+OIwhunOkN/NHcagM
	K+TdvSWJz3rj42b/aP0yznEDgQptIEx6+q0iZgPRBiX0+oOaN8u9HeNXxDRXy0brvjoESciB5+T
	i0mqobP3
X-Received: by 2002:a05:6402:a299:10b0:69d:4ed6:449a with SMTP id
 4fb4d7f45d1cf-69d4ed64c46mr482016a12.8.1784028124702; Tue, 14 Jul 2026
 04:22:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260713175345.2542331-1-joannelkoong@gmail.com>
 <CAJnrk1b9jjvP6a9PaYAiA0HZcJ0_dR_O2aGWPF44T2NNBJC94w@mail.gmail.com> <CAJnrk1Zo_j_QY9Q=jft5=fio9mU36uy5LXP3bC4=xO8DbakzrA@mail.gmail.com>
In-Reply-To: <CAJnrk1Zo_j_QY9Q=jft5=fio9mU36uy5LXP3bC4=xO8DbakzrA@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 14 Jul 2026 13:21:53 +0200
X-Gm-Features: AUfX_mx0XwOPLr_TC9ZSVZR7KwlGJvFz9wpGiR9F2T_Q54IMIVcuOKELEzZmZKs
Message-ID: <CAOQ4uxg1m0C6suUpoO8hNkgnqEH-APV3BJgzKg2biCEoC6kXVw@mail.gmail.com>
Subject: Re: [PATCH v1 0/2] fuse: fix missing barriers in io-uring init
To: Joanne Koong <joannelkoong@gmail.com>
Cc: miklos@szeredi.hu, bernd@bsbernd.com, fuse-devel@lists.linux.dev, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 14, 2026 at 1:51=E2=80=AFAM Joanne Koong <joannelkoong@gmail.co=
m> wrote:
>
> On Mon, Jul 13, 2026 at 3:11=E2=80=AFPM Joanne Koong <joannelkoong@gmail.=
com> wrote:
> >
> > On Mon, Jul 13, 2026 at 10:54=E2=80=AFAM Joanne Koong <joannelkoong@gma=
il.com> wrote:
> > >
> > > These are two pre-existing issues Sashiko reported [1] on the fuse ze=
rocopy
> > > series.
> > >
> > > [1] https://sashiko.dev/#/patchset/20260630211436.2062816-1-joannelko=
ong%40gmail.com
> >
> > Sashiko noted some other places that are also missing barriers [1].
> > Will send v2 to add these places as well.
>
> These additional ones aren't real bugs. They're not reachable on a
> well-behaved server and on a malicious/buggy server, the failure is
> benign / self-correcting.
>
> I think we need some sort of way to help Sashiko understand so it
> doesn't keep flagging this on every future patch anyone submits. I
> think there's a few other places where some of Sashiko's
> assumptions/analysis are wrong (eg uring-cmd sqe stability semantics
> [1] in the zero-copy series). I'll look into this unless anyone
> already knows how to do this.

You may want to talk with your colleague Chris Mason about adding review
prompts for FUSE, because he is also running AI analysis on existing subsys=
tems
regardless of mailing list patches.
I didn't try, but you can probably figure out how to add FUSE specific
review prompts
to Sashiko yourself...

Thanks,
Amir.
