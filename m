Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F0A04746C6;
	Tue,  6 Oct 2026 14:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791297021; cv=none; b=co1i4+dByBFG13N9lxGMFp3VzfZX3/ozazKElVqTbdhfl8KYwwGzZCRprVRV6mszvr6YjC3uP5o5ulKMVc957B6JWM9/QSPzN4gESlB5nvFUvJQbAIftpudekQDFS+pWtQJBh3VEFKOZwp5dJfuBN3AeEtJcOTllyB/NrXPhGvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791297021; c=relaxed/simple;
	bh=BO476hfquZhpWkkyTCubHomCxjh3G7NiyAaUYpZXs2w=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=iX4ge8TihoyY9ti9Hu8hCxTrFYxipYVeM9LkHFJVc2Hxsj2b2bezc9TGm+oLDQLj6e7/qEZBbR2VSAYk4J8iYLlDuxtFSmK+KqQXECm5Zh0iWt7t0RVZJq7euoHvUa1AL7S9I38ucvO5W7WtBKdIoBUok1b7XTJNBHCxsITorJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XZ7euWnY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XZ7euWnY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07ACF1F0089D;
	Tue,  6 Oct 2026 14:30:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791297020;
	bh=xtFXS7x3vYGkzPZZRqNMV+TcpRkW0o++yR/hQhGWDBo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=XZ7euWnYIok9E/srpGORzOiUBTXasgEXex4rhCnbPqsBCBKmzj69oIh1w0oT9Sg9I
	 faHEzie1Lss3EdoPjFnCl86b0ti6ofS+Y9Sy8JgA0fH5eZgOIpZKmjD6sB6jA3KwSz
	 hYbm1TLRojxiE+JuLU7lYKam5bMwfrTT6SWNuuSQG12+lmDy+xasFovAaznhHZ8Oz8
	 ieFEYq16TL2Vh+b1iBCFkLoJLvz/g22uQ0qhU+6YCzIRyw2NeOF/4B94k7uaVMKmzr
	 LrFfxex9r8l+IKFbTtt9/wNO2xLGF3Sm/6ThrFfS7MYFu7qe5NtRaWkRTEl2Yk7HiY
	 kPERu7cyO+/UA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F13B039D5FF3;
	Tue,  6 Oct 2026 14:30:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: hci_sync: Fix command skb lifetime during scan
 setup
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <179129701852.2655967.14077509856109864264.git-patchwork-notify@kernel.org>
Date: Tue, 06 Oct 2026 14:30:18 +0000
References: <20261004162612.3968831-1-nicoyip.dev@gmail.com>
In-Reply-To: <20261004162612.3968831-1-nicoyip.dev@gmail.com>
To: Chengfeng Ye <nicoyip.dev@gmail.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon,  5 Oct 2026 00:26:12 +0800 you wrote:
> During PA sync scan setup, hci_le_set_ext_scan_param_sync() gets the
> address used for the PA_LINK lookup from hci_sent_cmd_data(). The
> returned pointer borrows storage from sent_cmd or req_skb, without
> holding a reference to either skb.
> 
> The scan worker runs on req_workqueue while hci_cmd_work() runs on the
> separate device workqueue. After the scan worker loads sent_cmd, the
> command worker can free and replace it before hci_sent_cmd_data()
> dereferences the skb. The command payload can also be freed between
> returning from the helper and comparing the address. The connection
> lookup's RCU critical section does not protect the command skb.
> 
> [...]

Here is the summary with links:
  - Bluetooth: hci_sync: Fix command skb lifetime during scan setup
    https://git.kernel.org/bluetooth/bluetooth-next/c/9af12272061d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


