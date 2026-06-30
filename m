Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88DCC47AF6F;
	Tue, 30 Jun 2026 20:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782851572; cv=none; b=gaft8LZsds1CyQ8IAFpw1UzK/Elqkh3oWYgnbrf6xrW9NB8lstAxBbst36ZyCk4PgYgV11Zjih4H3Ejj0PCi3GmWd9M6XSHsVDthgZm/YRFIMPoMf7uPXAdGKwgTZJRwgL4x9j619N7Gt7su/7g2xjBGVcvUPEMUKG4vmtXsZSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782851572; c=relaxed/simple;
	bh=FLjrl7czaG4FfZ/yByaab4DhVMLtckgWxxVurMT0haE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=d/GFiaF/lu6wj02m42xuPZIpjqIW3MCTxqSJ2bXfqJocjD/bfcQ2GGz/A3CLrKYI5GUpcQRbkBfU8/3elMCT69C/TNkHdoTZwpckeXOEe2jsVEWdh+v53DoI4PnqMrUZE45tCi6/7mmCmLSJWrgpiH/87BE6O90e6hrjGkuk/W8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e32DL/vx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e32DL/vx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33BF21F000E9;
	Tue, 30 Jun 2026 20:32:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782851571;
	bh=xfw3ezIWzpDKuqA9gNKODmNxB7jhAnIOXzwGIeBOwIo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=e32DL/vxmT/1au2oHbHO7HiwryYow707JyWXPlbzkLj37hhZmggwFKYxbL9Ca+xPE
	 5Mxp4Qn9xEVjNvjU+p+Td71aCiMVZhNk+xtaej30GdsVs1+mfCYJSXvj4hI1WlKV08
	 ANxOkQFs3CrVXbE4S0nfM9uhA6bw87YfY13XlyV9MUNjValMw8OhhWlQLdKBN0Z8y0
	 S6/h4+T9a00C+6uMhZwMTJQbzUc3cM3h+JYOMh+/5l5Pa+MNea3Ad/pFMF6+dRpqrv
	 qCgxA5YBHgY+IspywzDkOo6bFfaQDEvO99mfLGDcyeRuJcY7rQatns0zXf3IZGLjGf
	 OEJDVPAWo7T1Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 5692C393A951;
	Tue, 30 Jun 2026 20:32:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: bnep: pin L2CAP connection during netdev
 registration
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178285155488.267316.4327348213803627629.git-patchwork-notify@kernel.org>
Date: Tue, 30 Jun 2026 20:32:34 +0000
References: <20260628005058.29072-1-alhouseenyousef@gmail.com>
In-Reply-To: <20260628005058.29072-1-alhouseenyousef@gmail.com>
To: Yousef Alhouseen <alhouseenyousef@gmail.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, syzbot+fed5dce4553262f3b35c@syzkaller.appspotmail.com

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Sun, 28 Jun 2026 02:50:58 +0200 you wrote:
> bnep_add_connection() reads the L2CAP connection without holding the
> channel lock, then passes its HCI device to register_netdev(). Controller
> teardown can clear and release that connection concurrently, leaving the
> network device registration path to dereference a freed parent device.
> 
> Take a reference to the L2CAP connection while holding the channel lock.
> Retain it until register_netdev() has taken the parent device reference.
> 
> [...]

Here is the summary with links:
  - Bluetooth: bnep: pin L2CAP connection during netdev registration
    https://git.kernel.org/bluetooth/bluetooth-next/c/d66f0661748e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


