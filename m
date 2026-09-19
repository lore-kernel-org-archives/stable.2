Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B95EF59B56;
	Sat, 19 Sep 2026 00:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789776690; cv=none; b=nGQ7qg0hZEMxFowcoxTo0RrUAHmYVNz5QBCMSaYVWTn8WOXVqzF8ta0SV7D/yxqpMay8N1it9GzGx61Qc6IIJB8xFFKdSUgEbtOBsVqoAOdbejKN9EIL5DeZwJlv9Ui5PA7MXNKfOsGdZkQhNhmcNgfJ+n1UK/NUDnYB3eqT7Q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789776690; c=relaxed/simple;
	bh=zlnNvibZ9UECBOhcxsqRmSALx8GJ4J/HotslRkKs6Dc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=VlF6wzzO1S6w6O0GnKhkO7WIiOsxTSJqrc1Ohvf11ejtXTHCYb059DbjP7ZQDSYYl6TM90FQoqC0GxONsUEPE2hhbDTSN1WJ2nr8fn6h0FX6YT0iMbd0nHNHFw8zxipp2jB3tJlBC9Ax8A7scfRsEtVfb55gD+ZzhCZ+EXRLyZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D0JvA1Ez; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D0JvA1Ez"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 690DF1F00898;
	Sat, 19 Sep 2026 00:11:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789776689;
	bh=lhf5uqL5K15bNYATsjdroq30RYPaV17sToVOTYUPIVk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=D0JvA1Ez8GvKLnHpfL9Fd6apsvbE/2cW6FGj0MHi+qP6nUfq6Q6LDUU3loXnLnh+S
	 aKrMbDvdg6Bg7QbJE2fDgzVS/+5FSbn0SkDuNSV68bEGhkKYV2ItwLsbJgNzh9FjQS
	 t7db3gmfKdZt170CqMYQB227F4mRmtnthcCa3k8qjQr5HuujO0rhaN3G1yJP0KFvKu
	 6fiE8UZWXi12v8/8wAD4bEiHReQ4dOLxeVwdVQX8iMJA1MChc4PVsozKd9hAYqqB4S
	 e71jvwbiAKE9nC8KQg4rhe54eo4U5PoYdMhguQTtehRwX/fqfRcgcL3ECjcFjqtnzz
	 GwZ/gEx+M1VGQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 939133811977;
	Sat, 19 Sep 2026 00:10:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: ionic: free VF resources on remove
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178977662214.1197442.13036951567761793356.git-patchwork-notify@kernel.org>
Date: Sat, 19 Sep 2026 00:10:22 +0000
References: <20260916053117.2906446-1-lgs201920130244@gmail.com>
In-Reply-To: <20260916053117.2906446-1-lgs201920130244@gmail.com>
To: Guangshuo Li <lgs201920130244@gmail.com>
Cc: brett.creeley@amd.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, tglx@kernel.org,
 kees@kernel.org, tiwai@suse.de, wangruikang@iscas.ac.cn, sln@onemain.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 16 Sep 2026 13:31:17 +0800 you wrote:
> ionic_probe() allocates VF tracking data and maps a statistics buffer
> for each already enabled VF with ionic_vf_alloc().
> 
> The probe failure path releases these resources with
> ionic_vf_dealloc(). However, after a successful probe, ionic_remove()
> tears down the LIF and device without releasing the VF resources.
> 
> [...]

Here is the summary with links:
  - net: ionic: free VF resources on remove
    https://git.kernel.org/netdev/net-next/c/9f1c440f9283

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


