Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C7EE480975;
	Thu,  6 Aug 2026 15:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786031486; cv=none; b=eq/KxuyahDdhKNRsl7DsllR85BZ7alakW8/8qKGEZ+h/h1z8110u2bO1ej5HBIBjwGPSixCQl6BVF4AZGzbMOGuG39xeWz08dWNveldw+mAHoFfzY3rMsD7+DZqB5ddTGO8LWGqmK/d1Ci6S4BwDqIqb4EQ19af5UWexBBIcI9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786031486; c=relaxed/simple;
	bh=bZJS0br1/u+dkalG1SFqNwknmyIg3aWdbDJXRe5qzec=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=kY8kAKqG7GLqUOlBdZdxmO1QZ2KzwFZxwVvz+TSkh8qw4f/9vnPrI9a6jfLo50/LvsqTD9hBaQHakw62cKbQRxmkAGKz9MeBuphcxATT94COOE/F4GnwVgN4nXwDl+tasiu6Wf0gw2EIMtQoZfl1TYRQnKoEfo/ZGS5Y4AH2wUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NQcubiwx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NQcubiwx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10F3E1F00AC4;
	Thu,  6 Aug 2026 15:51:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786031475;
	bh=TYR7zXdTELe6WmfkTY6j21tZSO0kCQddxLKncanvlc0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=NQcubiwxJkAlCVoQSZ1nd2jxeoRguWZLELfatNEdWvMaiExlygE7vON3VfTn+Hp9l
	 7C3T/DobH0pvk3IuYDsaLjcaHJu95zNQOWC6+I84JoBRBQSU+rj5CjVkgGNi/QKiMX
	 DoNFtjqpmmoz1ogefxLgX7yGxJvVxZ/ucfppkrCUm/hMFglErWCojHCdhMfGNMbzVu
	 QJ3fFGMHWKtt4uGIOSz+i0r/a65N9K0SmxjQ/3n7pV20aEv9I0yDJqNtvYAkn0sZve
	 UMtbdAVPfGBpTk7Z+UWhxZbrv4mcbR1SH/A1AM0ju552j0gSyrrHy1g9BEhtImTvEu
	 JRM9V4WRxOzTQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 9390A380820D;
	Thu,  6 Aug 2026 15:50:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] macvlan: require lower-netns admin for shared port
 settings
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178603143413.1348318.12932367688516790351.git-patchwork-notify@kernel.org>
Date: Thu, 06 Aug 2026 15:50:34 +0000
References: <20260802130137.98105-1-doruk@0sec.ai>
In-Reply-To: <20260802130137.98105-1-doruk@0sec.ai>
To: Doruk Tan Ozturk <doruk@0sec.ai>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, xmei5@asu.edu, thomas.karlsson@paneda.se,
 herbert@gondor.apana.org.au, daniel@iogearbox.net, horms@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun,  2 Aug 2026 15:01:37 +0200 you wrote:
> struct macvlan_port is per lower device and is shared by every macvlan
> upper on it, including uppers that live in other network namespaces.
> Two of its fields are settable over rtnetlink by any upper on the port:
> port->bc_cutoff, written by IFLA_MACVLAN_BC_CUTOFF, and
> port->bc_queue_len_used, recomputed from IFLA_MACVLAN_BC_QUEUE_LEN.
> (port->flags and port->perm_addr are also rtnetlink-settable, but only
> in passthru mode, which requires port->count == 0 and so cannot be
> reached from a second upper.)
> 
> [...]

Here is the summary with links:
  - [net,v2] macvlan: require lower-netns admin for shared port settings
    https://git.kernel.org/netdev/net-next/c/5b782a811e73

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


