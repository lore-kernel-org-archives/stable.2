Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2BEC1ACEDE;
	Sat, 19 Sep 2026 23:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789860075; cv=none; b=GB78BYNmVbVyPlJXfhnBNFIHfzKurpXVtuO3ahXLwz6Ts9z2QsR97DDC56TjIU+lcc/JgfljnfPGvTxr+dAsNuWtuuXh+r8S8ykcMoPNk+CrJCxtH73fsjvJ9i+PVebybKlhl5sW3fUBYVp6QBMsbxQkvbyYn6Bh12Hs+wydDdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789860075; c=relaxed/simple;
	bh=AZb+kScGG4PiiruSgXKlU3T7M3DKD2mW+8q/vno4rMc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Luft+FcUj+CyYjPMlEWxeURvqHuj4tBcIHTUykiy7dzCWH50coFD13AJ9JkrjMwm/ePMzkrTHnz1bvS5P6fhK6XUryVM9SJxQbj3aJawXXPqfVSAjBwgqMTUiu5DvfmDPxFTvn6LXzCkgp9NJAGbtRX3ffENQDS8M1CJoMoMw8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B/mBXBMa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B/mBXBMa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 629FF1F000FF;
	Sat, 19 Sep 2026 23:21:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789860074;
	bh=iq5dAyUVLkaFGRL8cxxr6glqE0y8QGW2cBUUD1enuwQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=B/mBXBMa56uwxFfA5ic92suV9u1k5JIGgSgGgP6yeNUJbOPY09uIOKQX2Nb39Gntc
	 Epqca4GFEBOIGczJvwhg0squzRDKpONl3hwBcrQE9qkOzCxkMP0SU4l2BhSBNpgjcc
	 6BwHxZjJtLnC8JWnyLckW8kYZTa7LbeMpI6iN56sljxt4462+pCHiZK+sLZHLj/sbP
	 C1PgOqCdH6mXXTwpztLYcIfkcC3+Pws0sqis1bPxm4JcSZq+T+beDqzy4oeNTjrRJB
	 jtr18LA3Qq3jXhalNid/x/NcgJqTekrKAwBRHdrAPAjShVA8Y+2flg7uY5cnZAhlxi
	 ptx8FlVWNqwQQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 19731392447F;
	Sat, 19 Sep 2026 23:20:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] vlan: require the MAC header to be present in
 __vlan_insert_inner_tag()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178986000690.1491217.13452537576986378858.git-patchwork-notify@kernel.org>
Date: Sat, 19 Sep 2026 23:20:06 +0000
References: <20260915083152.705309-1-xmei5@asu.edu>
In-Reply-To: <20260915083152.705309-1-xmei5@asu.edu>
To: Xiang Mei <xmei5@asu.edu>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org, jakub@cloudflare.com,
 stable@vger.kernel.org, co+0ea1ac045375cf05@bugs.sh

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 15 Sep 2026 01:31:52 -0700 you wrote:
> __vlan_insert_inner_tag() only guarantees head room via skb_cow_head(),
> never that mac_len bytes of MAC header are present.  Its ETH_HLEN
> wrappers - __vlan_insert_tag() under skb_vlan_push(), and
> vlan_insert_tag() under validate_xmit_vlan() on the generic transmit
> path - therefore rewrite the first 16 bytes at skb->data: a 12-byte
> memmove plus two 2-byte stores at +12 and +14.  No caller supplies the
> bound, while the pop helpers use skb_ensure_writable()/pskb_may_pull().
> 
> [...]

Here is the summary with links:
  - [net] vlan: require the MAC header to be present in __vlan_insert_inner_tag()
    https://git.kernel.org/netdev/net/c/ab888242fce4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


