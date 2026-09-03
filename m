Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F6B530C37C;
	Thu,  3 Sep 2026 01:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788399069; cv=none; b=pxSOx0q5SCHcGLc6zeXelP5jdZ7JKieKAvRG4eZ1GBc8Na4Uo+Ws0Buq9eag9SE3tcEGkdxHkIPfZHmEaez8C1yTaFxpICMWc+FenRoii3i0VlbLx/b6NTgkIZV4ng+xEwffqgn//5rvi35feF/tfb43Zhztp0J+iwdmazn/VfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788399069; c=relaxed/simple;
	bh=GMja80wdtiJ6nJNINbAJ88ByBH9/c+1qrcfM3V2csGg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=NyNhchXctNF/COrLbS2OedXVs1o+OH19wZrL3frAqQiwyrlE6ftzz2k9BmiZ+vONhKt6BMKTud4OSSxhHM7gCj4t/bpze9HXPh/C2Oszue316inwqJeH1KMBCIHKZS5JH8AwnY1ZMk6HDWmcYtWoHnh0XhpuT4BrptcIFStdF08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NE8TFGqQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NE8TFGqQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9C6B1F000E9;
	Thu,  3 Sep 2026 01:31:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788399067;
	bh=/NARrNyXQsxhklNjvRPfDhFMY+69UP7HHt7ffYR4UK0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=NE8TFGqQdzWM+BkyYztg4ZWmuIyWTYYQO2CHAF4JyGmVnEEJ+E5LLAhbofDIHkSgR
	 6JjbD6dFVBFVW4TDDswKLpX7UOf2LKKQFwEgwUhfG+oUnmkhOLusZbR95pmawLVDU1
	 yEOnA746er09aEZtE7ieOcsVFCqNDKIngq4Nn6Ayic1PJimyoLg9z++uFPZVjiqppc
	 13hPwvfutcXdxu4zYgpcKYVPZsq265zwn0HVw338fokUfGyVrkAY6Yhy/XzB+WOx+v
	 VGng0M6Rae17I2tN6/IFS0RnOEfSh1p2TSkr0e/E7UBvtICsF1j/Ry4pRUXlGJ2J8k
	 j6BTnYi5WDwqQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADBBD3927054;
	Thu,  3 Sep 2026 01:30:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3] net: bridge: mcast: don't truncate the port group
 walk
 on teardown
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178839900939.3032478.17694905475079268845.git-patchwork-notify@kernel.org>
Date: Thu, 03 Sep 2026 01:30:09 +0000
References: <20260831111330.199543-1-junvyyang@tencent.com>
In-Reply-To: <20260831111330.199543-1-junvyyang@tencent.com>
To: Fourie Zhang <littleddfu@gmail.com>
Cc: razor@blackwall.org, idosch@nvidia.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 stable@vger.kernel.org, corvus@tencent.com, bridge@lists.linux.dev,
 netdev@vger.kernel.org, junvyyang@tencent.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 31 Aug 2026 19:13:04 +0800 you wrote:
> __br_multicast_disable_port_ctx() and br_multicast_del_port() walk
> port->mglist with hlist_for_each_entry_safe(). However,
> br_multicast_find_del_pg() can also delete other entries from the same
> list through br_multicast_fwd_src_remove() or __fwd_del_star_excl().
> 
> If such an entry is the iterator's saved next node, hlist_del_init()
> clears its ->next and terminates the walk early. The reproducer triggers
> this in both teardown walks, leaving port groups in the bridge mdb with
> a dangling ->key.port after del_nbp() frees the port:
> 
> [...]

Here is the summary with links:
  - [net,v3] net: bridge: mcast: don't truncate the port group walk on teardown
    https://git.kernel.org/netdev/net/c/5a3f7a683aee

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


