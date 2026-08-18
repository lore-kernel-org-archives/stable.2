Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 694F33A7F62;
	Tue, 18 Aug 2026 18:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787078301; cv=none; b=R9KP5M3bPm9IC2iJMxf+KcXVXuR2+f125FR+TPZMoVkPF13rteOcgoiLMz1rRunwU1aBmEoGpJUPGwR6TqmV0EVkIMaEfLMCGTWcGOVsT/mzkUD1jmhCs4VlK6ttjcx4TXBZi9draKXsCj+rpZtvLfaYvACzI9A0+ypiYBiph4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787078301; c=relaxed/simple;
	bh=4SUMUujpbM7y1uDJyB5KaAwgTsl1/fxMKtufQdPgFBY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=GKkMmKHmLDcqHFScsxMhHNcFQReBjZcnMscTZ+aFEkx6J/glJYuAGryLU8fzmUPr41c3AFK87AgPRcunFohQGJVHMHQKlrGe7p27nyrZsFA729Uu9YPlqa0lPiJEM7hQWvUcqSOdgJGCv3rhLmxeZWp4M16iw4Ozcc2O+PtpWrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ceKAhWNk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ceKAhWNk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50DFA1F000E9;
	Tue, 18 Aug 2026 18:38:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787078300;
	bh=xcE8u3MTQeSN+HcN7MflLAd7hpeSPdq2Rj1vU/dHrpk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=ceKAhWNk/QWJiTGHfUmOYeY2Ku5OrcRC12NKi2kQq3Xqhjr4uDA5jEWx/mj6Otqnq
	 Cc6jk8INttufEJ1drwXZQX9SgBV00FFKpqpJNZMEiKfJrN8PM5zX2skOlKvYKQpK8O
	 wCiWc2n+0lxBYQDIdWCxQ8PSUnL6GFI91QFNOxjmkGkRkXDtCaW5wPXPjuYjiY3dk4
	 txL4LW3La0xH+EMjpK9VEM66YVG5QCxGC3BFKqYLPP4okg/U7yOOCTeV7DLLIWN2oP
	 IXgW3VpWofE+OxKA3tnC7QoMU6PfPrY95XNSSpZiSwwu+oUrO3mAk1OL+cYxirndoU
	 aETw4dZOTxm0g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 1981A392704D;
	Tue, 18 Aug 2026 18:37:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: hci_bcm4377: Ignore reserved PHY in ext adv
 reports on BCM4378
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178707825170.2194892.13646911015314059451.git-patchwork-notify@kernel.org>
Date: Tue, 18 Aug 2026 18:37:31 +0000
References: <20260818-fix-bcm4378-ext-adv-v1-1-81a143eac194@kernel.org>
In-Reply-To: <20260818-fix-bcm4378-ext-adv-v1-1-81a143eac194@kernel.org>
To: Lorenzo Stoakes (ARM) <ljs@kernel.org>
Cc: sven@kernel.org, j@jannau.net, neal@gompa.dev, marcel@holtmann.org,
 luiz.dentz@gmail.com, luiz.von.dentz@intel.com, asahi@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-bluetooth@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 18 Aug 2026 10:49:34 +0100 you wrote:
> Commit ed2a2ef16a6b ("Bluetooth: Add quirk to ignore reserved PHY bits in
> LE Extended Adv Report") added a quirk to handle creative use of the
> reserved bits in the PHY fields for 4388 controllers in Apple silicon.
> 
> I observed the same issue with the BCM4378 Bluetooth controller (14e4:5f69,
> rev 05) on an Apple MacBook Pro (13-inch, M2, 2022):
> 
> [...]

Here is the summary with links:
  - Bluetooth: hci_bcm4377: Ignore reserved PHY in ext adv reports on BCM4378
    https://git.kernel.org/bluetooth/bluetooth-next/c/762385e86200

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


