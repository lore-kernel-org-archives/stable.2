Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C44A2227EA7;
	Mon, 17 Aug 2026 20:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786996871; cv=none; b=bOTnqbuFdROQfQUsQScXTd/W40gNQgqwlpz+EWdlZU3wSa1XQn9FBJis6J3Isj1DEHLk1oEAQ+UAttkwUhGJgOLzyA4AVu8XgFbzGUUt/z2+1NBC5zodzMTRKSqmmpPuwWJNGuir9pxAyg2U2VT8lLNZp9zOQFJtKQHy+hQhxeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786996871; c=relaxed/simple;
	bh=catEK8hKMXaMqIPslB8AV7aglY5Ac/Qiqb0Fqc/46rw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=a7QmAHbAZJ1h0AV4WjDIvHwu6QWZNUz2/eCe1klFaJSjVl3DH2NbHitmU6MeLhJ1vvlS4nPEGZgjo3T2xjw7TL5R23oixY6HftI2JVu7uEihbUOV9Ml2J3jOYno/cabVi6mNqTgGwGWdt4fgPX9GSudiF+dGJACuT0S9QvQq4WA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NRuOX9iy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NRuOX9iy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73B171F000E9;
	Mon, 17 Aug 2026 20:01:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786996870;
	bh=5wzcyD22o4ZKBFfqa9wCKA/sLpaRiaUWvaQGXEUELbM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=NRuOX9iy6EU8B3c8ayvJjAgAs7rU0ppWGjsh6TJ5NgVnIpzkJ6CTvzsxpC1MoyGr3
	 t/erLM4CNR43XhRxQ2oxvA5QDtFmW3pHAvReIj/Njim/kyQ5+AzRJLbyfCaJnXXfwZ
	 KApfBrDvoWzLZi29/d6KnQ/XhCY79TGNhgoKJ5/S7RjRAMDgyLL7FMHFMtRp5zoXqK
	 6q+bG28ngYACEsdlXartWOa3MpHTfcOt17uNyfA5lVMOd/luzULlv8xPp3eFUwaXDf
	 L0K6V+n/C5lXRwnDalYTDxVe+saFpHB0BUwkzbEV2Bzjb3azPV9G5HzsqsoKnCOKuU
	 nNeVhC4uBHN8Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D097F3926263;
	Mon, 17 Aug 2026 20:00:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net: pktgen: use a consistent flow count
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178699682239.1714062.12069197278816778228.git-patchwork-notify@kernel.org>
Date: Mon, 17 Aug 2026 20:00:22 +0000
References: <20260812052130.32823-1-marsy12010123@gmail.com>
In-Reply-To: <20260812052130.32823-1-marsy12010123@gmail.com>
To: Qi Zhang <marsy12010123@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, nicoyip.dev@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 12 Aug 2026 13:21:30 +0800 you wrote:
> pktgen_if_write() can update cflows while the packet generator thread is
> inside mod_cur_headers(). The latter first tests cflows, but f_pick() then
> reloads it when selecting a random flow.
> 
> This allows the following interleaving:
> 
>   CPU 0 (kpktgend)                 CPU 1 (proc write)
>   if (pkt_dev->cflows) // 10
>                                    pkt_dev->cflows = 0
>   get_random_u32_below(pkt_dev->cflows)
> 
> [...]

Here is the summary with links:
  - [net,v2] net: pktgen: use a consistent flow count
    https://git.kernel.org/netdev/net-next/c/f98ca137c2dd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


