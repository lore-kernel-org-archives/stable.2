Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795683607;
	b=NU5+QPsqAy9sIPK99bW5yNqzUeR1yh476WoEb07hBWaxR5MzVx6u9g3fbzgUHQlNi7mE
	 o23tEoHqjwjz34NzkYlvOgjDhvP75EPcJcRwOOQjct5QVx2I+9IXsECxtNaZKV4BNdoyt
	 ZN6jPGgxd0xIuNLupJfLRCpjY6FiP+RlP+gy1tMDMEqnEqh8PtXw3dU/OUoVTuR3bHPUG
	 Yi+GjysdStXMPrVMNP5yGcT2dF31murO+rZrcFMN6/IaVWtrk2NfjWq75GTByRRLMrx5D
	 d+DWrm2f9J+frasRViGUf5Eso7gnGZDrbjKTmcxXmY0pg6hpgzICJnMHfXhCKNLKIDw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795683607;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=TEgty31plzkgiOVV+GRpxhDGlFoQNh5kg6i9e3toEk0=;
	b=HEDKCrt89MpUBJalc8ErUVj+flnJO/xtJ7wWhm5yJ74apY4ytjNYWKAT2zj7JbBigu7E
	 UlIT/h6rGLOCyx2j3WzhwNPzwxBQFBCEQJtKBGZT6tLrl3zhUt+pdgCLrCmTOB9nxAgq6
	 f6mrBvSzWdCS6RmDE6fNB2zNCxw6ewbFqQtFH6b8rGfP1xzI+g42AQhSwn2oyjOZCh0eY
	 P+RWq+/3prXNPkjB65q9HcGyWy3t3X8LEqjN5Xrc8FqxUpS2D2L5ic8awlcQr9qgouCqp
	 ALOP8I1KmM/02w8WN6RX+hZQ10I+sTZuEw39q8BtdX+sirSqzSZkp7e9V9qUX67G6RA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="bCYCE/nH";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD8DE606A338;
	Thu, 26 Nov 2026 09:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bCYCE/nH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 496B21F000EB;
	Thu, 26 Nov 2026 09:00:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795683607;
	bh=TEgty31plzkgiOVV+GRpxhDGlFoQNh5kg6i9e3toEk0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=bCYCE/nHRSKP/UNvufNeEqDJrkQsJHBG7SBSEUH/esRg7tCuaa9+7Bu0JJjVnCxPT
	 608gbd2JT3CQuglJoqSdZW9/hAACpM7AO+gxpPSfEWfZuOVVedYpYBvUeFnQ8iAmm5
	 LIP3JRUwXCln/p2SJBljSywUTxwWgsxtuwbh6e4644UvrVNa0EdmjVWRMDe5K+IKYi
	 Fge9vGSU5pRgsNxnJEoU4X+hEvPK+JbkoefyX0w/1OMT4u0ROYxyhuGs0NAl61oYtw
	 KEsHt8PV7ev6UmwRUh2KTNPWUc65pXVgatXWu/DPW0NsrYPLb+S02Oij1o1N4WOaJQ
	 XPFcMvanlzqAA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3A5D43809A8F;
	Thu, 26 Nov 2026 09:00:07 +0000 (UTC)
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
Subject: Re: [PATCH net] xfrm: interface: drop non-IP packets before
 pskb_inet_may_pull()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179568360577.1684356.12907143611601535467.git-patchwork-notify@kernel.org>
Date: Thu, 26 Nov 2026 09:00:05 +0000
References: <tencent_46F20906773869221623F9FA26275C133107@qq.com>
In-Reply-To: <tencent_46F20906773869221623F9FA26275C133107@qq.com>
To: Shuai Liu <847807867@qq.com>
Cc: netdev@vger.kernel.org, steffen.klassert@secunet.com,
 herbert@gondor.apana.org.au, edumazet@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, q.h.hack.winter@gmail.com,
 stable@vger.kernel.org, syzbot+d29af9ef5c96a3f5e96c@syzkaller.appspotmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu, 19 Nov 2026 13:08:14 +0800 you wrote:
> AF_XDP sockets bound to an xfrm interface submit skbs with
> skb->protocol unset (0) and skb->network_header still 0 from the
> __alloc_skb() zero-initialization; skb_reserve() only moves data
> NET_SKB_PAD bytes into the headroom.
> 
> Since commit 86de3a1118a16 ("xfrm: interface: validate the IP header
> on xmit"), xfrmi_xmit() calls pskb_inet_may_pull() unconditionally.
> For such a skb, pskb_inet_may_pull_reason() selects nhlen = 0 for the
> unknown protocol and pskb_may_pull_reason() receives
> len = skb_network_offset(skb) = network_header - data = -64, which as
> unsigned int exceeds INT_MAX and trips the
> DEBUG_NET_WARN_ON_ONCE(len > INT_MAX) in pskb_may_pull_reason():
> 
> [...]

Here is the summary with links:
  - [net] xfrm: interface: drop non-IP packets before pskb_inet_may_pull()
    https://git.kernel.org/netdev/net/c/e509726660dd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


