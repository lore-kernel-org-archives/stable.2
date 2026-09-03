Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB35335E944;
	Thu,  3 Sep 2026 02:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788402688; cv=none; b=QZtmQFP817pAl8uG0L5UnINsOwQZ2KhKpIiQqK6OwLAGBzKlGRsd9U9Nw3o/b2bEp7wyBReabpkEWNfNiVhJJU2ULpf+VHxZJPjUy6Zwphmxc4tn9h9qKTefpuRCyn7R1tOZgqMsa89EKL29hxnAzyuygW8EYffwcOIk1NJVCss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788402688; c=relaxed/simple;
	bh=GScD0uQsJvySgT3JAvkD50v55vDGr+Vlu1GbznkYPXk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=FUuCN4/EAIydttXszKrriMvnl2tOBFwlsqhaDxsjsfzDfZi8EmctGhPyGs0zPKuc0Bd+PCDxSYjUOKQBqdZrok96keD2hQhrOBEH1bjLwKWb3fHgLp6oKS6dCwxS+mHp9fCrooiZ2GK+ZmNXOrueJ+F0ryFhCmCtUVw+6vI4pnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ITTTsyiN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ITTTsyiN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F399F1F00A3A;
	Thu,  3 Sep 2026 02:31:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788402674;
	bh=AevkmPjURy5c1fxyhb3q3dISA5DXCYytj5WTAlaPUOU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=ITTTsyiN+HDj2gJcKPZIUZcGr/gho33vZ8K8B6KUAPvh++E9jLgd6i12aywIY7JGa
	 tHxcHekAJg5BiCO3Bo3m+M/xIhC/uxvtbn6LTDq1uIMgEHLsemKCIbCkmGJyhdwSYF
	 O6IESwWNjLVMaHaBkptzsJfPU972tJkKrWIn2E0tApb7abjRqbAcX7RVur/W7B9lhQ
	 hINrdGQm1lwkniHrzbN4debMAw+Pzib2/a+l4mRQrSBECh3aUdg9Se515f8a6nQvP6
	 4vOFP5/3VFZAjMvxv2ukE2T0GylICZxCoUfNawOWlNEwTUj3aB3+O/zT7/fGpWnNiD
	 lcJql/9j8Dmdg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0E5F3927056;
	Thu,  3 Sep 2026 02:30:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3] net: phy: air_en8811h: restore AN8811HB LED GPIO
 after
 MCU restart
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178840261539.3050934.14870920654715598424.git-patchwork-notify@kernel.org>
Date: Thu, 03 Sep 2026 02:30:15 +0000
References: <20260829033844.1975-1-xuziyougm@gmail.com>
In-Reply-To: <20260829033844.1975-1-xuziyougm@gmail.com>
To: Ziyou Xu <xuziyougm@gmail.com>
Cc: netdev@vger.kernel.org, andrew@lunn.ch, hkallweit1@gmail.com,
 linux@armlinux.org.uk, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, bjorn@mork.no, ericwouds@gmail.com,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 29 Aug 2026 11:38:43 +0800 you wrote:
> Commit 03b4702fc5e3 ("net: phy: air_en8811h: move LED GPIO
> configuration to config_init") moved the EN8811H LED GPIO setup from
> probe to config_init because an MD32 restart clears the output-enable
> bits.
> 
> AN8811HB follows the same initialization sequence: an8811hb_probe()
> enables GPIO3/4/5, and later config_init() calls restart MD32.
> 
> [...]

Here is the summary with links:
  - [net,v3] net: phy: air_en8811h: restore AN8811HB LED GPIO after MCU restart
    https://git.kernel.org/netdev/net-next/c/3498acda6b68

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


