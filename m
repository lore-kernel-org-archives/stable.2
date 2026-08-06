Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B32AF37F33F;
	Thu,  6 Aug 2026 16:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786035090; cv=none; b=HnZEQdi+zq0F3Lx8fG2cNbd+nTbBBKJG/aQ9cEluEdDHVlYs1rFSwREP2plBEz5dw9D8DPs8fdku3/Be7iu3wSYJr3o34DpwkkIYSa6HTdl4JuBHjrGn1HuHbCacUzQ73p9mwDSajQpVtQ6nHt6LWqVBhIulvQvH6stWD5K+w+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786035090; c=relaxed/simple;
	bh=45NAAedD7g5YQOH7dpDDYjiipzqsZkcyr1oeZGTxmM0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Uo4rzgET/s3tDQBNYASlZAq7/WE/3OxMOZtzFDRuAhPFRoLqyA6zysXTWJlNYpH98Y/7A6MYBEVuyXb6QLfEOF9d3f4gHZPSTB7TouPtnoRXYpeAiTmEc9H4/0aQ/lw/0Pzd0VWOEiE+HJxzydL3gqI9E/cAhNfpOpLyI8AhFLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FisnvbAe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FisnvbAe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 155821F00A3A;
	Thu,  6 Aug 2026 16:51:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786035079;
	bh=V0d9CVOXxDdjEJr3P6dHA3Zp9kfbflA+jBu+F9nto8E=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=FisnvbAePHDRcw+b0+qIYZ/gdnEKt7uRu4uEwv2x9qMZDPhTpT/oxxZDdHIQeTxjb
	 T1cS8Jem6Bp4rZpT7dPtCa+5k5n4IRLgTg+dOuOpcEg146ed44RrdDyXvF/F8gbzkY
	 5+D+3kt/enzieBb8dAqNHjVCgnuq+PNoBuuKyWxRq4tncuC4W3dZ5xWug13V9IjMnV
	 WCw+nZVXryyjx0PpouSGyuaQAdh+ty5NZ42WSzNTRqEpPzmM419aA8iUY+AGcW2nRe
	 QRNlbGiOCwD+oRo9ueQAwkaLahwcPRm1+tNeqA9TnT5ILDLPr3ODsjUYwl9+b0FW7R
	 YHJyUTwr9cmGg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 939E4380820D;
	Thu,  6 Aug 2026 16:50:39 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 1/2] fjes: unregister the netdev before destroying the
 workqueues
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178603503813.1375455.12729853575409508362.git-patchwork-notify@kernel.org>
Date: Thu, 06 Aug 2026 16:50:38 +0000
References: <20260805011410.414431-1-fanwu01@zju.edu.cn>
In-Reply-To: <20260805011410.414431-1-fanwu01@zju.edu.cn>
To: Fan Wu <fanwu01@zju.edu.cn>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 edumazet@google.com, pabeni@redhat.com, andrew+netdev@lunn.ch,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  5 Aug 2026 01:14:09 +0000 you wrote:
> fjes_remove() destroys the driver workqueues before unregistering the
> netdev. The interrupt handler queues work on them, but the IRQ is only
> freed from fjes_close() under unregister_netdev(), so an interrupt in that
> window can queue work once the workqueues are gone.
> 
> Unregister the netdev first so fjes_close() frees the IRQ and cancels the
> workers before the workqueues are destroyed. force_close_task, which the
> workers arm on the system workqueue, is handled in the next patch.
> 
> [...]

Here is the summary with links:
  - [net,1/2] fjes: unregister the netdev before destroying the workqueues
    https://git.kernel.org/netdev/net-next/c/f2473fbfc3fd
  - [net,2/2] fjes: cancel force_close_task in fjes_remove()
    https://git.kernel.org/netdev/net-next/c/c206fc0705d1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


