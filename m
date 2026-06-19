Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8AF831A7E2;
	Fri, 19 Jun 2026 01:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781832031; cv=none; b=YKhaA/QFt+dogJ+rxJHIWAbzahfqwfpAjB65s3ZfhXd6D/5+trXa6pTrEEAno54SCjjPz/CnludSiCEKW9nUQkFIx2xiqfggNu48yy5XD20ehUE6Khtt1qcUi1mUdBm+W1InrsVeUPcYw4j1/ls2KtunVp+XGJgzkNQ/HWDxYTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781832031; c=relaxed/simple;
	bh=TTJKMoYAuzoQ6ms+RJKrHG7+UltL4SCEIlIGwcXeQ2Q=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=GT6mrFRABbMzzeFNeGNH0XkRzKAzLgyTzva83dkdslFKPtr6BTc2cEA6virVQbqLxVEz3D+w1exMbu7RseEqf4+7vSRJ7hJfxHe13edfgU927vRCp0sag8KXh+McLgmUXkkSYryzxT7+1WxdduYpw9GDmRJQGmV+BK6VpjTy0wE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TZQHdmCF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TZQHdmCF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB3C41F000E9;
	Fri, 19 Jun 2026 01:20:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781832030;
	bh=U0LfVyHgXZFFi5lPDvfzmd2c1BqGyT+YI3QfoHzzyE8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=TZQHdmCFDGqFyuKnYKagiIuKdXQr1SrwRX9ngdSyFqp+7/A2ds4uvIQtnRCwt/Rou
	 TfsQTyOivts2WmeWtWSXvfVFGEF+0AOjmgwQl4QPL4NX72phXNYk8Z1wmX6gSd+cDo
	 cP78ZzvEWo21ZnLg2HSuRW2pRFSGdlK9cd2VfxfDPUUoUgGsqdVX3kbKk5BTlFOrG2
	 THPt5V+wDExOLdpVHDj7JlunMS9a/sMozOfLa+JxckI2++5jG3r/31qxFOAUin8nSr
	 oZXTatw938SNDJ1VEdMlbFL6Cnh4wI0qH69kdjAzsG2oZxAbl7ZvYQ0G21G1xvzCsy
	 o0Wh1ygkO0KfQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 569FC3A78A7C;
	Fri, 19 Jun 2026 01:20:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] gve: fix header buffer corruption with header-split
 and
 HW-GRO
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178183202388.3150917.7651474889065363625.git-patchwork-notify@kernel.org>
Date: Fri, 19 Jun 2026 01:20:23 +0000
References: <20260617013208.3781453-1-joshwash@google.com>
In-Reply-To: <20260617013208.3781453-1-joshwash@google.com>
To: Joshua Washington <joshwash@google.com>
Cc: netdev@vger.kernel.org, hramamurthy@google.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 willemb@google.com, thostet@google.com, ziweixiao@google.com,
 pkaligineedi@google.com, jeroendb@google.com, linux-kernel@vger.kernel.org,
 nktgrg@google.com, stable@vger.kernel.org, jordanrhee@google.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 16 Jun 2026 18:32:08 -0700 you wrote:
> From: Ankit Garg <nktgrg@google.com>
> 
> The DQO RX datapath programs a per-buffer-queue-descriptor
> header_buf_addr at post time and reads the split header back at
> completion time. Both the post and the read currently index the
> header buffer by queue position rather than by the buffer's identity:
> 
> [...]

Here is the summary with links:
  - [net] gve: fix header buffer corruption with header-split and HW-GRO
    https://git.kernel.org/netdev/net/c/d676c9a73bdc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


