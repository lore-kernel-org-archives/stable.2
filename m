Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792442823;
	b=zqA7bWne9axyx1SXtpQHp5G34eVp3L8eg5df0lG1I7bwrXoJxnNPgY4veCyolS8xT5uH
	 gOdn/Sv4nI6d0KwW41ovLxasZhqN3G0xB6QP4x4ikCZ1hzE5hkSmmWY3T+3fGkZegXys7
	 QQSPv5gIOJgStaoj1qL563wtXVpW/xD8wPu3DPGoHBIyXjW1RUo24ffk5LtnTSvmA3ERe
	 opk0/Wsx3C/UNUfk7e5E9keAB38Ygdq6mE+uLxPHzABNyPwYMVbCtubQM6DlYhIscHYbB
	 SE8eAps0axYGSrA+Ho5NIl0bpfuKr+Npuol3UT0tMqFeUw41GOWhv3AaW+npK8re1Cw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792442823;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=V1WbwvhVT+CaOduktfFrsnpnmJC/bkfFVrmRm8iPY4A=;
	b=3HI94pChNavWyuYjZB821HmUiCDafMGMfP6uSYQpOk3uJGyWrggjJ4fobt4Bgqa9L9EN
	 +cD8gKgzLWvc6Euz/acVbkNoax0v0Scf+KIYQYTxaeyluQOcnNZfWFx2KMeC28wBWUNns
	 TMiITa25/x0f46l/qCV2Eb1JPuDRgW6TvvBmr9TKmY7sz7cqc8+aSoHR/P8shiP1I8cfZ
	 8XxBKUiRtjoxCcnfT10SBMk+RKNzloIQUFrRx5RES503QlfPtQiAVYsEAD039aDtFUbg6
	 lWlicgY2mWFtkroyX43JJ0L/8q9mK8bz3QpcROd48GgKUlLqDdOmk8eM5zxKmMzU0rg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lPX21dfN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 05CF7606A31B;
	Mon, 19 Oct 2026 20:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lPX21dfN
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 2AA791F000C4;
	Mon, 19 Oct 2026 20:47:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792442822;
	bh=V1WbwvhVT+CaOduktfFrsnpnmJC/bkfFVrmRm8iPY4A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=lPX21dfNa/srFS30DqBEg08zS+0XWWTbE8Gd9yfXMbpXTtzN7wg3al9B01EpvJ2Z9
	 Gt9G2kr7S9un7IaTaGjBKIUw0nlSvgXFxKSE9Zq4ckFRrAR1xt9aNgnpKatoiQ2dKf
	 wIubCd76No+obcmZdBMgo68aoeIrGvC1Ep4Y3wzhoOuyF9a5Ctn2W3g9Y1rROtzTMr
	 ZoArsTHr3+C+g+FZpTvuEtQFs915UjYKKfHTIHRn6kBeyUyTMBdY27qGuMJGijUzaI
	 K+BNPePs4TcQqQRSpDUTTiQGQPyvKzloZvGgDGZSwFj+iU0v/dIVy2EdANa4hJWz/H
	 Fo4T2wVd2z/Qw==
Date: Mon, 19 Oct 2026 23:46:58 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Eric Biggers <ebiggers@kernel.org>
Cc: David Howells <dhowells@redhat.com>, keyrings@vger.kernel.org,
	stable@vger.kernel.org, Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>
Subject: Re: [PATCH v2 2/6] KEYS: Reject @desclen values >= KEY_MAX_DESC_SIZE
 in key_alloc()
Message-ID: <ataBwhb8d2M1q2ux@kernel.org>
References: <20261019181732.449591-1-jarkko@kernel.org>
 <20261019181732.449591-3-jarkko@kernel.org>
 <20261019191759.GB65095@quark>
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
In-Reply-To: <20261019191759.GB65095@quark>

On Mon, Oct 19, 2026 at 12:17:59PM -0700, Eric Biggers wrote:
> On Mon, Oct 19, 2026 at 09:17:22PM +0300, Jarkko Sakkinen wrote:
> > @desclen in key_alloc() is saved to the 16-bit wide desc_len field in
> > struct keyring_index_key.
> > 
> > Reject @desclen values at or above KEY_MAX_DESC_SIZE with -EINVAL in
> > order to account for the NUL terminator and prevent integer overflow.
> 
> This should say something like: "in order to match the userspace limit
> and avoid u16 truncation".
> 
> There are also similar truncations of desc_len to u16 in
> key_create_or_update() and keyring_search().

Ack.

> 
> > +#define KEY_MAX_DESC_SIZE 4096
> 
> Could use a comment mentioning that it includes the trailing NUL.

OK, that improved the commit mesage somewhat:

    KEYS: Reject @desclen values >= KEY_MAX_DESC_SIZE in key_alloc()

    @desclen in key_alloc() is saved to the 16-bit wide desc_len field in
    struct keyring_index_key.

    Reject @desclen values at or above KEY_MAX_DESC_SIZE with -EINVAL in order
    to match the userspace limit. The constraints inherits from the one byte
    required for the NULL character.

> 
> - Eric

Br, Jarkko
