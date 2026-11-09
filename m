Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794265221;
	b=j/sjTPs7ZPu8Nd3bOgWKHTtUdRQvregiQAl8xm7xHF558NQD2Ztxsl+NxdguCKIoESzr
	 eV43qAU3YX2yNOvPju4nG6Atx9Xl6Iu4HFvizrkyVOLYx9GSoY/DIGFp8Qm8r/vBMnhMg
	 u0n8NouxmBtm4UpTydzlBEY+uDSqbWK761OYUt2Vytnc1M95MFdMidoDOwzthzErjQs7y
	 0OGg6mnQwNE+xy4rzrDebZJdia7qVNrEfNzUeKHXDWqonMU8XQj8goANRsp/pzBq1cuYg
	 2u0fWlmGGjLCSQzc1KhxvpfJe5DoDxoJlpM2yi+hB+Qt7dhfjjPeLmQOoHmw1mOdqbA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794265221;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=xP8ew6Frff+/BgNF15w/pTjba+R+cyPPWe1Whyg7LzM=;
	b=uE5d6+Oh2VZFU1NNQaYoGVnnJ4NHHAWhGs2Ta6vmaqV0ueFC6WwG8kSWiNeUv/JibQrK
	 Mia7wjQ+o19Nby6AUqZVh0K+j41xpOX4hFkLPPpOIpnONz75nhrOs6iGHId8R0k6XY5bx
	 hFlq25PeZ4REJMTfk4BToXCYImGpuooljO5lWExcv14D3ako1wjcKhtpPb3AQqpT3sdCh
	 3TljXBJdopFCcgJJq2uB+2Qi+wTREbXgeBaMvzZLyI9QiCA7MuKcxINaRh5Oq7lw+L1v4
	 Lp/wgYOHskcCXsRuOL8SlEQMrjhh4in94JcGo6fBNWYa06yHl86RKZ8J8HHdFox7+BA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bslUQkU0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 177BC606A321;
	Mon,  9 Nov 2026 23:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bslUQkU0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A636B1F008A1;
	Mon,  9 Nov 2026 23:00:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794265220;
	bh=xP8ew6Frff+/BgNF15w/pTjba+R+cyPPWe1Whyg7LzM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=bslUQkU0K77KXmQ4PDjtPOPiTNarh29DG3/JpDXBhLYM/5Fd2vlu1x59XrKxLOzfQ
	 0mrVLDcLZQd+nEyizzMIOFKwDAubSdXeSgOyMmKX98j5viNim6G7L5vCHGPahXtn1o
	 BPH6S2Z624fN0nuvyXOogpKbcjtRrYxdo7jce/yqm+ZJR5oDqCoxU4fG6Hfu7aBp0e
	 q5t/+N/BwcdMQSI/8fs87eHWHCfhMlkomenmp6Ubn+4XBOfd/57lukpYYUZ1wvgRgO
	 QsW8v7T3bvaCyA3hxWjVTAWc/uykCoC5kaXDkUdFCY3neBa4gJfEsxFWZSJQX1Sh0/
	 DGv8Cha9yWDzA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 9B1D2391AF99;
	Mon,  9 Nov 2026 23:00:20 +0000 (UTC)
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
Subject: Re: [PATCH] Bluetooth: L2CAP: Keep recvmsg from resuming a closed
 channel
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <179426521925.3532311.18366530853288738368.git-patchwork-notify@kernel.org>
Date: Mon, 09 Nov 2026 23:00:19 +0000
References: <20261109132143.94305-1-enderaoelyther@gmail.com>
In-Reply-To: <20261109132143.94305-1-enderaoelyther@gmail.com>
To: Zhao Li <enderaoelyther@gmail.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com, martineau@kernel.org,
 gustavo@padovan.org, security@kernel.org, linux-bluetooth@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon,  9 Nov 2026 21:21:43 +0800 you wrote:
> Reading buffered ERTM data after ACL link loss can clear local busy and
> send a supervisory frame after l2cap_conn_del() has destroyed the HCI
> channel, which oopses on a NULL pointer in hci_send_acl(). The socket still
> owns its L2CAP channel, so its lifetime does not protect the underlying HCI
> channel.
> 
> Require BT_CONNECTED before clearing local busy in recvmsg. The socket lock
> already held here serializes this check and send with teardown, which
> closes the socket before the HCI channel is destroyed. Continue to allow
> buffered data to be read after disconnection.
> 
> [...]

Here is the summary with links:
  - Bluetooth: L2CAP: Keep recvmsg from resuming a closed channel
    https://git.kernel.org/bluetooth/bluetooth-next/c/1f2ac56137c5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


