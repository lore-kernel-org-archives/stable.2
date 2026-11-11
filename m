Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794438012;
	b=cQbmTShBCbpYgBGhAv8cfEcBtGlH9r9SeofDnQnhctT5oX9JgnuBCaQ9r5x4xWJrMMgj
	 2PUzksaVYjqR0lo3odkRD0EmgpMWLkhZiB4RO/+RpuGhhO5Kmu5lnK0U5zM5WZLMYf/tk
	 E2jXH0LyDu/WCe4bUoUv5jTiFYkbfcJFCsuq0uS2zDVJ/38XICJnuyLXB4CJFOa07fCy/
	 yAgwMw415323IlDGLKmtnKCoJYSK0acwQxa07r31qiAr0ZtbBAkrcTeimoZXy9i2M2sLP
	 DVkfjgYu5j81tWkGZ3eIYCTp7Z8cC2EdEDPWbpM+drM9V6uNkJXqxkLutW7705nOSIw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794438012;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=PT4QF1qXNcf5ToumnF7fZz7tNZztFh3q6qvq1mETrKM=;
	b=i9pueS1+XV8a9D1+w9eKWbkODjivLAmDVvPYHSeufg5FmNF9Vxq0lJ1v9U7+H9y7ASFy
	 UOX/IrHSiBBCkeLTge9INGEQJN1LpiyG8mVuj8KRI6YPGviaFZrqBLPtUmOaBMNwUwQkS
	 LHmCABCerGqob3ys1luvsXTlXG9vJWh1RXvz3xxiFWFeXV4E7s6pQS/c7gJN5kMKNqJ7f
	 8oa9ROR21MimGRSFOa5PJnyrAZzTFdJME2mgF+XFtXW0YFstavw3OuF/mRVPrwERVd7SA
	 oXjWISiiMuNbsr+wENJ16m2flTBiVMDlDAuRX9rJ0j5ni2WAry9pYRNLUyAgTgqQFgg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Tu7ERM0R;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 130FF606A89A;
	Wed, 11 Nov 2026 23:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Tu7ERM0R
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A481F1F00A09;
	Wed, 11 Nov 2026 23:00:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794438011;
	bh=PT4QF1qXNcf5ToumnF7fZz7tNZztFh3q6qvq1mETrKM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Tu7ERM0RTzyuuk04kPc/Hn3Ohsa75KN2wcryN+lCqGk7KM8Uo42C/aw5HpqBx/T2Z
	 QA9vQRFsgwPYJGjqEhBmsELgGvFQka26Kjd98VXKGrC3b5i2ZorSt4mccqs752Ib3s
	 +ez4rIG2E6wiPQ0OMUJcxkx/aMJMDoIJ9UKKJ/M/7KNFU+qQw3nrcJbLsRp7fE5f53
	 WeaXAWTih9ausn3x/Y1ZUSbldguNW5BvnBmGoo48DUaX82IsqmlZ7UT7Of5W5KDpXt
	 dXriTL3jyRF5YjgRdbqSPPXajNi3kmFG2YI5fooqn5zqsBJLHjPjF2MsXoZhDx1itV
	 Pf2ztl+zcX3EA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 9B2BF391AFC6;
	Wed, 11 Nov 2026 23:00:11 +0000 (UTC)
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
Subject: Re: [PATCH net v5 0/4] gve: Fixes for issues discovered via net
 selftests
 and Sashiko
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179443801016.1692642.9207097751401678746.git-patchwork-notify@kernel.org>
Date: Wed, 11 Nov 2026 23:00:10 +0000
References: <20261109182036.2910559-1-hramamurthy@google.com>
In-Reply-To: <20261109182036.2910559-1-hramamurthy@google.com>
To: Harshitha Ramamurthy <hramamurthy@google.com>
Cc: netdev@vger.kernel.org, joshwash@google.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 jordanrhee@google.com, willemb@google.com, przemyslaw.kitszel@intel.com,
 nktgrg@google.com, maolson@google.com, jacob.e.keller@intel.com,
 pkaligineedi@google.com, yangchun@google.com, patricion@google.com,
 awogbemila@google.com, csully@google.com, jonolson@google.com,
 lrizzo@google.com, stable@vger.kernel.org, linux-kernel@vger.kernel.org,
 treapking@google.com

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  9 Nov 2026 18:20:32 +0000 you wrote:
> From: Pin-yen Lin <treapking@google.com>
> 
> This patch series addresses several issues in the gve driver. All four of
> these fixes were either uncovered by running the net selftests or
> suggested by Sashiko in the previous version.
> 
> The series includes the following changes:
> 
> [...]

Here is the summary with links:
  - [net,v5,1/4] gve: Fix race between stats query and queue reconfig
    https://git.kernel.org/netdev/net/c/7de69da15088
  - [net,v5,2/4] gve: Fix backward stats when interface goes down or configuration is adjusted
    https://git.kernel.org/netdev/net/c/6752dfc316b9
  - [net,v5,3/4] gve: Block invalid ring sizes when device options are 0
    https://git.kernel.org/netdev/net/c/edc9a730ad3c
  - [net,v5,4/4] gve: Fix link flap after ethtool ops
    https://git.kernel.org/netdev/net/c/b1a53c452457

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


