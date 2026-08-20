Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ABED3D6CD7;
	Thu, 20 Aug 2026 20:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787258465; cv=none; b=iu2aBvmNBQ28f4vOrsvh7icoCU17s9lpd6bTtm+rd+L1k835h4ZBuW6uQYB3IB/s3Rx5gwoA6DnzZzmRfv8gDy865K8g0ubjwHyPHXEzjMW4rQ+DAyXKjzAJyifwgbRuRdylFul9vTmYOv57U2quKydyJTu03IPOPR9xHfTs8vA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787258465; c=relaxed/simple;
	bh=X3+gwGxPi+Q5JwEgDJcInO2ZOLFQUuG5UPquCvJHJQQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=sNZlVQ9bA0R63c9JHj9MNWHblKxRDbC4QcBLXcVtFDQDVBTeyGggtNNayY4gE02J92rpIMdSgc61WpChwPykoRIhkOSeCIIP3oJwrqcdURXOeCBMRvmfqfgvjIIToga0kXU8z8vaqhzM2fDJstrwt2a7bEEaCuqp4SCU76Ouj60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XZarZMSX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XZarZMSX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A03A41F00A3A;
	Thu, 20 Aug 2026 20:41:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787258463;
	bh=JOuGINPWo0nmDwbEXX+awnav/MTpoRGey1eZYHgeAFM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=XZarZMSXgzPV20bTPFJHRzOTAYoS/VyF3JOOqYXIdCGyTRqq7jR7BoW3yDCKwugua
	 UpZuXcTSzc7J0A0wpjzP10Ub9TMX9NS0zFT1OzeA6xX4OM7PiYhU1ysYAz1Fq0InNd
	 yh/hdoGAsbz3pggwQ9hNP9Ub4HzGNTb1rOaQOP7zyKsw4mX54MY6bhWJO4YSBgSQAE
	 zSWSEF6p9UmoiNd/NIQ3gaXhtSv3FMK+CyDGoKY4b5BXfwW3Ybv3p7rqaQbXa+iHrz
	 ZXXiXUmqF6N/FTCI7zvJ1/EiLwEhgycM3mVmiPIs3hpnnX+XSQo1TAOU+SgcW2uHGi
	 1lgGaQXB+qMqQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 0ED21392445E;
	Thu, 20 Aug 2026 20:40:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net: sched: fix 32-bit backlog wrap in gred,
 bfifo and plug enqueue
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178725841364.473641.6076100232757539064.git-patchwork-notify@kernel.org>
Date: Thu, 20 Aug 2026 20:40:13 +0000
References: <20260818095927.15901-1-jhs@mojatatu.com>
In-Reply-To: <20260818095927.15901-1-jhs@mojatatu.com>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: netdev@vger.kernel.org, jiri@resnulli.us, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 david.ward@ll.mit.edu, vega@nebusec.ai, victor@mojatatu.com,
 zhanxusheng1024@gmail.com, stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 18 Aug 2026 05:59:27 -0400 you wrote:
> gred_enqueue(), bfifo_enqueue() and plug_enqueue() admit a packet when the
> current backlog plus the packet length fits within the queue limit:
> 
>   sch->qstats.backlog + qdisc_pkt_len(skb) <= sch->limit (gred default VQ)
>   gred_backlog+qdisc_pkt_len(skb) <= q->limit  (gred configured VQ)
>   sch->qstats.backlog + qdisc_pkt_len(skb) <= sch->limit (bfifo)
>   sch->qstats.backlog + skb->len <= q->limit             (plug)
> 
> [...]

Here is the summary with links:
  - [net,v2] net: sched: fix 32-bit backlog wrap in gred, bfifo and plug enqueue
    https://git.kernel.org/netdev/net/c/4c660ee8c809

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


