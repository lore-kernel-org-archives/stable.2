Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795304663;
	b=D/GdYpAkxhPtEMyukeRj9FslQdvXxerowKdj/VtkYl5qWIoE680kwFYufMFlLe8by1XI
	 CWvraoOSSJPc06QUN0eIcggQOULSeh25TBLUA6+Y0wXUVHaoUWvPnEezWYhVrEoHf3Imt
	 TFpTa1pov+d+JxKKJXgMpfu2rqdwAhdOg9Kqyej9Ga6qz075lbfD9dFrtImZoc419itmh
	 93aWhp8NCUhgLnGci12oY1itA9GSpzJvu7GlzOqZvkpNr9LL/k1HrKyL7T8rUiaAsL4eN
	 NLEYhOgjE+3wGr/S8BKzyEpWy7MNawBbahGaT90tURTRDxd9qY5fJPkOZo4dnn6xYPQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795304663;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=bJv2CRi9uextI7SDskU+t+k/eig77lL331lPw8tX8+Y=;
	b=1I3KWwQWdCh7ROlJto9K8dAM/vlPDu81zRoQPtCMPjpdD2NTPqT57ci8vxn3LPKEa9iL
	 oZLNSAdlSF597cXpSV07IM+IDpMbWf2L5g8OtwdD+vY/6SWsqwfKmmGgis1Cm81DOrbqA
	 flKkq9Hhd89sPWihm0vWrrLGWLavUz+IijXZE5yjrhzTong1HtFXD4lvYAmzWPXmAXB/Q
	 y6wGJLj87zH40cTPRqphHZez6vPXqvWO/DNHpfzq5Xk9cV3wkdmpZ8a8FiBU0ZDV/Lkix
	 2G9o8kTxdNa9RBEZL0ac99P9YZSFcouftaN9QALrzl4ylMdwI9ADzrLDc/D7+hSFrPw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Nbv8iWP4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C8E4606A337;
	Sat, 21 Nov 2026 23:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Nbv8iWP4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 084531F000C0;
	Sat, 21 Nov 2026 23:44:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795304663;
	bh=bJv2CRi9uextI7SDskU+t+k/eig77lL331lPw8tX8+Y=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Nbv8iWP4eDIu7oYO4iAVCFUX/wOcOenIU8cUMWaTZezQZRRNPcPIirGaJpfk6OPjy
	 aXhzmCYIb/kMAmBKmYcD/pOqlMBSy08l73X80CpSw37mOVbsHuYhZOSoKq/sOiqhec
	 BHBYH7ahS5CwjhYrYr//gdhwPXbzlnsAoOPuYdAf04fDmYfmDsZG111IiFoK7Fn0Y5
	 y9F5ocZ5JHYkzjf2o7sqXGJiicrr6r+DkEW4nv8QA3HvSjyS/xsQVfsuS+V/vO4Cb7
	 8Jrmt0dp8gVz7QVpl+MF9bPFj9oHZ6Muo9pcJDFH2/ulB0+o7Gw9q8PZ0NM6Ol2320
	 KEwOKiE2HTJKw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F15AF391B08F;
	Sat, 21 Nov 2026 23:44:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: initialize sk_peer_lock in cloned sockets
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179530466152.1212208.3098530208274110712.git-patchwork-notify@kernel.org>
Date: Sat, 21 Nov 2026 23:44:21 +0000
References: <20261118101752.1989502-1-bsdhenrymartin@gmail.com>
In-Reply-To: <20261118101752.1989502-1-bsdhenrymartin@gmail.com>
To: Henry Martin <bsdhenrymartin@gmail.com>
Cc: edumazet@kernel.org, kuniyu@google.com, pabeni@redhat.com,
 willemb@google.com, davem@davemloft.net, kuba@kernel.org, horms@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 18 Nov 2026 18:17:52 +0800 you wrote:
> sock_copy() clones a struct sock with two memcpys that both include
> sk_peer_lock.  sk_clone() re-initializes sk_lock, but nothing resets
> sk_peer_lock, so a clone created while the parent's sk_peer_lock is held
> inherits the lock in the locked state.
> 
> The first getsockopt(SO_PEERCRED) on such a child spins forever in
> queued_spin_lock_slowpath().  spin_lock() disables preemption, so the
> task never schedules and its CPU stops reporting quiescent states; RCU
> grace periods then stop and callers of synchronize_rcu(), such as
> expand_files() from accept(), hang.
> 
> [...]

Here is the summary with links:
  - [net] net: initialize sk_peer_lock in cloned sockets
    https://git.kernel.org/netdev/net/c/ff73a2bb558f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


