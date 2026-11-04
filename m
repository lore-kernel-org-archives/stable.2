Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=65.109.113.108
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793810445;
	b=dx9KcfmPdT35PSJN/vVAcPWbhczoyuqFf0B0WR0QrfaiDZy4rv7/rQmaCujfn4wUmtEG
	 PJYq99OQ0UTeoh8OnVuSesO7J9FIYIxpsmm2vaC2Ykx/tjYxepD4d3J3JXK/dTRHHaeBS
	 fzBKmbna399BOdat84cDXXLq8ZTmJeNIHEWH6nyx/XbDToQaZhJgfMeYETwo/X+VWacxC
	 JmehmPPQm4ROVdgjZYirig+fVb9BweHimoOtgBtAkL+q77MnByp0JkZaddsO15BG966Aq
	 arKfqTK3aQy+gw3hZEjleRskgaILefnsLOWZ5xBYkK1xtvYu4w1tvpzW6b0aTNDeyfQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793810445;
	h=DMARC-Filter:Received:X-Virus-Scanned:Received:DKIM-Signature:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=whZk+5U0IpKR83qFbEVlR0PotzEDhK1VrQ467+d9wH8=;
	b=jZ6FM3nPtjxqdxPsScemCMAZ6263suj7UD831q+MTeURsgKDyT7P5bhqayMGy4BFllru
	 lDAqFNvllsh5xW3pUXGs63ZjXI7Ng8HciHhEUlpw30+3MrQZAj5ukB6UBCuZh5xGM+OzN
	 4w8WFBfiu77O5tfqb4gnLvpv/TUhbz1cG1hPdBxRYXoNTfkd3+ZcC88Hb2BAxoPVfTecM
	 7jR+WkJjIyocFTXGgxFY4mdd7EO80dSuSBIhHlYXWO9bbnMDfby8edYFXN96CcP2143at
	 m5jYjcI8YEnulhlO6WoymPvcaprM/3pGi/NpvJjW4wAE7tkONw58823/NI6ceAH8Q6A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=alien8.de;
	spf=pass smtp.mailfrom=alien8.de;
	dkim=pass header.d=alien8.de header.i=@alien8.de header.a=rsa-sha256 header.s=alien8 header.b="VPjh/r3+";
	arc=none smtp.remote-ip=65.109.113.108
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22E7C606A32F
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 16:40:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 22E7C606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key, unprotected) header.d=alien8.de header.i=@alien8.de header.a=rsa-sha256 header.s=alien8 header.b=VPjh/r3+
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 2807840E02CC;
	Wed,  4 Nov 2026 16:40:42 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id H_IiZZlUFf1M; Wed,  4 Nov 2026 16:40:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1793810436; bh=whZk+5U0IpKR83qFbEVlR0PotzEDhK1VrQ467+d9wH8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VPjh/r3+d2c3EQqX/g0JjvkmtKa2pZGJkERnnpGalXeEXWkSWlli9w0LRKZzrS8ZX
	 pOaH/2RJakCHNwA27IAt/GOAmHgyXvhk+qqv37WNJrwDgGCJRSzgvBg3J4K2+cT2GL
	 b64WBjeBdtlDp634yWJ+s3mSqjkHiUOJYD+RMiKQkfQi6uUDFqTkdqQVMJWvkoAxxM
	 SqWcR9uxkkAzW0rb/FjLbbw1zGnPadYpZmCWrKVd9+NpVbM/9+RxWRxv9qqhKs+JbR
	 THig0JOrmN7LbjJ3VCKZzLYbgN06ZWzZo4CtTreEVCsXu3JiBNVt0DO3T8NvrKMp2+
	 P27YmfcVyJ64wV/DNs4oX5cdlIKsKTcvpaOwRHcZEHEoBJcMwOpSjwW3E14/QMgFDZ
	 8gZveAjFnPVNrdlBAI+r7nppMAi6Agj46N/ws/M7S1/Td0CSf8YucDePjbzFTyQjjg
	 KBRkXW0Lj9dXu8+nK4Oh2HwRyNo4CVpabWGdeGQP5n3uFPMvGLOJ22GBYltwDz1pcq
	 d9AoAs+0wFxGl5PQ0xFJSRFQ/2r1EEMB69FQfrzEz41P1DhReI4q9B4ElPY+vA96ld
	 +jR3Mn8LERne8Xy64PDriagZW62mBr+uGRl8zBkwIRqTmW7N2DkqPS7xCK2Flpas6E
	 /6j4AuZGGXwdbLQNoT/swX0k=
Received: from stx.tnic (unknown [IPv6:2600:1700:38ca:c00::42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id EAEE640E015B;
	Wed,  4 Nov 2026 16:40:32 +0000 (UTC)
Date: Wed, 4 Nov 2026 08:40:29 -0800
From: Borislav Petkov <bp@alien8.de>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, sshaiju.lkml@gmail.com
Subject: Re: [PATCH 6.18] x86/bugs: Adapt SRSO mitigation to Zen6
Message-ID: <20261104164029.GBautf_X-KzjRfCSSf@fat_crate.local>
References: <20261103182143.27403-1-sshaiju.lkml@gmail.com>
 <2026-11-04-1-daily-reply-0003-re-x86-srso-zen6@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2026-11-04-1-daily-reply-0003-re-x86-srso-zen6@kernel.org>

On Wed, Nov 04, 2026 at 10:03:12AM -0500, Sasha Levin wrote:
> On 2026-11-03, "S Shaiju (AMD)" <sshaiju.lkml@gmail.com> wrote:
> > Zen6 has BTB protection which isolates the different contexts
> > (user/kernel, guest/host) from one another. This makes the SafeRET
> > mitigation there unnecessary
> 
> This is Zen6 enablement (a new cpufeature bit, a new mitigation state and a new
> sysfs string), not a fix. It has no Fixes: tag and no Cc: stable, and Zen6
> already gets the correct SafeRET mitigation on 6.18 without it. 7.3 doesn't
> have it either, so I won't queue it.
> 
> If it fixes a user-visible problem, please point me at it and I'll look again.

It gives back a big pile of performance and this will practically get
backported everywhere. So I thought we should preempt all that work by doing
it ourselves in stable and people can pick it up.

So yeah, perhaps the stable rules do not apply, or maybe this one:

  - Serious issues as reported by a user of a distribution kernel may also
    be considered if they fix a notable performance or interactivity issue.
    				^^^^^^^^^^^^^^^^^^^

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
