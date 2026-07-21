Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9852A40928C;
	Tue, 21 Jul 2026 19:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784660489; cv=none; b=ezqUeDA/y9ihI/r1dgnJCeybxpMRftEQOrV+6MLz9ryoewExF6t7mLen8MLguuhS/z4zOLAJ+KEb1/Mp497+rztgbFv57SK50U5jMV/tKEwDFD2Q7VgtEtZ2me+1mQ8FrUxovtEMaRpTgE0WunZsbz2dqL1v6YRohM09XS3hOjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784660489; c=relaxed/simple;
	bh=9nS3Kym6rY4Fw6q3Zx7D5Dkv2Ylo8PiNpkBhYEYSNv4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=EwBjDRBoqXBmHptPqUel6hC8oUzMcXMG3M4E3uS/AnTmqsau+/LIB5FaCTHP5MeSw+4H2NKv5jn3wS3DOBhA+OnZU+mD7afRrSyINT8We1jCzlUcOlCoLF5qYBtDncRrE9GpkZZeHxIDdTVytW2rqQ92qwxODMTUkEMp7y0c3Cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kF6pdNsw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kF6pdNsw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D30091F00A3D;
	Tue, 21 Jul 2026 19:00:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784660439;
	bh=ydQLqwdQ4YHy7iXnefvXJkBzPx7GxR69XjpEVznbuZM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=kF6pdNswZtNrXds3rGoZ8pX87WNTPvBh0HX19oBuVaigc+y+QSYA5Ogj4OC3FmAjR
	 pba4FzoKQEl/9lR5n7k4R4fAd/76DjUUynEWhAvBaa/2nYE9/i0RmZynJXQWacyHFM
	 Ym6KZDJaNcoqZbdO2Gi7BpMud45/iOkGlXh7tsPPQNsSapG1dOdYul3OqLXhCuoli3
	 nG0JrgrZfSOvHPO4/IVPNdFGfLoOHASpRdql1srO8EHrjJSmUQAE7zGfux7X+AEHTt
	 k7vyT73KDiexcdRrpHzONh0Iswg+ASrIRZGjnKmHG6DNSYbondoxUeY83XJwePzUOV
	 U8waIf7IwFPlA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93A0539253F6;
	Tue, 21 Jul 2026 19:00:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v5] rtase: Workaround for TX hang caused by hardware
 packet parsing
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178466040916.954483.3499011625995245458.git-patchwork-notify@kernel.org>
Date: Tue, 21 Jul 2026 19:00:09 +0000
References: <20260709103456.83789-1-justinlai0215@realtek.com>
In-Reply-To: <20260709103456.83789-1-justinlai0215@realtek.com>
To: Justin Lai <justinlai0215@realtek.com>
Cc: kuba@kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, stable@vger.kernel.org, horms@kernel.org,
 richardcochran@gmail.com, david.laight.linux@gmail.com,
 aleksander.lobakin@intel.com, pkshih@realtek.com, larry.chiu@realtek.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 9 Jul 2026 18:34:56 +0800 you wrote:
> The hardware performs packet parsing before packet transmission.
> Parsing incomplete IPv4, IPv6, TCP, or UDP headers may trigger a TX
> hang because the hardware parser expects additional protocol header
> data that is not present in the packet.
> 
> The hardware performs additional PTP parsing on UDP packets identified
> by destination ports 319/320 at the expected UDP destination port
> offset.
> 
> [...]

Here is the summary with links:
  - [net,v5] rtase: Workaround for TX hang caused by hardware packet parsing
    https://git.kernel.org/netdev/net/c/1c50efa1faf3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


