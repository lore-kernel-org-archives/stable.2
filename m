Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B8C033469C;
	Fri, 16 Oct 2026 01:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792112415; cv=none; b=ti5ax9f2Rq68MySXgo1DhJyZDt2pbEz7nsRoC1TuEXyHb8QE0OmKm08gIcnsl+GQIyOedj+Wa7/wQ6Z3OIWsrPtxatilbSu+hhVtegDJg4DY9sJ7Ytyu9Il5DzoQwPVV+wCWeHzH/juyTHQZ+RVNnBu0v2gQHgH+E7mku1fXEF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792112415; c=relaxed/simple;
	bh=0QYHgMFRn5QEijQE9Rx6nFc2G2E5b6zW3WYDmyWj1uI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=gZSh8JKYvLoMBblY1/x4yIQL2x47P8xv67XlZu7uOoO6zNRTwh93AP27OqErU/mu2xfFFLti6WRhdRH+3QGn8lKIn/9VLVkD44NvCWVPt0WVe6npAHH6VCGNY5OlqyF6RDF+7wA3QtXrMcOqcoR2UOOx6U/JxyfTMVPPjFnuoPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DmzD85yl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DmzD85yl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 816F21F000C5;
	Fri, 16 Oct 2026 01:00:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792112414;
	bh=SzkrVctPjDRMPtGKoq35IIuPHWQM5+XJxttWXHW0Xms=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=DmzD85ylww48ZluSYLBMb0UiN5mpJdsKaKIydq1TYF1W9euoMlzqJNQOjhqh32duJ
	 kulika61IU72pzxLYtn676CexMEMKejwjkPiv1P/dd/MyVHngrKivnOAaH8X8+bVSH
	 li+VYz7N20WV/+odpnVBZOHjS8xRRG7iohZ/BtqXWxjcOdunfpLcYwVl241vTMe3O6
	 +HzuKV0mi8jTP4kbXA3ScIHhbimoB3S6FRzNQDv2+4uqOirXe837ri1KtxtCOiArfk
	 vIT/QXA2DyNjcM+NhIm3EeoTjBqYLQMniD1OILl2Pxl2odl58EfJSWJ1csrAt3GkeZ
	 xJBNrANF0bKKA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 772683808209;
	Fri, 16 Oct 2026 01:00:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] macsec: prevent AES-GCM nonce reuse after packet
 number wrap
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179211241301.4182913.3552458253132943260.git-patchwork-notify@kernel.org>
Date: Fri, 16 Oct 2026 01:00:13 +0000
References: <20261008080625.360063-2-Jeremy.Jean@oss.cyber.gouv.fr>
In-Reply-To: <20261008080625.360063-2-Jeremy.Jean@oss.cyber.gouv.fr>
To: =?utf-8?b?SsOpcsOpbXkgSmVhbiA8SmVyZW15LkplYW5Ab3NzLmN5YmVyLmdvdXYuZnI+?=@aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org
Cc: sd@queasysnail.net, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  8 Oct 2026 08:06:26 +0000 you wrote:
> After allocating the last valid packet number, MACsec wraps next_pn to
> zero and deactivates the transmit SA. This happens for both 32- and
> 64-bit types of packet numbers (at values 0xffffffff and
> 0xffffffffffffffff, respectively).
> 
> TX packets that were still getting processed during deactivation keep
> being processed and then receive packet numbers. The first gets 0 and
> is correctly dropped, but next_pn is incremented to 1, which makes the
> next packet take number 1. It then does not get dropped and may induce
> a reuse of the AES-GCM nonce corresponding to value 1.
> 
> [...]

Here is the summary with links:
  - [net,v2] macsec: prevent AES-GCM nonce reuse after packet number wrap
    https://git.kernel.org/netdev/net-next/c/94d51c59f0a8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


