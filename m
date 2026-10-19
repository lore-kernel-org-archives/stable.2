Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792443994;
	b=J93iRZFoi7Sc/VN9F7AYHC+jL5ctgxAGtJI8lH1ymDQjXhLsJBbeDWXT08QoTEnxJfWU
	 7NYAquM14+BMFnZ2muXI2FKuyloPYrRsUwO2E07CkNGQgO9rO6o1eDtLU8fm3ULK59KAg
	 DlaFZKeErmNACHUCJGarjclCNJM1UwMTJnWGFhzdUhtwg8wbNitUv7NZjYUojZWNuiPoh
	 HjCVaasBe8nLFclpVem2G30lLCOE2kYR/Bno5jHeGJLqB06e8pXIH3JtwAoSGNVofGV7k
	 nZW0vUOI0XyS/sKOsDMwdepYa3m0KI5gobfLm80axxmR5g7ieSlDNHvbV2XDdmqgMtA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792443994;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=AWqHTSRn5LTK5jrpP68OYatKjaIxaIVfkVKm7B/jVgo=;
	b=IZWqFW5hxrv7SeA8uXvW2VckPfVwjvH4fi6XgL39qTrP0lYhXc2YLEBrVhJeqvQL6Y0k
	 oOJJxC1ditVdNQTeUtWNAAjZvfPuCsxDV6eELNOgt9UTpSRrE3KVosbznBUSS7rlYViaX
	 0NOaL0MJtzdaaEL8ex6byAgDpsQy8SYDupSmuaS4L0oSKv3kS1984UIG91S7Kt/YHCEA3
	 sbUt5nJnUDSAcf+3RW4mLeAaVrisUR4PYLFbBT/usshOPjwQmFfdwuuZDPxfpQhdevG1G
	 Fov6Jo/GogsARZvC09QOJLhYjxFW2yTCsKkaA1s+dROwjf0lZHwMS4PZp7T0mF9KkIw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DOYlcOo7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 47F9B606A31C;
	Mon, 19 Oct 2026 21:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DOYlcOo7
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 60F151F000C4;
	Mon, 19 Oct 2026 21:06:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792443993;
	bh=AWqHTSRn5LTK5jrpP68OYatKjaIxaIVfkVKm7B/jVgo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=DOYlcOo7rXSQmA120gnsaduf3i5LnNd6M0ky+Rx7HokEjP4BAgOaBtumCi/IZkGE8
	 IrDrY6Lcl0xYAYcwAMirj5pyPT/LVPgTFQ1wSCgXLv4ogUE7IO++wugXwUrmpjNJiz
	 Fof2u/w4PAwHQKVdDqYfLUU0G4+usQBJUHn3iGc2yzcaH45GOAdCPSCRb2sTNBTTKK
	 MBrUBuPGQqIiVTLVjKPtimUAH6GTHPT6VhJ7jhAYt5K0R+mfCCgkun+QK2vysrJIaZ
	 gr9dweE3MTnRK4NFXIdobky+DJXt3lZe5uu1dM0bnEylXu907vidEOnQKiNfdL0w1p
	 bHWTt9QPGMeUg==
Date: Tue, 20 Oct 2026 00:06:30 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Eric Biggers <ebiggers@kernel.org>
Cc: David Howells <dhowells@redhat.com>, keyrings@vger.kernel.org,
	stable@vger.kernel.org, Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	"open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 6/6] KEYS: Verify the key identity in __keyctl_unlink
Message-ID: <ataGVmTZooWzJYMP@kernel.org>
References: <20261019181732.449591-1-jarkko@kernel.org>
 <20261019181732.449591-7-jarkko@kernel.org>
 <20261019193502.GF65095@quark>
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
In-Reply-To: <20261019193502.GF65095@quark>

On Mon, Oct 19, 2026 at 12:35:02PM -0700, Eric Biggers wrote:
> On Mon, Oct 19, 2026 at 09:17:26PM +0300, Jarkko Sakkinen wrote:
> > [PATCH v2 6/6] KEYS: Verify the key identity in __keyctl_unlink
> 
> There is no __keyctl_unlink.  Seems you mean __key_unlink_begin.

This is definitely my typo :-) I was looking at the implementation
in other terminal while writing this and apparently lost focus.

> 
> > Let's define the following preconditions:
> > 
> > - Two keys: A and B.
> > - R is a keyring.
> > - Both have the same type/description/domain.
> > 
> > Then:
> > 
> > 1. KEYCTL_LINK(A, R) => {A}
> > 1. KEYCTL_LINK(B, R) => {B}
> > 2. KEYCTL_UNLINK(A, R) => {}
> 
> Should be 1, 2, and 3?

I tried to describe the scenarion but apparently was not so successful.

I.e. unlinking A removes B given the match in attributes while you would
expect getting -ENOENT and B retained. Or this is the idea.

> 
> > Instead, verify key tidentity before unlinking, and return -ENOENT on
> 
> tidentity => identity
> 
> Also should explicitly say what the bug is.

I tried and failed... But yeah, the bug is illict successful removal
so there is nothing unclear on that side.

Is clearer description enough or should I supplement this keyctl
snippet?

> 
> - Eric

Br, Jarkko
