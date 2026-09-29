Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEF1F3DA7F8;
	Tue, 29 Sep 2026 15:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790696409; cv=none; b=lZKr2Qtp9VBEEpCrjNOKvc0TDoDmsxNKq4znnsua/Um/wYA2dlGNMMcYWUsYVz0aaaDXhfZoyRjd2v+JrdmCzbxk1oqSEVkiexsHL2NWbSdqqr+zrJ7Jy18LMkio7crvWXQy093AKmA5rJFtfEnx9XMmQMCSJLFuZjpBaYowWcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790696409; c=relaxed/simple;
	bh=GSY0MLwhOKp54CZWhqu9DaMr1gjHIOaM1In3SvXhG/g=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=MWW5eaMbS59VWCoRqdVQIEhtXR64pwei7fVvtrCVPVisZjywqAY2dPURWkCH8+xBMFNoI24uxDdpF5hWDC/K/pzOljGxEAMoB0GxpXEiQW2Vv5xMBxbEnzHKk81Z1R3USnk5FQY8LbTCEYL5C31AiJQUzKlqorA5ZpD3TiJDjtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e8DL1JlY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e8DL1JlY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 454241F000FF;
	Tue, 29 Sep 2026 15:40:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790696407;
	bh=VqrhsOb2BGkK+de/uKR9CVB3GLg28KqdczJsX+zrXsI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=e8DL1JlYHbPOiSSicWpIyGCW1KuvBD5uZwWC/PBh2vV/0I/UDpYMkucrl6s1RgX5l
	 wBHiYdV/908C5svSov2YT4esdhg60u8Fgzr+a8IXJ6d02w8qyU6ZjzI8iK1aemvq/9
	 kSdCYy7Sd0ztfVdM/OavNniE3hUp/T/u4JnZ6wacnsEacaPmKBApXJ1Nwxk9djKX+c
	 vR5vmGpSIHTpY5OdEbVvnUg5r4AHHzbd4YjIywW1G1ZdLtKmR250CPzbXUHkWxfkVR
	 0NkZYbYB2s/aEwy2vSXWyN+yasjp9myxTeysB7+XMXzNRDebSjCyadGlj7fngXuVXJ
	 W4UzwpAUMvmdg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3A42A3927058;
	Tue, 29 Sep 2026 15:40:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: btusb: drop BROKEN_EXT_SCAN quirk for
 0bda:a728
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <179069640603.997963.8086437204230046339.git-patchwork-notify@kernel.org>
Date: Tue, 29 Sep 2026 15:40:06 +0000
References: <20260920020227.709800-1-junjie.cao@intel.com>
In-Reply-To: <20260920020227.709800-1-junjie.cao@intel.com>
To: Junjie Cao <junjie.cao@intel.com>
Cc: luiz.dentz@gmail.com, marcel@holtmann.org, andrew.tsvetinskiy@gmail.com,
 kserwus@gmail.com, alexej@sidorenko.cz, regressions@leemhuis.info,
 linux-bluetooth@vger.kernel.org, regressions@lists.linux.dev,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Sun, 20 Sep 2026 10:02:27 +0800 you wrote:
> Commit 5ead2063611a ("Bluetooth: btrtl: fix RTL8761B/BU broken LE
> extended scan") set HCI_QUIRK_BROKEN_EXT_SCAN on every RTL8761B, and
> commit ca0583c24661 ("Bluetooth: btusb: limit RTL8761B BROKEN_EXT_SCAN
> quirk to 0bda:a728") kept it on 0bda:a728 on the assumption that the
> USB id separates dongles with broken extended scan from those with a
> broken legacy scan path. It does not. An 0bda:a728 unit (RTL8761BUV,
> fw 0xdfc6d922) on 6.18.51 fails the same way the UB500 and 0bda:8771
> did: LE Set Scan Enable (0x200c) times out with -110 and btusb resets
> the device. With the flag removed from the table entry, scanning works
> on that unit.
> 
> [...]

Here is the summary with links:
  - Bluetooth: btusb: drop BROKEN_EXT_SCAN quirk for 0bda:a728
    https://git.kernel.org/bluetooth/bluetooth-next/c/fdd5964bd389

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


