Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45A6E46C826;
	Tue,  6 Oct 2026 14:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791297015; cv=none; b=tuWCYI3javH/O3d7RUXQJsooPELfJS6WoK5cNAsfHkRvmmjZdusCkKfxw2FBq1ZSEFuBIBb/y1V+5GZ9hi/K0TMteUFZ6E66ZUkVrPSW+qjydn8C8sYxGvyyH4pTFPQ2oEgXLUlC8DYU6m3nm1FbQyLRO0S29CeDlq4GD3e6hqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791297015; c=relaxed/simple;
	bh=HzR3bIkl7tqeptoaF03WRmK+k32y3BbzXLSjHdVXUxA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=u2il8sbX54GbhOCK41Ivks4SrKDPYqKaX1ua9gvyzZrov/sBNOJR3wtClT+j9SL3zJHmdAMQEpQQ8uuRHGxDKaCw/vzNBYH6FMb9RnuYpJWNuu48YsliGBcc6FeWuM6J8ljAUypGX/6ChAhTFSYJtp+g2oqCaIoycEeSYjP+e/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b9aEkOtP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b9aEkOtP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 099DA1F0089B;
	Tue,  6 Oct 2026 14:30:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791297014;
	bh=h0Pok1qt68YrWEZKekYSCZycWEqtZTNZYOSMSlnREtQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=b9aEkOtPb9kR4cgqq28dLQBF0Wthozxbw++/lPdcPIyL1WIo5+AQJM7BYNFaUpson
	 Bsugrj/dY1iotsSR79oypgwuPu+SsGCq3ygxjVaeVlLWyoEPw24I1try4NlOFiUBqm
	 dKGKCAiW5vpbXyLlwkdj/8PYzsoa5ysRyBRpUl7Gnjb/jZQuKjbfa3Tdeo7QkUAhVX
	 qiMCljSFH8GBbym/f8QX07ysjJjCZeLiwSSxMvFzIU6GAq6gwhH2pWzvOKP5X2U4g4
	 e7FOYEiWhkZ0iI9ZhkJRj/WiBBx1uRaRAEsePH05Y0ikTT1nuvVwOrc/tzTl/smBEt
	 L2Gj4M4+uTy2w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F147439D5FF3;
	Tue,  6 Oct 2026 14:30:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: hci_sock: Serialize dead-device detachment
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <179129701278.2655967.8493236646880910714.git-patchwork-notify@kernel.org>
Date: Tue, 06 Oct 2026 14:30:12 +0000
References: <20261004162442.3968446-1-nicoyip.dev@gmail.com>
In-Reply-To: <20261004162442.3968446-1-nicoyip.dev@gmail.com>
To: Chengfeng Ye <nicoyip.dev@gmail.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com,
 penguin-kernel@i-love.sakura.ne.jp, linux-bluetooth@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon,  5 Oct 2026 00:24:42 +0800 you wrote:
> Rebinding an HCI socket after its controller is unregistered can race
> monitor control replay and crash the kernel. hci_sock_bind() clears
> hci_pi(sk)->hdev and drops the device reference under only the socket
> lock, whereas send_monitor_control_replay() holds hci_sk_list.lock for
> reading.
> 
> Replay can observe a non-NULL hdev, then bind can clear it and drop the
> last reference before create_monitor_ctrl_open() reads hdev->id. This
> can cause a NULL pointer dereference if the pointer is reloaded, or a
> use-after-free if the old pointer is retained.
> 
> [...]

Here is the summary with links:
  - Bluetooth: hci_sock: Serialize dead-device detachment
    https://git.kernel.org/bluetooth/bluetooth-next/c/381a0925c556

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


