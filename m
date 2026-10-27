Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793101206;
	b=HC0dExGnWwJG2RZSGXzNJxvxDOKBnpibNjAEbKjbjzO0EGS0VqGXxTzNrN/mF5OBsrV1
	 YLqNHinhePOxt2k9qMgAl30Ia5AIyjgcufkIqkR43zdjFBqYTFlQ4ty/SqRzUkVcLUHyO
	 RAmI3POIdy9pV5RlM/qjsKaQHm6y07nSgfiWkMfNitrNSJPpxsba22naU81Ndr16BG3j4
	 m0MGH6ehAEIic6DvhNoUeSIYzzjjoUwFQ1JYorC5xFyjrgSMTORYofM3FepYcgGSwYSwQ
	 V7RE9zX9rwpFcKfcT/h7s0W/eQGnqsjTx448tzwLlR5B4UrslyJuMCMlL/b2DU6k3Lw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793101206;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=+MGD5y0SBhnCGXPr8r7cQslHIIeWmWu3KbgjBkuyqHo=;
	b=m7e9N123X1s4wDLNyZRYYnvsAc7mPG04Riv4v0c0xSnOOPtjwqIbt1Ey6zVE5IAGz6NB
	 adgAL3y24A/17hwnWyg8c84g1sezKidqid/NUIx1uyaCumW0Y5q1PnAz86CzzEhFuoFW5
	 P8PVyIVEjLA0FF2E34WtdMqJ28Y+r9UG9kSc/mpGmZC7O1E4jzJntI/+VCQuNWUrbM/1e
	 b/OWTklQThim5ljD+ef8uX1hVmaGc6OpW8ac8ye1bfgIUCXz2hQ7+vpUNh1cgVTEVJ4RE
	 7iCuTTv43xXX17vDcbjLHiDvL2mYlKt+uC5ePRvF4/vv2v1d0HiuYYDpIfncBuq7e+g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EUXRkTe4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6373606A846;
	Tue, 27 Oct 2026 11:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EUXRkTe4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BE6D1F01825;
	Tue, 27 Oct 2026 11:40:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793101205;
	bh=+MGD5y0SBhnCGXPr8r7cQslHIIeWmWu3KbgjBkuyqHo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=EUXRkTe4r4JcQ2KGgypdfiuQkb+knaSjR3gCaF+kUwN1aOlG58Gr5Z0WHP+iITQHL
	 OUsMtObX/cDjJF1yRpHkgTpczdOMom2WvL9WUUj9ZjOxjoR2lO03mZho30q4a52cyp
	 d+b5U5mC/r+aW7xfeOliHgLO9L98OAFtVXjJQEMkp56O+rQCYjagLpLBDL2Z4eQiCs
	 zyDBbCYp1nP6KTQ5He67BDe3Ub3/RgqwCWpVX/Aa0ixvS34UdekR4BhZ3A26Cv4YtH
	 B/LmApMJJTml7b6G3NUdBoE0xa8fxHHqnES6paJi2XGWYFZNCxdOd6AFACdy/8A4Wt
	 JIgSAwIkw+xKg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 815853AA939C;
	Tue, 27 Oct 2026 11:40:05 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] ixgbe: reserve TX timestamp after skb preparation
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179310120441.3755414.16229460906940090919.git-patchwork-notify@kernel.org>
Date: Tue, 27 Oct 2026 11:40:04 +0000
References: <20261026082035.335770-1-edumazet@kernel.org>
In-Reply-To: <20261026082035.335770-1-edumazet@kernel.org>
To: Eric Dumazet <edumazet@kernel.org>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 willemb@google.com, horms@kernel.org, netdev@vger.kernel.org,
 stable@vger.kernel.org, anthony.l.nguyen@intel.com,
 przemyslaw.kitszel@intel.com, andrew+netdev@lunn.ch

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon, 26 Oct 2026 09:20:35 +0100 you wrote:
> ixgbe_xmit_frame_ring() takes an extra skb reference with skb_get()
> for the pending TX timestamp before preparing the skb for transmit.
> Several of the following steps may need to reallocate the skb head:
> 
> - ixgbe_tso() calls skb_cow_head(), which reaches pskb_expand_head()
>   when the header is cloned (e.g. a packet tap holds a clone).
> - ixgbe_tx_csum() falls back to skb_checksum_help() for unsupported
>   checksum offsets, which can call pskb_expand_head() through
>   skb_ensure_writable().
> - With DCB and a software VLAN tag, skb_cow_head() is called to
>   rewrite the VLAN priority.
> 
> [...]

Here is the summary with links:
  - [net] ixgbe: reserve TX timestamp after skb preparation
    https://git.kernel.org/netdev/net/c/f75062536e2d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


