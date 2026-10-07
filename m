Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE40F35F619;
	Wed,  7 Oct 2026 23:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791417007; cv=none; b=XcIA1R8iqEbUMqIY2OZaT6+H6KT8s6GqPh4hNABHhq0ftK/FB+akdBrlkS4NGWmzNeDlhswpH1GRQxBd3MTm+GzmKYjAsDlrQozpjPbLVjQltfYPMbfbfdUnA90Qebuwn6sgqPBa8rrONfQ62NP1+btVq5gDfDghqz8UEqBWwxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791417007; c=relaxed/simple;
	bh=YEYgCAiQdlSDnPIG8OiwB6Bq7Me5xG/yQW0ImBE8UjE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=B++kV67Xxx3zS5VvEX1BtstrItLHU5P7cYphZm295TGQCClLI0UWEZUxbHjlHhLj6Fbacg/kDT6kTlyK8/CBmMONhQSxMqcSerxcVc79TckmvZlcR0hR5JgcG7qGxB+M5SIRVLneeOCYt2PVZBv3JwnupS6odHDMaLEQRgyWXk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z0Gcdm79; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z0Gcdm79"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81B051F000FF;
	Wed,  7 Oct 2026 23:50:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791417006;
	bh=p98D82/mKpVumsm5JXY8kgxMkA9BWwo/AfAksG5RNcg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Z0Gcdm79eKgUmCZQOGKtWTWB4yAPP1N3uq6G1zyDV9s1nYyMBirCYaSbLRbAHAxnO
	 eySmNCBGBHW/ZajmD8BlN5OnYiquv2IBnBMcWPZMCZIPLi8g9ajPE2VO0A/YPF/iqj
	 PdayvQAkM+JyUPMbg2zd+5NkjYKf8g+dBXIm8yZ0ozLiOlz2sGnxyZXiFncGGasDKy
	 qHbl8cMOG0JVXghm7VpqBQs5LbGwnSUDy4HRZqteHsUhGM8n2C2C4srFSUVECQVQno
	 DmDluuEUYjMj2GZBIyaKMXKMrSzy4OvihQtbQGxqVvbiYPyRAkmpYIRLzEdAQN1K3u
	 S403Etl4z0DRg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 774783809A08;
	Wed,  7 Oct 2026 23:50:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: usb: ax88179_178a: fix rx frame length for
 non-last packets
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179141700528.3739009.13126482907868656699.git-patchwork-notify@kernel.org>
Date: Wed, 07 Oct 2026 23:50:05 +0000
References: <20261002-ax88179-rx-len-v1-1-f01a2a295079@volvocars.com>
In-Reply-To: <20261002-ax88179-rx-len-v1-1-f01a2a295079@volvocars.com>
To: Fredrik Nyberg <fredrik.nyberg@volvocars.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, linux-usb@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, horms@kernel.org,
 joalonsof@gmail.com, stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 02 Oct 2026 14:28:57 +0200 you wrote:
> From: Fredrik Nyberg <fredrik.nyberg@volvocars.com>
> 
> Commit 4ce62d5b2f7a ("net: usb: ax88179_178a: stop lying about
> skb->truesize") replaced skb_clone() with a copy into a new skb for
> every packet of a bulk-in transfer except the last one. The copy skips
> the 2-byte IP alignment pseudo header but still copies pkt_len bytes,
> and pkt_len includes that header. Each of these frames is therefore
> delivered with two extra trailing bytes: the 0xeeee pseudo header of
> the next slot when the frame ends on an 8-byte boundary, or slot
> padding otherwise. The last packet is still trimmed to pkt_len - 2.
> 
> [...]

Here is the summary with links:
  - [net] net: usb: ax88179_178a: fix rx frame length for non-last packets
    https://git.kernel.org/netdev/net/c/9b6c20f78847

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


