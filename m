Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795542291;
	b=C5k5a1H8iRJeJ2lmg2nBMWrTi6PFnk6dqGqbsHj/fxJJXCWhFjbFINh3PBd+vcsnf37N
	 1Efb3LVGvTzIooTtV7fc0jBY6KAKnW1loGjqXeqxHb4c6soAexAHlsBqHnX8aMWVByAXs
	 J/oZbcHxgjDVrzpaT5HYvo0rigygZWTO9hNZbRnNQftEO9MmxV+k9jleGcuklXbYcN7v3
	 wGGN9U8Dwh30GI3ojxemiUUK1R+aF8Oo5nfQ/APvsY6TkbmKSdgwqkokoDLz37YSowSRw
	 jrAs0txWUPWuN5fbzs8bHS5mOUZlkHayiqxB8I+d8jfVh+pZjHRGpLWKfofBbgNPqJA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795542291;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=q+3U1Q2zApI9ESCrs1/K1eJ+2sqiL/C+z/Ifq/99hF8=;
	b=cY2Pl/bXGIHJJzKnfhKP0xi61W54dJnGpj1OgcJXQVimnsIfI/QegzDSDxLMnkYAJ8TU
	 gRwMcO7+iPb5xuSyyNQp8WEWCJ8kNeGEYUsUHTaHzj/W2l28pq20sJreZbuLyXaNlrdBr
	 of6DUy2o9ZYcZfVzEen+NMF9hQNBa+wZKJEx3k17OAtexwOVD6j2ytpR37du8reRjTNyn
	 43Tp0ajmISMR5TbFGWBFmDF5dRM0MCMeTmi4R587TxofCmnjuCp2dNF9/O547L3jzREEm
	 1K4faUpWdanitarEisHxTFTtJZc9eKN9RhA4tvrfs4AXTkKOcKebk+1yQJQkANN2IKw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XxEgckDD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 09650606A323;
	Tue, 24 Nov 2026 17:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XxEgckDD
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 4C5BA1F000CF;
	Tue, 24 Nov 2026 17:44:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795542290;
	bh=q+3U1Q2zApI9ESCrs1/K1eJ+2sqiL/C+z/Ifq/99hF8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=XxEgckDDMzG/SsUByh3vamNZSRHh2t572MW4EG3Sgb46pQYFk9qzuJrcvoloBSQ83
	 36zWRaZr2aNdT2tCNiraIwbTVarDWkuFszNZ5MjCmZadTztv4YCvkcl5AtGSFtHOwG
	 204FOaYxAbOJqs6tb1OiVD9Wab48dhVanOrtWyOrSkFsvx0Ylvt7QP+OXGVEOsjSD3
	 W6U3CblmaV88Fj6qLSGCDV/TeTBM3dm60u3In+ZUFN0AeahzQZsdVqpcYDHJbAOuYt
	 FpF3jTtHhb53OCnqf2NxDVIc+DixvKOLWygP0sl0HCCzCjTmd7uUXHlRdoGbPeqIdO
	 1sG7HfZ0YrJsg==
Date: Tue, 24 Nov 2026 19:44:47 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: keyrings@vger.kernel.org
Cc: stable@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	David Howells <dhowells@redhat.com>,
	James Morris <jmorris@namei.org>, Paul Moore <paul@paul-moore.com>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Guicai Ma <maguicai@kylinos.cn>
Subject: Re: [PATCH] KEYS: Prevent key type removal during
 key_instantiate_and_link()
Message-ID: <awXNDy90GGDeFPp8@kernel.org>
References: <20261124174035.1614480-1-jarkko@kernel.org>
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
In-Reply-To: <20261124174035.1614480-1-jarkko@kernel.org>

On Tue, Nov 24, 2026 at 07:40:35PM +0200, Jarkko Sakkinen wrote:
> key_instantiate_and_link() accesses key->type outside key->sem, which can
> lead into null deref due that key types can be dropped at any possible
> time.
> 
> Address this by moving key_construction_mutex inside key->sem, and match
> that order in key_reject_and_link())
> 
> Cc: stable@vger.kernel.org
> Cc: keyrings@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-security-module@vger.kernel.org
> Cc: David Howells <dhowells@redhat.com>
> Cc: James Morris <jmorris@namei.org>
> Cc: Jarkko Sakkinen <jarkko@kernel.org>
> Cc: Paul Moore <paul@paul-moore.com>
> Cc: "Serge E. Hallyn" <serge@hallyn.com>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Reported-by: Guicai Ma <maguicai@kylinos.cn>
> Closes: https://lore.kernel.org/r/20261124091243.1019217-1-maguicai@kylinos.cn
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>

Can be better addressed later with this:
https://lore.kernel.org/keyrings/20261112040242.247168-1-jarkko@kernel.org/

In erases all key type drop type of issue. Thus, totally acceptable
bug fix.

Br, Jarkko
