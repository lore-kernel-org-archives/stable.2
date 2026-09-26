Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A6A524CEEA;
	Sat, 26 Sep 2026 00:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790382678; cv=none; b=skiQ4CtCmAUZkRzeCJ6WlGg+Zfk05GmP03LFjpF2ED7ZOkhuOROG+tREu5HrCRhBRec9LraZKsyP6aX0Ukyjk+UjxnKSCPoh3xfoPu5GyBWRUlux+JeBlGfVNYnQc44HFSMOwA3WekH3Y8pNp2+pzGVxl6VXoj0SiJOFSMzFjt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790382678; c=relaxed/simple;
	bh=156tFXXAw6ggrz5IBIkSEQNT+4k4B6A5urBXht8wqac=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=j3pzLk/PW6cgKo+03BF/s+8w5N9y9o6BkyHWSq+awLekVTyca6l+x/CrWj93y9f4WWw8D3uLB5yGhoVyaCHR/RtOGqqBAjbiWEHkXFyUUE4GX6L6NNBg6ZeL5ZxTchd4A/e2ukpHMNjGR/JDraZ8qm2jx4hQku5yZdftL125oLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lQ5UH41F; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lQ5UH41F"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF40D1F000FF;
	Sat, 26 Sep 2026 00:31:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790382676;
	bh=gj0qhdtQeFx90b2Toe0xeaR8RJo0rl4N2NF5KYiq7JQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=lQ5UH41FlGTdmXUsF47rr42KJHXyrLwuYBVgqH5R5PQm1NrPUb5dvhi3iVHuIF8Bm
	 xlFBDfkORmxo5J7BfE2c8rFUNq7hmTuPuzjh5l7faZ2EyhLMh1TLK+WY9KAmYm3alZ
	 nfwWoS4eOyQWMPfBBMtLZCGkLzh9FnwHEd05hECVwGIdVSyCZKLSnHpetvZ0+nEyDh
	 tTIrhIyLZl75DVY1hdn5dJqvLNwmdr47KIgkal2lURvbrL27KxFiMIrMYQ0CwMO858
	 6DPBirqSzzNz3QO/eXjD2fwXViSeWELAPTeRax8q5TC1MlOcJzpzlgMOwkY0r65+WK
	 pmBEs0unw6QJw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93A633809A04;
	Sat, 26 Sep 2026 00:30:05 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net/sched: cls_api: reclaim an empty proto on the
 error
 path
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179038260440.3219877.10131915992681374207.git-patchwork-notify@kernel.org>
Date: Sat, 26 Sep 2026 00:30:04 +0000
References: <QDISC-JCOT.v1.20260910090924@mojatatu.com>
In-Reply-To: <QDISC-JCOT.v1.20260910090924@mojatatu.com>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: netdev@vger.kernel.org, jiri@resnulli.us, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 victor@mojatatu.com, stable@vger.kernel.org, sashiko-bot@kernel.org,
 hybris@mojatatu.ai

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 24 Sep 2026 04:32:49 -0400 you wrote:
> Two racing tc filter add requests on the same chain/prio of an
> unlocked classifier both run change() on the shared proto and both
> can fail: the winner's tcf_chain_tp_delete_empty() attempt gives up
> because the loser's handle is still in the idr, and the loser's
> error path drops only its own reference without a second reclamation
> attempt. The empty proto stays linked in the chain, holding the
> chain reference, a block reference and the classifier module
> reference until the chain or block is torn down.
> 
> [...]

Here is the summary with links:
  - [net] net/sched: cls_api: reclaim an empty proto on the error path
    https://git.kernel.org/netdev/net/c/0bb8eab29b55

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


