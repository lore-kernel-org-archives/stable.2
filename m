Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBE5839524B;
	Wed, 17 Jun 2026 22:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781733926; cv=none; b=t1s8Ki7sQcbkKXs7QkJRj3lRfZzaJa4FDIpkTdrofTvrNCGGdoiL7l61kx4Rr5mvG2iCIJ1YrbymIUfyDzmbWIeWDoOXDYq0mqIkbDtXD7z5jwEyhgdrhvR1udUMeYDwrdImtuQTIEV10skUsv7bp/dkE1ZltEMzUb9HqWrjfEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781733926; c=relaxed/simple;
	bh=/RWLcjq0LrvNt8Syg4lAVdGlcETIvNd2khLbHi6ojSY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uwvsuP+zWPxxz5QLndjLoGJDZydI84QQxnRBtXzXqU1rZqF4l3GzrGn4hA6TJtsIm/KbebAQDAMT6BdhT5sZzILaib0AtihI5EzLKgEsvzBn2PIJ/Q3fdV4bQkRNXAcGAamJdbT3TiFK1qsDt4DxFW4QpNYv6afb8c3F97u5jjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aLceKYlg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aLceKYlg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF0681F000E9;
	Wed, 17 Jun 2026 22:05:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781733925;
	bh=lIqMtEF9Rd4rP4mbW4Fu71TyM2PocpUsF9vug3MkTII=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=aLceKYlgGnk/0SEhYll97JgZQWX/vuWU/+OUKJSrtxQ5xyitsS7Y4l58RCpOrW+xo
	 6KQ5M+F/5um9QpuYQH2zQSGkG0Idk7hg7SB/UpeJCmBh+0tG/8vkPiSAJkWBV5fMXF
	 uNTvL9FbINzeyA9I14FmdFbUrZ5I+0c6dk3p3idakpUdZa/I/2u81WlI0mYncsHUqG
	 0FzByms4OqUqaUBOHzmOm0IX5O/yYLeD8aMDg/qFgqNDSppz7CJODqp1Q9PXXvOWcJ
	 +E1t+iBkiIxpE3Uz7OKq9eePihwS/OiFP8brLlyYG3FHzcY2/ii7hrh65e3mS2loHz
	 8IzYARMmigzZw==
Date: Wed, 17 Jun 2026 15:05:24 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, David Howells <dhowells@redhat.com>, Michael
 Bommarito <michael.bommarito@gmail.com>, Marc Dionne
 <marc.dionne@auristor.com>, Jeffrey Altman <jaltman@auristor.com>, Eric
 Dumazet <edumazet@google.com>, "David S. Miller" <davem@davemloft.net>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 linux-afs@lists.infradead.org, netdev@vger.kernel.org, stable@kernel.org
Subject: Re: [PATCH 6.6.y] rxrpc: Fix the ACK parser to extract the SACK
 table for parsing
Message-ID: <20260617150524.2298f6f3@kernel.org>
In-Reply-To: <ajMXGIoyTqpZCvw-@laps>
References: <2026061543-superior-passerby-d597@gregkh>
	<20260617180410.271223-1-sashal@kernel.org>
	<20260617132704.0e1fe56b@kernel.org>
	<ajMXGIoyTqpZCvw-@laps>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 17 Jun 2026 17:52:24 -0400 Sasha Levin wrote:
> On Wed, Jun 17, 2026 at 01:27:04PM -0700, Jakub Kicinski wrote:
> >On Wed, 17 Jun 2026 14:04:10 -0400 Sasha Levin wrote:  
> >> Subject: [PATCH 6.6.y] rxrpc: Fix the ACK parser to extract the SACK table for parsing
> >> Date: Wed, 17 Jun 2026 14:04:10 -0400
> >> X-Mailer: git-send-email 2.53.0
> >>
> >> From: David Howells <dhowells@redhat.com>
> >>
> >> [ Upstream commit 333b6d5bb9f87827ac2639c737bf9613dbae7253 ]  
> >
> >nit: you missed the "skip patchwork" header on this?  
> 
> Hey Jakub,
> 
> This one is a backport crafted in response to a failed backport of a stable
> tagged commit.
> 
> I followed Greg's template to sending those backports to him, but I also think
> that I do want folks to review the actual backport itself.

I see!
 
> Do you think it makes sense to add a skip patchwork header on these too?

Hm, maybe some clever patchwork DB query would tell us what others do.
For networking the patchwork queue is purely for patches we have to
apply. So my preference would be to skip, but I didn't realize this
was intentional. 

It'd still be useful to add _some_ header that we could filter on. 
We have bots which complain if people repost patches too fast,
they will get confused.
