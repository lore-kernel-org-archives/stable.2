Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 142133BCD0A;
	Thu, 20 Aug 2026 20:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787256060; cv=none; b=cpn3QqdBSDUCJeTZuMPYuxkEyGlE5/TeB1orEAhpudaQYdi3y5ErTXF7LHI/jKzXUmLr+3n9//0lUkzBZ9+kvGHIQUjoHmsqty3Q7gHppNlv5FKv49BBrF0RXM2oqjc8wHyFZN82jdVeJGEW2W6As6AGGpYoCxfy5zVIyw/rKPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787256060; c=relaxed/simple;
	bh=8g61RoNHQqAzOOfdY1lbZi9krehjtB0P5RqvcnbLdGI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=kq7KX7ADjsJzGwwgBQfCODqmjCBPDKcYBsrs3PkvmD12j39x5ljTNfY6U8qYkXT+peGGtRzVGUJtFgOQCkV36VadaRy4xqeuVxaL/YrzhWTCaXSi6+c0Kto6tKnAiJNtq7Cd0ZoWpasey8EG/TaHNitUJ0/FZRpXJVVzQ5XqzI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kUVmUW9H; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kUVmUW9H"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A530C1F000E9;
	Thu, 20 Aug 2026 20:00:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787256058;
	bh=DOs0n9SEm4ByeHFXj/fa0wKmj1XGR2iTgtrSlS1at0c=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=kUVmUW9HxZlcNTGBcG68Ja3Zh5v6gjGZOOcBQUposCjRnsGtd+XyACBg0lysMSk24
	 NJRyU3gUb8Hg2itv4O5ffHfiK8VQ+7/hqLnYcMwzZb5+GP0RqGxieYeW3whECmpj4o
	 yWcLVZquIleYgfc3G0yMG/+o7GbT1C46vuSJbWCMWyFXUTHDXItvk+fY0SAzHevYFb
	 uEAnOoCeRhk3YHXQuvAys9rlMUzTtpIuIYLGXfCmcY+ELzNaUSclVLUVbWRfEtPOxk
	 6mj1WwKU2h+j3sozwkVO9ZVB7wAIWhBStI2N/CzwmZiklvsgjlZyZv0NMF2BRvm8ld
	 kll2HQmzDZ+pA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 19918392445B;
	Thu, 20 Aug 2026 20:00:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] mptcp: fix uninitialized local_id in syncookie
 MP_JOIN
 reconstruction
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178725600863.460874.9689834140806639279.git-patchwork-notify@kernel.org>
Date: Thu, 20 Aug 2026 20:00:08 +0000
References: <20260815115205.197151-1-harshitvaru666@gmail.com>
In-Reply-To: <20260815115205.197151-1-harshitvaru666@gmail.com>
To: Harshit Varu <harshitvaru666@gmail.com>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, matttbe@kernel.org,
 martineau@kernel.org, geliang@kernel.org, stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 15 Aug 2026 17:22:05 +0530 you wrote:
> mptcp_token_join_cookie_init_state() restores remote_nonce, local_nonce,
> backup, join_id, token and msk from the saved cookie entry when rebuilding
> the request socket for a MP_JOIN 4th-ACK handled under SYN cookies, but it
> does not restore local_id, even though the SYN path saved it.
> subflow_ulp_clone() then reads that uninitialized field and stores it as
> the joined subflow's address-ID. Because the request-sock slab is
> SLAB_TYPESAFE_BY_RCU and not zeroed on allocation, the value is the stale
> byte of a previously freed request socket, which an off-path peer can
> influence by sending concurrent MP_JOIN SYNs. This corrupts the path
> manager's id-based subflow bookkeeping for the connection.
> 
> [...]

Here is the summary with links:
  - [net] mptcp: fix uninitialized local_id in syncookie MP_JOIN reconstruction
    https://git.kernel.org/netdev/net/c/b878dfdd12d7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


