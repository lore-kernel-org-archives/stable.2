Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5135F38AC88;
	Fri, 24 Jul 2026 19:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784919667; cv=none; b=VHelSVvnTNucr6SkpeJpBJrm+iHmJ20LoK7olSFB3i/Be9Fz+uLOhLHLWnrAcHpS2QD0wQFBf6DjI9pRZ3dF4MwFkdTVILAT/Hb0194W4pyrIWwRqHW9ZVIms4647dWk+VNvNv6zulPqkc1Kq9HCE7h05uAGJi8sL4pkvpaSm00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784919667; c=relaxed/simple;
	bh=xrDbTGv1EWv7C51I2Ll4IhGEO0hVf5Z7CK7wxQQcF40=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=vDuuWXIYGyLOlSclZ5R1jBPKsiL53p/0HcWsklsGVwhpm2h7V72+S7gBsfuwIc5AMy2quyMjdyWFAKHdgCgD1zVTut1v09rp5pf8nWYHGpj058MhwnhRBFHxlTNLtD618o33Ri/H1YjA5sRUiUKUJdjO5cjHuwJcmVBVZFr+EH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PBfG0z1F; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PBfG0z1F"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6DC81F00AC4;
	Fri, 24 Jul 2026 19:00:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784919641;
	bh=rLnMwrKlkJ7OoHLZ9KlvG0ID44hT+7mcFW57oGMoM0A=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=PBfG0z1Fq0kGgjal4hoKpYItmit66z054B+xqMIM3LIsswABZBEoQksnkz0I++J+w
	 MCP5tpwKO0k6y1/VY0xNJ92dBhBHsdCSv3mvXyJb3bVa0XN/ErbwWEeZQBKGvOpV2h
	 tw7V1rHNZr2Uj6KFEMyBZRw2OcmJEaHqJFD+jNT/ODtQWWuMyOMgXhWHTzYB4P8uaQ
	 9eohSHW+3FwfihxihXpQdh1Jw8oBnE0iw5ANBOrallKq8544aMQjArzHPjwPoA/8fN
	 dNHIqq4vlmQOw7W4tAhyyH7m/4KOyBiqgoNxoiBJ7EGWqJGglzCJeHosm3uUtCuu/7
	 NBKDSVXNhSB0g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 56958380CEF6;
	Fri, 24 Jul 2026 19:00:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 0/2] Bluetooth: HIDP: validate short receive frames
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178491960889.3273549.17393254757476094302.git-patchwork-notify@kernel.org>
Date: Fri, 24 Jul 2026 19:00:08 +0000
References: <20260723032807.1616487-1-kudo3228@gmail.com>
In-Reply-To: <20260723032807.1616487-1-kudo3228@gmail.com>
To: Sangho Lee <kudo3228@gmail.com>
Cc: luiz.dentz@gmail.com, marcel@holtmann.org,
 linux-bluetooth@vger.kernel.org, jikos@kernel.org, alan@signal11.us,
 padovan@profusion.mobi, linux-kernel@vger.kernel.org, stable@vger.kernel.org

Hello:

This series was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 23 Jul 2026 12:28:05 +0900 you wrote:
> The HIDP control and interrupt receive paths assume that every L2CAP SDU
> contains a transaction header. The raw-report return path also assumes that
> a numbered DATA response contains a report ID. Both assumptions allow a
> connected peer to make HIDP consume data beyond the logical skb boundary.
> 
> The tests used two BlueZ 5.87 btvirt BR/EDR controllers, real L2CAP PSM
> 0x11/0x13 channels, HIDPCONNADD, and HIDIOCGFEATURE on bluetooth.git at
> df541cd485ff. The series also applies without changes to bluetooth-next at
> 6f55ad8fb0ac.
> 
> [...]

Here is the summary with links:
  - [1/2] Bluetooth: HIDP: reject frames without a transaction header
    https://git.kernel.org/bluetooth/bluetooth-next/c/678c435909f2
  - [2/2] Bluetooth: HIDP: validate numbered report payloads
    https://git.kernel.org/bluetooth/bluetooth-next/c/883532b7d4eb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


