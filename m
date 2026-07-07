Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 909BF35898;
	Tue,  7 Jul 2026 17:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783445427; cv=none; b=DtsDfYvu4vM5z3in3RE65ah1SWSSZFuNnYwj9wfJcjCsQaTJVT7OmcucV/S4aEoPm+4ua5Jwprz2wnbPXZVjiNkgecDLBwexNJekmRGw3Lvi8nErUdmhv5slMIOVk3YPe0XUL3i8ha90NqfMGI2oxuo7BwXXrwTagwmgTOMqQuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783445427; c=relaxed/simple;
	bh=pjSbzPfqWWlibgOXumm1uZESRU4gCOOGC/F/fhF+FVw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=g8Zq7Y5ddBVtM+RFi4rJP1V/AJf7XeKBjsan218e6Sd+7Zt0Oh4z2wd3FfDFWZ8e/jmRJg2bB4765+eOzCIZwPxqJRcuWU0NjHu5veoyQRazXEoR0f0YaDu+kUnYmlx2R4fmeJmINv5MEjXPr2OBm1wXMJRWCbxJTdUg8ZVZTr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LMm9uCmj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LMm9uCmj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E2E81F000E9;
	Tue,  7 Jul 2026 17:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783445426;
	bh=yTxPIBxBTCojvF3ySohbMmEX4VHb0ZBBPu2wZmzCFfA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=LMm9uCmjYifAUG+T0OqOSTZlaKFywSs+ZL1sbZvfOgv0qtybBlAxyjk2QNfp7qvjX
	 yr4TYlapO24xpnQmtIrhz4DiuWudzVZ3Xgie4fU0/tDvFOSvQ2SVHWaWRnFr8k8/wJ
	 TX0X89eptkQYBMj4Hr1PDhandJOSNH4cBBqneHbJQKFlTkCQIN+YEUQ6wgHDAIvIS0
	 Y7TZGQgnaaFNRiqny6m+o+BUKthaJ7v+qjY2gzVE84gtOUrwesAKc8u03RexhrCwUF
	 FcgRezRWl+PBb6sDb2/M4pxHrUNar8sdidwm5BfTllhtCz3eRzPoftqMd87v583IK7
	 i1qVvP4jzmoBw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 568D039253FD;
	Tue,  7 Jul 2026 17:30:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: btusb: Add ASUS USB-BT540 and USB-BT600 for
 Realtek 8761CU
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178344540614.2101608.6818912304609485751.git-patchwork-notify@kernel.org>
Date: Tue, 07 Jul 2026 17:30:06 +0000
References: <20260704231312.340274-1-cito@online.de>
In-Reply-To: <20260704231312.340274-1-cito@online.de>
To: None <cito@online.de>
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
 luiz.dentz@gmail.com, linux-kernel@vger.kernel.org, stable@vger.kernel.org

Hello:

This series was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Sun,  5 Jul 2026 01:13:12 +0200 you wrote:
> From: Christoph Zwerschke <cito@online.de>
> 
> Add the vendor/product IDs (0x0b05, 0x1bef) and (0x0b05, 0x1d70) to the
> usb_device_id table for the Realtek RTL8761CU-based ASUS USB-BT540 and
> USB-BT600 adapters. Both bind via the generic Bluetooth class today, so
> BTUSB_REALTEK is never set and the rtl8761cu firmware is not loaded,
> leaving the controller non-functional. With the entries the driver loads
> rtl_bt/rtl8761cu_fw.bin (already shipped by linux-firmware) and the
> adapters work (tested: A2DP and ASHA).
> 
> [...]

Here is the summary with links:
  - Bluetooth: btusb: Add ASUS USB-BT540 and USB-BT600 for Realtek 8761CU
    (no matching commit)
  - [v2,2/2] Bluetooth: btusb: Add ASUS USB-BT600 for Realtek 8761CU
    https://git.kernel.org/bluetooth/bluetooth-next/c/3928fa44107d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


