Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9088480350;
	Thu,  6 Aug 2026 15:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786031475; cv=none; b=XIDo6EpsBo7luXR/JPrekhA8W+48den+aU3rjVAlNMErXuFJF5F4Iw7bSz63Poq9rEKbnyzN4+CwfBdEXi25yDs+LP4jIC9Sa6RYLQJUKXkvo2+b2JxkmXtHK9gFPYw1eAm2zDQrklHOcRaBQXosHlbzD2lu0GyufHXgH+sG/pM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786031475; c=relaxed/simple;
	bh=ZXb0oRlK3EiIu+WxcYj4mgoH9ZxTGx20k4GZc0mGp60=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=N919UpZqV4ZIMnnlM5V2vORf6y3Zes2lD68H/pgluyV1yqT6nbuYkvzXY5JUWAQ0FvlBctQ1BTv8AEwH34jmKmgn90KdY+WLgAb9lcGscekFlQ2X5IykEaiz7vC4RgDfsZrIL2CV7DtftaMCwPKjZt536VteTqjPv1h0m/dqFn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kt6xdSUU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kt6xdSUU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5E0F1F00A3D;
	Thu,  6 Aug 2026 15:51:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786031463;
	bh=JTlWuW7Ek/KcvkJsxcR9pM8DPrbJjAUnnUuIbCyGf0M=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Kt6xdSUU9XAkGhthE/ToXuIe/XNmw+fgjdfIFfiv5wW4nwMwhC5oDTfp0rnRoUWzn
	 UaFlYyl4VLs3Nx8/zrUaiO+UQi1sXQuAAeN7P+QIQ21dkc5SNK2BshjhDhTpx2km7i
	 RM5ByPJYnMJOAD2iZgWJ5SxE0iTCVbolw1Te2Rj8+BA1DrsLtnG8UqodbTbI3/KypL
	 OGNu7JO5ns59z2JVd5npHMX3e/TMSWMYN/QfZAqRSxCa/ApgRxrIgqQCBsXJJRweff
	 VDzGq5PR0Rrj9aPdBO7cn5pHjQ/1rc1zY2TAJiSpicP+auc/biDdiFik5g/WB0fr3b
	 0rxKIzrk3nkhA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 56936380820D;
	Thu,  6 Aug 2026 15:50:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net: usb: ipheth: fix carrier_work UAF on
 disconnect
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178603142291.1348318.12761684225975520681.git-patchwork-notify@kernel.org>
Date: Thu, 06 Aug 2026 15:50:22 +0000
References: <20260802120602.42595-1-doruk@0sec.ai>
In-Reply-To: <20260802120602.42595-1-doruk@0sec.ai>
To: Doruk Tan Ozturk <doruk@0sec.ai>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, andrew+netdev@lunn.ch, agk@godking.net,
 linux-usb@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun,  2 Aug 2026 14:06:02 +0200 you wrote:
> ipheth_sndbulk_callback() re-arms the carrier-check work on any
> non-zero URB status:
> 
> 	else
> 		schedule_delayed_work(&dev->carrier_work, 0);
> 
> Nothing ties that to the interface being up, so the work can be armed
> again after ipheth_close() has already drained it, and stay armed
> until the netdev whose private area embeds it is freed.
> 
> [...]

Here is the summary with links:
  - [net,v2] net: usb: ipheth: fix carrier_work UAF on disconnect
    https://git.kernel.org/netdev/net/c/fde39b8a5217

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


