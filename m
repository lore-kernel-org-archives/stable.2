Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792438310;
	b=SFKmxdV31ry/iekaIzVg1D6oKCe+2YxlWGrepeQI/2mu+eQ6Qgz2RhN7Jn2/yC4Tyd/A
	 O+YB4PKrzBWDWGFInjAFMxMs+xJ6fdAT/xDvoIdvowgTAm8452j444+VVD6soWBmRErD3
	 gVHBhuU/TiFLbjjA8iSEUWEZ3MiyxP3wn8/OJjtKPtjgfExOz1H8cXN3iTRbuetWiMFKM
	 5CEg1fZTgSj0ytv4uopJMd2UeL0vBXwEjlVTUul3URwMEwQ2F4mP9DiHiKanxR4EvE1Yk
	 b/EMSugTDCTKfGFRHoczh1gxoz3qjf9iONEV98ilj1NPveND2DUmf32jnbhS19E4dBQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792438310;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=9folctfNGauCs5nvuP3PEOoDXtbhtMvhvDZ7wQ7zCJA=;
	b=dC6B7VWb/dHiXI8CxM5NhKgUQB+oAPuLbmFpzWzNTftiTcWCI8Q2JLyYlTkDLnwM5rFe
	 tXwUXkdnVRm7ayM9zqSg/CHlcZYjviVTV9DkaH5ip6SBBwYWxvwc9fxzAaCbx8XYQTVL2
	 e0jvbswUB/XxKgot4Ag89jDxvLgT8ffxfAfYBbhfuapx8Qny83c1mRPJfON1qz1hqrG+O
	 DuU4brbwQT29V4KZRKeW11rxMproe1mamuRJ8lT5gltggEZ+qPmgfpLnwIlZppbNKhSo7
	 O/07AnLssagmbY9hW8hJMYnqmpYp9q8t6Yb/4y/D/QcKusOEaC+DO5h+dZBhsPde2aA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KRv0YG9c;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28C54606A319;
	Mon, 19 Oct 2026 19:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KRv0YG9c
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E74D1F000C4;
	Mon, 19 Oct 2026 19:31:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792438309;
	bh=9folctfNGauCs5nvuP3PEOoDXtbhtMvhvDZ7wQ7zCJA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=KRv0YG9crZ6IffbISojEqA6WtBl5tZ9bfqx8x0v7OigyeBWdLRWKs7LN7+a2nVvKR
	 YLQ06uqUvsW5EZHaibPXfilTwVoho6evFS5/edIne0VJt0c2bt+Fc46c73+vYdoJep
	 a1OQhtxg2phVCVejKi6aqBS907dz6u3mjwTcWMQdcX392lCWi7r0q3ezkKv3miM5YQ
	 mm1RlkmMOfPpWUuIyjk2ZryRLgWzkiBpvJrySS74Wq8hfILMNBv8DRGQEaigX6Z88m
	 GN/zwM0tqXCIM9Up6/vu+Yq6m9qGipuwi02BYYwRcJ7OKIdw0BfuWAwwWBHEW4xmn0
	 BU4pD4vQ1z/nw==
Date: Mon, 19 Oct 2026 12:31:48 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: David Howells <dhowells@redhat.com>, keyrings@vger.kernel.org,
	stable@vger.kernel.org, Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	"open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 5/6] KEYS: Reject @datalen values over INT_MAX
Message-ID: <20261019193148.GE65095@quark>
References: <20261019181732.449591-1-jarkko@kernel.org>
 <20261019181732.449591-6-jarkko@kernel.org>
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
In-Reply-To: <20261019181732.449591-6-jarkko@kernel.org>

On Mon, Oct 19, 2026 at 09:17:25PM +0300, Jarkko Sakkinen wrote:
> Protect quota from overflowing by rejecting @datalen values that
> surpass over INT_MAX.

Is there an example of how this can happen, and why the limit needs to
still be so large?  add_key() for example limits the payload length to
1 MiB.

- Eric
