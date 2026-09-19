Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 586BA3B9DA7;
	Sat, 19 Sep 2026 01:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789780889; cv=none; b=QdTZ5kALwTACjHd8CESEjotvLsS1ZcFsh1bEILfd/0cmYTwFIM2wEkqnXFzfwTwd6D0PbGYtejenE5fpThIB+2mIw0HW5lSOhNgsG5L0PsXfsR9rUSJGLX/STJSsE5P9E13HYMJoDd/7cZSjL2KAoS1BPTVVUUx8WQ26l+hbQwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789780889; c=relaxed/simple;
	bh=OYdMBBiyMG0yAA7jK+T8oYaNQizfScsWVE59F9Ha8m8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=LzsmZHXibr9jG6bELMJFSJFOrOjUD9Ht3pELXf0tgSD20TbS5T/GMcL64JrhApcX78wkSZL08Akbt2+whFKN2AXYqbW5OXYD1C0IeGQCpFO+P8A/kG/n+P8EROzzDdHdrUO93/mdDikL4fz/pZd5HGkY+EajIX26KPCNWgFcNF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WIikHbkK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WIikHbkK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE6DD1F000FF;
	Sat, 19 Sep 2026 01:21:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789780872;
	bh=sLkauqrG9cJJazGhRAmL1C5dD6B5Im/JEJm/qQv759M=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=WIikHbkKCVuruURgVsTLBYcRg1Fu5hHTalv+l9gMJWD7Btw7+gA0KxFywbMshdthc
	 NaU4UiMBf90enqZAytGC+iAwdYcK2MIE/YvBmVAF61vL+EbUS2w+aDY5UzmXUo1om3
	 T8cRJ5yPzG0teYTyhslz+TXFc6RhNIKDSF8zCjAmdjDIc8/fFRjq9KTD+/tH+Vgox1
	 +XvHD7eLU2c8Pp2j2WvTDKgXdMGhA6cx3XwWoFpcDjAGgexEZUGQJCKMKtiQqYGxcA
	 VKjzEY8+50qHULuqlYzOiCfP/6WNOrYAioyYU1REgaWx4QXnPBdpNu0Ln/+yM/KQ1l
	 Yw3yhMRpd484A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 1980F381197A;
	Sat, 19 Sep 2026 01:20:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3] net/mlx5e: advertise MACsec offload only when
 supported
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178978080490.1218950.811303206106717319.git-patchwork-notify@kernel.org>
Date: Sat, 19 Sep 2026 01:20:04 +0000
References: <20260917122724.654639-1-ralf@mandelbit.com>
In-Reply-To: <20260917122724.654639-1-ralf@mandelbit.com>
To: Ralf Lici <ralf@mandelbit.com>
Cc: saeedm@nvidia.com, tariqt@nvidia.com, mbloch@nvidia.com,
 netdev@vger.kernel.org, leon@kernel.org, borisp@nvidia.com,
 sd@queasysnail.net, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, ehakim@nvidia.com,
 sbhatta@marvell.com, horms@kernel.org, stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 17 Sep 2026 14:27:23 +0200 you wrote:
> Commit 339ccec8d43d ("net/mlx5: Enable MACsec offload feature for VLAN
> interface") added NETIF_F_HW_MACSEC unconditionally to vlan_features so
> that VLAN devices could inherit MACsec offload support.
> 
> mlx5e_build_nic_netdev subsequently copies vlan_features into
> hw_features and features. As a result, all mlx5e NIC netdevices
> advertise MACsec hardware offload, even when the firmware does not
> support it and the driver does not install macsec_ops.
> 
> [...]

Here is the summary with links:
  - [net,v3] net/mlx5e: advertise MACsec offload only when supported
    https://git.kernel.org/netdev/net/c/4581c3d2adc3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


