Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794961809;
	b=G5vhF578oYSnmGDEMZAValv4cXWhfkJ4hqQrRlKVI7w9mCvi3GzPurBOAesv1Hvq0Nuf
	 e+XH3BqB4G7bFLJoBcGjUg3M0yu4K+RBsGgESgCZt5gRWMUwV18qHkOSUJXZp6Xwl+7qB
	 ZR4unI9u3MxsucIZVtPWLXuVPgc2RqpLpxwPOOhX+t4L7jLsKxx/fvzg0BDlXq3m9iwA+
	 kBJsFVTBfjBznjyAiOTx/XBD0bfidCjCytC5KA6H063FQ8c0n45PvfjdQu0xLzHtBTCwg
	 y+Ai+zqD9Y6DFlZWU8XCiJQ7laaTr12rYgZw1RQuKMhqj/CvnMzm66+T11E400ncV8g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794961809;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=FLFSTzTgvHuqY+20z4nQYiKE6NAG46HA4Pa6c/Rj/M8=;
	b=KjlrmfvXV1HWWrM2PErc6M3Zy5Q/4+XV+PAjVt3tLn1Z/QT7wyNaSRAfYzwHqDK/JUz/
	 vS4oVfcwX4lKBspVyIEN5xomTQyqpHwzsY99m2hrWVu+wqeTPwlzynBhqBxrbIONMUuQo
	 OsYajK5j5TAxd6xC7a3VnOq8LqgHb+IDjz1Q4Qkt73dZZoWElQq59QfrTEkX1kvFNwWWZ
	 tlZcGNOndjgcbD7Fu3sycd8tKO10qC+0+aQNviMXf9+oDWK6n9uiUPzzy32eq9WSUvSgk
	 h1gZUB5saohGh0POvZMEv5xd79bFk40qUThYVihHQQsJjSEPphXl6d8igvYRQ0IfFvw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FX6YvtvS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65141606A31C;
	Wed, 18 Nov 2026 00:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FX6YvtvS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09E4E1F000C4;
	Wed, 18 Nov 2026 00:30:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794961809;
	bh=FLFSTzTgvHuqY+20z4nQYiKE6NAG46HA4Pa6c/Rj/M8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=FX6YvtvSn6ASXYLwgRspXj6sUWUpGx3ppTDB+6G8ni/XIRXn1YPR8ui0j6BHP0VB8
	 sfl05aOw6lj6c6k59P58XLllop85jGSlnESHQlLlGluTGV914DqiO+Xd2eUkIjTvJi
	 ivu5YSzOma+PuyToik8lBQtgnZKlmmR/MSAQa9CJNXlLdX5to8kDXCPGn+TADVog83
	 bWGGYLoCiO+qMzrP1cd3CglvosF9WZVzm/EjVHllW8n7saRqJ7DWR/tld3SOj2Vrqz
	 +gK0aisppO6RcIshOEFK3WhJDbapEnMmQBFgpXn7oTICm0StfUBgsQvXSoKXI3sErd
	 5T/uZuGXklyCQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F15C9392B1FA;
	Wed, 18 Nov 2026 00:30:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH wpan] mac802154: llsec: reject secured frames with
 security
 level 0
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179496180753.1369671.1262843769170490245.git-patchwork-notify@kernel.org>
Date: Wed, 18 Nov 2026 00:30:07 +0000
References: <20261110-llsec-seclevel-none-v1-1-06ef143e467f@gmail.com>
In-Reply-To: <20261110-llsec-seclevel-none-v1-1-06ef143e467f@gmail.com>
To: Joas Antonio <joasantonio108@gmail.com>
Cc: alex.aring@gmail.com, stefan@datenfreihafen.org,
 miquel.raynal@bootlin.com, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 linux-wpan@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 10 Nov 2026 09:03:23 +0000 you wrote:
> From: Joas Antonio dos Santos <joasantonio108@gmail.com>
> 
> mac802154_llsec_decrypt() handles every received frame that has the
> Security Enabled bit set.  The security level is taken from the
> auxiliary security header of the frame and is not required to be
> non-zero.  The only check that looks at level 0 rejects the frame only
> if level 0 is not allowed by the matching seclevel entry, the entry has
> device_override set and the device is not seclevel_exempt:
> 
> [...]

Here is the summary with links:
  - [wpan] mac802154: llsec: reject secured frames with security level 0
    https://git.kernel.org/netdev/net/c/3e8c853c959e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


