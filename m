Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792437171;
	b=knBMo35OGHWGLtj4uqo9bvT4/6W5ZA78LqJGmSxLTdN1xHAVYzWvKJoJLq9lAnpLqPHD
	 o4TZaefWwcAw/KzKCBcngEL9eYU/gJjLqe2tCgFPV9cYsbTNbT3U3E1tIC5CRHs/71i88
	 w9sV1q8x34b1gDVIOcfzxUZb0Y9E6fQoRP7aI/hdgk6ZqgPW9+4rWir8y5m7mR6ofcYuK
	 bQ0VYaeWLb1hBeJ3VLugABkPWQHRmMhrk2MVK4AeP51zolqOs5cLUD7w2r3BMqVTjczRF
	 tQysgHRURl4KyPXBOZY6fvVZobvexmp3kiUalatHiGSB4/rVPs1nEyK2Tu5esGghjvw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792437171;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=KgyAc8q3o/G/gyeGdvTtRRzKYp9WY3cB4AhYfV3oG2Y=;
	b=eGf9XlaxidT2fk3KIXoQ2rrDhjDYPRmZk5qalqrwLQmk0nWTUQF0NEp+FsZ1x6770OXJ
	 8C0mDEGLoIw5VbAoHnrrCMhpXGZBngE9i8WhFj33W0Dl1qAJm84GIK94KalDOS+b65A6d
	 RN0FL7OsAdset2xXpFdpUiR1Yo4LIp7l6mqWQfoe1035sd3J8UoHRqJQ1wOEqKjQ6l+oD
	 84eyUdX6+O80Y8l8r8NYcsk1FsFii5r/g3060QUBkrB9Qa9d6OYYpvHEgJiWawXuHP1Cy
	 sRDjwOTQozc3UehQdvos3oM+gOEHBusFJ4OhnT1QeT9UP5z50RZUUF0+I10z1E0jZnw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QZtuucHz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEC5C606A319;
	Mon, 19 Oct 2026 19:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QZtuucHz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EE251F000C4;
	Mon, 19 Oct 2026 19:12:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792437170;
	bh=KgyAc8q3o/G/gyeGdvTtRRzKYp9WY3cB4AhYfV3oG2Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=QZtuucHzvOXdQWQfRhYR97V9CyZRmOPF3DBOXIKTFKaVuV/ZFPjMeT9qy+QQd9GhK
	 CwWce4b6uSzOK6TwInOXGQcIKFYb4Ds4n99uJ4oN7uX3ohvGfNOp9HFkX1KhPblLU2
	 h8ha4ZnJXFeVqI2XRGwB8x31SdG8JkilO1N72e0QHqvnkMjoAlxCh4XbxA8zZcbtPL
	 nyKYMexbv16CuXgi6/LbYiT92aCmu7gy6aZvJDFc1wUKwGhpG69RQWD5wuyijJmUNa
	 HjjiHztOkBt+zZ2t/NNP3CnK/gd/678pcG2fvzhb7bjPmuY0KwRDXvsIKowQXdUBY/
	 JurO6LHUooK/w==
Date: Mon, 19 Oct 2026 12:12:48 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: David Howells <dhowells@redhat.com>, keyrings@vger.kernel.org,
	stable@vger.kernel.org, Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>
Subject: Re: [PATCH v2 1/6] KEYS: Expand key->{datalen,quotalen} to unsigned
 int
Message-ID: <20261019191248.GA65095@quark>
References: <20261019181732.449591-1-jarkko@kernel.org>
 <20261019181732.449591-2-jarkko@kernel.org>
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
In-Reply-To: <20261019181732.449591-2-jarkko@kernel.org>

On Mon, Oct 19, 2026 at 09:17:21PM +0300, Jarkko Sakkinen wrote:
> In key_alloc() and key_payload_reserve(), key->quotalen and key->datalen
> can receive values larger than USHRT_MAX.

Could use an explanation about how this can happen.  A keyring with more
than 16383 links, I guess?

- Eric
