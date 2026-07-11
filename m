Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBE352EEE77;
	Sat, 11 Jul 2026 11:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783767648; cv=none; b=XT5ERToIXYDGpskD0tucrWBg+Nrgptf7LkfvT/sbj96TuguD9NqpsFc/bSr/hVXEpq+42xn1PbDGCHrLrLDyxhwYwqcbEammGLC1DEZRGYGUd26Up1X0ZY6mtMWQsIhzHCnJkWDEblKSk2c27JHsoYzLogBDxtuNf0mAracKRKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783767648; c=relaxed/simple;
	bh=/Hdlq07QT6cec9QK0gjFqWA0md0uFPXBnWdFvSu/0Uo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=dUexbN0cKwoToNnHUBhp+X031jqKBEyOTDMRtRODSIAOYFqwk6ORlM0LJ999s08M1frKZsJIM1VYFrj0TsfoB+5V1vq9EMikj74kuN1ogVMJgK0gAam5AA3LQR0wfXoH2BHqf7oqXs/7LttFiWAmkE9qNdmlEVsH+/lJ0hPNMVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FYxPvA06; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FYxPvA06"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 444B11F00A3A;
	Sat, 11 Jul 2026 11:00:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783767645;
	bh=RMERE8igQkTzeoIxLSMUT+IGfvTmPfefBtS6+cyZ/zQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=FYxPvA067/yiHekLwDijewrrNP91l+omzrrkWrJu19x63lDZ9o03EQb/HxM3mI7cD
	 dMv64465VSvR4xyO7/kDECufj9rYhNJg67PTmSC+wW/4PrHTP73Y+54GwdDDzsIRZ0
	 hFM58dRqj+k0DlLwLguhgUzPbDNMuaiqEijVc3r00HbAfUwUiVKdpFqJtAap/51I7D
	 xVrG8aMn6EmG1z39T9Y/O/5rc4C4TJcJupZOtaJDvsg2F9R2pZem+X0Z/1x2Q/dUTN
	 T3hDjRDPkDfxdfbv9tSkmQ/GoSzXCKmi/dgRjeVu518FwWuwgZYcd0zTjgUJezUETp
	 +P5AcsV2y71uA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93CF339244F2;
	Sat, 11 Jul 2026 11:00:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] macsec: fix promiscuity refcount leak in
 macsec_dev_open()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178376762213.1079343.12809475600428290154.git-patchwork-notify@kernel.org>
Date: Sat, 11 Jul 2026 11:00:22 +0000
References: <20260705113629.187490-1-jamestiotio@gmail.com>
In-Reply-To: <20260705113629.187490-1-jamestiotio@gmail.com>
To: James Raphael Tiovalen <jamestiotio@gmail.com>
Cc: sd@queasysnail.net, netdev@vger.kernel.org, stable@vger.kernel.org,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, atenart@kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Sun,  5 Jul 2026 19:36:29 +0800 you wrote:
> When a MACsec interface with IFF_PROMISC set is brought up on top of a
> device that has hardware offload enabled, macsec_dev_open() first calls
> dev_set_promiscuity(real_dev, 1) and then propagates the open to the
> offload device. If that propagation fails, the error path jumps to the
> clear_allmulti label, which only reverts allmulti and the unicast
> address. The promiscuity taken on the lower device is never dropped, so
> real_dev is left permanently stuck in promiscuous mode. Its promiscuity
> count can no longer be balanced from software.
> 
> [...]

Here is the summary with links:
  - [net] macsec: fix promiscuity refcount leak in macsec_dev_open()
    https://git.kernel.org/netdev/net/c/7410d11460eb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


