Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F667544D5B;
	Tue, 22 Sep 2026 14:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790085676; cv=none; b=O+RN8VT5MDcYTu9OuU+gj8TnYnUbXSR4hvhx6FxWJf+ZBxtuBxvr+vBc//607U1zYwb8CawYc0pQhB36DGjXT5YSBtzjLg2gr7pltDeezl02bo2QfTAVPjrERh8w1kKiwenl24vPGnuSAnNBqE6swpEH18faGTmXpPYu4s2sy7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790085676; c=relaxed/simple;
	bh=+xT3lhOevF9cEOl9WZISiKH7vf8j4vxQuX8dCDiLEVU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=lABwgc9RmoqriAy9SHV8ZjKa+90/895FetzxFGWDqxFmDmDY3dAm7beBTDGqw9lbzoCKrjcJNbJoCIfom8FFfHnZ7k5hLyy67N7wZb0QKJd0grarq+34WVp9KVFUGh0XYuYJ9wtKm1hjyOdHP61WUWtXB+q0ek4HWsINTqlD0BY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kts70Emy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kts70Emy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08F4A1F000FF;
	Tue, 22 Sep 2026 14:01:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790085674;
	bh=1Ess7UL1IoK9tUC3cvBKwGTxvOb5UlfUK/tcef+tFdk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=kts70EmyYpMUaKoBIgrTmmimVEk8VqBvrO8X9GJ/lGezN/wrsQNQSqo3focx4AsVE
	 7DA+RKgFjm9hbsabLj+bGUwWKhXOoD92YPGOORphEH1nLozttsWdTLzMIp37xbCl+D
	 k71QSnpYL3zD2guL5blAX8EUQ7o3vb1SGz4XrZgcZGaJanr1HcwSUuIrHV77KNaPZh
	 roYiQydJ0V/MLtYkE366the5xrt8ErLfP/o7IS7QKx/KqpxJk6SrOWhczEPsRb7SNC
	 XHsumt6AactL6cFTLn6Ibxzf5iwF91zbqOleESDILnCc/V/XehhMGBGkXD0iRN2oiR
	 7mat9+0owX3aA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 567C738119F8;
	Tue, 22 Sep 2026 14:00:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: usb: lan78xx: Fix URB reference leak in
 lan78xx_submit_deferred_urbs()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179008560489.4097520.9027717710600492085.git-patchwork-notify@kernel.org>
Date: Tue, 22 Sep 2026 14:00:04 +0000
References: <20260917115811.2150119-1-vulab@iscas.ac.cn>
In-Reply-To: <20260917115811.2150119-1-vulab@iscas.ac.cn>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: Rengarajan.S@microchip.com, Thangaraj.S@microchip.com,
 UNGLinuxDriver@microchip.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, john.efstathiades@pebblebay.com, kuba@kernel.org,
 linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
 netdev@vger.kernel.org, pabeni@redhat.com, stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu, 17 Sep 2026 11:58:11 +0000 you wrote:
> usb_get_from_anchor() hands over a reference to the URB, which the caller
> must release. lan78xx_submit_deferred_urbs() never does, so every deferred
> Tx URB keeps an extra reference: the counter grows on each suspend/resume
> cycle and the URBs are never freed when the buffers are released. Drop
> the reference after submitting, and on the path that drops the packet
> instead of submitting it.
> 
> [...]

Here is the summary with links:
  - net: usb: lan78xx: Fix URB reference leak in lan78xx_submit_deferred_urbs()
    https://git.kernel.org/netdev/net/c/17741334d00b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


