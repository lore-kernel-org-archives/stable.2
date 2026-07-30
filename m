Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD1D6381AE0;
	Thu, 30 Jul 2026 23:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785455443; cv=none; b=AQUlPOxuu0AAYM9Jr4dvAAahZ6CPr65j9etG2I85aRWTJql8sYqKAksdmDA337kqXbBv6Pef7xTJoifpOF2KFwCvaXAZbw1rcv+ZIqaEShyOT5WwVKv7vigMXAoHRwdWHpn5NWUjW9SxC7UGoGKNzlGM0CNvq/nkSY1A4kJnsU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785455443; c=relaxed/simple;
	bh=EfHJMSR9mrQkJNs0iulkb3NIEL/Ny+oJslGFBxYe3yE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=fCRFxR2mtrn92VkrZQj6KMkKe6ie9SJbfKU16CwN1+xfHoR48Tx5+Vf1r7vMoZnQ82Daj/5cx4THIsFK0vVyRa/F11HFtNhmXxgUoOU2McBb1giTlUbC0s4g1bT5wcWpnKQnVdsaPcjvZdht7rxZXvuznlGiogG5RI0+X/QSV38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=chSYqu4r; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="chSYqu4r"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A2311F00A3A;
	Thu, 30 Jul 2026 23:50:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785455442;
	bh=o7x4qo0dbYpOtv9TGn49E1T/fS6oN6kSEOvCKZK4ytc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=chSYqu4rYSZM/ZJnQ8/1TifbqGTQuv8Tozu89mKl5ffg+pGewxwghVCheJnlZTJ4X
	 bibxHfrHN1B1qd3pxsztrC+XJxKHmxY1jdt5/SJyPtd6avRNDF9ILd43GbUbQVH4Vo
	 Oy6gqZmXG7H33j580d1HzhAdf4Mqneyj69tG5L+dGN7ssJV1tKyMEW2TmFCpkIFuGH
	 uyBDcD7Db+ShGsqOqAN9LnZE2L+CXzaLDzjvrwLdYz1+2l/N421UH6lrSnG6XltjAt
	 VddjZouMPKwOJkwanUdS3GpIOwZC+yOADXNq7UAmRJ3TqYY72F0kfi5ICF4OBHIZif
	 r6BqRvWdE7Nrw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0B2D392445F;
	Thu, 30 Jul 2026 23:50:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net/packet: reset the MAC header on the
 packet-socket
 transmit path
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178545540570.44276.13476302996465546754.git-patchwork-notify@kernel.org>
Date: Thu, 30 Jul 2026 23:50:05 +0000
References: <20260724144015.63219-1-doruk@0sec.ai>
In-Reply-To: <20260724144015.63219-1-doruk@0sec.ai>
To: Doruk Tan Ozturk <doruk@0sec.ai>
Cc: willemdebruijn.kernel@gmail.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, sd@queasysnail.net,
 olteanv@gmail.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 24 Jul 2026 16:40:15 +0200 you wrote:
> packet_parse_headers() resets the MAC header only for a SOCK_RAW frame
> whose socket did not bind a protocol. A protocol-bound SOCK_RAW socket,
> any SOCK_DGRAM frame, and the legacy SOCK_PACKET path therefore leave
> skb->mac_header unset here.
> 
> For frames sent via __dev_queue_xmit() this is harmless: it resets the
> MAC header unconditionally. But the packet-socket PACKET_QDISC_BYPASS
> path uses dev_direct_xmit(), which does not, so the frame reaches
> ndo_start_xmit() with the MAC header unset. A driver that reads
> eth_hdr(skb) on transmit then dereferences skb->head + (u16)~0, an
> out-of-bounds access ~64 KiB past the head -- the same class fixed for
> one consumer in commit f5089008f90c ("macsec: do not read an unset MAC
> header in macsec_encrypt()").
> 
> [...]

Here is the summary with links:
  - [net,v2] net/packet: reset the MAC header on the packet-socket transmit path
    https://git.kernel.org/netdev/net/c/c2707480cfbf

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


