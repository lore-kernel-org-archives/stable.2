Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 157092DD5F6;
	Thu,  8 Oct 2026 23:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791503358; cv=none; b=Noy9tCBxKIM//ouDfcu3PvzRChUI8v93JJn5kTxvp9IApknfiEI2pvBE/dpWtYHO8+ZDE9Gsx47h28GcD4NavLNFWICC7tVzUCyGlLDZCe+ScldigvgvRVd0UdHb7VE7sJn4fJqOcfcW8yLCWNj+uCiaTLSPZSvXie8CImsbisA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791503358; c=relaxed/simple;
	bh=kvd8Wdqg7MXOv7eKgOr1HM24rJGeO1gL3nSxcIOcaX8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=th0VoF4lsVt41xfAehfCoFUQNRd3cT9FdEjnISlzsLCYjNAq3YonXiZdnL9fTqICN3u5XK39qQHKLUkbBJxqdYKa1/rrCEVRorsQ5JCDhKgxnVBJO/9yr6xIFroGY+0uFXH2yib4bDC/QQ3ngI/x8iR70J1K6a3zeBly7aoss+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oPpxfuSC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oPpxfuSC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9359F1F000FF;
	Thu,  8 Oct 2026 23:49:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791503357;
	bh=0Mga/Cp2RNkPq/r+Fvql3rpWViZY0lp0vp3ozmjghD8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=oPpxfuSCZI7QDZJn92O/gXRAyMwDyGzrzBQpUMXOdpr2meBNflTFNRXNlI3UXgFq6
	 6LB1Ao1UYjypW+D6q2JH3GAevcO6r6L2+brDdTO+Jy9dZIzbeSzItPPrU8bnZEGTHa
	 b5K+za2jsuSk33witaTFMg5JJsr70d07NH9C+khYsZTmUk2VZ9RGa1kNcglzwAf7vq
	 oNQhLf6FqWyyF8Anjup11sYKewgv/U0Iq39uHIawbLjAHWsHt9ainFcJ1j0VJqYt4I
	 tgN+f714hPQg0t5x1nhMOMQ9t05f7ZX5+UtV0rtl7J2gvTqKFeZEm1IdSyfwwR620k
	 4SlDNh4aq4+yA==
Date: Thu, 8 Oct 2026 16:49:17 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: netdev-bot+sinfo@kernel.org
Cc: Chengfeng Ye <nicoyip.dev@gmail.com>, davem@davemloft.net,
 edumazet@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH net v4] net: pin protocol module before inet socket
 allocation
Message-ID: <20261008164917.384b8e96@kernel.org>
In-Reply-To: <179096305349.1402591.6316561110428507255@kernel.org>
References: <20261002173844.3537111-1-nicoyip.dev@gmail.com>
	<179096305349.1402591.6316561110428507255@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 02 Oct 2026 17:44:13 +0000 netdev-bot+sinfo@kernel.org wrote:
> This is an automated message. This series looks like a fix, but its
> commit messages seem to be missing some information:
> 
>  - How the issue was discovered, e.g. hit in production, hit during
>    development, syzbot report, manual code inspection, LLM or static
>    analysis tool scan.

You have to answer the bot's question.
