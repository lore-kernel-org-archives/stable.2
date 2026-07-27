Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF84D427FAB;
	Mon, 27 Jul 2026 20:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785185446; cv=none; b=IXrKIjbtc1qYEpt8wJ/DgG6nMRgr2qMgIT8XJfUrIa4uLeQb0VFy/y4scET84hBYt1AgiAbFXdTUW8QNiw6N4//zyW7JgCkDzOgsm3fsLomT40WoHMEHmBCF/7pqhY41BHWtDlKmMQQIB6RLXUbzcoQf0q2SykraazMEv6a3SGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785185446; c=relaxed/simple;
	bh=V+S2Xn4psO8d+BxG9K2+1XitLSF5hl1UxlmPO8jjoKM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=fXcMjWFINhFhzn82Tx7C8Pw7UyYgpPZ4LFpF0biVB1w3IzZQtnl8HV0024QATGTz9LZUCedWgxdUGYrk6v0W6U06KSmmCPYtSG0u1K0Vk3ooRptMn5sn8E9WxEI0M8wNuRe7VKfL+py/oo04Bn4j3iSNgDlQpasENVB7U07jDbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mlPIVM3Q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mlPIVM3Q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C15A1F000E9;
	Mon, 27 Jul 2026 20:50:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785185445;
	bh=RS6pYWHXgojoqiODGdTZWB//jMBLHEwugdQdZLoh/Q0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=mlPIVM3Qqk0LIzsBAieYur6Ysgm+Mf66fYejkG1tkLe+jXoPOYUq4qgXOk/TIqVZG
	 8uqbGwIiUOeTM5gLVpgU9AP0dbJGE/exwS7bOKV20ia9Zr+ltB4ACDMv8lthED6Y96
	 dpV0efLK+PfT51zDupThj17b9TnwW596rymW0b0rmbfu6S9TORORGQqzATc3YFI52N
	 HFzJ3axN2yLYI/4lfbJ6XsQMomTG4yGdqIvr4hjZvUfjk5cfCgzER4RvJ5dRMpmNj/
	 4QVjJ7JLmaOlCctdbVO1aHraLv7HfHIQYU/HWgu1o5976AydmKgji1W6B4BTIKMe4+
	 HHTTnGbo1/k6w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 197AD380664D;
	Mon, 27 Jul 2026 20:50:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3] Bluetooth: SCO: give the socket its own sco_conn
 reference
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178518541063.1412337.17890508638369383289.git-patchwork-notify@kernel.org>
Date: Mon, 27 Jul 2026 20:50:10 +0000
References: <20260725195230.967546-1-qwe.aldo@gmail.com>
In-Reply-To: <20260725195230.967546-1-qwe.aldo@gmail.com>
To: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
Cc: pav@iki.fi, luiz.dentz@gmail.com, marcel@holtmann.org,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Sat, 25 Jul 2026 16:52:30 -0300 you wrote:
> sco_conn_del() drops a reference it does not own. It takes one transient
> reference via sco_conn_hold_unless_zero() and releases it with the
> sco_conn_put() that follows sco_sock_hold(); the additional put in the
> !sk branch releases a second one:
> 
>     conn = sco_conn_hold_unless_zero(conn);
>     ...
>     sk = sco_sock_hold(conn);
>     sco_conn_unlock(conn);
>     sco_conn_put(conn);
> 
> [...]

Here is the summary with links:
  - [v3] Bluetooth: SCO: give the socket its own sco_conn reference
    https://git.kernel.org/bluetooth/bluetooth-next/c/018d1e023ea5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


