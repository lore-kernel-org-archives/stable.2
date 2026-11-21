Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795289407;
	b=EPcXKMEBU0Q9+oyzNqhsyk5tesGx5unBeFsT0zkhbF8RZ4VVnyD++5mx6Wj32gQGCsXD
	 8CnaaUTYHnQnAHTGgWwQArGbZrVTa+UhUMFGK7mIC2/57RP5moFtI9RmB6kEWsULEoxcj
	 d/ObRmgjURfF3lEs2kHaDQeNOdSZmhQQgzliSxSPll8ZJyfAWKZ6EfbqSYGgKkDTi7duy
	 dV4mUjs53VgLbmeAyONa6j+7FSs58m9ocgbYbZRCrXaYjyb+ktoB1d/5yk50XHFUk8jHg
	 ON1E0P8HV1eVLt+JIW5rKEGQkJ76SQAwDVUYUMY409xKy2+bzXoqCNNTo567wi2EDOg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795289407;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=ya+NhNd1CcqJp1D4xAF8pRIQ5WA9rekIkUHynOGIv0g=;
	b=lhRDfZg947Y3+ffofexDBf63EApC9t8+8xEDX1mizE5C1O3vqj6Tic+1dRYDBNoiJLdo
	 IkgPHarRKIWUgPHBuQyYI5+t+/PmyUsAeYEgh14KIAm2HyYP99LWxYWCDcrtvQdiyl3y/
	 ReEv0Sc/rtFZPwAAKdraFvWPq1N3gLq14zz2msL8fCZOA4g7V+sAe4P5NhGVcE6IrUVxb
	 FR0evhgbDttKpvl4ebbszdZ2f0o6rVrx2/Mj35ZbfAfCp5k8oHbHm/fyC+IoSWZO2rhUd
	 hk4RXYVphkfXrhko5yr6S3dqizQgd0sED0lkySzqkIptAOMS8DKXqIgkTwlO8yFP5Ew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F3aMYHsr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87516606A32A;
	Sat, 21 Nov 2026 19:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F3aMYHsr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44BA41F000CF;
	Sat, 21 Nov 2026 19:30:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795289407;
	bh=ya+NhNd1CcqJp1D4xAF8pRIQ5WA9rekIkUHynOGIv0g=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=F3aMYHsrOXJM+6ivSrF8HPD5oerwkdCKrO8EKg8E87kGC0EC1An8FlQvm1WKPrudX
	 m0vArSt0kppfEv3xCApngi1AXZSFOWdnFyPCUhjcyQgcyHN0TfKMhkD0XZJaNwVAoD
	 FAnZUxMi4iHd0+kd7tYmxM++++xqTgYsbJq7m9XD+ZtNkVOMANaUwm5EImfE4ntrEX
	 JDVVsOjqsGirukhzvAh/Q5twCeYyfw+ANAec+IAIohbCtK2+jX/UEX/mzms+lDMoGt
	 MZfXzTA3q5iW0MHAx+euaVtbAcTTnHCaRWBFragqu8EUWwUPO9vfsvO2rxgohei4P/
	 YSLWp3r/Ob+nA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3A441391B06F;
	Sat, 21 Nov 2026 19:30:07 +0000 (UTC)
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
Subject: Re: [PATCH net 0/2] net: fix a pidfd leak with a short SO_PEERPIDFD
 optlen
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179528940603.1145636.16413757332346392828.git-patchwork-notify@kernel.org>
Date: Sat, 21 Nov 2026 19:30:06 +0000
References: 
 <20261117-work-net-peerpidfd_short_optlen-v1-0-a93f56288501@kernel.org>
In-Reply-To: 
 <20261117-work-net-peerpidfd_short_optlen-v1-0-a93f56288501@kernel.org>
To: Christian Brauner <brauner@kernel.org>
Cc: davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, kuniyu@google.com,
 alexander@mihalicyn.com, netdev@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, stable@vger.kernel.org, sashiko-bot@kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 17 Nov 2026 16:25:29 +0100 you wrote:
> SO_PEERPIDFD caps optlen at sizeof(int) but never rejects a shorter one.
> With an optlen of 0 to 3 getsockopt() still installs a pidfd and copies
> only part of the fd number to userspace, or none of it. The caller can't
> close an fd it doesn't know about, so the pidfd sticks around until the
> process exits.
> 
> That's been the case since SO_PEERPIDFD went in for v6.5. When I moved
> the code into a helper for SO_PEERPIDFD_THREAD in v7.4-rc1 I kept the
> bug, so the new option has it too.
> 
> [...]

Here is the summary with links:
  - [net,1/2] net: don't leak pidfds through a short SO_PEERPIDFD optlen
    https://git.kernel.org/netdev/net/c/fa827805a629
  - [net,2/2] selftests/net: check that a short SO_PEERPIDFD optlen fails
    https://git.kernel.org/netdev/net/c/c9b3eb7bfd7f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


