Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7847543D508;
	Wed, 22 Jul 2026 22:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784758239; cv=none; b=mAyO83omT3Pya0/Pmewj/Cvo4nleKZ7dPa/uFdeIUy88kFohvembsNJ7GZeU7TO1XKUc8JhqEhIcJo0sQkh4GlLOZT/2L6RmbFXjXwbuHjb35GtfYH0ziZwQA0Sd2wpJNRQpbeMzFpIFTABHs7uaDh39bWDvlCGF52EaQeaTwZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784758239; c=relaxed/simple;
	bh=iYTfMInGuH+Yft5xotSdidr9AF5WeNNmNqcGoS3A8CA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ie4dw7LUzf9apqE7tbzEo6SReGWcimO7rCFej8bw/hEdLkjTvwsy1TEqPvLWa3FEfekoNHoILfnvI5Bme5kIh4b/moN6DPx8iD0FQMlrzO3OLbeSLHRY2ol796AqrSjhDrOQYBzqO4vOentxHKpl26DKU8DOEhvbqapGPkB5dcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ac4Fd8UL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ac4Fd8UL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C2061F000E9;
	Wed, 22 Jul 2026 22:10:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784758238;
	bh=8uFCIXp9qKDSOWVwNyhuki8vv8ZBb5RFt1n9Wvkn0IQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Ac4Fd8ULs88/zeRUgtknN37UYDHHMGeVYZlB8ghJeOFlACXhUmxU9LIYLNzm+gLqZ
	 /SuZRcMEjcfOVTpXVDfrvCY1kSFw7WqLhlyjZfSlYRDOD+b1JKRNQbB4S0/zQk1ytp
	 4nDMcaB38tboSYE+ApMtWliiXzs6R/zcmOx8Wp4iS7UlC3FLztiEjWNgobcHahD0Wf
	 EQCTg0K7eqmWenCFzriNcLcMG8khehQJYT2IoulKbwWO54S1BaTG6TNoLg/lkEd7mz
	 CkpfSFVYwHwMbcyGy5yaKhynm/GBP6LJ1o1zhOKw0ptI8+Bl1cwm9NnpnpqN8NTWeW
	 dQfWzdrnNXGHQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F2215380CED7;
	Wed, 22 Jul 2026 22:10:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net/sched: serialize qdisc_rtab_list against
 concurrent get/put
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178475820665.2043959.17201731412611698161.git-patchwork-notify@kernel.org>
Date: Wed, 22 Jul 2026 22:10:06 +0000
References: <20260715114114.446841-1-qwe.aldo@gmail.com>
In-Reply-To: <20260715114114.446841-1-qwe.aldo@gmail.com>
To: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
Cc: netdev@vger.kernel.org, jhs@mojatatu.com, jiri@resnulli.us,
 edumazet@google.com, davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, stable@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 15 Jul 2026 08:41:14 -0300 you wrote:
> qdisc_get_rtab() and qdisc_put_rtab() mutate the process-global singly
> linked list qdisc_rtab_list and a plain non-atomic 'int refcnt' with no
> lock. This was only safe because every caller historically held the RTNL
> mutex, which serialized all rate-table lookups, inserts and frees.
> 
> That invariant no longer holds. cls_flower sets
> TCF_PROTO_OPS_DOIT_UNLOCKED, so tc_new_tfilter() keeps rtnl_held == false
> for it and sets TCA_ACT_FLAGS_NO_RTNL. That flag propagates through
> tcf_exts_validate_ex() -> tcf_action_init() -> tcf_action_init_1() ->
> tcf_police_init(), which calls qdisc_get_rtab()/qdisc_put_rtab() with the
> RTNL mutex NOT held. Two RTM_NEWTFILTER requests on different CPUs, each
> adding a flower filter with a police action carrying the same rate, then
> race on qdisc_rtab_list and on the non-atomic refcnt, leading to a
> use-after-free / double-free of the kmalloc-2k struct qdisc_rate_table.
> qdisc_rtab_list is a single global (not per-netns), so the corrupted
> object is shared system-wide.
> 
> [...]

Here is the summary with links:
  - [net,v2] net/sched: serialize qdisc_rtab_list against concurrent get/put
    https://git.kernel.org/netdev/net/c/f43ee0c0730d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


