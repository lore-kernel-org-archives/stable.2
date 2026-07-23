Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8935448D1D;
	Thu, 23 Jul 2026 11:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784804448; cv=none; b=kvdi/jN/DpQe7QNnFUC+sfC8PQ3SHL6bxwdAd1jmoMLZwA95ioM3hQMuQc+jwTlxjLsJOxr9Q+qPXt7Ag5LdYq708VOscjKeKYDageLVvUnEwj4d2ak9pouSenOy3oCPZ1BFlxBsTBQ04O1MqUHS9J9/pRjFjuY5SX4vEZdTVvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784804448; c=relaxed/simple;
	bh=AJYbyxGEU23cWrIj0Fus7zk9LeS+LflcAxSfPiPs/oA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=tLN7Awl5VieuGpZS4xmDK52tYA7dLHU7Nn7Oe3Nn2jj7Yj5I4+X3+22XcDzu3LSz2ha+uam/GPY1kvailwr6kTMtX6g5XSbxbpgx/kGLFnL9y0Yy2qRnA9xipCjJmFccM2dUQQBGmv90wEKL8zEIlChCFHvXq4VLr6juj40Pifw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ElP9k4cJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ElP9k4cJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A77D71F00A3A;
	Thu, 23 Jul 2026 11:00:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784804446;
	bh=d63LXpVb2/FLNxAsKV/rh29mEJJJntNOnSkLXm8IGG4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=ElP9k4cJYeIccgu/PEOZQnJK9suVC/0Ig3ZMRBqhaIY76MNkc2TebJNrXdnn5EdJx
	 S/m8PAJt9sN78XrAhfNprLmePlF4Ufu7czrToleUIR7qseLiga/5b5+Q5AcZPPAq1X
	 8F1WRnDVrRok5s6NN4tgl3jcnp1CzO0Qr23375Z9Vmlb26iigRs+x0E347ZXwcIwNv
	 om6pZcJtOSeDx73+j5qdnzJbwOZVFobYTBSe4FHTUo+UNnyX6+AGQcrF19wqGuarZA
	 nuX26vBNKcAiW6InJP5Refz6FtZ7LjdCknpHA2m0qfUxq8iPuzV9X7bkAYCSlFwit3
	 hw5aOZryMz/WA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 19B5C380DBFA;
	Thu, 23 Jul 2026 11:00:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3] tipc: clear sock->sk on the failed-insert path in
 tipc_sk_create()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178480441464.2227840.1009712427461521847.git-patchwork-notify@kernel.org>
Date: Thu, 23 Jul 2026 11:00:14 +0000
References: <20260714131939.1255974-1-4ncienth@gmail.com>
In-Reply-To: <20260714131939.1255974-1-4ncienth@gmail.com>
To: Daehyeon Ko <4ncienth@gmail.com>
Cc: netdev@vger.kernel.org, jmaloy@redhat.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 tung.quang.nguyen@est.tech, leitao@debian.org,
 tipc-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 14 Jul 2026 22:19:39 +0900 you wrote:
> When tipc_sk_create() fails to insert the new socket (tipc_sk_insert()
> returns non-zero), its error path frees the sk with sk_free() but leaves
> sock->sk pointing at the freed object:
> 
> 	if (tipc_sk_insert(tsk)) {
> 		sk_free(sk);
> 		pr_warn("Socket create failed; port number exhausted\n");
> 		return -EINVAL;
> 	}
> 
> [...]

Here is the summary with links:
  - [net,v3] tipc: clear sock->sk on the failed-insert path in tipc_sk_create()
    https://git.kernel.org/netdev/net/c/ba0533fc163f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


