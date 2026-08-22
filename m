Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E82D2D23BC;
	Sat, 22 Aug 2026 20:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787428875; cv=none; b=mu/mr98Aj/JUG0bv8TsfQMLRwupDTIykaWtWL1/TM4kJ3yhug7k3MnO6+yR1fSzRvv4d+k41f2/VPFzmRQ6SJiG7o445AyDFf7aiwjzmOPbKRjYLd9l4+iSNT7joZXepw78kFnylyMR5rnawze4GtxEx10xeE+WiLnEzSz5XTfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787428875; c=relaxed/simple;
	bh=DWm37jv3KvQ5wyZ/OkmjUUIEfL6snBiU29SWVimdB+A=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=VK2TJJM+p8tH0xYsAzWTUIDkFXGsrf3/x8aT/B4duAwCs6Wi7YFvnFnDXV9rE2fiwMGOX9JLlRo8IVOWPq8Me90LlhUA0AH3JEZcQZzdD6rgL7FeTZnAS512gp6EEpk7W/rlkzE9+vz6u95dk/hZ9G6xu5oJX8zPGeYF680dArc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SkpqrcOt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SkpqrcOt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAE3F1F000E9;
	Sat, 22 Aug 2026 20:01:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787428872;
	bh=rG7xpvk/jI2Cf5bJb178qqtyZfjMEvbfQkdsZyaDBHQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=SkpqrcOtFGGlPgvuriGNJUclqSNUop5rJRa0UxQ5cDp/CMj36GZqoxckjNCQJmzTU
	 HoCOL6XiRLA9ugOy//F77ETKiMNUU/nSWSXbmtMhSwkOkGORZ6QN4tmAnXWHtERZRK
	 NX/UAJa/YQlsBxAtRCjAcEc02GVAC+5vPYcwcnQPv/EG0V+d0PYTM/M4JHtWzDW4gW
	 ewgzz9Ua2lQXHe+kFWxk4/+wAj4lLKBqIfxnThvH6m+PgGhkFVMhcAm+FTm2X2TJ+E
	 3ldI/8sn/Ti+cKv8AVfFyL38bTFJeiFxhzE2UDz8SlDC4gDLI8yQOFyknK+DW+/WGJ
	 tHufXzJaucHew==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0A40380CEF9;
	Sat, 22 Aug 2026 20:00:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 1/9] batman-adv: fix stale receive device on merged
 fragments
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178742882155.1812309.6129874703667132966.git-patchwork-notify@kernel.org>
Date: Sat, 22 Aug 2026 20:00:21 +0000
References: <20260821094813.201800-2-sw@simonwunderlich.de>
In-Reply-To: <20260821094813.201800-2-sw@simonwunderlich.de>
To: Simon Wunderlich <sw@simonwunderlich.de>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 b.a.t.m.a.n@lists.open-mesh.org, zhilinz@nebusec.ai, stable@vger.kernel.org,
 vega@nebusec.ai, sven@narfation.org

Hello:

This series was applied to netdev/net.git (main)
by Sven Eckelmann <sven@narfation.org>:

On Fri, 21 Aug 2026 11:48:05 +0200 you wrote:
> From: Zhiling Zou <zhilinz@nebusec.ai>
> 
> Fragment reassembly reuses the skb from the highest-numbered buffered
> fragment as the merged packet. When that fragment was received on a hard
> interface which is deleted before the chain completes, the merged skb can
> re-enter the receive path with a stale skb->dev and skb_iif.
> 
> [...]

Here is the summary with links:
  - [net,1/9] batman-adv: fix stale receive device on merged fragments
    https://git.kernel.org/netdev/net/c/ad46c907d7d9
  - [net,2/9] batman-adv: bla: avoid CRC corruption due to parallel claim add
    https://git.kernel.org/netdev/net/c/08645ab95768
  - [net,3/9] batman-adv: bla: prevent CRC corruptions after claim flush
    https://git.kernel.org/netdev/net/c/89f3502ff687
  - [net,4/9] batman-adv: dat: avoid unaligned fault in IP extraction
    https://git.kernel.org/netdev/net/c/0121afa52cdb
  - [net,5/9] batman-adv: dat: atomically update mac addresses
    https://git.kernel.org/netdev/net/c/e6de568d3eda
  - [net,6/9] batman-adv: fix TX priority extraction for BATADV_FORW_MCAST
    https://git.kernel.org/netdev/net/c/7aedb59b8099
  - [net,7/9] batman-adv: mcast: ensure unshared skb for multicast packets
    https://git.kernel.org/netdev/net/c/82bf207f48eb
  - [net,8/9] batman-adv: mcast: linearize skbuff for packet generation
    https://git.kernel.org/netdev/net/c/6a30a59e2660
  - [net,9/9] batman-adv: bla: fix freeing of claims on meshif deletion
    https://git.kernel.org/netdev/net/c/8d128c932bce

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


