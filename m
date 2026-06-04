Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E9C847B431;
	Thu,  4 Jun 2026 16:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780588832; cv=none; b=i2r3TeIBYD/PvF514t97IIzAEjxQ5ijaKoWsdHUtGJlO9m9h/lmzRC+eNPYkM+3iFJFOt5heZt3LVzUMHpZS5i8Q4g+Qwn8N2m7WMKe81v+j8FVBio+wRPA3Erm+JWl1CLk3xZwlyFIQr35feoMZhFgBxmgC1qn1dZTg5Mb3Ups=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780588832; c=relaxed/simple;
	bh=/DuU/H+ePsONsMhYu4qmqPYLCf70f1/9AKu9wRqIunc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=gPopnY+3BgsTwwIJ7XjfQIw9sX1kMpvpLd0c9aNeAqOSKBavIR+/vbWwNkreB40tKWnwt5WGJSS+3+d1lttEZlJ0xos4tIjzvtFzRM/JMo66Ew10S9jttDpdIkdOnHhjT6fAL4NqLWQhJOWWQJSaJKOSs7Uci6gy/6yab7gz9ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qu/XSKzs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qu/XSKzs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 394701F00893;
	Thu,  4 Jun 2026 16:00:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780588831;
	bh=EJEf64ZBQsNzoWifPhtZA9P/vPax0Lu5T3OxobFaaJg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Qu/XSKzs7mlytpjAQqsaZY+AWM5fEaBYftI+qI0GjzoBURUaaikPmF3NmwzcBccn/
	 BY21p4Ec78JFombHsCEdb/97ipy+RUUHykYipFJPMBdlDjQ+AdmYU9ym8EwJnEAg+j
	 ecuAu+XMGZhG0Gjg+YjZCOt1PRflY4sj+rW2MvQr+DcO7qwFPfsfJj8nVwBmkVJEXa
	 I7wB2q7mhBZzyuQwBJMP4lpJHhVJRjbtW5u4sEdeHum3oI4Q3ffuhAtaBHU1XdyD+W
	 PoX3Boq80v3inIOHZYtotFDRvHHTHzhjTR136mnwaScK09Q9CJKB/5mcT2HPe5+g6X
	 IlP3PxhQaUjSQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 5695039309B7;
	Thu,  4 Jun 2026 16:00:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] rtase: Avoid sleeping in get_stats64()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178058883188.2493857.544475254028266565.git-patchwork-notify@kernel.org>
Date: Thu, 04 Jun 2026 16:00:31 +0000
References: <20260603061816.31356-1-justinlai0215@realtek.com>
In-Reply-To: <20260603061816.31356-1-justinlai0215@realtek.com>
To: Justin Lai <justinlai0215@realtek.com>
Cc: kuba@kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, stable@vger.kernel.org, horms@kernel.org,
 aleksander.lobakin@intel.com, pkshih@realtek.com, larry.chiu@realtek.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 3 Jun 2026 14:18:16 +0800 you wrote:
> The .ndo_get_stats64 callback must not sleep because it can be
> called when reading /proc/net/dev.
> 
> rtase_get_stats64() calls rtase_dump_tally_counter(), which polls
> the tally counter dump bit with read_poll_timeout(). This may
> sleep while waiting for the hardware counter dump to complete.
> 
> [...]

Here is the summary with links:
  - [net,v2] rtase: Avoid sleeping in get_stats64()
    https://git.kernel.org/netdev/net/c/9fc237f8d49f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


