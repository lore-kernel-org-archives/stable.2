Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792441936;
	b=HaJJucZBY+aI+idMLV0UILDzduTjkzYxb3UQO1piNF2RGGGOyuRwr7JvWyjHqjRx+Uro
	 giJxNIW06qWnsE2Woe8vA8zCpFdxRxUgvPeZlC76D1ZmPHKCtx+icoSFLudSk6DsDVxSi
	 KwYMVp1a88BTS78da2r8lpwcI6u+IVn7+dMw6xFifG9jQKzoJy0wxCdwXATbKFOGXHkMy
	 Mgoa+9VnlTYPPc4F9xJvWZUM+DyYjXsI1biJTSYDDA2PhMuJcVHJGmE1NkwQYQ8NZNrQi
	 Qyy1Q6yHtG+uY00lMO7hEiGaH7ZSOFYR0Cd5WzJRIsfmJ516q9QWigjDZNDbR7Pzvog==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792441936;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=6JZ6owAUfodkQDSu5cz9f3U1hSFgVs7lIZQwMs65d7c=;
	b=lcGlvVnO+NwL7Jvin6kciMHRdSBfw0AObrGIVaR8EN1rTGGxhhj/nhZY4mCRmeFqHMBV
	 jjDR2cq8aD/k9xrAWYf+Oh0N1ZXatn7HgFVAotD6t2gUiFcfmRnm2hTBamo32eAbnaPiu
	 wfMFADDZTxxi9krTpcZ7J59llDVLWaz7IRpbfbaLxccHRo4tGh+ybOCdQnpTSbRdOmkrK
	 dJ2hYcFRuG8zpfodUvmLvzvt9Mmh+rVSrNVwZUD5TTb3mTT5OIMSRZl/4+B7KSdhzxE2X
	 kauo/kIxAcbh/92SJEsGhtcKSHi3Scf4oHoaQ1d4o3jJ965rFJDFFiFOUvtGVUHX4Jw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CUUnoV2S;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id E7564606A319;
	Mon, 19 Oct 2026 20:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CUUnoV2S
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 07C371F000C4;
	Mon, 19 Oct 2026 20:32:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792441935;
	bh=6JZ6owAUfodkQDSu5cz9f3U1hSFgVs7lIZQwMs65d7c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=CUUnoV2SJv2FTIJiSh91486w2lDw+7kQ7aGLKU8YR2fwDr3V5BWxwtHu8T3Vc+8DZ
	 Wr2QoUEbo/ckUxXITUoZGIZDGKAYheFOvIAME5vx4+JUljuTxD8oX1t8kfzbqkjvrL
	 JlnA2g3obr/iDb0LIT1qZ1fXpFKOQqHLTSKnIJ6uhiO+Fxf0nZTfAr7DAV9AXrz5FW
	 uXnBzpgBwgJJWBqm7wrevI5mpoVQ0P26CtspvqdZk1/3/Zz3P/C5Bck3K3sk62Q+ya
	 bw+0pp+k4II3XQ2cqT4IsfSXmB6WIQNEU2Cs9mFXa7XMV5EwHhCRExRAZsoqnqysM4
	 ze0QhufHlaXxA==
Date: Mon, 19 Oct 2026 23:32:11 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Eric Biggers <ebiggers@kernel.org>
Cc: David Howells <dhowells@redhat.com>, keyrings@vger.kernel.org,
	stable@vger.kernel.org, Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>
Subject: Re: [PATCH v2 1/6] KEYS: Expand key->{datalen,quotalen} to unsigned
 int
Message-ID: <atZ-SyaBG0leY8P9@kernel.org>
References: <20261019181732.449591-1-jarkko@kernel.org>
 <20261019181732.449591-2-jarkko@kernel.org>
 <20261019191248.GA65095@quark>
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
In-Reply-To: <20261019191248.GA65095@quark>

On Mon, Oct 19, 2026 at 12:12:48PM -0700, Eric Biggers wrote:
> On Mon, Oct 19, 2026 at 09:17:21PM +0300, Jarkko Sakkinen wrote:
> > In key_alloc() and key_payload_reserve(), key->quotalen and key->datalen
> > can receive values larger than USHRT_MAX.
> 
> Could use an explanation about how this can happen.  A keyring with more
> than 16383 links, I guess?

It is good to sanity check these given the source of origin.

I tried to implement your example and I think I was successful.

Here's what I did:

	keyctl new_session >/dev/null

	owner=$(keyctl newring owner @s)
	keeper=$(keyctl newring keeper @s)

	for ((i=0; i<16384; i++)); do
	  key=$(keyctl add user "k$i" x "$keeper")
	  keyctl link "$key" "$owner"
	done

	awk -v uid="$(id -u):" '$1 == uid {print $NF}' /proc/key-users
	keyctl clear "$owner"
	awk -v uid="$(id -u):" '$1 == uid {print $NF}' /proc/key-users

It is mostly safe from unprivileged user as /proc/sys/kernel/keys/maxkeys
and /proc/sys/kernel/keys/maxbytes are by default set to 200 and 20000.

When I run it as root, this what I get on first run:

252793/25000000
252793/25000000

Second run:

383862/25000000
383862/25000000

And third run for good measure:

514934/25000000
514934/25000000

So yeah, it is right on the uapi surface easily accessible :-)

> 
> - Eric

Br, Jarkko
