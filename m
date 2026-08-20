Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F8093AA4F6;
	Thu, 20 Aug 2026 20:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787257874; cv=none; b=FDjleeQBCbpBL0KDmU+3QDNypxWcEYiXzIx1oFoljo29pCq0yoWP4f8m8EhC5f3lKP7q/a/mEYg3WU25+HxnhuWr7xq60S+Y+oF1LZUZoXlyfYNp6xNbtR4s/tnmhh5KdEwbgXlrDXov/cJSXgIGVnPRwNiMXnWETqPToDaMjf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787257874; c=relaxed/simple;
	bh=D7r7tDcczau59hOfvg2B2qNW27IEbl7dyCkD3sHNa4E=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=M8kkPE0JIl06M5hfZMT3PafZJDV1lNfd2lfXVWVH9gZ+A+cB+PLIvDm5dLNIL58iyLvwXfE0VhhTKwINber/m/zdogwREUYXH0GglBrqBwLqO2Ko6EuHarh80XRswddzjG4yUip3MaL0wjUHjqhnXPO1tGUP3Umj/ZB9NAFf6Yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nm0gwe4O; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nm0gwe4O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E62721F00A3D;
	Thu, 20 Aug 2026 20:31:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787257870;
	bh=lfGpxby0qIksvhJs7yVHNMqsy9jYZ64uWGDMv6yGbIA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=nm0gwe4ONOpR5NGv0ZDiLksLxzs9hv+uN3vtMnQ9kOmxJ/cUpsrNZB7P8T11Opnni
	 Ez94XAoJro0gIF6kGeLJL6LXMjYqVrQ6mpuvrJnD3Z30X7aSJ/UAri7gtBX1zD3PTe
	 VarVCurNlcRTlLtPsu9MuJbKeQcvZLsRTy0NBf8zGu4TDKdDBqQYYdcJVkcRqrElra
	 RXrho3RK/5OnGVGB/+cvcnndc02lXTO/DI6rfNk9f2CXs8OD45lnaNh4Pg8ZBK4GPB
	 LAbZPHL8nJbWucn3/LOF/c1D00KVvUGQxIRnnOik5Qh6GZ5qgvKmcxvjyU+b+B8aNm
	 PY+IUw17PARTA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 567F6392445B;
	Thu, 20 Aug 2026 20:30:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net/packet: defer vmalloc TX_RING free until skbs
 finish
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178725782089.470503.8939686138697227562.git-patchwork-notify@kernel.org>
Date: Thu, 20 Aug 2026 20:30:20 +0000
References: <20260816235646.76500-1-kylebot@openai.com>
In-Reply-To: <20260816235646.76500-1-kylebot@openai.com>
To: Kyle Zeng <kylebot@openai.com>
Cc: netdev@vger.kernel.org, edumazet@google.com, kuba@kernel.org,
 davem@davemloft.net, willemdebruijn.kernel@gmail.com,
 Muhammad_Hazley_SAMSUDIN_from.TP@tech.gov.sg, stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 16 Aug 2026 16:56:46 -0700 you wrote:
> AF_PACKET TX_RING skbs keep a raw pointer to their ring frame. The skb
> page references preserve page-backed ring blocks after pg_vec is freed,
> but they do not preserve a vmalloc mapping.
> 
> tpacket_destruct_skb() currently drops the pending reference before
> writing the timestamp and TP_STATUS_AVAILABLE to the frame. Move the
> decrement after those stores. The smp_wmb() in __packet_set_status()
> orders the frame stores before the decrement.
> 
> [...]

Here is the summary with links:
  - [net,v2] net/packet: defer vmalloc TX_RING free until skbs finish
    https://git.kernel.org/netdev/net/c/992cc9f94ca9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


