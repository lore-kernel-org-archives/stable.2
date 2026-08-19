Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15CFB26A1AC;
	Wed, 19 Aug 2026 07:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787123456; cv=none; b=A7jzPKFSewsSFsdOLedMteFORHAZxC+cjlqkiAls7+OVGpBxG1bq65PbHqWEV5OwackhCJViHc9DC+5seIlyFptP8VtWUjdhj+efkeCZaUKpigTGS3Fwv+LzUO8naGUPIEyY++2PlPEU/7qbMXhwnNPTe+BOJC3Z0KykGknQDkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787123456; c=relaxed/simple;
	bh=uAIWxdzO+BxsdUzewzx9rccJpwJcqH91RAiuVox4OcI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=BEsN7NUtbpCtOyNahBdKcS0AHmOaFbBGZd/4+7yf3u4vAQ8W/qNs4+vhA/v9/kifKYr+4LmzqLMjN7yRKUfK6a7ByPRPkNs1o20ARJ4p+IPPG9lWP3rHBR9YMzlI+5WXBXAgrUDsaGROlI48Ly0/oGy70tscYTmIV/UxfM5DaSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kcvOBiWp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kcvOBiWp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA4CF1F00A3A;
	Wed, 19 Aug 2026 07:10:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787123454;
	bh=9CtrAGZTsWA5o3/jbm79ZgTzoUlujXH4Q9TzoibH1Vo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=kcvOBiWpgR9K4bybrVOnFN8JQpVXZ65b/Vlt8RBANZBJGnsJnWRNhSWThgv+qZ/YM
	 itkAD45V4sDAgtmvDQMgu3f+S3y4q1RuGvTW8dJzZVdB2OhoD3rpnBBZgXpvUHNbqK
	 Es4Y5iLo5E1hy2pmwnztPJCXccNckJKfULkyiqGKcelCmGObsyF7ClJKKkpl8tl6kz
	 1h9j9KJMB+NNxQGupGOKzrCLuc/T7YJhE+kSOEJWpyWpdagf+G0HRL0cV7BV8bxlsN
	 vWNJkbUSR3jouJsS/GUVoArRP/RfuntUyJVeKwRfMEzIikAPXVLZ7vd5zYUD03+geT
	 +Xyzv3Oh2Joxw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 198993927201;
	Wed, 19 Aug 2026 07:10:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: ipa: fix stalled modem TX queue after runtime
 resume
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178712340564.2894881.925016818321422836.git-patchwork-notify@kernel.org>
Date: Wed, 19 Aug 2026 07:10:05 +0000
References: <20260815040302.653650-1-jorijnvdgraaf@catcrafts.net>
In-Reply-To: <20260815040302.653650-1-jorijnvdgraaf@catcrafts.net>
To: Jorijn van der Graaf <jorijnvdgraaf@catcrafts.net>
Cc: elder@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 luca.weiss@fairphone.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Sat, 15 Aug 2026 06:03:02 +0200 you wrote:
> ipa_start_xmit() unconditionally stops the TX queue before calling
> pm_runtime_get(), relying on the wake scheduled by runtime resume
> (ipa_modem_wake_queue_work()) to restart it once power is ACTIVE.
> But that work is queued from within the runtime resume callback,
> before the device's power state reaches RPM_ACTIVE, so it can run
> while the device is still RPM_RESUMING.  The wake is then consumed
> too early: the transmit it restarts stops the queue again,
> pm_runtime_get() returns -EINPROGRESS without arranging any future
> wake (deferred_resume exists only for RPM_SUSPENDING), and after the
> resume completes nothing is left to wake the queue.  Transmit stalls
> permanently: packets pile up in the qdisc behind the stopped queue,
> the device runtime-suspends, and since the netdev registers no
> ndo_tx_timeout the watchdog never fires.  Observed on SM7635
> (Fairphone 6) as the cellular data path going permanently deaf
> within hours, RX included, since nothing resumes the suspended
> endpoints.
> 
> [...]

Here is the summary with links:
  - [net] net: ipa: fix stalled modem TX queue after runtime resume
    https://git.kernel.org/netdev/net/c/c8c69c9a6d81

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


