Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795461024;
	b=B3HN4E0EACx3WnYhpu9+h3p/A7/KsUiXd28YLZnmLasrQi6ydDfYeOBigXNpXQfnAeDH
	 72swe/R+8TF8hlHFt1jGP78W9yzZdxRXn5hjj69RMHQCbeQBumCUnHHCNxh8xUj38p4Rv
	 V89Yvu2vkEYzA7bmI673o1FfHXMZp9V+93nPFzsW1Eg9PjCsu5bomuipX8D8utTnG41Qi
	 pD4ZzcYlOOC4dlzu+76dZ+RqTzIDqdcvLzLm5GHnmRWw9r4tioAGkYZZONfRr66NTFMt3
	 FVVHBlFs/CF9dJFLgW4TcMwkKUvY6tXVNMyTgwlbNMckrRm9i5rd0WLD+0a/EBhlzlA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795461024;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=P7FDWnuntiypVaq18IX2yuHzG9oAyX3kKeY7z/oJ1wQ=;
	b=mPUbLNY+z/wKtozOrHye9TMoiREFFX+gKw4JVbb6SbVfU4kgvFkv7oFUOMkTLTs2ezIy
	 DDMvdR2qvWzqtvXkQJ3Z9HJvaCrr6X21L6CYiIhkwt0PxvLAvWXPnTb04vAsBql5p9FxA
	 TDEoP6egpTmRphWLhBjTh1EgnmbNsLsSTuiDlS0ybSqSPw9c9TW+/V1Difnb5OpMiKnl5
	 ioj4yLVug+UiCeOUh2ULx6gxHYubL2uZAdEdpLOTkSzCINh0UFaPjRgE9EFTOvbbusLKr
	 0kBrGzh4aaOLOQpQabtpCe0LNEndOqPHBueK9DEy1Jn3EcLrAF0JcLzPaP/k145lavw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="XT/fCYaQ";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DEE9606A327;
	Mon, 23 Nov 2026 19:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XT/fCYaQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 424CB1F000D1;
	Mon, 23 Nov 2026 19:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795461024;
	bh=P7FDWnuntiypVaq18IX2yuHzG9oAyX3kKeY7z/oJ1wQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=XT/fCYaQIeezXNJfRxmj5ZGfuM1sBkL29bHYyq05kX05dI0+ZIiBUs4WbNcXBakM9
	 yc3dCKTPL1DsCUtjV7HkPHaMhAR6K1gvFezI3luPEuZNxNGPSapOlZ+/WsG5FbXuoe
	 9qlA3G1izaR/mm2uHFlFLaFd2r87AnCHaR4ncMsRyTRRFANGvab7iiw3uoOMMQz8IG
	 X26YqXK7mRE3vjePMGVT3mxD/wutlbgmOSQxr3FwvuxW6ZvKaFXRddQr2FroiyZPjy
	 ixdObuzqcdweDWZwcu7CCtLqYN9/6lhf5we/bU1PJa38rsKvSdcoppRJAxEuKkSOv8
	 DUvRGr0Vin9zw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3A2B3392EE35;
	Mon, 23 Nov 2026 19:10:24 +0000 (UTC)
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
Subject: Re: [PATCH] Bluetooth: RFCOMM: Fix slab-use-after-free in
 rfcomm_dev_add()
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <179546102276.3063022.6621548034236747071.git-patchwork-notify@kernel.org>
Date: Mon, 23 Nov 2026 19:10:22 +0000
References: <20261122-fix-rfcomm-dev-add-uaf-v1-1-cac5354752ed@gmail.com>
In-Reply-To: <20261122-fix-rfcomm-dev-add-uaf-v1-1-cac5354752ed@gmail.com>
To: Leicheng Xie <leicheng.dev@gmail.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com, gianluca@sottospazio.it,
 linux-bluetooth@vger.kernel.org,
 syzbot+11542ff1d167fdffa1fc@syzkaller.appspotmail.com, stable@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Sun, 22 Nov 2026 17:33:29 +0800 you wrote:
> From: Leicheng Xie <leicheng.dev@gmail.com>
> 
> __rfcomm_dev_add() inserts the newly allocated struct rfcomm_dev into
> rfcomm_dev_list and releases rfcomm_dev_lock while holding only the
> initial tty_port reference. Back in rfcomm_dev_add(), the device is
> registered with tty_port_register_device() and further initialized
> (dev->tty_dev assignment, reparenting, drvdata, sysfs attributes, and
> reading dev->id).
> 
> [...]

Here is the summary with links:
  - Bluetooth: RFCOMM: Fix slab-use-after-free in rfcomm_dev_add()
    https://git.kernel.org/bluetooth/bluetooth-next/c/cc0b0a62cbde

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


