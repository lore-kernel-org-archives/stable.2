Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 965263C1F45;
	Thu, 20 Aug 2026 19:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787254975; cv=none; b=ZeKTU1+d74veVmmJSPgoncGqj9VAJ2so7mfBroThc6sb84Jd6txhA3aHKdcfxoUgAha4iiUpuWcWz0gPzJ6GOtU/vnonmwg8BxMUSKXSn5F6z0fulmnWYI8mN9qsI2sE9bg5XdTuh70dzrOtj/MJCeWa5b11IMky47uJY881IG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787254975; c=relaxed/simple;
	bh=xqlTrHCEIOwnxXyUutGBU6iU2zNTMhaWfZ6Ens+s6Ig=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ljFFhWljNiwdTwFxJU/32+T0kdjpTuAQjyzZ/AbNSLVFBM3jKzQgGdmhecEnZIheJekv7RBqepzkIjw1+vfEnx56uWMzd3W6a+5uL2kXWpN2O97NuPRb7nIGbq79eRcjvHuYvWdNq5sllPWtzHyPsvvIadh21AiajCY18tWcyJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jSGJ8XSL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jSGJ8XSL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47E761F000E9;
	Thu, 20 Aug 2026 19:42:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787254974;
	bh=xqlTrHCEIOwnxXyUutGBU6iU2zNTMhaWfZ6Ens+s6Ig=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=jSGJ8XSL5lvkbHzPHkPmnDy8lM1io0JoJw07wk/d1MAtHGAtllgTeH4jjksEsjY+Q
	 dtlDnHYin2QpLkZJ3TLAiJN2ShrzCfMXZMIDb73BXM6z86xW8sbgCgKl28N9T3/rvB
	 AjIkQCZYKjn8ChwbSafTAKjxKxsKmTFDdGjX68O1sUsiKrw88NXyj5zYOKirjxlzd8
	 Rpcom90ycqguGHT2HCiIVNL4Y+mWwdh9Sx600nPP5J/w6Wd5qkaNENxOrSz4wt5TVd
	 tFlb5dS0KCYWX1WHvPAv23zukPuSdY3CExNd1ZezmB5S0MUD6Ek/br65ZwuOF6RhVl
	 I+F5Z8UE9Xe+g==
Date: Thu, 20 Aug 2026 12:42:53 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Kyle Zeng <kylebot@openai.com>
Cc: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>, "David S .
 Miller" <davem@davemloft.net>, Willem de Bruijn
 <willemdebruijn.kernel@gmail.com>,
 Muhammad_Hazley_SAMSUDIN_from.TP@tech.gov.sg, stable@vger.kernel.org
Subject: Re: [PATCH net v2] net/packet: defer vmalloc TX_RING free until
 skbs finish
Message-ID: <20260820124253.1fd25425@kernel.org>
In-Reply-To: <20260816235646.76500-1-kylebot@openai.com>
References: <20260816235646.76500-1-kylebot@openai.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 16 Aug 2026 16:56:46 -0700 Kyle Zeng wrote:
> Fixes: b013840810c2 ("packet: use percpu mmap tx frame pending refcount")
> Cc: stable@vger.kernel.org
> Link: https://lore.kernel.org/netdev/20260721015824.45829-1-kylebot@openai.com/
> Suggested-by: Eric Dumazet <edumazet@google.com>
> Suggested-by: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
> Assisted-by: Codex:gpt-5.6-sol

Kyle, we're missing your sign-off tag here.
