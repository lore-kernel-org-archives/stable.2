Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794874207;
	b=2FCRjdPyn2zd3yPPan+oUvRQzh4xG3KkmiWifWQJTdKHeH7ITve55VuFJfZ9EXxsJpzD
	 X0YlPB+wau8XiM1T3eUxEP98WE3wrwJkQKS7l0QpPJvl2SN9tiG8gc3j54tnj3jC3Ae/f
	 dMk878/G2v4Go3nqnuBBwIYiw9beMpy8jSWgMvHIDO2rmDCWcaE49iF7OdRIOsAca6aF5
	 v6Mm1qI3JHFvzUhqBUCmwZQM4wJlYsmMmHfTVqcAzap1biqtKf6zwsv1iwW1NFiM4my22
	 eyotejY+dbh/jD2gw5Lvqcw0Wj4lOv34UZmgpXRoVYhBFCoTn91gUnbcqn2UPnk7H9A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794874207;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=JAbzMK+eO7ufYjj/PpkxvxIL4v+GclD+c/34sZfG5bU=;
	b=GecIynjX5fcW3U5t1EVmz8liFMrd8rEHA6QiYZ9Dw7UO2+BSx/c8h4eXFT75lf8QE9dw
	 pl4m1+OFs3/Fth0AMZbrXC9ESb/Ava4hs8GGZXInENRCckwAMBYJl4C3oUC0keEk26/c9
	 2GDGqsYy6+PA2iInQTIHbxl64Nhz6SDT6fvBo+XvY0r6ly6WTC9mI0tVNnX0btRZ24ZXZ
	 KcHmFi8KOy2stvFQ6ddE9+JWMxqSFtk2HZ2FH2Z93ZbW+ot330GyWLDfUNC6HRoQd5UiP
	 g/WdZlTKlOZmunN/sGtytMu/6m55ygzd6bDliFCF54Ountik5qTHIb9x4mMj9eoqKrQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Og5zuoAm;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72C0E606A32A;
	Tue, 17 Nov 2026 00:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Og5zuoAm
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 464421F000C4;
	Tue, 17 Nov 2026 00:10:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794874207;
	bh=JAbzMK+eO7ufYjj/PpkxvxIL4v+GclD+c/34sZfG5bU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Og5zuoAmgHtz5zcMfOBvqi+CWnqpRcie/3PbZNm5uYKD/106AwU6psi2tYrF0dJef
	 ln8r9Y3hkOpvhWKo4Rjlv0wsLCiwEm1ITcoLUyBpZ16fGzZG2mJ0ODR7KHjgQb6GbE
	 +U1PxInPpv9TMqMMw59fDj/KfgInvCi1VpL4xESQVAHUPMqp+f1oz/JaA48oRwCB3G
	 6g7uwDA2Yzl2UlK2xGOEAN3hodqVhc2pgMdG61i9AJzZN1gUO25wMtUb3YT1d4sTXa
	 vf/LfD9Jbqmd+/gOomvfbSaoIR6cx4075HdEhB8hKxOw4jFtcxPGtqf/ivrAMOLCyu
	 dFRSAaYZf9pww==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3A469391B06A;
	Tue, 17 Nov 2026 00:10:07 +0000 (UTC)
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
Subject: Re: [PATCH net v6 0/2] gve: fix RX page refcount overflow with the
 pagecnt bias
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179487420603.254275.3233065832052946037.git-patchwork-notify@kernel.org>
Date: Tue, 17 Nov 2026 00:10:06 +0000
References: <20261112091451.22969-1-amaan.cheval@gmail.com>
In-Reply-To: <20261112091451.22969-1-amaan.cheval@gmail.com>
To: Amaan Cheval <amaan.cheval@gmail.com>
Cc: netdev@vger.kernel.org, joshwash@google.com, hramamurthy@google.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, bcf@google.com, jordanrhee@google.com,
 przemyslaw.kitszel@intel.com, maciej.fijalkowski@intel.com,
 pkaligineedi@google.com, maolson@google.com, csully@google.com,
 willemb@google.com, yangchun@google.com, npl@google.com,
 awogbemila@google.com, shailend@google.com, nktgrg@google.com,
 maxyuan@google.com, bpf@vger.kernel.org, john.fastabend@gmail.com,
 hawk@kernel.org, sdf@fomichev.me, daniel@iogearbox.net, ast@kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 12 Nov 2026 14:44:49 +0530 you wrote:
> gve's GQI and DQO-QPL RX paths bias every RX page's refcount to INT_MAX,
> so a single get_page() from the stack, e.g. splice() of received data,
> overflows it: splice/tee fail with EIO/EFAULT and GQI can reset the
> NIC. Patch 2 lowers the bias to USHRT_MAX, as other drivers do.
> 
> With the smaller bias the driver gives up its last reference on a page
> once every USHRT_MAX handoffs instead of once every INT_MAX, which is
> only safe while every consumer holds its reference until the buffer is
> recycled. That is not the case for an XDP_REDIRECT from DQO-QPL to an
> AF_XDP socket in copy mode, a path the driver never meant to support:
> commit d8a8ca14c937 dropped the queue_format check that used to refuse
> it. Patch 1 refuses XDP on any queue format the driver advertises no
> XDP features for, today DQO-QPL and GQI-RDA, so patch 2 depends on it.
> On GQI-RDA it also stops XDP_TX from writing into a TX FIFO that raw
> addressing never allocates. Trees before 6.17 still have the old check,
> so there patch 2 stands alone.
> 
> [...]

Here is the summary with links:
  - [net,v6,1/2] gve: refuse XDP on queue formats without XDP support
    https://git.kernel.org/netdev/net/c/92c569c28b63
  - [net,v6,2/2] gve: fix RX page refcount overflow from INT_MAX pagecnt_bias
    https://git.kernel.org/netdev/net/c/3946899dbeac

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


