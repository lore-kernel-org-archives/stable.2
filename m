Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795503957;
	b=kqhjFar1pAgvfm4xYCxf+VMEh8/imkFVc5RpPUg+OkVFBSpxyEmW8cpBz/jIB6Ii3mDR
	 6vr20yvLt1YteSHr6a/b5rVHxvMvOyP+tkwS4Np1ZQ5N44C1I7LhccxilMdJKk9BzpHhO
	 /M1JWxjoigGqDuYkR3Q/kRP8QIyPEv0mXHcoKHCZdEyyT3CnRTQLUAglSEZNtAETrMh2y
	 2TNxGo0a2m6vtbu4fnvboJ6aUGJrPw/VfZlNR2nCab9lLAw7WrN0nkTeXyQ4dgOWqjuZh
	 crHlkOiG41vVE0S9CPsm7miKHwIC8s3cGkoq8qRu6mm52l+zsQBDTQsKLG1Bbs90pxg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795503957;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=NTFO0fzMPBpVmRn0e1Mt3dynHEeKk9zF1NfDz/o/wek=;
	b=EQuJ4OcMMaoN2WOeurvGTdcsDtwlgCaHDjIX/0eY5jSvkOPBEsl2AWAsBH8bzdEpVI2b
	 XkQxOvFOIC9xaUlC3BXvN3ud9aWmR5g6TyGZ77rY8grRgRmiAl9ufk8cBBRgDVoVhQWUr
	 fbOurNgXWGQMT4P14cBTblOIFjpc+t8LTTYwPZruPfDkkigN999g/Gemr4gqI+69RYQaW
	 oTVcrE+AXPzeHESFpQN4SY4RiNtc3Nz4QP43OSixQUOrCshteUIDFyeghWI/MOpo0Jy0T
	 G2sRcxF5X3EPBqe0lBOlVTfJchiUibfm1wVIOQF7GESozp+elUWLBLdVxLHxfXEn2Gg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=ASyI0gkD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDAB0606A31E;
	Tue, 24 Nov 2026 07:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=ASyI0gkD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6B631F000CA;
	Tue, 24 Nov 2026 07:05:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795503957;
	bh=NTFO0fzMPBpVmRn0e1Mt3dynHEeKk9zF1NfDz/o/wek=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ASyI0gkDU2j1coxPSBDYs5JWeX6RbBguZs1kKjfARizoaWMXZEMbBbI+kfOGdI47I
	 zzzrkeg3p7TjCZToHivKIjknjNPYkoFf/5qfXzl/7ClVLBHbB6hco6uneiHDpCrC5f
	 0aV8CmIdhhhPK0ExT/4h1LwArsC7av3Lq8IO3rEo=
Date: Tue, 24 Nov 2026 08:05:54 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Tanuj Sharma <ertanuj96@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	linux-hams@vger.kernel.org, stable@vger.kernel.org,
	ralf@linux-mips.org, horms@kernel.org
Subject: Re: [PATCH] net: rose: fix OOB read in CCITT facility parsing
Message-ID: <2026112418-freebee-tasting-68ba@gregkh>
References: <20261123183818.24508-1-ertanuj96@gmail.com>
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
In-Reply-To: <20261123183818.24508-1-ertanuj96@gmail.com>

On Tue, Nov 24, 2026 at 12:08:18AM +0530, Tanuj Sharma wrote:
> In rose_parse_ccitt(), the 0xC0 (variable-length) case validates that
> len >= 2 and that the length field l is in range [10, 20], but does not
> check that the remaining buffer can actually hold l + 2 bytes before
> performing memcpy operations at offsets p+7 and p+12.
> 
> With a short facilities field (e.g. 2 bytes) and l=10, the memcpy calls
> read up to 15 bytes past the buffer, leaking adjacent heap data into
> the facilities struct. This data is then copied to the socket and can be
> read by userspace via getsockname()/getpeername().
> 
> Add the same bounds check that rose_parse_national() already uses for
> its own 0xC0 case: if (len < 2 + l) return -1.
> 
> This code was removed from mainline by commit dd8d4bc28ad72 but remains
> in the 6.12 LTS branch and all prior LTS branches.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: stable@vger.kernel.org
> Signed-off-by: Tanuj Sharma <ertanuj96@gmail.com>
> ---
>  net/rose/rose_subr.c | 2 ++
>  1 file changed, 2 insertions(+)

This file is no longer in the tree, please submit this to the
out-of-tree repo that is keeping this codebase alive as it does send
patches back to the stable kernel trees quite often.

thanks,

greg k-h
