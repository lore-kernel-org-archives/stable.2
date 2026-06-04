Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 409F43976AD;
	Thu,  4 Jun 2026 09:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780566607; cv=none; b=MtMJksrts0S7eUHVd/5aNQqSLLF3PIbfL2km3i19fLZ1AswUAEh5yI9DWWKqbR8IjvoNkowUzFwV8JYdLqFw+y9ab6KAJcGfd4rbJeA0ywPfQQxfVuxXMDboPvRSHhDSQmhUEEe2Ah4QOFfHC2MDoy2fZ99PubrWkz1cO7C/4sE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780566607; c=relaxed/simple;
	bh=VjTz8+WeiUzWcBdR1Rs4zqbDM7DUGzeYknM8QM87u7g=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=mk9D2p2Ty/LiBKDR4+g7iqPNEdzYB9t3pR9ZmlUuOd74EYX4L8rOrqgloIfrMZvDDwDeRseJVSjCs6iYmXWCtJy1Fzk34ec1GmlNe69o0H/l+bucNtf48esXcTnjVK/f4kab0X+/wV/ONT/nFCTlM1bfQoNjN26cqRjLV9r9Y+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d6iP0khd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d6iP0khd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3BB01F00893;
	Thu,  4 Jun 2026 09:50:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780566605;
	bh=O28jlKo2Rqtk1QypQ4hf3RUWWZ+g2xqi0sDgvdKBjSU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=d6iP0khdSRO9oJ9jhpsJFigjkK4PxYrrDYsCg1mL8By1f9fJYGeHurMK2aXCWMPFX
	 gp4273JFIdC3YvcQikPPJxtTzLOBXy9nbo7tev87uFvt5qR3iVBXmz5XYRD+gflaK6
	 fG2zGXApPazkVr/ThpvCnJj8Qxf/oLbv8z01G59MlmuQL2KtpUITO9udQxpIsmJvW9
	 DYY0Vhh7LnXkGK7ixtlpGs2Ay7T8iN+pRe2xPJwE19DZFdSMkaN0eNRZYESS/DD1En
	 B41wVeHqSIUEnkiu7tkXluKxeQXTJeoMNyR0MAK5XUakjh0rCPXStR+BcYFKea8j7g
	 Q6ArEyLWhNd/Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 1987F393090A;
	Thu,  4 Jun 2026 09:50:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: bonding: fix NULL pointer dereference in
 bond_do_ioctl()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178056660688.2344782.1689826187240652656.git-patchwork-notify@kernel.org>
Date: Thu, 04 Jun 2026 09:50:06 +0000
References: <20260601085649.4029067-1-zhaojinming@uniontech.com>
In-Reply-To: <20260601085649.4029067-1-zhaojinming@uniontech.com>
To: ZhaoJinming <zhaojinming@uniontech.com>
Cc: jv@jvosburgh.net, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, jarod@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon,  1 Jun 2026 16:56:49 +0800 you wrote:
> In bond_do_ioctl(), slave_dev is obtained via __dev_get_by_name() which
> can return NULL if the requested interface name does not exist. However,
> the subsequent slave_dbg() call is placed before the NULL check:
> 
>     slave_dev = __dev_get_by_name(net, ifr->ifr_slave);
>     slave_dbg(bond_dev, slave_dev, "slave_dev=%p:\n", slave_dev); //here
>     if (!slave_dev)
>         return -ENODEV;
> 
> [...]

Here is the summary with links:
  - net: bonding: fix NULL pointer dereference in bond_do_ioctl()
    https://git.kernel.org/netdev/net/c/a764b0e8317a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


