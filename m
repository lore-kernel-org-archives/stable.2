Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BD9B414A2B;
	Thu, 24 Sep 2026 18:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790273490; cv=none; b=Q+UZndouBAolqOv7SMtQa/GL7IEEikx2lVCgeFnicMYF/XxU23xIM9C7DHI60kKBSl3cPDfmGRHDMYN6lAHT3J2OOKsDQpoB4JA29ko3Er8GSjRTofp1g5GOfEnrpF8sHCKcyGY06cv6RaYxSTigyZDSN1s6S1ScpBvI0x0yplk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790273490; c=relaxed/simple;
	bh=RS1BPBNpFy/IJRUj7AKTNhavOSw7epugGV+e33iadzQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=S8UEVsMDelknBI0D92DGjHcCNBz0OFjeegFNGiadPVVCuQAL88YX1wbccRUwexIzQtbhj8JhPZrxn7LBLnTMWviO0iD+3HQMQ9L8yAMm0XKLi6zhnwkscmEUk4M+WfO48fpak4MVctYL0oX7tb49Fs6pTYQbOs7Fq8ruDIxz1MQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mvgxOpdv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mvgxOpdv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFE891F00898;
	Thu, 24 Sep 2026 18:11:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790273488;
	bh=vfjpOrySqbseWDxpJq0bbS4xH4n75UMTy4DQPXLMvys=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=mvgxOpdvrxbZl58ueb/T6nh39kV1oL8BxTV0Ju+kRyIvGfmQsHHWHra5vtMkGNNab
	 X7RlZoQ/iL4d1HgzyxNGxuznE30jGomb4D/Fv8HsEmhW+nS9K80sOFKH7dGPV/B1SG
	 K+WrDQVjncS6xsWIp2ckBvqUPAhBUj8CLsgLz4AV+/XVhPQtoJCTyxdUl/8FHJfj/s
	 Ca6RBrUK55zjuf/e3dzcwSq6RvjjgUM/R2O8YAaYpLg9ISQzDK4WACDLHBKaJSmO0C
	 lOIblAjFMh9AFVlw3NIgF85l3Y1cU/O4ncxSN54xPt1wNnzIMKBvlL1UF+esxUpI3v
	 ZtzHv+UBZWRKA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0B6F3A566DD;
	Thu, 24 Sep 2026 18:10:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] tcp: prevent collapsing skbs across boundary in rtx
 queue
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179027341739.1690644.1321155040303228016.git-patchwork-notify@kernel.org>
Date: Thu, 24 Sep 2026 18:10:17 +0000
References: <20260924154427.953800-1-willemdebruijn.kernel@gmail.com>
In-Reply-To: <20260924154427.953800-1-willemdebruijn.kernel@gmail.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
 andrew+netdev@lunn.ch, dzahka@meta.com, john.fastabend@gmail.com,
 sd@queasysnail.net, willemb@google.com, stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 24 Sep 2026 11:44:12 -0400 you wrote:
> From: Willem de Bruijn <willemb@google.com>
> 
> tcp_write_collapse_fence() sets TCP_SKB_CB(skb)->eor = 1 on
> tcp_write_queue_tail(sk) to prevent skbs queued after a switch to
> device encryption from being collapsed into earlier skbs.
> 
> The fence is a no-op if all earlier data has already been transmitted
> when the switch happens: sk->sk_write_queue is empty. The not yet
> acknowledged earlier skbs wait in sk->tcp_rtx_queue with eor 0.
> 
> [...]

Here is the summary with links:
  - [net] tcp: prevent collapsing skbs across boundary in rtx queue
    https://git.kernel.org/netdev/net/c/fc6d80eb5044

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


