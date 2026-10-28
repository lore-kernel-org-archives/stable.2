Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793195880;
	b=A8Odm0GmVvlDcphulKR63To19HRCXZaqaw0X+w0VveamEqez2d6NGnvIyasm/6I5qFEW
	 eqXAaTep2q7mva+wokEPL0wNeQ4fuO8WUWzzRHOFjU7eny8n5OBOR9diUybmu8WZSwD5N
	 xezdc4K6GaPte55efGF5exii0jV2xLjl6KR0/FvByOpUvbtnIbX4RHcq7XWDpxjNamF40
	 9a2VdL3omqEDExf15fGmhYj4T+aPZrBLN0CKtKePb1NiWZygGQNfSZ/yJRlXAmXYLlSvw
	 riQzYhXV38RIMRKmCRLTiuWVo9JsM0SnlAAr0jb4VrvFNpNjXjoA5zGy3IYO6HLD8WA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793195880;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=KYRNCEPeqYA+nqmP2N0oHiqcDzPKl6MGn5aUK1z7t4k=;
	b=EnfVbtxXiHKEvqwNszVm867fg0T2NUFnZh3+4XhhLYc0CY0mbL+4xqIKbtc5fBUCfwoD
	 BaA9qRyExKhVWX8eiZufiqBWhnZso+eLvTTnW1bvklJ74Br/abkSRexJwChdofxwtAKSe
	 yPxKWZ2u2DKvNXdnKauMNatNfCDrMQgKvOrOHReLxsYljyKuEuGY1TzHmpmuhYjnCKDXi
	 7CNGLevhP4HaMtkXmuDBWfpbLXhvDzqUgGir5UufWqw4nfT4VJEZ6sWI0FFJ2BR/Th8XB
	 k7RjPUhUaO8HRhs3Ed8EwxKbMf9mg66scLDDwt1JecLbtaowMHuzdqIUse74H/zd+/Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=FCSxv6s8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC013606A31D
	for <stable@vger.kernel.org>; Wed, 28 Oct 2026 13:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=FCSxv6s8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B15C61F031E2;
	Wed, 28 Oct 2026 13:57:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793195879;
	bh=KYRNCEPeqYA+nqmP2N0oHiqcDzPKl6MGn5aUK1z7t4k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=FCSxv6s8BYBjEs0MumuPhaMjzi1ZRMeSnh1GiyF1CEmjr8WyQWBZvAd3xR0NRaRKu
	 szCJM40YHP+MVNDj+aV5B4qDRNYZQ1N/Gu73TftQGfrPDWBB1YnnTXlZ/gQGXAKtzV
	 raCJdQoHfrgUbnVCwFGzmVJWp3ZB3j1dv0VSKM50=
Date: Wed, 28 Oct 2026 14:57:57 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: stable <stable@vger.kernel.org>
Subject: Re: Queued patches for 7.2-stable
Message-ID: <2026102818-bazooka-smolder-122f@gregkh>
References: <42b54e88-8fd3-46d4-9cf4-cf28830cf089@kernel.dk>
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
In-Reply-To: <42b54e88-8fd3-46d4-9cf4-cf28830cf089@kernel.dk>

On Wed, Oct 28, 2026 at 07:53:02AM -0600, Jens Axboe wrote:
> Hi,
> 
> Like the 6.1 series, but for 7.2-stable.
> 
> Please apply!

Where's my "YES!" button to pound in response to these?

thanks so much, I'll go queue them up now.

greg k-h
