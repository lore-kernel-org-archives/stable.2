Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99DAD380FF8;
	Sat, 22 Aug 2026 20:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787430677; cv=none; b=GNaLmEhKhQvyQ4pm0Z+P1do/N5SQmDA+jCDFxr/Iassswjn+JO5GQJVduR5gcd+/Im8nN6LDCzBwh3NrOWkWFg2eludQ/jJesV/unBitkHZd1kV1YEtnAUMVNf2KV0hdqZ4xmKCY8kBJ6RLzI3ecJ2v96jfYIJxhq7gMz0xP3rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787430677; c=relaxed/simple;
	bh=r4zLk98bcowo6c+ebnjNVPiaRgXF4lUosKru9TdIzDw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=txNXm/8Zwc3zOxEo2vL3sN5+Cy09JNoFS7hKMQALCi8a7uKJZr5UNyGEH+YXo8W07AFtlflGtqN2+1HXYZHczdZe9tXS8M0e6BH5p0KkGVW3a4cwuf99kwCJd9Trq42kA1HnTAv1EkHhgBKUV87cH54sCuwhOuL6BKvj2jFbbss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=acwJTzpn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="acwJTzpn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 574311F000E9;
	Sat, 22 Aug 2026 20:31:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787430676;
	bh=dUKk6ed4/9Z0wl6Xm+0+qocMHswqgzE5cEeeu53iBlM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=acwJTzpnGyvTs4/KmOkWkM4eCU2KrxnHwB6t4ThQL/tNilSDyZSNw+yuimD5Ov8L2
	 oM4qw8AlgxH9TIvozKQbGVjqFYo88t/BFCZzmWZYobD/o1Wa4TX9tpzdigPGQ+2j5U
	 pjnMOgDq6v/pc9/DU8Lyyj35NohNB+09kYEt8G1IkUxnYfEXHhyxL6KYaxkysdzUUg
	 1fHj7sDGcblb/lm5d+Vv7/dBgWRrZTecnbn/f/5DOLL1ZaDpX626i8OMFcd6G1ylDR
	 QS3QOudfZufIv457ALtDXCNsYGWvcIo/eiVW/WF/JLQr9n016sTHmypydmPr1auO+E
	 PfZG6jNUJYufg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 5690D380CEF9;
	Sat, 22 Aug 2026 20:30:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v5] gtp: serialize PDP context updates
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178743062488.1819488.16577192802417073757.git-patchwork-notify@kernel.org>
Date: Sat, 22 Aug 2026 20:30:24 +0000
References: <20260818150000.7670-1-a0yami@mailbox.org>
In-Reply-To: <20260818150000.7670-1-a0yami@mailbox.org>
To: Ming Qing <a0yami@mailbox.org>
Cc: pablo@netfilter.org, laforge@gnumonks.org, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, kuniyu@google.com, osmocom-net-gprs@lists.osmocom.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 18 Aug 2026 23:00:00 +0800 you wrote:
> PDP contexts can be deleted through GTP_CMD_DELPDP or while the GTP
> network device is being unregistered. The latter is serialized by RTNL,
> but the generic-netlink delete path only holds RCU.
> 
> Running both paths concurrently can therefore make both paths delete the
> same PDP context. The issue was found through static analysis and
> reproduced on a KASAN-enabled kernel by a simple two-thread program
> racing GTP_CMD_DELPDP against RTM_DELLINK:
> 
> [...]

Here is the summary with links:
  - [net,v5] gtp: serialize PDP context updates
    https://git.kernel.org/netdev/net/c/498386b6d402

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


