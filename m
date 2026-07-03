Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5B75386440
	for <stable@vger.kernel.org>; Fri,  3 Jul 2026 11:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783079248; cv=none; b=O1mVs3xW51L7QzD/iLilSdJN5IegEQIYAQABpTiVwpq5Y8NI9RC/EOjmly/d2yb33qcf0bl0Vzl1k3w+6ZQZqTQpioLUVLGrR0sv0xfxvJLqNwAISWpxMd8eFoQyWCyl5VMCXmcmjYMdBQUWAnRcF+FoVbKYuu5ZV4y9a2wj1Ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783079248; c=relaxed/simple;
	bh=PAqfQAOpMlMDCw8VgFjXaKgS8Em1IBXIvmErmx2w6HY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aPl/w/BYB4wFJAzEHMFDBR4cWka9drCh5WuBxHKkitMN43B1AP0hQNDZLpq4W2fCyVLgWc/EQ8EuhQEUx22f7aNxD4zxT6OSj57uIN6mNTVv/F/f5QvDeJE8TfmC12mtY8jwUJDkfwi7IwEj8ssT/eB28IddsKxBGOoIG9i62Bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PiaJW733; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PiaJW733"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A4971F00ADB
	for <stable@vger.kernel.org>; Fri,  3 Jul 2026 11:47:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783079247;
	bh=PAqfQAOpMlMDCw8VgFjXaKgS8Em1IBXIvmErmx2w6HY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=PiaJW733uwYb8erG29p49uhNQfoo3dgX4tI31n/7Cka2uYkC899P/0dvWym1mu/Iu
	 poc2i6mHcgT7zFGmBankKzqZLWdahpops2eopauVNQytOApiTcklTmxJl4+3up/Tu3
	 qLXVOycUKC9th+4dZhwvg3K0nHqS62HCX4epWVvvPGiKGZlDEGo1Lfxt2pciRgofYx
	 p4UkSpW92aQMmkkFzVQBy76H6y1NlsIMjle9SYRX9k4cKvLmCGWLI6LnIv7jOel0wp
	 XDF/ys6Df4nPSbTX5QGVZB6CdkMdPow4vItDPpAxtKylZ+zRcXJo3XBc76lLlYhqmK
	 OUyAeGOB6lk5A==
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5aebc8cb5bcso356903e87.2
        for <stable@vger.kernel.org>; Fri, 03 Jul 2026 04:47:27 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RppcCp4zjlK0i37ORTw+A67pL/oWyycukKj9axJa0HfHdGIc0fJ4TrjJiYSEjvwkucRnLtxXls=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2bPE9mKPvsJnHfv3dRtY/zS9w+aid56GxzW+Jf839ZlB6/4J4
	z2RpDw+QbKlsiB1LkifBtcA0lHEpQaJTyybOAPEf60YhKqa9PYBGZGoHXI3bxeOobkpVunVtaTZ
	uPoG4m9+wSPqaELi9/jq766VbyMFQJG4=
X-Received: by 2002:a05:6512:a354:b0:5ae:ba3e:a6f6 with SMTP id
 2adb3069b0e04-5aec67a2b83mr1899880e87.4.1783079246183; Fri, 03 Jul 2026
 04:47:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260701-arm32-cfi-bug-v2-1-9bf922593e00@kernel.org> <akd5_G5oA2dxdg89@J2N7QTR9R3>
In-Reply-To: <akd5_G5oA2dxdg89@J2N7QTR9R3>
From: Linus Walleij <linusw@kernel.org>
Date: Fri, 3 Jul 2026 13:47:14 +0200
X-Gmail-Original-Message-ID: <CAD++jLmnUX0EHpjqGc6Pk3bXr0XTp9r4+rPSNUYVwk+e0JMgTw@mail.gmail.com>
X-Gm-Features: AVVi8CfUHAbqySS7cIAW-rrONys-5i7T9Hv7PNMZ8MoGQJy-d4zcjDrgoR6pU04
Message-ID: <CAD++jLmnUX0EHpjqGc6Pk3bXr0XTp9r4+rPSNUYVwk+e0JMgTw@mail.gmail.com>
Subject: Re: [PATCH v2] RFC: ARM: breakpoint: CFI breakpoints only on demand
To: Mark Rutland <mark.rutland@arm.com>
Cc: Russell King <linux@armlinux.org.uk>, Nathan Chancellor <nathan@kernel.org>, 
	Sami Tolvanen <samitolvanen@google.com>, Kees Cook <kees@kernel.org>, 
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	slipher <slipher@protonmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 3, 2026 at 10:59=E2=80=AFAM Mark Rutland <mark.rutland@arm.com>=
 wrote:

> AFAICT, hw_breakpoint_cfi_handler() is only intended to handle
> BKPT instructions executed in kernel mode, and even when the kernel is
> build with CF support, it doesn't make sense to call that for BKPT
> instructions executed in user mode.
>
> On arm64, we have separate paths for BRK exceptions from user mode
> (do_el0_brk64()) and kernel mode (do_el1_brk64()).
>
> Surely you can check kernel_mode(regs) or user_mode(regs) to distinguish
> the two cases, and only call hw_breakpoint_cfi_handler() when the
> exception was taken from kernel mode?

You're right of course... I'll add a check like that and see if this
solves the problem for the reporter.

Yours,
Linus Walleij
