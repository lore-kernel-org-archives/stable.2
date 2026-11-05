Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793903191;
	b=1y3I4dpgWnp817e4NOQ7/jWsAqwCx/798gJmcxnqVjZBg/fSzxrz9Ax6NbUrPMLV6iTy
	 JJysSuPqJaDPZqopmlHPEv+lEJiiTgjG4xl0ZFqWddgqz9I1HDxmJWIqhS2U0WDQbTRPT
	 eV032SnY37J5OWC047Shy3lUMcFTEU49GOEpQTyqYUL/nVnhoby5hEsgoplDQ3hRfeKVp
	 2pdyX0lC+VykMxyvpcLoSU8uvGM4PUaHE73xtuViiMxiDNHwnj1krtQJuODzPg8PSR5dw
	 siHuSyQvvHt7mB5Y+VedsJu7m8JqxVVUftSFMWyuTdUyjE0jCUnAENyn0hLdfbOlOOQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793903191;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=ZjZZBHNzUUSdl8+mB6CksZcOvkW2kaVJTAeX6AL9t3o=;
	b=ZLjiiCYkqyMsdhHiQSer/LsihCSCeBXfb3C2kw1dG/BZpti86cwtMekni+Bhr09EERUt
	 FsHN7lTMoWt9QqHj19HZu/cTxRlxJCERCa0bg+i8nmvNoV43D5S4iRAIRTFR7xhsyIXJ/
	 rDbCtqgvD9ZyPfdP1U1QEiHF5qR1jGUPy74FjSlvQMUjkGJSpeUGEx4pP7jAc+7en0IkE
	 KDG9ClExPqO6yBN7r4ZAxSWykq9qXpOGkibaxwWo5hPcWlefku7CasgYUpledvovuGg61
	 +L30dFtiulGbEKvTPNMfHqUz3a2vv0a1QdNOuDocUfEtgV1yvyq+56RBx2coEQDDG1Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JTvvwaXk;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 045F1606A33D;
	Thu,  5 Nov 2026 18:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JTvvwaXk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D79951F00A18;
	Thu,  5 Nov 2026 18:26:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793903190;
	bh=ZjZZBHNzUUSdl8+mB6CksZcOvkW2kaVJTAeX6AL9t3o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=JTvvwaXkP9+gdJl7sIR42xpr0Phc2EY0WhM3xuNdJkWFsPeYNXam7mFT/lilxXd6A
	 j0ZFIs5jD8Spxe8dkW0n2ariVz3YND7QLErOKBx3YiNywrwN9Lp0G+0NVAsL31bIxV
	 FlXmdcvYJX9PUql8Ty3tXo3N7rLyisUQcKQBB0CAGZse17FV05nfdg0HkTBjTZkDCE
	 7HfNFihUQd6jH8wFxm5aOUh8Bf6M3+yWAE/6/2gC5ySwA7PsK3XtJJrWReOrgr9mXZ
	 muv0UQ37OTU45t4EZmmdrlxp1Tny8QeXlFncV59LJHK0Dw/IMauVfclnArhvIkjvSm
	 TxY2KTdOC1hDQ==
Date: Thu, 5 Nov 2026 18:26:26 +0000
From: Lee Jones <lee@kernel.org>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>
Cc: Michael Hennerich <michael.hennerich@analog.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Trevor Gamblin <tgamblin@baylibre.com>,
	Sergiu Cuciurean <sergiu.cuciurean@analog.com>,
	Drew Fustini <dfustini@baylibre.com>, linux-pwm@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 4/8] pwm: axi-pwmgen: Enable clocks before accessing
 hardware registers in probe()
Message-ID: <20261105182626.GM1650678@google.com>
References: <20261105143847.2559586-1-lee@kernel.org>
 <20261105143847.2559586-5-lee@kernel.org>
 <auylN53GJra88-E3@monoceros>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <auylN53GJra88-E3@monoceros>

On Thu, 05 Nov 2026, Uwe Kleine-König wrote:

> On Thu, Nov 05, 2026 at 02:38:06PM +0000, Lee Jones wrote:
> > axi_pwmgen_probe() calls axi_pwmgen_setup(), which reads and writes MMIO
> > registers to verify the IP core version and determine the channel count,
> > before acquiring and enabling axi_clk.  If the bootloader leaves the AXI
> > peripheral clock gated, accessing the registers causes an unclocked bus
> > access fault.
> 
> Do you have the hardware? Or what convinced you that an access fault
> happens?

These are Sashiko bugs, as we discussed out-of-band.

None of these have been tested on real h/w.

-- 
Lee Jones
