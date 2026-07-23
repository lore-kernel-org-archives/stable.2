Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1B1147ACF4;
	Thu, 23 Jul 2026 15:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784820064; cv=none; b=GwzD2Qq7UEUgutSMzDphLbU1eLcK55f/7szMh7bzVG/CGQOztHM/cKxEu2R16QGHn9Tc7R/KDFbrccUjcqkLKeKWsnsHtrAZC6qhDz7DJc7d6oJuRlK0aaFg9c8TU4niM6NFY/xiTJCC7GPpIrSXppTRVlKyfdsDq/CW1ExHJls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784820064; c=relaxed/simple;
	bh=Al6ywTVlrN9fn9YCyJ5PSmXZlft8LYRFE5bN43Q34ug=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=k0rCXT9MPe5vsBMCIZWQB71uhcuVpZ9MmSkRqiC19UCc2yV8rwArmd5dTs8WkeWZFA516WEElwkXjUjtPY4K9PDgdBGn+9Ts+n7XOt4n6OCYDgu6yT+4zkvOc9TyVfZgEgp+vVRM2H1ega7lHvk3fuSoOUxIy4buNKAa2Uxr8Sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mq87set7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mq87set7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 105811F000E9;
	Thu, 23 Jul 2026 15:20:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784820058;
	bh=rO+6JsaE4IC8uL/fxszQbXIK072NUX/4lwAtxQBDn5k=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Mq87set7pdCNcloEk7LFgpSL7aO56WiDnp+1hys3Wucgkk+ao0DhK+iagRKdoDPk5
	 bR9hk37EDD1UVkxm850rxYbXPCTv/es1oPhtFZ5VU6xkL+G7wfMqOSop56p4RjYHzs
	 bD6ym9q537qt3f+S+db4hICQRVaKT5zlhCCYvYwjZXy4H+wbLmNfbz15aJEHhzmCUE
	 b8qATli9GXZPOFK0P6NygW8r7oNDtUxabUwNFrjPxH2MrLoA2W6zEesIEQGZKoHVFd
	 CgJ1OEZ9qL2yIgqI0jonax+rlnlQkeBRWa7lhlXwbC7Njb9FmEI8AoHk7QjFYM3Twj
	 GsBTrib51PLaA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93A95392444F;
	Thu, 23 Jul 2026 15:20:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] mac802154: llsec: reject frames shorter than the
 authentication tag
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178482001540.2315735.1412808647619439700.git-patchwork-notify@kernel.org>
Date: Thu, 23 Jul 2026 15:20:15 +0000
References: <20260716193423.32498-1-doruk@0sec.ai>
In-Reply-To: <20260716193423.32498-1-doruk@0sec.ai>
To: Doruk Tan Ozturk <doruk@0sec.ai>
Cc: alex.aring@gmail.com, stefan@datenfreihafen.org,
 miquel.raynal@bootlin.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, leitao@debian.org,
 linux-wpan@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 16 Jul 2026 21:34:23 +0200 you wrote:
> llsec_do_decrypt_auth() computes the associated-data length for the
> AEAD request as
> 
> 	assoclen += datalen - authlen;
> 
> where datalen is the number of bytes after the MAC header and authlen
> (4, 8 or 16) is the length of the authentication tag. Nothing verifies
> that the frame actually carries at least authlen payload bytes. A
> secured frame whose payload is shorter than the tag makes
> datalen - authlen negative; assoclen is then passed to
> aead_request_set_ad() as an unsigned value close to 4 GiB, so
> crypto_aead_decrypt() walks far off the end of the scatterlist that
> only spans the real frame.
> 
> [...]

Here is the summary with links:
  - [net,v2] mac802154: llsec: reject frames shorter than the authentication tag
    https://git.kernel.org/netdev/net/c/fd3a3f28ed60

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


