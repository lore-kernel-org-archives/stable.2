Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794320407;
	b=4WSyb7nqZskvAVjm80cSjt7Al0uAG42UrXABdP2vOO67czXJMpjy82iL3tvTehGFE5nc
	 JBL/bcuTp/BYVaTI/rqU7VSjy7FTfdN8J2pE2hjHcZYng/SXRRrTNLqBfNivFtJBU7s5O
	 ltJGYnv9Xr9VXANCHxFKHSXg0A0SEDG0eU3Kt9xguzHAohRJBJlviRibHZbKe5PxTz328
	 D/9uN7BxELZxS1mANgODS4ikb9D00w6lmYn/mJAMmLw14QfmF4izYuHnrwUd8oFNdK+/j
	 PsOH1mMPPYOntsqQPIGsidqOR4yF8+kRUpmDm1Heu1VPUoC1MUkg4+sjNkR0XQOqE6Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794320407;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=9GjOW8HzxHhNlBVytkPohM1w2TsUdmk1Xb8jc6vaQjg=;
	b=Cy3Wg1F9kqyn82BzpPBomnEjI0cu3Ortku+SegP+ENX61hvBs1NPHi+/xPetaPHxc20f
	 pzaKNO5OjJB2FFX3tFbc5C4aZPogEez/lk+MFYHuxEavOx9uamxKGrs3OoBWJas7lCfjH
	 ZSM2ZWSUDdOLXPJAjpdbkpeikW0kZNCw5fV/ULE1k70L5HoW3hZt89dk8NwBVEXwDF2Uo
	 h4NPXuFw2RoJ3xo0WcSBMeMlw7hf7AbaGYUqmRGK5H+BqtpNoEV9fUIS9yXemUshHFNwQ
	 j29aFvHBgwBWwLoolV11IEDefhY7uXARR9mLWwOqcdBpLRWqJu9Tgq4hLOdQC/JOgKA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kJrZfuC+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA257606A321;
	Tue, 10 Nov 2026 14:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kJrZfuC+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 689801F0089F;
	Tue, 10 Nov 2026 14:20:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794320406;
	bh=9GjOW8HzxHhNlBVytkPohM1w2TsUdmk1Xb8jc6vaQjg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=kJrZfuC+oX66C9FVtRYbr6pIlMgaHmbFL6BJ3wmlSYFM5EXhoMKHWjGXPyyAFROAG
	 +bH7ltyw3B8S/IFWyJxtX2McbYcRSoQr3+JbUmLP14Dvf4qkw9hdzTDJJsV73xZ1Pt
	 Kdlht2Ij8sB1g4dVuIy7ELgyuOWzMEsa6Ay335gXQ+sEfNkwouk88PhUaoa/b91Dg0
	 QIoE0BF1woqBu+G9cb/E/BfHXOYdYcQvdyv5B56EOir1KVQJDLqd2fqn6gRJn1O+x+
	 bXHbemgd0b2cFx+i1VKWxO7qlumdZhGBzfFwAj5dwFoXSGCX8geNVq89SUd6Q4AevG
	 2PEKFynVLYTqA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 5DFE439D0C97;
	Tue, 10 Nov 2026 14:20:06 +0000 (UTC)
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
Subject: Re: [PATCH net] net: dsa: microchip: initialize the IRQ access mutex
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179432040518.3989458.1694702089176046934.git-patchwork-notify@kernel.org>
Date: Tue, 10 Nov 2026 14:20:05 +0000
References: <20261104-ksz-irq-mutex-init-v1-1-e3bb7d9dbd80@vaisala.com>
In-Reply-To: <20261104-ksz-irq-mutex-init-v1-1-e3bb7d9dbd80@vaisala.com>
To: Tapio Reijonen <tapio.reijonen@vaisala.com>
Cc: woojung.huh@microchip.com, UNGLinuxDriver@microchip.com, andrew@lunn.ch,
 olteanv@gmail.com, davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, arun.ramadoss@microchip.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Tristram.Ha@microchip.com,
 stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Wed, 04 Nov 2026 07:58:35 +0000 you wrote:
> ksz_switch_register() initializes dev_mutex, regmap_mutex, alu_mutex and
> vlan_mutex but not lock_irq, which the IRQ chip takes in its bus lock
> callbacks on every mask and unmask of a switch interrupt, and the PTP
> code takes the same way. The zeroed mutex happens to work on the
> uncontended fast path, but with CONFIG_DEBUG_MUTEXES the first lock,
> from the IRQ domain mapping during probe, warns:
> 
> [...]

Here is the summary with links:
  - [net] net: dsa: microchip: initialize the IRQ access mutex
    https://git.kernel.org/netdev/net/c/ba1dc196502f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


