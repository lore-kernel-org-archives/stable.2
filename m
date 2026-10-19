Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792443197;
	b=oiUvWwLB4n+uOL2QQ9hCattMAOlP44OAyVt+kJLkGWkgrH5HgKGcV1PMDtYn9H7zEqLs
	 L+1jB8nQ986yD2oKKF/eqfLa1tEPW9XYN50/iLSGm5D9Zszu9PpFieIbFJSLPFWs+rn7K
	 HrtgETF+rUBKI/xSQ+kIhxneo57btl4n/dCkzxEcRhe40kRMgfC1d9nct43Vs7GJsq9j6
	 YODRuerM/y4jlE12QEqBUFGp36wSJV7M9cJXRXYAefKj2mY7piRebGIZWCb1HYwr2dbIc
	 quVPrhSPFX6s+CeDe9SiDxGRNiDKUO1mLB8iYsN5vfpOm8SAV5jXgn936+MmpVNKfJA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792443197;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=GEfrbSDO+kMON7gUdxMJYNLuv9YA8z2rL/SQx/cfk8U=;
	b=Rqhw/DDgQe3CiWSHG0AOijX+oQQFcTZfQODWNCLcOD5xXxWn5rFwHbAMVIHukNZmR1kB
	 tM3ZCokt7OQybX4Xb0GZXn7UYKvXcefWk97kR2impxCTSL9fIysrkHD3SL3foG7fbMp/O
	 nuMSzfayWy79irTYCZcpFC8vov1nDvYvvkC7IhwmH4SgWxRMe5+J6orx5TN8zDh+5zb+E
	 Eg6KInFpBUEuCC1C7stT1f5KvT1jz37P/BVLo7Dcb9L/dbulWC5ZIue7zb3AVT4Codo04
	 1MHRybTAAiwlFrdugVV26K4usGbs3cUc6U2vBQKoSuEXy/WJNrscwCQkgAUPrWh7GtQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mHCnM0qv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 9095F606A322;
	Mon, 19 Oct 2026 20:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mHCnM0qv
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 8CCEB1F000C4;
	Mon, 19 Oct 2026 20:53:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792443197;
	bh=GEfrbSDO+kMON7gUdxMJYNLuv9YA8z2rL/SQx/cfk8U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=mHCnM0qvx3tC9koBop5PGxWkq8uAIe0hoI2I9IZO96/U/2ZvRw3rmSlL5tydBxyeA
	 Q0oFz9s5WZeGm4pihbB71XXfriWSF/tVLWqUx3YRc2Y1SQfqusbGXn0JbJbFlANhCV
	 VZB3bFQcIxANqcx17uxzyVjqVHSHsH0xQ1KRc1ocpjEmh+VzUO+u8YpxbA13/B+jXA
	 v5QV0S2iHrMbazDBuelx/rxbmXgiGQRIIy1R94wZx933kz/UeH9gF3aaSjrWULldXf
	 udJaKBS+sRznt8Tx+FLYK8a8xVtgASISxeDKRpNlTM2kqRsrS9wWrblDyTnWMr+Hhs
	 fmpzSt11aI+hw==
Date: Mon, 19 Oct 2026 23:53:12 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Eric Biggers <ebiggers@kernel.org>
Cc: David Howells <dhowells@redhat.com>, keyrings@vger.kernel.org,
	stable@vger.kernel.org, Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>, Andrew Morton <akpm@osdl.org>,
	"open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 3/6] KEYS: Prevent overflow of user->{qnkeys,qnbytes}
 in key_alloc()
Message-ID: <ataDOKziXt8j8AhS@kernel.org>
References: <20261019181732.449591-1-jarkko@kernel.org>
 <20261019181732.449591-4-jarkko@kernel.org>
 <20261019192332.GC65095@quark>
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
In-Reply-To: <20261019192332.GC65095@quark>

On Mon, Oct 19, 2026 at 12:23:32PM -0700, Eric Biggers wrote:
> On Mon, Oct 19, 2026 at 09:17:23PM +0300, Jarkko Sakkinen wrote:
> > Add the missing overflow checks for user->qnkeys and user->qnbytes
> > in order keep calculations within INT_MAX range, which is the
> > absolute maximum quota.
> > 
> > Cc: stable@vger.kernel.org
> > Assisted-by: LLM
> > Fixes: 7e047ef5fe2d ("[PATCH] keys: sort out key quota system")
> > Reviewed-by: David Howells <dhowells@redhat.com>
> > Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> 
> Don't keyctl_chown_key() and key_payload_reserve() need similar fixes?

Thanks, I'll investigate.

Unless any specific reason, I would not hold merging this series. I have
written down a follow-up backlog i.e., post-tasks once this series is
merged.

> 
> - Eric

Br, Jarkko
