Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 018201FA272;
	Thu, 15 Oct 2026 13:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792071609; cv=none; b=OfTrHDgdTNZyBk8iyrsA4AhlH6rAF5dtdtoCodzp1vZMcJuUVaIUlgRkZFB6zo1LB5D2tlGftw9Z4Nlj2muS/r8BIJM/I8J6uR62ZjEA7MELjxY8XQZ3Gnp6o849hkmHbmkbgpVd0LwKTW4L4FqWo/W+osETcDVXF0xcffk/3tY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792071609; c=relaxed/simple;
	bh=k4mM2IDQkXDme11YcBwJHpfnj2VVZBVHkpp151CHt+U=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=JrLgpr2A3Pa2wZAfqEihz2xmpuf2r7KcjUo1kw8DjZvfw/f0rWoVds5UJGCtuCtCRJ9e+zQRZPl+4YfhSqzwoXzqIBefrNQoZSrsyjHaGmwZVF2XfklmxwSW7/yYbPWq7cGk4aXqSQZcArDWx/WuIm7jAolmYJCDEjrY5NrCsCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gFxxw6Rt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gFxxw6Rt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FF831F000C4;
	Thu, 15 Oct 2026 13:40:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792071607;
	bh=jjDER0mNzeDQlHOZq2YsXBJeSiABiPoqbl4QA16CmQQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=gFxxw6Rte22sXL9wdlxA7gjXLqnpMBLvncS8P/fNkE7IM51rr6O1VzjVHGBzFI2Cs
	 jiIiiUakpo/D7r7GgeJ191n/3iO/BjqIuUy367qNioVy+OhkBtYBObM7TewPQ4HpmW
	 vG6qPMYlmh/Pov9jO75HM9DOzOqGOh0leeLu761+7gqUh1nn3Oab0YyQxAaOfQPJHy
	 miWoaTyyTHbUe9+sKf77HT3wWyDdE9Jbz2gO3r7+2/lTlEVAoakIw5P7x4R2Tfz3OJ
	 FgaIbKo+6lvNHSRl5UmxkHEws2E+FDILH1iWNMmvkveUixnLVgfZz4aPLLVu1yl5P+
	 6747IaAPR/F3g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7756B392EB04;
	Thu, 15 Oct 2026 13:40:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4 1/3] Bluetooth: btintel_pcie: Add initial YoYo debug
 support
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <179207160627.3441573.10441193801394049903.git-patchwork-notify@kernel.org>
Date: Thu, 15 Oct 2026 13:40:06 +0000
References: <20261015115431.27456-1-ajay.k.v@intel.com>
In-Reply-To: <20261015115431.27456-1-ajay.k.v@intel.com>
To: Ajay KV <ajay.k.v@intel.com>
Cc: linux-bluetooth@vger.kernel.org, chandrashekar.devegowda@intel.com,
 kiran.k@intel.com, linux-kernel@vger.kernel.org, luiz.dentz@gmail.com,
 marcel@holtmann.org, stable@vger.kernel.org,
 chethan.tumkur.narayan@intel.com, lakshmipathi.k@intel.com

Hello:

This series was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 15 Oct 2026 14:54:29 +0300 you wrote:
> From: Ajaykv <ajay.k.v@intel.com>
> 
> Add an optional YoYo firmware configuration path to the Intel PCIe
> Bluetooth driver. Read DBG_PATH and ENABLE_INI from
> ibt_bt_dbg_cfg.ini, and load intel/ibt_debug_yoyo.bin only when YoYo
> is enabled and host DRAM routing is selected.
> 
> [...]

Here is the summary with links:
  - [v4,1/3] Bluetooth: btintel_pcie: Add initial YoYo debug support
    (no matching commit)
  - [v4,2/3] Bluetooth: btintel_pcie: Validate the YoYo DEBUG_INFO TLV
    https://git.kernel.org/bluetooth/bluetooth-next/c/d52ecdd482cf
  - [v4,3/3] Bluetooth: btintel_pcie: Configure YoYo DBGC buffer allocations
    https://git.kernel.org/bluetooth/bluetooth-next/c/ff8b09806b7b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


