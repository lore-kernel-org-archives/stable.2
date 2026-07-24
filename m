Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98CEC3AEF49
	for <stable@vger.kernel.org>; Fri, 24 Jul 2026 20:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784926179; cv=pass; b=T95An7iyLwCkUO288Lktz1aaNQj3BmtROOZ805+NzMGN7Q0kfMkdJxPFTCCYpytqOA+p7GpJQaPzXmTlXDT5ddSpJdV2nkndLsaE6EwSgMkK77wTmQhmwrInL7BM41/CvxLO8T/SyW7WgYaisrMgOef/raNKRRLcJNfKVfpbioI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784926179; c=relaxed/simple;
	bh=gaeGWLc1DkhoMVhCoeTTtFJMXVnVmf3wALfJxA2LuRo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VQ6GuuNhr8sSiP+SFPxxpjyUSKvlSRdAE1h6pKRHkdj/vYZ1k6bHHo1IJGwbZwcrQb9B+RRiJTUaKQV1KU5z0rxdO/s4SYRi+8FgFth0EO/A0yRdVNd2sfqh9nLUnB7IN/L8pHktzslxlBkeoxiAL0ilctght5qt12pVMGVhu6I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nc8e+mC+; arc=pass smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nc8e+mC+"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-c197e7e4e94so161606766b.2
        for <stable@vger.kernel.org>; Fri, 24 Jul 2026 13:49:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784926176; cv=none;
        d=google.com; s=arc-20260327;
        b=A06ufTdlpwh7Qkvc9Tw9GIScT4GiA3J6DeeRPt741J0NLmlJ6BQe8z/CyCDdTcS7bz
         jNb8Z0nqEFIyVhAFV+nD6qJ7gRjglcD/4r+hwr7tA/5TtvLMNClKyNgXQyQMxD9sdHpN
         Ic42WUWDtlYI7u2ffxM4EeHEThoVnFFqhkoZs+0ZavD+i7UqS24PnItMVphqfqXbHgMA
         KvCqNFjldgtvs9+WtYDgSAtmsDXjep+GpM1/cTtcBhyFdTnUZKjXAPwdOfZ2UkWibg4C
         AI0UYZ1Fehm2P+RTY0el3oboFeCqwGN/rK15slARdMYsk1Ppqgs2B/ikTEe7V6ozULxQ
         tjug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Ir3cBbA+grq0RW9ubbM0IgTXxYQsKBl5GJdSxtKNd+o=;
        fh=va8ntlGKHMR1qhkjGJ0YUzeMRmloDIQc8p2OTLogyEs=;
        b=Nrk/MWqbhNC7Y7j8iNllyv3bsh5LC3DegH/xHz1xCPZLmo9aRAxV3P3kBxb8i1AhMF
         OYJaukJ+faqLlJdNy+5h1QTlDzevbaBxNZ7ZW05aOhElTRZjeqfkVs4Ho6pqMhoXT596
         nJNto5pnkPsOF+ci99hU3fBzHPmZurWnW3Z3QYUG+4w4ISvw1M3efzDT9GWGcyL5EM++
         OSFBs8loSYvFCkad5tCwd2ntvzq+IQjiB9HXpmyEg9YTG3evI08zH4ABHveFvzg3Z0xd
         uRrqUnVlJIWE5QDzi4FYHOg1HUe//gjQ0LXGQodNLxbdVkjGE5iajm5YDsBWcw1KCm4W
         OKdg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784926176; x=1785530976; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Ir3cBbA+grq0RW9ubbM0IgTXxYQsKBl5GJdSxtKNd+o=;
        b=nc8e+mC+gCQoXhpjxW3fssDB7n+HrH3lAgTBgYct/ASrvaTvVogC0IS+JSzCTBeKVM
         8j1Fv+CwueCtLx78voMhV/KCEXYH64yZrWoB5SYmIE2NHIoBhrYq5PzH1V02EzgsNBCR
         WYWfXWlbr80iGDZYk+gCMIVfZ7j88Oj9ZdcXv/vNN2SlGJyB/KUB2tYH8mkBtEXqXB2g
         AroFCJz9xCBUSXG624vO/Orzmk2tZuyLxF349XKO6+SKgRD3bfsxhY5tTR5NrrTBrs/M
         bndUOwM5YShWqtPhkGPBAWaX+eqn91k3tSaMRX2My/Xph6EepwkGhabqZNi/G25N6pOL
         pv6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784926176; x=1785530976;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ir3cBbA+grq0RW9ubbM0IgTXxYQsKBl5GJdSxtKNd+o=;
        b=X0wRAffIrzelBg57jwus7db4qZAH9vuYdMW1GHrSsNpjCQkiIC5DI0UBpTclMio1Z3
         m3T50BSdkhVS6IcqzeMvap7yxjEjqAcITYFrV2MGJQNUEu6qKfaZiPDRjq5QwsF2dQwz
         ojNKsJTex1g4IDCcWLwm/sZa8RFr9gyB91TO5A4asqzmgcj69EM1sXhLSG34OwpGdr3r
         RhNOcPr5SAJP+WeXCM2hu5Ccpk/jE7NbqTxcgRJ1xpF5XlXd7n1r8wI6d1occh+X7hy4
         zAh5QqYHLDD2KnYW7g/Sx++WI95LZl1Lo+Po55sBfqKmpehIZq9hba9BaV432qVnAdnB
         Dpkw==
X-Forwarded-Encrypted: i=1; AHgh+RqYenmODA9N+1pVIao2Wxc+FfytdaPGtfjgy5w0vMcOAO6UZbG10o26b7xL+I2Qn56jKsCW6Ls=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYio7QZesHP1YiQQsLrIPvaU4BmmFrPO/5rYZil7Se0w/Pafrs
	sYLT+PxItNwjXdTPY3sFoTbh0XfTXblWvUOMw8rTzwGyNc68h/tY16vWXJIv+Kl8ol/4EL6hVut
	rYRZfQ6EhSr6TKT1jE+NAZ/7TzS5SbUDVl/I0GKiN
X-Gm-Gg: AR+sD11S5F2av7NoBf1zkc9OyBSTziVFAURSMcFRWAZ/RYYx6uApHWIDlUjPR2z2Ep7
	VOb0gmDvq2hH6JSxRaEouCmyMlHg5omsMWl8k8jkcJ7Fa9dD+Zime/CVqF18yRKAe7Xp8xc7TsX
	/yyVyzC7q8p5bxjSmKtJ8Dhirb8L0v5WSMsEQkAIFCurGzBY9IpmCX2Q1hjDCpEPAIhychjoc2N
	he7fqcUEaCc00SSNOPtnNLyyNaKlnOX4A84B4TM9sgG4smgR1Mr+/PmGOv4Nao93BCrnn5ysZLk
	7i+TFT1Fodo40uYsYB9tl/mmw1qIfNcm7DrH9R25KrhTjeEzDMTv9z/ljz0M7yALizRvC8y+ito
	=
X-Received: by 2002:a17:907:608f:b0:c19:5db0:edd3 with SMTP id
 a640c23a62f3a-c1c50cf9265mr356852666b.58.1784926175176; Fri, 24 Jul 2026
 13:49:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260718111340.159896-1-linux@yoavmoshe.com> <CABCJKudqGL+BFFcz3qsuoJB6S_OAt-vs2yqePC_=oy+JzmPpVw@mail.gmail.com>
 <3046e60d-509f-471f-bd15-3ce78c87500b@yoavmoshe.com> <20260721180950.GA3684684@ax162>
 <180001f5-bddd-4e58-8442-f7ef3c979500@yoavmoshe.com> <CABCJKufhvTxmVm8y7xr4RWWKsoZk0h8UGBnem+F5fknnimaqPA@mail.gmail.com>
 <7f273a08-b29c-4e15-b340-898b251efe57@yoavmoshe.com> <CABCJKud+GsBVv+XMTsi_4QAaTHo7jXD2Hyvi9wqKd7x3i2xyAg@mail.gmail.com>
 <415ffa24-a30b-43b2-aa6a-a1cde3bd4ef0@yoavmoshe.com> <CABCJKud9B8vB-J8f0HLHw6EgEKVWzy+Q1PrNxpO_6yCGtEyi8A@mail.gmail.com>
 <12a46993-82a5-4109-87fa-61b8fcf764aa@yoavmoshe.com> <CABCJKufoQ0fX797M01t7CkTgMEwNCELY1=ptZsxr=jWOR-KAyA@mail.gmail.com>
In-Reply-To: <CABCJKufoQ0fX797M01t7CkTgMEwNCELY1=ptZsxr=jWOR-KAyA@mail.gmail.com>
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Fri, 24 Jul 2026 13:49:23 -0700
X-Gm-Features: AUfX_myzXob-BTOm6ceAaY-cqbzmlciva43qU3JWJWtP-y4nEwp_xtUIj8U2zQo
Message-ID: <CAKwvOdnaOy-nyZ=8oLw4N-_hA9JZVdP2BhR8cweCAOhsy4VG6w@mail.gmail.com>
Subject: Re: [PATCH v3] ARM: imx: Fix suspend/resume crash with Clang CFI
To: Sami Tolvanen <samitolvanen@google.com>, "Yo'av Moshe" <linux@yoavmoshe.com>
Cc: Nathan Chancellor <nathan@kernel.org>, Frank Li <Frank.Li@nxp.com>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Russell King <linux@armlinux.org.uk>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, llvm@lists.linux.dev, 
	stable@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 24, 2026 at 8:54=E2=80=AFAM Sami Tolvanen <samitolvanen@google.=
com> wrote:
>
> On Thu, Jul 23, 2026 at 12:56=E2=80=AFPM Yo'av Moshe <linux@yoavmoshe.com=
> wrote:
> >
> > On 2026-07-23 9:21 PM, Sami Tolvanen wrote:
> > > What's the value for the __kcfi_typeid_imx6_suspend symbol in
> > > vmlinux.o? I would expect the hash value to look a bit more random.
> > Checking vmlinux.o with `llvm-readelf -s vmlinux.o` indeed shows:
> >
> >   a488ebfc  0 NOTYPE  WEAK  DEFAULT  ABS __kcfi_typeid_imx6_suspend
>
> OK, so the hashes should match. I can only assume that the hash prefix
> doesn't end up getting copied to OCRAM for some reason then, or

Yeah, Yo'av did you test further modifications that explicitly copy
the hash prefix? I assumed Nathan's change _plus some additional tweak
to copy not just imx6_suspend to OCRAM which I assume the code already
does, but I would imagine you need another change to copy
__kcfi_typeid_imx6_suspend into OCRAM just before the function.  Was
that tested?

> perhaps the source of the copy operation doesn't have relocations
> applied? Either way, if this turns out to be infeasible, I think the
> __nocfi approach is reasonable in this case too.
>
> Sami



--=20
Thanks,
~Nick Desaulniers
