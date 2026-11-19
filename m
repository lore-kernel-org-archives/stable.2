Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795116103;
	b=srHzBfMlirWIhm9yU5MBNLMxDr9n8E0qZfRC5H3BhLwO3pbf1KvMQ7vWOTa/pq6igQsJ
	 6kYubWjuH3fnn/F4VgC3PwE8lsaUMelo4yTzondwJKaQhTZRQJ5w2r7/SvQkFhC3d+dvo
	 bCvACc3h9amn8uzShO1+ns5YJBRCUqJcIF6UbO6zKLWL6zCvjaui/MVmzINHZaRdCJ/1B
	 nMMo8o2/CSQydeuNWI7CLn/01yfPoETXbrGhiU+MWjUZv8AoPBM3aj958JCJdLM8eIQK8
	 ERoHc8c+D71u7zNJJ5j1CCTWDCGVhX8w0ciTKraYFh+sF72VxACJ1k9RY6Ehyn+uqBg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795116103;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=t5b45MJbXxk9U+wWh1HRCpzHlvIbooPndscEKlY6KHQ=;
	b=bZaarM52cdNnvRkDYs5Plo/Qaa0OCOM2CUxgfACzVfDj6EF+AZS6Ldqjp5eH74uvFhWc
	 tprcOg7olpaSCQ+Gyz8PMBqBIZvBLczRMCVZG908siZf9/CBWaSlmGdH1KyJvLYbFfmIk
	 DU/nqfZkSAm6OlbyyFSxKyIhoETmr1xh+tiDRqCkNSET/ERx85kue70cv1nIoeG/0R9B0
	 4wNgL4wEX+eM3Fmx2qV7wMUPJ2zTGb3SOIW2U2qIE8xyVCOLwsj8S7X1i8gVp2ccRyF5y
	 l6CEuv0KA7kkOCzrephsaC1+/nFCvdTsmfrmSns2leFpiNAHdENp7uNHnT0KKsBuCPg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EhQodG4n;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76443606A32A;
	Thu, 19 Nov 2026 19:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EhQodG4n
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FDB81F000CB;
	Thu, 19 Nov 2026 19:21:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795116103;
	bh=t5b45MJbXxk9U+wWh1HRCpzHlvIbooPndscEKlY6KHQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=EhQodG4na0jHn78oVrJIVn4+BSo66drPc/w0dCkMwaV688VaVEMLeBdKeBge89K1T
	 TkN3H+r0ZXlU9vtZOIMTA1X5Bt7x31v9gyt/lAye2b3kBLKnvfxDNk5Gp6rvloD5IV
	 hmiNA1bXy66gsCPIZyVcdyzdvuk1BE6GxnVE85DgvC2sovWD01f2p+6julKf4wGBhA
	 PYNF1aF14h9O+0IF8p6Ae8R0DhN9utvpXk68CKCaDRqXNFyIS5uu5YtQdj4gqrEtM5
	 nUMhGGXQxfY3EBo4kefZgitcSELA9JPCaSqWny9TAWwZcFeTvuGhZF7pVt5b9dsGVA
	 nvEUsx8JOM2JA==
Date: Thu, 19 Nov 2026 12:21:39 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
	stable@vger.kernel.org, x86@kernel.org
Subject: Re: [tip: x86/urgent] x86/build: Do not allow X86_NATIVE_CPU to be
 enabled when compile testing
Message-ID: <20261119192139.GA875856@ax162>
References: <179480914308.3191731.6125228756396043444.tip-bot2@tip-bot2>
 <avrPcQ4sOkgJPbkZ@gmail.com>
 <20261116130159.GA1327949@ax162>
 <CAHk-=wgmkoWHWwaQ6nsGoCiBp0hrpJuiwmoVbQ=Efun8JyUNKw@mail.gmail.com>
 <20261116204517.GB1037705@ax162>
 <20261119031635.GFav5qExslqQpbK2Oj@fat_crate.local>
 <20261119041205.GA1218811@ax162>
 <av7BgoDGvN15sdNq@gmail.com>
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
In-Reply-To: <av7BgoDGvN15sdNq@gmail.com>

On Thu, Nov 19, 2026 at 10:29:38AM +0100, Ingo Molnar wrote:
> Sounds good to me (and v2 looks pretty good as well) - and this bug
> is pretty old, so you are probaby the first one to trigger it and

Yeah, I did a little more digging for the upstream report [1] and it is
definitely an odd corner case, so I am not surprised this has not been
noticed before :)

> trying to do something about it. Sorry about penalizing your diligence. :-)

Eh, I don't see it as penalized, coming to a solution everyone is happy
with is just part of the process. Thanks again for all the discussion to
get there.

-- 
Cheers,
Nathan
