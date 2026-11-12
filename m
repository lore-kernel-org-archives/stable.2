Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794503410;
	b=1ZB0q926pgcEFRvEWlRQ66REobDxq7NcKFMnM3LMSoQjxlfXMaPHALIOJSbZw1vpRxdK
	 BhSHUraYGzO8rKv0zjuAfIdqArjqXu4Anu5ilK63Ue57Z2rtDJDbubvnqvMTC0dH6w4+h
	 /R/ZBLOWKMHPwwiXQgfxq2MOH6IcXPNm94rEMHzZtyR1NVqpWMd80wK+DQo8AdFO+LMCX
	 2phpAoRVxH8poygB+nCivuaq5e/yIN/W2jPigeBw2agtJTYhRQ/6ra80KagA13uVH86pw
	 8pw665y4R8SNsPm/803H2S1O5TJgclRYg6Wjub+OoiIhbgGPn0xDtsvF2oLmkXMORtA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794503410;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=VqJqQmXN3Hcs0vJ81mtWmJGZP+7ybSBHA9gD6M1mDho=;
	b=l5h1J84I05gkppu+YtP/mCUZF6yiGO/GhD6oTlDV51YC0Gh2pSTSugKEAfJTx3X572JK
	 ijoJfCoAozDUG4pGQkha5ISpqBbrQy/0FZd0mwTu9nPCvK0jq7MIIruCq9Bv68IZXGlfD
	 hpiZeUh+pOS3qcwbdI37GUQRcSQug+sPZLfZsw6j3E2wtsh+8uS1PRoFw9DmvTFj6YhaC
	 nbKExWpKAwM1J3JsP1oam7P4O1cEinP83LM7/j3ciYswTjxu6QeT4kvft1Cr8vzknmDSO
	 sHTEBdquAL/fYYV7rw9tn3J94jr24nXP3GIKnv/DrDGHEqUWFnrUAmFm+Xkv4lwAR9A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="aTG/8Ov9";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3DEC606A330;
	Thu, 12 Nov 2026 17:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aTG/8Ov9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 439A01F000C4;
	Thu, 12 Nov 2026 17:10:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794503409;
	bh=VqJqQmXN3Hcs0vJ81mtWmJGZP+7ybSBHA9gD6M1mDho=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=aTG/8Ov9L8E3TMZ8MQNHvVDIc081ZU1Klddc8cKf0uj0aXPlNQ6WIL/cPOdrUKrMZ
	 Y34OIwnYg9/Ot5okj5Qjt5Z7Kmj3+K/UUyFfkNLi6g6WnE9SMMNbCe0+of8RUGP5/W
	 UbxAFcBxGR4PsNMjf9r0WUJiYDH/kFJaQIcZItjE8hQli0HdqpgG0aWJ4aOTTcvtOD
	 neZMdTCTqWm2Bm73JBKrqFiEqjmPMxX729EpukRf5WSRSLt79LIvLcBqF2vQZJirGJ
	 qlgCzEIEh32eVHPgN/eNAoG7jY9UmvuKrILa2VB+p+E7WCUbNsdndXTWKVQvP3ajl8
	 jYCUgdgme8Ipg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3A2EF380AA75;
	Thu, 12 Nov 2026 17:10:09 +0000 (UTC)
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
Subject: Re: [PATCH net v8] net: libwx: fix VF PM suspend/resume flow
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179450340777.540799.8922827918825455447.git-patchwork-notify@kernel.org>
Date: Thu, 12 Nov 2026 17:10:07 +0000
References: <20261109101442.84605-1-mengyuanlou@net-swift.com>
In-Reply-To: <20261109101442.84605-1-mengyuanlou@net-swift.com>
To: Mengyuan Lou <mengyuanlou@net-swift.com>
Cc: netdev@vger.kernel.org, jiawenwu@trustnetic.com,
 duanqiangwen@net-swift.com, linglingzhang@net-swift.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, hramamurthy@google.com,
 jacob.e.keller@intel.com, przemyslaw.kitszel@intel.com,
 stable@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  9 Nov 2026 18:14:42 +0800 you wrote:
> The shared PM callbacks used by txgbevf and ngbevf free queue vectors and
> disable PCI without first stopping a running VF or draining service
> activity. Resume does not re-enable PCI or restore the queues and IRQs of
> a running VF. Service work can therefore access torn-down resources, and a
> running interface is not restored correctly after resume.
> 
> Stop a running VF under RTNL before freeing its interrupt resources,
> preserving its administrative running state. Drain the service timer and
> work before disabling PCI.
> 
> [...]

Here is the summary with links:
  - [net,v8] net: libwx: fix VF PM suspend/resume flow
    https://git.kernel.org/netdev/net-next/c/a6c3e4c1f703

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


