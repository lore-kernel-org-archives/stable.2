Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16B25370AD0;
	Tue,  7 Jul 2026 17:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783445429; cv=none; b=CX1y8rnaV2qYMUwcOLUTdLkgzlb6IGxQZw697UrYTWpZIU+WymOAV36jyZX1nvuf1of6UQm278TPAXtAXhkHGnn45AuE+458pGdDPhR0v0bYPNYEgFESAszcrbfr2xoQhlfXS/x3fL/757VdvvbTfri844lESvUZTKROP9svoUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783445429; c=relaxed/simple;
	bh=+5hkn1DNH+9o5vT1CMQriWiVQi+EvM/8BswFVubJLPs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=uICeWTUlxwvQ9+kYvMv06aU5V55xXjGuPsN+B0X93XVSOMbE+n0QI73eiJMZixLLwlhCxV4qXK27fi2cjZxGm+kHqqVYz2Vy0qJZSiH0LkAqqEJyO6DJX6PoMJxC+MnaTcl3nO4pVrPgUgBZSVlL1M6G/MxF61cWIwyzQe/enFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YKsMQzhL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YKsMQzhL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C65601F000E9;
	Tue,  7 Jul 2026 17:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783445427;
	bh=asVWZ4aalKCMP99zfcOYH8lI/PLIrSY5HSZ1HBEKecM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=YKsMQzhL1uDB1Dj7qTFFJLH67NRk6myKsjG4MJyiJ6Z1pYvQzBrFhMMPQ6dALyrNj
	 PwCfLBf+W3vRTpXOspe4iXWK+m3z+o6HEmRAmKiZ67WnSCEhwfAwUh+HkVl6EXDSXF
	 nM0xCBBjP7Pt7ODng6vYwpn53wN5IF5EZI/GTn8IgVmQvnBjrjZryB70+mJJLYLCVR
	 u7Rjmo5TNfwgRqbn2HtbxNoEyquVRaRL5HZtMak9rbYJKdsoUvg/Hu5I/OwXWZWpUy
	 ty69ng8+1zJ2v9Wx/6dZdGU0bmou0gEEX44PQPrjq+fhag/JYBoJMvaJfRwppzjf7l
	 zYE0g6nqX9wrg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0C5C39253FD;
	Tue,  7 Jul 2026 17:30:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 1/2] Bluetooth: btusb: Add ASUS USB-BT540 for Realtek
 8761CU
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178344540738.2101608.3736686961465718656.git-patchwork-notify@kernel.org>
Date: Tue, 07 Jul 2026 17:30:07 +0000
References: <20260705092857.27050-2-cito@online.de>
In-Reply-To: <20260705092857.27050-2-cito@online.de>
To: None <cito@online.de>
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
 luiz.dentz@gmail.com, linux-kernel@vger.kernel.org, stable@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Sun,  5 Jul 2026 11:28:56 +0200 you wrote:
> From: Christoph Zwerschke <cito@online.de>
> 
> Add the vendor/product ID (0x0b05, 0x1bef) to the usb_device_id table for
> the Realtek RTL8761CU-based ASUS USB-BT540 adapter. It binds via the
> generic Bluetooth class today, so BTUSB_REALTEK is never set and the
> rtl8761cu firmware is not loaded, leaving the controller non-functional.
> With the entry the driver loads rtl_bt/rtl8761cu_fw.bin (already shipped by
> linux-firmware) and the adapter works (tested: A2DP and ASHA).
> 
> [...]

Here is the summary with links:
  - [v2,1/2] Bluetooth: btusb: Add ASUS USB-BT540 for Realtek 8761CU
    https://git.kernel.org/bluetooth/bluetooth-next/c/babd12cf40c8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


