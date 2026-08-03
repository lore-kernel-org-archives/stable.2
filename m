Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0C9C2C21F0;
	Mon,  3 Aug 2026 22:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785795212; cv=none; b=Du+GAyra0wONMCoxFKu66h1uox0qoovXZyG5xRl/1QugBAEa9Mz6ipsvH88JwwUqbPlnn7hpxcSjrh3CydGKbSMv1OXtfbxsFpnV6x82lxRWoxzSCttjn5I/4y9HT4cSoU8IiYAmFhDjcFDKdhm/BdFTkuCxHCzJ4kUqg+GaOrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785795212; c=relaxed/simple;
	bh=a+Iu1jvD4weg8gLdemIn2VXHuzkjDGAFzOKfmb4oXFM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kdOS7VcFzwBrvMY8O/e3xAW2XXRD5wFoT90JW+QKqKabiYD4O2yRmypWtMQwfCfCJfT8vkKl0dfD3gnRnXqDkIAD51c6IW7tCDZkgk5seCNuZZNIlr9Nybf9OoGwSuUZtqtjBEWWJAGOM9OfIpmhS3IalAI+sdYA/9UFVtfzAMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oRC5LBab; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oRC5LBab"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26CDE1F000E9;
	Mon,  3 Aug 2026 22:13:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785795210;
	bh=8OW2Z/fs88GRDkTjWf8werMO7BSTsauvt7Er95fV0I8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=oRC5LBabp7a9Tjlw/28qLD3P2pWaVqOlLPbkc60YoLEfnpmjDn2AzqaqUpSzEoysQ
	 7c5wFlypmfUbQ+9pGZImeGCuFhxLcWdYvMzUukZVeIaCf9IxliavF8GxqP9reJJVk6
	 DwEp4paNPHadTDyOPOW8ysQZGNLYwQeZ75S2lzrgi/NLRaFb9kjMCnOhm3lKWQRo09
	 +eu8SN8UYj87qyVlhxsLmrIJRQuNqfPjighuVpYH/G88PIL81bC5/zKtYmCufqh9hM
	 PFT25v9MOr8Zn/UzWKDqETAEl9MsjDdgM1Bw8TvXsJfcJOuMseoD0g+jE/va69wLxz
	 QBiEN3Qd3yHKQ==
Date: Mon, 3 Aug 2026 15:13:29 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: chanyoung <ppoo1220@gmail.com>
Cc: Sabrina Dubroca <sd@queasysnail.net>, netdev@vger.kernel.org, John
 Fastabend <john.fastabend@gmail.com>, David Howells <dhowells@redhat.com>,
 Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH net 1/2] tls: don't over-fill the plaintext sk_msg ring
 in tls_sw_sendmsg_splice()
Message-ID: <20260803151329.40ec5aa8@kernel.org>
In-Reply-To: <20260727125804.2889161-1-ppoo1220@gmail.com>
References: <amczWCEaLMVQWZp8@krikkit>
	<20260727125804.2889161-1-ppoo1220@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 27 Jul 2026 21:58:04 +0900 chanyoung wrote:
> 2026-07-27, 12:30:48 +0200, Sabrina Dubroca wrote:
> > This should never happen. We need to fix whatever path leads to that
> > invalid condition.  
> 
> Your diff is right. Tested on net (53658c6f3682), stock config: without it
> the test in 2/2 oopses in the AEAD walk, with it applied there is no oops
> and no regression in the tls selftests.
> 
> Agreed, my patch was treating the symptom.
> 
> Sorry about the verbosity of v1.
> 
> Happy to send a v2 with your diff if you'd like me to carry it, or leave
> it to you. Should Fixes: stay at fe1e81d4f73b?

Please send a v2, I don't see anyone else sending a fix for this.
