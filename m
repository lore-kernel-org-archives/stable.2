Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794358207;
	b=v67XvonSUIOHNRAUCrZmhi5qD0zx8MXN1R13CNZCh9nUxQiN2xEeECUSrZDxK7rVBC9w
	 1gBuhZFnQclZSjY08v/KoXAS3pUCwDTpsptBdhyRstRzeyKqtz2v+j43X4ZLcOc3NnOzu
	 jiyW9HSdOt7bahHdqrEmgNq/mjt8qFPXj78XmlaEPgGk4f5QQAhMvoQOU+yXhyNqbA2vY
	 +ZPhq3Lioj4epNM+sRs8ovBXa52d3zTPhpsZlYCmxuPSM/7+ETAn2fe4Nxb8XdkY+nyzM
	 ZyTe+cs1XSNexx4AEGZ59XUg2uy+B2gqinxh9hrNQoisG6aj1gY9i3sdEgt75JLnx3g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794358207;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=d5faOEgw9/xCBeRgP4qFBQ9+iauNTkgah4zQf/hKjwc=;
	b=pVaytooKu44mWGMCQK307xlt/oPvFOto674+3Olzs2eEqNO7a8W2tXAvs2DIhc/G3Pp5
	 hdCL5LjbVUI87Bora75BM3TXZPlRQfLmRW4n00AXVfX5LGdojK85sV9M5t7ODvjwgnsTy
	 y3hpeJXffAbEHo3opjXRYXN1xT54NEkYWK9m7QdaBq9JMkWTzyV23d7yDWsn1wjAR3jqz
	 x0BbkkDP0/yp0kERK6MAuMD0wopXzu7TUaDe6UfaTDawshopk2V+uMvu4rO3dOvA7KFMU
	 O+tx4iXK97Z5iIH/v5Olh0SPAAG03io3iA5GbR/7F+N/srBOPeEdGwDelsg7wXnDL1A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=neVdYXZw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5F20606A31C;
	Wed, 11 Nov 2026 00:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=neVdYXZw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B5691F0089F;
	Wed, 11 Nov 2026 00:50:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794358206;
	bh=d5faOEgw9/xCBeRgP4qFBQ9+iauNTkgah4zQf/hKjwc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=neVdYXZwsoWzXbS0Ns29tqjDabZmucPjU3doSpLTzSh5AnhvIqT3+tdKRb8a2soVA
	 AGOuquDi8QwqSg3q2RLbUn5CGHLx4Av8R2iCg9iAN1VW2f4worR6QUw0kLgJvRW/XU
	 9UMqbiTe8wN4YJP0qm/HGKmgSESg01HRfSsbeu9242FFnec1+hTJvdcF9941GqldwN
	 dFtFV9AjY0F7+j5cML5EupPlJPwA+GpXxwe083+SjOOVSQdmVwoGmGkS6ufj6SfOtv
	 WrmjRVw/EV6ltRQTuJM3MfvbWCMlJ2euECeTan4V1ybmNjoWxTPovOdmqMaciqSel/
	 fRBfMQiGmEBIA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 5E08639E8A55;
	Wed, 11 Nov 2026 00:50:06 +0000 (UTC)
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
Subject: Re: [PATCH net] cipso: stop modifying live ip_options_rcu
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179435820518.142717.5535232865040780378.git-patchwork-notify@kernel.org>
Date: Wed, 11 Nov 2026 00:50:05 +0000
References: <20261106-cipso-rcuopts-v1-1-31ae931d7a0f@google.com>
In-Reply-To: <20261106-cipso-rcuopts-v1-1-31ae931d7a0f@google.com>
To: Jann Horn <jannh@google.com>
Cc: paul@paul-moore.com, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, jmorris@namei.org, serge@hallyn.com,
 horms@kernel.org, stephen.smalley.work@gmail.com, omosnacek@gmail.com,
 casey@schaufler-ca.com, netdev@vger.kernel.org,
 linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
 selinux@vger.kernel.org, stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 06 Nov 2026 22:40:31 +0100 you wrote:
> cipso_v4_delopt() operates on the ip_options_rcu of a socket or a request
> socket, and tries to remove CIPSO options from the middle by moving all
> subsequent options.
> That's not allowed - ip_options_rcu can be read locklessly and must always
> be consistent. For example, ip_options_undo() reads trusted offsets and
> length values from the options buffer.
> Fix it by doing the modification in a copy.
> 
> [...]

Here is the summary with links:
  - [net] cipso: stop modifying live ip_options_rcu
    https://git.kernel.org/netdev/net/c/1f2c5183fc09

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


