Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58CA046C847;
	Mon, 24 Aug 2026 16:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787590264; cv=none; b=UoxQ2PYUvxHDVMt4BdcILStRwTrxXanzZGI/82pZNGN/8ZPCG/D9PHx4aukKViBiyCN8nH+pz8eOhwkp9HZDYBBX+otn/W5rZZaMsN03fKWSxrZXgffuFxLe4/WCj7BmqPWsAgDRQT8zdYZTH1oUnOZ/uOgSLU4dT+MQIIZ3lII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787590264; c=relaxed/simple;
	bh=SXsX/EIm3gnCBZwNm6uHPm8S2fRnNY3XmvWqWnfj3xM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=FugYWMIyi79lkHyXXmsx2q1IkNfMjUmhBB17kiBGxhTxYysC1yGfLDvH+N2tW3iUznHlEZ0G5p+2/VyOQtxT8NXiHYYs6p/Di2yUOwiNrR/Xf5YdsEm6o1ixEzMFvJEBiQg1END+urGiaOyyydkDkmabp0n1cu7u5QpSk8+4QNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i177Ruln; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i177Ruln"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51FEA1F00A3A;
	Mon, 24 Aug 2026 16:51:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787590261;
	bh=dcJ9eGwTufyPuZGfIoQs/6brY3popS9qR1vvr2CuF3I=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=i177Ruln1SVmgiBGBCI+6mMAQHsY2sK43iWwjfCXg2ZIakEe+c/fn+AhwWWMYMee3
	 dTV94GcADDlwGUQrN1Ip9wCQvhvH76T/VzToNjL0KQXZtLeBNjAMPmXP3cRO9m8MHv
	 g4OToweKDl1e2tGXuf8hPoHo+gYIVo65gHWpQw8oHhxwIrGKdZbH6uyCpGcaW7FAQr
	 PYrast+V1hQLB+8sb2v7E7POriX19Q91/WR3ehq+SWs4XkhfVnFKGetDYWHLDVYsSW
	 fioOAQansQRyAEAZRwUTktusssAvMlbKXr2t1wfDcpVCVsVP6CZ7THW9apjh5Tbp1c
	 /PiFI740FkaBg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 198303924478;
	Mon, 24 Aug 2026 16:50:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: btusb: limit RTL8761B BROKEN_EXT_SCAN quirk to
 0bda:a728
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178759020863.3014491.13354284194463299863.git-patchwork-notify@kernel.org>
Date: Mon, 24 Aug 2026 16:50:08 +0000
References: <20260824053227.317496-1-junjie.cao@intel.com>
In-Reply-To: <20260824053227.317496-1-junjie.cao@intel.com>
To: Junjie Cao <junjie.cao@intel.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 alexej@sidorenko.cz, regressions@lists.linux.dev, sashal@kernel.org,
 stable@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 24 Aug 2026 13:32:27 +0800 you wrote:
> Commit 5ead2063611a ("Bluetooth: btrtl: fix RTL8761B/BU broken LE
> extended scan") set HCI_QUIRK_BROKEN_EXT_SCAN for every CHIP_ID_8761B
> device to cure repeated 0x2042 failures on an 0bda:a728 dongle. The
> brokenness is per-dongle, not per-chip: on a TP-Link UB500 (2357:0604,
> RTL8761BU, fw 0xdfc6d922) extended scan works, and the legacy scan
> path the quirk forces is what is broken -- LE Set Scan Enable (0x200c)
> times out with -110 about 30 s after firmware load, btusb resets the
> device, and the adapter re-enumerates in an endless loop (382 firmware
> reloads in one boot). 7.1.8, which predates the stable backport, runs
> clean on this unit; 7.1.9 loops.
> 
> [...]

Here is the summary with links:
  - Bluetooth: btusb: limit RTL8761B BROKEN_EXT_SCAN quirk to 0bda:a728
    https://git.kernel.org/bluetooth/bluetooth-next/c/0c9d2588a514

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


