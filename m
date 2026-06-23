Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F7E22D46B3
	for <stable@vger.kernel.org>; Tue, 23 Jun 2026 13:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782221721; cv=none; b=OgiKl6Wx4gByhj816mdZvrpxTsYievQ5ygao5C8l8jezsrcmrv1/7gKc666LVF+QjKOt6vHcHFX1gOYcyFrIpv0wNlFyXYyCv4crd4dB773PqWJJI68no0md+JSnPmt+iyHK6WdY0RyZWJk+RxyfntF+D+we25s+NIctsqDpftE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782221721; c=relaxed/simple;
	bh=70Mss4+1TNhqcGzR/q9is2zVGgiFexamRA5lydNN3wc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QMShO5sspm/r71a4IAqiQ0Nzxx9f1t9DHXtoH0dKMN0L2osoCzsNLnL2CHosvJXBc0w3iLT/YLDDrITD1YAKfaviDQxcST5Cem+epEPBEBNZdy7V3u4qEX63T/ilJlZbr3QY3CDDADY+YJhC9SH1f4vYqoiAb5Ae42ItfpOGxWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o3ccrfOQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o3ccrfOQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 179801F000E9
	for <stable@vger.kernel.org>; Tue, 23 Jun 2026 13:35:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782221720;
	bh=70Mss4+1TNhqcGzR/q9is2zVGgiFexamRA5lydNN3wc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=o3ccrfOQRSDKIUBli16fKYFBhxAZEuc39NhfUI2G8vzTMgXjue9Ew13AikAXGdQJe
	 8W+X3M+BrKe5eiM1n/D7fEbCyU0kh4QVdgjb9VzjYCnIrw9UzJUy4MjD179WL6iAKB
	 3ETiweCFL1WtN2+vLAdeY0DJalHZ2/bpCAIUqZENst/ZcnSw2HAgiTgc+Ddm26RwYP
	 //irFuPogxX09otGYxCNdnFtvIK6ECiGDTjcjcS649s5+BHdju4qaW30rEHQusornh
	 z8fKrogBRiGA+uApZpPxtF3AD+GhrGC7/KYL+/BRrkTud/WsdXrDBVAYoakbqLDYWH
	 +6B80/yhAAqsg==
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-396775c26e0so53776421fa.2
        for <stable@vger.kernel.org>; Tue, 23 Jun 2026 06:35:20 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ94PtJ5edkIbP4BvXrIkmxCJqFUq3Pb3ASmrUzKbG++oCEj4vhK4i3jKjC6i50RYEOIVSdYXYI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuzCM7+Hd1aClNq8VJpVAfqjrZJZQnayWJ4Mr2K/IEMH5Qobef
	ar50LYMWQOm+jv2Zn5u1hXtelg+ejPRs6KMLtS6tVb1UIKTgW0HQmWDyUipDdsESPWQDuo8ayyu
	N2SnHw5x51KbJMIghF/90mBhRZq5E+CE=
X-Received: by 2002:a05:6512:1318:b0:5aa:6af9:3829 with SMTP id
 2adb3069b0e04-5ade4743aadmr729184e87.29.1782221718829; Tue, 23 Jun 2026
 06:35:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <kJqktbpLphg_Pk5I5SPptgTLjl3E3eq5mN5UzCslyFj7Q1Irp-wDid4mj5eQVd2iZtRGXgeZd8goq195EkXdjyt864YMc8mVb2B9NGH91NQ=@protonmail.com>
 <ajhHYKyvL9nCUvG5@shell.armlinux.org.uk> <zbEOoL4_phCCh7td7DwqQtyhleFJ_G3yRBc8AFjT5hwIwcRipRMsjtIVJgLi3t5vJk5QsuKjY9c8I91nuVSYk4-xlzrAqigMWIE0iNMc9PM=@protonmail.com>
 <ajhof3cRtiN0Hk7k@shell.armlinux.org.uk> <ajhyyq_SscBAOFFY@shell.armlinux.org.uk>
 <DUmi3WqfISs6WPqSP0CfEAYosyWQN5F7owhotvDcuyyv7WFoloOeHyoatIx6TKimecbF_OFncDikItB-0ubyO5doBOvsIhEKMQsT2wHyeuE=@protonmail.com>
 <ajpWaTW9uXWqX1OA@shell.armlinux.org.uk>
In-Reply-To: <ajpWaTW9uXWqX1OA@shell.armlinux.org.uk>
From: Linus Walleij <linusw@kernel.org>
Date: Tue, 23 Jun 2026 15:35:05 +0200
X-Gmail-Original-Message-ID: <CAD++jL=C0mnn-PCqZB4zg7y1=u-W4mEOt+NR3OQFzpdwSR-9Og@mail.gmail.com>
X-Gm-Features: AVVi8CekqyKNtvNu7_t4CpWgRPnDKVuf3TPT7Vt5cGlAgnbP8YiaCd5H7GaSOBc
Message-ID: <CAD++jL=C0mnn-PCqZB4zg7y1=u-W4mEOt+NR3OQFzpdwSR-9Og@mail.gmail.com>
Subject: Re: [REGRESSION] 32-bit ARM's BKPT instruction no longer works
To: Russell King <linux@armlinux.org.uk>
Cc: slipher <slipher@protonmail.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"stable@vger.kernel.org" <stable@vger.kernel.org>, 
	"regressions@lists.linux.dev" <regressions@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 23, 2026 at 11:48=E2=80=AFAM Russell King <linux@armlinux.org.u=
k> wrote:

> Let me also be clear: I expect Linus W to fix this

I'll try!

I guess the offending commit is:
commit c3f89986fde7bb9ccc86a901bf28e1f7d69fc3b3
"ARM: 9391/2: hw_breakpoint: Handle CFI breakpoints"

> I suspect that the CFI fault code was a decision by compiler authors,
> but I can't say because I don't have a setup that generates the code
> for CFI.

Yep, the LLVM implementers chose breakpoint code 0x03:
I think it comes from here:
https://llvm.org/doxygen/ARMAsmPrinter_8cpp_source.html
Line 1536-37:
unsigned AddrIndex =3D TRI->getEncodingValue(AddrReg);
unsigned ESR =3D 0x8000 | (31 << 5) | (AddrIndex & 31);

Yours,
Linus Walleij
