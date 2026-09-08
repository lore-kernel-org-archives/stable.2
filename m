Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3711584950;
	Tue,  8 Sep 2026 16:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788885095; cv=none; b=uifZ5iLjPO5pDYa2fY6yixnUD5X+hO5neM76SkE7m0neZXgGNKIa/5BolaecnxxnOdDAQ1CXZEn/k5BEJYi1yVME45cJaFiciFvDWKaUCc1CJCRKkccGYuxbV8AGC+aOoK1RgGA3fy49Zf2rAyuPIQ/FFV2YtUXN9ulrEi5yE3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788885095; c=relaxed/simple;
	bh=6YdikH69pDVCDQRGZNlif1fc6llKfnOJnag9WU+oYw0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=vGhYYn5H4lcRrhfso+AKMHW8/qfEcBC6/hhoZtEXYpCv4vYZ+jkqGyoAztS6pdo9itgXTAoTJz2B9Zqhowoo8FPrQzYAOuvVGn+NV1e3oDqKZt2M4owbcPUHj41tiScIYn+YKa0stCxUG0aGC4YFMHBBWRvRa28txrr8irk5Wyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IbEWVLZo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IbEWVLZo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDD421F00A3D;
	Tue,  8 Sep 2026 16:31:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788885092;
	bh=L6ETMy1hFkoiR6zVprxkJPZ8mYcnoca35fwVV/7h1ro=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=IbEWVLZovFidHQqTocXFv1qY4a93AEk5lCbHtQp8W80mxy0tmuICXupoFif9TC9fs
	 6PgqdOoHaqO4EI0ln6qT9stH37Ne3YwoSaY6/qmCjHcgD9W4oqPUW1lA0kbtQiDZP8
	 5nucvMZtJ/lmbAY9Cp0ulnvK//6y5ipQb9TPOitf2rqHLZwRgLsnf2m5lKf5RZj1Dd
	 5jM1Ax9H4ngFO7UC/6lpjdesICJUJaFWlGBci2yRlW/3w5IC3C+6yq76n9Vx5jD+AW
	 cm+FEHnWzrpVHg0nIcei8fPe6MPx0vyB66yHgvimzhzyqGqB3o206QdSPwh4JLhx5h
	 OYHm8BIyDCt2A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 939AF39EAF6D;
	Tue,  8 Sep 2026 16:30:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: btusb: fix NXP IW610 composite device handling
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178888503113.3627954.15907243154963861505.git-patchwork-notify@kernel.org>
Date: Tue, 08 Sep 2026 16:30:31 +0000
References: <20260908080108.1260799-1-nithibert@gmail.com>
In-Reply-To: <20260908080108.1260799-1-nithibert@gmail.com>
To: Nicolas Thibert <nithibert@gmail.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue,  8 Sep 2026 10:01:08 +0200 you wrote:
> The NXP IW610 module exposes itself as a composite USB device
> (0471:0215) with three interfaces: two real Bluetooth HCI interfaces
> (class 0xe0) and one vendor-specific WiFi interface (class 0xff) used
> by mwifiex-nxp.
> 
> The composite device's whole USB descriptor reports class 0xe0/01/01
> (Bluetooth), so btusb_table's generic USB_DEVICE_INFO(0xe0, 0x01, 0x01)
> entry matches every interface, not just the two real HCI ones -- btusb
> ends up binding the WiFi interface too, and mwifiex-nxp never gets it.
> 
> [...]

Here is the summary with links:
  - Bluetooth: btusb: fix NXP IW610 composite device handling
    https://git.kernel.org/bluetooth/bluetooth-next/c/bd5e3aa5d35a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


