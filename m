Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795655411;
	b=0nZEptYrCdVjNB6wEF+grTUMCt5liERAxWCTzf3soznm4FhkOpHXuxfWMdWYH5gRvNTM
	 ktt+sdW2+JIThcUR+jccclztioBl5OjZqgHOHfdIDdDrQYEQGfPAsQHUbgw57waq5AgOs
	 qwkgKjbDL2wffmsYSW8dqGo59O/SaHrqfKSNBSAQTRHY3fyBF82fKlAFoc/9e7+TSvkX/
	 /rnp+oL1CBpaF5kHjRQD8pXGaHv3gHHVwKsc0NomJ/XwehJF9tYVBv+Njmx7v77+j7S5P
	 crjutNYDwaFWBp02D23hCcce3Hz74LjU1WlU2GCu+ClIwnyGCgoUB9jbgpMesoqamWQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795655411;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=hLqcqMJze4p895PyhjSSj+Tnxq3rn5mo+PGedMdTRNQ=;
	b=FZmAwSTTZawtBFA7/6OehCElzSUzSm8j+MOTu/fDWjh4/N5wnsV6+z2NKvPAaVE0UZkO
	 K2m6P+XqEU25zLNsD958N9JMJtwQq+H70x6hGf67GAgRliJYqOnRg7FMSs0ouGqWXcyzl
	 MnrE2bSg0ASaTMT1K3KDlGBf8p0Nq/rm2CwZjU3ZW4GcMEyMt4urdxvZ58bQcKDjj97r8
	 282ydvnNuZhIrW8rdTJrudtJJjq8h9n/HA+kMQxZQGCA2g9QoFr8vBzyNs2No877CdlVP
	 UvHiXei00UmZkH2ZeWROlGn6+zNIaiwnc96Ddk/TwUCbxKdZBd6mxN08kBt4XzYFStg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VkAOY2HH;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 859FB606B74B;
	Thu, 26 Nov 2026 01:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VkAOY2HH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 427B91F000E0;
	Thu, 26 Nov 2026 01:10:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795655411;
	bh=hLqcqMJze4p895PyhjSSj+Tnxq3rn5mo+PGedMdTRNQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=VkAOY2HHQuDGOkhEX07xSs9Sbgj5AzCwb6MVURp1N7KzgV8N7bCUO7HktDtB5gNTP
	 mmbgWuHHYUwQIwdpmjKPaDcgqAIfO1J3us2t7qWPrgg0RfKrBfbkAN3JccGxsC2tCR
	 y4T/GGTy2ZuOsa4DGRtYx+eHDbawNQs+kuRNzcon4rkDYyAyEbQkyy5anQB4K0Z376
	 a85nk1vGqopCXkkyCtP8Oyjr5NfkoN9qtBZsC1Nx5qPJg14SKSihH5q5itqpcUqDOP
	 dgX2v6EyO8dVnTCgRubw7OsCJA7gEPa4vOwQM2jO7pGiNmPbTHJrzd8u1LQDYQRiLg
	 s9VhpJxLlAhEA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3A3243809A24;
	Thu, 26 Nov 2026 01:10:11 +0000 (UTC)
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
Subject: Re: [PATCH net v2] vhost/net: Fix receive queue test in busy poll
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179565540977.1427026.8052845055528929913.git-patchwork-notify@kernel.org>
Date: Thu, 26 Nov 2026 01:10:09 +0000
References: <1B3A1B72438119BC+20261120033824.681219-1-raoxu@uniontech.com>
In-Reply-To: <1B3A1B72438119BC+20261120033824.681219-1-raoxu@uniontech.com>
To: raoxu <raoxu@uniontech.com>
Cc: mst@redhat.com, jasowangio@gmail.com, eperezma@redhat.com,
 davem@davemloft.net, kvm@vger.kernel.org, virtualization@lists.linux.dev,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Willem de Bruijn <willemb@google.com>:

On Fri, 20 Nov 2026 11:38:24 +0800 you wrote:
> From: Xu Rao <raoxu@uniontech.com>
> 
> sock_has_rx_data() returns a positive value when receive data is
> available. For sockets without a peek_len() callback, however, its
> fallback returns skb_queue_empty(), which has the opposite meaning.
> 
> An AF_PACKET SOCK_RAW socket is accepted by get_raw_socket() as a
> vhost-net backend, and its socket operations do not provide peek_len().
> With busy polling enabled for this backend, an empty receive queue is
> treated as ready and a nonempty queue as not ready. This can make
> vhost_net_busy_poll() stop polling prematurely or fail to stop for
> queued receive data, and invert its receive-side scheduling decision.
> TUN and TAP backends provide peek_len() and are unaffected.
> 
> [...]

Here is the summary with links:
  - [net,v2] vhost/net: Fix receive queue test in busy poll
    https://git.kernel.org/netdev/net/c/cdf84b850584

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


