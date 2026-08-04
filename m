Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD7CB39B943;
	Tue,  4 Aug 2026 01:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785805246; cv=none; b=Ub53F3uVd0XNEfKasuTnaod+jWsgDwql8fKEY1Ygdvgu4KrvrWbCX81V7p6MBmXWJqklqQcdo4Xi+EfyTjEsv5NkTvry+zVdQEj1cQMF+3gn0rtfIKZhjFVbr25M1bVuzQ/vyraUX/3MUqA23UC5iYtkHqEMukfVWqS3cqiONyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785805246; c=relaxed/simple;
	bh=uGaiRyA37WI8ClYtoX+tAnzT6PMBOwVquZksh9XZZJk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=T5iVyuW1bosJHj0AtH3GmTsMTrozw8MRYH6WeKZOdcpFt10h0Ym6nwmy8G97ZUzPrq4cKTMWg/RWq72QFh9i7ffmGTxF5cZV3qZ0zb7UzewNMUTiEpS1QhDwpkWmG0kGEIiskBZaLYJV5pb62xK6G/jOIQSJQzceQ+7L7LyJT4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i6ag75cv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i6ag75cv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 788CD1F000E9;
	Tue,  4 Aug 2026 01:00:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785805245;
	bh=P+5nv5aJshBSU0gmkZbEpOazh8u+wbch6usH4/cZq4U=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=i6ag75cvCCvu5a6OeOhIlw8xXDzma364ByPySPzMawEeRvFDAEj9h5EuJgCVDn2KK
	 IuMI1KrpJuI0NM5iQ5qgnR0VIx2ZelAC2nayvTbjH+d1Iu6k1AzQkbay54v2rVGJ/r
	 gif3Fp1VWpGrlPVKju1E7h4eDQt9GA6pMV+kTWEk5oMfFI8KRg3Fku031Tf7WvX+j5
	 yibyXft3v0ri3wohnuJhbr1rTdNWWdPMt3v8B3tDjnO4p67smigYnBvc6EeNJGBrOg
	 PhTFsN5hgrsKl2to8M0LDnc6LobbeiHcZ9HDnUGHSeyv4pmHTIpUuYTrQd39hMpIJC
	 6gSX1uonast9g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 939C83924467;
	Tue,  4 Aug 2026 01:00:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: usb: ax88179_178a: fix skb leak in
 ax88179_tx_fixup()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178580520614.2899965.8757939088248761753.git-patchwork-notify@kernel.org>
Date: Tue, 04 Aug 2026 01:00:06 +0000
References: <20260729030436.3420477-1-cong.yi@linux.dev>
In-Reply-To: <20260729030436.3420477-1-cong.yi@linux.dev>
To: Yi Cong <cong.yi@linux.dev>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, jackychou@asix.com.tw,
 netdev@vger.kernel.org, linux-usb@vger.kernel.org, yicong@kylinos.cn,
 stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 29 Jul 2026 11:04:36 +0800 you wrote:
> From: Yi Cong <yicong@kylinos.cn>
> 
> When the interface has NETIF_F_SG enabled and skb_linearize() fails in
> ax88179_tx_fixup(), the function returns NULL without freeing the skb.
> 
> usbnet_start_xmit() treats a NULL return from tx_fixup() as a drop
> (info->flags does not set FLAG_MULTI_PACKET for this driver), jumping
> to the "drop" label where it does `if (skb) dev_kfree_skb_any(skb)`.
> Because tx_fixup() returned NULL, the local skb variable in
> usbnet_start_xmit() is NULL, so the original skb is never freed — a
> memory leak on every TX frame whose linearization fails (i.e. under
> memory pressure).
> 
> [...]

Here is the summary with links:
  - [net-next] net: usb: ax88179_178a: fix skb leak in ax88179_tx_fixup()
    https://git.kernel.org/netdev/net/c/1f428e309473

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


