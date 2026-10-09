Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B79944E50D4;
	Fri,  9 Oct 2026 14:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791555625; cv=none; b=KEdOLdpnkRd7LiKNG8zc9Gm6Ro6tR1tjkUCfP6K450J96RP2GPOPwAVh5FS45LLH08i4Q6qq653eXaeG6moKbqV0UKQ1PJ7zVaPaDgULLJ8tCPZHaba7aN7ZJiMUJRalHXVc8W/ayUOwbXH8YXWWdw4lE7HZWTAe4Tgs+bnzV3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791555625; c=relaxed/simple;
	bh=jgrQTMRQ0unq2toGPHoebilsSlx4ybwMtMaMTssnMDs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=OSBd8+AUbxARoPQ8g3+GQqgsRH1R2dMWX2ZjFlbFGA8OStJr4z4IRGVsQ0Y3pCX1j4RiRpd4H3xZ6K68x92DkHEoCe09gjivwD599KvGIozxmfgDRRrglw9RgdTcGXaLFmKbOgakVF577gkS28Urlu1GKD7Vq8hNoVmmHJfBaNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ixsi8w8n; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ixsi8w8n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 819971F000FF;
	Fri,  9 Oct 2026 14:20:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791555616;
	bh=D6kJidk7FTb9r8BlcxtB4jKSucroK1qPJhdHqNnFsmU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Ixsi8w8nI2uGNANx3SkRN7yEV8kkIXLiHJpAzQSgdXvProZhLdqE7Ej18JVw2caEE
	 3Fw8efW5P/Zg6taPC1twkA5f5n2wGpsw5gB6iYgpNES27EeGZeYV8R7SSI0THtJSBb
	 vStth8kOwOhcouZ8Yiw5LITG1GYIC87b7hsZ7E1QHSULCH0RV2FAFJuJg6dh9HE3cn
	 9Co3ZW2yxXZryjJIo/Z3xEJg01hv2uqyplKDsGJPFK8ViEXxJU+1Zf7VMmBMECAP4+
	 ooxcj3pG4E6e9HesedHauAqlJ9B+/Yr8Hb6embEmOUwuiYJBDnaketsSOtO+zbmXEM
	 NYgqxVRc78rmQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 772BB39253CC;
	Fri,  9 Oct 2026 14:20:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: selftest: Pin module for selftest debugfs file
 operations
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <179155561501.812174.1610963869730671308.git-patchwork-notify@kernel.org>
Date: Fri, 09 Oct 2026 14:20:15 +0000
References: <20261008051803.526248-1-dungvn2345@gmail.com>
In-Reply-To: <20261008051803.526248-1-dungvn2345@gmail.com>
To: Bui Viet Dung <dungvn2345@gmail.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu,  8 Oct 2026 12:18:03 +0700 you wrote:
> An open debugfs file retains its file_operations pointer in the
> debugfs proxy state. However, test_smp_fops in net/bluetooth/smp.c and
> test_ecdh_fops in net/bluetooth/selftest.c have no .owner set to
> THIS_MODULE.
> 
> As a result, full_proxy_open_regular() calls fops_get() which succeeds
> without taking a reference to the bluetooth module. When CONFIG_BT=m
> and selftests are enabled, a userspace process can open either
> /sys/kernel/debug/bluetooth/selftest_smp or
> /sys/kernel/debug/bluetooth/selftest_ecdh and keep the file descriptor
> open while the module is unloaded (rmmod bluetooth).
> 
> [...]

Here is the summary with links:
  - Bluetooth: selftest: Pin module for selftest debugfs file operations
    https://git.kernel.org/bluetooth/bluetooth-next/c/839c7cdc250c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


