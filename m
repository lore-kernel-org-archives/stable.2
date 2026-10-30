Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793353206;
	b=TOo5RBT5S04wrU5c8fmUcXHUmBzLlGDG2oSDr8tsGdci1HtmVQBd9y/XvUY/xpe2nlFr
	 5sHEmL+amYtKmWwD13Yqw1LAn+9ekQYEXX89qxqksQTNbsjhpEO4ilMmShLaa6WvH5lif
	 gxnnJ46D8oTdZwkwoniHjcl9FBRf8P5jxGo7DFB3IXQAijEPNUeM/QLpfjKH3ZaLgIu4D
	 mox82+uzVyG28o3jVWMgJ4S8tOmoFmo8XR2MPVF56sZc6Yq/+rWPiPID9zvHan/X6tZ+Y
	 UEhMo8fQnP1gTSGi5sD6kATnPB1YIxWzTh80KFEwmpFwTxzGhyLvL1yx7QN86tohRig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793353206;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=q97ib2TJPGW5E/QbfamNipDgstGtnceryoKyk72t9L8=;
	b=GGbXd7PwpWVBIiWqYg7Hjp4C9AeaNdCaCgpQ291TkUEYQ/aRENQlgibzAD3iITyBdtZx
	 b3sL9BLhMpVUksZ1fRh1op15cmWNRHMztRqHoHRRNV/VrPrZeRmYPKjAOo2rG9tV+omZX
	 AY+lgGgjIXcD+ONqRwP/dthfRup6dd/Ao6dJVrG9hX+WlNBhqFWYL2FNOdar+UE1VOcIj
	 mNhB794SiZbrpNv+Kv589JCb+Qj8fBoDttga8uTi/NQz9+IxoQAmJF51en/qGGiWJjQsw
	 qr96i5sx5H4thkLEXWGf7k3KShyznD0fxjAR8O1rI4iEyILNMy2Gkhdk155zBnaEF1Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ng0jMIm3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ABF4606A32E;
	Fri, 30 Oct 2026 09:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ng0jMIm3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C6E01F00A02;
	Fri, 30 Oct 2026 09:40:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793353206;
	bh=q97ib2TJPGW5E/QbfamNipDgstGtnceryoKyk72t9L8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=ng0jMIm3EJt5nxY9uMhz8iXU4DgSJvH3LydfcLjyYKK8HUqNNZJFBYWEyl+lefcyL
	 NeFPnkZf6OZqc+RfIYL4WhvmYwemj8EyrmwLIRF6v0e/e3TBtTBEQvdAXQr+AduuLV
	 myUfKQAqIdOquJJRbyJHcBNolj8rSfQuFdrxtArjLOLjBQ4SfmNkVsdKEac4sUZp9v
	 9blouBCPzcIk/w0dNvcdWmFVdHV4k8M+YNpaAdfiivc635ZoCzB3wQymDz5/aHBXQG
	 JU+ZrMez+CkTYliDch24peGKqWClY2m2WTTouemmDi/JVHjKdFjc/yykXloWkYNaXX
	 ut4lGbx81g9rw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 030B23800449;
	Fri, 30 Oct 2026 09:40:06 +0000 (UTC)
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
Subject: Re: [PATCH net v2] ipv6: raw: fix use-after-free in
 rawv6_send_hdrinc()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179335320480.958825.16569701682023560926.git-patchwork-notify@kernel.org>
Date: Fri, 30 Oct 2026 09:40:04 +0000
References: <20261026044808.613-1-n0ps1edzz@gmail.com>
In-Reply-To: <20261026044808.613-1-n0ps1edzz@gmail.com>
To: Zhou Qiuyue <n0ps1edzz@gmail.com>
Cc: netdev@vger.kernel.org, dsahern@kernel.org, idosch@nvidia.com,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, hangbin.liu@linux.dev, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Dave Miller <davem@davem-thinkpadp1gen8.ibmlond.csb>:

On Mon, 26 Oct 2026 12:48:08 +0800 you wrote:
> rawv6_send_hdrinc() caches the route before handing the skb to
> l3mdev_ip6_out(). The VRF output path may replace skb->dst and release
> the original route, leaving the cached pointer stale.
> 
> The function later dereferences that pointer for statistics accounting
> and as the output device passed to NF_HOOK(). Its RCU read-side critical
> section starts after l3mdev_ip6_out(), so it cannot prevent the old route
> from being reclaimed in between.
> 
> [...]

Here is the summary with links:
  - [net,v2] ipv6: raw: fix use-after-free in rawv6_send_hdrinc()
    https://git.kernel.org/netdev/net/c/66dfb2cacda7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


