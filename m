Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 755113DD509;
	Thu, 25 Jun 2026 11:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782387958; cv=none; b=gvGILitB7Y8bguFiEQmUbIiv2OhCtAVsTvIrddgNSV3AzPKhKxTwEWpe5+mFtalWcfgSP78Jn0kkj3Pv94L1ELI7bY+yW9OpdaTPfeM6KKlHmGPoHjJLlNyAOXz/hdPOVn6bwUO4IpmLBqwQKHT1jtG5tE8zR3QghtpWDQooD6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782387958; c=relaxed/simple;
	bh=Nd8YdKOzt+Ca9w1TBuYqUtzZR7XwfY1USeE0VwvaT6I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u99wDeQiMpgSFgZsKatsufulilodh3dCvp83WYBjM59fEF8gkrV/Di9+1mrnz5malQqq4U6O13avo6RsI9nlvnBIL34x3Y2PMdcM8k6oKfkSnWg8vsiyOkayfTohe7jiMg7dFB6KVcjVihUZ5o8MZmLGqkngzI9bAIu0WJ2QZcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Znl0J5WX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Znl0J5WX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83B1F1F00A3A;
	Thu, 25 Jun 2026 11:45:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1782387957;
	bh=O5Nsrv7dbKI0TRU5J5+1J9WSCqQWpJP9oDy03m9SzNA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Znl0J5WXUw2BJePR4uI199t/XyfCjUR1y2S0ZdLOBKfKzFKxD0zqS/V8CB2IYvHNB
	 d9HimkDYCBzFzBmV7ttG+L7jwRZALoWqvFG0jKBefPxxhwZqAvnbzahqYyj9sYsErX
	 TfsI9prfOT9Apmv68QSqkDKVko2x38Kx4r0AYTcU=
Date: Thu, 25 Jun 2026 12:37:31 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Maximilian Heyne <mheyne@amazon.de>
Cc: stable@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	"Eric W. Biederman" <ebiederm@aristanetworks.com>,
	linux-can@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH 6.12.y] net: add missing ns_capable check for peer netns
Message-ID: <2026062556-residue-anybody-e756@gregkh>
References: <20260617-pats-coif-316245c6@mheyne-amazon>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260617-pats-coif-316245c6@mheyne-amazon>

On Wed, Jun 17, 2026 at 08:25:31AM +0000, Maximilian Heyne wrote:
> The upstream commit 7b735ef81286 ("rtnetlink: add missing
> netlink_ns_capable() check for peer netns") doesn't apply on older
> stable kernels due to refactoring. Therefore, this patch is an attempt
> to implement the same capability check just directly in the respective
> interface types.

Why can't we take the full series of patches instead?  Otherwise this is
going to be a pain over time for any other fixes/updates in this area,
right?

And if not, then we need acks from the maintainers here...

thanks,

greg k-h
