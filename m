Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795705809;
	b=ZPCcq9OeG2hK0HNkkevBTN+fuG9PTWAupXWF40h/G9EPuynN7GpSwoKe1TOEJJRFosp8
	 IdWaKLp8A9rw91rK7TG2PEskNUGs9BEzcN9TKlfvy0hTX5pDJGvEYtB7g4FSX6QbDVCKT
	 REgAITatcRKU0Tpp/8JTUM2uGfBYVBg4/Fm7y+Ym1sf5KfJ9ZXr5GL8lvno9ptP/qZtJg
	 nknGDxv7lN1AKCSYv5QnjUY3k2qGjN78Exq058ykGaLwXqwF0+hQ/LXRI9DtrOvWezKGF
	 lQqAUu8USFYF4AcOY1rroCmL5YT9Awk6J7kVIMVVm26s2cQsmAlZRkKiquh89buSIug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795705809;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=nve0oiWt3fDBEFLCLIFQKd/HP7O7o2kSx1+K6NEp3nc=;
	b=rsTtR2dq2Wez4I1/oAXng9dPnOBdvRRWa3L9eXl5g2nvT8SbA1T4Yyw4VwSyvd5V3zWo
	 b9nR+XJZjrOeomWJLk7l4TWtVjv1QHaN5nH5arwNdJTWHH7kro1jbfc05G2xgrHZvVFAw
	 YCoam7+ubEXfYO4IC9k7PTuC4w42HCGeu0oCnNRisCLGZiOmF/QcKx1KsdnJ5tutLbom9
	 qNpXzRfsmhiEDnOmPSOiQLfyQm6XDIr49j7yVeQqnvv1qndi7A8sIHzjJzGESVUpO5kIi
	 fNWcpDQzsU5YM0RiVMEjX2+cXX8VA8Gf81XZiCua8D5gdl79/2s893HkSbyIauF+T7w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aelEwF6A;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23DC1606A332;
	Thu, 26 Nov 2026 15:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aelEwF6A
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCE7E1F000CF;
	Thu, 26 Nov 2026 15:10:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795705808;
	bh=nve0oiWt3fDBEFLCLIFQKd/HP7O7o2kSx1+K6NEp3nc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=aelEwF6A03r3YWdtYsLZPM9kvOmQFrhn7zpswNC32gfEfUBl5dMYRElCUEcYrhqGw
	 z7FV1skppZDcvhD23+lrQHZMWdRCVsDh+NO907CHknnDvs1Qst45NWjW0gvhs9Dv+u
	 TF3Ez5l5oRISNn+kARNT/g3+WaXqGFWDOnZfqjQa1vnMfi/cQSH08VRSBT5O6m/1gK
	 9NJc8WNFyiozd40Dm78TkZCUjWCGcgC75/xwwNx6Gk9xCf8DfYhsAePkPwqu9LWxI5
	 KC2N9En3vvNJd8so0VJgoZbqa5K7LLfvlVwG6zdlBR50aS3Schr+zCGfmpZht+w65E
	 UuTB2L8hZeerQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B445E380A96C;
	Thu, 26 Nov 2026 15:10:08 +0000 (UTC)
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
Subject: Re: [PATCH net 01/12] can: bcm: copy the CAN frames outside of
 lock_sock()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179570580753.1889275.331318921844606497.git-patchwork-notify@kernel.org>
Date: Thu, 26 Nov 2026 15:10:07 +0000
References: <20261124085757.1093632-2-mkl@pengutronix.de>
In-Reply-To: <20261124085757.1093632-2-mkl@pengutronix.de>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 linux-can@vger.kernel.org, kernel@pengutronix.de, socketcan@hartkopp.net,
 stable@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Marc Kleine-Budde <mkl@pengutronix.de>:

On Tue, 24 Nov 2026 09:51:28 +0100 you wrote:
> From: Oliver Hartkopp <socketcan@hartkopp.net>
> 
> bcm_sendmsg() copies the CAN frames of TX_SETUP, RX_SETUP and TX_SEND
> from user space while holding lock_sock(). A copy that faults or
> stalls, e.g. on a FUSE backed mapping, holds lock_sock() for its whole
> duration.
> 
> [...]

Here is the summary with links:
  - [net,01/12] can: bcm: copy the CAN frames outside of lock_sock()
    https://git.kernel.org/netdev/net/c/a2bdc43c05f9
  - [net,02/12] can: bcm: do not remove the procfs entry in bcm_notify()
    https://git.kernel.org/netdev/net/c/2caf66eca1bc
  - [net,03/12] can: raw: use a private mutex instead of lock_sock()
    https://git.kernel.org/netdev/net/c/f7c5b6e19684
  - [net,04/12] can: isotp: use a private mutex instead of lock_sock()
    https://git.kernel.org/netdev/net/c/c781fc329528
  - [net,05/12] can: bcm: use a private mutex instead of lock_sock()
    https://git.kernel.org/netdev/net/c/bcea265a4c04
  - [net,06/12] can: isotp: always start the rx timeout in ISOTP_WAIT_DATA state
    https://git.kernel.org/netdev/net/c/4b558c0ccb62
  - [net,07/12] can: isotp: reject socket options while a transfer is active
    https://git.kernel.org/netdev/net/c/da0eaf6fd9bb
  - [net,08/12] can: netlink: fix static FD-NON-ISO mode validation
    https://git.kernel.org/netdev/net/c/36da93199869
  - [net,09/12] can: netlink: fix IFLA_CAN_BITRATE_MAX attribute sizing
    https://git.kernel.org/netdev/net/c/0bfb76b7c927
  - [net,10/12] can: netlink: fix CAN XL PWM attribute sizing
    https://git.kernel.org/netdev/net/c/3949d692d646
  - [net,11/12] can: gs_usb: gs_can_start_xmit(): don't leak uninitialized memory over USB
    https://git.kernel.org/netdev/net/c/4dfaa1160683
  - [net,12/12] can: flexcan: Fix probing for m68k/coldfire
    https://git.kernel.org/netdev/net/c/869199293237

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


