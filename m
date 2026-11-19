Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=65.109.113.108
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795058213;
	b=Z4dfFQQLU0Ui0aaAyv3IvAvTx/jlabLMjSi94Td00qjEp4MnI6kkVGoauu9IIq0tgpCB
	 mgRi7juYXK8jb2QtBZZZSOGjqQc2LnfrJ6osR8uPU1031Q7BnhrhwA2LQvOUELN5TrZ0y
	 G2wPLRQprE/t/6MWgyerHmFHvXUyIPZGY9kGtKrfbGnjWEhJDwkMw6IkwQqeb1x9XcCqD
	 TAMXJQvMOizs8jNpL4yT3PGZg9XFrxMmS7ilKFciMbyd6/s1beU/HgGuvnESj+4Fklnfo
	 6YTJSmct8+g/V+14Ekq/X2txJSrcUfPSi8cgcT3+gK5AdQIM+oBGuckyJWyweteG6iA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795058213;
	h=DMARC-Filter:Received:X-Virus-Scanned:Received:DKIM-Signature:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=VtkJ3Z4Keaaf0a1f0xzm9Icf8cIV2tuP8cugNZuGT54=;
	b=pnEWw+KM12h0HynhF/6Uy6Z8cmMD0mwhWtBjZkYnGOSZNaM2DZgm5Xaoek72Rg4K27Qd
	 BoqftT/n8vBKUiocIAz4YQYlaObA18wvbtHhiB+taMqIdhATyM8wglG8Y1HGmkWZiprP8
	 fnEM401sPXGjUSbnEYeSHUyDuX+NnZ5CDq1AmPQOX2bN7OGcbVAWsZL8KzR4V4N/9njf6
	 8czoc7BgKlyUCgM67e6bCUJP6RzLHmIVVLm19q8C5A1p66mZltnJu3eOZhn2ziLi0rIE8
	 qGEXDiwKaa9LiZZ5AuP9sGrWjQOAoxlN8tW8Jagwmbl83A9pzD69N3It1WMzxvW0+9g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=alien8.de;
	spf=pass smtp.mailfrom=alien8.de;
	dkim=pass header.d=alien8.de header.i=@alien8.de header.a=rsa-sha256 header.s=alien8 header.b=V3EMdyEr;
	arc=none smtp.remote-ip=65.109.113.108
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A10C0606A31C;
	Thu, 19 Nov 2026 03:16:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A10C0606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.a=rsa-sha256 header.s=alien8 header.b=V3EMdyEr
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 4DD8940E0218;
	Thu, 19 Nov 2026 03:16:50 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id VpHH9U9LXYh2; Thu, 19 Nov 2026 03:16:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1795058207; bh=VtkJ3Z4Keaaf0a1f0xzm9Icf8cIV2tuP8cugNZuGT54=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=V3EMdyErtl3+eb0ARlj5hDQnMTaOP6JbLxR5nOtglrX+Ro8LaD/q3mQURtXEWna27
	 3K5MkmKqMoPCcAeb424PU0F8PGncmwrn7EUL7zyWITen+uDb4W0o1Lo1QMfkCPqIMs
	 +OM6C1dDQXz9Exj7dPafMT9B5STAkxMRa0ztA5uS2GmmAbclZmk314f824ajt0yayE
	 Ksp6rvUURy9xOPb0Z/rOAteEPgyEDeNaXSHFuwXzPVjv1Mnz7CrA3eJfXFLxgAp6hS
	 oeWiWJ6LcwlPxrDyl+09JNuG6tOPxpWPsjnsrzDsEwghAkNxYi+VA3XLXlolEOSbKp
	 u5SpgFBBt1UjLoA8bW5uxxcbPu+PHWiwUrv+Pj6imULat7l0JW9/duqZNYPcqJIZKb
	 XTQmCLNs9CygKamvnjBmmK32rqigDjLgdKGi+ObTeKIfKyhkMXlQjgA5nIJQUal+jJ
	 u8cF4TSftjQC8I22sVeCaJdoxCGbav7IeEfpq2aVpQBT4DGI/0s3NvV906ONWsfLms
	 OoGqh+R4plMdxcfKJob6C5uJppt0J58q+kCFgNpsvKR0Y3K6H7uX4zZ0VHgZSZaLGd
	 ZAe0GW+RjWKIdnXGiOfn+8OlRrersmS1xfkP9DEC8RIjym+iMLkZHoScoCt78q1lRg
	 U2ZxYRP4ALWvcg0hLR68Irv4=
Received: from stx.tnic (unknown [IPv6:2600:1700:38ca:c00::2b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 0A9AD40E0140;
	Thu, 19 Nov 2026 03:16:38 +0000 (UTC)
Date: Wed, 18 Nov 2026 19:16:35 -0800
From: Borislav Petkov <bp@alien8.de>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
	linux-tip-commits@vger.kernel.org, stable@vger.kernel.org,
	x86@kernel.org
Subject: Re: [tip: x86/urgent] x86/build: Do not allow X86_NATIVE_CPU to be
 enabled when compile testing
Message-ID: <20261119031635.GFav5qExslqQpbK2Oj@fat_crate.local>
References: <179480914308.3191731.6125228756396043444.tip-bot2@tip-bot2>
 <avrPcQ4sOkgJPbkZ@gmail.com>
 <20261116130159.GA1327949@ax162>
 <CAHk-=wgmkoWHWwaQ6nsGoCiBp0hrpJuiwmoVbQ=Efun8JyUNKw@mail.gmail.com>
 <20261116204517.GB1037705@ax162>
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
In-Reply-To: <20261116204517.GB1037705@ax162>

On Mon, Nov 16, 2026 at 01:45:17PM -0700, Nathan Chancellor wrote:
> Hmmm, not a bad idea. That does seems to work based on my initial tests,

So I'm going to zap what I had queued until we figure out what we really wanna
do here.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
