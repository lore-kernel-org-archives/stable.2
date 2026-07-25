Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 689162771E;
	Sat, 25 Jul 2026 00:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784938240; cv=none; b=XkZKeYO5BBP6i/3PP4txxuvV9RiOFoh0RRKwE6aDlJzH//q1DbIImzqThG7aTsYua93T5/Ma3FXUOPun70KGJW0/k7tGu77yF5SqZKfRuYyaAJMZTXjwGxJaZ604enkllMsreV/EIZsQ1X0UrMkLHEuMGI2MG4THkzrumh1vm8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784938240; c=relaxed/simple;
	bh=Zko8iDNBnxDt13+skpFnanyO6gyoFDmgNvvuIcCcWg0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=t2duprsVhxtW3Z3TCKx6yw+G+jlSDZd//Eg7nptSvblUAKvhz3vIRerDjFwPHU8YPPOBG5bCboMVQVVSrwLFZZScvq+ORoTZz8Jp4AiEVY+Lt3JDVALR7yXnSODA4pMpfCRydRmgRV5owfobF+6ehvj7c0R0zdTD0dgg7FY29Z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JKOVTljO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JKOVTljO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DB821F000E9;
	Sat, 25 Jul 2026 00:10:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784938239;
	bh=ZLivT9kGA2BtbGDfTpkvWXnyqkH2d5UL361k1IF+lcg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=JKOVTljOINggi64Md2mcWKenmnoqYGN8tq9plVzJts7PzAscKKzbYpcs7Wl8piZKX
	 DMoFoo1WFWV+pS23RNNsbcgHhPGCp2sdCzYrUSCFJNnfSzTExeZOJP1yrweI+Xq4Bh
	 WnDOMvLwGqgudpTQxG98ILu8vHtNXXmolfYWTwMzrHdSRc6F+d/53kazNOl5PYl+qn
	 64qZSuoW4EDmJ66PD09EsrGf90lFOaBplnABrsUccHlRMD8B/0nCzg9T+9LdIW+jjI
	 lp0WcdmNRegvGIrZhpUOY8rOiL++gns6ebSShyhMRJ65zrxMLWUBt0fp5UO+g1OPLo
	 unkzsRHeIm1Mw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 56ABF38111D8;
	Sat, 25 Jul 2026 00:10:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3] veth: convert frag_list skbs before running XDP
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178493820590.3361200.16785920221578022952.git-patchwork-notify@kernel.org>
Date: Sat, 25 Jul 2026 00:10:05 +0000
References: <20260722191925.2192070-1-matt@readmodwrite.com>
In-Reply-To: <20260722191925.2192070-1-matt@readmodwrite.com>
To: Matt Fleming <matt@readmodwrite.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, ast@kernel.org,
 daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
 sdf@fomichev.me, lorenzo@kernel.org, toke@toke.dk, bpf@vger.kernel.org,
 netdev@vger.kernel.org, stable@vger.kernel.org, kernel-team@cloudflare.com,
 mfleming@cloudflare.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 22 Jul 2026 20:19:25 +0100 you wrote:
> From: Matt Fleming <mfleming@cloudflare.com>
> 
> A frag_list skb can reach veth with data_len set but nr_frags zero.
> veth_convert_skb_to_xdp_buff() only converts skbs that are shared,
> locked, have frags[], or do not have enough headroom. It later uses
> skb_is_nonlinear() to decide whether to set XDP_FLAGS_HAS_FRAGS and
> xdp_frags_size.
> 
> [...]

Here is the summary with links:
  - [net,v3] veth: convert frag_list skbs before running XDP
    https://git.kernel.org/netdev/net/c/d0d641596304

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


