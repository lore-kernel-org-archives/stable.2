Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794918607;
	b=GmlEIk4MZypFhjB0q/ZFpYxDAOhfG8o9G2u425/Vm6y6+k+9mpacwh7/yyBuwQ841clv
	 hIxJF5BiShnzsEK5Qwsyl1BraVbKWUSL4/tSFikay2Z/ZqA3WRHBhRDg47U5PxSRc25mh
	 VURlTQUe0vFfwmKT3N10aS3TQvfyCEDpObbvbQHeXcTPY+8rWjFQNBhHR4xekZ0h9fW1+
	 wXZRi2WWNP1zSrkDhY/Ec0mAZ0onAzJbYlJU4i+VkF8zlb+AiNOkODy/eiqxmj8ndvTBE
	 1VHRKIKdcw1WP3x8JffD2BeMP1snJtXkWhIebccB5WPCjr7D5PPX5zGKR82qoFcZGQg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794918607;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=kGK65NhYquWSDWGthO9j5qhwvE0SAGa/SUrbJPZLC0k=;
	b=BZcoPKn++k6pxVAEei2CX57nY3rJFN4H6bahyOa5zs+ZMRhZnndEP9t317icuI3gOK8S
	 R7aEQghgTWxzkxeLz2uTVZaIY4Dtnmn6dT55QaaT9MehYRPgJI8LrGrSvI4IRDS8C99f1
	 ddhkuaWisOH1gFfyjbDzCk8n3wPqcAMLqzkAEwK0gP5HIclWEu5Jbn7sx5j5wRBb7jF+l
	 nWHFtiZiaDNWDBLS0oKnjfMaFSxYZq05q7Kkm6vPXaN+tjTqnWBlQ1k354MN+CkmXMiSx
	 XbsmOxjYnVvhW7pc51ajGD3F7AwhzaOmJfb9xDHo1565cv3nRmhP0bEg/+fsOebQaEQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=maRDYnqr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3FBA606A31C;
	Tue, 17 Nov 2026 12:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=maRDYnqr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48A8B1F000CA;
	Tue, 17 Nov 2026 12:30:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794918607;
	bh=kGK65NhYquWSDWGthO9j5qhwvE0SAGa/SUrbJPZLC0k=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=maRDYnqrrfLCTxka8J5kvWD6TZEDnBF8H1yWccCDxypMj3eUMAcYD3CC4wD9RD/7z
	 JYeLpUPPvr72eJCvFV5ahnguoUoaROsvj2LhAbKHpmBxn4odccu0MUvzFjItx2GTEy
	 ULhqv+l8AH5rAFRK2MW2/daNJ1TgDORX51PsqqXnKI8wIjgc+VvlBqoOqfwAtQFWhq
	 rgt13r6GrV8btMdKoT3zSTgDjK7y1n2NBO6RdWVbSApV72ibEd5ZIU9EUJEev6iBw6
	 9OBmSS/f0uiJriq7XWF/U3LMocAIZAvP7WQp6NndiPwnVU/8avKYsjsdT8GlgGUtgl
	 eg5OLPWsnodww==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3A3833926667;
	Tue, 17 Nov 2026 12:30:07 +0000 (UTC)
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
Subject: Re: [PATCH net] net: wwan: mhi_wwan_mbim: fix dangling links on
 registration failure
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179491860579.550910.13113562419613180415.git-patchwork-notify@kernel.org>
Date: Tue, 17 Nov 2026 12:30:05 +0000
References: <20261111113213.280066-1-yanxia@cmss.chinamobile.com>
In-Reply-To: <20261111113213.280066-1-yanxia@cmss.chinamobile.com>
To: Xia Yan <yanxia@cmss.chinamobile.com>
Cc: netdev@vger.kernel.org, loic.poulain@oss.qualcomm.com,
 ryazanov.s.a@gmail.com, johannes@sipsolutions.net, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, yana06070@163.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Wed, 11 Nov 2026 19:32:13 +0800 you wrote:
> mhi_mbim_newlink() adds the link to mbim->link_list before calling
> register_netdevice(). If registration fails, the caller frees the
> netdev without removing the link, leaving a dangling list entry that
> RCU readers such as mhi_mbim_rx() can access after free.
> 
> Register the netdev before adding the link to the list so that failed
> registrations do not publish a link.
> 
> [...]

Here is the summary with links:
  - [net] net: wwan: mhi_wwan_mbim: fix dangling links on registration failure
    https://git.kernel.org/netdev/net-next/c/500da33276f5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


