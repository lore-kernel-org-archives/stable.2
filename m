Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D486340800D;
	Thu,  1 Oct 2026 23:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790898238; cv=none; b=pQ5x5jw4Pwob8A8yNox7j//z2PY0cgsCdW6QWdz0vPVWBpnpEI0xPai2iJAUFMprr4+d3Oy61urpbPSTGR/FvfVZ3dH4FIvTYbHuTaB/p3gp7TeURzk2vBNkzdsAecdNOSGdx49Wzhni11sjnS5vassuet0IToZZdUYLhiMhF8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790898238; c=relaxed/simple;
	bh=Nl2BF3D9zyUHwNaOIXmQHl2PyVqrGI7iVEXv10MIdrs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tNg2HbfA5UP5f/PTTzD0CCMYCGpGQoyJztoeq+8yypQN0dVZDFDPD+inQd1T2H0ZC1XWorzPzay3/YGUvZe4O64DlQjZSZIi4Zitkce3UNgZIYO6HijAbv9MEdzxMr3+g3tCzlrB/TwpvhZqQD3JaYUFav+iphkSiopn74dPuoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vdy+Ulja; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vdy+Ulja"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E60BF1F000FF;
	Thu,  1 Oct 2026 23:43:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790898236;
	bh=Nl2BF3D9zyUHwNaOIXmQHl2PyVqrGI7iVEXv10MIdrs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Vdy+UljagiWy4dJtR8icrn7V8IXG88yooho8SfjCe0zpT1brLcrYccEoPGmmriYj5
	 ZYzZ3kJzTWR0yadTBvZmJ43WryfIusa9EIS9jz4SLGKgPT0YbRwVOXZI5vBXYCUazZ
	 CEjXdj5bdtAx7kJK+j8xoyED1rnwOZ3Q/FHU1FSCKZplnUX4pbiVS3UfgTcbrQU+02
	 OnIBbDwk8yx2PsrVHtJvtnbuKSLjgyn2Cq+KxhihJ5dNSAUdWkYEpli3gDqo0riZol
	 4ZGvCuw6QIErVEx0MS47Ee6kr10ITOIjhmCag9shuWVKelQhTtOWaWhEtYf+cUspYx
	 Rg4UnuuUU3qEg==
Date: Thu, 1 Oct 2026 16:43:55 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Karl Mehltretter <kmehltretter@gmail.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>, Steven
 Rostedt <rostedt@goodmis.org>, Stephen Hemminger
 <stephen@networkplumber.org>, Arend van Spriel
 <arend.vanspriel@broadcom.com>, linux-kernel@vger.kernel.org,
 linux-rt-devel@lists.linux.dev, stable@vger.kernel.org
Subject: Re: [PATCH net v2 1/2] netpoll: use a raw lock for the deferred
 transmit queue
Message-ID: <20261001164355.212c8ce9@kernel.org>
In-Reply-To: <20260930192103.62973-2-kmehltretter@gmail.com>
References: <20260928064239.32456-1-kmehltretter@gmail.com>
	<20260930192103.62973-2-kmehltretter@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 30 Sep 2026 21:21:02 +0200 Karl Mehltretter wrote:
> Fixes: b6cd27ed3388 ("netpoll per device txq")
> Cc: stable@vger.kernel.org # 6.12+
> Assisted-by: LLM

This slop is definitely not a fix.
It never worked, it's net-next at best, no fixes tags
