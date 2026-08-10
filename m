Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 811913B6BFD;
	Mon, 10 Aug 2026 23:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786405252; cv=none; b=oPe8rirwLQZKn/iRDEoAzr1KQPTXiyK5Qpz/J6Zc2v8ShNCQAk0Nkzmb/5EZsxs6Ci6rQFulu0WsShfnpD/qjPgNknxW4X6xh7MMOdVLDdUyuSd4EvY6bFKaTnA9oo9KfdFlF2ZVB7vrBgPYRFaKnAZAgondudPkapPlFWjOHkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786405252; c=relaxed/simple;
	bh=jkcMwrKVVK8447gJahzt3XxXmie987PHKSdD5enZTvQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=PytztrxyZjEoaJbvmpR8T97XvVAHYF5E5OIQYPSF82krsfmpqQqBtWSafSb5x4Uhza15jLpxBnkaCl5AGHC0Ufl+roQH++rV18yz+4WLlWxRYzOVCB14P48k9VllOGxy4LfLaRxFlKbltoXkCzUwncCifj5f3nTtNSwi8EcuC9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iVysRlxt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iVysRlxt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AC3A1F000E9;
	Mon, 10 Aug 2026 23:40:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786405251;
	bh=e94jut7BDx2TeLjil2fsKpSXP24Q6d6ykiaNSn52s6A=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=iVysRlxt8aH2RKYYjf7M8oQdMjvsGOqxaL0bmNDRnWFBgbNzobOvA+YaxGC8V/40d
	 jjxfzjR5FqNFzuCbVU7FITVbOpaHft48zARG9j6MeFlv0ShP5kOkckqe+PUFsXYxsr
	 RHgS2LsUBW324Ooq82AVNujtW7MIEQrhCtgo2VlrsTG8gh1qhL/D1Jvd36ZZu+NYdC
	 3+fhi3LE6biDSyaqldNjc6ULBs3t0yaK/zHgLWR6cNEjAzvFX3VZxL2IPqts+9zKSM
	 43c+c562+6izbC3ZczmKBF+cx5PIoZpc/BfXCMgON/xkS9S01jBYF/+tRp5z8XssgD
	 1KHCnc2e+vbCA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0988392626C;
	Mon, 10 Aug 2026 23:40:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2 1/2] net/sched: act_ct: fix sk_buff leak when the
 header checks reject a packet
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178640520739.254991.6676555820239919462.git-patchwork-notify@kernel.org>
Date: Mon, 10 Aug 2026 23:40:07 +0000
References: <20260806101235.809370-1-hj351016@gmail.com>
In-Reply-To: <20260806101235.809370-1-hj351016@gmail.com>
To: Hyunjung Ko <hj351016@gmail.com>
Cc: jhs@mojatatu.com, jiri@resnulli.us, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 shuah@kernel.org, taoliu828@163.com, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  6 Aug 2026 19:12:34 +0900 you wrote:
> tcf_ct_handle_fragments() runs its header sanity checks before handing
> anything to the defragmentation engine:
> 
> 	if (family == NFPROTO_IPV4)
> 		err = tcf_ct_ipv4_is_fragment(skb, &frag);
> 	else
> 		err = tcf_ct_ipv6_is_fragment(skb, &frag);
> 	if (err || !frag)
> 		return err;
> 
> [...]

Here is the summary with links:
  - [net,v2,1/2] net/sched: act_ct: fix sk_buff leak when the header checks reject a packet
    https://git.kernel.org/netdev/net/c/8a7ed561671a
  - [net,v2,2/2] selftests: tc-testing: add act_ct test for malformed header handling
    https://git.kernel.org/netdev/net/c/f1b3416ceaf7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


