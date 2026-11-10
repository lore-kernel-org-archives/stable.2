Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794334983;
	b=nD3mLyC0SDQq/Ow7Ngfi0ii25EIby9/vy8IPV8yequ3CJbWXTr+cgv0ZSfhcfOppMyGU
	 +VXFdG4IIN3dYS4hlVi+K2XsgndvF1xBulixEa3nPqz5A/D+ndrnMPr+OWOspmm1ecv5J
	 Yb76EAwi+tVrQ5X9cj6y2x5M5+SvkqucLocLs8S5tlUkA6xf1JNn/rcgTftoVJ/dsurAo
	 Ps3hWTZCt/K0V4akcVP6WWtjBib1ytkBnuCo0A0z0NY2CDU8nM9ZAdU/nlANTAVq8Albg
	 QdBVplpx55AAhlwOBH3w9YL+yYiVoC6NDsJNyqNrc6nuBKarTGD3a8HiVqaWxZYL7Jg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794334983;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=STj4gsh+ECkiq52y42atn6++DW4Ig0+TQVJRAn04acQ=;
	b=SPPR3sPOp8gNHjX8ebWEqaMRsNaFpYLbFywE6Z1MU/9e2UIVq6bqU4f6mK6qbdbFpXN2
	 JvjvYVLEEx1GnPEQYm+NKTFz5gd3X7H9nOutx2IxfwERwnjKFxrcbBGVcgNnrZ/rE9sah
	 LiDyJcFH0U/ke2jMOUyhVr7BxbGQRIk5c4M5Rz0QR58LKhZ0+9pEHC6/Nyr97OlS5vuSZ
	 vHAliMntnEGcUtW2UnBznD3eAjSExMRXqL1TJSwRgCIUoujoLRf4TKghmnCQ8kF0XzrCj
	 Utmrgsh9W2KlBubUZYvvLm5lu7BLjjNStNbMJnJbeIvQDyW2cRV5H5etlG22EPpAYPw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MBSXZjuH;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F71A606A336;
	Tue, 10 Nov 2026 18:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MBSXZjuH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30F8C1F008A1;
	Tue, 10 Nov 2026 18:23:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794334983;
	bh=STj4gsh+ECkiq52y42atn6++DW4Ig0+TQVJRAn04acQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=MBSXZjuHQ9vFqwd+iX2S78XLwgd17suaM5GydqfUi9v08LyszHYr3TbpPYR+TQje/
	 A3CeHzqP+jRHyMKXcRjR2gqAF6iDha4etd3p88/Jj2uw1GWTnDzaRCjEYx2SiGE/U/
	 3kgdjIAzHPkAkoxzF87C2LKvOXgkViFA5IJSJuaaBX3tEkwWs7oA2rIN8MbgzW204T
	 wfdfcGIUkZW8M3ab5nfOLHccQNplUjG9YXMdwwqMIDZ2KMuR5N0zW6fYA9nCZa3wNW
	 pVWa6K1YqSnwMdyf9LUFNcdvArYrlyhBxUvKyn7ebOKBe6LxrY/zPn8kPlMl5qbcra
	 fCLq1HXFOjM9g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 210EE39D608B;
	Tue, 10 Nov 2026 18:23:03 +0000 (UTC)
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
Subject: Re: [PATCH net v3 0/4] net/sched: fix short-skb metadata and
 namespace
 boundaries
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179433498169.4118637.9465762376116363079.git-patchwork-notify@kernel.org>
Date: Tue, 10 Nov 2026 18:23:01 +0000
References: <SER-NSBD.v3.r0.20261103064310@mojatatu.com>
In-Reply-To: <SER-NSBD.v3.r0.20261103064310@mojatatu.com>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: netdev@vger.kernel.org, stable@vger.kernel.org, shawnq1@163.com,
 davem@davemloft.net, edumazet@kernel.org, horms@kernel.org, jiri@resnulli.us,
 kuba@kernel.org, pabeni@redhat.com, victor@mojatatu.com,
 sashiko-bot@kernel.org, thomas.goff@boeing.com, shuah@kernel.org,
 yotam.gi@gmail.com, linux-kselftest@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  3 Nov 2026 06:50:28 -0500 you wrote:
> This series fixes three independent boundary problems in net/sched, and
> covers the third one with tc-testing cases.
> 
> 1/4 act_ife: encode a configured zero metadata value.  The u32 and u16
> presence callbacks reserve an 8-byte TLV for a configured zero value, but
> the encoders returned without writing it, leaking stale skb headroom bytes.
> 
> [...]

Here is the summary with links:
  - [net,v3,1/4] net/sched: act_ife: encode configured zero metadata values
    https://git.kernel.org/netdev/net/c/7d02c07c738b
  - [net,v3,2/4] net/sched: act_ife: require a full Ethernet header on egress
    https://git.kernel.org/netdev/net/c/11dbce090834
  - [net,v3,3/4] net/sched: sch_teql: reject qdiscs from another network namespace
    https://git.kernel.org/netdev/net/c/1ae84bdd736f
  - [net,v3,4/4] selftests: tc-testing: teql: cover each attach rejection on its own
    https://git.kernel.org/netdev/net/c/367a50c3233e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


