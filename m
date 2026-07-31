Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 060BB47D928;
	Fri, 31 Jul 2026 18:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785523845; cv=none; b=JTxO1uLgUdSfYnLHE2KMnreyNzppzBnmJCgZrAj2/qE0QEySATV15l0fTgzIC0tRpT6roAZGWj4gtpVqCXavn6QzFKvqYtj6qr3RgWwBqfnoF3ecjee6rbpcQV7Y7N2hfbzLiGuWfI39fCHRXA99GG/Mrx24/pyaR1pkOS5KkpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785523845; c=relaxed/simple;
	bh=PWIqd2YTUg+l6Ueoo9ANSuACuGX4ypO+X3B0RR8HKuI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=AMpjpJZivZt7WrBfYkylr0EUNJY58HpRjg2HqNBZYUxYXPul7TBPZg5VC84MZTjAGXuVJ+DcToxeakLLLXZtZko3szKjGNAd8/f/o3QazP9a9JDAcl5+L5CPG5+R5faBIGVQMXv1j31r/1bFXocd8PsB6Zzuw9uVm0Zx6brEeNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XKgLNVzT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XKgLNVzT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FDC01F00AC4;
	Fri, 31 Jul 2026 18:50:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785523843;
	bh=3B4Y/x0m8unUhd8sEdVQNTYzpCKo1fvByEBPLPVZCsg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=XKgLNVzTnbeod3gYaWN6bEsgWEk6NUX7yadwVQfDN7LPrNQmijilQtfkuuv0eUuVT
	 Ci9w7PC5DA+GmcaIUea3YmHI5V/aIgVySNPgjV64ftJXt7L4rUwuqFa/172UtkRlzF
	 2ZsuMlUJyHmuUPOqYWy+KQtaLcRqtOsgZa8DZVCBGQ3iXnmd77kICwc9O56HR1W508
	 bX/SFP874YcB9k4HKbvU1dDhK3370ydSXu8zo8q23X4L7oeoVYwwFfgiZJAPj/zXSx
	 sNZ/QH7UQCHqV1oMv6NCfH6ZKcbMmUVtF3pGgFYlOUHZbmWWv714Rvc7LgMFaKoQhP
	 4u1Tl7ggrRLHg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 938ED39263BC;
	Fri, 31 Jul 2026 18:50:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: hci_event: fix LE list UAF on reset
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178552380614.861446.15530207520125767511.git-patchwork-notify@kernel.org>
Date: Fri, 31 Jul 2026 18:50:06 +0000
References: <20260730083202.2065336-1-nicoyip.dev@gmail.com>
In-Reply-To: <20260730083202.2065336-1-nicoyip.dev@gmail.com>
To: Chengfeng Ye <nicoyip.dev@gmail.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com, johan.hedberg@intel.com,
 ankit.p.navik@intel.com, linux-bluetooth@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 30 Jul 2026 16:32:02 +0800 you wrote:
> hci_cc_reset() clears the LE accept and resolving lists without taking
> hdev->lock. Other command-complete handlers serialize updates to these
> lists with that lock, and the debugfs readers hold it while walking them.
> 
> This permits the reset completion and a debugfs read to interleave as
> follows:
> 
> [...]

Here is the summary with links:
  - Bluetooth: hci_event: fix LE list UAF on reset
    https://git.kernel.org/bluetooth/bluetooth-next/c/58356452043e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


