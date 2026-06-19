Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 982DD317158;
	Fri, 19 Jun 2026 01:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781832030; cv=none; b=hEMLB/x4opYbI5f72aHIeiMfhpVfZBdHyDhDp3VvCz02Be9fn0zs1Vz8+0PT+J7oUCKHrl5SJjl9s1TG0EdfLUWamXEzqlWeeJvxibRkEN9PTiCxpsrCH0Xn35oJNYnoTBEezqJV/K8xjAtYImiGtfpT3Np4SiKQskM+jonmHjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781832030; c=relaxed/simple;
	bh=9O435HB2nHcHpcJ7lpNvlQc8rPSrK6TVWxTfyZkLZ0s=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=KCLC6s0cf1UwMxNCZdTEUYiWmkqpC49vxLx5f3S3gIoysRiq9Gmp1xec77DsSLVEe0qjL3gKYaahXwgocmk0TscHjSiWPxCQ+eoLgXF8VkRCb9yzpmdlpXpBw5X7X8cBDfTJgqPsPPi6FeLwK+gieZ4KNEIaIV7pKZdg9AjKIR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eMTUVa1E; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eMTUVa1E"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53A5F1F000E9;
	Fri, 19 Jun 2026 01:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781832029;
	bh=ZPVK/Sl5RtQKBJ6Yg1YH+0BVyvCS6fX8Qf1yVRYKZHw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=eMTUVa1E5985OLXAz2ypqwEkIVp3v6HNA265x5mphIUMQ8IY2sEbC8uAuFo85W2vi
	 /Z5OOIqGrNtmDb4eGUYM2v++56k2G1VnBhTItmCgQjJDbnrfNCrKKWtz6bRiQvf2ON
	 dip70eFwvemd3n4LnaEh3882/DFbLr+TJNCiKYPypN0kGCdS53SRziEI+C2TR5SnwA
	 fiVwmAO+NhcnmuPy1JTWER1XnEOTPBc54T/SF1h53qH82Oh55I9FBF0tagwwarZZ+8
	 2tlLAEwJDcQQfCLQBz6KygMoyS4dZeutsUXI0DZoVwMTkvuHwLpGhWNgn28AWiI+SY
	 OCsargfsDqc1Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D09F03A78A7C;
	Fri, 19 Jun 2026 01:20:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: ena: clean up XDP TX queues when regular TX
 setup
 fails
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178183202238.3150917.16483912631551334888.git-patchwork-notify@kernel.org>
Date: Fri, 19 Jun 2026 01:20:22 +0000
References: <20260616142424.4005130-1-dawei.feng@seu.edu.cn>
In-Reply-To: <20260616142424.4005130-1-dawei.feng@seu.edu.cn>
To: Dawei Feng <dawei.feng@seu.edu.cn>
Cc: akiyano@amazon.com, darinzon@amazon.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
 john.fastabend@gmail.com, sdf@fomichev.me, sameehj@amazon.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 jianhao.xu@seu.edu.cn, stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 16 Jun 2026 22:24:24 +0800 you wrote:
> create_queues_with_size_backoff() creates XDP TX queues before setting
> up the regular TX path. If the subsequent allocation or creation of
> regular TX queues fails, the error handling paths omit the teardown of the
> XDP TX queues, leading to a resource leak.
> 
> Fix this by explicitly destroying the XDP TX queue subset at the two
> missing failure points.
> 
> [...]

Here is the summary with links:
  - [net] net: ena: clean up XDP TX queues when regular TX setup fails
    https://git.kernel.org/netdev/net/c/1bd6676254b4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


