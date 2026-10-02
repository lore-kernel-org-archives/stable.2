Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A8DD4F68DF;
	Fri,  2 Oct 2026 16:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790959210; cv=none; b=FtVHTNaKlzUZSFfyiYs5NtqbwDn23FRXYirL86aIRZ9DC63v+a3gIK/+8NXzqETCPvJ68gEr/BcyxQMuJyRgwr/H/jII0yR+C6d1aD1n5oGNl7o1TLxvEdL1F8fL3FopFAfR4KAJg7CTZlIZwfb5WAjcHcYy92/puo66ysISDY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790959210; c=relaxed/simple;
	bh=rU5+RR8WLDnzI9HYYWUZGjLsKQIDtw3Vpbo/f7hN6Rw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=c0YQpm2u0MVcbS7xgvvvv4KVFAk3cLtq+ER68XTMBwYrf9saEK2egNi2l5imZaRbwog2kSZOhr+FA5ITJ65UnnaPQicWy4gsIE+Zmmtmg4uNfyuZbVnnqVZDgHS7rppUcVylstCzIVQhM/Ky0lIEu7H4AfShPShkXlH0xK9D4H0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UpAzDP9R; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UpAzDP9R"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07E5E1F00893;
	Fri,  2 Oct 2026 16:40:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790959209;
	bh=t6xHMgdwBFAjGREex9403Fea2cHa/XbCZ6WoWG9ihuQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=UpAzDP9RMM0kfBH2odhLGoU0TlU8lP/qqRszZwR5id/fNKzTpKpm3HBF0/jILG8gx
	 /CwqJfCvce34TwjK55Otktq+EM6XtuMKL356ZB8K03JbJT88gfFEM1cRSUpgGmiEG0
	 MU8xgnAv4lv2P5U+b+YhXITQBAZH4KwUgjPBilA0CyHosfi/bAJ2tY8qhEK7sl7SFF
	 lc+Ft21Suoz78GBI9TqLJr+iO2VDejHcaXUP9Onk+1+54nnt9wtPGJzVH5HRZIpln5
	 IXCOa0PSITLygAhsxwUXA+HwfpZV7VihbxygZOwuWJFd/ZHuOsyrjFlDImKHFR4BIB
	 TB30kke/ph1SQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F15023811A65;
	Fri,  2 Oct 2026 16:40:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: RFCOMM: Fix NULL tty_dev dereference in
 rfcomm_dev_shutdown
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <179095920764.3497173.9577139976103551924.git-patchwork-notify@kernel.org>
Date: Fri, 02 Oct 2026 16:40:07 +0000
References: <20261002070752.84486-1-raghunathpalla.0209@gmail.com>
In-Reply-To: <20261002070752.84486-1-raghunathpalla.0209@gmail.com>
To: Palla Raghunath <raghunathpalla.0209@gmail.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com,
 linux-bluetooth@vger.kernel.org, luiz.von.dentz@intel.com,
 nicoyip.dev@gmail.com, gianluca@sottospazio.it, shuah@kernel.org,
 me@brighamcampbell.com, linux-kernel-mentees@lists.linux.dev,
 linux-kernel@vger.kernel.org,
 syzbot+4a807caf7680652d53b6@syzkaller.appspotmail.com, stable@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri,  2 Oct 2026 08:07:52 +0100 you wrote:
> syzbot hit a NULL pointer dereference in rfcomm_dev_shutdown() when an
> RFCOMM tty is closed.
> 
> rfcomm_dev_add() puts the new device on rfcomm_dev_list first and only
> then registers the tty device and saves it in dev->tty_dev. If that
> registration fails, dev->tty_dev is never set at all. The device can be
> looked up in the meantime, so an open() of /dev/rfcommN gets through
> rfcomm_tty_install() and attaches to it. When that tty is closed again,
> rfcomm_dev_shutdown() uses dev->tty_dev without checking it:
> 
> [...]

Here is the summary with links:
  - Bluetooth: RFCOMM: Fix NULL tty_dev dereference in rfcomm_dev_shutdown
    https://git.kernel.org/bluetooth/bluetooth-next/c/08e90633377f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


