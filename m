Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=65.109.113.108
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795065588;
	b=a4ymNnGtP5ypzWrtDAA6JnPKJSvbMdAVwcDvySWsx7aCjA2Us8v42c/R5eLPf4VHpfss
	 PgbM9iWxJ1VQ9I/RJVa+RF6cQDyWGXuIXOxSxn0fjslV59XJpN9c9nsn4Is3ds4CpRePz
	 jqzpbIfE1/d9aEBm3iQJBXCYurbH4O+oc8K5lATJr0nCcPWrDiYB0EqV6iERmrP71xFV6
	 /ht5LPX9IElB+S9WsIkU5V246BVgiaSOD9KtGYvM3XXTZN3hF8bqLt484zD/6K0j5jNIr
	 YwlXPc2cQ6JbNBirrAN2elHcP8YVhKnEAxdG2dYXdacsIejh+en5MAEetuyhIYUkvKw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795065588;
	h=DMARC-Filter:Received:X-Virus-Scanned:Received:DKIM-Signature:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=usC7S19PXBjoXnDBi5olAKQtDP97Tet9x9eMiBimyTY=;
	b=YnRoT6GAEQWAGf8Y71t0GeNllI/WawWQbOIKX/jN5NkpZzh80c2LoQ0CrTeFalBb9ai5
	 FnioaCFhhA+CAXOvzSLMVSQD30mC9hKcUpJt+8JuHEX993EE0ICqBvAAhqDQMOdhbGm5P
	 W0C3Wl5Wkud3PADKFVj4ewgsTyipKtMJmFZ+XE7L1pPMIGp5Lu8OXVGfWqy9f0432vOYG
	 UEVQkMqxv1goGflWrrgVkzVEFY+84VswZ2GgY8AN6v+fqIALb3eTVe/z7l5H5qsUXjp7I
	 n0L5RrppAn1/gouU8ftylg7CIaplN/FnaGpH7h6NBVBpGw93qYxI/ecv6kaYtkNtxEQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=alien8.de;
	spf=pass smtp.mailfrom=alien8.de;
	dkim=pass header.d=alien8.de header.i=@alien8.de header.a=rsa-sha256 header.s=alien8 header.b=JzAbPtkl;
	arc=none smtp.remote-ip=65.109.113.108
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3104A606A320;
	Thu, 19 Nov 2026 05:19:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3104A606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.a=rsa-sha256 header.s=alien8 header.b=JzAbPtkl
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 49DB040E0218;
	Thu, 19 Nov 2026 05:19:45 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id qE1Q3jyGF3A5; Thu, 19 Nov 2026 05:19:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1795065581; bh=usC7S19PXBjoXnDBi5olAKQtDP97Tet9x9eMiBimyTY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JzAbPtklVnJIID0dEUO2BKSaGy0pmmI8kGG7V0p09xPa03eb1q6ZTCN0bofsu3PZz
	 DT7yXPRWgdvDK97YTHgPbCxv8N9xoQGCIze12mGG8X0YL44GGDa3OVwT65qb3lGCrJ
	 WLY0JGDyZ8TRuIHlmrD8mVRQuiEdrP7orijJQDbQcSNMRsZKrc59SaEU1B3oG4k3ID
	 vT4mc3ibn5V2tJ6TxLnXbFmduIh0X77SYF4TOfU+Y9q2jMWP27jyONmxqsBWK9BIUv
	 cqVURqAHo9Fl0c3zMKyJX/5jHro0KTBY7zTheNm4cqzdoL5NnlvqOfB9LNAVP8ll6d
	 KkIQfgEgPySxEo9CsTfhIUV/PoaQ4gMorl/vVGU5k6xAT12H7tfvclXRJb5VbDUnGU
	 1JC+u6AD3FaaxKXJWOI/8wvrbRjeyyM828S/fP8vuLPVjYz6vNBP17xpHZyvsytwSG
	 DU6NzZKMle0fuqENHU7udJxdr0XYcEzkBgWqeVxL0iZis7kz6Vwki7QWsRQP3W7qnA
	 5BrqHJ3CfOS1AjYy1LenX1Iv54Z1S3HS3xJlPWec7Q24rvz2fPmtxTB7391SpAR7k4
	 BOVedwHdlsqZt2FhGLfBiFO6WvEKZmiiw7zbAGvaXx26agyoXVSsGLQM3WGN9tHj1W
	 yQ834ceZEgffQU3aDxkgg9Yc=
Received: from stx.tnic (unknown [IPv6:2600:1700:38ca:c00::2b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id AF51040E0184;
	Thu, 19 Nov 2026 05:19:33 +0000 (UTC)
Date: Wed, 18 Nov 2026 21:19:30 -0800
From: Borislav Petkov <bp@alien8.de>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
	linux-tip-commits@vger.kernel.org, stable@vger.kernel.org,
	x86@kernel.org
Subject: Re: [tip: x86/urgent] x86/build: Do not allow X86_NATIVE_CPU to be
 enabled when compile testing
Message-ID: <20261119051930.GHav6G4kxjPcyBI_uY@fat_crate.local>
References: <179480914308.3191731.6125228756396043444.tip-bot2@tip-bot2>
 <avrPcQ4sOkgJPbkZ@gmail.com>
 <20261116130159.GA1327949@ax162>
 <CAHk-=wgmkoWHWwaQ6nsGoCiBp0hrpJuiwmoVbQ=Efun8JyUNKw@mail.gmail.com>
 <20261116204517.GB1037705@ax162>
 <20261119031635.GFav5qExslqQpbK2Oj@fat_crate.local>
 <20261119041205.GA1218811@ax162>
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
In-Reply-To: <20261119041205.GA1218811@ax162>

On Wed, Nov 18, 2026 at 09:12:05PM -0700, Nathan Chancellor wrote:
> If there are no objections, I'll send v3 within the next few days. Let's
> take it for 7.5 instead of 7.4 just to give it time to soak, I don't
> think this is really high priority (and I am testing -next most of the
> time anyways).

No objections whatsoever. Take your time.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
