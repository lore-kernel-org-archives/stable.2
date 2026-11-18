Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794986933;
	b=RdIV0/sLMiAoj+bTFDz2UXvwK4480fzss7Sg9uHl4AjkIvMM7dqWN3nvqx8lyAb+LmHF
	 dPNXtc84QrfBhD4nTPgfZaPECSpgRdw4w1LIq/eWy0DwDWDD95LoSkUwcs7zFHHFhTQx2
	 KZKUO8PzHy/mh5dZ5Z5bTVhtG/z1wbTUEGxAhJUZMdbXe46VQqEt08x0vNMuvQKG8s0h5
	 ymyJC95HpCbMIOanJ1alsFmRpSE46NpCrnby4YMe3vs8HpSKrL+cJY9wEc546AyhuLb0R
	 D3HWaJTumAlC4QRjkDLPi+dDp4v8puUCLkmJvIqRHSTGFsriJG7YOon18+yG/oZDPsw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794986933;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=vsqpXrvhFD7jKsDFlhV8QKdSwNCeLB3Iu8VGRA5Wd20=;
	b=Q39VQ/AN7QrsXCYamX5HQoCbdF6yhVSZjky4KXmKwOX93syJU5K4vdfe0+vK8NXNfVbY
	 5vp+D76Le56OQQ5RylGMaIR17KXk4mFHR27SQ3e49Yc1fow6rgcBI3tQ+ZPVWxpv0YN0a
	 urdmKrKXIr0x5KdEo2rnRJ5zGMYLxd3LYYIoFir6aqm5pnu8G9q7rTmOXORkRPs9JjB2w
	 SEiJv3k/1GAnpVpDmqzyLz1Owq9sqAbhW/+m0XvFbpABSOhzX6c6EuBcLdjFAc0BIkzYv
	 dkpVcoNVBZ+1KLP8HaoUY1OIpfojXcQY3MZscxP9vwflVjrC5nne8WtwyDgyXcKWf5w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iXrceJhF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B31B5606A31C;
	Wed, 18 Nov 2026 07:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iXrceJhF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A23BC1F000C4;
	Wed, 18 Nov 2026 07:28:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794986933;
	bh=vsqpXrvhFD7jKsDFlhV8QKdSwNCeLB3Iu8VGRA5Wd20=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=iXrceJhFerACI6Ppd4V83Dg+h+bRoQAe0orBgaIV5N6gUPDgFioE0P24lCO9kPcSf
	 ZNTU3zMyboNMS8DM25MvrYMyDBTZDksQenxIa4OEw907B5xTS/VN1KOVp3UsinqqsW
	 IFVW6YuRC1BecqbwVb/WzlcGzBANewOKibF8fZhZTcKo+Jn+WhL+tgSACuxZ1gP1w9
	 UUos1EZBM0TGU4U3+oTw2/xF8KFZyIwyDLrx5mRK1gIfOOsaxR2WtNgj6+vGQTRXen
	 ZGV/dn6m2qK9MYdf5SgjiLekU/+iTmsjbLep2eT3OLvd44bteozKEAGc/4AxZtyLOP
	 W+KN73HLlkaSA==
Date: Wed, 18 Nov 2026 00:28:48 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: David Laight <david.laight.linux@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
	linux-tip-commits@vger.kernel.org,
	"Borislav Petkov (AMD)" <bp@alien8.de>, stable@vger.kernel.org,
	x86@kernel.org
Subject: Re: [tip: x86/urgent] x86/build: Do not allow X86_NATIVE_CPU to be
 enabled when compile testing
Message-ID: <20261118072848.GA325225@ax162>
References: <179480914308.3191731.6125228756396043444.tip-bot2@tip-bot2>
 <avrPcQ4sOkgJPbkZ@gmail.com>
 <20261116130159.GA1327949@ax162>
 <CAHk-=wgmkoWHWwaQ6nsGoCiBp0hrpJuiwmoVbQ=Efun8JyUNKw@mail.gmail.com>
 <20261116223628.5a6139a7@pumpkin>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261116223628.5a6139a7@pumpkin>

On Mon, Nov 16, 2026 at 10:36:28PM +0000, David Laight wrote:
> I don't even remember a check that the compiler is right for the architecture.
> I'm sure I've got strange errors when I've forgotten I need to specify the
> compiler for a cross build - and then forgotten where I'd put the compiler,

Yeah, I guess having some internal check that the correct compiler is
being used could be useful/user friendly but given how fast things
explode otherwise, I am not sure it is worth the additional complexity.

> Oh and forgotten all the things you need to set to get clang to do a
> cross compile.

  $ make ARCH=... LLVM=1

is generally all you need to do nowadays.

-- 
Cheers,
Nathan
