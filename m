Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89AB433BBD7;
	Mon, 22 Jun 2026 17:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782147636; cv=none; b=TulyItielkWLXrl5qSosozndh+jqd3zeqcFif9Dy5nt8qbreD8bMcWoJnjggwvu4yGFVY0SZBoP3O/U34af6c1tGc106wPlNdJdTFprPVta+VUQ9ukCDwwLIgmw7P4qugkqHI7RftLdzR/P3Ne5kSjmHxKRD0irBDjf3E1THqWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782147636; c=relaxed/simple;
	bh=uawZCU4dKRwJpV8SxDfmjaHFYaTJIM5AyoQPv1Ujphc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=QkbJIC9CqvZ6CJi4HQUoOrJ2bxxbh+5zxhyh0odLfE5qGtMK0r1pdVrZ6X4/IxNMe4mwjqDo51upSQuQt4psoaaMRoz28p5fJ8IEAy70j/9A7rm8B3Tz09pXy/KC2AG3o7IId6u4ALJ3pdWJIMN+zIZBFVBfAyNEdG/UHHpVLNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WHCmZJm8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WHCmZJm8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D0E21F000E9;
	Mon, 22 Jun 2026 17:00:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782147635;
	bh=71dBz+bpiTgHoc2XULs4mRyX7MFma4xtldFQ8t9msFw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=WHCmZJm8kTypjIqQUnliHC4pvyDknYZxznA17Sh6Oi3JrlOg6HsJijlEBNEIwrQJv
	 aebWqM6eKtk6apNSuZ5r1OCivaNP+IkAQiPzrr5O2SbCW7UV8d6ErpYm1Fe84e3vTA
	 +oaiImeflI7mOqdusEj4tZXYr5xZSv4mmphRDywcPsV4JO0HUI1v4vBg1ry1BmpyTv
	 RnDCgxqM24yqA47194c58pj3ryLPjwIEr69hN7fAwjkGPUqBuVk/1l6bLAW10P+7dm
	 PwRtqLMqNY1zkOIPbEkW9jSyo7tvwMwzvfni2JcxchbM00oSUh8rc4f9klp7KLGtdF
	 x6SVGZ14LwE4Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D09E73930917;
	Mon, 22 Jun 2026 17:00:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: ISO: avoid NULL deref of conn in
 iso_conn_big_sync()
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178214762553.1322955.9611658441298431960.git-patchwork-notify@kernel.org>
Date: Mon, 22 Jun 2026 17:00:25 +0000
References: <20260621162305.219763-1-meatuni001@gmail.com>
In-Reply-To: <20260621162305.219763-1-meatuni001@gmail.com>
To: Muhammad Bilal <meatuni001@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 marcel@holtmann.org, luiz.dentz@gmail.com, iulia.tanasescu@nxp.com,
 stable@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Sun, 21 Jun 2026 21:23:05 +0500 you wrote:
> iso_conn_big_sync() drops the socket lock to call hci_get_route() and
> then re-acquires it, but dereferences iso_pi(sk)->conn->hcon afterwards
> without re-checking that conn is still valid.
> 
> While the lock is dropped, the connection can be torn down under the
> same socket lock: iso_disconn_cfm() -> iso_conn_del() -> iso_chan_del()
> sets iso_pi(sk)->conn to NULL (and the broadcast teardown path can also
> clear conn->hcon on its own). When iso_conn_big_sync() re-acquires the
> lock and reads conn->hcon, conn may be NULL, causing a NULL pointer
> dereference (hcon is the first member of struct iso_conn).
> 
> [...]

Here is the summary with links:
  - Bluetooth: ISO: avoid NULL deref of conn in iso_conn_big_sync()
    https://git.kernel.org/bluetooth/bluetooth-next/c/a0ac2b200be1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


