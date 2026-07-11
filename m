Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA31730F938;
	Sat, 11 Jul 2026 11:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783768830; cv=none; b=OuE7X6NH8pBuIIvOuP1kZzrKacWya1vhyn5cWRmUP32OrUKEG8pcKHrkgMavbtR5AwFepeOLC4kpsDfKAywopbboV7wxXqjkPoPF2bSTo8uUL/VgQZvQ6KgZjByLWAHvxyVxXfjAEMAb/6ZkBm2hU9VRWJwRRHi350UMWYZJyvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783768830; c=relaxed/simple;
	bh=WRXN8jmaeV1QtLV6fcDmvp9cxQx3koK/KqBqE6bqrPo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=eY3SPPoKP2REEDDK+9PV/5Zzo3GK7ilHwH2FlCB9Eu1HCmKzemKYCbFVYiK8/T1VhQIufi1MB5xV1wYP/5CaQQw/ttPV6fBlY13JcQPSUsr1ZGhHRbnmUeR2zNZ2BWNQ8kycfVkOoudeT+gydXDZfBiXr3Qd8ga+KmSlkOj1AEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CTIb8XkP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CTIb8XkP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 831F41F000E9;
	Sat, 11 Jul 2026 11:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783768829;
	bh=I4P3ukPBAPyUNBYCLfuvLvoMBHWyWY23AbOL42za9c4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=CTIb8XkPGy0Rrvi65dH17awar+n9eEhu+UeE3ELNn7YT7Js8Lniiamapm7F7g88vn
	 PpiTXz7ShfnRIzhAxgYbI6nMBI5I5EU81/WjOnKmnJ8qb4vdDmPSPGypL7i/kMc/0S
	 2HEi42LdqvmAWR+2cduIgWWPI7poqoehzA18lU94FbsUiE4Lw16/Cb6ySICbE38sgF
	 qh+ZXb8OaWRKAyXFmYm5QrC2rfUkI5z7EntCA/6rlOJYerK0fJuV035Whjd/P49oWL
	 +xU4mFNQK6GDS3z5fifSXbw2b0HUr33Bkv/KC+95sjBdINtzuhvtvlimUEx1lMlIvJ
	 z+SJNspql0CPA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0A2939244F3;
	Sat, 11 Jul 2026 11:20:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: openvswitch: reject oversized nested action
 attrs
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178376880639.1083328.16620372107082658323.git-patchwork-notify@kernel.org>
Date: Sat, 11 Jul 2026 11:20:06 +0000
References: <20260706094336.38639-1-manizada@pm.me>
In-Reply-To: <20260706094336.38639-1-manizada@pm.me>
To: Asim Viladi Oglu Manizada <manizada@pm.me>
Cc: netdev@vger.kernel.org, dev@openvswitch.org, aconole@redhat.com,
 echaudro@redhat.com, i.maximets@ovn.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon, 06 Jul 2026 09:44:10 +0000 you wrote:
> Open vSwitch stores generated flow actions as nlattrs, whose nla_len
> field is u16. Commit a1e64addf3ff ("net: openvswitch: remove
> misbehaving actions length check") allowed the total sw_flow_actions
> stream to grow beyond 64 KiB, which is valid, but also removed the last
> guard preventing a generated nested action attribute from exceeding
> U16_MAX.
> 
> [...]

Here is the summary with links:
  - [net] net: openvswitch: reject oversized nested action attrs
    https://git.kernel.org/netdev/net/c/3f1f75536668

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


